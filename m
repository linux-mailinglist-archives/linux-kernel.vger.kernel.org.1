Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3882AA92D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKHFSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKHFR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1DC0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so5098388wmm.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJo4NJDNG1P32pfdiK6qTmwCPGbFDEEHy5zNr4wBr24=;
        b=AGAilGIvOqeJ+SKiMKGXGZ/ISTN8hS/VfK9gs+9QwISNAbZku50Qk7wluelqBJ6kbe
         4ANV8HNBWB7HNIw6V1hilfEAfP0FIeoXAj28uB3n3SgTxjj2kC10k4rW4V13S3agH0Ng
         Dyd4zVbgiCt4+Seu/ofV09cR5iI8JrjElJ/Df2AfHw0A1rt4rz8Rvf7coehfcX2WI7o9
         a7Bj98iNZewX4kLg7h/bs4M26kLIlGlFE6ftS2ptEgs6pO+AqoQZ5Aw5EVDShLK1ZP5k
         KN8xw0fLMQNFZA0R8vuES3sYsnZjZETSYpkxECpmxYBoMbtYP1ys07EuY1ZiqYXGfg1A
         yBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJo4NJDNG1P32pfdiK6qTmwCPGbFDEEHy5zNr4wBr24=;
        b=sV4N/85rv9J/KGUyRIJJvWLgYtBWyycCI2tyl/CHJHYmLvgLuLs9sTLxZOBxc47zsv
         SehpzdmMaCB7MEuNqd3TcFgMwT8Hb+2+gKcQ92i47dPSZs9oCusGpH03XnjfwJ6xnlRf
         oiXf3hykbRFGN6dItQboge2JquDjVXIuhZ8yQdlLd9ITGqt1iYn1qruV89d/Z/SQtVCd
         awfC+vHkhXLMM5j8OJmWq6EGbnFFxHAA4n3+Aeq90ND1v/h972PuOlwy2y/oYucxrR9W
         v5uO1AwieUQrMy1DUIL82fpdGczpWRufyq6hM6oklcgB0dcTsFneWEiIP8NKdY2q9KRr
         UCLw==
X-Gm-Message-State: AOAM533joWXDGlxc4uD+8jwP/BHoUx00kteOH2FwHvDz3pyYvygrbJDU
        7JbjId5zYSKaRlvnF2V8p1x8L2Y3tAD5ibIb
X-Google-Smtp-Source: ABdhPJyfXymifjn309sLGsQwZMT9ClM6crIQICSx7N4tqkR9CmakNpsxnYh/CMQ2HrdLqWzR+PjttQ==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr7548867wmj.187.1604812677226;
        Sat, 07 Nov 2020 21:17:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:56 -0800 (PST)
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
Subject: [PATCH 18/19] arm64/vdso: Migrate native signals to user_landing
Date:   Sun,  8 Nov 2020 05:17:28 +0000
Message-Id: <20201108051730.2042693-19-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/kernel/signal.c | 10 +++++++---
 arch/arm64/kernel/vdso.c   | 13 +++----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index bec6ef69704f..4c1dfbc1aed3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -723,9 +723,10 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	return 0;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static int setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			 struct rt_sigframe_user_layout *user, int usig)
 {
+	unsigned long land = (unsigned long)current->mm->user_landing;
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
@@ -754,10 +755,13 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
+	else if (land != UNMAPPED_USER_LANDING)
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
index 08e8f1d56d92..d710fcd7141c 100644
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
@@ -247,12 +240,14 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ERR(ret))
 		goto up_fail;
 
+	/* 32-bit ABI is to land on sigpage, 64-bit on vdso */
+	if (abi == VDSO_ABI_AA64)
+		mm->user_landing = (void __user *)vdso_base;
 	*sysinfo_ehdr = vdso_base;
 
 	return 0;
 
 up_fail:
-	mm->context.vdso = NULL;
 	return PTR_ERR(ret);
 }
 
@@ -285,7 +280,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
@@ -431,7 +425,6 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
-- 
2.28.0

