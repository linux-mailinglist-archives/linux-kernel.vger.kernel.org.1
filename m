Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD92D11F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgLGN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgLGN1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:27:46 -0500
Date:   Mon, 7 Dec 2020 14:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607347625;
        bh=Qvq3h6d1Gy5E6Tnj5vXRnTSeMKnHR2i8+PXsH+/t4JM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuhOirZm5bjMHTZ7KthSr+UdTicVFIDA3Sz5dPvUDlkx5eSXha7mx5f4tGud2i89w
         M0m9WZH71Ff2zgpD7e+j6P5p/SEknkaZIaSvhbrTc+bq8pyC/csMjcmW4KoTsVu0Jm
         xVHAkWxNiXFif2SOOMZakaM4JV3y9EGl170fSbV7C1GvxdP7g9nZII1ByweJSmcujs
         +3cW9k3rse1JUpSiJcDaNQ1/iI653arX4kgi2+t31DQabY10FrmNb5Rbf0xwVWcIfE
         ROJuJj7rNm/f1Gtf0gMtI+wtX8S2sz7q0nPoNOOunaQp2Wl4Uvu+FIqdMnNR6ZbaV3
         vyF8cZE1hSH0Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 2/9] irqtime: Make accounting correct on RT
Message-ID: <20201207132702.GC122233@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170804.889561591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170804.889561591@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:53PM +0100, Thomas Gleixner wrote:
> vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
> which fails on RT because preempt_count() does not contain the softirq
> accounting which is seperate on RT.
> 
> These checks do not need the full preempt count as they only operate on the
> hard and softirq sections.
> 
> Use irq_count() instead which provides the correct value on both RT and non
> RT kernels. The compiler is clever enough to fold the masking for !RT:
> 
>        99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
>  -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
>  +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Also I'm seeing a few other explicit SOFTIRQ_MASK checks on top
of preempt_count(), especially on RCU:

   $ git grep SOFTIRQ_MASK
   arch/sh/kernel/irq.c:                   (irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK) |
   arch/sh/kernel/irq.c:                   (curctx->tinfo.preempt_count & SOFTIRQ_MASK);
   kernel/rcu/rcutorture.c:                if (preempt_count() & (SOFTIRQ_MASK | HARDIRQ_MASK))
   kernel/rcu/tree_exp.h:          if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
   kernel/rcu/tree_plugin.h:                       !!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
   kernel/rcu/tree_plugin.h:           (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {

I guess some RT RCU config take care of that?

Also tracing:

     kernel/trace/ring_buffer.c:     if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
     kernel/trace/trace.c:           ((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0)

Thanks.
