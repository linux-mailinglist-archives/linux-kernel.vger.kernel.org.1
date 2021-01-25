Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B21302BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbhAYTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbhAYTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:03 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:55 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c1so10552288qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RDSr+b90kmy9FHMSi/QfI0SbQbMsMCPJRwK16BQ54DQ=;
        b=WxdWiV+PelSJ2780GgGioA+Au/FzkI2Ld3y9Qv3Ck/gIiT2w/EXtKoJsE+0QnLkhrF
         NzgL174DN5cyesZLqlpqi8wPfQWzScrpFqhGV5CV3/CcIi8+lHuuakfvuwiDRZKLYZ3q
         nxbpY0DJyx2V7mpAlbB6yER6hOLSOQxb0inofimIHO0nE2l6OxdL+p8TooiCMkTBEqgS
         aKxIWoPPMcArqYT3n2Hllj39Y5pRCseZpf4aEvhKRcGsVkbcHpvyIkHgd/77M21AOhoO
         jx4xb6tc/azC6m9EMYG0FlqI24127XEIEFtRtuGwkiuvC1Tn85VAmqo8jJxWldh7tVaP
         NTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDSr+b90kmy9FHMSi/QfI0SbQbMsMCPJRwK16BQ54DQ=;
        b=FJo/0rX1wSNZPlBq8igMPO1Zqhc8WGTRXzEJJKYCSZnM+bP1iR4Z8T4ZJn/hXKvMcu
         RKY7EKxulxMu561rwZfL8Z8ZzkoeWLGTRodyenuzkk+hU/xpP/Y+swOeyM9+YmMmYwJM
         VegJcnbsq3FNWGfQzUruxcRtl+3IjLt2jdr6VwrqHA6wIuDIOaL3Z59ZQLjZO+EAVOBm
         eBd+m3bKST7eBbQPcyGpMCxNvrR0WlLttUeuSDOlFcBtswVeiVyrr+trh3lpsSLkoH/3
         w2G6A+2B4bHiWV95oZCZE+OOwoyP7l/f4QOHBvfsb763Cc4jGFlhG6x4+87Ykk/SDG/3
         8Nrw==
X-Gm-Message-State: AOAM531poNB923nbP1Ycbn/LZAprxI/4PUSRSy9440s2bC6qFHUr/+6k
        Fa4aei721mN59tIhOwl3c4egQQ==
X-Google-Smtp-Source: ABdhPJxQav/dTh+GHIW6w/wd5sxxZLx8m02Wa9EmWUQyDQjM4DNHDdovsx6PrQGMmiR59tWpk8dAcg==
X-Received: by 2002:ac8:5a4b:: with SMTP id o11mr1983211qta.202.1611602394865;
        Mon, 25 Jan 2021 11:19:54 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:54 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 17/18] arm64: kexec: enable MMU during kexec relocation
Date:   Mon, 25 Jan 2021 14:19:22 -0500
Message-Id: <20210125191923.1060122-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we have transitional page tables configured, temporarily enable
MMU to allow faster relocation of segments to final destination.

The performance data: for a moderate size kernel + initramfs: 25M the
relocation was taking 0.382s, with enabled MMU it now takes
0.019s only or x20 improvement.

The time is proportional to the size of relocation, therefore if initramfs
is larger, 100M it could take over a second.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 131 ++++++++++++++++++----------
 1 file changed, 87 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c6178b1a4e60..9c60981a6911 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -4,6 +4,8 @@
  *
  * Copyright (C) Linaro.
  * Copyright (C) Huawei Futurewei Technologies.
+ * Copyright (C) 2020, Microsoft Corporation.
+ * Pavel Tatashin <pasha.tatashin@soleen.com>
  */
 
 #include <linux/kexec.h>
@@ -14,6 +16,54 @@
 #include <asm/page.h>
 #include <asm/sysreg.h>
 
