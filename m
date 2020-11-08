Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7042AA930
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgKHFSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgKHFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:53 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3AC0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:51 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so5341732wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9A3cU3s2UWdUoKcSXUdZHI+jRrF2fhgIn1uS/374W7k=;
        b=LSteLV3kQosYfLFFynXxaoBaZQ6QWsohHCwVrfReURLzo8/8LwOAaHzrZE1E5TfdHj
         D6KwXCepDRTpAcvG8lF54VY7rjPTAUdXx6o/x/j2kTrI8Hx4gZm8kH+8HVxSb1K6gkfH
         FbEr0p/glBb/NicCYF+MikZo/ojyry09a3IEFRyKU5a5332pUNMwX1i86V1/ze4BJbBW
         b2NXI+0/Q1CQt7h+2632mrDGR16uyRZkzWvGb7UMmdDuroK8cKR/5Q0JHg+MrUd95UTL
         q0ykLvHHEVy73UzLSY7fLqoOaJp/4YrhUqh78qHPHoYqKYluHYcaM6o1DYtuxr+p5IiY
         Yz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9A3cU3s2UWdUoKcSXUdZHI+jRrF2fhgIn1uS/374W7k=;
        b=ZdcpT44DKohxXK1csjZRA0aXh66wTrv6UUdz3xcTy88QyySp/LlYVteoPAy7JhnW55
         VEKyfMWQ/IcboRJXB1ZcQ4u5ttkK6/9YWYgCa7niewRoDiJLftRJIJCoFhKRnzFPBxhU
         O16Fr9ArEUElacFWr2BEAAz+5WIEDwJvqS4OE3yKE7RdeRhAVZTsMNgnl7jP1B6gHDyz
         CvEHaZ8WgcmLJjOFO385N8/Uqg1NKV8O0ta3sqKeLjCNejlvG9wk3DhCLlkXcVPwBc7a
         bw0R6ZPWtdouaevjJBJx1ilRlldkHYAhRo5OrfcIon5Eq7dh1DqKw6IIlaFIA1DUTci6
         PDZw==
X-Gm-Message-State: AOAM531tv8WSTsk3CWaiJuPwxKeYoWyjp0jkPTbT4meCjWOIXrzkme9F
        0mzrRqk73IEAC9Lzjuo9aaD37iYDp44lFNoN
X-Google-Smtp-Source: ABdhPJz4yu+SqHfhaBjWCl9/xZqGgHQhrxznkQFrgbHMYybnh8nqrTwmMhJmXpi1u8rbVGXvSJAheg==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr10812509wrn.35.1604812670501;
        Sat, 07 Nov 2020 21:17:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:50 -0800 (PST)
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
Subject: [PATCH 13/19] x86/signal: Check if vdso_image_32 is mapped before trying to land on it
Date:   Sun,  8 Nov 2020 05:17:23 +0000
Message-Id: <20201108051730.2042693-14-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
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
index 870efeec8bda..1be1bdbe55d4 100644
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
index bbcdc7b8f963..a19e0a7bae2d 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -39,6 +39,10 @@ extern const struct vdso_image vdso_image_x32;
 
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
2.28.0

