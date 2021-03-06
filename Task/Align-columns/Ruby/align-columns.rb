J2justifier = {'L' => :ljust,
               'R' => :rjust,
               'C' => :center}

=begin
Justify columns of textual tabular input where the record separator is the newline
and the field separator is a 'dollar' character.
justification can be L, R, or C; (Left, Right, or Centered).

Return the justified output as a string
=end
def aligner(infile, justification = 'L')
  fieldsbyrow = infile.map {|line| line.strip.split('$')}
  # pad to same number of fields per record
  maxfields = fieldsbyrow.map(&:length).max
  fieldsbyrow.map! {|row| row + ['']*(maxfields - row.length)}
  # calculate max fieldwidth per column
  colwidths = fieldsbyrow.transpose.map {|column|
    column.map(&:length).max
  }
  # pad fields in columns to colwidth with spaces
  justifier = J2justifier[justification]
  fieldsbyrow.map {|row|
    row.zip(colwidths).map {|field, width|
      field.send(justifier, width)
    }.join(" ")
  }.join("\n")
end

require 'stringio'

textinfile = <<END
Given$a$text$file$of$many$lines,$where$fields$within$a$line$
are$delineated$by$a$single$'dollar'$character,$write$a$program
that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$
column$are$separated$by$at$least$one$space.
Further,$allow$for$each$word$in$a$column$to$be$either$left$
justified,$right$justified,$or$center$justified$within$its$column.
END

for align in %w{Left Right Center}
  infile = StringIO.new(textinfile)
  puts "\n# %s Column-aligned output:" % align
  puts aligner(infile, align[0..0])
end
