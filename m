Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB5280B30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgJAXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgJAXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:51 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5DCC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:50 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 13so46546wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gnytaCb94xVQ7L/CojXY6Um8kg/YstpjCzFIZv8WTx8=;
        b=JBmbjsh06TRX2MzOuMJtipf1JeMyyK4+o+s0GwITV5q225JHL6TRmNrSwW/SwVnwpd
         9pFyGXO4cBlZ1O9c8OKx/TtXAOlLIhePYK0EWrzxHQ1NYlTuc6OvKJFzu6h3x8YydlpQ
         /l5My7D/fx4LoDdyhfi5NYiUjs0f9ICkJfzi55QZC4HSGST1/gorGgLCHPIUS2/IamAc
         /5sZKV4Osw8xaa2Ls1j3ItngPHnHoTBUOKKLc8UvZN7E6VwTR9lH+CoBkL8bBT3gxoJR
         tfv/2Tir2xiYX4nerOc7jdK75KBUkrOWpW0WLXtVQ8Uc4LdDlduG0EtFfp3fb+hDeHqn
         HOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gnytaCb94xVQ7L/CojXY6Um8kg/YstpjCzFIZv8WTx8=;
        b=YcM9cG6qrTY0Is5cBRdCCe+pFWWiZBJ9WrP1+8zOwpWNshNFiOc5OoIkK2QIoJE0u4
         WC9xy+ywkvvNgkU4GEn1dq4GMy6zbmEdej3M/O/ddOnlIMstpvNvzNGy1GsTgf91ib/E
         B+r3n4/+ydcNj1tp+TsDrTbh+3M254Jfc/YBg+JzeUyE99r4leEhZnrhGPCJ/Z54s2lb
         qiit9lWge5POD/eAoq54avmhOxvpUCRa6qYz8xXkb/S39q3AQZP/i8Fl3rjuBVk6ER/k
         EZAyYgrF4HXNsVwFUEYLU1hwDB1DzamqxEsHgsp2GyT8OOWUXn5yfUwreDZ5jjXMGfT0
         XtTQ==
X-Gm-Message-State: AOAM5315Jk8cTTOZ07oaph1bqxuS1eGNbLb+9+9xuSEfeCesJsO22KRc
        gRcH/rau5jYGicZGilACn9jMf73sZDfDTOol
X-Google-Smtp-Source: ABdhPJzJbo5CtXwA6Gi/sqrbZmN6s9dyBVmdhWMApSx7WyyHOrMaayQuq65zZXh83F1UYFJ51megLIxRwmYFJ7Gw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:cc8c:: with SMTP id
 p12mr11956869wrj.92.1601593909486; Thu, 01 Oct 2020 16:11:49 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:28 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <e8d5ed9bc12086670cbde30d390de32730d0371f.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 27/39] arm64: kasan: Enable in-kernel MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
feature and requires it to be enabled.

The Tag Checking operation causes a synchronous data abort as
a consequence of a tag check fault when MTE is configured in
synchronous mode.

Enable MTE in Synchronous mode in EL1 to provide a more immediate
way of tag check failure detection in the kernel.

As part of this change enable match-all tag for EL1 to allow the
kernel to access user pages without faulting. This is required because
the kernel does not have knowledge of the tags set by the user in a
page.

Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
similar way as TCF0 affects EL0.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I4d67497268bb7f0c2fc5dcacefa1e273df4af71d
---
 arch/arm64/kernel/cpufeature.c |  7 +++++++
 arch/arm64/mm/proc.S           | 23 ++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index add9da5d8ea3..eca06b8c74db 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1718,6 +1718,13 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 		cleared_zero_page = true;
 		mte_clear_page_tags(lm_alias(empty_zero_page));
 	}
+
+	/* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
+		/* Enable MTE Sync Mode for EL1 */
+		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
+		isb();
+	}
 }
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..6c1a6621d769 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -40,9 +40,15 @@
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define TCR_KASAN_FLAGS TCR_TBI1
+#define TCR_KASAN_SW_FLAGS TCR_TBI1
 #else
-#define TCR_KASAN_FLAGS 0
+#define TCR_KASAN_SW_FLAGS 0
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1
+#else
+#define TCR_KASAN_HW_FLAGS 0
 #endif
 
 /*
@@ -427,6 +433,10 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x5, MAIR_EL1_SET
 #ifdef CONFIG_ARM64_MTE
+	mte_tcr	.req	x20
+
+	mov	mte_tcr, #0
+
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
 	 * (ID_AA64PFR1_EL1[11:8] > 1).
@@ -447,6 +457,9 @@ SYM_FUNC_START(__cpu_setup)
 	/* clear any pending tag check faults in TFSR*_EL1 */
 	msr_s	SYS_TFSR_EL1, xzr
 	msr_s	SYS_TFSRE0_EL1, xzr
+
+	/* set the TCR_EL1 bits */
+	mov_q	mte_tcr, TCR_KASAN_HW_FLAGS
 1:
 #endif
 	msr	mair_el1, x5
@@ -456,7 +469,11 @@ SYM_FUNC_START(__cpu_setup)
 	 */
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
+#ifdef CONFIG_ARM64_MTE
+	orr	x10, x10, mte_tcr
+	.unreq	mte_tcr
+#endif
 	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-- 
2.28.0.709.gb0816b6eb0-goog

