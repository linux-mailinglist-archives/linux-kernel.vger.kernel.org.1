Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61432C91FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgK3XGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgK3XGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:06:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E1C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:05:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e23so3439pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rpRp72Cd+BjOQIE+2S1fX880ZRKaJuZN5zlTj/95IQ4=;
        b=iV46j/5p4mZN18vAZR855k8jb3GkIjrtLpWP2EX9yGogh1rOWeoVD5VyeD8hLKXI1f
         y5OsK5NisANj0/msIsd6h1clhZTgYKmVxn6VuOw710hILdE4Od7KourtqQvqEnpLiSpO
         KXuLpm/R5kRGw8dXPD8JTNIMxvuCEKBlx4FSIuY0v5UphPXYI/1q9NNMaDSj9MgYh5bC
         8li079B0BCBM0aRWcVwlJnWuQDkXItJE120YozBDlP1zix3Bn3WoLwAzeTHAC+6orerY
         eaiPv0n7i/ofuyqO8hN6w3bTpWy4u92uxNRkA+RjcyN194eRByrC+XYib4Qa3UGsDsQT
         d78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rpRp72Cd+BjOQIE+2S1fX880ZRKaJuZN5zlTj/95IQ4=;
        b=m2Slt/ZLjsKM05Pf4pqkzxPz7pB8nJcWUfnS2ZA0mufJZqTaf9mtuAaBrbzZ7GVtBJ
         bpX8slZQjdKPY23uKcqUMadE7xpClcGUUy/G9qs/GcaKW2DhoQAbWHEFDfdpiCKK9E16
         0TqmUti+vJXJupINq0p9ed7QEGrYng1srrpPFmoD/xQRjV7WNHKZX3jJryrh1XmR3SJO
         uuEvykhXx7RAGnsgNuwdZj5nUUEyzLhPO+kiE5LunNngRX9P1Ly/6/mbMKouWzd9Sl49
         pn1CSNKdS+ZoXIMuEv2TUpOXNwBAmsn3ir8kne11kyt4g2hw+4E0/BVQixC2nbAnL2zT
         cp0w==
X-Gm-Message-State: AOAM530wCwv6XsfcE1+jlyLpfxt3wzAOUOKeA7+sR9dpbWZTNirrHLCN
        +tRgkCoiJOjSRz8sGHdOYKw=
X-Google-Smtp-Source: ABdhPJxEYA1OekeVw9lO8mYPLWVseBMQEh7EWevHWWfJXRfcn5QNe1CsHJvNxuVxvGvYXxzZmUI+6Q==
X-Received: by 2002:a62:8705:0:b029:198:22e5:adcd with SMTP id i5-20020a6287050000b029019822e5adcdmr21271782pfe.74.1606777531847;
        Mon, 30 Nov 2020 15:05:31 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id d4sm43032pjz.28.2020.11.30.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:05:30 -0800 (PST)
