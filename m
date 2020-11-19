Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ABE2B89AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKSBkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:40:42 -0500
Received: from mail.loongson.cn ([114.242.206.163]:40870 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbgKSBkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:40:42 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxitAVzbVfalYSAA--.29117S2;
        Thu, 19 Nov 2020 09:40:38 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Michal Simek <monstr@monstr.eu>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: Use the common INIT_DATA_SECTION macro in vmlinux.lds.S
Date:   Thu, 19 Nov 2020 09:40:37 +0800
Message-Id: <1605750037-433-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxitAVzbVfalYSAA--.29117S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kCw1fuFW5Kr1rXr4kXrb_yoW8JFy8pr
        sIv3s7uw4UGF4UZ3Z7KFy8uryavr1ftw4UWayqvay8Cr17uFyvvwnrtrs3JFyDGrWUC3Wr
        uF18XFWYga17J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w4l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jOCzZUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common INIT_DATA_SECTION rule for the linker script in an effort
to regularize the linker script.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/microblaze/kernel/vmlinux.lds.S | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d..527ebfc 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -96,10 +96,7 @@ SECTIONS {
 	__init_begin = .;
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
-
-	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
-		INIT_DATA
-	}
+	INIT_DATA_SECTION(0)
 
 	. = ALIGN(4);
 	.init.ivt : AT(ADDR(.init.ivt) - LOAD_OFFSET) {
@@ -107,25 +104,6 @@ SECTIONS {
 		*(.init.ivt)
 		__ivt_end = .;
 	}
-
-	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
-		INIT_SETUP(0)
-	}
-
-	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET ) {
-		INIT_CALLS
-	}
-
-	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
-		CON_INITCALL
-	}
-
-	__init_end_before_initramfs = .;
-
-	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
-		INIT_RAM_FS
-	}
-
 	__init_end = .;
 
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
-- 
2.1.0

