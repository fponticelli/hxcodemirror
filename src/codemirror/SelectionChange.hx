package codemirror;

typedef SelectionChange = {
  ranges : Array<Range>,
  origin : String,
  update : Array<Range> -> Void
}
