Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C12BA224
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKTGI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:08:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48792 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgKTGIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:08:25 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx739OXbdfFXUTAA--.30887S2;
        Fri, 20 Nov 2020 14:08:15 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] m68k: Add a missing ELF_DETAILS in link script
Date:   Fri, 20 Nov 2020 14:08:14 +0800
Message-Id: <1605852494-23515-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx739OXbdfFXUTAA--.30887S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Gw47Xr13uw4kZw4xWFg_yoW8XrW7pw
        sFy3s5Jw4j9FyUAFykur4kZFyag3Z5WrW3XryYyFWrAF1a9r10q34kuF17JFWqqFyfKF40
        gF1xKF4qya48ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GF1l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUszBTUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c604abc3f6e3 ("vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG")
after should add a missing ELF_DETAILS, at the same time, the .comment
section has been included in the ELF_DETAILS.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/m68k/kernel/vmlinux-nommu.lds | 2 +-
 arch/m68k/kernel/vmlinux-std.lds   | 2 +-
 arch/m68k/kernel/vmlinux-sun3.lds  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
index 247e19f..396e126 100644
--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -86,7 +86,7 @@ SECTIONS {
 	_end = .;
 
 	STABS_DEBUG
-	.comment 0 : { *(.comment) }
+	ELF_DETAILS
 
 	/* Sections to be discarded */
 	DISCARDS
diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index 1511346..ed1d9ed 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -59,7 +59,7 @@ SECTIONS
   _end = . ;
 
   STABS_DEBUG
-  .comment 0 : { *(.comment) }
+  ELF_DETAILS
 
   /* Sections to be discarded */
   DISCARDS
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index 90ff8e5..4a52f44 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -52,6 +52,7 @@ __init_begin = .;
   _end = . ;
 
   STABS_DEBUG
+  ELF_DETAILS
 
   /* Sections to be discarded */
   DISCARDS
-- 
2.1.0

