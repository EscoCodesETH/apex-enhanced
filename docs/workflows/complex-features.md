# 🏗️ Complex Features Workflow

Learn how to use APEX Enhanced robust mode for complex features that require careful planning, security considerations, and comprehensive testing.

## What Are Complex Features?

Complex features typically include:
- Payment processing
- Authentication/authorization systems
- Data migrations
- Third-party integrations
- Real-time features (WebSockets)
- Reporting and analytics
- Multi-tenant features
- Performance-critical code

## The Robust Process

```
Planning: 30-45 minutes
Architecture Review: 15-20 minutes
Testing: 45-60 minutes
Implementation: 2-4 hours
Security Review: 20-30 minutes
Total: 4-6 hours
```

## Example: Implementing Stripe Payment Integration

Let's walk through a complete payment system implementation:

### Step 1: Initial Analysis

```
You: "Implement Stripe payment processing with APEX Enhanced"

AI: "I've detected this is a COMPLEX feature requiring robust mode due to:
- Financial transactions
- Security implications  
- Third-party integration
- Compliance requirements

Let me ask comprehensive questions to ensure we build this correctly."
```

### Step 2: Detailed Requirements Gathering

```
AI: "Payment Processing Requirements:

1. **Payment Types**
   a) One-time payments only
   b) Subscriptions
   c) Both

2. **Payment Methods**
   a) Credit/debit cards only
   b) Include ACH/bank transfers
   c) Include digital wallets (Apple Pay, etc.)

3. **Currency Support**
   a) USD only
   b) Multi-currency
   c) With currency conversion

4. **Compliance Requirements**
   a) PCI compliance level needed?
   b) Location-specific regulations (EU/GDPR)?
   c) Sales tax/VAT handling?

5. **User Experience**
   a) Embedded checkout on your site
   b) Redirect to Stripe hosted checkout
   c) Custom payment form

6. **Post-Payment**
   a) Email receipts?
   b) Invoice generation?
   c) Webhook handling for status updates?

7. **Error Handling**
   a) Retry failed payments?
   b) Dunning for subscriptions?
   c) Customer support integration?

8. **Testing Strategy**
   a) Stripe test mode available?
   b) Specific test scenarios needed?"
```

### Step 3: Comprehensive Planning

Based on responses, AI generates detailed plan:

```markdown
# Payment Processing Implementation Plan

## Architecture Overview

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Frontend  │────▶│   API Server │────▶│   Stripe    │
│   (React)   │     │   (Node.js)  │     │     API     │
└─────────────┘     └──────────────┘     └─────────────┘
                            │
                    ┌───────┴────────┐
                    ▼                ▼
              ┌──────────┐    ┌──────────┐
              │ Database │    │  Redis   │
              │  (PostgreSQL) │    │ (Sessions) │
              └──────────┘    └──────────┘
```

## Security Measures

1. **No Credit Card Storage**: Use Stripe tokens only
2. **API Key Security**: Environment variables, never in code
3. **Webhook Verification**: Validate Stripe signatures
4. **Rate Limiting**: Prevent abuse on payment endpoints
5. **Audit Logging**: Track all payment attempts
6. **HTTPS Only**: Enforce TLS for all payment flows

## Implementation Phases

### Phase 1: Foundation (1.5 hours)
- Set up Stripe SDK
- Configure environment variables
- Create payment database schema
- Implement secure key management

### Phase 2: Payment Flow (2 hours)
- Create payment intent endpoint
- Build frontend payment form
- Implement 3D Secure handling
- Add comprehensive error handling

### Phase 3: Webhook Processing (1 hour)
- Set up webhook endpoint
- Implement signature verification
- Handle payment events
- Add idempotency

### Phase 4: Testing & Security (1.5 hours)
- Unit tests for all endpoints
- Integration tests with Stripe test mode
- Security audit
- Load testing

## Database Schema

```sql
-- payments table
CREATE TABLE payments (
  id UUID PRIMARY KEY,
  stripe_payment_intent_id VARCHAR(255) UNIQUE,
  user_id UUID REFERENCES users(id),
  amount INTEGER NOT NULL, -- in cents
  currency VARCHAR(3) NOT NULL,
  status VARCHAR(50) NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- payment_events table for audit trail
CREATE TABLE payment_events (
  id UUID PRIMARY KEY,
  payment_id UUID REFERENCES payments(id),
  event_type VARCHAR(50) NOT NULL,
  stripe_event_id VARCHAR(255) UNIQUE,
  payload JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_payments_user_id ON payments(user_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payment_events_payment_id ON payment_events(payment_id);
```

