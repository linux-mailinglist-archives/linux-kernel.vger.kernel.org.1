Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98252C1A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgKXAaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgKXA34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:56 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1EC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:56 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so973324wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEfHDSC1rUUvQppED0ej2b0l4ko6b4Zmo785jR6gKvA=;
        b=AeDvFa18xVWOs/YJjzQlMRv/rNBZ64Lkj9FBKDxX2YFYKmNIWG06OPQjetn3Rw+RjT
         JtGvpOY/1j92fLOSINEKJV/ElpXxdFC/lnkQtDUeRVSmvuYNwqUwI7Y8Ln0Pg88B5xsS
         Sb34Avbo/gcwMhz2TOOjQpIVETQDvWg3ptwl0hEP3VJVxUGRpajsoc88daclM5UUzGrX
         YDSeuocBSrNEA8FGPhzrE6IwJ9pqayfnn+MTpfllcvmNRyag7AA2RJjeTvHp3PBje8jt
         A69er/rueKcmvsGWSvVMfXQbAiWuwjYu9zxYPLufowuihqe8CWwEk7Z6TrwBuonrX1Go
         yhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEfHDSC1rUUvQppED0ej2b0l4ko6b4Zmo785jR6gKvA=;
        b=fS85WahP7j5jETFn671OELM/2Bv9YwUjwOcXfwXaUPEAQB3dLWfJ23+HTwlnzLuNAd
         MqqNPV1ebMHAjioGqBikkEkHshe+LScofkbupvQl5wut1S84MPi9nFCz41Wb/pEHrVjj
         1jjeeb/osSArlUMbs8MaJiblwaT/K97TakztH/WwgYs4cZAhFow1X9l6lJv6lDd/qrCx
         NapgGY3cbrtS9PUWgmW/kEakMdSTCE60tl6GDNmYoqA3Y/0I62QG1wzFioduNkXo7tqu
         7C+dJF24YoQGpaLxTHw+mAx2EHh1Bb1juJIrMfBVaQ8mIL5jkpN+/4Ua7+zhb+f2Do37
         eCwg==
X-Gm-Message-State: AOAM532TBgCEgTsOIrlmL57ztcXwaRy/vZcs/IFc6kIfae/Tseyoqm4o
        pGjT61/l2SOz6mXsZepa61eT9aMvLhfLNWV5
X-Google-Smtp-Source: ABdhPJyftVjNghxkaLCCsBP4wBr7Ry/RkgjW4RlirffSiBTMAaPEkPPvt5DLRFHMUsILggsjDLI8hQ==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr1401543wml.174.1606177794679;
        Mon, 23 Nov 2020 16:29:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:54 -0800 (PST)
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
Subject: [PATCH v2 13/19] x86/signal: Check if vdso_image_32 is mapped before trying to land on it
Date:   Tue, 24 Nov 2020 00:29:26 +0000
Message-Id: <20201124002932.1220517-14-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide current_has_vdso_image_32() helper and check it apriory landing
attempt on vdso vma.
The helper is a macro, not a static inline funciton to avoid
linux/sched/task_stack.h inclusion in asm/vdso.h.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/common.c     | 7 ++++++-
 arch/x86/ia32/ia32_signal.c | 4 ++--
 arch/x86/include/asm/vdso.h | 4 ++++
 arch/x86/kernel/signal.c    | 4 ++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 18d8f17f755c..d9ab58cc765b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -142,11 +142,16 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
 __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned long landing_pad;
+
+	if (!current_has_vdso_image_32())
+		force_sigsegv(SIGSEGV);
+
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
+	landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
 
 	/*
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index ea3db15b57bf..f87ed1d53938 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -255,7 +255,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 		restorer = ksig->ka.sa.sa_restorer;
 	} else {
 		/* Return stub is in 32bit vsyscall page */
-		if (current->mm->context.vdso)
+		if (current_has_vdso_image_32())
 			restorer = current->mm->context.vdso +
 				vdso_image_32.sym___kernel_sigreturn;
 		else
@@ -336,7 +336,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso_image_32())
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index b5d23470f56b..e3829c3a6149 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -41,6 +41,10 @@ extern const struct vdso_image vdso_image_x32;
 
 #if defined CONFIG_X86_32 || defined CONFIG_COMPAT
 extern const struct vdso_image vdso_image_32;
+
+#define current_has_vdso_image_32()					\
+	likely(current->mm->context.vdso_image == &vdso_image_32 &&	\
+		!!current->mm->context.vdso)
 #endif
 
 extern void __init init_vdso_image(const struct vdso_image *image);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 372ec09dc4ac..6fed2e523e0a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -319,7 +319,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso_image_32())
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
@@ -381,7 +381,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up to return from userspace.  */
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else if (current->mm->context.vdso)
+	else if (current_has_vdso_image_32())
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
-- 
2.29.2

