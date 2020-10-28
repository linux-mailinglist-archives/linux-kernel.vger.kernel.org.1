Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E084C29E226
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgJ2CLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgJ1VhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04F624827;
        Wed, 28 Oct 2020 20:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603918763;
        bh=uhOhRHxQVfGw7MyAyAJTdGF3H9kCy/1BltY5AjTtSN0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=loooxR5XyCI1oAjmIJHBwJpYv3LJvTxBzAr3RNF9wwefMD6/PYs7CotHJqnLyHWfP
         iJWhdiBHD8kIx56QNV6L8kXzavPKJe0TMhRs3XZhpvdyH+xqG7bUw64lnu5IOM7ejT
         MMYu3qltUG0hDSkGZwhklk03zwVcULaE3bL3uyxI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1C2935229CE; Wed, 28 Oct 2020 13:59:22 -0700 (PDT)
Date:   Wed, 28 Oct 2020 13:59:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201028205922.GF3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182334.13466-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182334.13466-1-cai@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:23:34PM -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in start_secondary() is not early enough
> in the CPU-hotplug onlining process, which results in lockdep splats as
> follows:
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
>  dump_stack+0xec/0x144 (unreliable)
>  lockdep_rcu_suspicious+0x128/0x14c
>  __lock_acquire+0x1060/0x1c60
>  lock_acquire+0x140/0x5f0
>  _raw_spin_lock_irqsave+0x64/0xb0
>  clockevents_register_device+0x74/0x270
>  register_decrementer_clockevent+0x94/0x110
>  start_secondary+0x134/0x800
>  start_secondary_prolog+0x10/0x14
> 
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the start_secondary() function. Note that the
> raw_smp_processor_id() is required in order to avoid calling into
> lockdep before RCU has declared the CPU to be watched for readers.
> 
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/powerpc/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 3c6b9822f978..8c2857cbd960 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1393,13 +1393,14 @@ static void add_cpu_to_masks(int cpu)
>  /* Activate a secondary processor. */
>  void start_secondary(void *unused)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu = raw_smp_processor_id();
>  
>  	mmgrab(&init_mm);
>  	current->active_mm = &init_mm;
>  
>  	smp_store_cpu_info(cpu);
>  	set_dec(tb_ticks_per_jiffy);
> +	rcu_cpu_starting(cpu);
>  	preempt_disable();
>  	cpu_callin_map[cpu] = 1;
>  
> -- 
> 2.28.0
> 
