Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF4527E396
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgI3ITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3ITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:19:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30524C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:19:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601453990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rZrly6olnokuVeon5dpD/FuXUcu5p0ca4GP2VT0oyos=;
        b=mxjWLJ+wcFe9EPGD0MrMLMDd4rbWIzGlFWraCcvkNxQj3fzgPeI58syLeameaXIp91l2gl
        HJK0bbQbHW9SXrtMhn73/zhxQOzfD1URaKGZZ/cfATWnQlZ3N8xIWumeCnmD+QrLNw7KiB
        9QowOpd7HTk+YPGdMf+IRhZHHXnaoAmp5QQlnphiXP2ht3/FVBxH3SV8GRI8d0gJ+/TjoJ
        gGu0BBjHhAFjufkXgxJkxL1QgMxMEKNXk+cF3xdNi1kFl50h0fI5Xrvyv8I5JqQ8wz6G/u
        GQJV4MvQ9LTnNeAZVSQjC1A10gVpHGQuC7XCzDSquCcS6HRswT1IxJVFwA6p2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601453990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rZrly6olnokuVeon5dpD/FuXUcu5p0ca4GP2VT0oyos=;
        b=wOkIboveHJN9bFt0Kz8imqUChyNW9xtdz1GbaS/mhJ2Zu8MoLFuuIvjwylC1hN5t2CcV5S
        mQYcPqAd4O/AW+Dw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [PATCH] x86/mce: Use idtentry_nmi_enter/exit()
Date:   Wed, 30 Sep 2020 10:19:49 +0200
Message-ID: <87mu17ism2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for NMI vs. IRQ state tracking missed to apply the cure to
the MCE handler.

Fixes: ba1f2b2eaa2a ("x86/entry: Fix NMI vs IRQ state tracking")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/mce/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,6 +1904,8 @@ void (*machine_check_vector)(struct pt_r
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	bool irq_state;
+
 	WARN_ON_ONCE(user_mode(regs));
 
 	/*
@@ -1914,7 +1916,7 @@ static __always_inline void exc_machine_
 	    mce_check_crashing_cpu())
 		return;
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -1925,7 +1927,7 @@ static __always_inline void exc_machine_
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
