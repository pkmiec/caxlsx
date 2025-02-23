# frozen_string_literal: true

module Axlsx
  # A BarSeries defines the title, data and labels for bar charts
  # @note The recommended way to manage series is to use Chart#add_series
  # @see Worksheet#add_chart
  # @see Chart#add_series
  class BarSeries < Series
    # The data for this series.
    # @return [NumDataSource]
    attr_reader :data

    # The labels for this series.
    # @return [Array, SimpleTypedList]
    attr_reader :labels

    # The shape of the bars or columns
    # @return [Symbol] must be one of [:cone, :coneToMax, :box, :cylinder, :pyramid, :pyramidToMax]
    attr_reader :shape

    # An array of rgb colors to apply to your bar chart.
    attr_reader :colors

    # The fill color for this series.
    # Red, green, and blue is expressed as sequence of hex digits, RRGGBB.
    # @return [String]
    attr_reader :series_color

    # Creates a new series
    # @option options [Array, SimpleTypedList] data
    # @option options [Array, SimpleTypedList] labels
    # @option options [String] title
    # @option options [String] shape
    # @option options [String] colors an array of colors to use when rendering each data point
    # @option options [String] series_color a color to use when rendering series
    # @param [Chart] chart
    def initialize(chart, options = {})
      @shape = :box
      @colors = []
      super(chart, options)
      self.labels = AxDataSource.new({ data: options[:labels] }) unless options[:labels].nil?
      self.data = NumDataSource.new(options) unless options[:data].nil?
    end

    # @see colors
    def colors=(v) DataTypeValidator.validate "BarSeries.colors", [Array], v; @colors = v end

    def series_color=(v)
      @series_color = v
    end

    # @see shape
    def shape=(v)
      RestrictionValidator.validate "BarSeries.shape", [:cone, :coneToMax, :box, :cylinder, :pyramid, :pyramidToMax], v
      @shape = v
    end

    # Serializes the object
    # @param [String] str
    # @return [String]
    def to_xml_string(str = +'')
      super(str) do
        colors.each_with_index do |c, index|
          str << '<c:dPt>'
          str << '<c:idx val="' << index.to_s << '"/>'
          str << '<c:spPr><a:solidFill>'
          str << '<a:srgbClr val="' << c << '"/>'
          str << '</a:solidFill></c:spPr></c:dPt>'
        end

        if series_color
          str << '<c:spPr><a:solidFill>'
          str << '<a:srgbClr val="' << series_color << '"/>'
          str << '</a:solidFill>'
          str << '</c:spPr>'
        end

        @labels.to_xml_string(str) unless @labels.nil?
        @data.to_xml_string(str) unless @data.nil?
        # this is actually only required for shapes other than box
        str << '<c:shape val="' << shape.to_s << '"></c:shape>'
      end
    end

    private

    # assigns the data for this series
    def data=(v) DataTypeValidator.validate "Series.data", [NumDataSource], v; @data = v; end

    # assigns the labels for this series
    def labels=(v) DataTypeValidator.validate "Series.labels", [AxDataSource], v; @labels = v; end
  end
end
