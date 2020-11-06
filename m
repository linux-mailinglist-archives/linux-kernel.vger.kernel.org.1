Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86C2A97D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKFOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:43:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF4A20724;
        Fri,  6 Nov 2020 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604673793;
        bh=Fj8awA6Fcy8YY7k4CfGwBYzsc5wO+RhyNYKCMKn+Tgw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WVaTpqyzRDjE84irSOloXbMBATmZDFNKMDSBKQd6owGZ6BzV6xpSBKGSHmFv1dwuz
         IlGycO1W8Of5jO850yWfaG4HRtUWnmlYwtSOffGtdlAjqdctCeNhHF/nAPkClaWDuO
         4+pTL5/ZfaiDit4KSZ1J7qqm4vua8OmPqb6Gw0HU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB157352097B; Fri,  6 Nov 2020 06:43:12 -0800 (PST)
Date:   Fri, 6 Nov 2020 06:43:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <cai@redhat.com>
Subject: Re: [PATCH 2/2] arm64: smp: Tell RCU about CPUs that fail to come
 online
Message-ID: <20201106144312.GU3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201106103602.9849-1-will@kernel.org>
 <20201106103602.9849-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106103602.9849-3-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:36:02AM +0000, Will Deacon wrote:
> Commit ce3d31ad3cac ("arm64/smp: Move rcu_cpu_starting() earlier") ensured
> that RCU is informed early about incoming CPUs that might end up calling
> into printk() before they are online. However, if such a CPU fails the
> early CPU feature compatibility checks in check_local_cpu_capabilities(),
> then it will be powered off or parked without informing RCU, leading to
> an endless stream of stalls:
> 
>   | rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   | rcu:	2-O...: (0 ticks this GP) idle=002/1/0x4000000000000000 softirq=0/0 fqs=2593
>   | (detected by 0, t=5252 jiffies, g=9317, q=136)
>   | Task dump for CPU 2:
>   | task:swapper/2       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x00000028
>   | Call trace:
>   | ret_from_fork+0x0/0x30
> 
> Ensure that the dying CPU invokes rcu_report_dead() prior to being powered
> off or parked.
> 
> Cc: Qian Cai <cai@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Suggested-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/arm64/kernel/smp.c | 1 +
>  kernel/rcu/tree.c       | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 09c96f57818c..18e9727d3f64 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -413,6 +413,7 @@ void cpu_die_early(void)
>  
>  	/* Mark this CPU absent */
>  	set_cpu_present(cpu, 0);
> +	rcu_report_dead(cpu);
>  
>  	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>  		update_cpu_boot_status(CPU_KILL_ME);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2a52f42f64b6..bd04b09b84b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4077,7 +4077,6 @@ void rcu_cpu_starting(unsigned int cpu)
>  	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
>  }
>  
> -#ifdef CONFIG_HOTPLUG_CPU
>  /*
>   * The outgoing function has no further need of RCU, so remove it from
>   * the rcu_node tree's ->qsmaskinitnext bit masks.
> @@ -4117,6 +4116,7 @@ void rcu_report_dead(unsigned int cpu)
>  	rdp->cpu_started = false;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
>  /*
>   * The outgoing CPU has just passed through the dying-idle state, and we
>   * are being invoked from the CPU that was IPIed to continue the offline
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
