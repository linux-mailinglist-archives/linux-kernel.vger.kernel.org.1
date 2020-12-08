Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9BB2D30CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgLHRTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:18:59 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C33C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:18:19 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Cr6MX48Lnz8v7b;
        Tue,  8 Dec 2020 18:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607447896; bh=nGL1H2DC0k+G9oqH0k5fF50qkeoY7q+qbbnHqBDBPRg=;
        h=Subject:References:To:Cc:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=IlDn34bBwHCrumsGXdeOaIhIAbipiytZHARmYbaijw9IcO3hM3LBga1A59CWnxTUx
         NEwaEMSadOD+Mj5bFVEAkhRV6qlR2WuY53Ibe0FuMPwENCh5W3fuhhOR70TiFGTFg7
         bF7o3GGcSBOZsVNcJ+KRjlhgvHooJieEn4Tq4tiGRFTd/vVmvWAkz5fjm06H5I9YLX
         7+v9qy1Ap/0AzeUDdk1D9usAmPZiDe5SB7RFsiohdPx3b3fJGHLs7l7lC5JK32tyJ8
         LDqX1+6H5cmoob6n/wFLbbEjtSgYRQkzVU0XXzk3pvt3tznE5nfiscuQYCyqfXBAkS
         EaBBIChfANedA==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1245
Received: from [IPv6:2a02:810d:8080:2d9f::1245] (unknown [IPv6:2a02:810d:8080:2d9f::1245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19ytk193ENKz99m0O62xD9gaood015NZC0=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Cr6MT6YGFz8ssD;
        Tue,  8 Dec 2020 18:18:13 +0100 (CET)
Subject: [RFC PATCH v2] checkpatch: rewrite Kconfig parsing
References: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
From:   Nicolai Fischer <nicolai.fischer@fau.de>
X-Forwarded-Message-Id: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
Message-ID: <97fb4ba0-68b3-8faf-1d98-e4990b2e63e3@fau.de>
Date:   Tue, 8 Dec 2020 18:18:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a07d684c-37ea-b589-c4b1-489e88b5caa5@fau.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch currently only warns if the help text is too short.
To determine this the diff gets parsed for keywords starting
a new entry, but several kinds of false positives can occur with
the current implementation, especially when the config
is not well formatted.

This patch makes the parsing more robust and includes
new warnings if:
1) the help attribute is not specified last
2) there is no blank line or endif before the next keyword
3) the help text is not indented 2 spaces more than
   the attribute itself.

Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
---

This patch rewrites most of the Kconfig parsing to address
the issues mentioned in the first RFC:

1) search for 'help' instead of '---help---'
> I believe all the '---help---' lines have been converted to just 'help'
> so the '(?:---)?' bits here could be removed

2) create new warnings:
> Perhaps it'd be better to create a new warning when the help text
> block is not the last block of the config section.  Maybe warn when
> a blank line or endif is not the separator to the next keyword.
> Maybe warn when the next line after help is not indented 2 more
> spaces than the help line.

3) fix handling of blank lines and rely on keywords for end of help text
> This doesn't allow blank lines for multi-paragraph help text either.
> 
> I think keyword parsing is necessary and some false positives are
> inevitable as the parsing logic in a line-by-line analyzer will
> always be incomplete.


It has occurred to us, that kconfig-language.rst does not explicitly
specify that the help text should be the last attribute, although
this is the defacto convention. Now that checkpatch actively checks
for this, we should probably update the documentation accordingly.


 scripts/checkpatch.pl | 95 +++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..52b3fd0c4581 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3299,7 +3299,11 @@ sub process {
 				      "Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.\n" . $herevet)
 		}
 
-# check for Kconfig help text having a real description
+# Check if Kconfig is well formatted. Warn if help text:
+# 1) is shorter than $min_conf_desc_length lines
+# 2) is not specified last
+# 3) and next keyword are not separated by a blank line or endif
+# 4) is not indented correctly
 # Only applies when adding the entry originally, after that we do not have
 # sufficient context to determine whether it is indeed long enough.
 		if ($realfile =~ /Kconfig/ &&
@@ -3308,46 +3312,83 @@ sub process {
 		    # (\b) rather than a whitespace character (\s)
 		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
 			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
 			my $is_start = 0;
 			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+			my $valid_end = 0;
+			my $wrong_indent = 0;
+			my $help_last = 1;
 
-				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+			my $cnt = $realcnt;
+			my $help_indent;
+			my $last_blank = 0;
+			for (my $ln = $linenr; $cnt > 0 && defined $lines[$ln]; $ln++) {
+				my $line = $lines[$ln];
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+				next if ($line =~ /^-/);
+				last if (!$file && $line =~ /^\@\@/);
+				$cnt--;
+				$line =~ s/^\+//;
+
+				if ($line =~ /^\s*(?:bool|tristate|string|hex|int|prompt)\s*["']/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				} elsif ($line =~ /^(\s*)help$/) {
+					$help_indent = $1;
+					$length = 0;
+					next;
 				}
+				next if ($line =~ /^#.*$/);
+				next if (!defined $help_indent);
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
-
-				# This only checks context lines in the patch
-				# and so hopefully shouldn't trigger false
-				# positives, even though some of these are
-				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
+				if ($line =~ /^\s*$/) {
+					$last_blank = 1;
+					next;
+				}
+				my $l = $line;
+				$l =~ s/^$help_indent//;
+				if ($l =~ /^(?:bool|tristate|string|hex|int|prompt|default|
+					depends\ on|select|imply|visible\ if|range|option)\b/x) {
+					$help_last = 0;
+				} elsif ($line =~/^\s*endif\s*(?:#.*)?$/) {
+					# line contains only endif keyword and optional comment
+					# help text is terminated properly
 					$is_end = 1;
+					$valid_end = 1;
 					last;
+				} elsif ($line =~ /^\s*(?:config|menuconfig|choice|endchoice|
+					comment|if|menu|endmenu|source)\b/x) {
+					# match all keywords except endif
+					$is_end = 1;
+					if ($last_blank) {
+						# This generates a false positive if a blank line is followed by an
+						# 'if' on the next line. But that would probably not be a well formatted text.
+						$valid_end = 1;
+						last;
+					}
+				}
+				if ($l !~ /^\ {2}/) {
+					$wrong_indent = 1;
 				}
+				$last_blank = 0;
 				$length++;
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($is_start && $is_end && !$valid_end) {
+				WARN("CONFIG_DESCRIPTION",
+					"help text is not followed by a blank line or endif\n" . $herecurr);
+			}
+			if ($is_start && $valid_end && $length < $min_conf_desc_length) {
+				WARN("CONFIG_DESCRIPTION",
+				     "help text is too short ($length/$min_conf_desc_length lines)\n" . $herecurr);
+			}
+			if ($is_start && $valid_end && $help_last && $wrong_indent) {
+				WARN("CONFIG_DESCRIPTION",
+					"help text is not indented 2 spaces more than the help keyword\n" . $herecurr);
+			}
+			if ($is_start && !$help_last) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+					"help text is not the last attribute\n" . $herecurr);
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
+			#print "is_start<$is_start> is_end<$is_end> valid_end <$valid_end>";
+			#print "help_last <$help_last> length<$length>\n";
 		}
 
 # check MAINTAINERS entries
-- 
2.28.0

