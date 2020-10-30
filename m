Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C32A07B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJ3OTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3OTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:19:36 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FAD2076E;
        Fri, 30 Oct 2020 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604067574;
        bh=IvxDEHweFp2efRJhOUMWQE0L08hytg3HwZCxZxPTYT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03sa/iIctBfY09k9N5sWYiZ5/mJ92P3xx8LXlxp6vguzqfeTPz5g6qkyKqKu1+qeb
         CrW7gQC9R25aSBFsBHb+NZb73RPkPt4dMwrB8aA6MzyKY2YYT1wNRDGTUdzbOxSbqv
         E41IXBuaNdghgdg5Gd6+FuUK/CH90/gg8l9LZsWg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYVFb-004TfQ-3S; Fri, 30 Oct 2020 15:19:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RFC] scripts: kernel-doc: better handle spaces after section markups
Date:   Fri, 30 Oct 2020 15:19:29 +0100
Message-Id: <e4d09fabc22c6b62a485779966d4022afbfbdee5.1604067396.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201030150019.1cc6db7d@coco.lan>
References: <20201030150019.1cc6db7d@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better handle things like:

	* Return: foo
	*         description

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

I already posted this as part of a reply to Randy/Matthew.

As said there, I only did a fast check here, in order to verify if it
 won't be producing additional warnings. I didn't check the html
output. Just the resulting ReST from kernel-doc and the
"make htmldocs" warnings.

Yet, let me post in separate, just in case someone has enough
time/bandwidth to test if this is working properly and it is not
causing regressions.

Feel free to either use, modify or drop it ;-)

 scripts/kernel-doc | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f699cf05d409..a91a2420cccf 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -389,7 +389,7 @@ my $doc_com_body = '\s*\* ?';
 my $doc_decl = $doc_com . '(\w+)';
 # @params and a strictly limited set of supported section names
 my $doc_sect = $doc_com .
-    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:(.*)';
+    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)(\s*:)(.*)';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
@@ -865,8 +865,21 @@ sub output_highlight_rst {
     my $in_literal = 0;
     my $litprefix;
     my $block = "";
+    my $spaces = "";
+    my $first = 1;
 
     foreach $line (split "\n",$input) {
+        if ($first) {
+		$spaces = $1 if ($line =~ (m/^(\s+)/));
+		$first = 0;
+        }
+
+        if ($spaces ne "") {
+		if (!($line =~ s/^$spaces//)) {
+		    $spaces = "";
+		}
+        }
+
 	#
 	# If we're in a literal block, see if we should drop out
 	# of it.  Otherwise pass the line straight through unmunged.
@@ -2135,8 +2148,9 @@ sub process_body($$) {
     }
 
     if (/$doc_sect/i) { # case insensitive for supported section names
+	my $spaces = "$1$2";
 	$newsection = $1;
-	$newcontents = $2;
+	$newcontents = $3;
 
 	# map the supported section names to the canonical names
 	if ($newsection =~ m/^description$/i) {
@@ -2161,11 +2175,20 @@ sub process_body($$) {
 
 	$in_doc_sect = 1;
 	$state = STATE_BODY;
-	$contents = $newcontents;
 	$new_start_line = $.;
-	while (substr($contents, 0, 1) eq " ") {
-	    $contents = substr($contents, 1);
+
+	if ($newsection =~ m/(return|note)/i) {
+	    $spaces =~ s/\S/ /g;
+	    $newcontents = $spaces . $newcontents;
+	    $newcontents =~ s/^\s+$//;
+	    $contents = $newcontents;
+	} else {
+	    $contents = $newcontents;
+	    while (substr($newcontents, 0, 1) eq " ") {
+		$newcontents = substr($newcontents, 1);
+	    }
 	}
+
 	if ($contents ne "") {
 	    $contents .= "\n";
 	}
-- 
2.26.2