+.macro tlb_invalidate
+	dsb	sy
+	dsb	ish
+	tlbi	vmalle1
+	dsb	ish
+	isb
+.endm
+
+.macro turn_off_mmu tmp1, tmp2
+	mrs	\tmp1, sctlr_el1
+	mov_q	\tmp2, SCTLR_ELx_FLAGS
+	bic	\tmp1, \tmp1, \tmp2
+	pre_disable_mmu_workaround
+	msr	sctlr_el1, \tmp1
+	isb
+.endm
+
+.macro turn_on_mmu tmp1, tmp2
+	mrs	\tmp1, sctlr_el1
+	mov_q	\tmp2, SCTLR_ELx_FLAGS
+	orr	\tmp1, \tmp1, \tmp2
+	msr	sctlr_el1, \tmp1
+	ic	iallu
+	dsb	nsh
+	isb
+.endm
+
+/*
+ * Set ttbr0 and ttbr1, called while MMU is disabled, so no need to temporarily
+ * set zero_page table. Invalidate TLB after new tables are set.
+ */
+.macro set_ttbr arg, tmp1, tmp2
+	ldr	\tmp1, [\arg, #KEXEC_KRELOC_TRANS_TTBR0]
+	msr	ttbr0_el1, \tmp1
+	ldr	\tmp1, [\arg, #KEXEC_KRELOC_TRANS_TTBR1]
+	offset_ttbr1 \tmp1, \tmp2
+	msr	ttbr1_el1, \tmp1
+	isb
+.endm
+
+/* Set T0SZ to match the requirements of idmap page */
+.macro set_tcr_t0sz arg, tmp1, tmp2
+	ldr	\tmp2, [\arg, #KEXEC_KRELOC_TRANS_T0SZ]
+	mrs	\tmp1, tcr_el1
+	bfi     \tmp1, \tmp2, TCR_T0SZ_OFFSET, TCR_TxSZ_WIDTH
+	msr	tcr_el1, \tmp1
+.endm
+
 .macro el1_sync_64
 	.align 7
 	br	x4			/* Jump to new world from el2 */
@@ -36,56 +86,49 @@
  * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
  * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
  * safe memory that has been set up to be preserved during the copy operation.
+ *
+ * This function temporarily enables MMU if kernel relocation is needed.
+ * Also, if we enter this function at EL2 on non-VHE kernel, we temporarily go
+ * to EL1 to enable MMU, and escalate back to EL2 at the end to do the jump to
+ * the new kernel. This is determined by presence of el2_vector.
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
-	/* Check if the new image needs relocation. */
-	ldr	x16, [x0, #KEXEC_KRELOC_HEAD]	/* x16 = kimage_head */
-	tbnz	x16, IND_DONE_BIT, .Ldone
-	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
-.Lloop:
-	and	x12, x16, PAGE_MASK		/* x12 = addr */
-
-	/* Test the entry flags. */
-.Ltest_source:
-	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
-
-	/* Invalidate dest page to PoC. */
-	mov     x2, x13
-	add     x20, x2, #PAGE_SIZE
-	sub     x1, x15, #1
-	bic     x2, x2, x1
-2:	dc      ivac, x2
-	add     x2, x2, x15
-	cmp     x2, x20
-	b.lo    2b
-	dsb     sy
-
-	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
-	b	.Lnext
-.Ltest_indirection:
-	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-	mov	x14, x12			/* ptr = addr */
-	b	.Lnext
-.Ltest_destination:
-	tbz	x16, IND_DESTINATION_BIT, .Lnext
-	mov	x13, x12			/* dest = addr */
-.Lnext:
-	ldr	x16, [x14], #8			/* entry = *ptr++ */
-	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
-.Ldone:
-	/* wait for writes from copy_page to finish */
-	dsb	nsh
-	ic	iallu
-	dsb	nsh
-	isb
-
-	/* Start new image. */
-	ldr	x4, [x0, #KEXEC_KRELOC_ENTRY_ADDR]	/* x4 = kimage_start */
+	mov	x20, xzr			/* x20 will hold vector value */
+	ldr	x11, [x0, #KEXEC_KRELOC_COPY_LEN]
+	cbz	x11, 5f				/* Check if need to relocate */
+	ldr	x20, [x0, #KEXEC_KRELOC_EL2_VECTOR]
+	cbz	x20, 2f				/* need to reduce to EL1? */
+	msr	vbar_el2, x20			/* el2_vector present, means */
+	adr	x1, 2f				/* we will do copy in el1 but */
+	msr	elr_el2, x1			/* do final jump from el2 */
+	eret					/* Reduce to EL1 */
+2:	set_tcr_t0sz x0, x1, x2			/* Set t0sz for idmaped page */
+	set_ttbr x0, x1, x2			/* Set our page tables */
+	tlb_invalidate
+	ldr	x1, [x0, #KEXEC_KRELOC_DST_ADDR]; /* arg is not idmapped so */
+	ldr	x2, [x0, #KEXEC_KRELOC_SRC_ADDR]; /* read before MMU is on */
+	turn_on_mmu x3, x4			/* Turn MMU back on */
+	mov	x12, x1				/* x12 dst backup */
+3:	copy_page x1, x2, x3, x4, x5, x6, x7, x8, x9, x10
+	sub	x11, x11, #PAGE_SIZE
+	cbnz	x11, 3b				/* page copy loop */
+	raw_dcache_line_size x2, x3		/* x2 = dcache line size */
+	sub	x3, x2, #1			/* x3 = dcache_size - 1 */
+	bic	x12, x12, x3
+4:	dc	cvau, x12			/* Flush D-cache */
+	add	x12, x12, x2
+	cmp	x12, x1				/* Compare to dst + len */
+	b.ne	4b				/* D-cache flush loop */
+	turn_off_mmu x1, x2			/* Turn off MMU */
+	tlb_invalidate				/* Invalidate TLB */
+5:	ldr	x4, [x0, #KEXEC_KRELOC_ENTRY_ADDR]	/* x4 = kimage_start */
 	ldr	x3, [x0, #KEXEC_KRELOC_KERN_ARG3]
 	ldr	x2, [x0, #KEXEC_KRELOC_KERN_ARG2]
 	ldr	x1, [x0, #KEXEC_KRELOC_KERN_ARG1]
 	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
-	br	x4
+	cbnz	x20, 6f				/* need to escalate to el2? */
+	br	x4				/* Jump to new world */
+6:	hvc	#0				/* enters kexec_el1_sync */
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 /* el2 vectors - switch el2 here while we restore the memory image. */
-- 
2.25.1

