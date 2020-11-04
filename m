Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9A2A5EF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKDHvu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Nov 2020 02:51:50 -0500
Received: from mx1.emlix.com ([136.243.223.33]:44494 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgKDHvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:51:50 -0500
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 02:51:49 EST
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D296C604B1;
        Wed,  4 Nov 2020 08:44:55 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: fix typos in "compress" variants
Date:   Wed, 04 Nov 2020 08:44:55 +0100
Message-ID: <1959691.vJJ4Jf3O8W@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 arch/x86/kernel/head64.c | 2 +-
 fs/f2fs/data.c           | 2 +-
 scripts/kallsyms.c       | 2 +-
 scripts/spelling.txt     | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05e117137b45..a18a11acad92 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -105,7 +105,7 @@ static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
 static bool __head check_la57_support(unsigned long physaddr)
 {
 	/*
-	 * 5-level paging is detected and enabled at kernel decomression
+	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
 	 */
 	if (!(native_read_cr4() & X86_CR4_LA57))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index be4da52604ed..93c23ae5723d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2377,7 +2377,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
-			/* there are remained comressed pages, submit them */
+			/* there are remained compressed pages, submit them */
 			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 7ecd2ccba531..623dedecd8e3 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -12,7 +12,7 @@
  *  map char code 0xF7 to represent "write_" and then in every symbol where
  *  "write_" appears it can be replaced by 0xF7, saving 5 bytes.
  *      The used codes themselves are also placed in the table so that the
- *  decompresion can work without "special cases".
+ *  decompression can work without "special cases".
  *      Applied to kernel symbols, this usually produces a compression ratio
  *  of about 50%.
  *
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2de1e5..061e15201739 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -338,6 +338,7 @@ compoment||component
 comppatible||compatible
 compres||compress
 compresion||compression
+comressed||compressed
 comression||compression
 comunication||communication
 conbination||combination
@@ -406,6 +407,8 @@ debouce||debounce
 decendant||descendant
 decendants||descendants
 decompres||decompress
+decompresion||decompression
+decomression||decompression
 decsribed||described
 decription||description
 dectected||detected
-- 
2.29.1


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



