+++
title = "My perfect Node + Typescript setup"
date = 2024-12-26
+++

Ideally, I would just use [Deno](https://deno.com) for every new Typescript project I create. But sometimes you just **have** to use Node.

These are the tools and libraries I use to make my Node + Typescript experience less cumbersome.

Feel free to check out the final template on [this repository](https://github.com/neolight1010/node-ts-template), based on what is written on this post.

### ES Modules

ES Modules are *the* standard for modern-Javscript module resolution, and they are growing in popularity with each new package and framework out there. So, I adhere to this new standard by prefering ES-Module libraries and setting my target module resolution to ES Modules. Look at [this article](https://deno.com/blog/commonjs-is-hurting-javascript) for more information on the benefits of ES Modules over CommonJS.

### [`@tsconfig/strictest`](https://www.npmjs.com/package/@tsconfig/strictest)

To enjoy the full benefits of static typing, I use the `tsconfig.json` template from [`@ts-config/strictest`](https://www.npmjs.com/package/@tsconfig/strictest). It enables the strictest Typescript configurations in a sensible manner. You can either extend it by installing the package, or just copy the configuration file directly.

### [Biome](https://biomejs.dev/)

It's always been bothersome to me having to set up mulitple tools for formatting, linting and import-sorting. Thankfully, this is not necessary anymore thanks to [Biome](https://biomejs.dev/). This tool packs a formatter, linter and import-sorter in a single, easy-to-configure and Typescript-friendly package. Goodbye Prettier and ESLint!

### [Husky](https://typicode.github.io/husky/) + [`lint-staged`](https://github.com/lint-staged/lint-staged)

I've tried multiple tools for Git hooks over the years, but I always end up coming back to [Husky](https://typicode.github.io/husky/). I think it is the best Git-hook solution in the Node ecosystem due to its flexibility and simplicity of use.

In order to set up a pre-commit hook for automatically formatting and linting the code, I pair up Husky with [`lint-staged`](https://github.com/lint-staged/lint-staged). This tool runs your hooks in a smart way to avoid messing up your Git workspace -- that is, you don't have to worry about unstaged modifications inadvertedly being added to new commits. That's very handy to keep your commits tidy!

### [Vitest](https://vitest.dev/)

Every time I've had to configure Jest with Typescript I've ended up with a headache. [Vitest](https://vitest.dev/) not only runs tests faster, but its integration with Typescript is seamless! It's also part of the [Vite](https://vite.dev/) (best build tool?) ecosystem and it allows you to configure more advanced features in a breeze, like path aliases. Oh, and about that...

### [`tsc-alias`](https://www.npmjs.com/package/tsc-alias)

I usually find that, in larger projects, relative imports become distracting and fail to express the designed module structure. Typescript's path aliases help you overcome this issue easily by allowing you to create "shortcuts" to your modules and libraries. However, Typescript does not resolve these aliases after compilation, so we need another tool to correctly reference the actual code during build or runtime.

[`tsconfig-paths`](https://www.npmjs.com/package/tsconfig-paths) is the most popular of these tools, but the resolution is performed at runtime, which I think produces unnecessary overhead. [`tsc-alias`], although less popular, is my preferred tool, as it performs the resolution at compile time; you just need to add a new command to your `build` script and you're ready to go!

The default alias I recommend you add is `"@/*": "[./src/*]"`. That way, you can easily import your main modules like: `import { NavBar } from "@/components/index.js"` or `import { zip } from "@/utils/index.js"`.

## Additionally

These are some additional tools/libraries that I find useful for my projects:

### [`fp-ts`](https://gcanti.github.io/fp-ts/)

This library allows you to write code in a functional style. It packs very useful utilities like the `Option`, `Either` and `Task` types. The code you write with this library will end up looking very different to your traditional imperative code, but if you use it right, it will be more concise, expressive, safe and reusable. Just make sure your team is okay with adopting this paradigm!

I might write a blog about this beautiful library sometime. Stay tuned!

### [Vite](https://vite.dev/)

Vite has become one of the most popular build tools out there. It's fast, modern, easy to use and featureful. I highly recommend it to build new frontend projects. You can pair up [Vite](https://vite.dev/) with [Vitest](https://vitest.dev/) for the best Typescript-for-frontend experience out there.

### [Yarn](https://yarnpkg.com/)

With time, NPM has caught up with the features of its competitors. But [Yarn](https://yarnpkg.com/) still holds up well against it thanks to its parallel-installation process and its easy adoptability. I highly recommend it as a middle ground between regular NPM and the more "experimental" package managers like [pnpm](https://pnpm.io/).

# Thank you!

Thank you for reading this blog! I hope you found it useful :)
