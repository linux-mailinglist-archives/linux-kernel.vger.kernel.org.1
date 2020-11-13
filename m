Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88B62B285C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKMWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:28 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:28 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z14so6624863qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VB38GTxukpbyDO0optCuqHPWhKmIjr0MvF2hNC1HBK8=;
        b=j2wQ5L7GrYCB+gwtSLpkHkpCwTZg/CnbH/yXIOCi6KSlnfJtiANg3kPAE+G72ivAWc
         alQgdxI17l4HBVm+FWBHr3mFnjbvHsthhSfDfF0B1PlFsIS1YNRpm1tDhtc0AFjz4xV2
         o7DCsYAdRoAUFL9GJ2t+E1y1EtVSfYGvzRo2EygWioleeTKYmad3IJnIfxwNy0tYtCOY
         WIIZ8yGJieLlWZr3hob3Kw2kdZO2idwpvOW51n7ynp2HZ96MpTrMzse9hqHzGlZNnl5l
         jHqOGcTDeXaff5suJoQksgRfyJcLro2dHbSPA660y11xeL2yWe0rSFMZbkWoDXiBuPTo
         V1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VB38GTxukpbyDO0optCuqHPWhKmIjr0MvF2hNC1HBK8=;
        b=e70qGFV3XP9fnd2f3DPSaHsaxI+PzWCLh26BzIwKTkFYxSTM8lX9+4RIfO6amzeiKt
         Sqk6Hq3LvzSmwkv0lD8qiFmslSecqICYG2qGMkmhgXsAuku6VbRO+S+YFDMRdluaZCnQ
         8xEDLBvInMQQ4RbHroBLr7rV7ZojdlvnMOzGKw1CkbpV2304SOs+9FtSJPUcGFBFL6oZ
         ly+PSkhgDJTeMrViO4MTTWW1XlHFel34DFFiDyiDueFlEvlSZUDn8W3AJVWcePLEBDhx
         xcEkPDxpp0u8ejPs82NQmM8CBvyCPff+vfW//5eKPhup+tF0Z1QQbAmQxKBcedKQjU81
         +5PA==
X-Gm-Message-State: AOAM533aRf8E8Rs9WcnowPAw2Os5SEe0Nc48Ji2lxbMpQ5zdi5w9Mxuy
        Zue7TuDqE8beg4Pt43zKG6j2uzDYwAThY3Ch
X-Google-Smtp-Source: ABdhPJyrKGZnDEdiIkYP48wj4MgDg/QzmjF91yzAh6rruKbQJlqMakQDLt0EseLx/+AJ8kaiXaphCarjFxLTkixO
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a959:: with SMTP id
 z25mr4634040qva.51.1605305847433; Fri, 13 Nov 2020 14:17:27 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:58 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <555318f1f88288126b41e3b3d71da8ca8c9b69f2.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 30/42] arm64: mte: Switch GCR_EL1 in kernel entry and exit
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

When MTE is present, the GCR_EL1 register contains the tags mask that
allows to exclude tags from the random generation via the IRG instruction.

With the introduction of the new Tag-Based KASAN API that provides a
mechanism to reserve tags for special reasons, the MTE implementation
has to make sure that the GCR_EL1 setting for the kernel does not affect
the userspace processes and viceversa.

Save and restore the kernel/user mask in GCR_EL1 in kernel entry and exit.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: I0081cba5ace27a9111bebb239075c9a466af4c84
---
 arch/arm64/include/asm/mte-def.h   |  1 -
 arch/arm64/include/asm/mte-kasan.h |  5 ++++
 arch/arm64/include/asm/mte.h       |  2 ++
 arch/arm64/kernel/asm-offsets.c    |  3 +++
 arch/arm64/kernel/entry.S          | 41 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/mte.c            | 31 +++++++++++++++++++---
 6 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
index 8401ac5840c7..2d73a1612f09 100644
--- a/arch/arm64/include/asm/mte-def.h
+++ b/arch/arm64/include/asm/mte-def.h
@@ -10,6 +10,5 @@
 #define MTE_TAG_SHIFT		56
 #define MTE_TAG_SIZE		4
 #define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
-#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
 
 #endif /* __ASM_MTE_DEF_H  */
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 71ff6c6786ac..26349a4b5e2e 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -30,6 +30,7 @@ u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
 void mte_enable_kernel(void);
+void mte_init_tags(u64 max_tag);
 
 #else /* CONFIG_ARM64_MTE */
 
