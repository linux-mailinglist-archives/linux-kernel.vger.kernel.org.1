Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F982F2236
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbhAKVve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbhAKVvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:51:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A73A22CAF;
        Mon, 11 Jan 2021 21:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610401852;
        bh=sllTsw4+hrXQqGdh21Tld3kVSTGbU8J1qMWj+YcynXw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p9v7njyZ/8ErPcX1wGdtW1hqJH0wGQJs1j8k5cJSg8bg6iJIsuaO9RGXbgC/pAH5I
         n/X5p40MXYUTKeD9I7fGKLO/DRq3iWJte919kinnU6x/MyntdtWEF+/vGWGScNIPTy
         +mez/BlAwxrMFoHoilMKTGHXM+QMLcTProeqbAcyWhVnW13X5+qCoces7BG3varICT
         qkKfQJhqHl661o3ny1RnVVRUGUqzeSv//ZwuGbvk68IBtw1Iq1MlFXiaR3ZWmyv8xS
         tGg+q9AXwXBP1i7Q7+Btp94ploq7Px/W2zYNkPkQiYCm1iHCyYCARbgi6Q3yOhV1kY
         2dYHtUbays3pw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 198823522A7B; Mon, 11 Jan 2021 13:50:52 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:50:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <20210111215052.GA19589@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <20210111180907.GE2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111180907.GE2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:09:07AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 11, 2021 at 06:16:39PM +0100, Peter Zijlstra wrote:
> > 
> > While thinking more about this, I'm thinking a big part of the problem
> > is that we're not dinstinguishing between geniuine per-cpu kthreads and
> > kthreads that just happen to be per-cpu.
> > 
> > Geniuine per-cpu kthreads are kthread_bind() and have PF_NO_SETAFFINITY,
> > but sadly a lot of non-per-cpu kthreads, that might happen to still be
> > per-cpu also have that -- again workqueue does that even to it's unbound
> > workers :-(
> > 
> > Now, anything created by smpboot, is created through
> > kthread_create_on_cpu() and that additionally sets to_kthread(p)->flags
> > KTHREAD_IS_PER_CPU.
> > 
> > And I'm thinking that might be sufficient, if we modify
> > is_per_cpu_kthread() to check that, then we only match smpboot threads
> > (which include the hotplug and stopper threads, but notably not the idle
> > thread)
> > 
> > Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> > then having any hotplug crud on, so that needs additinoal frobbing.
> > 
> > Also, init_task is PF_KTHREAD but doesn't have a struct kthread on.. and
> > I suppose bound workqueues don't go through this either.
> > 
> > Let me rummage around a bit...
> > 
> > This seems to not insta-explode... opinions?
> 
> It passes quick tests on -rcu both with and without the rcutorture fixes,
> which is encouraging.  I will start a more vigorous test in about an hour.

And 672 ten-minute instances of RUDE01 passed with this patch applied
and with my rcutorture patch reverted.  So looking good, thank you!!!

							Thanx, Paul
