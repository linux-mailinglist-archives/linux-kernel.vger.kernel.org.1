Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370EF28CD89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgJMLyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79F7C20E65;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=RCPnWcXK1bSpyxXJWxQImSTNLictdx2PM3q4GNyrSN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScYbERL/Dt/152g5uCm9dw9y6qg0tBtiyzZktzO88O5Kzy63wS14zH75nJTnSPaJj
         BwXKSbasMBBKd2//EQLRx3i4AqG5iYfwJ49HgYwRmpLsV25yBlUwFXUMXBbv/Snz/T
         gdQ1lHNEwfFjn3LuL5yG6pgmvRzenqAh1who9o20=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTS-BH; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/80] scripts: kernel-doc: fix line number handling
Date:   Tue, 13 Oct 2020 13:53:24 +0200
Message-Id: <9074689b1060c9871cc1ac45d8b49012fed34f53.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address several issues related to pointing to the wrong line
number:

1) ensure that line numbers will always be initialized

   When section is the default (Description), the line number
   is not initializing, producing this:

	$ ./scripts/kernel-doc --enable-lineno ./drivers/media/v4l2-core/v4l2-mem2mem.c|less

	**Description**

	#define LINENO 0
	In case of streamoff or release called on any context,
	1] If the context is currently running, then abort job will be called
	2] If the context is queued, then the context will be removed from
	   the job_queue

  Which is not right. Ensure that the line number will always
  be there. After applied, the result now points to the right location:

	**Description**

	#define LINENO 410
	In case of streamoff or release called on any context,
	1] If the context is currently running, then abort job will be called
	2] If the context is queued, then the context will be removed from
	   the job_queue

2) The line numbers for function prototypes are always + 1,
   because it is taken at the line after handling the prototype.
   Change the logic to point to the next line after the /** */
   block;

3) The "DOC:" line number should point to the same line as this
   markup is found, and not to the next one.

Probably part of the issues were due to a but that was causing
the line number offset to be incremented by one, if --export
were used.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index ed32883c3221..9496abba9538 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1705,7 +1705,7 @@ sub dump_function($$) {
     my $file = shift;
     my $noret = 0;
 
-    print_lineno($.);
+    print_lineno($new_start_line);
 
     $prototype =~ s/^static +//;
     $prototype =~ s/^extern +//;
@@ -2033,7 +2033,7 @@ sub process_name($$) {
     if (/$doc_block/o) {
 	$state = STATE_DOCBLOCK;
 	$contents = "";
-	$new_start_line = $. + 1;
+	$new_start_line = $.;
 
 	if ( $1 eq "" ) {
 	    $section = $section_intro;
@@ -2116,6 +2116,7 @@ sub process_body($$) {
     if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
 	dump_section($file, $section, $contents);
 	$section = $section_default;
+	$new_start_line = $.;
 	$contents = "";
     }
 
@@ -2171,6 +2172,7 @@ sub process_body($$) {
 	$prototype = "";
 	$state = STATE_PROTO;
 	$brcount = 0;
+        $new_start_line = $. + 1;
     } elsif (/$doc_content/) {
 	if ($1 eq "") {
 	    if ($section eq $section_context) {
-- 
2.26.2