Shall we proceed with implementation?
```

### Step 4: Test-Driven Implementation

```typescript
// AI starts with comprehensive tests

describe('Payment Processing', () => {
  describe('Security', () => {
    it('rejects requests without authentication', async () => {
      const response = await request(app)
        .post('/api/payments/create-intent')
        .send({ amount: 1000 });
      
      expect(response.status).toBe(401);
    });

    it('validates webhook signatures', async () => {
      const payload = { type: 'payment_intent.succeeded' };
      const invalidSignature = 'invalid_sig';
      
      const response = await request(app)
        .post('/api/webhooks/stripe')
        .set('stripe-signature', invalidSignature)
        .send(payload);
      
      expect(response.status).toBe(400);
    });

    it('prevents duplicate payment processing', async () => {
      const paymentIntentId = 'pi_test123';
      
      // First webhook
      await processWebhook({
        type: 'payment_intent.succeeded',
        data: { object: { id: paymentIntentId } }
      });
      
      // Duplicate webhook
      const result = await processWebhook({
        type: 'payment_intent.succeeded',
        data: { object: { id: paymentIntentId } }
      });
      
      expect(result.status).toBe('already_processed');
    });
  });

  describe('Payment Creation', () => {
    it('creates payment intent with correct amount', async () => {
      const response = await request(app)
        .post('/api/payments/create-intent')
        .set('Authorization', `Bearer ${validToken}`)
        .send({ 
          amount: 5000, // $50.00
          currency: 'usd'
        });
      
      expect(response.status).toBe(200);
      expect(response.body.clientSecret).toBeDefined();
      expect(response.body.amount).toBe(5000);
    });

    it('handles Stripe API errors gracefully', async () => {
      // Mock Stripe error
      stripe.paymentIntents.create.mockRejectedValueOnce(
        new Error('Card declined')
      );
      
      const response = await request(app)
        .post('/api/payments/create-intent')
        .set('Authorization', `Bearer ${validToken}`)
        .send({ amount: 1000 });
      
      expect(response.status).toBe(400);
      expect(response.body.error).toBe('Payment failed');
      expect(response.body.details).toBeUndefined(); // Don't leak internals
    });
  });
});
```

### Step 5: Secure Implementation

```typescript
// AI implements with security focus

// payment.service.ts
import Stripe from 'stripe';
import { createHmac, timingSafeEqual } from 'crypto';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
});

export class PaymentService {
  async createPaymentIntent(
    userId: string,
    amount: number,
    currency: string = 'usd'
  ): Promise<PaymentIntent> {
    // Validate inputs
    if (amount < 50) { // $0.50 minimum
      throw new ValidationError('Amount too small');
    }
    
    if (!ALLOWED_CURRENCIES.includes(currency)) {
      throw new ValidationError('Invalid currency');
    }
    
    try {
      // Create payment intent
      const intent = await stripe.paymentIntents.create({
        amount,
        currency,
        metadata: {
          userId,
          timestamp: Date.now().toString(),
        },
        // Security: Require 3D Secure for European cards
        payment_method_options: {
          card: {
            request_three_d_secure: 'automatic',
          },
        },
      });
      
      // Store in database
      await this.savePaymentRecord({
        userId,
        stripePaymentIntentId: intent.id,
        amount,
        currency,
        status: 'pending',
      });
      
      // Return client secret (not the full intent)
      return {
        clientSecret: intent.client_secret!,
        amount,
        currency,
      };
      
    } catch (error) {
      // Log error securely (no sensitive data)
      logger.error('Payment creation failed', {
        userId,
        error: error.message,
      });
      
      // Generic error to client
      throw new PaymentError('Payment initialization failed');
    }
  }
  
  async verifyWebhookSignature(
    payload: string,
    signature: string
  ): Promise<boolean> {
    const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET!;
    
    try {
      // Stripe's signature verification
      stripe.webhooks.constructEvent(payload, signature, webhookSecret);
      return true;
    } catch (err) {
      logger.warn('Invalid webhook signature');
      return false;
    }
  }
  
  async processWebhook(event: Stripe.Event): Promise<void> {
    // Idempotency check
    const existing = await this.findEventById(event.id);
    if (existing) {
      logger.info('Duplicate webhook event', { eventId: event.id });
      return;
    }
    
    // Store event
    await this.saveEvent(event);
    
    // Process based on type
    switch (event.type) {
      case 'payment_intent.succeeded':
        await this.handlePaymentSuccess(event.data.object);
        break;
        
      case 'payment_intent.payment_failed':
        await this.handlePaymentFailure(event.data.object);
        break;
        
      default:
        logger.info('Unhandled webhook event type', { type: event.type });
    }
  }
}

