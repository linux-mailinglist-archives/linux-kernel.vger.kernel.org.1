Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AE7240BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 19:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHJRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHJRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:31:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC8C061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:31:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so7362624qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZilIbn8Ey5e/y0nurcgCYw++o8bX2sBJEAqKjJZdF3Y=;
        b=TeAR59/IsQrIHUm1kqmj6qyUtILmf286hf119B3TZDeeDDuSnf67RCLE5rl9ZYvrBw
         4/CpANJ73gHmkccdLd7QPTu18LIPLRkDGUK8I2Dwysjn88tWQWZC/yqz5Yun2ypnVT5H
         iAROliLYVfBQ5l8ALknMRoE/AMOT3NfdTkhT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZilIbn8Ey5e/y0nurcgCYw++o8bX2sBJEAqKjJZdF3Y=;
        b=TclnpPgSemsENSQFJ50TKK/w8NoiZNl+WXSJhM0kByGmK4iCKX9MySzZopI/EI9FV7
         iOklVFrgcR9Q/Rq77avrfHf+MEPWwUKWAIRiB/rPMMplUtGqB+OQz7+vvVeSV5aExn/v
         F1Yp7YRIJHgF8uGHCk8BzuN/YmjmUgll6+kO5Z8Ht1X3RbN3zjp5ZUwf87bG8YBRPknG
         yQrVmpQu/KGhTzM6TIABuuSosb4toNPDlx5C2OJihoawavmsOlxyOGLg/h4v9hFc9Xr/
         KI4+umYpLaz+dgNauj74T3HCrlyNTfxwQGbtO4bimkYDEr8H9lHDoOUvhUR7JTfZXILC
         kiag==
X-Gm-Message-State: AOAM530Gb5/GnFMyCAEsA0ok2px4YqcGa0AMxTj/eUvsgTC8XBapkq1C
        l+b9gGy+VY9pp7/mOJIOcL2PrQ==
X-Google-Smtp-Source: ABdhPJzuDduk9KeU4Tn3zvbI76yUyhP9Dlr8dxrVEI8d7EoyPDSJFgI/WFaVqcbl4dy+C3KWPY1vxg==
X-Received: by 2002:ac8:d4e:: with SMTP id r14mr27341729qti.325.1597080670238;
        Mon, 10 Aug 2020 10:31:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l66sm16180988qte.48.2020.08.10.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 10:31:09 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:31:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        neeraju@codeaurora.org, peterz@infradead.org,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        vineethrp@gmail.com
Subject: Re: [PATCH v4 4/5] rcutorture: Force synchronizing of RCU flavor
 from hotplug notifier
Message-ID: <20200810173109.GA2253395@google.com>
References: <20200807170722.2897328-1-joel@joelfernandes.org>
 <20200807170722.2897328-5-joel@joelfernandes.org>
 <20200810161945.GK4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810161945.GK4295@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Aug 10, 2020 at 09:19:45AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 07, 2020 at 01:07:21PM -0400, Joel Fernandes (Google) wrote:
> > RCU has had deadlocks in the past related to synchronizing in a hotplug
> > notifier. Typically, this has occurred because timer callbacks did not get
> > migrated before the CPU hotplug notifier requesting RCU's services is
> > called. If RCU's grace period processing has a timer callback queued in
> > the meanwhile, it may never get called causing RCU stalls.
> > 
> > These issues have been fixed by removing such dependencies from grace
> > period processing, however there are no testing scenarios for such
> > cases.
> > 
> > This commit therefore reuses rcutorture's existing hotplug notifier to
> > invoke the flavor-specific synchronize callback. If anything locks up,
> > we expect stall warnings and/or other splats.
> > 
> > Obviously, we need not test for rcu_barrier from a notifier, since those
> > are not allowed from notifiers. This fact is already detailed in the
> > documentation as well.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Given that rcutorture_booster_init() is invoked on the CPU in question
> only after it is up and running, and that (if I remember correctly)
> rcutorture_booster_cleanup() is invoked on the outgoing CPU before it
> has really started going away, would this code really have caught that
> timer/CPU-hotplug/RCU bug?

You are right, it would not have caught that particular one because the timer
callbacks would have been migrated by the time the rcutorture_booster_init()
is called.

I still thought it is a good idea anyway to test if the dynamic hotplug
notifiers don't have these issues.

Did you have a better idea on how to test the timer/hotplug/rcu bug?

thanks,

 - Joel



