Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A9F2D13EE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgLGOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:45:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA3C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:44:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607352268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbesxnCMYYp3/mXP6uyKW5uEBqGAfAIC3QKbmN6u0aU=;
        b=XPOD1qX7JjBAhHfK5q56AE4wMKNAxDHdb91FiMliCQzLJCZlvvc/jYhXf/VTY+3wJ0QMKU
        t3HnsgrFEaMh4T78GDyiz5yKLo5UCiwnaKLiqokRfpfg2XfHC9Yu7OLdQx4SWjgTWtNzti
        iVtQOsOItfEsrhgaGmgu6XPSqJbhU5d0dgzFesX6MK66CBLcA5Mj9WG5eCmYy5SH4Cs+nQ
        Xpg/qwJUH71mPEahn7JQk6ReMHMHe7c5wBVws5Wz7ym2N+BgP5hQXhgCZ7Kni39JyyB07A
        YOfdabk7gAWLOHlJlS3+cfgLaXVCEVFMOiHsjLVjdqCiG6ypO/z++/kiPZkhZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607352268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbesxnCMYYp3/mXP6uyKW5uEBqGAfAIC3QKbmN6u0aU=;
        b=tVV6kLuIutC5oFi8RUAjLcnWmxZji9WH7ErkO3rwX8AIMN4IzGkQu+94/bW08oOU+69vqS
        M3hz/J1oitUniYCQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 2/9] irqtime: Make accounting correct on RT
In-Reply-To: <20201207132702.GC122233@lothringen>
References: <20201204170151.960336698@linutronix.de> <20201204170804.889561591@linutronix.de> <20201207132702.GC122233@lothringen>
Date:   Mon, 07 Dec 2020 15:44:28 +0100
Message-ID: <874kkx7k1f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 14:27, Frederic Weisbecker wrote:
> On Fri, Dec 04, 2020 at 06:01:53PM +0100, Thomas Gleixner wrote:
>> vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
>> which fails on RT because preempt_count() does not contain the softirq
>> accounting which is seperate on RT.
>> 
>> These checks do not need the full preempt count as they only operate on the
>> hard and softirq sections.
>> 
>> Use irq_count() instead which provides the correct value on both RT and non
>> RT kernels. The compiler is clever enough to fold the masking for !RT:
>> 
>>        99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
>>  -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
>>  +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax
>> 
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Also I'm seeing a few other explicit SOFTIRQ_MASK checks on top
> of preempt_count(), especially on RCU:
>
>    $ git grep SOFTIRQ_MASK
>    arch/sh/kernel/irq.c:                   (irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
>    arch/sh/kernel/irq.c:                   (curctx->tinfo.preempt_count & SOFTIRQ_MASK);
>    kernel/rcu/rcutorture.c:                if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
>    kernel/rcu/tree_exp.h:          if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
>    kernel/rcu/tree_plugin.h:                       !!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
>    kernel/rcu/tree_plugin.h:           (preempt_count() &
>    (PREEMPT_MASK | SOFTIRQ_MASK))) {
>
> I guess some RT RCU config take care of that?

I ignored sh so far and RCU has some quirks for RT vs. softirqs.

> Also tracing:
>
>      kernel/trace/ring_buffer.c:     if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
>      kernel/trace/trace.c:           ((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0)

Bah, I somehow lost the cure for that while rebasing.

Thanks,

        tglx
