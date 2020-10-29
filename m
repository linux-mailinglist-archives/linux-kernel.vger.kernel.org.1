Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB9B29DCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbgJ2Abb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgJ2Ab2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:31:28 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF9D2076B;
        Thu, 29 Oct 2020 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603931487;
        bh=0na4mT6eNXzrRMVhpFNG3ZDkoIiM9kYNBq3wAcqLzBE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cpf/clVVmqzTpV19NiSrbhVA9NtJ+yFm0xgE5+5I/0PwCzJIQyGVV7WTxrMABNmRD
         F5oUMAvU0rFn217BTUmy7XJwESfPH/27qpIma7yF9yesyyD0XB6Zjn/0TBKqZ7UOd4
         zsG/0JUoo46rlIocYLs5OYrp24OSsX1ic3B2Rzn4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F82135229CE; Wed, 28 Oct 2020 17:31:27 -0700 (PDT)
Date:   Wed, 28 Oct 2020 17:31:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Qian Cai <cai@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201029003127.GJ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182334.13466-1-cai@redhat.com>
 <87lffpx598.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lffpx598.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:09:07AM +1100, Michael Ellerman wrote:
> Qian Cai <cai@redhat.com> writes:
> > The call to rcu_cpu_starting() in start_secondary() is not early enough
> > in the CPU-hotplug onlining process, which results in lockdep splats as
> > follows:
> 
> Since when?
> What kernel version?
> 
> I haven't seen this running CPU hotplug tests with PROVE_LOCKING=y on
> v5.10-rc1. Am I missing a CONFIG?

My guess would be that adding CONFIG_PROVE_RAW_LOCK_NESTING=y will
get you some splats.

							Thanx, Paul

> cheers
> 
> 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> >
> >  other info that might help us debug this:
> >
> >  RCU used illegally from offline CPU!
> >  rcu_scheduler_active = 1, debug_locks = 1
> >  no locks held by swapper/1/0.
> >
> >  Call Trace:
> >  dump_stack+0xec/0x144 (unreliable)
> >  lockdep_rcu_suspicious+0x128/0x14c
> >  __lock_acquire+0x1060/0x1c60
> >  lock_acquire+0x140/0x5f0
> >  _raw_spin_lock_irqsave+0x64/0xb0
> >  clockevents_register_device+0x74/0x270
> >  register_decrementer_clockevent+0x94/0x110
> >  start_secondary+0x134/0x800
> >  start_secondary_prolog+0x10/0x14
> >
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the start_secondary() function. Note that the
> > raw_smp_processor_id() is required in order to avoid calling into
> > lockdep before RCU has declared the CPU to be watched for readers.
> >
> > Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > Signed-off-by: Qian Cai <cai@redhat.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 3c6b9822f978..8c2857cbd960 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1393,13 +1393,14 @@ static void add_cpu_to_masks(int cpu)
> >  /* Activate a secondary processor. */
> >  void start_secondary(void *unused)
> >  {
> > -	unsigned int cpu = smp_processor_id();
> > +	unsigned int cpu = raw_smp_processor_id();
> >  
> >  	mmgrab(&init_mm);
> >  	current->active_mm = &init_mm;
> >  
> >  	smp_store_cpu_info(cpu);
> >  	set_dec(tb_ticks_per_jiffy);
> > +	rcu_cpu_starting(cpu);
> >  	preempt_disable();
> >  	cpu_callin_map[cpu] = 1;
> >  
> > -- 
> > 2.28.0
