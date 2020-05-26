Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB21A85CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501931AbgDNQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440288AbgDNQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E4F2074D;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=fEH5MARuDeBm7xykHMdOvvg3KVJtsODv97Cvb7xeU/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3FMlTZ1yInQXMcI8jhffWX2vXo9obhbpUBT1dMjhPAO8rvQLdwijnT7XgL0KDHej
         WGH9Pa4fbvSddfnn+JB6WKCniIfwHdHur1cOEiB1u/GP8EOMtrl+/2p0BH9FObVoej
         5p/7Ec7+TBzMZlhTi75W+rwGQdWDGaBce7YRZnno=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068l6-IG; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/33] scripts: kernel-doc: accept blank lines on parameter description
Date:   Tue, 14 Apr 2020 18:48:29 +0200
Message-Id: <c07d2862792d75a2691d69c9eceb7b89a0164cc0.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx is very pedantic with respect to blank lines. Sometimes,
in order to make it to properly handle something, we need to
add a blank line. However, currently, any blank line inside a
kernel-doc comment like:

	/*
	 * @foo: bar
         *
	 *       foobar
	 *
	 * some description

will be considered as if "foobar" was part of the description.

This patch changes kernel-doc behavior. After it, foobar will
be considered as part of the parameter text. The description
will only be considered as such if it starts with:

zero spaces after asterisk:

	*foo

one space after asterisk:
	* foo

or have a explicit Description section:

	*   Description:

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index b019d8db6502..41ed4202f4ad 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -331,13 +331,14 @@ my $lineprefix="";
 
 # Parser states
 use constant {
-    STATE_NORMAL        => 0, # normal code
-    STATE_NAME          => 1, # looking for function name
-    STATE_BODY_MAYBE    => 2, # body - or maybe more description
-    STATE_BODY          => 3, # the body of the comment
-    STATE_PROTO         => 4, # scanning prototype
-    STATE_DOCBLOCK      => 5, # documentation block
-    STATE_INLINE        => 6, # gathering documentation outside main block
+    STATE_NORMAL        => 0,        # normal code
+    STATE_NAME          => 1,        # looking for function name
+    STATE_BODY_MAYBE    => 2,        # body - or maybe more description
+    STATE_BODY          => 3,        # the body of the comment
+    STATE_BODY_WITH_BLANK_LINE => 4, # the body, which has a blank line
+    STATE_PROTO         => 5,        # scanning prototype
+    STATE_DOCBLOCK      => 6,        # documentation block
+    STATE_INLINE        => 7,        # gathering doc outside main block
 };
 my $state;
 my $in_doc_sect;
@@ -1957,6 +1958,12 @@ sub process_body($$) {
 	}
     }
 
+    if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
+	dump_section($file, $section, $contents);
+	$section = $section_default;
+	$contents = "";
+    }
+
     if (/$doc_sect/i) { # case insensitive for supported section names
 	$newsection = $1;
 	$newcontents = $2;
@@ -2010,18 +2017,21 @@ sub process_body($$) {
 	$state = STATE_PROTO;
 	$brcount = 0;
     } elsif (/$doc_content/) {
-	# miguel-style comment kludge, look for blank lines after
-	# @parameter line to signify start of description
 	if ($1 eq "") {
-	    if ($section =~ m/^@/ || $section eq $section_context) {
+	    if ($section eq $section_context) {
 		dump_section($file, $section, $contents);
 		$section = $section_default;
 		$contents = "";
 		$new_start_line = $.;
+		$state = STATE_BODY;
 	    } else {
+		if ($section ne $section_default) {
+		    $state = STATE_BODY_WITH_BLANK_LINE;
+		} else {
+		    $state = STATE_BODY;
+		}
 		$contents .= "\n";
 	    }
-	    $state = STATE_BODY;
 	} elsif ($state == STATE_BODY_MAYBE) {
 	    # Continued declaration purpose
 	    chomp($declaration_purpose);
@@ -2173,7 +2183,8 @@ sub process_file($) {
 	    process_normal();
 	} elsif ($state == STATE_NAME) {
 	    process_name($file, $_);
-	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE) {
+	} elsif ($state == STATE_BODY || $state == STATE_BODY_MAYBE ||
+		 $state == STATE_BODY_WITH_BLANK_LINE) {
 	    process_body($file, $_);
 	} elsif ($state == STATE_INLINE) { # scanning for inline parameters
 	    process_inline($file, $_);
-- 
2.25.2