// Webhook endpoint with security
export async function stripeWebhookHandler(
  req: Request,
  res: Response
): Promise<void> {
  const signature = req.headers['stripe-signature'] as string;
  
  if (!signature) {
    res.status(400).json({ error: 'Missing signature' });
    return;
  }
  
  // Get raw body for signature verification
  const payload = req.rawBody;
  
  try {
    const event = stripe.webhooks.constructEvent(
      payload,
      signature,
      process.env.STRIPE_WEBHOOK_SECRET!
    );
    
    await paymentService.processWebhook(event);
    
    res.status(200).json({ received: true });
  } catch (err) {
    logger.error('Webhook processing failed', { error: err.message });
    res.status(400).json({ error: 'Webhook processing failed' });
  }
}
```

### Step 6: Frontend Implementation (Secure)

```typescript
// AI implements secure frontend

// PaymentForm.tsx
import { loadStripe } from '@stripe/stripe-js';
import {
  Elements,
  PaymentElement,
  useStripe,
  useElements,
} from '@stripe/react-stripe-js';

// Load Stripe outside component to avoid recreating
const stripePromise = loadStripe(
  process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY!
);

function PaymentForm({ amount }: { amount: number }) {
  const stripe = useStripe();
  const elements = useElements();
  const [error, setError] = useState<string | null>(null);
  const [processing, setProcessing] = useState(false);

  const handleSubmit = async (event: FormEvent) => {
    event.preventDefault();

    if (!stripe || !elements) return;

    setProcessing(true);
    setError(null);

    try {
      // Create payment intent
      const { clientSecret } = await createPaymentIntent(amount);

      // Confirm payment
      const result = await stripe.confirmPayment({
        elements,
        clientSecret,
        confirmParams: {
          return_url: `${window.location.origin}/payment/success`,
        },
      });

      if (result.error) {
        // Show error to customer
        setError(result.error.message ?? 'Payment failed');
      }
    } catch (err) {
      setError('Payment initialization failed');
      logger.error('Payment error', err);
    } finally {
      setProcessing(false);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <PaymentElement />
      {error && (
        <Alert type="error" className="mt-4">
          {error}
        </Alert>
      )}
      <Button
        type="submit"
        disabled={!stripe || processing}
        className="mt-4"
      >
        {processing ? (
          <Spinner />
        ) : (
          `Pay $${(amount / 100).toFixed(2)}`
        )}
      </Button>
    </form>
  );
}

// Secure API call with CSRF protection
async function createPaymentIntent(amount: number) {
  const response = await fetch('/api/payments/create-intent', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': getCsrfToken(), // CSRF protection
    },
    credentials: 'same-origin',
    body: JSON.stringify({ amount }),
  });

  if (!response.ok) {
    throw new Error('Failed to create payment intent');
  }

  return response.json();
}
```

### Step 7: Security Audit

```
AI: Running security audit...

✅ API keys in environment variables
✅ No credit card data stored
✅ Webhook signatures verified
✅ HTTPS enforced
✅ Rate limiting implemented
✅ CSRF protection enabled
✅ Input validation comprehensive
✅ Error messages don't leak internals
✅ Audit logging in place
✅ Idempotency for webhooks

⚠️ Recommendations:
1. Add payment retry logic for transient failures
2. Implement webhook replay protection (15-minute window)
3. Add monitoring alerts for failed payments
4. Consider implementing SCA exemptions for low-risk transactions
```

### Step 8: Load Testing

```typescript
// AI includes load test
describe('Payment Load Testing', () => {
  it('handles concurrent payment creation', async () => {
    const promises = Array(50).fill(null).map((_, i) => 
      createPaymentIntent({
        userId: `user-${i}`,
        amount: 1000,
      })
    );

    const results = await Promise.allSettled(promises);
    const successful = results.filter(r => r.status === 'fulfilled');
    
    expect(successful.length).toBeGreaterThan(45); // 90% success rate
  });
});
```

### Step 9: Documentation

```markdown
# Payment Processing Documentation

## Setup

1. Add Stripe keys to environment:
   ```
   STRIPE_SECRET_KEY=sk_test_...
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   STRIPE_WEBHOOK_SECRET=whsec_...
   ```

2. Configure webhook endpoint in Stripe Dashboard:
   - URL: https://yourapp.com/api/webhooks/stripe
   - Events: payment_intent.succeeded, payment_intent.payment_failed

## Testing

Use Stripe test cards:
- Success: 4242 4242 4242 4242
- Requires auth: 4000 0025 0000 3155
- Decline: 4000 0000 0000 0002

