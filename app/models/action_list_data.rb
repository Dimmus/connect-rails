
class ActionListData

  def initialize(headings, widths, data_procs)
    @headings = headings
    @widths = widths
    @data_procs = data_procs

    if @headings.size != @widths.size || @headings.size != @data_procs.size
      raise IllegalArgument, "data sizes don't match" 
    end
  end

  def num_columns
    @headings.size
  end

  def get_heading(column)
    @headings[column]
  end

  def get_width(column)
    @widths[column]
  end

  def get_data(column, *args)
    @data_procs[column].call(*args)
  end

end