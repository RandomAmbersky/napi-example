# `napi-example`

![https://github.com/napi-rs/package-template/actions](https://github.com/napi-rs/package-template/workflows/CI/badge.svg)

> Template project for writing node packages with napi-rs.

# Usage

1. Click **Use this template**.
2. **Clone** your project.
3. Run `yarn install` to install dependencies.
4. Run `yarn napi rename -n [@your-scope/package-name] -b [binary-name]` command under the project folder to rename your package.

## Install this test package

```bash
yarn add napi-example
```

## Ability

### Build

After `yarn build/npm run build` command, you can see `napi-example.[darwin|win32|linux].node` file in project root. This is the native addon built from [lib.rs](./src/lib.rs).

### Test

With [ava](https://github.com/avajs/ava), run `yarn test/npm run test` to testing native addon. You can also switch to another testing framework if you want.

### CI

With GitHub Actions, each commit and pull request will be built and tested automatically in [`node@20`, `@node22`] x [`macOS`, `Linux`, `Windows`] matrix. You will never be afraid of the native addon broken in these platforms.

### Release

Release native package is very difficult in old days. Native packages may ask developers who use it to install `build toolchain` like `gcc/llvm`, `node-gyp` or something more.

With `GitHub actions`, we can easily prebuild a `binary` for major platforms. And with `N-API`, we should never be afraid of **ABI Compatible**.

The other problem is how to deliver prebuild `binary` to users. Downloading it in `postinstall` script is a common way that most packages do it right now. The problem with this solution is it introduced many other packages to download binary that has not been used by `runtime codes`. The other problem is some users may not easily download the binary from `GitHub/CDN` if they are behind a private network (But in most cases, they have a private NPM mirror).

In this package, we choose a better way to solve this problem. We release different `npm packages` for different platforms. And add it to `optionalDependencies` before releasing the `Major` package to npm.

`NPM` will choose which native package should download from `registry` automatically. You can see [npm](./npm) dir for details. And you can also run `yarn add napi-example` to see how it works.

## Examples

### Basic Usage

```typescript
import { plus100 } from 'napi-example';

// Using the plus100 function
const result = plus100(42);
console.log(result); // Output: 142
```

### Advanced Usage with Interfaces

```typescript
// Define TypeScript interfaces for better type safety
interface MathOperation {
  input: number;
  operation: 'plus' | 'minus' | 'multiply' | 'divide';
  value: number;
}

interface MathResult {
  original: number;
  result: number;
  operation: string;
}

// Function that uses the native addon with proper typing
function performMathOperation(params: MathOperation): MathResult {
  switch(params.operation) {
    case 'plus':
      return {
        original: params.input,
        result: plus100(params.input + params.value),
        operation: `plus ${params.value}`
      };
    default:
      throw new Error('Unsupported operation');
  }
}

// Usage example
const operation: MathOperation = {
  input: 10,
  operation: 'plus',
  value: 5
};

const result = performMathOperation(operation);
console.log(result); // Output: { original: 10, result: 115, operation: 'plus 5' }
```

## Develop requirements

- Install the latest `Rust`
- Install `Node.js@10+` which fully supported `Node-API`
- Install `yarn@1.x`

## Test in local

- yarn
- yarn build
- yarn test

And you will see:

```bash
$ ava --verbose

  ✔ sync function from native code
  ✔ sleep function from native code (201ms)
  ─

  2 tests passed
✨  Done in 1.12s.
```

## Release package

Ensure you have set your **NPM_TOKEN** in the `GitHub` project setting.

In `Settings -> Secrets`, add **NPM_TOKEN** into it.

When you want to release the package:

```bash
npm version [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease [--preid=<prerelease-id>] | from-git]

git push
```

GitHub actions will do the rest job for you.

> WARN: Don't run `npm publish` manually.

## TypeScript Typing Improvements

This project demonstrates several TypeScript typing best practices:

1. **Interface Definitions**: Using interfaces for complex data structures
2. **Function Signatures**: Explicit typing for function parameters and return values
3. **Type Safety**: Leveraging TypeScript's compile-time checking to prevent runtime errors
4. **Documentation**: Adding JSDoc comments for better IDE support

### Benefits of Enhanced Typing

- **Compile-time Error Detection**: Catch type-related errors before runtime
- **Better IDE Support**: Enhanced autocomplete and refactoring capabilities
- **Self-documenting Code**: Clear function signatures make code easier to understand
- **Maintainability**: Easier to refactor and extend codebase

### Adding More Typings

To add more TypeScript typings to this project:

1. Define interfaces for your data structures
2. Add JSDoc comments to functions
3. Use generic types where appropriate
4. Create type aliases for complex types
5. Export types for use in other modules

Example of adding a new typed function:

```typescript
/**
 * Performs a mathematical operation on a number
 * @param input - The number to operate on
 * @param operation - The type of operation to perform
 * @param value - The value to use in the operation
 * @returns The result of the operation
 */
export function performOperation(
  input: number, 
  operation: 'add' | 'subtract' | 'multiply' | 'divide', 
  value: number
): number {
  // Implementation would go here
  return input; // Placeholder
}