Date:   Tue, 1 Dec 2020 10:05:27 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201130230527.GE473773@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-23-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> In order to prevent interference and clearly support both per-task and CGroup
> APIs, split the cookie into 2 and allow it to be set from either per-task, or
> CGroup API. The final cookie is the combined value of both and is computed when
> the stop-machine executes during a change of cookie.
> 
> Also, for the per-task cookie, it will get weird if we use pointers of any
> emphemeral objects. For this reason, introduce a refcounted object who's sole
> purpose is to assign unique cookie value by way of the object's pointer.
> 
> While at it, refactor the CGroup code a bit. Future patches will introduce more
> APIs and support.
> 
> Reviewed-by: Josh Don <joshdon@google.com>
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/sched.h |   2 +
>  kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/debug.c  |   4 +
>  3 files changed, 236 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a60868165590..c6a3b0fa952b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -688,6 +688,8 @@ struct task_struct {
>  #ifdef CONFIG_SCHED_CORE
>  	struct rb_node			core_node;
>  	unsigned long			core_cookie;
> +	unsigned long			core_task_cookie;
> +	unsigned long			core_group_cookie;
>  	unsigned int			core_occupation;
>  #endif
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b99a7493d590..7ccca355623a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -346,11 +346,14 @@ void sched_core_put(void)
>  	mutex_unlock(&sched_core_mutex);
>  }
>  
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
> +
>  #else /* !CONFIG_SCHED_CORE */
>  
>  static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>  static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
>  static bool sched_core_enqueued(struct task_struct *task) { return false; }
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
>  
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -4032,6 +4035,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  #endif
>  #ifdef CONFIG_SCHED_CORE
>  	RB_CLEAR_NODE(&p->core_node);
> +
> +	/*
> +	 * Tag child via per-task cookie only if parent is tagged via per-task
> +	 * cookie. This is independent of, but can be additive to the CGroup tagging.
> +	 */
> +	if (current->core_task_cookie) {
> +
> +		/* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
> +		if (!(clone_flags & CLONE_THREAD)) {
> +			return sched_core_share_tasks(p, p);
> +               }
> +		/* Otherwise share the parent's per-task tag. */
> +		return sched_core_share_tasks(p, current);
> +	}
>  #endif
>  	return 0;
>  }
> @@ -9731,6 +9748,217 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
>  #ifdef CONFIG_SCHED_CORE
> +/*
> + * A simple wrapper around refcount. An allocated sched_core_cookie's
> + * address is used to compute the cookie of the task.
> + */
> +struct sched_core_cookie {
> +	refcount_t refcnt;
> +};
> +
> +/*
> + * sched_core_tag_requeue - Common helper for all interfaces to set a cookie.
> + * @p: The task to assign a cookie to.
> + * @cookie: The cookie to assign.
> + * @group: is it a group interface or a per-task interface.
> + *
> + * This function is typically called from a stop-machine handler.

Can you clarify if it is typically or always, what are the implications for
locking?

> + */
> +void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
> +{
> +	if (!p)
> +		return;
> +
> +	if (group)
> +		p->core_group_cookie = cookie;
> +	else
> +		p->core_task_cookie = cookie;
> +
> +	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
> +	p->core_cookie = (p->core_task_cookie <<
> +				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
> +

Always use masks to ensure this fits in the space we have, should we be concerned about
overflows and the potential for collision of cookie values?

> +	if (sched_core_enqueued(p)) {
> +		sched_core_dequeue(task_rq(p), p);
> +		if (!p->core_task_cookie)
> +			return;
> +	}
> +
> +	if (sched_core_enabled(task_rq(p)) &&
> +			p->core_cookie && task_on_rq_queued(p))
> +		sched_core_enqueue(task_rq(p), p);
> +}
> +
> +/* Per-task interface */
> +static unsigned long sched_core_alloc_task_cookie(void)
> +{
> +	struct sched_core_cookie *ptr =
> +		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
> +
> +	if (!ptr)
> +		return 0;
> +	refcount_set(&ptr->refcnt, 1);
> +
> +	/*
> +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> +	 * is done after the stopper runs.
> +	 */
> +	sched_core_get();
> +	return (unsigned long)ptr;
> +}
> +
> +static bool sched_core_get_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> +
> +	/*
> +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> +	 * is done after the stopper runs.
> +	 */
> +	sched_core_get();
> +	return refcount_inc_not_zero(&ptr->refcnt);
> +}
> +
> +static void sched_core_put_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> +
> +	if (refcount_dec_and_test(&ptr->refcnt))
> +		kfree(ptr);
> +}
> +
> +struct sched_core_task_write_tag {
> +	struct task_struct *tasks[2];
> +	unsigned long cookies[2];
> +};

Use a better name instead of 2?

