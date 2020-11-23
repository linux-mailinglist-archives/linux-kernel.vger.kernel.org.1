Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0502C15ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgKWUJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbgKWUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:35 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7040C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:33 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id r124so8090522qkd.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rVMBHBVJQeUCZLewjiSRiYOL9IjQshxMwG3NdWet2ZQ=;
        b=Zjw7Bjb0EieYeLR3i+7toAO5bnDeRvutOgtkBZRShwjuTUuJ870vZm1vdPcskK+Khe
         6Ci+kghVW52zYO64/WdaIvWrFqE2VyquVaX7KJMlSEy7/lclemhxncoZVKlgFfyG2GeE
         vHa1pt7MxhnAdjscAzzFH3RLfwFSBLq3pcjV2DaqXDxSrwlrPdubBqHZ5Pzku9wK+Jig
         SjNxp+jRVJ7b+lfMlnBOpt5InCabQZWAiqEby8RK6xQsPoGexbw6FRS8e/YMNY+w+m/C
         MDs+Mq9NLbv04CN2K+z5RM63cwRXmM7RQ0jRYNVctQQcCIzWXa8VsSIPmeyW1PJkJaHE
         3g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rVMBHBVJQeUCZLewjiSRiYOL9IjQshxMwG3NdWet2ZQ=;
        b=ElG/5Dqji+pHbdiCy1gYtNwVqQoBm7CTYQld+uzD1YAgrzSF5+5MI20oTYs9bpg3x6
         d2j4cL14aWJrC3FvGcZCOWJwzzWg9mTSpmlloLaTwlVyDdzVnLmoNuEH5KGBP/NdQhiJ
         +KNHb3aZ6qpIs6ksUNQ4SzNBVs9iAYYM38hpAbJ0oeicEfvNf4CoEwtbrgdy1jyAGWQM
         yYDJbeKnrfpK5W7dZpib18Vlv3+Ut69J7TwcGunr9FAaPmJpJG+cvW8H2tGlhB4o2Juo
         mHzXT6Lnl6h3kfheEbEbGraepgwKFEDwXLa/vdktSYv/4C/nbpRwGSBqXSSre62d7LQn
         nlXQ==
X-Gm-Message-State: AOAM533bCMpGuSwOP+sMV5vS+VexE5FyR5vNF5/pTfI3AVGPSrDwUQAM
        kzPz2ZuGCmLAAPlrddwIuntngqVbHqyCKxGt
X-Google-Smtp-Source: ABdhPJzHMl1mbdwup/jzKm/e31Xz7AdnHxGJhgVnDJJTQN6EFH67dsLT2eiWkAdM3Q4HjJUvj4UmozVfjlzKoJly
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:40d1:: with SMTP id
 x17mr1213864qvp.21.1606162172985; Mon, 23 Nov 2020 12:09:32 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:52 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <7352b0a0899af65c2785416c8ca6bf3845b66fa1.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 28/42] arm64: kasan: Allow enabling in-kernel MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
feature and requires it to be enabled. MTE supports

This patch adds a new mte_enable_kernel() helper, that enables MTE in
Synchronous mode in EL1 and is intended to be called from KASAN runtime
during initialization.

The Tag Checking operation causes a synchronous data abort as
a consequence of a tag check fault when MTE is configured in
synchronous mode.

As part of this change enable match-all tag for EL1 to allow the
kernel to access user pages without faulting. This is required because
the kernel does not have knowledge of the tags set by the user in a
page.

Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
similar way as TCF0 affects EL0.

MTE that is built on top of the Top Byte Ignore (TBI) feature hence we
enable it as part of this patch as well.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I4d67497268bb7f0c2fc5dcacefa1e273df4af71d
---
 arch/arm64/include/asm/mte-kasan.h |  6 ++++++
 arch/arm64/kernel/mte.c            |  7 +++++++
 arch/arm64/mm/proc.S               | 23 ++++++++++++++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 3a70fb1807fd..71ff6c6786ac 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -29,6 +29,8 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
+void mte_enable_kernel(void);
+
 #else /* CONFIG_ARM64_MTE */
 
 static inline u8 mte_get_ptr_tag(void *ptr)
@@ -49,6 +51,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
+static inline void mte_enable_kernel(void)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 86d554ce98b6..7899e165f30a 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -129,6 +129,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return ptr;
 }
 
+void mte_enable_kernel(void)
+{
+	/* Enable MTE Sync Mode for EL1. */
+	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
+	isb();
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 0eaf16b0442a..0d85e6df42bc 100644
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
+#define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1 | TCR_TBI1
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
2.29.2.454.gaff20da3a2-goog

