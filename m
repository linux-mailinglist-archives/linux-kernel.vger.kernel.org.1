Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157DA28CDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgJMMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgJMLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:40 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8575B2173E;
        Tue, 13 Oct 2020 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590079;
        bh=EjhsXt2TTbz27tflwp0Res4uq/4Y2qjajetlKiJB0vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el9Z8mPHpLo2RC1NDZdy27PaurpNC/sa7VyZHyYYkUtfJ9Z0J2Q/anWZpv9RGMXkz
         0nrt2TAdWGjBmhRGCOHMS0A5XaQvJrfIjLpXhaQ7XbpzeRNUeSa12FDVqb2UK84M3E
         WfMx5awcjZ9PPvCgBG0EcmthLiMY4XF6EdaCJWHU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt3-006CTG-6Z; Tue, 13 Oct 2020 13:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/80] scripts: kernel-doc: fix troubles with line counts
Date:   Tue, 13 Oct 2020 13:53:19 +0200
Message-Id: <be13b9152768c8768d33336d6593715b2a36035b.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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
index d9783c98f33b..bdd2ebb4ac41 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2268,7 +2268,7 @@ sub process_file($) {
 
     $file = map_filename($orig_file);
 
-    if (!open(IN,"<$file")) {
+    if (!open(IN_FILE,"<$file")) {
 	print STDERR "Error: Cannot open file $file\n";
 	++$errors;
 	return;
@@ -2277,9 +2277,9 @@ sub process_file($) {
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
@@ -2311,6 +2311,7 @@ sub process_file($) {
 	    print STDERR "${file}:1: warning: no structured comments found\n";
 	}
     }
+    close IN_FILE;
 }
 
 
-- 
2.26.2

