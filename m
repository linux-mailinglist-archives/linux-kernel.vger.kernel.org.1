Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6465242910
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHLMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:06:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46996 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgHLMGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1q04XWzB09Zl;
        Wed, 12 Aug 2020 14:06:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Vo5GMqA0xuhj; Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1p5ScdzB09Zf;
        Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29AB48B826;
        Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FzGH8EXJSKW8; Wed, 12 Aug 2020 14:06:03 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E290E8B7FC;
        Wed, 12 Aug 2020 14:06:02 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C432065C34; Wed, 12 Aug 2020 12:06:02 +0000 (UTC)
Message-Id: <3e2f2862e422c89739dedf2b9e9e0eedc04beb6d.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 11/19] powerpc/signal32: Simplify logging in
 handle_rt_signal32()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:06:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If something is bad in the frame, there is no point in
knowing which part of the frame exactly is wrong as it
got allocated as a single block.

Always print the root address of the frame in case on
failed user access, just like handle_signal32().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d1087dd87174..495bee1b713d 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -754,7 +754,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
 	struct mcontext __user *tm_frame = NULL;
-	void __user *addr;
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
@@ -769,7 +768,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, tsk, sizeof(*rt_sf), 1);
-	addr = rt_sf;
 	if (!access_ok(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
 
@@ -784,7 +782,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	addr = frame;
 	if (vdso32_rt_sigtramp && tsk->mm->context.vdso_base) {
 		sigret = 0;
 		tramp = tsk->mm->context.vdso_base + vdso32_rt_sigtramp;
@@ -820,7 +817,6 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* create a stack frame for the caller of the handler */
 	newsp = ((unsigned long)rt_sf) - (__SIGNAL_FRAMESIZE + 16);
-	addr = (void __user *)regs->gpr[1];
 	if (put_user(regs->gpr[1], (u32 __user *)newsp))
 		goto badframe;
 
@@ -837,7 +833,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	return 0;
 
 badframe:
-	signal_fault(tsk, regs, "handle_rt_signal32", addr);
+	signal_fault(tsk, regs, "handle_rt_signal32", rt_sf);
 
 	return 1;
 }
-- 
2.25.0

