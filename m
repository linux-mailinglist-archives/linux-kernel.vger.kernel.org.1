Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2F29D2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJ1Vh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgJ1VhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E2324724;
        Wed, 28 Oct 2020 21:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603918867;
        bh=cQJGuWfvLs1OyxCH5Hveq93nka68GE77I3EkBKGcDVw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nztoUpclkAs/vX/8RPAPt/UxcB8PP7Z2qKHsBlFmgVbhuaYpGSwRaeBIB5B0rYuXw
         7PuhsqozVQB7s5CUrz7qoOSNnCr5jZ/LkkoYmyD0XQP3aLWVXb1Nxzo6d+KgYzA0HI
         bzFS0F55hqurCUFlacConpqlCkv6QAixyO3CqF/c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2F8D735229CE; Wed, 28 Oct 2020 14:01:07 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:01:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201028210107.GH3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182742.13773-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182742.13773-1-cai@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:27:42PM -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in smp_init_secondary() is not early
> enough in the CPU-hotplug onlining process, which results in lockdep
> splats as follows:
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  RCU used illegally from offline CPU!
>  rcu_scheduler_active = 1, debug_locks = 1
>  no locks held by swapper/1/0.
> 
>  Call Trace:
>  show_stack+0x158/0x1f0
>  dump_stack+0x1f2/0x238
>  __lock_acquire+0x2640/0x4dd0
>  lock_acquire+0x3a8/0xd08
>  _raw_spin_lock_irqsave+0xc0/0xf0
>  clockevents_register_device+0xa8/0x528
>  init_cpu_timer+0x33e/0x468
>  smp_init_secondary+0x11a/0x328
>  smp_start_secondary+0x82/0x88
> 
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the smp_init_secondary() function. Note that the
> raw_smp_processor_id() is required in order to avoid calling into
> lockdep before RCU has declared the CPU to be watched for readers.
> 
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/s390/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index ebfe86d097f0..390d97daa2b3 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -855,13 +855,14 @@ void __init smp_detect_cpus(void)
>  
>  static void smp_init_secondary(void)
>  {
> -	int cpu = smp_processor_id();
> +	int cpu = raw_smp_processor_id();
>  
>  	S390_lowcore.last_update_clock = get_tod_clock();
>  	restore_access_regs(S390_lowcore.access_regs_save_area);
>  	set_cpu_flag(CIF_ASCE_PRIMARY);
>  	set_cpu_flag(CIF_ASCE_SECONDARY);
>  	cpu_init();
> +	rcu_cpu_starting(cpu);
>  	preempt_disable();
>  	init_cpu_timer();
>  	vtime_init();
> -- 
> 2.28.0
> 
