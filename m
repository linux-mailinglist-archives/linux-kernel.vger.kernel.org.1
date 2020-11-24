Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D52C2C85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbgKXQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgKXQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:14:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE435C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/1kCWnd3feKEZ2BNY0EBqrEBKNfPzZjxoqXEKQGIzvM=; b=U6Ify2qunErItlzQIuaLuG1RGm
        2J8nOfxIjjQVT2MvNXuSaqYWI5Ot6CbunbyaGKRhLdzrv9+GQpMyzdihjo079ocKcXpzJlfycdVN0
        Oa13yi9a20EQCbZ2PrAbDrTgRf2KjUYQMP9wb5bMsV/ARG1af0tMx3SgDUBkWyLn6rqTwQOnG+fL0
        2Evqo6udgxpOjViHAz/93arflja2DIkfySSUnWmAPcRJuUp/AcfA0jv68q/n+puhnmaAd1j3wKSXQ
        n4o2f1KSvcq2XU34v5vAYfGeET6W0s5jrBEB+VprcFytc9hsxUTt/6oL2DFdHgxXliZdEcPY8gYg4
        r36epBdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khawj-0001gk-3k; Tue, 24 Nov 2020 16:13:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5EBB3012DF;
        Tue, 24 Nov 2020 17:13:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFA1B201ABB33; Tue, 24 Nov 2020 17:13:35 +0100 (CET)
Date:   Tue, 24 Nov 2020 17:13:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 19/32] entry/idle: Enter and exit kernel protection
 during idle entry and exit
Message-ID: <20201124161335.GB3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-20-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-20-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:49PM -0500, Joel Fernandes (Google) wrote:
> Add a generic_idle_{enter,exit} helper function to enter and exit kernel
> protection when entering and exiting idle, respectively.
> 
> While at it, remove a stale RCU comment.
> 
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/entry-common.h | 18 ++++++++++++++++++
>  kernel/sched/idle.c          | 11 ++++++-----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 022e1f114157..8f34ae625f83 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -454,4 +454,22 @@ static inline bool entry_kernel_protected(void)
>  	return IS_ENABLED(CONFIG_SCHED_CORE) && sched_core_kernel_protected()
>  		&& _TIF_UNSAFE_RET != 0;
>  }
> +
> +/**
> + * generic_idle_enter - General tasks to perform during idle entry.
> + */
> +static inline void generic_idle_enter(void)
> +{
> +	/* Entering idle ends the protected kernel region. */
> +	sched_core_unsafe_exit();
> +}
> +
> +/**
> + * generic_idle_exit  - General tasks to perform during idle exit.
> + */
> +static inline void generic_idle_exit(void)
> +{
> +	/* Exiting idle (re)starts the protected kernel region. */
> +	sched_core_unsafe_enter();
> +}
>  #endif

That naming is terrible..

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 8bdb214eb78f..ee4f91396c31 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -8,6 +8,7 @@
>   */
>  #include "sched.h"
>  
> +#include <linux/entry-common.h>
>  #include <trace/events/power.h>
>  
>  /* Linker adds these: start and end of __cpuidle functions */
> @@ -54,6 +55,7 @@ __setup("hlt", cpu_idle_nopoll_setup);
>  
>  static noinline int __cpuidle cpu_idle_poll(void)
>  {
> +	generic_idle_enter();
>  	trace_cpu_idle(0, smp_processor_id());
>  	stop_critical_timings();
>  	rcu_idle_enter();
> @@ -66,6 +68,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
>  	rcu_idle_exit();
>  	start_critical_timings();
>  	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +	generic_idle_exit();
>  
>  	return 1;
>  }
> @@ -156,11 +159,7 @@ static void cpuidle_idle_call(void)
>  		return;
>  	}
>  
> -	/*
> -	 * The RCU framework needs to be told that we are entering an idle
> -	 * section, so no more rcu read side critical sections and one more
> -	 * step to the grace period
> -	 */
> +	generic_idle_enter();
>  
>  	if (cpuidle_not_available(drv, dev)) {
>  		tick_nohz_idle_stop_tick();
> @@ -225,6 +224,8 @@ static void cpuidle_idle_call(void)
>  	 */
>  	if (WARN_ON_ONCE(irqs_disabled()))
>  		local_irq_enable();
> +
> +	generic_idle_exit();
>  }

I'm confused.. arch_cpu_idle_{enter,exit}() weren't conveniently placed
for you?
