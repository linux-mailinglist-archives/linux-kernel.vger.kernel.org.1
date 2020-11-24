Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2107D2C1A03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKXA35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgKXA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4054C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t4so7642187wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ntv+KONJUb78/ESDloSvWIlBNF2WtF5S7J/XXTw9XE=;
        b=YkOwoSmtyb5mpKRzQKxF7YvwIfYklUS61a6sZCJM8MlxXV338aYhnUHdqICUcBIKVJ
         Mgzxn81p1yyQqPokCM9kbjiZJDiCK0iy4cbmvsQYl3aX+RhNKexuUbS+jLCMz5Fvpgb2
         Se+Tai94ydoXDBOpGbwD1MHKrPGy69KFjauwmWK5MqjNwr5yzJh3GRBDbDDcUuBJtf5U
         p2OwDEiu5vhMENq3qOI6wsmCGVgwGujrVs9YbgO0mQZULgWTKeIAjCAa580TCQnTL/PR
         dc5vM91271GyjH073UaA6lAlou9mQ+dj5oZ2gxy57w5z0YFslSncz1QJ1f01ZOxL1Ztv
         4Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ntv+KONJUb78/ESDloSvWIlBNF2WtF5S7J/XXTw9XE=;
        b=DuOOVPvdqiInAF1ogSfaJTWSNd2yg+R7ZkHbgEXm51fBXrlwTSwhwLW+kP+kD1Jv+p
         95LpraKIuDN+QwrdjilVI2snSgD+igAk5nCyNYL+SAviQ4FZ03tAQAgBzVk6L+TSXLXq
         atfeysZ1QyDBxdWE13ggQbAQluDBRAfuRffZZBG993v542+8QoCVaMg1Ltb50KdE70ww
         qEljj2AIlJUBI0OrVy3ccE6iTXjIGmK9N/HX54vnt68+9yjNH4MNJYJr2C+9ezsWByDp
         TEo/kv8hcuMX/nhRa3FAoZkrzLvqesWv4Y6pHNjQF0vx7pu6n3s/gorEN6wsqe2QuEeJ
         vXQA==
X-Gm-Message-State: AOAM533bs+yUt9Up22bcnNgdAaVyhu89d5CgG1EXOmsQuZB23XsWw+BO
        vtDahRq25ChzRWJcyS4+6BaaHcmsJB0xPFFp
X-Google-Smtp-Source: ABdhPJxVDXuTizyubZhFqrEBeClT0OVR30m3CXjIjhVZa2il/WcfesGLRU6z3011oYomYv0i6U0dyQ==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr2125054wrn.427.1606177793358;
        Mon, 23 Nov 2020 16:29:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:52 -0800 (PST)
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
Subject: [PATCH v2 12/19] x86/signal: Land on &frame->retcode when vdso isn't mapped
Date:   Tue, 24 Nov 2020 00:29:25 +0000
Message-Id: <20201124002932.1220517-13-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9fbbd4dd17d0 ("x86: Don't require the vDSO for handling
a.out signals") after processing 32-bit signal if there is no vdso
mapped frame->retcode is used as a landing.
Do the same for rt ia32 signals.
It also makes the ia32 compat signals match the native ia32 case.

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
2.29.2

