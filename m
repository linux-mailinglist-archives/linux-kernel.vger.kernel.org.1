Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1372AA933
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgKHFSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbgKHFSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:18:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45929C0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so5090387wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDIDvYZOPjTtxvl36Gh43D1VS6edK8laVREVVoepQiM=;
        b=NYjlJ+WzFO3FlcEZCMSG47J72mOKj60UAc5KsKwVNuPzO6r6qlBxJAd4yS9a9rC2VD
         P6+dUu/rRgYsLVSkqjGkmFGdzIcyUOExwQreu2WiEY27YfT8e9TdJmIfHZ92SvC6ug/a
         pYmz0XJ6v6OHFPI/7ISzENMPiWQ2ApqJoRaiya+4Z4mPuv+xs/8de/CxRNYCdIAQguGs
         KAOjWqINtA7SjquBhcQU9QhcQFLEXofAqLn0NEPu0pVXkCJXaQJFsMF9YUSdYbf6qEK2
         IVEaAfBwucZcBvU9H6jqJflvmXRYR/c2p0l/mft+sPoI58AAIIsebZswMkQpQqphgMZs
         mnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDIDvYZOPjTtxvl36Gh43D1VS6edK8laVREVVoepQiM=;
        b=Yle6S6HGaXIimTQZEueMR8ozNckfxqKpiF8FqEkEZA8/RFEDqMcOmGtkUyn+vv1iCb
         P558M7cjh2Q9p0g0uFNGuQFZHSmLzx7HmPCf1xpY5R2sTwaiUtuDlfTRSs0pyTDQ8tk/
         GZIt0M4BitXLyGAgqA26Qs7PK5XRXvo0uLvXtAWcLYT9jGkYV2RwQm17L2Lvk5LE9KLR
         MO22df8Nf/BnKT4U3EOnXhoEVF2pXmEquwWpaDAcFi6XF8dvheeXneLSG0hRuDYyLT9A
         ymM6rWOzdcoY9ezIYGAdOlnXBsZsCtUqktMU8JjN09CAelvnKILzZnOpkrwMw5uVQEKv
         fboA==
X-Gm-Message-State: AOAM5330m+5zN1tNsyai9lOFH5ZjIfpQdKC3dxh15qbulRqN/0gph3cG
        hULqKAMw0K7osGKimGdQV+FzManEoDLXQZxq
X-Google-Smtp-Source: ABdhPJwBK0sFWqEWY6I0XX+LMZKR8zTKC/oidDVzgGAbW101EqzqLzBXSdyYjTsW/pm/HmhKFstAgA==
X-Received: by 2002:a1c:448:: with SMTP id 69mr7425060wme.12.1604812675880;
        Sat, 07 Nov 2020 21:17:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:55 -0800 (PST)
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
Subject: [PATCH 17/19] arm64/vdso: Migrate compat signals to user_landing
Date:   Sun,  8 Nov 2020 05:17:27 +0000
Message-Id: <20201108051730.2042693-18-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping sigpage, kernel won't try to land on its
previous position.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/kernel/signal32.c | 17 ++++++++++++-----
 arch/arm64/kernel/vdso.c     |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7111cf335ede..56505e396253 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -38,6 +38,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_USER_LANDING
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..61d583c73be3 100644
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
+		unsigned long land = (unsigned long)current->mm->user_landing;
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = (unsigned long)current->mm->context.sigpage +
-			  (idx << 2) + thumb;
+		if (land == UNMAPPED_USER_LANDING)
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
index 91c1b7c716b7..08e8f1d56d92 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -394,7 +394,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	if (IS_ERR(ret))
 		goto out;
 
-	mm->context.sigpage = (void *)addr;
+	mm->user_landing = (void __user *)addr;
 
 out:
 	return PTR_ERR_OR_ZERO(ret);
-- 
2.28.0

