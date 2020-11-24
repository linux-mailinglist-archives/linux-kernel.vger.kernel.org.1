Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25722C1A07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgKXAaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgKXAaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:30:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CFC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so20564196wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hka8X9h2wDZIdkgrxCYWyIWsJuDTXXiC3fCdlayvJA4=;
        b=ROKe6JdBGP+Ba/LKQ48eUI4vbwgoVyVHGnRpALvZMqwlyspyggPrbAo2GvhlrEjIBb
         4JkQwPnVPSx2M+lC0tbpQq9YicgOlUn4wdEVWTXrz5H4GHHuLlUton0bv4Jcg1TTvWgi
         uJBdXTe8sTBlRXQ25iWhxULoD+jU412IxI1YEAbEqOorK/Zr6yc0toLNSMze3goruWRe
         Lf6a9uC7BnFI4nrcYXZlFXhwBvuNsbe6DckbsUjvKJY4kdGBqt7Xn4ZOPEBAXtrdzekW
         LMu896cj/+9moMWWQ2BfICvXozOsPWKEZS2MOsdYG2ujL5KTA1k68LUW04ea6Hyhke7T
         Qldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hka8X9h2wDZIdkgrxCYWyIWsJuDTXXiC3fCdlayvJA4=;
        b=QanNJkr/HiKu+RMkugnsQwUy4wq2gE7AIUGKcT84yE/PsqbX1dJSC3C52lN1iqU+Om
         9zNe1GuOgVqH4YSinEZieXzjclB3oYezCrcRdIvdPYsrZiOV3nIZEtXzYkrtro273Rai
         MzTMi0pdcCpOz/G0D28Uc+bF1UydG9hAotwyFr2YsNowA8ubk1rvmDcZnJgfvMp1QaCl
         dODBAmkWoCj/XJsLiZ1WMa3UTq34iC24m5JllW8UHu8gxw+6CtftbUA7S5rxif7t7ERJ
         0zwAG4q2tBmZjvVos0riJFzHbpmQno1+jMFBphn2/9C0p1Bdp3h+yaiGgGvwF2LW+4/x
         lK6A==
X-Gm-Message-State: AOAM5337OPYX35OMfaR5LqPT9QKlqhyqvP4sDaG0+vx25UiMMfIB8wCz
        Uuhmfo2lB+1rduPSSZRYvHi33vipHcR+hhNw
X-Google-Smtp-Source: ABdhPJywf4ACkRl7eXO0eblfADsEDSVDS8s6eIORdX3QPot7zS0Ovv5tBSqAmG2mDG1/CBX5qKxbhQ==
X-Received: by 2002:adf:f245:: with SMTP id b5mr2239016wrp.354.1606177800328;
        Mon, 23 Nov 2020 16:30:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:59 -0800 (PST)
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
Subject: [PATCH v2 17/19] arm64/vdso: Migrate compat signals to generic vdso_base
Date:   Tue, 24 Nov 2020 00:29:30 +0000
Message-Id: <20201124002932.1220517-18-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the landing vma area.
As a bonus, after unmapping sigpage, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/signal32.c | 17 ++++++++++++-----
 arch/arm64/kernel/vdso.c     |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 35d8e4acd38d..a93ec99644b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..3d2ac8062e99 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -315,7 +315,7 @@ static void __user *compat_get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static int compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 				compat_ulong_t __user *rc, void __user *frame,
 				int usig)
 {
@@ -342,13 +342,16 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+		unsigned long land = (unsigned long)current->mm->vdso_base;
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = (unsigned long)current->mm->context.sigpage +
-			  (idx << 2) + thumb;
+		if (land == UNMAPPED_VDSO_BASE)
+			return 1;
+
+		retcode = land + (idx << 2) + thumb;
 	}
 
 	regs->regs[0]	= usig;
@@ -356,6 +359,8 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->compat_lr	= retcode;
 	regs->pc	= handler;
 	regs->pstate	= spsr;
+
+	return 0;
 }
 
 static int compat_setup_sigframe(struct compat_sigframe __user *sf,
@@ -425,7 +430,8 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 	err |= compat_setup_sigframe(&frame->sig, regs, set);
 
 	if (err == 0) {
-		compat_setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
+		err = compat_setup_return(regs, &ksig->ka,
+					  frame->sig.retcode, frame, usig);
 		regs->regs[1] = (compat_ulong_t)(unsigned long)&frame->info;
 		regs->regs[2] = (compat_ulong_t)(unsigned long)&frame->sig.uc;
 	}
@@ -448,7 +454,8 @@ int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 
 	err |= compat_setup_sigframe(frame, regs, set);
 	if (err == 0)
-		compat_setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
+		err = compat_setup_return(regs, &ksig->ka,
+					  frame->retcode, frame, usig);
 
 	return err;
 }
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 91c1b7c716b7..03a6519d50cd 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -394,7 +394,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	if (IS_ERR(ret))
 		goto out;
 
-	mm->context.sigpage = (void *)addr;
+	mm->vdso_base = (void __user *)addr;
 
 out:
 	return PTR_ERR_OR_ZERO(ret);
-- 
2.29.2