@@ -55,6 +56,10 @@ static inline void mte_enable_kernel(void)
 {
 }
 
+static inline void mte_init_tags(u64 max_tag)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index cf1cd181dcb2..d02aff9f493d 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -18,6 +18,8 @@
 
 #include <asm/pgtable-types.h>
 
+extern u64 gcr_kernel_excl;
+
 void mte_clear_page_tags(void *addr);
 unsigned long mte_copy_tags_from_user(void *to, const void __user *from,
 				      unsigned long n);
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7d32fc959b1a..dfe6ed8446ac 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -47,6 +47,9 @@ int main(void)
 #ifdef CONFIG_ARM64_PTR_AUTH
   DEFINE(THREAD_KEYS_USER,	offsetof(struct task_struct, thread.keys_user));
   DEFINE(THREAD_KEYS_KERNEL,	offsetof(struct task_struct, thread.keys_kernel));
+#endif
+#ifdef CONFIG_ARM64_MTE
+  DEFINE(THREAD_GCR_EL1_USER,	offsetof(struct task_struct, thread.gcr_user_excl));
 #endif
   BLANK();
   DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6f31c2c06788..2f4dca656b34 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -173,6 +173,43 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+	.macro mte_set_gcr, tmp, tmp2
+#ifdef CONFIG_ARM64_MTE
+	/*
+	 * Calculate and set the exclude mask preserving
+	 * the RRND (bit[16]) setting.
+	 */
+	mrs_s	\tmp2, SYS_GCR_EL1
+	bfi	\tmp2, \tmp, #0, #16
+	msr_s	SYS_GCR_EL1, \tmp2
+	isb
+#endif
+	.endm
+
+	.macro mte_set_kernel_gcr, tmp, tmp2
+#ifdef CONFIG_KASAN_HW_TAGS
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	ldr_l	\tmp, gcr_kernel_excl
+
+	mte_set_gcr \tmp, \tmp2
+1:
+#endif
+	.endm
+
+	.macro mte_set_user_gcr, tsk, tmp, tmp2
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
+
+	mte_set_gcr \tmp, \tmp2
+1:
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -212,6 +249,8 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
+	mte_set_kernel_gcr x22, x23
+
 	scs_load tsk, x20
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -330,6 +369,8 @@ alternative_else_nop_endif
 	/* No kernel C function calls after this as user keys are set. */
 	ptrauth_keys_install_user tsk, x0, x1, x2
 
+	mte_set_user_gcr tsk, x0, x1
+
 	apply_ssbd 0, x0, x1
 	.endif
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 6a7adb986b52..02d508391ec7 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -23,6 +23,8 @@
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
+u64 gcr_kernel_excl __ro_after_init;
+
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
@@ -129,6 +131,26 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return ptr;
 }
 
+void mte_init_tags(u64 max_tag)
+{
+	static bool gcr_kernel_excl_initialized;
+
+	if (!gcr_kernel_excl_initialized) {
+		/*
+		 * The format of the tags in KASAN is 0xFF and in MTE is 0xF.
+		 * This conversion extracts an MTE tag from a KASAN tag.
+		 */
+		u64 incl = GENMASK(FIELD_GET(MTE_TAG_MASK >> MTE_TAG_SHIFT,
+					     max_tag), 0);
+
+		gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
+		gcr_kernel_excl_initialized = true;
+	}
+
+	/* Enable the kernel exclude mask for random tags generation. */
+	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
+}
+
 void mte_enable_kernel(void)
 {
 	/* Enable MTE Sync Mode for EL1. */
@@ -171,7 +193,11 @@ static void update_gcr_el1_excl(u64 excl)
 static void set_gcr_el1_excl(u64 excl)
 {
 	current->thread.gcr_user_excl = excl;
-	update_gcr_el1_excl(excl);
+
+	/*
+	 * SYS_GCR_EL1 will be set to current->thread.gcr_user_excl value
+	 * by mte_set_user_gcr() in kernel_exit,
+	 */
 }
 
 void flush_mte_state(void)
@@ -197,7 +223,6 @@ void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
-	update_gcr_el1_excl(next->thread.gcr_user_excl);
 }
 
 void mte_suspend_exit(void)
@@ -205,7 +230,7 @@ void mte_suspend_exit(void)
 	if (!system_supports_mte())
 		return;
 
-	update_gcr_el1_excl(current->thread.gcr_user_excl);
+	update_gcr_el1_excl(gcr_kernel_excl);
 }
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
-- 
2.29.2.299.gdc1121823c-goog

