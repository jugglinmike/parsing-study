export { foo };
export { foo, };
export { foo as bar };
export { foo as bar, };

export { foo, bar };
export { foo, bar, };
export { foo, bar as baz };
export { foo, bar as baz, };

export { foo, bar, baz };
export { foo, bar as baz, qux };

export { foo } from 'elsewhere';
