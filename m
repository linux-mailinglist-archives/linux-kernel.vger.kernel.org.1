Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC97C242904
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgHLMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:06:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62924 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgHLMGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1d6nT2zB09ZQ;
        Wed, 12 Aug 2020 14:05:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Mb4FY47BJ_UM; Wed, 12 Aug 2020 14:05:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1d62CPzB09Zb;
        Wed, 12 Aug 2020 14:05:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A6098B7FC;
        Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NTMMr_RJzyJo; Wed, 12 Aug 2020 14:05:59 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAB3F8B826;
        Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AACDB65C34; Wed, 12 Aug 2020 12:05:58 +0000 (UTC)
Message-Id: <c9e470b3623902193f0549e7f6aa437194e45e86.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 07/19] powerpc/signal: Move access_ok() out of
 get_sigframe()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:05:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This access_ok() will soon be performed by user_access_begin().
So move it out of get_sigframe()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.c    | 4 ----
 arch/powerpc/kernel/signal_32.c | 4 ++--
 arch/powerpc/kernel/signal_64.c | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 3b56db02b762..1be5fd01f866 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -154,10 +154,6 @@ void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
 	oldsp = sigsp(oldsp, ksig);
 	newsp = (oldsp - frame_size) & ~0xFUL;
 
-	/* Check access */
-	if (!access_ok((void __user *)newsp, oldsp - newsp))
-		return NULL;
-
         return (void __user *)newsp;
 }
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 7b291707eb31..5a838188a181 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -770,7 +770,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*rt_sf), 1);
 	addr = rt_sf;
-	if (unlikely(rt_sf == NULL))
+	if (!access_ok(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
@@ -1231,7 +1231,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 1);
-	if (unlikely(frame == NULL))
+	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index bfc939360bad..ec259a0efe24 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -825,7 +825,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	BUG_ON(tsk != current);
 
 	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 0);
-	if (unlikely(frame == NULL))
+	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
-- 
2.25.0

