Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB132280B2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgJAXMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387600AbgJAXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48AC0613E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x191so55928qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eriXeedY9+UywDi2qWo7RghhjAzjAQSNbHMqcD58SBQ=;
        b=eqamaMyGZKJH6XI2Oszq/kJcbN+cIgZXAWWpRNUZVsAgU04Aigj2taatMYnlUmxqcg
         BphADtmDSEqsibigWmHqz7wn6y4PwLA2HgJA3UnW5H2kquhoC6gbMxPczpN3Z9tDUxn9
         oVFd7KPtstYk3r6WPzmynq6os5x0/uc4t0IymA4a16OHEasVx5Jd7Ha43rhzQx5KJaIf
         cUguGEf7GAVEyMDCLCkUPNpdqvGIHMRcMdMA5m5ZNEY3BWeoSU53LbDE2rgpek1BgnLS
         D7vZ37MpIf/nlTM1gLexmzKFDs7fInGXCGvmlu9AmGpNd2Gw6No/zbfC/8eMNADA0ayG
         ITcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eriXeedY9+UywDi2qWo7RghhjAzjAQSNbHMqcD58SBQ=;
        b=LH/RPZSZTKfwP/eTbMrdexiPBjblmR57Zb1AefdxI4VIK3DP8wi/mRysfqXi7TUdZw
         +Zfch0pqoa3lM+8FtgSIMMysHjjFfOvsMIYLXoHjcGH4ePO0oU/Pel/9ziVCjHgEE77t
         mD4qw2Pdfdu7T+h51AwNRuSkzK6SKTYgoJQ6kuCphDMjC98yBRPk6iu2uq5gyapTCaF1
         sby+/h8/A0psfxd+QhcRKj1rOlrD+w54/4z2/GjoxrG+YVfRcpyPMoeHDZJrUgESBdz4
         Lnd8TnpKoyVc1/zfyLE0d9/ZvchIIBphGWNO4wDHo6HkX72L6i3IG+4CK6y1QvfjrvRs
         hg0A==
X-Gm-Message-State: AOAM530Wn2Eg/rtTL1CH4wVIzkInOGchIVX0zoMbfViT6pUO7RujfBPx
        uGlOUjJLy0hSxqfTOC4w9hW5Nm4hc0NKirmo
X-Google-Smtp-Source: ABdhPJzcVkBhr6dhDe2B3hByZ4QRlMn8UGMRK6jnqwNcEHwpnrJPzZp0ybnOwPaNERfNQmcVXCEfJdFYokyTzpW2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:58aa:: with SMTP id
 ea10mr10043170qvb.58.1601593913975; Thu, 01 Oct 2020 16:11:53 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:30 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <1f2681fdff1aa1096df949cb8634a9be6bf4acc4.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 29/39] arm64: mte: Switch GCR_EL1 in kernel entry and exit
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
 arch/arm64/include/asm/mte-kasan.h |  6 +++++
 arch/arm64/include/asm/mte.h       |  2 ++
 arch/arm64/kernel/asm-offsets.c    |  3 +++
 arch/arm64/kernel/cpufeature.c     |  3 +++
 arch/arm64/kernel/entry.S          | 41 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/mte.c            | 18 ++++++++++---
 6 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 3a70fb1807fd..a4c61b926d4a 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -29,6 +29,8 @@ u8 mte_get_mem_tag(void *addr);
 u8 mte_get_random_tag(void);
 void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
+void mte_init_tags(u64 max_tag);
+
 #else /* CONFIG_ARM64_MTE */
 
 static inline u8 mte_get_ptr_tag(void *ptr)
@@ -49,6 +51,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
 	return addr;
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
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index eca06b8c74db..e76634ad5bc7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1721,6 +1721,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 
 	/* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
+		/* Enable the kernel exclude mask for random tags generation */
+		write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
+
 		/* Enable MTE Sync Mode for EL1 */
 		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
 		isb();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ff34461524d4..eeaac91021bf 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -175,6 +175,43 @@ alternative_else_nop_endif
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
@@ -214,6 +251,8 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
+	mte_set_kernel_gcr x22, x23
+
 	scs_load tsk, x20
 	.else
 	add	x21, sp, #S_FRAME_SIZE
@@ -332,6 +371,8 @@ alternative_else_nop_endif
 	/* No kernel C function calls after this as user keys are set. */
 	ptrauth_keys_install_user tsk, x0, x1, x2
 
+	mte_set_user_gcr tsk, x0, x1
+
 	apply_ssbd 0, x0, x1
 	.endif
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 7c67ac6f08df..d1847f29f59b 100644
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
@@ -120,6 +122,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
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
@@ -155,7 +164,11 @@ static void update_gcr_el1_excl(u64 excl)
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
@@ -181,7 +194,6 @@ void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
-	update_gcr_el1_excl(next->thread.gcr_user_excl);
 }
 
 void mte_suspend_exit(void)
@@ -189,7 +201,7 @@ void mte_suspend_exit(void)
 	if (!system_supports_mte())
 		return;
 
-	update_gcr_el1_excl(current->thread.gcr_user_excl);
+	update_gcr_el1_excl(gcr_kernel_excl);
 }
 
 long set_mte_ctrl(struct task_struct *task, unsigned long arg)
-- 
2.28.0.709.gb0816b6eb0-goog

