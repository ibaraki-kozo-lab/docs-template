// 数式（mkdocs.yml の pymdownx.arithmatex）を MathJax で表示するための設定．
// Material for MkDocs の資料のとおりで，ふだんは触らなくてよい
window.MathJax = {
  tex: {
    inlineMath: [["\\(", "\\)"]],
    displayMath: [["\\[", "\\]"]],
    processEscapes: true,
    processEnvironments: true,
  },
  options: {
    ignoreHtmlClass: ".*|",
    processHtmlClass: "arithmatex",
  },
};

// ページを移るたびに，新しいページの数式を表示し直す
document$.subscribe(() => {
  MathJax.startup.output.clearCache();
  MathJax.typesetClear();
  MathJax.texReset();
  MathJax.typesetPromise();
});
