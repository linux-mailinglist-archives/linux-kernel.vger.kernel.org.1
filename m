Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224E728859A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgJIIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbgJIIy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:54:59 -0400
Received: from mail.kernel.org (ip5f5ad5d0.dynamic.kabel-deutschland.de [95.90.213.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6BA2227F;
        Fri,  9 Oct 2020 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602233698;
        bh=PyiP6M+lDsgbufpbwMpTvauol6VUFL607YHj7WiFOD8=;
        h=From:To:Cc:Subject:Date:From;
        b=15JTSwYH/sbarqoWl9NhOZ0NJtuFdUchcbIqRsIc3Y7vx0E5BVqUDndXSuMaJRq/v
         auGACGsPdZQUgs/wYYqj0H/TmfmKo/vZgTZG5nfI/E7oX1unliTO1ct/42+Fg72l5o
         F03A1nDTir8/LnQ1r/ogLG8yhDXw/xltL4aBwTww=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQoAx-0036mc-F4; Fri, 09 Oct 2020 10:54:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: fix line number handling
Date:   Fri,  9 Oct 2020 10:54:54 +0200
Message-Id: <32dd3f497839310aebcea763add71d390f4c7b54.1602233692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
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
index a3453de4495c..297312824d26 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1706,7 +1706,7 @@ sub dump_function($$) {
     my $file = shift;
     my $noret = 0;
 
-    print_lineno($.);
+    print_lineno($new_start_line);
 
     $prototype =~ s/^static +//;
     $prototype =~ s/^extern +//;
@@ -2034,7 +2034,7 @@ sub process_name($$) {
     if (/$doc_block/o) {
 	$state = STATE_DOCBLOCK;
 	$contents = "";
-	$new_start_line = $. + 1;
+	$new_start_line = $.;
 
 	if ( $1 eq "" ) {
 	    $section = $section_intro;
@@ -2117,6 +2117,7 @@ sub process_body($$) {
     if ($state == STATE_BODY_WITH_BLANK_LINE && /^\s*\*\s?\S/) {
 	dump_section($file, $section, $contents);
 	$section = $section_default;
+	$new_start_line = $.;
 	$contents = "";
     }
 
@@ -2172,6 +2173,7 @@ sub process_body($$) {
 	$prototype = "";
 	$state = STATE_PROTO;
 	$brcount = 0;
+        $new_start_line = $. + 1;
     } elsif (/$doc_content/) {
 	if ($1 eq "") {
 	    if ($section eq $section_context) {
-- 
2.26.2

