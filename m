Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BC26AFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgIOVua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgIOVaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:30:16 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042EC061225
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:29 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id l9so1688059wrq.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bCscEPFr1p8biWaTnMvAabXKFPxq9bPZ2kCBns9eE1M=;
        b=dj076h3Hq0EZ5vJsqvWYXNTgDdvEZskWR3MgYexaY/cHXXt/eNQ961DFynen3V5ls3
         1gM+0JhfkHfRhDJv2EgyJpd8fTFxLm+Ie9EAP37+QlOFhJsoOwlIjPNv7pTfIRxQpnEN
         wZQOiN28rW7bBvA4c8d2fnW1qmdR5cJwGsUi5tatyu/J2LGJb4en6ZIwkIh/BSFC/vJ6
         1w6pM4PpIThFUj0A3FikYijkbdliUSF3+7yELSk1fB5ELKjHSFKTwyjOuylsHYFnkRUm
         CYU7gh3lliG2hefWhZp0KC0fuXs2zCDlkOQP0Q/GvkntJVd0BVujYDp8RP9yrNScuDsz
         oW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bCscEPFr1p8biWaTnMvAabXKFPxq9bPZ2kCBns9eE1M=;
        b=BhUVYTzdWZe86wNj9JhUSfC+T1wisDCGgdS9LMRxmzZ/Ift+UZE1Cz/hwhPQBpxmU0
         7o/aYv/bKkXvqU2DI34Oxy6780EMa2xkLG48oCW4dsapRYOZAJajCOM2xVSzFrZ4p41L
         rT2VI7J45akVPxy1LFqnnCQRJVId9Q4eQD46hYvxwDkOgTgoi6W0yEU+yL5pDgbruyU6
         c30eMSw82MzQCjYpAxnoo3S8OLwIH7RuMdMnVSQhrEoPFE6AsZcztCsi+2O9H+5mq7qS
         UiDjFLR4GGGW6b50H7csTYut0zdKMgibl45a2MhIZCp7RrupPgzJkk3b7aH3lYpxfxiH
         imww==
X-Gm-Message-State: AOAM533rsd+G0hvKBwXidJUrHzYzaC7UeyqWviOHthBPWRCSLdZBpdJB
        T0vgJOyoSmk9wpEX0VottMSlvnBWSuta6Z1E
X-Google-Smtp-Source: ABdhPJxLok4nKh03xLUM/OQWLXouOIoUSpe2Vwhf8TfNubNG71ESeL1AFAa3x8/3NFceAmkBHHqlope7y9QQo3dJ
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4d0c:: with SMTP id
 o12mr181612wmh.0.1600204648094; Tue, 15 Sep 2020 14:17:28 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:16:09 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <c801517c8c6c0b14ac2f5d9e189ff86fdbf1d495.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 27/37] arm64: mte: Switch GCR_EL1 in kernel entry and exit
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
Sender: linux-kernel-owner@vger.kernel.org
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
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: I0081cba5ace27a9111bebb239075c9a466af4c84
---
 arch/arm64/include/asm/mte-helpers.h |  6 ++++++
 arch/arm64/include/asm/mte.h         |  2 ++
 arch/arm64/kernel/asm-offsets.c      |  3 +++
 arch/arm64/kernel/cpufeature.c       |  3 +++
 arch/arm64/kernel/entry.S            | 26 ++++++++++++++++++++++++++
 arch/arm64/kernel/mte.c              | 19 ++++++++++++++++---
 6 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mte-helpers.h b/arch/arm64/include/asm/mte-helpers.h
index 5dc2d443851b..60a292fc747c 100644
--- a/arch/arm64/include/asm/mte-helpers.h
+++ b/arch/arm64/include/asm/mte-helpers.h
@@ -25,6 +25,8 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
+void mte_init_tags(u64 max_tag);
+
 #else /* CONFIG_ARM64_MTE */
 
 #define mte_get_ptr_tag(ptr)	0xFF
@@ -41,6 +43,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
 }
 
+static inline void mte_init_tags(u64 max_tag)
+{
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 82cd7c89edec..3142a2de51ae 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -15,6 +15,8 @@
 
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
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index eca06b8c74db..3602ac45d093 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1721,6 +1721,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 
 	/* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
+		/* Enable the kernel exclude mask for random tags generation */
+		write_sysreg_s((SYS_GCR_EL1_RRND | gcr_kernel_excl), SYS_GCR_EL1);
+
 		/* Enable MTE Sync Mode for EL1 */
 		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
 		isb();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ff34461524d4..79a6848840bd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -175,6 +175,28 @@ alternative_else_nop_endif
 #endif
 	.endm
 
+	.macro mte_restore_gcr, el, tsk, tmp, tmp2
+#ifdef CONFIG_ARM64_MTE
+alternative_if_not ARM64_MTE
+	b	1f
+alternative_else_nop_endif
+	.if	\el == 0
+	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
+	.else
+	ldr_l	\tmp, gcr_kernel_excl
+	.endif
+	/*
+	 * Calculate and set the exclude mask preserving
+	 * the RRND (bit[16]) setting.
+	 */
+	mrs_s	\tmp2, SYS_GCR_EL1
+	bfi	\tmp2, \tmp, #0, #16
+	msr_s	SYS_GCR_EL1, \tmp2
+	isb
+1:
+#endif
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -214,6 +236,8 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
+	mte_restore_gcr 1, tsk, x22, x23
+
 	scs_load tsk, x20
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -332,6 +356,8 @@ alternative_else_nop_endif
 	/* No kernel C function calls after this as user keys are set. */
 	ptrauth_keys_install_user tsk, x0, x1, x2
 
+	mte_restore_gcr 0, tsk, x0, x1
+
 	apply_ssbd 0, x0, x1
 	.endif
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 858e75cfcaa0..1c7d963b5038 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -18,10 +18,13 @@
 
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
+#include <asm/kprobes.h>
 #include <asm/mte.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
+u64 gcr_kernel_excl __ro_after_init;
+
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
@@ -120,6 +123,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return ptr;
 }
 
+void mte_init_tags(u64 max_tag)
+{
+	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
+
+	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
@@ -155,7 +165,11 @@ static void update_gcr_el1_excl(u64 excl)
 static void set_gcr_el1_excl(u64 excl)
 {
 	current->thread.gcr_user_excl = excl;
-	update_gcr_el1_excl(excl);
+
+	/*
+	 * SYS_GCR_EL1 will be set to current->thread.gcr_user_incl value
+	 * by mte_restore_gcr() in kernel_exit,
+	 */
 }
 
 void flush_mte_state(void)
@@ -181,7 +195,6 @@ void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
-	update_gcr_el1_excl(next->thread.gcr_user_excl);
 }
 
 void mte_suspend_exit(void)
@@ -189,7 +202,7 @@ void mte_suspend_exit(void)
 	if (!system_supports_mte())
 		return;
 
-	update_gcr_el1_excl(current->thread.gcr_user_excl);
+	update_gcr_el1_excl(gcr_kernel_excl);
 }
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
-- 
2.28.0.618.gf4bc123cb7-goog

