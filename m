Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094DB2AA936
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgKHFS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgKHFRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D02C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so5329327wrc.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Wis55H0eFlqwW8/U6+ywrZRHli9oK16qYa+/pAEFZo=;
        b=Sw6aLn97HjMRklLJAFpFgxGseF6Z8Z2d4d60v0JoiHHSnXO8pc3rzHSFOeSqCOk0Jd
         wGkbNN0pHbs+NQ7wbMCP8oJhIGm/Nkzv4PZBIFKFRa8UrsfL2DZxUIb2HKLPNgXvA8RL
         E1qfFCpPQvMktrLplU4pj6Ey4skAhGI8QTHqMdSBaHr+nF07FwBQUmuLuNEd/kWyDOsI
         NhpLg8ZO/v3aZCgUFwJKqc/91OluIGtAp9+hDKSlVOPNeceZkIRY4Hhq1nRfbf7v7OQo
         30mmamX/2sEwmS2fFYNqPx3m/9Cy6jrKN9NGbbFCyvc8k7cPbtuKCz7uAntbxJEjxI1Y
         HgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Wis55H0eFlqwW8/U6+ywrZRHli9oK16qYa+/pAEFZo=;
        b=J69IIuPM+rxfHmDh3RmRiBksGzva+PqBV7TerfaMHb0VFz+GfXXTxnh9FyLO9E7QUQ
         PS0iBQxqXuQ9y5Lx0g+RhItBcofEvnH8/C2uPG1O+UBM8N+iA3VOV8yZTnPBNrXihfVY
         xBswbbn9qN0oljTJscCFuZ/W09aZjXCAQAKIdp329tYu01jqVxa8Y0SWw7cwRvMWq3bf
         iHEjvIOtMfouHJUSxaOcG4LVFz3rLk5ORuQAa5CdrOuiChiBord0mzMJBq9tOqa94G36
         KW/uAz8/qO/OX2qzDuaUQqHo+pbiSG4LWz4l4WYhH1pN5VekG4e/cUhhHZ5+Knh2JMR0
         sm6Q==
X-Gm-Message-State: AOAM532zpuWRkXqyBG3EEaptNIOrvaJNyP73ia+0ZlcuBQUMKY1m/ot7
        Bdzk9Nn0ElBSG9tyMEO4TZuMi7npZfWKAhmw
X-Google-Smtp-Source: ABdhPJzPRzT6VFcifR1x1oBTWzQnMHql7D5xiWxkXlnNaO0K40qHBV2TkLEIy1kAK2u1NulcAMFVrw==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr10958474wrr.300.1604812669209;
        Sat, 07 Nov 2020 21:17:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:48 -0800 (PST)
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
Subject: [PATCH 12/19] x86/signal: Land on &frame->retcode when vdso isn't mapped
Date:   Sun,  8 Nov 2020 05:17:22 +0000
Message-Id: <20201108051730.2042693-13-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
a.out signals") after processing 32-bit signal if there is no vdso
mapped frame->retcode is used as a landing.
Do the same for rt ia32 signals.

This shouldn't be mistaken for encouragement for running binaries with
executable stack, rather something to do in hopefully very rare
situation with disabled or unmapped vdso and absent SA_RESTORER.
For non-executable stack it'll segfault on attempt to land, rather than
land on a random address where vdso was previously mapped.
For programs with executable stack it'll just do the same for rt signals
as for non-rt.

Discouraging users to run with executable stack is done separately in
commit 47a2ebb7f505 ("execve: warn if process starts with executable
stack").

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/ia32/ia32_signal.c | 12 +++++++-----
 arch/x86/kernel/signal.c    | 23 ++++++++++-------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 81cf22398cd1..ea3db15b57bf 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -270,8 +270,8 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 	/*
-	 * These are actually not used anymore, but left because some
-	 * gdb versions depend on them as a marker.
+	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	user_access_end();
@@ -336,14 +336,16 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
-	else
+	else if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_rt_sigreturn;
+	else
+		restorer = &frame->retcode;
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 
 	/*
-	 * Not actually used anymore, but left because some gdb
-	 * versions need it.
+	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
 	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ea794a083c44..372ec09dc4ac 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -317,23 +317,20 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	unsafe_put_user(sig, &frame->sig, Efault);
 	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	if (current->mm->context.vdso)
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
 		restorer = &frame->retcode;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
 
 	/* Set up to return from userspace.  */
 	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
 	/*
 	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
 	user_access_end();
@@ -382,18 +379,18 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
 	/* Set up to return from userspace.  */
-	restorer = current->mm->context.vdso +
-		vdso_image_32.sym___kernel_rt_sigreturn;
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
+	else if (current->mm->context.vdso)
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+	else
+		restorer = &frame->retcode;
 	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
 	/*
 	 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
+	 * gdb uses it as a signature to notice signal handler stack frames.
 	 */
 	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
 	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-- 
2.28.0

