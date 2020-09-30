Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4B27E96C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgI3NZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgI3NZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:20 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D472075F;
        Wed, 30 Sep 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472319;
        bh=zXf5IdVsjv02CToXaGl0U+R8uIJox+Ax0tMq2ZJvFgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wq9DiuS7coeK0Mv84TbR5q4Tr9FckZkb/644XnL/0ybkwLmsNQ+d4zW+2kxHKmOOA
         jz2MujdIjAXe+so7aKov0dMDHO/74k2Htd8Cb2ZRI7FbiIXR9JAl82xyV6/vx16aOt
         S+pHBBQye8FF99RaxH5txXLcPrPU1ciM9pCdqI4I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6f-001XJ3-OD; Wed, 30 Sep 2020 15:25:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/52] scripts: kernel-doc: fix troubles with line counts
Date:   Wed, 30 Sep 2020 15:24:29 +0200
Message-Id: <c3aa73d08083a3584aaaa87adc45ea7368b187d3.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently a bug with the way kernel-doc script
counts line numbers that can be seen with:

	$ ./scripts/kernel-doc -rst  -enable-lineno include/linux/math64.h >all && ./scripts/kernel-doc -rst -internal -enable-lineno include/linux/math64.h >int && diff -U0 int all

	--- int	2020-09-28 12:58:08.927486808 +0200
	+++ all	2020-09-28 12:58:08.905486845 +0200
	@@ -1 +1 @@
	-#define LINENO 27
	+#define LINENO 26
	@@ -3 +3 @@
	-#define LINENO 16
	+#define LINENO 15
	@@ -9 +9 @@
	-#define LINENO 17
	+#define LINENO 16
	...

This is happening with perl version 5.30.3, but I'm not
so sure if this is a perl bug, or if this is due to something
else.

In any case, fixing it is easy. Basically, when "-internal"
parameter is used, the process_export_file() function opens the
handle "IN". This makes the line number to be incremented, as the
handler for the main open is also "IN".

Fix the problem by using a different handler for the
main open().

While here, add a missing close for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e1140869b889..07b1073b0bc0 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2261,7 +2261,7 @@ sub process_file($) {
 
     $file = map_filename($orig_file);
 
-    if (!open(IN,"<$file")) {
+    if (!open(IN_FILE,"<$file")) {
 	print STDERR "Error: Cannot open file $file\n";
 	++$errors;
 	return;
@@ -2270,9 +2270,9 @@ sub process_file($) {
     $. = 1;
 
     $section_counter = 0;
-    while (<IN>) {
+    while (<IN_FILE>) {
 	while (s/\\\s*$//) {
-	    $_ .= <IN>;
+	    $_ .= <IN_FILE>;
 	}
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
@@ -2304,6 +2304,7 @@ sub process_file($) {
 	    print STDERR "${file}:1: warning: no structured comments found\n";
 	}
     }
+    close IN_FILE;
 }
 
 
-- 
2.26.2

