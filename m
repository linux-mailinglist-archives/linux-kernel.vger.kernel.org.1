Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CE2A627D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgKDKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:49:11 -0500
Received: from mail.loongson.cn ([114.242.206.163]:36544 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727923AbgKDKtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:49:10 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD9MXh6JfwaIFAA--.14438S2;
        Wed, 04 Nov 2020 18:48:56 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangyouling@loongson.cn
Subject: [PATCH] arm64: Change the location of DISCARDS
Date:   Wed,  4 Nov 2020 18:48:52 +0800
Message-Id: <1604486932-18889-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxD9MXh6JfwaIFAA--.14438S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1kZF4xCr1UXF4rGrW5trb_yoWkGrcE9a
        1aqwnrGr10vF4ava4rKa93Wasaqa18G348Zr1DAr40gF9xXrs8J393JF47W3W5ArW2krn5
        AF1DJ3s3Zw12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the include/asm-generic/vmlinux.lds.h file, the "must be the last"
comment indicates that DISCARDS should be placed in the last position
of SECTIONS, like x86, mips, riscv, etc.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/arm64/kernel/vmlinux.lds.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1bda604..bf31074 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -109,12 +109,6 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
-	DISCARDS
-	/DISCARD/ : {
-		*(.interp .dynamic)
-		*(.dynsym .dynstr .hash .gnu.hash)
-	}
-
 	. = KIMAGE_VADDR;
 
 	.head.text : {
@@ -284,6 +278,13 @@ SECTIONS
 
 	.data.rel.ro : { *(.data.rel.ro) }
 	ASSERT(SIZEOF(.data.rel.ro) == 0, "Unexpected RELRO detected!")
+
+	/* Sections to be discarded */
+	DISCARDS
+	/DISCARD/ : {
+		*(.interp .dynamic)
+		*(.dynsym .dynstr .hash .gnu.hash)
+	}
 }
 
 #include "image-vars.h"
-- 
2.1.0

