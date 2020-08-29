export function throttle(handlerFunc, timeout = 66) {
  let resizeTimeout;
  if (!resizeTimeout) {
    resizeTimeout = setTimeout(() => {
      resizeTimeout = null;
      handlerFunc();
      // The actualResizeHandler will execute at a rate of 15fps
    }, timeout);
  }
}
export const debouncing = function(fn, delay = 300) {
  let timer;
  let context = this;
  args = arguments;
  return function() {
    clearTimeout(timer);
    timer = setTimeout(() => {
      fn.apply(context, arguments);
    }, delay);
  };
};
