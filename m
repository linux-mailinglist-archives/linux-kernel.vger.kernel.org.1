Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821AF2A2BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBNjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:39:19 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1579C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:39:18 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id s1so6055046qvm.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VdJt/pbzhdvog71KvjgwZ1fxesSe3Oxbx5LSdU9zcvU=;
        b=Y2IwVrfEepmNUhhx1m9KU6SQnDB18Ke6nw489imDatKGt6aOK6MxgL6aI7xfV+FRI6
         7GL6DvYvjS0LvlJSD5XzvYDpyeAyPQjIkR8a7yQAcNHvrjEp2P+63MYH1rJsA3/Ozx/0
         w4TPV5P9CDf7XjPOfO5xBWhIgDvgK8t1BCMIRBX8aE0ieLGYyedzcen59FFzdEXd2d3h
         PZ4LbeX7la28faSDoQ6U0U3h4jab3/+GXIAfhE6Tv/Mra80otFpyg95MZTtL4/CPDKee
         epp0MlnfVLXM7c2Rnt1cESJCJDAe2WrUy27TkKjdbngNSRDMQNP4poQZRQI7LcHvG3qw
         nSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VdJt/pbzhdvog71KvjgwZ1fxesSe3Oxbx5LSdU9zcvU=;
        b=aZKlUwLIhfR/6zOWLR75FRlVsrj9LzqbIuWR+NyOFBL8+e9KOkZBHFKNFL0kf2ZmCp
         FOSBBXoKyVIBTxclBhJ7WumOg9FAP9kRoCFm26BT4AGJknVT9JFiXV/3yeBytn3blWX5
         RyccXa/pon+L/mC7Dgj1Bx8dzvW7eXMGqfk6LcCaEBIHy42/RIKQ2cb8n55ZI211UPYe
         IQvTuDEMeLMCuTOCjdNjyHOKLLPffhCibB6eAnp783Nc6P6m0q7vmAp6ubGW0PjmKZ6m
         GcMOfBQKiZkR9GqW/pds18MFgmf2FSsJCk/Ff1A4iS70HWrPOj5Vwv/4KQIFpLYN6myd
         vkgw==
X-Gm-Message-State: AOAM531Y3ULIb6Y5HgmM+uk+6th52mbWaB8Mx/jEZfgYAxuSd22oGbGN
        gsh9YuzA0iE/CZI5fyTR56Q=
X-Google-Smtp-Source: ABdhPJyUsPFYk0dMDtAfEcdYHeoPfoDKnmncQ+TmHvQNW42NkClfRdsmjTbspXU11i9/7O4cyHhyKA==
X-Received: by 2002:a0c:f706:: with SMTP id w6mr22444019qvn.48.1604324357936;
        Mon, 02 Nov 2020 05:39:17 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r133sm5633618qke.23.2020.11.02.05.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 05:39:17 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 15C0F27C0054;
        Mon,  2 Nov 2020 08:39:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Nov 2020 08:39:16 -0500
X-ME-Sender: <xms:AgygX_fEvS5TPj4IaK81KccBaico9WnRfOJk2zn_gqeh23HnjWNVJg>
    <xme:AgygX1PjbHMmJiKhlJnUN6tOm9_A8QgQHKoH5Q2yICJHWbVyfYWJ5F1l-P01Ay2YU
    bmwR16XDQ7UvRTbDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:AgygX4i0fXuO8ktn1LLpqE9hGOwkkRX_5ozSCpxRp46-6NrYxH-gTQ>
    <xmx:AgygXw96-yaABk4uoBM09TjZaMLyzDUT_EnTmGVtYs8p_F_ciNNmug>
    <xmx:AgygX7s21Ez-MT8ky_U55QQqNTgFMWUxXpi2DH7c1FiSz5rTplPPkw>
    <xmx:BAygX0_ocTy14HOtTTzHfLLjKGdkdNzZrqjl7uKmg2f0fbi-U-1vog>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F6923064683;
        Mon,  2 Nov 2020 08:39:14 -0500 (EST)
Date:   Mon, 2 Nov 2020 21:38:24 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 05/16] rcu: De-offloading CB kthread
Message-ID: <20201102133824.GA2661878@boqun-archlinux>
References: <20201023144649.53046-1-frederic@kernel.org>
 <20201023144649.53046-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023144649.53046-6-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

Could you copy the rcu@vger.kernel.org if you have another version, it
will help RCU hobbyists like me to catch up news in RCU, thanks! ;-)

Please see below for some comments, I'm still reading the whole
patchset, so probably I miss something..