> +
> +/*
> + * Ensure that the task has been requeued. The stopper ensures that the task cannot
> + * be migrated to a different CPU while its core scheduler queue state is being updated.
> + * It also makes sure to requeue a task if it was running actively on another CPU.
> + */
> +static int sched_core_task_join_stopper(void *data)
> +{
> +	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
> +	int i;
> +
> +	for (i = 0; i < 2; i++)

Use ARRAY_SIZE(cookies) if you have to or ARRAY_SIZE(tasks)

> +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> +
> +	return 0;
> +}
> +
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> +{

Can you please explain how t1 and t2 are related, there is a table below, but
I don't understand case#2, where the cookies get reset, is t2 the core leader
and t2 leads what t1 and t2 collectively get?

May be just called t2 as parent?

> +	struct sched_core_task_write_tag wr = {}; /* for stop machine. */
> +	bool sched_core_put_after_stopper = false;
> +	unsigned long cookie;
> +	int ret = -ENOMEM;
> +
> +	mutex_lock(&sched_core_mutex);
> +
> +	/*
> +	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
> +	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
> +	 *       by this function *after* the stopper removes the tasks from the
> +	 *       core queue, and not before. This is just to play it safe.
> +	 */
> +	if (t2 == NULL) {
> +		if (t1->core_task_cookie) {
> +			sched_core_put_task_cookie(t1->core_task_cookie);
> +			sched_core_put_after_stopper = true;
> +			wr.tasks[0] = t1; /* Keep wr.cookies[0] reset for t1. */
> +		}
> +	} else if (t1 == t2) {
> +		/* Assign a unique per-task cookie solely for t1. */
> +
> +		cookie = sched_core_alloc_task_cookie();
> +		if (!cookie)
> +			goto out_unlock;
> +
> +		if (t1->core_task_cookie) {
> +			sched_core_put_task_cookie(t1->core_task_cookie);
> +			sched_core_put_after_stopper = true;
> +		}
> +		wr.tasks[0] = t1;
> +		wr.cookies[0] = cookie;
> +	} else
> +	/*
> +	 * 		t1		joining		t2
> +	 * CASE 1:
> +	 * before	0				0
> +	 * after	new cookie			new cookie
> +	 *
> +	 * CASE 2:
> +	 * before	X (non-zero)			0
> +	 * after	0				0
> +	 *
> +	 * CASE 3:
> +	 * before	0				X (non-zero)
> +	 * after	X				X
> +	 *
> +	 * CASE 4:
> +	 * before	Y (non-zero)			X (non-zero)
> +	 * after	X				X
> +	 */
> +	if (!t1->core_task_cookie && !t2->core_task_cookie) {
> +		/* CASE 1. */
> +		cookie = sched_core_alloc_task_cookie();
> +		if (!cookie)
> +			goto out_unlock;
> +
> +		/* Add another reference for the other task. */
> +		if (!sched_core_get_task_cookie(cookie)) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		wr.tasks[0] = t1;
> +		wr.tasks[1] = t2;
> +		wr.cookies[0] = wr.cookies[1] = cookie;
> +
> +	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
> +		/* CASE 2. */
> +		sched_core_put_task_cookie(t1->core_task_cookie);
> +		sched_core_put_after_stopper = true;
> +
> +		wr.tasks[0] = t1; /* Reset cookie for t1. */
> +
> +	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
> +		/* CASE 3. */
> +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		wr.tasks[0] = t1;
> +		wr.cookies[0] = t2->core_task_cookie;
> +
> +	} else {
> +		/* CASE 4. */
> +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		sched_core_put_task_cookie(t1->core_task_cookie);
> +		sched_core_put_after_stopper = true;
> +
> +		wr.tasks[0] = t1;
> +		wr.cookies[0] = t2->core_task_cookie;
> +	}
> +
> +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
> +
> +	if (sched_core_put_after_stopper)
> +		sched_core_put();
> +
> +	ret = 0;
> +out_unlock:
> +	mutex_unlock(&sched_core_mutex);
> +	return ret;
> +}
> +
> +/* CGroup interface */
>  static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
>  {
>  	struct task_group *tg = css_tg(css);
> @@ -9761,18 +9989,9 @@ static int __sched_write_tag(void *data)
>  	 * when we set cgroup tag to 0 when the loop is done below.
>  	 */
>  	while ((p = css_task_iter_next(&it))) {
> -		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
> -
> -		if (sched_core_enqueued(p)) {
> -			sched_core_dequeue(task_rq(p), p);
> -			if (!p->core_cookie)
> -				continue;
> -		}
> -
> -		if (sched_core_enabled(task_rq(p)) &&
> -		    p->core_cookie && task_on_rq_queued(p))
> -			sched_core_enqueue(task_rq(p), p);
> +		unsigned long cookie = !!val ? (unsigned long)tg : 0UL;
>  
> +		sched_core_tag_requeue(p, cookie, true /* group */);
>  	}
>  	css_task_iter_end(&it);
>  
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 60a922d3f46f..8c452b8010ad 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1024,6 +1024,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  		__PS("clock-delta", t1-t0);
>  	}
>  
> +#ifdef CONFIG_SCHED_CORE
> +	__PS("core_cookie", p->core_cookie);
> +#endif
> +
>  	sched_show_numa(p, m);
>  }
>

Balbir Singh.  
