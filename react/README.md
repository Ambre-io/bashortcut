# 🧿 REACT BEST PRACTICES 🧿
###### 🚀 [FROM THE OFFICIAL 2023 DOCUMENTATION](https://react.dev/learn) ~ should evolve a bit

## Basics

- Component should be pure: same props give the same JSX with no side effects
- Do not mutate Component inputs, set a state with `useState()`
- Side effect could be triggered by event handlers `goChange()` or `useEffect()`
- Favor logic in the Component body in order to keep the returned JSX light
- Component sould not return `null`, you would conditionally include or exclude the component in the parent component’s JSX

## More...

- JSX elements inside a `map()` always need keys. Keys are a React hint for good performance. Each key should be defined with a stable ID based on data
- Never nest a Component inside another one, declare all components in the no man's land
- Do not put numbers on the left side of `&&` in JSX conditional rendering, use booleans only
- Hooks can only be called within the component main scope

## States

- All states should be treated has immutable, even if it's an object or an array
- [Objects](https://react.dev/learn/updating-objects-in-state) and [Arrays](https://react.dev/learn/updating-arrays-in-state) in React state are read-only: to update the state, create a new instance by using the `...` spread operator, `map()` or `filter()` for instance
- Lifting state up: to share a state, parent component declare the state and pass it as props to these children components
- A component is controlled when it's managed by its parent using props
- A component is uncontrolled when it's managed by its own local state

## Renders

- Each render is a snapshot of a Component and its state, only the last state update is take in account for a render
- Variables and event handlers don’t “survive” re-renders
- Batching: React execute event handlers and queue state updates before process them during the (re-)render
- State setter with a value as parameter is a "replace with", it could not update the state multiple times, it's ignoring what is already queued
- State setter with a function as parameter, called updater function, allows to update state mutiple times, until a "replace with".

💡 Maybe updater function should not be used: please code in an explicit and simple way, for all of us.

## Tricks

- [\<StrictMode>](https://react.dev/reference/react/StrictMode) is an integrated development-only debugger
- It checks Components usages, re-run effects an extra time but discard the second result and re-render an extra time
- It's possible to force a Component to reset state by using the `key` argument
- It's possible to use `await` at top level with self-invoing function

## Pitfalls

- All events propagate in React except onScroll, which only works on the JSX tag you attach it to
