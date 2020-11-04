Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858932A7097
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgKDWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:35:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54730 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:35:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MT9YE193720;
        Wed, 4 Nov 2020 22:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=POwdnxVA37sCODlKnfwCuSWGC1qTj8/nVO6OCxt3Xwk=;
 b=KbG/aYFL/P2BvIjJfE2fw0a+3NvdZOAaWUeFSNh+yh37ztWSJvc8dAveGS+dE8HUVDQk
 NYs7Ch58rjEDUTVQaAUAs28X8nmu/KOzunjrwObtZRt92s99qXZfuNF42zqPT98t8eUR
 NJF7R1EZTU69u6EfpAcoB24GZGpBtL1Cti8XLy8rjyJt9r1j8Y0jpGKUR6j1GYmAVaMp
 bMMny9Rzi5x9RguzzYEvezsHZZncoJX7hxyOzGeoHGpFXnwhHiWYD0bXe00teqXRW8EJ
 u1uBiBFcXkeBtXPhGV4bUlICmy8b4P4NZOGU78ZWkwyyXWdIlfd/UHILPGxI09lSFEFu Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34hhw2s78j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 22:32:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MUXPA122731;
        Wed, 4 Nov 2020 22:30:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34hw0kn53k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 22:30:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A4MUTdG013094;
        Wed, 4 Nov 2020 22:30:31 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 14:30:29 -0800
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-18-joel@joelfernandes.org>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <e296ed5a-d473-de1e-d2ab-af37e5db856a@oracle.com>
Date:   Wed, 4 Nov 2020 17:30:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-18-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/20 9:43 PM, Joel Fernandes (Google) wrote:
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
> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   include/linux/sched.h |   2 +
>   kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
>   kernel/sched/debug.c  |   4 +
>   3 files changed, 236 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index fe6f225bfbf9..c6034c00846a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -688,6 +688,8 @@ struct task_struct {
>   #ifdef CONFIG_SCHED_CORE
>   	struct rb_node			core_node;
>   	unsigned long			core_cookie;
> +	unsigned long			core_task_cookie;
> +	unsigned long			core_group_cookie;
>   	unsigned int			core_occupation;
>   #endif
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bab4ea2f5cd8..30a9e4cb5ce1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -346,11 +346,14 @@ void sched_core_put(void)
>   	mutex_unlock(&sched_core_mutex);
>   }
>   
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
> +
>   #else /* !CONFIG_SCHED_CORE */
>   
>   static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
>   static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
>   static bool sched_core_enqueued(struct task_struct *task) { return false; }
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
>   
>   #endif /* CONFIG_SCHED_CORE */
>   
> @@ -3583,6 +3586,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>   #endif
>   #ifdef CONFIG_SCHED_CORE
>   	RB_CLEAR_NODE(&p->core_node);
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
>   #endif
>   	return 0;
>   }
> @@ -9177,6 +9194,217 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>   #endif /* CONFIG_RT_GROUP_SCHED */
>   
>   #ifdef CONFIG_SCHED_CORE
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
> +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> +
> +	return 0;
> +}
> +
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> +{
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
> +			return -EINVAL;

should be:              ret = -EINVAL;

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
>   static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
>   {
>   	struct task_group *tg = css_tg(css);
> @@ -9207,18 +9435,9 @@ static int __sched_write_tag(void *data)
>   	 * when we set cgroup tag to 0 when the loop is done below.
>   	 */
>   	while ((p = css_task_iter_next(&it))) {
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
>   	}
>   	css_task_iter_end(&it);
>   
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index c8fee8d9dfd4..88bf45267672 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1024,6 +1024,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>   		__PS("clock-delta", t1-t0);
>   	}
>   
> +#ifdef CONFIG_SCHED_CORE
> +	__PS("core_cookie", p->core_cookie);
> +#endif
> +
>   	sched_show_numa(p, m);
>   }
>   
> 

-chrish
