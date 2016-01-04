package codemirror;

typedef LineInfo = {
  line : Int,
  handle : LineHandle,
  text : String,
  gutterMarkers : String, // TODO ?
  textClass : String,
  bgClass : String,
  wrapClass : String,
  widgets : Array<Dynamic> // TODO ?
}
