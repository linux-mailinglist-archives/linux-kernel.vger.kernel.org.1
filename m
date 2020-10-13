Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04F28CE81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgJMMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:40:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgJMMkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:40:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9A81FB;
        Tue, 13 Oct 2020 05:40:05 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FE4D3F719;
        Tue, 13 Oct 2020 05:40:04 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:40:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     jun qian <qianjun.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20201013124001.ivqr4exkidkkny3o@e107158-lin>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
 <878scz89tl.fsf@nanos.tec.linutronix.de>
 <20200925004207.GE19346@lenoir>
 <CAKc596Km6kjQcp2MJmH9BZLY_7i7yFmHDmRnaJGsm4WzUNjwaA@mail.gmail.com>
 <20200929114428.GA56480@lothringen>
 <20201009150139.vatmppe2e3cwtoof@e107158-lin.cambridge.arm.com>
 <20201013104357.GB47577@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013104357.GB47577@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 12:43, Frederic Weisbecker wrote:
> On Fri, Oct 09, 2020 at 04:01:39PM +0100, Qais Yousef wrote:
> > On 09/29/20 13:44, Frederic Weisbecker wrote:
> > > > that will delay the net_rx/tx softirq to process, Peter's branch
> > > > maybe can slove
> > > > the problem
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/softirq
> > > 
> > > It's probably also the right time for me to resume on this patchset:
> > > 
> > > https://lwn.net/Articles/779564/
> > > 
> > > In the long term this will allow us to have per vector threads that can be
> > > individually triggered upon high loads, and even soft interruptible by
> > > other vectors from irq_exit(). Also if several vectors are on high loads
> > > at the same time, this leaves the balance decisions to the scheduler instead
> > > of all these workarounds we scratch our heads on for several years now.
> > > 
> > > Besides, I'm convinced that splitting the softirqs is something we want in
> > > the long run anyway.
> > 
> > So if I understood correctly we'll end up with a kthread for each softirq type
> > that can be scheduled individually on any CPU following the 'normal' scheduler
> > rules, correct?
> > 
> > If I got it right, I like that. I certainly think having these softirqs as RT
> > threads (like irq threads) makes a lot more sense. At least one would be able
> > to use priorities to reason about when it's okay to preempt them or not.
> > 
> > If I got it wrong, why we can't do that?
> 
> We can't do that right away because some softirq vectors may rely on the
> fact that they can't be interrupted by other softirq vectors. If they use
> per cpu data, they can perfectly assume that it's locally softirq-safe
> and not use any lock to protect it, provided the data is stricly per-cpu
> of course.
> 
> So we'll need to check all the softirq handlers and make sure they don't
> do such assumption, or fix the site. I can imagine it as an iterative
> pushdown just like we did with the big kernel lock.

Thanks Frederic. I know what to do in my free cycles now ;-)

FWIW, NAPI seems to have learnt the ability to use kthreads (in case you missed
it)

	https://lwn.net/Articles/833840/
	https://lwn.net/ml/netdev/20201002222514.1159492-1-weiwan@google.com/

Thanks

--
Qais Yousef
