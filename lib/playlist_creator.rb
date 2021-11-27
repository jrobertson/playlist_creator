#!/usr/bin/env ruby

# file: playlist_creator.rb

require 'dynarex'
require 'nokogiri'


XSLT_DX = <<XSLT
<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0' xmlns="http://www.opengis.net/kml/2.2">
  <xsl:output method='xml' indent='yes' omit-xml-declaration='no'  encoding='utf-8'/>
  <xsl:template match='tracklist'>
  <playlist version="1">
    <tracklist>
      <xsl:apply-templates select='summary'/>
      <xsl:apply-templates select='records/track'/>
    </tracklist>
  </playlist>
  </xsl:template>
  <xsl:template match='tracklist/summary'/>
  <xsl:template match='records/track'>
    <track>
      <title>
        <xsl:value-of select='title'/>
      </title>
      <location>
        <xsl:value-of select='location'/>
      </location>
    </track>
  </xsl:template>
</xsl:stylesheet>
XSLT


class PlaylistCreator

  def initialize(obj)

    @dx = if obj.is_a? String then
      header = "<?dynarex schema='tracklist/track(title, location)'?>\n--+\n"
      Dynarex.new(header + obj)
    elsif  obj.is_a? Dynarex
      obj
    end

  end

  def to_xspf()
    doc   = Nokogiri::XML(@dx.to_xml(pretty: true))
    xslt  = Nokogiri::XSLT(XSLT_DX)
    xslt.transform(doc).to_xml
  end

end