## Monitoring

Monitor these metrics:
- Payment success rate
- Average processing time
- Webhook delivery rate
- Error rates by type

## Security Checklist

- [ ] API keys rotated quarterly
- [ ] Webhook endpoint IP allowlisting
- [ ] PCI compliance scan completed
- [ ] Security headers configured
- [ ] Rate limiting tested
```

### Step 10: Final Commit

```bash
git add .
git commit -m "feat: implement secure Stripe payment processing

- Add PCI-compliant payment flow with Stripe
- Implement comprehensive webhook handling
- Add idempotency for payment processing
- Include 3D Secure support for SCA compliance
- Add rate limiting and security measures
- 94% test coverage including security tests

Security:
- No credit card data stored
- Webhook signature verification
- CSRF protection enabled
- Comprehensive audit logging

Breaking changes: None
Deploy notes: Requires Stripe webhook configuration

Closes #456"
```

## Complex Feature Patterns

### Pattern 1: Multi-Step Workflows

```typescript
// State machine for complex flows
const checkoutMachine = createMachine({
  initial: 'cart',
  states: {
    cart: {
      on: { CHECKOUT: 'shipping' }
    },
    shipping: {
      on: { 
        NEXT: 'payment',
        BACK: 'cart'
      }
    },
    payment: {
      on: {
        SUCCESS: 'confirmation',
        FAILURE: 'payment',
        BACK: 'shipping'
      }
    },
    confirmation: {
      type: 'final'
    }
  }
});
```

### Pattern 2: Distributed Transactions

```typescript
// Saga pattern for distributed operations
async function processOrderSaga(order: Order) {
  const saga = new Saga();
  
  try {
    // Step 1: Reserve inventory
    const reservation = await saga.run(
      () => inventoryService.reserve(order.items),
      () => inventoryService.release(order.items)
    );
    
    // Step 2: Process payment
    const payment = await saga.run(
      () => paymentService.charge(order.total),
      () => paymentService.refund(payment.id)
    );
    
    // Step 3: Create shipment
    const shipment = await saga.run(
      () => shippingService.create(order),
      () => shippingService.cancel(shipment.id)
    );
    
    await saga.commit();
    
  } catch (error) {
    await saga.rollback();
    throw error;
  }
}
```

### Pattern 3: Event Sourcing

```typescript
// Event sourcing for audit trail
class PaymentAggregate {
  private events: PaymentEvent[] = [];
  
  createPayment(amount: number) {
    this.applyEvent({
      type: 'PaymentCreated',
      data: { amount, timestamp: Date.now() }
    });
  }
  
  authorizePayment() {
    this.applyEvent({
      type: 'PaymentAuthorized',
      data: { timestamp: Date.now() }
    });
  }
  
  private applyEvent(event: PaymentEvent) {
    this.events.push(event);
    // Update state based on event
  }
}
```

## Security Checklist for Complex Features

### Authentication & Authorization
- [ ] Verify user permissions for each action
- [ ] Implement proper session management
- [ ] Use secure token generation
- [ ] Add rate limiting per user

### Data Validation
- [ ] Validate all inputs server-side
- [ ] Sanitize data before storage
- [ ] Use parameterized queries
- [ ] Implement size limits

### Encryption
- [ ] Encrypt sensitive data at rest
- [ ] Use TLS for data in transit
- [ ] Secure key management
- [ ] Regular key rotation

### Monitoring
- [ ] Log security events
- [ ] Set up alerts for anomalies
- [ ] Regular security audits
- [ ] Penetration testing

## When to Use Robust Mode

### Always Use For:
- Financial transactions
- User authentication
- Personal data handling
- Third-party integrations
- Database migrations
- API design

### Consider For:
- Performance optimizations
- Complex algorithms
- Multi-user features
- Real-time features
- Reporting systems

## Common Pitfalls

1. **Underestimating Complexity**
   - Start with robust mode when in doubt
   - Easy to scale down, hard to scale up

2. **Skipping Security Review**
   - Always include security phase
   - Get peer review for critical features

3. **Insufficient Testing**
   - Test edge cases thoroughly
   - Include integration tests
   - Load test before deployment

4. **Poor Error Handling**
   - Plan for failure modes
   - Implement proper rollback
   - User-friendly error messages

## Next Steps

- Review [Security Best Practices](../guides/security.md)
- Learn about [Performance Optimization](../guides/performance.md)
- Understand [Testing Strategies](../guides/testing.md)

---

Remember: Complex features require patience and thoroughness. The extra time spent in planning and security review pays off in reliability and maintainability!