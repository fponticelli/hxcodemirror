package codemirror;

import js.html.TextAreaElement;

extern class TextAreaCodeMirror extends CodeMirror {
  /**
  Copy the content of the editor into the textarea.
  */
  function save() : Void;
  /**
  Remove the editor, and restore the original textarea (with the editor's current content).
  */
  function toTextArea() : Void;
  /**
  Returns the textarea that the instance was based on.
  */
  function getTextArea() : TextAreaElement;
}
