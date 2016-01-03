package codemirror;

import js.html.Element;
import haxe.extern.EitherType as E;

typedef Options = {
  /**
  The starting value of the editor. Can be a string, or a document object.
  */
  ?value : E<String, Doc>,
  /**
  The mode to use. When not given, this will default to the first mode that was loaded. It may be a string, which either simply names the mode or is a MIME type associated with the mode. Alternatively, it may be an object containing configuration options for the mode, with a name property that names the mode (for example `{name: "javascript", json: true}`). The demo pages for each mode contain information about what configuration parameters the mode supports. You can ask CodeMirror which modes and MIME types have been defined by inspecting the `CodeMirror.modes` and `CodeMirror.mimeModes` objects. The first maps mode names to their constructors, and the second maps MIME types to mode specs.
  */
  ?mode : E<String, { name : String }>,
  /**
  Explicitly set the line separator for the editor. By default (value null), the document will be split on CRLFs as well as lone CRs and LFs, and a single LF will be used as line separator in all output (such as getValue). When a specific string is given, lines will only be split on that string, and output will, by default, use that same separator.
  */
  ?lineSeparator : String,
  /**
  The theme to style the editor with. You must make sure the CSS file defining the corresponding `.cm-s-[name]` styles is loaded (see the theme directory in the distribution). The default is "`default`", for which colors are included in `codemirror.css`. It is possible to use multiple theming classes at once—for example "`foo bar`" will assign both the `cm-s-foo` and the `cm-s-bar` classes to the editor.
  */
  ?theme : String,
  /**
  How many spaces a block (whatever that means in the edited language) should be indented. The default is `2`.
  */
  ?indentUnit : Int,
  /**
  Whether to use the context-sensitive indentation that the mode provides (or just indent the same as the line before). Defaults to `true`.
  */
  ?smartIndent : Bool,
  /**
  The width of a tab character. Defaults to `4`.
  */
  ?tabSize : Int,
  /**
  Whether, when indenting, the first N*`tabSize` spaces should be replaced by N tabs. Default is false.
  */
  ?indentWithTabs : Bool,
  /**
  Configures whether the editor should re-indent the current line when a character is typed that might change its proper indentation (only works if the mode supports indentation). Default is true.
  */
  ?electricChars : Bool,
  /**
  A regular expression used to determine which characters should be replaced by a special placeholder. Mostly useful for non-printing special characters. The default is `/[\u0000-\u0019\u00ad\u200b-\u200f\u2028\u2029\ufeff]/`.
  */
  ?specialChars : js.RegExp,
  /**
  A function that, given a special character identified by the specialChars option, produces a DOM node that is used to represent the character. By default, a red dot (`•`) is shown, with a title tooltip to indicate the character code.
  */
  ?specialCharPlaceholder : String -> Element, // TODO should String be Int? doc says `char`
  /**
  Determines whether horizontal cursor movement through right-to-left (Arabic, Hebrew) text is visual (pressing the left arrow moves the cursor left) or logical (pressing the left arrow moves to the next lower index in the string, which is visually right in right-to-left text). The default is false on Windows, and true on other platforms.
  */
  ?rtlMoveVisually : Bool,
  /**
  Configures the key map to use. The default is "default", which is the only key map defined in codemirror.js itself. Extra key maps are found in the key map directory. See the section on key maps for more information.
  */
  ?keyMap : String,
  /**
  Can be used to specify extra key bindings for the editor, alongside the ones defined by keyMap. Should be either `null`, or a valid key map value.
  */
  ?extraKeys: {}, // TODO
  /**
  Whether CodeMirror should scroll or wrap for long lines. Defaults to `false` (scroll).
  */
  ?lineWrapping : Bool,
  /**
  Whether to show line numbers to the left of the editor.
  */
  ?lineNumbers : Bool,
  /**
  At which number to start counting lines. Default is `1`.
  */
  ?firstLineNumber : Int,
  /**
  A function used to format line numbers. The function is passed the line number, and should return a string that will be shown in the gutter.
  */
  ?lineNumberFormatter : Int -> String,
  /**
  Can be used to add extra gutters (beyond or instead of the line number gutter). Should be an array of CSS class names, each of which defines a width (and optionally a background), and which will be used to draw the background of the gutters. May include the CodeMirror-linenumbers class, in order to explicitly set the position of the line number gutter (it will default to be to the right of all other gutters). These class names are the keys passed to setGutterMarker.
  */
  gutters: Array<String>,
  /**
  Determines whether the gutter scrolls along with the content horizontally (false) or whether it stays fixed during horizontal scrolling (true, the default).
  */
  ?fixedGutter : Bool,
  /**
  Chooses a scrollbar implementation. The default is "native", showing native scrollbars. The core library also provides the "null" style, which completely hides the scrollbars. Addons can implement additional scrollbar models.
  */
  ?scrollbarStyle : String,
  /**
  When fixedGutter is on, and there is a horizontal scrollbar, by default the gutter will be visible to the left of this scrollbar. If this option is set to true, it will be covered by an element with class CodeMirror-gutter-filler.
  */
  ?coverGutterNextToScrollbar : Bool,
  /**
  Selects the way CodeMirror handles input and focus. The core library defines the "textarea" and "contenteditable" input models. On mobile browsers, the default is "contenteditable". On desktop browsers, the default is "textarea". Support for IME and screen readers is better in the "contenteditable" model. The intention is to make it the default on modern desktop browsers in the future.
  */
  ?inputStyle : String,
  /**
  This disables editing of the editor content by the user. If the special value "nocursor" is given (instead of simply `true`), focusing of the editor is also disallowed.
  */
  ?readOnly : E<Bool,String>,
  /**
  Whether the cursor should be drawn when a selection is active. Defaults to `false`.
  */
  ?showCursorWhenSelecting : Bool,
  /**
  When enabled, which is the default, doing copy or cut when there is no selection will copy or cut the whole lines that have cursors on them.
  */
  ?lineWiseCopyCut : Bool,
  /**
  The maximum number of undo levels that the editor stores. Note that this includes selection change events. Defaults to `200`.
  */
  ?undoDepth : Int,
  /**
  The period of inactivity (in milliseconds) that will cause a new history event to be started when typing or deleting. Defaults to `1250`.
  */
  ?historyEventDelay : Int,
  /**
  The tab index to assign to the editor. If not given, no tab index will be assigned.
  */
  ?tabindex : Int,
  /**
  Can be used to make CodeMirror focus itself on initialization. Defaults to off. When fromTextArea is used, and no explicit value is given for this option, it will be set to true when either the source textarea is focused, or it has an autofocus attribute and no other element is focused.
  */
  ?autofocus : Bool
}
