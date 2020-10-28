Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C229D3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgJ1Vhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgJ1VhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5B824828;
        Wed, 28 Oct 2020 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603918843;
        bh=w8Adt+DgZhtcRUqHXQcSpd5t5zZ9mo0QyjcUXXzx+94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0y1TaBF2DmtbC1eIjvDualGIbJaBaQdJFsdqVa8zTE9KWl9c6DMbSPQdNUjhB4k8U
         qKy0T73omL1hJF6ZCIzCOqTXZI3sOmSXaHL2/S0Jels+I7zXDD2OHp7aKSaRAX08nB
         h09biKyNFWyirNNWiu7fnC6WaVHUNvmLT/GJ1IuA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4BA3E35229CE; Wed, 28 Oct 2020 14:00:43 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:00:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201028210043.GG3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182614.13655-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182614.13655-1-cai@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:26:14PM -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in secondary_start_kernel() is not early
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
>  Call trace:
>   dump_backtrace+0x0/0x3c8
>   show_stack+0x14/0x60
>   dump_stack+0x14c/0x1c4
>   lockdep_rcu_suspicious+0x134/0x14c
>   __lock_acquire+0x1c30/0x2600
>   lock_acquire+0x274/0xc48
>   _raw_spin_lock+0xc8/0x140
>   vprintk_emit+0x90/0x3d0
>   vprintk_default+0x34/0x40
>   vprintk_func+0x378/0x590
>   printk+0xa8/0xd4
>   __cpuinfo_store_cpu+0x71c/0x868
>   cpuinfo_store_cpu+0x2c/0xc8
>   secondary_start_kernel+0x244/0x318
> 
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the secondary_start_kernel() function.
> 
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>

Interesting way to compute "cpu" earlier in the code, but nevertheless:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 82e75fc2c903..09c96f57818c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -222,6 +222,7 @@ asmlinkage notrace void secondary_start_kernel(void)
>  	if (system_uses_irq_prio_masking())
>  		init_gic_priority_masking();
>  
> +	rcu_cpu_starting(cpu);
>  	preempt_disable();
>  	trace_hardirqs_off();
>  
> -- 
> 2.28.0
> 
