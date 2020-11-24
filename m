Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA62C1A09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgKXAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbgKXAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:30:03 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47105C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:03 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so1202138wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6ONlLGCp/bVglrhHe4YoZJAyCoe2DsbyvzmZF0Mhmg=;
        b=QJ5As3JGW88m9mwfUWtvqghO7Cn/uKM5IefM3ELdYMm2dnSEHIlq5JpYkwprnQnnIn
         ZR1MYveFYhwitI4XA8wLdgXdozwS4D99kowi2aaoJ3KaeM1Zoe9kzp8qQxdMqio7RIr6
         NoP2ucqhweJWb6TtFxNdisqLt5jm/URdZFnm2SYj6FM+3bc0NkT4EXkmraWsX8RXeQFI
         4LZwjeIHVe6CamnHHcAX2bJsIrHBefE2hxL67qdu6nkWF3hu3MjrWzcSBmaNzYEDCaLA
         jc1z7iubU1WBAbaykvH8tQc5tV0vuf6wnn/FlO+2IRdY2eTAZ92lvoVNRJ3KFUSDpb4C
         m9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6ONlLGCp/bVglrhHe4YoZJAyCoe2DsbyvzmZF0Mhmg=;
        b=Qe0tjQDuc/ZIuxPsmsdn0cRYt8DCaO1VFDAAlHcuV7uM97CLwqmntiyddBfXOn31qQ
         auofiYREdAjXKMX891nvnZhjpexZqP/e3sq9ZtrPtPK/q6hCKPRzOxCUeNIUEwSBfuWK
         jrMQqZk838dCdLAGsxdMRsB8uicQV/FFZv2wVyXQzBXEFDcE1sSIJgKdIdFlUKfE4mCh
         GCrq1Qta88L4qkjqtvKEaSMK0vlZtJbMs3fcjoe7Ldv3ukPQYNp1P3Lr+z2ARoArk9PH
         VTB1OchXxwRtPiVIJsstn3vxqnMcJMRAkytHgv8gWHPa/GBIDeSzv1E9SEwTyFQF+Zul
         SHUQ==
X-Gm-Message-State: AOAM531b78NB57YYIt3jh7tDwmXunDxxM1/hNaA0bmqGNKIYnKu7chTA
        tK3C3DzOOQmQKL3eOKw6tY373A7+U7N13w1T
X-Google-Smtp-Source: ABdhPJwcXI8NRQGC8IuLyH9JTlmG/VLi5DRqIRsNiNyofoL88NHSIEe4yzlFQ9sqyUf3QqN8ohXy3A==
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr1515710wmd.12.1606177801746;
        Mon, 23 Nov 2020 16:30:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:30:01 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v2 18/19] arm64/vdso: Migrate native signals to generic vdso_base
Date:   Tue, 24 Nov 2020 00:29:31 +0000
Message-Id: <20201124002932.1220517-19-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/kernel/signal.c | 10 +++++++---
 arch/arm64/kernel/vdso.c   | 16 ++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index bec6ef69704f..96e8988f033d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -723,9 +723,10 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	return 0;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static int setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			 struct rt_sigframe_user_layout *user, int usig)
 {
+	unsigned long land = (unsigned long)current->mm->vdso_base;
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
@@ -754,10 +755,13 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
+	else if (land != UNMAPPED_VDSO_BASE)
+		sigtramp = VDSO_SYMBOL(land, sigtramp);
 	else
-		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+		return 1;
 
 	regs->regs[30] = (unsigned long)sigtramp;
+	return 0;
 }
 
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
@@ -780,7 +784,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
+		err = setup_return(regs, &ksig->ka, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 03a6519d50cd..5b44463b739a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -78,12 +78,6 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-static void vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.vdso = (void *)new_vma->vm_start;
-}
-
 static int __vdso_init(enum vdso_abi abi)
 {
 	int i;
@@ -239,7 +233,6 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		gp_flags = VM_ARM64_BTI;
 
 	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
@@ -247,12 +240,17 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ERR(ret))
 		goto up_fail;
 
+	/*
+	 * 32-bit ABI is to land on sigpage (see aarch32_sigreturn_setup()),
+	 * 64-bit on vDSO.
+	 */
+	if (abi == VDSO_ABI_AA64)
+		mm->vdso_base = (void __user *)vdso_base;
 	*sysinfo_ehdr = vdso_base;
 
 	return 0;
 
 up_fail:
-	mm->context.vdso = NULL;
 	return PTR_ERR(ret);
 }
 
@@ -285,7 +283,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
@@ -431,7 +428,6 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
-- 
2.29.2

