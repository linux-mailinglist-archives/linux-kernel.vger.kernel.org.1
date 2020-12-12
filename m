Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3482D83CF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 02:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406477AbgLLBVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 20:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbgLLBVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 20:21:13 -0500
Date:   Sat, 12 Dec 2020 02:20:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607736032;
        bh=7N5LPiSz1QnteNYFe7nnZia5zFtf0AshDPu19JW/Jwg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGX1DspLs2PguS08exU48zJQo6JtLdn+26dtL0LfyjyvJ5/ZPtrJsr7er1gmiewGe
         9AuoWlpLy3Zq/jAL55SAcJWFdmaYmiir8X7SQEMuq6XihFoeWZW4VQMdMSeWBP7+Sh
         JfUDJZK6jXL2DWQ1ZkG6k9gNrJP6grzO6wPYZhnUIbSnuBZ6/4pdnvD8jFwnJ/1tfd
         aEygaawygVo3eDg/Es+0CGUwBKx656Q2ldFv4YTB8/Dmvz/h7serT8I5uRVqZbSKtW
         G5rdf/YPpdQcFtE0wV0tWsyNLeyLfW+ZpsyIHW7+YmoGNFLnJtwONVTErPb38KG/CT
         RuEEyyeNjYEiw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 1/3] tick: Remove pointless cpu valid check in hotplug
 code
Message-ID: <20201212012030.GE595642@lothringen>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.582579516@linutronix.de>
 <20201211222104.GB595642@lothringen>
 <87v9d7g9pv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9d7g9pv.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 01:16:12AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 11 2020 at 23:21, Frederic Weisbecker wrote:
> > On Sun, Dec 06, 2020 at 10:12:54PM +0100, Thomas Gleixner wrote:
> >> tick_handover_do_timer() which is invoked when a CPU is unplugged has a
> >> @@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot
> >>  /*
> >>   * Transfer the do_timer job away from a dying cpu.
> >>   *
> >> - * Called with interrupts disabled. Not locking required. If
> >> + * Called with interrupts disabled. No locking required. If
> >>   * tick_do_timer_cpu is owned by this cpu, nothing can change it.
> >>   */
> >>  void tick_handover_do_timer(void)
> >>  {
> >> -	if (tick_do_timer_cpu == smp_processor_id()) {
> >> -		int cpu = cpumask_first(cpu_online_mask);
> >> -
> >> -		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
> >> -			TICK_DO_TIMER_NONE;
> >> -	}
> >> +	if (tick_do_timer_cpu == smp_processor_id())
> >> +		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
> >
> > I was about to whine that this randomly chosen CPU may be idle and leave
> > the timekeeping stale until I realized that stop_machine() is running at that
> > time. Might be worth adding a comment about that.
> >
> > Also why not just setting it to TICK_DO_TIMER_NONE and be done with it? Perhaps
> > to avoid that all the CPUs to compete and contend on jiffies update after stop
> > machine?
> 
> No. Because we'd need to add the NONE magic to NOHZ=n kernels which does
> not make sense.

I forgot about that other half of the world.

Thanks.
