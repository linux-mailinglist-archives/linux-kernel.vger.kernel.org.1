Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF642A62CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKDK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:59:30 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38364 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbgKDK73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:59:29 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCtF_iaJfXqQFAA--.7999S2;
        Wed, 04 Nov 2020 18:59:11 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use the common INIT_DATA_SECTION macro in vmlinux.lds.S
Date:   Wed,  4 Nov 2020 18:59:10 +0800
Message-Id: <1604487550-20040-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxCtF_iaJfXqQFAA--.7999S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1fXw43AFyfWF4xAr1kKrg_yoWkCrX_Ga
        sIva1ftr1kCrsIya1kAr1fXFyDtayrGr1S93ZI9ws7AF1fZwsxJ3Z7Ga17Zw18Wr1Ikrsx
        ZF45ZF90yF10yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gw1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SdgDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common INIT_DATA_SECTION rule for the linker script in an effort
to regularize the linker script.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/powerpc/kernel/vmlinux.lds.S | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index e0548b4..5dc05f3 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -186,21 +186,7 @@ SECTIONS
 		EXIT_TEXT
 	}
 
-	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
-		INIT_DATA
-	}
-
-	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
-		INIT_SETUP(16)
-	}
-
-	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
-		INIT_CALLS
-	}
-
-	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
-		CON_INITCALL
-	}
+	INIT_DATA_SECTION(16)
 
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
@@ -228,9 +214,6 @@ SECTIONS
 		__stop___fw_ftr_fixup = .;
 	}
 #endif
-	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
-		INIT_RAM_FS
-	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
-- 
2.1.0

