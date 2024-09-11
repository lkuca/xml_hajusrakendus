<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="html" indent="yes" encoding="utf-8"/>

    <xsl:template match="/">
		<h3>Autode üldkogus xml jadas</h3>
		<br></br>
		kasutame count() funktsiooni
		<br></br>
		<xsl:value-of select="count(autod/auto)"/>
		<hr></hr>
		<h3>Autode üldkogus mis on vaasta=2000</h3>
		<br></br>
		<xsl:value-of select="count(autod/auto[vaasta=2000])"/>
		<hr></hr>
		<h3>Auto regnumbrid mis algavad 2:</h3>
		<br></br>
		<h2>1.trüki välja (eralda komaga) auto registrinumbri numbrite osa</h2>
		<xsl:for-each select="autod/auto">
			<xsl:value-of select="substring(registrinumber, 1, 3)"/>, 
		</xsl:for-each>
		<hr></hr>
		<h2>2. trüki välja (eralda komaga) omaniku nime viimane täht</h2>
		<xsl:for-each select="autod/auto">
			<xsl:value-of select="substring(omanik, string-length(omanik), 1)"/>,
		</xsl:for-each>
		<hr></hr>
		<h2>3. Auto omanikud, mis sisaldavad A täht:</h2>
		<xsl:for-each select="autod/auto[contains(omanik, 'A') or contains (omanik, 'a')]">
			<xsl:value-of select="omanik"/>,
		</xsl:for-each>
		<hr></hr>
		<h2>4. Leia, mitme auto registrimärgi numberite viimasest on 2</h2>
		<xsl:for-each select="autod/auto[substring(translate(registrinumber, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', ''), string-length(translate(registrinumber, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ', '')), 1) = '2']">
			<li>
				<xsl:value-of select="registrinumber"/>
			</li>
		</xsl:for-each>
		<hr></hr>
		<h2>Dotskin ülesanne 1</h2>
		<table border="1">
			<tr>
				<th>Reg numer (reversed)</th>
				<th>Mark</th>
				<th>Väljastamise aasta</th>
				<th>Omanik</th>
			</tr>
			<xsl:for-each select="autod/auto[vaasta >= 2010]">
				<tr>
					<td>
						<xsl:call-template name="reverse">
							<xsl:with-param name="text" select="registrinumber"/>
						</xsl:call-template>
					</td>
					<td>
						<xsl:value-of select="mark"/>
					</td>
					<td>
						<xsl:value-of select="vaasta"/>
					</td>
					<td>
						<xsl:value-of select="omanik"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<hr></hr>
		<h2>Dotskin ülesanne 2</h2>
		<table border="1">
			<tr>
				<th>Reg Number</th>
				<th>Märk</th>
				<th>Väljastamise aasta</th>
				<th>Omanik</th>
				<th>Sellise marki autode arv</th>
			</tr>
			<xsl:for-each select="autod/auto">
				<tr>
					<td>
						<xsl:value-of select="registrinumber"/>
					</td>
					<td>
						<xsl:value-of select="mark"/>
					</td>
					<td>
						<xsl:value-of select="vaasta"/>
					</td>
					<td>
						<xsl:value-of select="omanik"/>
					</td>
					<td>
						<xsl:value-of select="count(../auto[mark = current()/mark])"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		<hr></hr>
		Kasutame starts-with funktsiooni
		<ul>
		<xsl:for-each select="autod/auto[starts-with(registrinumber, 2)]">
			<xsl:sort select="vaasta" order="descending"/>
			<li>
				<xsl:value-of select="concat(mark, ',',registrinumber, ',',vaasta)"/>
			</li>
		</xsl:for-each>
		</ul>
		
		
		<h2>Autod tabelina</h2>
		
		<table border-collapse="1">
			<tr>
				<th>Reg numer</th>
				<th>Mark</th>
				<th>väljastamise aasta</th>
				<th>Omanik</th>
				<th>Ülevatuse kuu</th>
				<xsl:for-each select="autod/auto">
					<tr>
						<td>
							<xsl:value-of select="registrinumber"/>
						</td>
						<td>
							<xsl:value-of select="mark"/>
						</td>
						<td>
							<xsl:value-of select="vaasta"/>
						</td>
						<xsl:if test="contains(omanik, 'a')">
							<td bgcolor="yellow">
								<xsl:value-of select="omanik"/>
							</td>
						</xsl:if>

						<xsl:if test="not(contains(omanik, 'a'))">
							<td>
								<xsl:value-of select="omanik"/>
							</td>
						</xsl:if>
						
						<xsl:if test="number(substring(registrinumber, 3,1)+2)>=9">
							<td bgcolor="red">
								<xsl:value-of select="substring(registrinumber, 3,1)+2"/>
							</td>
						</xsl:if>
						<xsl:if test="number(substring(registrinumber, 3,1)+2) &lt; 9">
							<td bgcolor="green">
								<xsl:value-of select="substring(registrinumber, 3, 1)+2"/>
							</td>
						</xsl:if>
						</tr>
				</xsl:for-each>
			</tr>
		</table>
    </xsl:template>
	<xsl:template name="reverse">
		<xsl:param name="text"/>
		<xsl:choose>
			<xsl:when test="string-length($text) > 0">
			
				<xsl:value-of select="substring($text, string-length($text), 1)"/>
				<xsl:call-template name="reverse">
					<xsl:with-param name="text" select="substring($text, 1, string-length($text) - 1)"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
