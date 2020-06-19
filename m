Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF691FFF21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 02:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFSAB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 20:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgFSAB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:01:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71448C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:01:58 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fc4so3682553qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNchvC4tH2Tj4K3jgyuexvmGUcl61SJ/ygEHsSpC1MI=;
        b=cy8LU4gN5EMWqz2rD+681PTcDvGi0NtokQF1JnGdedhKjh7HV+2NeV7U6F1NvAWJ7A
         QenGDTy+fEKKwZFCU/PBkCALnDs3uLdWypWU8v+CrMLetqK+L43rwP75KaAqvcyCp/Sg
         kQmIZkd+7vZ0Qjr9gtzlUgONWZsqGsnGcybEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNchvC4tH2Tj4K3jgyuexvmGUcl61SJ/ygEHsSpC1MI=;
        b=niMCM+4dqmvGuX/fjHPmaQPcYqs+sLK/kydOvoRg7/Y8Q6Wku/mAEN9lyMgDU2QwTJ
         wfcQgRP4WMycrQrhdIfC45bqbWrkHDiJw5jqARtcIro4iG34WpPDYWspXbWEV6KKERRW
         fdrQ97ETV07CtMbmkXQalmDg6zlA+D2Qjp+Y/sFiBE7sO2VyjGUuFiP1x344P6UV+W7z
         RhxbklErNbLsgCSNyFItD6Ax1YGV1vcR3KtxElp4CHb1CdHV41aYkLhFhA2+1tS4XXXy
         XqpozNlUjfys4+L1xo0qtDDdU/MmS0imLzslRMEYWY1FTXN5oIpuXPY0xbRVUKz4dOuz
         hfCw==
X-Gm-Message-State: AOAM530eOLfWthSCfMa8pKz+LT5k11vkkMsXAMdut8bb7r6lSEsERx+r
        FZdhMbyLy4MKqdFIcAvHTnBrjg==
X-Google-Smtp-Source: ABdhPJwlQKbcQQUzDdsZoGymkXo/pBXE0eYMdHpV8eExonBxpGTRc2ese8BIwCGXZuMM/eqMx76keg==
X-Received: by 2002:a05:6214:1342:: with SMTP id b2mr6425412qvw.80.1592524917556;
        Thu, 18 Jun 2020 17:01:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g5sm5271583qta.46.2020.06.18.17.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 17:01:57 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:01:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 6/7] rcutorture: Add support to get the number of wakeups
 of main GP kthread
Message-ID: <20200619000156.GD40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-6-joel@joelfernandes.org>
 <20200618224058.GD2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618224058.GD2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:40:58PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 04:29:54PM -0400, Joel Fernandes (Google) wrote:
> > This is useful to check for any improvements or degradation related to
> > number of GP kthread wakeups during testing.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This was a good way to collect the data for your testing, but
> we can expect rcutorture to only do so much.  ;-)

np, I will push this one into a git tag for the next time I need it ;)

thanks,

 - Joel


> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/Kconfig.debug |  1 +
> >  kernel/rcu/rcu.h         |  2 ++
> >  kernel/rcu/rcutorture.c  | 23 ++++++++++++++++++++++-
> >  kernel/rcu/tree.c        |  7 +++++++
> >  4 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 3cf6132a4bb9f..3323e3378af5a 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -50,6 +50,7 @@ config RCU_TORTURE_TEST
> >  	select TASKS_RCU
> >  	select TASKS_RUDE_RCU
> >  	select TASKS_TRACE_RCU
> > +	select SCHEDSTATS
> >  	default n
> >  	help
> >  	  This option provides a kernel module that runs torture tests
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index cf66a3ccd7573..7e867e81d9738 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -511,6 +511,7 @@ srcu_batches_completed(struct srcu_struct *sp) { return 0; }
> >  static inline void rcu_force_quiescent_state(void) { }
> >  static inline void show_rcu_gp_kthreads(void) { }
> >  static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
> > +static inline struct task_struct *rcu_get_main_gp_kthread(void) { return 0; }
> >  static inline void rcu_fwd_progress_check(unsigned long j) { }
> >  #else /* #ifdef CONFIG_TINY_RCU */
> >  bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
> > @@ -519,6 +520,7 @@ unsigned long rcu_exp_batches_completed(void);
> >  unsigned long srcu_batches_completed(struct srcu_struct *sp);
> >  void show_rcu_gp_kthreads(void);
> >  int rcu_get_gp_kthreads_prio(void);
> > +struct task_struct *rcu_get_main_gp_kthread(void);
> >  void rcu_fwd_progress_check(unsigned long j);
> >  void rcu_force_quiescent_state(void);
> >  extern struct workqueue_struct *rcu_gp_wq;
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d0d265304d147..959a1f84d6904 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/rcupdate_wait.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/sched/stat.h>
> >  #include <uapi/linux/sched/types.h>
> >  #include <linux/atomic.h>
> >  #include <linux/bitops.h>
> > @@ -460,9 +461,29 @@ static void rcu_sync_torture_init(void)
> >  	INIT_LIST_HEAD(&rcu_torture_removed);
> >  }
> >  
> > +unsigned long rcu_gp_nr_wakeups;
> > +
> > +static void rcu_flavor_init(void)
> > +{
> > +	rcu_sync_torture_init();
> > +
> > +	/* Make sure schedstat is enabled for GP thread wakeup count. */
> > +	force_schedstat_enabled();
> > +	rcu_gp_nr_wakeups = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> > +}
> > +
> > +static void rcu_flavor_cleanup(void)
> > +{
> > +	unsigned long now_nr = rcu_get_main_gp_kthread()->se.statistics.nr_wakeups;
> > +
> > +	pr_alert("End-test: Cleanup: Total GP-kthread wakeups: %lu\n",
> > +		now_nr - rcu_gp_nr_wakeups);
> > +}
> > +
> >  static struct rcu_torture_ops rcu_ops = {
> >  	.ttype		= RCU_FLAVOR,
> > -	.init		= rcu_sync_torture_init,
> > +	.init		= rcu_flavor_init,
> > +	.cleanup	= rcu_flavor_cleanup,
> >  	.readlock	= rcu_torture_read_lock,
> >  	.read_delay	= rcu_read_delay,
> >  	.readunlock	= rcu_torture_read_unlock,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c3bae7a83d792..a3a175feb310a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -175,6 +175,13 @@ int rcu_get_gp_kthreads_prio(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
> >  
> > +/* Retrieve RCU's main GP kthread task_struct */
> > +struct task_struct *rcu_get_main_gp_kthread(void)
> > +{
> > +	return rcu_state.gp_kthread;
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_get_main_gp_kthread);
> > +
> >  /*
> >   * Number of grace periods between delays, normalized by the duration of
> >   * the delay.  The longer the delay, the more the grace periods between
> > -- 
> > 2.27.0.111.gc72c7da667-goog
> > 