On Fri, Oct 23, 2020 at 04:46:38PM +0200, Frederic Weisbecker wrote:
> In order to de-offload the callbacks processing of an rdp, we must clear
> SEGCBLIST_OFFLOAD and notify the CB kthread so that it clears its own
> bit flag and goes to sleep to stop handling callbacks. The GP kthread
> will also be notified the same way. Whoever acknowledges and clears its
> own bit last must notify the de-offloading worker so that it can resume
> the de-offloading while being sure that callbacks won't be handled
> remotely anymore.
> 
> Inspired-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  include/linux/rcupdate.h   |   2 +
>  kernel/rcu/rcu_segcblist.c |  10 ++-
>  kernel/rcu/rcu_segcblist.h |   2 +-
>  kernel/rcu/tree.h          |   1 +
>  kernel/rcu/tree_plugin.h   | 134 +++++++++++++++++++++++++++++++------
>  5 files changed, 126 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 7c1ceff02852..bf8eb02411c2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -104,8 +104,10 @@ static inline void rcu_user_exit(void) { }
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
>  void rcu_init_nohz(void);
> +int rcu_nocb_cpu_deoffload(int cpu);
>  #else /* #ifdef CONFIG_RCU_NOCB_CPU */
>  static inline void rcu_init_nohz(void) { }
> +static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
>  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
>  
>  /**
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index a96511b7cc98..3f6b5b724b39 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -170,10 +170,14 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
>   * Mark the specified rcu_segcblist structure as offloaded.  This
>   * structure must be empty.
>   */
> -void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
> +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
>  {
> -	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
> -	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
> +	if (offload) {
> +		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
> +		rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
> +	} else {
> +		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
> +	}
>  }
>  
>  /*
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 575896a2518b..00ebeb8d39b7 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -105,7 +105,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
>  void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
> -void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
>  bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
>  bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
>  struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index e4f66b8f7c47..8047102be878 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -200,6 +200,7 @@ struct rcu_data {
>  	/* 5) Callback offloading. */
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
> +	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
>  	struct task_struct *nocb_gp_kthread;
>  	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
>  	atomic_t nocb_lock_contended;	/* Contention experienced. */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index fd8a52e9a887..09caf319a4a9 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2081,16 +2081,29 @@ static int rcu_nocb_gp_kthread(void *arg)
>  	return 0;
>  }
>  
> +static inline bool nocb_cb_can_run(struct rcu_data *rdp)
> +{
> +	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_CB;
> +	return rcu_segcblist_test_flags(&rdp->cblist, flags);
> +}
> +
> +static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
> +{
> +	return nocb_cb_can_run(rdp) && !READ_ONCE(rdp->nocb_cb_sleep);
> +}
> +
>  /*
>   * Invoke any ready callbacks from the corresponding no-CBs CPU,
>   * then, if there are no more, wait for more to appear.
>   */
>  static void nocb_cb_wait(struct rcu_data *rdp)
>  {
> -	unsigned long cur_gp_seq;
> -	unsigned long flags;
> +	struct rcu_segcblist *cblist = &rdp->cblist;
> +	struct rcu_node *rnp = rdp->mynode;
> +	bool needwake_state = false;
>  	bool needwake_gp = false;
> -	struct rcu_node *rnp = rdp->mynode;
> +	unsigned long cur_gp_seq;
> +	unsigned long flags;
>  
>  	local_irq_save(flags);
>  	rcu_momentary_dyntick_idle();
> @@ -2100,32 +2113,50 @@ static void nocb_cb_wait(struct rcu_data *rdp)
>  	local_bh_enable();
>  	lockdep_assert_irqs_enabled();
>  	rcu_nocb_lock_irqsave(rdp, flags);
> -	if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> +	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
>  	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
>  	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
>  		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
>  		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
>  	}
> -	if (rcu_segcblist_ready_cbs(&rdp->cblist)) {
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> -		if (needwake_gp)
> -			rcu_gp_kthread_wake();
> -		return;
> -	}
>  
> -	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
>  	WRITE_ONCE(rdp->nocb_cb_sleep, true);
> +
> +	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
> +		if (rcu_segcblist_ready_cbs(cblist))
> +			WRITE_ONCE(rdp->nocb_cb_sleep, false);
> +	} else {
> +		/*
> +		 * De-offloading. Clear our flag and notify the de-offload worker.
> +		 * We won't touch the callbacks and keep sleeping until we ever
> +		 * get re-offloaded.
> +		 */
> +		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> +		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_CB);
> +		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
> +			needwake_state = true;
> +	}
> +
> +	if (rdp->nocb_cb_sleep)
> +		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
> +
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  	if (needwake_gp)
>  		rcu_gp_kthread_wake();
> -	swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> -				 !READ_ONCE(rdp->nocb_cb_sleep));
> -	if (!smp_load_acquire(&rdp->nocb_cb_sleep)) { /* VVV */
> +
> +	if (needwake_state)
> +		swake_up_one(&rdp->nocb_state_wq);
> +
> +	do {
> +		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
> +						    nocb_cb_wait_cond(rdp));
> +
>  		/* ^^^ Ensure CB invocation follows _sleep test. */
> -		return;
> -	}
> -	WARN_ON(signal_pending(current));
> -	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> +		if (smp_load_acquire(&rdp->nocb_cb_sleep)) {
> +			WARN_ON(signal_pending(current));
> +			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
> +		}
> +	} while (!nocb_cb_can_run(rdp));
>  }
>  
>  /*
> @@ -2187,6 +2218,69 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
>  		do_nocb_deferred_wakeup_common(rdp);
>  }
>  
> +static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> +{
> +	struct rcu_segcblist *cblist = &rdp->cblist;
> +	struct rcu_node *rnp = rdp->mynode;
> +	bool wake_cb = false;
> +	unsigned long flags;
> +
> +	printk("De-offloading %d\n", rdp->cpu);
> +
> +	rcu_nocb_lock_irqsave(rdp, flags);
> +	raw_spin_lock_rcu_node(rnp);

Could you explain why both nocb_lock and node lock are needed here?
Besides rcu_nocb_{un}lock_* can skip the lock part based on the offload
state, which gets modified right here (in a rcu_nocb_{un}lock_* critical
secion), and I think this is error-prone, because you may get a unpaired
lock-unlock (not in this patch though). Maybe just use node lock?

> +	rcu_segcblist_offload(cblist, false);
> +	raw_spin_unlock_rcu_node(rnp);
> +
> +	if (rdp->nocb_cb_sleep) {
> +		rdp->nocb_cb_sleep = false;
> +		wake_cb = true;
> +	}
> +	rcu_nocb_unlock_irqrestore(rdp, flags);
> +
> +	if (wake_cb)
> +		swake_up_one(&rdp->nocb_cb_wq);
> +
> +	swait_event_exclusive(rdp->nocb_state_wq,
> +			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> +
> +	return 0;
> +}
> +
> +static long rcu_nocb_rdp_deoffload(void *arg)
> +{
> +	struct rcu_data *rdp = arg;
> +
> +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());

I think this warning can actually happen, if I understand how workqueue
works correctly. Consider that the corresponding cpu gets offlined right
after the rcu_nocb_cpu_deoffloaed(), and the workqueue of that cpu
becomes unbound, and IIUC, workqueues don't do migration during
cpu-offlining, which means the worker can be scheduled to other CPUs,
and the work gets executed on another cpu. Am I missing something here?.

Regards,
Boqun

> +	return __rcu_nocb_rdp_deoffload(rdp);
> +}
> +
> +int rcu_nocb_cpu_deoffload(int cpu)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +	int ret = 0;
> +
> +	if (rdp == rdp->nocb_gp_rdp) {
> +		pr_info("Can't deoffload an rdp GP leader (yet)\n");
> +		return -EINVAL;
> +	}
> +	mutex_lock(&rcu_state.barrier_mutex);
> +	cpus_read_lock();
> +	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
> +		if (cpu_online(cpu)) {
> +			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
> +		} else {
> +			ret = __rcu_nocb_rdp_deoffload(rdp);
> +		}
> +		if (!ret)
> +			cpumask_clear_cpu(cpu, rcu_nocb_mask);
> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +
> +	return ret;
> +}
> +
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> @@ -2229,7 +2323,8 @@ void __init rcu_init_nohz(void)
>  		rdp = per_cpu_ptr(&rcu_data, cpu);
>  		if (rcu_segcblist_empty(&rdp->cblist))
>  			rcu_segcblist_init(&rdp->cblist);
> -		rcu_segcblist_offload(&rdp->cblist);
> +		rcu_segcblist_offload(&rdp->cblist, true);
> +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
>  	}
>  	rcu_organize_nocb_kthreads();
>  }
> @@ -2239,6 +2334,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
>  {
>  	init_swait_queue_head(&rdp->nocb_cb_wq);
>  	init_swait_queue_head(&rdp->nocb_gp_wq);
> +	init_swait_queue_head(&rdp->nocb_state_wq);
>  	raw_spin_lock_init(&rdp->nocb_lock);
>  	raw_spin_lock_init(&rdp->nocb_bypass_lock);
>  	raw_spin_lock_init(&rdp->nocb_gp_lock);
> -- 
> 2.25.1
> 
