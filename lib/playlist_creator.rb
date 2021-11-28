#!/usr/bin/env ruby

# file: playlist_creator.rb

require 'dynarex'
require 'nokogiri'


XSLT_DX = <<XSLT
<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0' xmlns='http://xspf.org/ns/0/'>
  <xsl:output method='xml' indent='yes' omit-xml-declaration='no'  encoding='utf-8'/>
  <xsl:template match='tracklist'>
  <playlist version="1">
    <trackList>
      <xsl:apply-templates select='summary'/>
      <xsl:apply-templates select='records/track'/>
    </trackList>
  </playlist>
  </xsl:template>
  <xsl:template match='tracklist/summary'/>
  <xsl:template match='records/track'>
    <track>
      <title>
        <xsl:value-of select='title'/>
      </title>
      <album>
        <xsl:value-of select='album'/>
      </album>
      <location>
        <xsl:value-of select='location'/>
      </location>
    </track>
  </xsl:template>
</xsl:stylesheet>
XSLT


class PlaylistCreator

  def initialize(obj=nil)

    @dx = if obj.is_a? String then
      header = "<?dynarex schema='tracklist/track(location, title, " +
          "album)'?>\n--+\n"
      Dynarex.new(header + obj)
    elsif  obj.is_a? Dynarex
      obj
    else
      Dynarex.new('tracklist/track(location, title, album)')
    end

  end

  def add(titlex='', locationx='', title: titlex,
          location: locationx, album: '')
    @dx.create({title: title, location: location, album: album})
  end

  def delete(id)
    @dx.delete id
  end

  def find_by_title(title)
    @dx.all.select {|x| x.title[/#{title}/i]}
  end

  def to_dx()
    @dx.clone
  end

  def to_xml()
    @dx.to_xml pretty: true
  end

  def to_xspf()
    doc   = Nokogiri::XML(@dx.to_xml(pretty: true))
    xslt  = Nokogiri::XSLT(XSLT_DX)
    xslt.transform(doc).to_xml
  end

  def update(id, title: nil, location: nil, album: nil)
    @dx.update(id, {title: title, location: location, album: album})
  end

end
