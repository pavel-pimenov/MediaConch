<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="https://mediaarea.net/mediaconch" xmlns:mc="https://mediaarea.net/mediaconch" xmlns:ma="https://mediaarea.net/mediaarea" xmlns:mi="https://mediaarea.net/mediainfo" xmlns:mmt="https://mediaarea.net/micromediatrace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:exsl="http://exslt.org/common" xmlns:str="http://exslt.org/strings" version="1.0" extension-element-prefixes="xsi ma mc mi mmt exsl str">
  <xsl:output encoding="UTF-8" method="xml" version="1.0" indent="yes"/>
  <xsl:template match="mmt:MicroMediaTrace/mmt:b">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  <xsl:variable name="lookupschema" select="document($schema)"/>
  <xsl:key name="elementNameViaSchema" match="element" use="@id"/>
  <xsl:variable name="ElementListWIthIDs">
    <xsl:for-each select="$lookupschema//element">
      <xsl:value-of select="@id"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>.</xsl:text>
    </xsl:for-each>
  </xsl:variable>
  <xsl:template match="ma:MediaArea">
    <MediaConch>
      <xsl:attribute name="version">
        <xsl:text>0.2</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="verbosity">
        <xsl:value-of select="$verbosity"/>
      </xsl:attribute>
      <xsl:for-each select="ma:media">
        <media>
          <xsl:attribute name="ref">
            <xsl:value-of select="./@ref"/>
          </xsl:attribute>
          <xsl:for-each select="mi:MediaInfo/mi:track">
            <xsl:choose>
              <xsl:when test="mi:Format='Matroska' or mi:Format='WebM'">
                <xsl:for-each select="ancestor::ma:media">
                  <xsl:call-template name="implementationChecks">
                    <xsl:with-param name="name">MediaConch EBML Implementation Checker</xsl:with-param>
                    <xsl:with-param name="checks">
                      <xsl:variable name="EBMLVersion">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLVersion']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLVersion']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>1</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:variable name="EBMLReadVersion">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLReadVersion']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLReadVersion']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>1</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:variable name="EBMLMaxIDLength">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxIDLength']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxIDLength']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>4</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:variable name="EBMLMaxSizeLength">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxSizeLength']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxSizeLength']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>8</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:variable name="DocTypeVersion">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='DocTypeVersion']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='DocTypeVersion']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>1</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <xsl:variable name="DocTypeReadVersion">
                        <xsl:choose>
                          <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='DocTypeReadVersion']/mmt:d">
                            <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='DocTypeReadVersion']/mmt:d"/>
                          </xsl:when>
                          <xsl:otherwise>1</xsl:otherwise>
                        </xsl:choose>
                      </xsl:variable>
                      <!-- EBML-ELEM-START -->
                      <xsl:call-template name="element_is_x">
                        <xsl:with-param name="icid">EBML-ELEM-START</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="x">EBML</xsl:with-param>
                        <xsl:with-param name="x_name">Required First Element of an EBML Document</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[1]"/>
                      </xsl:call-template>
                      <!-- /EBML-ELEM-START -->
                      <!-- EBML-VER-COH -->
                      <xsl:call-template name="element_is_less_than_or_equal_to_x">
                        <xsl:with-param name="icid">EBML-VER-COH</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLReadVersion']"/>
                        <xsl:with-param name="x" select="$EBMLVersion"/>
                        <xsl:with-param name="x_name">EBMLVersion</xsl:with-param>
                      </xsl:call-template>
                      <!-- /EBML-VER-COH -->
                      <!-- EBML-DOCVER-COH -->
                      <xsl:call-template name="element_is_less_than_or_equal_to_x">
                        <xsl:with-param name="icid">EBML-DOCVER-COH</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='DocTypeReadVersion']"/>
                        <xsl:with-param name="x" select="$DocTypeVersion"/>
                        <xsl:with-param name="x_name">DocTypeVersion</xsl:with-param>
                      </xsl:call-template>
                      <!-- /EBML-DOCVER-COH -->
                      <!-- EBML-ELEMENT-VALID-PARENT -->
                      <xsl:call-template name="element_has_valid_parent">
                        <xsl:with-param name="icid">EBML-ELEMENT-VALID-PARENT</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b//mmt:b[mmt:b[1][@n='Header']/mmt:d[@n='Name']]"/>
                      </xsl:call-template>
                      <!-- /EBML-ELEMENT-VALID-PARENT -->
                      <!-- EBML-ELEMENT-NONMULTIPLES -->
                      <xsl:call-template name="element_does_not_repeat_in_parent">
                        <xsl:with-param name="icid">EBML-ELEMENT-NONMULTIPLES</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace//mmt:b[mmt:b[1][@n='Header']/mmt:d[@n='Name']]"/>
                      </xsl:call-template>
                      <!-- /EBML-ELEMENT-NONMULTIPLES -->
                      <!-- EBML-ELEMENT-CONTAINS-MANDATES -->
                      <xsl:call-template name="element_contains_mandates">
                        <xsl:with-param name="icid">EBML-ELEMENT-CONTAINS-MANDATES</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace//mmt:b[mmt:b[1][@n='Header']/mmt:d[@n='Name']][not(mmt:d)]"/>
                      </xsl:call-template>
                      <!-- /EBML-ELEMENT-CONTAINS-MANDATES -->
                      <!-- EBML-ELEMENT-IN-SIZE-RANGE -->
                      <xsl:call-template name="element_at_correct_size">
                        <xsl:with-param name="icid">EBML-ELEMENT-IN-SIZE-RANGE</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace//mmt:b[mmt:b[1][@n='Header']/mmt:d[@n='Name']][mmt:d]"/>
                      </xsl:call-template>
                      <!-- /EBML-ELEMENT-IN-SIZE-RANGE -->
                      <!-- EBML-VALID-MAXID -->
                      <xsl:call-template name="element_is_less_than_or_equal_to_x">
                        <xsl:with-param name="icid">EBML-VALID-MAXID</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxIDLength']"/>
                        <xsl:with-param name="x">4</xsl:with-param>
                        <xsl:with-param name="x_name">Minimum valid EBMLMaxIDLength</xsl:with-param>
                      </xsl:call-template>
                      <!-- /EBML-VALID-MAXID -->
                      <!-- EBML-VALID-MAXSIZE -->
                      <xsl:call-template name="element_is_less_than_or_equal_to_x">
                        <xsl:with-param name="icid">EBML-VALID-MAXSIZE</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='EBML']/mmt:b[@n='EBMLMaxSizeLength']"/>
                        <xsl:with-param name="x">8</xsl:with-param>
                        <xsl:with-param name="x_name">Minimum valid EBMLMaxSizeLength</xsl:with-param>
                      </xsl:call-template>
                      <!-- /EBML-VALID-MAXSIZE -->
                      <!-- HEADER-ELEMENTS-WITHIN-IDLENGTH-LIMIT -->
                      <xsl:call-template name="check">
                        <xsl:with-param name="icid">HEADER-ELEMENTS-WITHIN-IDLENGTH-LIMIT</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="context">
                          <context>
                            <xsl:attribute name="name">
                              <xsl:text>EBMLMaxIDLength</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="$EBMLMaxIDLength"/>
                          </context>
                        </xsl:with-param>
                        <xsl:with-param name="test">
                          <xsl:choose>
                            <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']//mmt:b[@n='Header']/mmt:d[@n='Size'][@o &gt; (../../mmt:b/@o + 4)]">
                              <xsl:for-each select="mmt:MicroMediaTrace/mmt:b[@n='EBML']//mmt:b[@n='Header']/mmt:d[@n='Size'][@o &gt; (../../mmt:b/@o + 4)]">
                                <test>
                                  <xsl:attribute name="outcome">fail</xsl:attribute>
                                  <xsl:attribute name="reason">
                                    <xsl:text>Element ID Length greater than EBMLMaxIDLength.</xsl:text>
                                  </xsl:attribute>
                                  <value>
                                    <xsl:attribute name="offset">
                                      <xsl:value-of select="@o"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                      <xsl:value-of select="../../@n"/>
                                      <xsl:text>:Element_ID_Length</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="@o - ../../mmt:b/@o"/>
                                  </value>
                                </test>
                              </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                              <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <value>
                                  <xsl:attribute name="name">
                                    <xsl:text>EBMLMaxIDLength (for EBML Header Elements)</xsl:text>
                                  </xsl:attribute>
                                  <xsl:value-of select="4"/>
                                </value>
                              </test>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:with-param>
                      </xsl:call-template>
                      <!-- /HEADER-ELEMENTS-WITHIN-IDLENGTH-LIMIT -->
                      <!-- ELEMENTS-WITHIN-MAXIDLENGTH -->
                      <xsl:call-template name="check">
                        <xsl:with-param name="icid">ELEMENTS-WITHIN-MAXIDLENGTH</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="context">
                          <context>
                            <xsl:attribute name="name">
                              <xsl:text>EBMLMaxIDLength</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="$EBMLMaxIDLength"/>
                          </context>
                        </xsl:with-param>
                        <xsl:with-param name="test">
                          <xsl:choose>
                            <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n!='EBML']//mmt:b[@n='Header']/mmt:d[@n='Size'][@o &gt; (../../mmt:b/@o + $EBMLMaxIDLength)]">
                              <xsl:for-each select="mmt:MicroMediaTrace/mmt:b[@n!='EBML']//mmt:b[@n='Header']/mmt:d[@n='Size'][@o &gt; (../../mmt:b/@o + $EBMLMaxIDLength)]">
                                <test>
                                  <xsl:attribute name="outcome">fail</xsl:attribute>
                                  <xsl:attribute name="reason">
                                    <xsl:text>Element ID Length greater than EBMLMaxIDLength.</xsl:text>
                                  </xsl:attribute>
                                  <value>
                                    <xsl:attribute name="offset">
                                      <xsl:value-of select="@o"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                      <xsl:value-of select="../../@n"/>
                                      <xsl:text>:Element_ID_Length</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="@o - ../../mmt:b/@o"/>
                                  </value>
                                </test>
                              </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                              <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <value>
                                  <xsl:attribute name="name">
                                    <xsl:text>EBMLMaxIDLength</xsl:text>
                                  </xsl:attribute>
                                  <xsl:value-of select="$EBMLMaxIDLength"/>
                                </value>
                              </test>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:with-param>
                      </xsl:call-template>
                      <!-- /ELEMENTS-WITHIN-MAXIDLENGTH -->
                      <!-- HEADER-ELEMENTS-WITHIN-MAXSIZELENGTH -->
                      <xsl:call-template name="check">
                        <xsl:with-param name="icid">HEADER-ELEMENTS-WITHIN-MAXSIZELENGTH</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="context">
                          <context>
                            <xsl:attribute name="name">
                              <xsl:text>EBMLMaxSizeLength</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="$EBMLMaxSizeLength"/>
                          </context>
                        </xsl:with-param>
                        <xsl:with-param name="test">
                          <xsl:choose>
                            <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n='EBML']//mmt:b/mmt:d[@n='Size'][(../../mmt:d/@o - @o) &gt; 4]">
                              <xsl:for-each select="mmt:MicroMediaTrace/mmt:b[@n='EBML']//mmt:b/mmt:d[@n='Size'][(../../mmt:d/@o - @o) &gt; 4]">
                                <test>
                                  <xsl:attribute name="outcome">fail</xsl:attribute>
                                  <xsl:attribute name="reason">
                                    <xsl:text>An Element at has an Element Size Length greater than EBMLMaxSizeLength.</xsl:text>
                                  </xsl:attribute>
                                  <value>
                                    <xsl:attribute name="offset">
                                      <xsl:value-of select="@o"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                      <xsl:value-of select="../../@n"/>
                                      <xsl:text>:ElementDataSize_Length</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="../../mmt:d/@o - @o"/>
                                  </value>
                                </test>
                              </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                              <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <value>
                                  <xsl:attribute name="name">
                                    <xsl:text>EBMLMaxSizeLength (for EBML Header Elements)</xsl:text>
                                  </xsl:attribute>
                                  <xsl:value-of select="4"/>
                                </value>
                              </test>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:with-param>
                      </xsl:call-template>
                      <!-- /HEADER-ELEMENTS-WITHIN-MAXSIZELENGTH -->
                      <!-- ELEMENTS-WITHIN-MAXSIZELENGTH -->
                      <xsl:call-template name="check">
                        <xsl:with-param name="icid">ELEMENTS-WITHIN-MAXSIZELENGTH</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="context">
                          <context>
                            <xsl:attribute name="name">
                              <xsl:text>EBMLMaxSizeLength</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="$EBMLMaxSizeLength"/>
                          </context>
                        </xsl:with-param>
                        <xsl:with-param name="test">
                          <xsl:choose>
                            <xsl:when test="mmt:MicroMediaTrace/mmt:b[@n!='EBML']//mmt:b/mmt:d[@n='Size'][(../../mmt:d/@o - @o) &gt; $EBMLMaxSizeLength]">
                              <xsl:for-each select="mmt:MicroMediaTrace/mmt:b[@n!='EBML']//mmt:b/mmt:d[@n='Size'][(../../mmt:d/@o - @o) &gt; $EBMLMaxSizeLength]">
                                <test>
                                  <xsl:attribute name="outcome">fail</xsl:attribute>
                                  <xsl:attribute name="reason">
                                    <xsl:text>An Element at has an Element Size Length greater than EBMLMaxSizeLength.</xsl:text>
                                  </xsl:attribute>
                                  <value>
                                    <xsl:attribute name="offset">
                                      <xsl:value-of select="@o"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                      <xsl:value-of select="../../@n"/>
                                      <xsl:text>:ElementDataSize_Length</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="../../mmt:d/@o - @o"/>
                                  </value>
                                </test>
                              </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                              <test>
                                <xsl:attribute name="outcome">pass</xsl:attribute>
                                <value>
                                  <xsl:attribute name="name">
                                    <xsl:text>EBMLMaxSizeLength</xsl:text>
                                  </xsl:attribute>
                                  <xsl:value-of select="$EBMLMaxSizeLength"/>
                                </value>
                              </test>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:with-param>
                      </xsl:call-template>
                      <!-- /ELEMENTS-WITHIN-MAXSIZELENGTH -->
                      <!-- MKV-SEEK-RESOLVE -->
                      <xsl:call-template name="seek_element_resolves">
                        <xsl:with-param name="icid">MKV-SEEK-RESOLVE</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="seek_element" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='SeekHead']/mmt:b[@n='Seek']/mmt:b[@n='SeekID']"/>
                      </xsl:call-template>
                      <!-- /MKV-SEEK-RESOLVE -->
                      <xsl:variable name="CRC_Elements" select="mmt:MicroMediaTrace/mmt:b/mmt:b[@n='CRC-32']|mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b/mmt:b[@n='CRC-32']"/>
                      <!-- EBML-CRC-FIRST -->
                      <xsl:call-template name="element_is_first_child">
                        <xsl:with-param name="icid">EBML-CRC-FIRST</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="$CRC_Elements"/>
                      </xsl:call-template>
                      <!-- /EBML-CRC-FIRST -->
                      <!-- EBML-CRC-VALID -->
                      <xsl:call-template name="child_data_info_is_ok">
                        <xsl:with-param name="icid">EBML-CRC-VALID</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="$CRC_Elements/mmt:d[@n='Value']"/>
                      </xsl:call-template>
                      <!-- /EBML-CRC-VALID -->
                      <!-- MKV-VALID-TRACKTYPE-VALUE -->
                      <xsl:call-template name="x_is_in_list">
                        <xsl:with-param name="icid">MKV-VALID-TRACKTYPE-VALUE</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="x" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Tracks']/mmt:b[@n='TrackEntry']/mmt:b[@n='TrackType']"/>
                        <xsl:with-param name="list">1 2 3 16 17 18 32</xsl:with-param>
                      </xsl:call-template>
                      <!-- /MKV-VALID-TRACKTYPE-VALUE -->
                      <!-- MKV-VALID-BOOLEANS -->
                      <xsl:call-template name="x_is_in_list">
                        <xsl:with-param name="icid">MKV-VALID-BOOLEANS</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="x" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Tracks']/mmt:b[@n='TrackEntry']/mmt:b[@n='FlagEnabled' or @n='FlagDefault' or @n='FlagForced' or @n='FlagLacing' or @n='CodecDecodeAll']|mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Chapters']/mmt:b[@n='EditionEntry']/mmt:b[@n='EditionFlagHidden' or @n='EditionFlagDefault' or @n='EditionFlagOrdered']|mmt:MicroMediaTrace/mmt:b[mmt:b[1][@n='Header']/mmt:d[@n='Name']='Segment']/mmt:b[@n='Chapters']/mmt:b[@n='EditionEntry']//mmt:b[@n='ChapterAtom']/mmt:b[@n='ChapterFlagHidden' or @n='ChapterFlagEnabled']|mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Tags']/mmt:b[@n='Tag']//mmt:b[@n='SimpleTag']/mmt:b[@n='TagDefault']"/>
                        <xsl:with-param name="list">0 1</xsl:with-param>
                      </xsl:call-template>
                      <!-- /MKV-VALID-BOOLEANS -->
                      <!-- MKV_NUMERICAL_TAG -->
                      <xsl:call-template name="tag_is_number">
                        <xsl:with-param name="icid">MKV_NUMERICAL_TAG</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="tagname">TOTAL_PARTS</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Tags']/mmt:b[@n='Tag']//mmt:b[@n='SimpleTag'][mmt:b[@n='TagName'][@info='TOTAL_PARTS']]/mmt:b[@n='TagString']"/>
                      </xsl:call-template>
                      <!-- /MKV_NUMERICAL_TAG -->
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:when>
              <xsl:when test="mi:Format='FFV1'">
                <xsl:for-each select="ancestor::ma:media">
                  <xsl:call-template name="implementationChecks">
                    <xsl:with-param name="name">MediaConch FFV1 Implementation Checker</xsl:with-param>
                    <xsl:with-param name="checks">
                      <xsl:call-template name="data_is_in_list">
                        <xsl:with-param name="icid">FFV1-VALID-CODERTYPE-VALUE</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="x" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Cluster']/mmt:b[@n='SimpleBlock']/mmt:b[@parser='FFV1']/mmt:d[@n='coder_type']"/>
                        <xsl:with-param name="list">0 1 2</xsl:with-param>
                      </xsl:call-template>
                      <xsl:call-template name="data_is_in_list">
                        <xsl:with-param name="icid">FFV1-VALID-COLORSPACETYPE-VALUE2</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="x" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Cluster']/mmt:b[@n='SimpleBlock']/mmt:b[@parser='FFV1']/mmt:d[@n='colorspace_type']"/>
                        <xsl:with-param name="list">0 1</xsl:with-param>
                      </xsl:call-template>
                      <!-- FFV1-SLICE-CRC-VALID -->
                      <xsl:call-template name="child_data_info_is_ok">
                        <xsl:with-param name="icid">FFV1-SLICE-CRC-VALID</xsl:with-param>
                        <xsl:with-param name="version">1</xsl:with-param>
                        <xsl:with-param name="element" select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Cluster']/mmt:b[@n='SimpleBlock']/mmt:b[@parser='FFV1']/mmt:b[@n='Slice']/mmt:d[@n='crc_parity']"/>
                      </xsl:call-template>
                      <!-- /FFV1-SLICE-CRC-VALID -->
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:when>
              <xsl:when test="mi:Format='PCM'">
                <xsl:call-template name="implementationChecks">
                  <xsl:with-param name="name">MediaConch PCM Implementation Checker</xsl:with-param>
                  <xsl:with-param name="checks">
                    <!-- PCM-IS-CBR -->
                    <xsl:call-template name="data_is_in_list">
                      <xsl:with-param name="icid">PCM-IS-CBR</xsl:with-param>
                      <xsl:with-param name="version">1</xsl:with-param>
                      <xsl:with-param name="x" select="mi:BitRate_Mode"/>
                      <xsl:with-param name="list">CBR</xsl:with-param>
                    </xsl:call-template>
                    <!-- /PCM-IS-CBR -->
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="implementationChecks">
                  <xsl:with-param name="name">
                    <xsl:choose>
                      <xsl:when test="mi:Format">
                        <xsl:text>MediaConch Implementation Checker does not support </xsl:text>
                        <xsl:value-of select="mi:Format"/>
                        <xsl:if test="@type!='General'">
                          <xsl:text> as found in </xsl:text>
                          <xsl:value-of select="@type"/>
                          <xsl:text> track</xsl:text>
                          <xsl:if test="@typeorder">
                            <xsl:text> #</xsl:text>
                            <xsl:value-of select="@typeorder"/>
                          </xsl:if>
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>Unrecognized format</xsl:text>
                        <xsl:if test="@type!='General'">
                          <xsl:text> as found in </xsl:text>
                          <xsl:value-of select="@type"/>
                          <xsl:text> track</xsl:text>
                          <xsl:if test="@typeorder">
                            <xsl:text> #</xsl:text>
                            <xsl:value-of select="@typeorder"/>
                          </xsl:if>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </media>
      </xsl:for-each>
    </MediaConch>
  </xsl:template>
  <xsl:variable name="digit" select="'0123456789'"/>
  <xsl:variable name="period" select="'.'"/>
  <xsl:variable name="comma" select="','"/>
  <xsl:variable name="decimal" select="concat($digit, $period, $comma)"/>
  <xsl:template name="element_has_valid_parent">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:variable name="GlobalElements">
      <xsl:text>Void CRC-32</xsl:text>
    </xsl:variable>
    <xsl:variable name="ElementListWIthParents">
      <xsl:for-each select="$lookupschema//element">
        <xsl:value-of select="@name"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="@parent"/>
        <xsl:text>.</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="RecursiveElements">
      <xsl:for-each select="$lookupschema//element[@recursive='true']">
        <xsl:text>,</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>.</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ParentElement">
            <xsl:value-of select="../@n"/>
          </xsl:variable>
          <xsl:variable name="allowedParentElement">
            <xsl:value-of select="substring-before(substring-after($ElementListWIthParents,concat('.',$ElementName,',')),'.')"/>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="not(contains($GlobalElements,$ElementName))">
            <xsl:choose>
              <xsl:when test="$allowedParentElement=$ParentElement or ( contains($RecursiveElements,concat(',',$ElementName,'.')) and $ElementName = $ParentElement )">
                <test>
                  <xsl:attribute name="outcome">pass</xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:when>
              <xsl:otherwise>
                <test>
                  <xsl:attribute name="outcome">fail</xsl:attribute>
                  <xsl:attribute name="reason">
                    <xsl:value-of select="$ParentElement"/>
                    <xsl:text> is not a valid Parent Element of </xsl:text>
                    <xsl:value-of select="$ElementName"/>
                    <xsl:if test="string-length($allowedParentElement)&gt;0">
                      <xsl:text>. The valid Parent Element is </xsl:text>
                      <xsl:value-of select="$allowedParentElement"/>
                    </xsl:if>
                    <xsl:text>.</xsl:text>
                  </xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="element_does_not_repeat_in_parent">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:variable name="NonRepeatingElements">
      <xsl:text>  </xsl:text>
      <xsl:for-each select="$lookupschema//element[@maxOccurs!='unbounded' or not(@maxOccurs)]">
        <!-- needs a correction is maxOccurs may be something other than 'unbounded' -->
        <xsl:value-of select="@name"/>
        <xsl:text>  </xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ParentElement">
            <xsl:value-of select="../@n"/>
          </xsl:variable>
          <xsl:variable name="SiblingNames">
            <xsl:for-each select="../mmt:b[@n!='Header']">
              <xsl:value-of select="@n"/>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="contains($NonRepeatingElements,concat(' ',$ElementName,' '))">
            <xsl:choose>
              <xsl:when test="not(contains(concat(' ',substring-after($SiblingNames,concat(' ',$ElementName,' '))),concat(' ',$ElementName,' ')))">
                <test>
                  <xsl:attribute name="outcome">pass</xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:when>
              <xsl:otherwise>
                <test>
                  <xsl:attribute name="outcome">fail</xsl:attribute>
                  <xsl:attribute name="reason">
                    <xsl:value-of select="$ElementName"/>
                    <xsl:text> occurs more times than allowed within </xsl:text>
                    <xsl:value-of select="$ParentElement"/>
                  </xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="element_contains_mandates">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:variable name="ElementsWithMandatoryChildrenWithoutDefaults">
      <xsl:text> </xsl:text>
      <xsl:for-each select="$lookupschema//element[not(@default)][@minOccurs>0]">
        <xsl:value-of select="@parent"/>
        <xsl:text>=</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>;</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="ElementsThatContainMandates">
      <xsl:text> </xsl:text>
      <xsl:for-each select="$lookupschema//element[not(@default)][@minOccurs>0]">
        <xsl:value-of select="@parent"/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ElementSize">
            <xsl:value-of select="mmt:b[@n='Header']/mmt:d[@n='Size']"/>
          </xsl:variable>
          <xsl:if test="contains($ElementsThatContainMandates,$ElementName)">
            <xsl:variable name="CurrentElementChildren">
              <xsl:for-each select="mmt:b[@n!='Header']">
                <xsl:value-of select="@n"/>
                <xsl:text> </xsl:text>
              </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="mandatoryChildrenVINT">
              <xsl:for-each select="str:tokenize($ElementsWithMandatoryChildrenWithoutDefaults, ';')">
                <xsl:variable name="parent" select="substring-before(.,'=')"/>
                <xsl:variable name="name" select="substring-after(.,'=')"/>
                <xsl:if test="$parent=$ElementName">
                  <xsl:value-of select="$name"/>
                  <xsl:text> </xsl:text>
                </xsl:if>
              </xsl:for-each>
              <xsl:value-of select="substring-before(substring-after($ElementsWithMandatoryChildrenWithoutDefaults,concat($ElementName,':')),';')"/>
            </xsl:variable>
            <xsl:variable name="offset">
              <xsl:value-of select="@o"/>
            </xsl:variable>
            <xsl:variable name="values">
              <xsl:call-template name="EBMLElementValue">
                <xsl:with-param name="ElementName" select="$ElementName"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:if test="$ElementSize &lt; 2">
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:value-of select="$ElementName"/>
                  <xsl:text> MUST contain mandates but has an ElementSize of </xsl:text>
                  <xsl:value-of select="$ElementSize"/>
                  <xsl:text>.</xsl:text>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:if>
            <xsl:for-each select="str:tokenize($mandatoryChildrenVINT)">
              <xsl:choose>
                <xsl:when test="contains($CurrentElementChildren,.)">
                  <test>
                    <xsl:attribute name="outcome">pass</xsl:attribute>
                    <xsl:attribute name="reason">
                      <xsl:value-of select="."/>
                      <xsl:text> is present within </xsl:text>
                      <xsl:value-of select="$ElementName"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$values"/>
                  </test>
                </xsl:when>
                <xsl:otherwise>
                  <test>
                    <xsl:attribute name="outcome">fail</xsl:attribute>
                    <xsl:attribute name="reason">
                      <xsl:value-of select="."/>
                      <xsl:text> MUST be a Child Element of </xsl:text>
                      <xsl:value-of select="$ElementName"/>
                      <xsl:text> but is not present.</xsl:text>
                    </xsl:attribute>
                    <xsl:copy-of select="$values"/>
                  </test>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:if>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="element_at_correct_size">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:variable name="ElementsWithSizeRestrictions">
      <xsl:text>;</xsl:text>
      <xsl:for-each select="$lookupschema//element">
        <xsl:choose>
          <xsl:when test="@size">
            <xsl:value-of select="@name"/>
            <xsl:text>=</xsl:text>
            <xsl:value-of select="@size"/>
            <xsl:text>;</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="ElementsWithTypes">
      <xsl:text>;</xsl:text>
      <xsl:for-each select="$lookupschema//element">
        <xsl:value-of select="@name"/>
        <xsl:text>=</xsl:text>
        <xsl:value-of select="@type"/>
        <xsl:text>;</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="type">
            <xsl:value-of select="substring-before(substring-after($ElementsWithTypes,concat(';',$ElementName,'=')),';')"/>
          </xsl:variable>
          <xsl:if test="contains($ElementsWithSizeRestrictions,concat(';',$ElementName,'=')) or $type='uinteger' or $type='integer' or $type='float'">
            <xsl:variable name="ElementSize">
              <xsl:value-of select="mmt:b[@n='Header']/mmt:d[@n='Size']"/>
            </xsl:variable>
            <xsl:variable name="allowedElementSize">
              <xsl:value-of select="substring-before(substring-after($ElementsWithSizeRestrictions,concat(';',$ElementName,'=')),';')"/>
            </xsl:variable>
            <xsl:variable name="values">
              <xsl:call-template name="EBMLElementValue">
                <xsl:with-param name="ElementName" select="$ElementName"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$allowedElementSize=$ElementSize">
                <test>
                  <xsl:attribute name="outcome">pass</xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:when>
              <xsl:when test="$type='uinteger' or $type='integer'">
                <xsl:choose>
                  <xsl:when test="$ElementSize >= 0 and $ElementSize &lt;= 8">
                    <test>
                      <xsl:attribute name="outcome">pass</xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:when>
                  <xsl:otherwise>
                    <test>
                      <xsl:attribute name="outcome">fail</xsl:attribute>
                      <xsl:attribute name="reason">
                        <xsl:value-of select="$ElementName"/>
                        <xsl:text> is a </xsl:text>
                        <xsl:value-of select="$type"/>
                        <xsl:text> and does not have a valid Element Size of 0-8 octets but is instead using </xsl:text>
                        <xsl:value-of select="$ElementSize"/>
                        <xsl:text> octets.</xsl:text>
                      </xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$type='float'">
                <xsl:choose>
                  <xsl:when test="$ElementSize = 0 or $ElementSize = 4 or $ElementSize = 8">
                    <test>
                      <xsl:attribute name="outcome">pass</xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:when>
                  <xsl:otherwise>
                    <test>
                      <xsl:attribute name="outcome">fail</xsl:attribute>
                      <xsl:attribute name="reason">
                        <xsl:value-of select="$ElementName"/>
                        <xsl:text> is a </xsl:text>
                        <xsl:value-of select="$type"/>
                        <xsl:text> and does not have a valid Element Size of 0, 4, or 8 octets but is instead using </xsl:text>
                        <xsl:value-of select="$ElementSize"/>
                        <xsl:text> octets.</xsl:text>
                      </xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$type='date'">
                <xsl:choose>
                  <xsl:when test="$ElementSize = 0 or $ElementSize = 8">
                    <test>
                      <xsl:attribute name="outcome">pass</xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:when>
                  <xsl:otherwise>
                    <test>
                      <xsl:attribute name="outcome">fail</xsl:attribute>
                      <xsl:attribute name="reason">
                        <xsl:value-of select="$ElementName"/>
                        <xsl:text> is a </xsl:text>
                        <xsl:value-of select="$type"/>
                        <xsl:text> and does not have a valid Element Size of 0 or 8 octets but is instead using </xsl:text>
                        <xsl:value-of select="$ElementSize"/>
                        <xsl:text> octets.</xsl:text>
                      </xsl:attribute>
                      <xsl:copy-of select="$values"/>
                    </test>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <test>
                  <xsl:attribute name="outcome">fail</xsl:attribute>
                  <xsl:attribute name="reason">
                    <xsl:value-of select="$ElementName"/>
                    <xsl:text> is not a valid Element Size of </xsl:text>
                    <xsl:value-of select="$allowedElementSize"/>
                    <xsl:text> octets but is instead using </xsl:text>
                    <xsl:value-of select="$ElementSize"/>
                    <xsl:text> octets.</xsl:text>
                  </xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
  <xsl:template name="element_is_less_than_or_equal_to_x">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:param name="x"/>
    <xsl:param name="x_name"/>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="context">
        <context>
          <xsl:attribute name="name">
            <xsl:value-of select="$x_name"/>
          </xsl:attribute>
          <xsl:value-of select="$x"/>
        </context>
      </xsl:with-param>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ElementValue">
            <xsl:value-of select="mmt:d"/>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$ElementValue &lt;= $x">
              <test>
                <xsl:attribute name="outcome">pass</xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:when>
            <xsl:otherwise>
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:value-of select="$ElementName"/>
                  <xsl:text> (</xsl:text>
                  <xsl:value-of select="$ElementValue"/>
                  <xsl:text>) is not less than or equal to the </xsl:text>
                  <xsl:value-of select="$x_name"/>
                  <xsl:text> (</xsl:text>
                  <xsl:value-of select="$x"/>
                  <xsl:text>)</xsl:text>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="element_is_x">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:param name="x"/>
    <xsl:param name="x_name"/>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="context">
        <context>
          <xsl:attribute name="name">
            <xsl:value-of select="$x_name"/>
          </xsl:attribute>
          <xsl:value-of select="$x"/>
        </context>
      </xsl:with-param>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$x = $ElementName">
              <test>
                <xsl:attribute name="outcome">pass</xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:when>
            <xsl:otherwise>
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:value-of select="$x_name"/>
                  <xsl:text> is set to </xsl:text>
                  <xsl:value-of select="$ElementName"/>
                  <xsl:text> but is required to be </xsl:text>
                  <xsl:value-of select="$x"/>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="element_is_first_child">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ParentElement">
            <xsl:value-of select="../@n"/>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="count(preceding-sibling::mmt:b[mmt:b[@n='Header']]) = '0'">
              <test>
                <xsl:attribute name="outcome">pass</xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:when>
            <xsl:otherwise>
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:value-of select="$ElementName"/>
                  <xsl:text> is used but not as the first element. It is Child Element number </xsl:text>
                  <xsl:value-of select="count(preceding-sibling::mmt:b[mmt:b[@n='Header']]) + 1"/>
                  <xsl:text> of </xsl:text>
                  <xsl:value-of select="count(../mmt:b[mmt:b[@n='Header']])"/>
                  <xsl:text> Child Elements under </xsl:text>
                  <xsl:value-of select="$ParentElement"/>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="seek_element_resolves">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="seek_element"/>
    <xsl:variable name="FirstSegmentValueOffset">
      <xsl:value-of select="mmt:MicroMediaTrace/mmt:b[@n='Segment']/@o + mmt:MicroMediaTrace/mmt:b[@n='Segment']/mmt:b[@n='Header']/@s"/>
    </xsl:variable>
    <xsl:variable name="context">
      <context>
        <xsl:attribute name="name">
          <xsl:text>Offset of First Segment Element</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="$FirstSegmentValueOffset"/>
      </context>
    </xsl:variable>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="context" select="$context"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$seek_element">
          <xsl:variable name="SeekID">
            <xsl:call-template name="DecToVINT">
              <xsl:with-param name="dec" select="mmt:d[@n='Data']"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="lookupElementNameFromID">
            <xsl:value-of select="substring-before(substring-after($ElementListWIthIDs,concat('.',$SeekID,',')),'.')"/>
          </xsl:variable>
          <xsl:variable name="SeekPosition" select="../mmt:b[@n='SeekPosition']/mmt:d[@n='Data']"/>
          <xsl:variable name="SeekPositionFileOffset" select="$FirstSegmentValueOffset + $SeekPosition"/>
          <xsl:variable name="ElementIDatOffset">
            <xsl:call-template name="DecToVINT">
              <xsl:with-param name="dec" select="../../../mmt:b[@o=format-number($SeekPositionFileOffset, '#')]/mmt:b[@n='Header']/mmt:d[@n='Name']"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$SeekID"/>
            </xsl:call-template>
            <xsl:for-each select="../mmt:b[@n='SeekPosition']">
              <xsl:call-template name="EBMLElementValue">
                <xsl:with-param name="ElementName" select="../mmt:b[@n='SeekPosition']"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:variable>
          <!-- $ElementIDatOffset = '0x80' means that there is no block in mediatrace at that offset. If that and the id is Cluster, SeekHead, or Cues, then skip the test. Later this can be expanded if the mediatrace coverage is higher. -->
          <xsl:if test="not ($ElementIDatOffset = '0x80')">
            <xsl:choose>
              <xsl:when test="$SeekID = $ElementIDatOffset">
                <test>
                  <xsl:attribute name="outcome">pass</xsl:attribute>
                  <xsl:attribute name="reason">
                    <xsl:text>The Seek ID references an Element (</xsl:text>
                    <xsl:value-of select="$SeekID"/>
                    <xsl:text>) which is stored at that location. Note: this test currently does not test Seek references to Clusters.</xsl:text>
                  </xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:when>
              <xsl:otherwise>
                <test>
                  <xsl:attribute name="outcome">fail</xsl:attribute>
                  <xsl:attribute name="reason">
                    <xsl:text>The Seek Element at </xsl:text>
                    <xsl:value-of select="@o"/>
                    <xsl:text> octets references an Element with </xsl:text>
                    <xsl:value-of select="$SeekID"/>
                    <xsl:text> as an ID and a Seek Position of </xsl:text>
                    <xsl:value-of select="$SeekPosition"/>
                    <xsl:text> but it is not there.</xsl:text>
                  </xsl:attribute>
                  <xsl:copy-of select="$values"/>
                </test>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="child_data_info_is_ok">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="element"/>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="ParentElement">
            <xsl:value-of select="../@n"/>
          </xsl:variable>
          <xsl:variable name="info">
            <xsl:value-of select="@i"/>
          </xsl:variable>
          <xsl:variable name="CRCValue">
            <xsl:call-template name="DecToVINT">
              <xsl:with-param name="dec" select="."/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:for-each select="parent::mmt:b">
              <xsl:call-template name="EBMLElementValue">
                <xsl:with-param name="ElementName" select="$ElementName"/>
              </xsl:call-template>
            </xsl:for-each>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$info != 'NOK'">
              <test>
                <xsl:attribute name="outcome">pass</xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:when>
            <xsl:otherwise>
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:text>A crc evaluation gives a result of </xsl:text>
                  <xsl:value-of select="$info"/>
                  <xsl:text>.</xsl:text>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="x_is_in_list">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="x"/>
    <xsl:param name="list"/>
    <xsl:variable name="context">
      <context>
        <xsl:attribute name="name">
          <xsl:text>Valid Values</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="$list"/>
      </context>
    </xsl:variable>
    <xsl:variable name="tests">
      <xsl:for-each select="$x">
        <xsl:variable name="xValue">
          <xsl:value-of select="mmt:d[1]"/>
        </xsl:variable>
        <xsl:variable name="xVINT">
          <xsl:call-template name="DecToVINT">
            <xsl:with-param name="dec" select="mmt:b[@n='Header']/mmt:d[@n='Name']"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="values">
          <xsl:call-template name="EBMLElementValue">
            <xsl:with-param name="ElementName" select="$xVINT"/>
          </xsl:call-template>
          <value>
            <xsl:attribute name="offset">
              <xsl:value-of select="@o"/>
            </xsl:attribute>
            <xsl:attribute name="name">
              <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:value-of select="$xValue"/>
          </value>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="contains($list,$xValue)">
            <test>
              <xsl:attribute name="outcome">pass</xsl:attribute>
              <xsl:copy-of select="$values"/>
            </test>
          </xsl:when>
          <xsl:otherwise>
            <test>
              <xsl:attribute name="outcome">fail</xsl:attribute>
              <xsl:attribute name="reason">
                <xsl:text>The value of </xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text> is not a valid value (</xsl:text>
                <xsl:value-of select="$list"/>
                <xsl:text>).</xsl:text>
              </xsl:attribute>
              <xsl:copy-of select="$values"/>
            </test>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$tests != ''">
      <xsl:call-template name="check">
        <xsl:with-param name="icid" select="$icid"/>
        <xsl:with-param name="version" select="$version"/>
        <xsl:with-param name="context" select="$context"/>
        <xsl:with-param name="test" select="$tests"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="data_is_in_list">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="x"/>
    <xsl:param name="list"/>
    <xsl:variable name="context">
      <context>
        <xsl:attribute name="name">
          <xsl:text>Valid Values</xsl:text>
        </xsl:attribute>
        <xsl:value-of select="$list"/>
      </context>
    </xsl:variable>
    <xsl:variable name="tests">
      <xsl:for-each select="$x">
        <xsl:variable name="values">
          <value>
            <xsl:attribute name="offset">
              <xsl:value-of select="@o"/>
            </xsl:attribute>
            <xsl:attribute name="name">
              <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </value>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="contains($list,.)">
            <test>
              <xsl:attribute name="outcome">pass</xsl:attribute>
              <xsl:copy-of select="$values"/>
            </test>
          </xsl:when>
          <xsl:otherwise>
            <test>
              <xsl:attribute name="outcome">fail</xsl:attribute>
              <xsl:attribute name="reason">
                <xsl:text>The value of </xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text> is not a valid value (</xsl:text>
                <xsl:value-of select="$list"/>
                <xsl:text>).</xsl:text>
              </xsl:attribute>
              <xsl:copy-of select="$values"/>
            </test>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$tests != ''">
      <xsl:call-template name="check">
        <xsl:with-param name="icid" select="$icid"/>
        <xsl:with-param name="version" select="$version"/>
        <xsl:with-param name="context" select="$context"/>
        <xsl:with-param name="test" select="$tests"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="DecToHex">
    <xsl:param name="dec"/>
    <xsl:if test="$dec &gt; 0">
      <xsl:call-template name="DecToHex">
        <xsl:with-param name="dec" select="format-number(floor($dec div 16),'#')"/>
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="$dec mod 16 &lt; 10">
          <xsl:value-of select="format-number(format-number($dec,'#') mod 16,'#')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$dec mod 16 = 10">A</xsl:when>
            <xsl:when test="$dec mod 16 = 11">B</xsl:when>
            <xsl:when test="$dec mod 16 = 12">C</xsl:when>
            <xsl:when test="$dec mod 16 = 13">D</xsl:when>
            <xsl:when test="$dec mod 16 = 14">E</xsl:when>
            <xsl:when test="$dec mod 16 = 15">F</xsl:when>
            <xsl:otherwise>A</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="DecToVINT">
    <xsl:param name="dec"/>
    <xsl:variable name="hex">
      <xsl:call-template name="DecToHex">
        <xsl:with-param name="dec" select="$dec"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:text>0x</xsl:text>
    <xsl:choose>
      <xsl:when test="string-length($hex) = 7">
        <xsl:text>1</xsl:text>
        <xsl:value-of select="$hex"/>
      </xsl:when>
      <xsl:when test="string-length($hex) = 6">
        <xsl:choose>
          <xsl:when test="starts-with($hex, '1')">
            <xsl:text>3</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>10</xsl:text>
            <xsl:value-of select="$hex"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="string-length($hex) = 5">
        <xsl:text>2</xsl:text>
        <xsl:value-of select="$hex"/>
      </xsl:when>
      <xsl:when test="string-length($hex) = 4">
        <xsl:choose>
          <xsl:when test="starts-with($hex, '1')">
            <xsl:text>5</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '2')">
            <xsl:text>6</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '3')">
            <xsl:text>7</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>20</xsl:text>
            <xsl:value-of select="$hex"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="string-length($hex) = 3">
        <xsl:text>4</xsl:text>
        <xsl:value-of select="$hex"/>
      </xsl:when>
      <xsl:when test="string-length($hex) = 2">
        <xsl:choose>
          <xsl:when test="starts-with($hex, '1')">
            <xsl:text>9</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '2')">
            <xsl:text>A</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '3')">
            <xsl:text>B</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '4')">
            <xsl:text>C</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '5')">
            <xsl:text>D</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '6')">
            <xsl:text>E</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:when test="starts-with($hex, '7')">
            <xsl:text>F</xsl:text>
            <xsl:value-of select="substring($hex, 2, string-length($hex)-1)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>40</xsl:text>
            <xsl:value-of select="$hex"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="string-length($hex) = 1">
        <xsl:text>8</xsl:text>
        <xsl:value-of select="$hex"/>
      </xsl:when>
      <xsl:when test="string-length($hex) = 0">
        <xsl:text>80</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$hex"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="tag_is_number">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="tagname"/>
    <xsl:param name="element"/>
    <xsl:call-template name="check">
      <xsl:with-param name="icid" select="$icid"/>
      <xsl:with-param name="version" select="$version"/>
      <xsl:with-param name="test">
        <xsl:for-each select="$element">
          <xsl:variable name="ElementName">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:variable name="values">
            <xsl:call-template name="EBMLElementValue">
              <xsl:with-param name="ElementName" select="$ElementName"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="string-length(translate(mmt:d,$decimal,'')) = 0">
              <test>
                <xsl:attribute name="outcome">pass</xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:when>
            <xsl:otherwise>
              <test>
                <xsl:attribute name="outcome">fail</xsl:attribute>
                <xsl:attribute name="reason">
                  <xsl:value-of select="$ElementName"/>
                  <xsl:text> (</xsl:text>
                  <xsl:value-of select="$tagname"/>
                  <xsl:text>) contains non-numeric values</xsl:text>
                </xsl:attribute>
                <xsl:copy-of select="$values"/>
              </test>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="replace">
    <xsl:param name="text"/>
    <xsl:param name="search"/>
    <xsl:param name="replace"/>
    <xsl:choose>
      <xsl:when test="contains($text, $search)">
        <xsl:variable name="replace-next">
          <xsl:call-template name="replace">
            <xsl:with-param name="text" select="substring-after($text, $search)"/>
            <xsl:with-param name="search" select="$search"/>
            <xsl:with-param name="replace" select="$replace"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="                         concat(                             substring-before($text, $search)                         ,   $replace                         ,   $replace-next                         )                     "/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="EBMLElementValue">
    <xsl:param name="ElementName"/>
    <xsl:param name="offset"/>
    <xsl:param name="name"/>
    <value>
      <xsl:attribute name="name">
        <xsl:choose>
          <xsl:when test="$name">
            <xsl:value-of select="$name"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@n"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="offset">
        <xsl:choose>
          <xsl:when test="$name">
            <xsl:value-of select="$offset"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@o"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="context">
        <xsl:for-each select="ancestor-or-self::mmt:b">
          <xsl:variable name="elementname">
            <xsl:value-of select="@n"/>
          </xsl:variable>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@n"/>
          <xsl:text>[</xsl:text>
          <xsl:value-of select="count(preceding-sibling::mmt:b[@n=$elementname])+1"/>
          <xsl:text>]</xsl:text>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:if test="@n!='Slice'">
        <xsl:attribute name="formatid">
          <xsl:call-template name="DecToVINT">
            <xsl:with-param name="dec" select="mmt:b[@n='Header']/mmt:d[@n='Name']"/>
          </xsl:call-template>
        </xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@n='SeekID'">
          <xsl:variable name="ElementHex">
            <xsl:call-template name="DecToVINT">
              <xsl:with-param name="dec" select="format-number(mmt:d,'#')"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="lookupElementNameFromID">
            <xsl:value-of select="substring-before(substring-after($ElementListWIthIDs,concat('.',$ElementHex,',')),'.')"/>
          </xsl:variable>
          <xsl:value-of select="$ElementHex"/>
          <xsl:text> (</xsl:text>
          <xsl:value-of select="$lookupElementNameFromID"/>
          <xsl:text>)</xsl:text>
        </xsl:when>
        <xsl:when test="@n='CRC-32'">
          <xsl:text>0x</xsl:text>
          <xsl:call-template name="DecToHex">
            <xsl:with-param name="dec" select="format-number(mmt:d,'#')"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="@n='Block'">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@s"/>
          <xsl:text> bytes]</xsl:text>
        </xsl:when>
        <xsl:when test="@n='SegmentUID'">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@s"/>
          <xsl:text> bytes]</xsl:text>
        </xsl:when>
        <xsl:when test="mmt:d">
          <xsl:value-of select="mmt:d"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@s"/>
          <xsl:text> bytes]</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </value>
  </xsl:template>
  <xsl:template name="implementationChecks">
    <xsl:param name="name"/>
    <xsl:param name="checks"/>
    <implementationChecks>
      <xsl:attribute name="checks_run">
        <xsl:value-of select="count(exsl:node-set($checks)/mc:check)"/>
      </xsl:attribute>
      <xsl:attribute name="fail_count">
        <xsl:value-of select="count(exsl:node-set($checks)/mc:check[@fail_count!='0'])"/>
      </xsl:attribute>
      <xsl:attribute name="pass_count">
        <xsl:value-of select="count(exsl:node-set($checks)/mc:check[@fail_count='0'])"/>
      </xsl:attribute>
      <name>
        <xsl:value-of select="$name"/>
      </name>
      <xsl:copy-of select="$checks"/>
    </implementationChecks>
  </xsl:template>
  <xsl:template name="check">
    <xsl:param name="icid"/>
    <xsl:param name="version"/>
    <xsl:param name="context"/>
    <xsl:param name="test"/>
    <xsl:choose>
      <xsl:when test="not (2 &gt;= $verbosity and count(exsl:node-set($test)/mc:test[@outcome='fail']) = 0)">
        <!-- verbosity <= 2: only export checks with a positive fail count -->
        <xsl:if test="$test!=''">
          <check>
            <xsl:attribute name="icid">
              <xsl:value-of select="$icid"/>
            </xsl:attribute>
            <xsl:attribute name="version">
              <xsl:value-of select="$version"/>
            </xsl:attribute>
            <xsl:attribute name="tests_run">
              <xsl:value-of select="count(exsl:node-set($test)/mc:test)"/>
            </xsl:attribute>
            <xsl:attribute name="fail_count">
              <xsl:value-of select="count(exsl:node-set($test)/mc:test[@outcome='fail'])"/>
            </xsl:attribute>
            <xsl:attribute name="pass_count">
              <xsl:value-of select="count(exsl:node-set($test)/mc:test[@outcome='pass'])"/>
            </xsl:attribute>
            <xsl:copy-of select="$context"/>
            <xsl:choose>
              <xsl:when test="$verbosity &gt; 4">
                <!-- verbosity > 4: export all tests-->
                <xsl:copy-of select="exsl:node-set($test)/mc:test"/>
              </xsl:when>
              <xsl:when test="$verbosity = 4">
                <!-- verbosity = 4: export all failed tests or if none than the first pass -->
                <xsl:choose>
                  <xsl:when test="exsl:node-set($test)/mc:test[@outcome='fail']">
                    <xsl:copy-of select="exsl:node-set($test)/mc:test[@outcome='fail']"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:copy-of select="exsl:node-set($test)/mc:test[1]"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$verbosity = 3">
                <!-- verbosity = 3: export all failed tests -->
                <xsl:copy-of select="exsl:node-set($test)/mc:test[@outcome='fail']"/>
              </xsl:when>
            </xsl:choose>
          </check>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
