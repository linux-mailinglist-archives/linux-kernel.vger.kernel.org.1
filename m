Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E339A293FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436519AbgJTPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436483AbgJTPie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:38:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBC22222D;
        Tue, 20 Oct 2020 15:38:32 +0000 (UTC)
Date:   Tue, 20 Oct 2020 11:38:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: sched: Reenable interrupts in do sched_yield()
Message-ID: <20201020113830.378b4a4c@gandalf.local.home>
In-Reply-To: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
References: <87r1pt7y5c.fsf@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 16:46:55 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> -	/*
> -	 * Since we are going to call schedule() anyway, there's
> -	 * no need to preempt or enable interrupts:

I think the above comment still makes sense, just needs to be tweeked:

	/*
	 * Since we are going to call schedule() anyway, there's
	 * no need to allow preemption after releasing the rq lock.
> -	 */

Especially, since we are now enabling interrupts, which is likely to
trigger a preemption.

-- Steve

>  	preempt_disable();
> -	rq_unlock(rq, &rf);
> +	rq_unlock_irq(rq, &rf);
>  	sched_preempt_enable_no_resched();
>  
>  	schedule();