> >  kernel/rcu/rcutorture.c | 81 +++++++++++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 39 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 92cb79620939..083b65e4877d 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -1645,12 +1645,37 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
> >  		 read_exit_delay, read_exit_burst);
> >  }
> >  
> > -static int rcutorture_booster_cleanup(unsigned int cpu)
> > +static bool rcu_torture_can_boost(void)
> > +{
> > +	static int boost_warn_once;
> > +	int prio;
> > +
> > +	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
> > +		return false;
> > +
> > +	prio = rcu_get_gp_kthreads_prio();
> > +	if (!prio)
> > +		return false;
> > +
> > +	if (prio < 2) {
> > +		if (boost_warn_once  == 1)
> > +			return false;
> > +
> > +		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
> > +		boost_warn_once = 1;
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int rcutorture_hp_cleanup(unsigned int cpu)
> >  {
> >  	struct task_struct *t;
> >  
> > -	if (boost_tasks[cpu] == NULL)
> > +	if (!rcu_torture_can_boost() || boost_tasks[cpu] == NULL)
> >  		return 0;
> > +
> >  	mutex_lock(&boost_mutex);
> >  	t = boost_tasks[cpu];
> >  	boost_tasks[cpu] = NULL;
> > @@ -1662,11 +1687,14 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > -static int rcutorture_booster_init(unsigned int cpu)
> > +static int rcutorture_hp_init(unsigned int cpu)
> >  {
> >  	int retval;
> >  
> > -	if (boost_tasks[cpu] != NULL)
> > +	/* Force synchronizing from hotplug notifier to ensure it is safe. */
> > +	cur_ops->sync();
> > +
> > +	if (!rcu_torture_can_boost() || boost_tasks[cpu] != NULL)
> >  		return 0;  /* Already created, nothing more to do. */
> >  
> >  	/* Don't allow time recalculation while creating a new task. */
> > @@ -2336,30 +2364,6 @@ static void rcu_torture_barrier_cleanup(void)
> >  	}
> >  }
> >  
> > -static bool rcu_torture_can_boost(void)
> > -{
> > -	static int boost_warn_once;
> > -	int prio;
> > -
> > -	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
> > -		return false;
> > -
> > -	prio = rcu_get_gp_kthreads_prio();
> > -	if (!prio)
> > -		return false;
> > -
> > -	if (prio < 2) {
> > -		if (boost_warn_once  == 1)
> > -			return false;
> > -
> > -		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
> > -		boost_warn_once = 1;
> > -		return false;
> > -	}
> > -
> > -	return true;
> > -}
> > -
> >  static bool read_exit_child_stop;
> >  static bool read_exit_child_stopped;
> >  static wait_queue_head_t read_exit_wq;
> > @@ -2503,8 +2507,7 @@ rcu_torture_cleanup(void)
> >  		 rcutorture_seq_diff(gp_seq, start_gp_seq));
> >  	torture_stop_kthread(rcu_torture_stats, stats_task);
> >  	torture_stop_kthread(rcu_torture_fqs, fqs_task);
> > -	if (rcu_torture_can_boost())
> > -		cpuhp_remove_state(rcutor_hp);
> > +	cpuhp_remove_state(rcutor_hp);
> >  
> >  	/*
> >  	 * Wait for all RCU callbacks to fire, then do torture-type-specific
> > @@ -2773,21 +2776,21 @@ rcu_torture_init(void)
> >  		if (firsterr)
> >  			goto unwind;
> >  	}
> > +
> > +	firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
> > +			rcutorture_hp_init,
> > +			rcutorture_hp_cleanup);
> > +	if (firsterr < 0)
> > +		goto unwind;
> > +	rcutor_hp = firsterr;
> > +
> >  	if (test_boost_interval < 1)
> >  		test_boost_interval = 1;
> >  	if (test_boost_duration < 2)
> >  		test_boost_duration = 2;
> > -	if (rcu_torture_can_boost()) {
> > -
> > +	if (rcu_torture_can_boost())
> >  		boost_starttime = jiffies + test_boost_interval * HZ;
> >  
> > -		firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
> > -					     rcutorture_booster_init,
> > -					     rcutorture_booster_cleanup);
> > -		if (firsterr < 0)
> > -			goto unwind;
> > -		rcutor_hp = firsterr;
> > -	}
> >  	shutdown_jiffies = jiffies + shutdown_secs * HZ;
> >  	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
> >  	if (firsterr)
> > -- 
> > 2.28.0.236.gb10cc79966-goog
> > 
