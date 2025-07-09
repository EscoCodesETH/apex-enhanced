import { ApexFramework, createApexFramework, ApexConfig } from './index';

describe('ApexFramework', () => {
  const defaultConfig: ApexConfig = {
    name: 'Test Project',
    version: '1.0.0',
    environment: 'test',
  };

  let framework: ApexFramework;

  beforeEach(() => {
    framework = new ApexFramework(defaultConfig);
    // Mock console.log to prevent output during tests
    jest.spyOn(console, 'log').mockImplementation(() => {});
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe('constructor', () => {
    it('should create an instance with the provided config', () => {
      expect(framework).toBeInstanceOf(ApexFramework);
      expect(framework.getConfig()).toEqual(defaultConfig);
    });
  });

  describe('initialize', () => {
    it('should log initialization messages', () => {
      framework.initialize();

      expect(console.log).toHaveBeenCalledWith(
        '🚀 APEX Enhanced Framework v1.0.0 initialized'
      );
      expect(console.log).toHaveBeenCalledWith('📋 Project: Test Project');
      expect(console.log).toHaveBeenCalledWith('🌍 Environment: test');
    });
  });

  describe('getConfig', () => {
    it('should return a copy of the configuration', () => {
      const config = framework.getConfig();
      
      expect(config).toEqual(defaultConfig);
      expect(config).not.toBe(framework.getConfig()); // Should be a copy
    });
  });

  describe('updateConfig', () => {
    it('should update the configuration with new values', () => {
      const updates = { name: 'Updated Project', version: '2.0.0' };
      
      framework.updateConfig(updates);
      
      const updatedConfig = framework.getConfig();
      expect(updatedConfig.name).toBe('Updated Project');
      expect(updatedConfig.version).toBe('2.0.0');
      expect(updatedConfig.environment).toBe('test'); // Should remain unchanged
    });

    it('should handle partial updates', () => {
      framework.updateConfig({ name: 'Partial Update' });
      
      const updatedConfig = framework.getConfig();
      expect(updatedConfig.name).toBe('Partial Update');
      expect(updatedConfig.version).toBe('1.0.0');
      expect(updatedConfig.environment).toBe('test');
    });
  });
});

describe('createApexFramework', () => {
  it('should create a new ApexFramework instance', () => {
    const config: ApexConfig = {
      name: 'Factory Test',
      version: '1.0.0',
      environment: 'development',
    };

    const framework = createApexFramework(config);
    
    expect(framework).toBeInstanceOf(ApexFramework);
    expect(framework.getConfig()).toEqual(config);
  });

  it('should work with different environments', () => {
    const environments: ApexConfig['environment'][] = ['development', 'production', 'test'];
    
    environments.forEach((env) => {
      const config: ApexConfig = {
        name: 'Env Test',
        version: '1.0.0',
        environment: env,
      };
      
      const framework = createApexFramework(config);
      expect(framework.getConfig().environment).toBe(env);
    });
  });
}); 