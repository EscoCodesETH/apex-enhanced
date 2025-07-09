# 🎓 Your First Feature with APEX Enhanced

Let's build a real feature together to understand the APEX workflow!

## Feature: User Profile Avatar Upload

We'll implement a complete avatar upload system with:
- Image upload
- Validation
- Storage
- Display
- Error handling

## Step 1: Start the Feature

Tell your AI:

```
I want to implement user avatar upload using APEX Enhanced.
Users should be able to upload a profile picture with these requirements:
- Max size: 5MB
- Formats: JPG, PNG, WebP
- Automatic resizing to 200x200
- Default avatar for new users
```

## Step 2: APEX Analysis Phase

The AI will analyze and ask questions:

```
🤖 APEX: Let me analyze this feature...

Questions for clarity:
1. Where should avatars be stored? (local/S3/Cloudinary?)
2. Should we keep original images or just resized?
3. Do we need moderation for inappropriate content?
4. Real-time preview before upload?
```

You respond:
```
1. Use S3 for production, local for development
2. Keep both original and resized
3. No moderation needed for now
4. Yes, show preview before upload
```

## Step 3: APEX Planning

The AI generates an adaptive plan:

```
🤖 APEX: This is a STANDARD complexity feature. Here's my plan:

📋 Feature Plan: User Avatar Upload

Goals:
- Users can upload profile pictures
- Images are validated and resized
- Seamless UX with preview

Success Criteria:
✓ Upload images up to 5MB
✓ Support JPG, PNG, WebP
✓ Auto-resize to 200x200
✓ Show preview before save
✓ Fallback to default avatar

Implementation Tasks:
1. Setup (20 min)
   - Create AvatarUpload component
   - Add S3 configuration

2. Core Logic (45 min)
   - Image validation
   - Preview functionality
   - Upload handling
   - Resize logic

3. Testing (30 min)
   - Unit tests for validation
   - Upload integration tests
   - UI component tests

4. Polish (15 min)
   - Loading states
   - Error messages
   - Accessibility

Shall we start with TDD?
```

## Step 4: Test-Driven Development

APEX writes tests first:

```typescript
🤖 APEX: Starting with tests for image validation...

// avatar-upload.test.ts
describe('Avatar Upload', () => {
  describe('Image Validation', () => {
    it('accepts valid image formats', () => {
      const validFiles = [
        new File([''], 'avatar.jpg', { type: 'image/jpeg' }),
        new File([''], 'avatar.png', { type: 'image/png' }),
        new File([''], 'avatar.webp', { type: 'image/webp' })
      ];
      
      validFiles.forEach(file => {
        expect(validateImageFile(file)).toBe(true);
      });
    });

    it('rejects invalid formats', () => {
      const invalidFile = new File([''], 'doc.pdf', { type: 'application/pdf' });
      expect(validateImageFile(invalidFile)).toBe(false);
    });

    it('enforces 5MB size limit', () => {
      const largeFile = new File(['x'.repeat(6 * 1024 * 1024)], 'large.jpg', {
        type: 'image/jpeg'
      });
      expect(validateImageFile(largeFile)).toBe(false);
    });
  });

  describe('Image Preview', () => {
    it('generates preview URL for valid image', async () => {
      const file = new File(['fake-image-data'], 'avatar.jpg', {
        type: 'image/jpeg'
      });
      const previewUrl = await generatePreview(file);
      expect(previewUrl).toMatch(/^blob:/);
    });
  });
});
```

## Step 5: Implementation

APEX implements to pass tests:

```typescript
🤖 APEX: Now implementing to make tests pass...

// avatar-upload.utils.ts
const ALLOWED_FORMATS = ['image/jpeg', 'image/png', 'image/webp'];
const MAX_SIZE = 5 * 1024 * 1024; // 5MB

export function validateImageFile(file: File): boolean {
  if (!ALLOWED_FORMATS.includes(file.type)) {
    return false;
  }
  
  if (file.size > MAX_SIZE) {
    return false;
  }
  
  return true;
}

export async function generatePreview(file: File): Promise<string> {
  return new Promise((resolve) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve(reader.result as string);
    reader.readAsDataURL(file);
  });
}

// React component implementation...
```

## Step 6: Quality Checks

APEX automatically runs quality checks:

```
🤖 APEX: Running quality analysis...

✅ Test Coverage: 92%
✅ Complexity: Low (cyclomatic: 3)
✅ Accessibility: ARIA labels present
⚠️ Performance: Consider lazy loading for avatar display
✅ Security: File type validation prevents XSS

Applying Sandi Metz review...
- Methods under 5 lines ✓
- Single responsibility ✓
- Clear naming ✓
```

## Step 7: Smart Git Integration

APEX creates meaningful commits:

```bash
🤖 APEX: Creating atomic commits...

git add src/components/AvatarUpload/
git commit -m "feat: add avatar upload validation

- Validate image format (JPG, PNG, WebP)
- Enforce 5MB size limit
- Add comprehensive tests
- 92% test coverage"

git add src/utils/imageResize.ts
git commit -m "feat: implement image resizing

- Auto-resize to 200x200
- Maintain aspect ratio
- Optimize for web display"

git add src/components/AvatarUpload/AvatarUpload.tsx
git commit -m "feat: complete avatar upload component

- Real-time preview
- S3 integration for production
- Local storage for development
- Accessible interface with ARIA labels"
```

## Step 8: PR Creation

APEX generates PR with rich context:

```markdown
## 🖼️ User Avatar Upload Feature

### Summary
Implements complete avatar upload system with validation, resizing, and storage.

### Changes
- ✅ `AvatarUpload` component with preview
- ✅ Image validation (format & size)
- ✅ Automatic resizing to 200x200
- ✅ S3 integration with local fallback
- ✅ Default avatar support

### Technical Details
- **Validation**: Client-side format/size checks
- **Storage**: S3 in production, local in development
- **Performance**: Lazy loading, optimized images
- **Accessibility**: Full keyboard support, ARIA labels

### Testing
- Unit tests: 92% coverage
- Integration tests: Upload flow
- Manual testing: ✅ Chrome ✅ Firefox ✅ Safari

### Screenshots
[Preview functionality]
[Uploaded avatar display]
[Error states]

### Security Considerations
- File type validation prevents malicious uploads
- Size limits prevent DoS
- S3 presigned URLs for secure upload

Closes #123
```

## 🎉 Congratulations!

You've just implemented your first feature with APEX Enhanced! Notice how:

1. **Planning was proportional** to complexity
2. **Tests came first** ensuring quality
3. **AI handled repetitive tasks** while you made decisions
4. **Quality was automatic** not manual
5. **Documentation wrote itself**

## What's Next?

- Try a [Simple Feature](../workflows/simple-features.md)
- Learn about [Complex Features](../workflows/complex-features.md)
- Explore [Team Collaboration](../workflows/team-collaboration.md)

## Pro Tips

💡 **Complexity Scaling**: Tell AI "this is a simple/complex/critical feature" to adjust the process

💡 **Quick Iterations**: For prototypes, say "use APEX lightweight mode"

💡 **Maximum Safety**: For payments/auth, say "use APEX robust mode"

💡 **Learn Patterns**: APEX remembers your preferences and improves over time

---

Ready for more? Check out our [example projects](../../examples/)!