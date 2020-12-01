Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAD2CB0BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgLAXSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLAXSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:18:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96628C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:17:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606864641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UE/rlHSP0G7s86tz7tjEzg2yq4EO+0YTSH4Q6g6NmcU=;
        b=kCDSKkLOhprlm8gDzoLFWHfYXs7il5xKGZmOBVSqaLPnJmaHwykojcHdi/8YY4erFK4x+5
        Hzk/CJecsziPY0313ELPOP3SidS4HHUuq40JWxLg8F1vX10DeuEjfTir64DZVIMJXctggU
        FREnHqCdTkQUC5yxOdjjoWQbPM9s5KNZ55gmGOOA5dauXJ+jFIVO8zJgI6tcg+nNEBnMzu
        9a3mlGFv+iM9jxwz8/s+r/GhpKXEwo65hdy3SdenByiQ9G8dotUnxnQxo7T6FOaSzyJCCS
        VQlkMSm0wl11SV+7KnDIH/3zSqyv5sCNh/J5Y7t01IjbvyR+llbD5RlQpMeXng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606864641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UE/rlHSP0G7s86tz7tjEzg2yq4EO+0YTSH4Q6g6NmcU=;
        b=IZTBrTtftxzvTCDGtBxSKvStEbFFau7T7km8xENUWmccC3SSETFINT2XAdYsGMFmYkSn9I
        fskpLsHQHV+wuODQ==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] split up lockdep and syscall related functionality in generic entry code
In-Reply-To: <20201201142755.31931-1-svens@linux.ibm.com>
References: <20201201142755.31931-1-svens@linux.ibm.com>
Date:   Wed, 02 Dec 2020 00:17:21 +0100
Message-ID: <877dq1f75q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 15:27, Sven Schnelle wrote:
> __do_syscall is the function which gets called by low level entry.S code:
>
> void noinstr __do_syscall(struct pt_regs *regs)
> {
> 	enter_from_user_mode(regs);	/* sets lockdep state, and other initial stuff */
>
> 	/*
> 	 * functions that need to run with irqs disabled,
> 	 * but lockdep state and other stuff set up
> 	 */
> 	memcpy(&regs->gprs[8], S390_lowcore.save_area_sync, 8 * sizeof(unsigned long));
> 	memcpy(&regs->int_code, &S390_lowcore.svc_ilc, sizeof(regs->int_code));
> 	regs->psw = S390_lowcore.svc_old_psw;

As __do_syscall() is marked noinstr you want to add

        instrumentation_begin();
>
> 	update_timer_sys();
>
> 	local_irq_enable();
>
> 	regs->orig_gpr2 = regs->gprs[2];
>
> 	do {
> 		regs->flags = _PIF_SYSCALL;
> 		do_syscall(regs);
> 	} while (test_pt_regs_flag(regs, PIF_SYSCALL_RESTART));

        instrumentation_end();

for two reasons:

    - it clearly documents the boundaries in the code

    - it will make objtool happy.

      I know it does not have s390 support yet, but I only can recommend
      to add that. It's annoying to analyze all the spots it complains
      about violating the noinstr rules, but it's way more reliable than
      human inspection.
      

> 	exit_to_user_mode();
> }

Thanks,

        tglx
