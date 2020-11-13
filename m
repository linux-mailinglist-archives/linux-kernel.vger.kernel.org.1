Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3D2B284B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgKMWR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgKMWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:24 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341BEC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:24 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id u123so3998894wmu.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cfK4RFJv/+x4FxS02JTsoCZH8VGMApR9HDzWNscVs7I=;
        b=OOL94VYxcAsKXTJaJu6KcYf3vzQ7ALDn9FfHmq0W91HIkulxRVB5GVp1tl37kNnoCT
         JSQ4Rrez3biamm+oyAWa3e8z6a3necmDEmocLY/gGFf2hxx1wqubehCrwhWIAaHl0pTm
         bI93xbZ1ZkHRJFfrs31wJ+bGrSaoBnSJPK3zKjj9fkTZZTCzAv6SVbDB2+q0ss/U6vVT
         mWi+gxlD3eeH+JNmA7KYH+K4ZxsWGPGF+BTtLlDqzaPzgoZYPkHs6UBfuDM/A0a4bQXw
         h6SpE3qaaVv07/06PbiJdmGGMxN4XCr6Cx1lKn5LibBKEHK8SamwUVI2qYXU7pegAlbC
         Qocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cfK4RFJv/+x4FxS02JTsoCZH8VGMApR9HDzWNscVs7I=;
        b=MzBQ38my4hyHcrHU1tpOKzk899zFNJXEYl+UzIaMmGvhGwwysANStu6/Zq+iemg+cR
         o+05EIIWZUg0X/wCjWUV+GeU/VwWuopzNTAikp4cYXzZHndE824V0Brjh8JPEjUnAh9d
         W7mHKEpERpObR26Kyls2PPuhmSQ0if20ySe83as094Z0ljHZLyu09VZkicoBDfcBIjOa
         F9t749cqAuf3wov02Yymijb3WfVuWD5Ogvw+tcccyU4w7ceWPkJvyA9CUS+Ez911I+cL
         0PV9bcRKd+SdegWM+V1/w/wcf5OZNMirDUqMP/Tci8Z9lE4+VmDrDDP34gszGsXlNsBB
         lAxw==
X-Gm-Message-State: AOAM530tRXl8g2ryZUw5btjplGbarfOkGKgU6qBHTcVI+ykJBodnKcRL
        w7qD6APniGku6ZpXOHEgNjDZLTAR38hJ/xRk
X-Google-Smtp-Source: ABdhPJzZn6Fk8JEDAcUL+VhVc/Ws7b3I8O+2jHvWTiLs2zRetCbpu1oT17RVx3l4ZGwTNmhAmvFYQjjhZlmNSpPd
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:eb4f:: with SMTP id
 u15mr6012608wrn.165.1605305842904; Fri, 13 Nov 2020 14:17:22 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:56 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <123c654a82018611d38af8c83d1e90c16558ce52.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 28/42] arm64: kasan: Allow enabling in-kernel MTE
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
2.29.2.299.gdc1121823c-goog

