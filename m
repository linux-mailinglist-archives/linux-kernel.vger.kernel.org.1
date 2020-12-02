Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30BB2CC54E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLBShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbgLBShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:37:04 -0500
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Dec 2020 10:36:24 PST
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:36:24 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CmSBT4jHSz8tCX;
        Wed,  2 Dec 2020 19:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1606933665; bh=FduM7RXkc4VPK3lBUYzuzk6VCBKBhnLizNuQoArlROs=;
        h=Cc:From:Subject:To:Date:From:To:CC:Subject;
        b=kH2PmIrn9nDeZ07ylXoFPmAGaM+NFQLxpGRWlaJxzdOkqmTu/+NwxRdt+VTDvfSP+
         mEYXh9MIQVXK77p0m+fMRwAyHR4C0LI2dw+87dDUd48cj/maRqt5brmB0eeh8BekB8
         bBZqkg2q98gzLFQ/Usng530REJYcJHmXKFgQmC7eyrw534IMUkLibmyvljpAONX9oP
         NvTqvpbG8m01hUyq6dsEczvcp39eIlxlnz/cDRqxP2S6xZ6wNmE8ZtHqCQ+J8HIvoL
         49GbbsQdkJdYk8s8+nGLyvSv+OEhuWPz3sTuQ2KGBMXd5YH5I/1pKWyoxnh0/QMPjQ
         4oSU6eueaM5hg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+OglfbQ7BMP/Z4bgV6k88XsnCe5DcEHbc=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CmSBR2Sbbz8sXS;
        Wed,  2 Dec 2020 19:27:43 +0100 (CET)
Cc:     apw@canonical.com, joe@perches.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Subject: [RFC PATCH] checkpatch: correctly detect lines of help text
To:     linux-kernel@vger.kernel.org
Message-ID: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
Date:   Wed, 2 Dec 2020 19:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch uses keywords to determine the end
of a Kconfig help message which leads to false positives:

1) if a line of the help text starts with any of the keywords, e.g. if:

+config FOO
+	help
+	  help text
+	  if condition
+	  previous line causes warning
+	  last line.

2) if the help attribute is not specified last, checkpatch counts
other attributes like depends on towards the line count:

+config FOO
+	help
+	bool "no help message, but passes checkpatch"
+	default n
+	depends on SYSFS
+	depends on MULTIUSER

This patch fixes this behavior by using the indentation to determine
the end of the help message.

Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
---


The code responsible for counting the lines of the help message
seems overly complicated and we could rewrite it entirely
in order to be more clear and compact if requested.


Additionally this if block is only meant to run
when adding a new config option, because, as the comment indicates,
otherwise the diff context might not include the whole help message.
However if one renames an option, the regex matches as well and
might trigger another false positive.
This could potentially be addressed in the warning message,
though we are happy for any input on this.


 scripts/checkpatch.pl | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..671b369a39d4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3234,6 +3234,7 @@ sub process {
 			my $f;
 			my $is_start = 0;
 			my $is_end = 0;
+			my $help_indent;
 			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
 				$f = $lines[$ln - 1];
 				$cnt-- if ($lines[$ln - 1] !~ /^-/);
@@ -3245,7 +3246,12 @@ sub process {
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
 				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+					$length = 0;
+					if (defined $lines[$ln]) {
+						$lines[$ln] =~ /^\+(\s*)\S+/;
+						$help_indent = $1;
+					}
+					next;
 				}
 
 				$f =~ s/^.//;
@@ -3253,14 +3259,13 @@ sub process {
 				$f =~ s/^\s+//;
 				next if ($f =~ /^$/);
 
-				# This only checks context lines in the patch
-				# and so hopefully shouldn't trigger false
-				# positives, even though some of these are
-				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
-					last;
+				# Help text ends if a line has a smaller indentation
+				# than the first line of the message
+				if (defined $help_indent) {
+					if ($lines[$ln - 1] !~ /^\+$help_indent\S+/) {
+						$is_end = 1;
+						last;
+					}
 				}
 				$length++;
 			}
-- 
2.28.0
