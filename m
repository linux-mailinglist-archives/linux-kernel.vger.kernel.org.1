Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1452A6114
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgKDKDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgKDKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:03:10 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E017C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:03:08 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n12so9947297ioc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/qnNqIEzF/JGwjaQW+05VIgXbzEydcUrLQJFysm65c=;
        b=lAaVIzYSjh41fqLw228RfK/BmRZfAyxF9EjD4VsHSZpTo9d1yqsbzU+QOQCcFu2RaP
         jbuSW47wD21ZZeaxUqUIvXAH8Ooj3v76JhvUa4gl1jny0Iqt0VHURF4KQSyIpfLeDswO
         d16fc3syqnol4EuBDq4dvAl6Oedt8x9zMQJzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/qnNqIEzF/JGwjaQW+05VIgXbzEydcUrLQJFysm65c=;
        b=E7YmG63Lpu/b4DE4TxazCzTeRdfWNtt9wWHDAyciGjqc0amWl0W1616ygYtrNN0T9M
         5qk6PAkHagbZ2N2P9YVjlR8y6TkEJMU//1gSpYO0d4iiF3e9k517F78LKAMMzNnNHNnH
         QagYE6Djy15JDy10edz+axCDhouia+iKIp8KNqJml5yyls+7YrZLm+lU+idhKebOpONa
         ER0BHM9jDhJQ165G8c6xoLgqO1PiNT8PVSF2xfSBlFpznNL/EwzAV5JxosQ4wzeFDdx0
         dwqJNrvy5GJTkBl2UIjVkqTLMYhMUnhY6ULsgsfsplZ/KEeSAC9X6HWG7FtnFgBXQCmt
         OuYw==
X-Gm-Message-State: AOAM5332CPFz1hkoKTUeXv9oy80wi4N7bShbJAxecRvfSfx841nHI5+o
        3vn8xDmG12xeNU2CQ2Rny5TKFg==
X-Google-Smtp-Source: ABdhPJziP3wEYIARudJhnmZenGYBccMmhy85xPBeVaK5oV64Hr3bdUaKsi+ZLRVJbPLCEBkK69fRYA==
X-Received: by 2002:a02:9716:: with SMTP id x22mr5300621jai.114.1604484187652;
        Wed, 04 Nov 2020 02:03:07 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id u8sm1104103ilm.36.2020.11.04.02.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 02:03:07 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:03:05 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH v1 4/4] Allow to change the user namespace in which
 user rlimits are counted
Message-ID: <20201104100304.GA20449@ircssh-2.c.rugged-nimbus-611.internal>
References: <cover.1604335819.git.gladkov.alexey@gmail.com>
 <2718f7b13189dfd159414efb68e3533552593140.1604335819.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2718f7b13189dfd159414efb68e3533552593140.1604335819.git.gladkov.alexey@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:50:33PM +0100, Alexey Gladkov wrote:
> Add a new prctl to change the user namespace in which the process
> counter is located. A pointer to the user namespace is in cred struct
> to be inherited by all child processes.
> 
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/exec.c                  |  2 +-
>  fs/io-wq.c                 | 13 ++++++++-----
>  fs/io-wq.h                 |  1 +
>  fs/io_uring.c              |  1 +
>  include/linux/cred.h       |  8 ++++++++
>  include/uapi/linux/prctl.h |  5 +++++
>  kernel/cred.c              | 35 +++++++++++++++++++++++++++++------
>  kernel/exit.c              |  2 +-
>  kernel/fork.c              |  4 ++--
>  kernel/sys.c               | 22 +++++++++++++++++++++-
>  kernel/user_namespace.c    |  3 +++
>  11 files changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index c45dfc716394..574b1381276c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1837,7 +1837,7 @@ static int __do_execve_file(int fd, struct filename *filename,
>  		goto out_ret;
>  	}
>  
> -	processes = get_rlimit_counter(&init_user_ns, current_euid(), UCOUNT_RLIMIT_NPROC);
> +	processes = get_rlimit_counter(current_rlimit_ns(), current_euid(), UCOUNT_RLIMIT_NPROC);
>  
>  	/*
>  	 * We move the actual failure in case of RLIMIT_NPROC excess from
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index c3b0843abc9b..19e43ec115cb 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -116,6 +116,7 @@ struct io_wq {
>  
>  	struct task_struct *manager;
>  	struct user_struct *user;
It seems like user would be unused here, and you could use creds->user?

> +	const struct cred *creds;
>  	refcount_t refs;
>  	struct completion done;
>  
> @@ -217,7 +218,7 @@ static void io_worker_exit(struct io_worker *worker)
>  	if (worker->flags & IO_WORKER_F_RUNNING)
>  		atomic_dec(&acct->nr_running);
>  	if (!(worker->flags & IO_WORKER_F_BOUND))
> -		dec_rlimit_counter(&init_user_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC);
> +		dec_rlimit_counter(wqe->wq->creds->rlimit_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC);
>  	worker->flags = 0;
>  	preempt_enable();
>  
> @@ -350,9 +351,9 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
>  			worker->flags |= IO_WORKER_F_BOUND;
>  			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers--;
>  			wqe->acct[IO_WQ_ACCT_BOUND].nr_workers++;
> -			dec_rlimit_counter(&init_user_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC);
> +			dec_rlimit_counter(wqe->wq->creds->rlimit_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC);
>  		} else {
> -			if (!inc_rlimit_counter(&init_user_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC))
> +			if (!inc_rlimit_counter(wqe->wq->creds->rlimit_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC))
>  				return;
>  			worker->flags &= ~IO_WORKER_F_BOUND;
>  			wqe->acct[IO_WQ_ACCT_UNBOUND].nr_workers++;
> @@ -662,7 +663,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
>  	}
>  
>  	if (index == IO_WQ_ACCT_UNBOUND &&
> -	    !inc_rlimit_counter(&init_user_ns, wq->user->uid, UCOUNT_RLIMIT_NPROC)) {
> +	    !inc_rlimit_counter(wq->creds->rlimit_ns, wq->user->uid, UCOUNT_RLIMIT_NPROC)) {
>  		kfree(worker);
>  		return false;
>  	}
> @@ -772,7 +773,8 @@ static bool io_wq_can_queue(struct io_wqe *wqe, struct io_wqe_acct *acct,
>  	if (free_worker)
>  		return true;
>  
> -	processes = get_rlimit_counter(&init_user_ns, wqe->wq->user->uid, UCOUNT_RLIMIT_NPROC);
> +	processes = get_rlimit_counter(wqe->wq->creds->rlimit_ns, wqe->wq->user->uid,
> +			UCOUNT_RLIMIT_NPROC);
>  
>  	if (processes >= acct->max_workers &&
>  	    !(capable(CAP_SYS_RESOURCE) || capable(CAP_SYS_ADMIN)))
> @@ -1049,6 +1051,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
>  
>  	/* caller must already hold a reference to this */
>  	wq->user = data->user;
> +	wq->creds = data->creds;
>  
>  	for_each_node(node) {
>  		struct io_wqe *wqe;
> diff --git a/fs/io-wq.h b/fs/io-wq.h
> index 071f1a997800..6acc3a04c38f 100644
> --- a/fs/io-wq.h
> +++ b/fs/io-wq.h
> @@ -105,6 +105,7 @@ typedef void (io_wq_work_fn)(struct io_wq_work **);
>  
>  struct io_wq_data {
>  	struct user_struct *user;
> +	const struct cred *creds;
>  
>  	io_wq_work_fn *do_work;
>  	free_work_fn *free_work;
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 493e5047e67c..e419923968b3 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -6933,6 +6933,7 @@ static int io_init_wq_offload(struct io_ring_ctx *ctx,
>  	int ret = 0;
>  
>  	data.user = ctx->user;
> +	data.creds = ctx->creds;
>  	data.free_work = io_free_work;
>  	data.do_work = io_wq_submit_work;
>  
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 18639c069263..43aee68d117f 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -144,6 +144,7 @@ struct cred {
>  #endif
>  	struct user_struct *user;	/* real user ID subscription */
>  	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
> +	struct user_namespace *rlimit_ns; /* user_ns in which rlimits is tracked */
>  	struct group_info *group_info;	/* supplementary groups for euid/fsgid */
>  	/* RCU deletion */
>  	union {
> @@ -170,6 +171,7 @@ extern int set_security_override_from_ctx(struct cred *, const char *);
>  extern int set_create_files_as(struct cred *, struct inode *);
>  extern int cred_fscmp(const struct cred *, const struct cred *);
>  extern void __init cred_init(void);
> +extern int set_rlimit_ns(struct user_namespace *ns);
>  
>  /*
>   * check for validity of credentials
> @@ -370,6 +372,7 @@ static inline void put_cred(const struct cred *_cred)
>  
>  #define task_uid(task)		(task_cred_xxx((task), uid))
>  #define task_euid(task)		(task_cred_xxx((task), euid))
> +#define task_rlimit_ns(task)	(task_cred_xxx((task), rlimit_ns))
>  
>  #define current_cred_xxx(xxx)			\
>  ({						\
> @@ -390,11 +393,16 @@ static inline void put_cred(const struct cred *_cred)
>  extern struct user_namespace init_user_ns;
>  #ifdef CONFIG_USER_NS
>  #define current_user_ns()	(current_cred_xxx(user_ns))
> +#define current_rlimit_ns()	(current_cred_xxx(rlimit_ns))
>  #else
>  static inline struct user_namespace *current_user_ns(void)
>  {
>  	return &init_user_ns;
>  }
> +static inline struct user_namespace *current_rlimit_ns(void)
> +{
> +	return &init_user_ns;
> +}
>  #endif
>  
>  
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..4f853f903415 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,9 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +#define PR_SET_RLIMIT_USER_NAMESPACE	59
> +#define PR_GET_RLIMIT_USER_NAMESPACE	60
> +# define PR_RLIMIT_BIND_GLOBAL_USERNS	(1UL << 0)
> +# define PR_RLIMIT_BIND_CURRENT_USERNS	(1UL << 1)
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 748704db1f6b..7b90e1ef9c9a 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -59,6 +59,7 @@ struct cred init_cred = {
>  	.cap_bset		= CAP_FULL_SET,
>  	.user			= INIT_USER,
>  	.user_ns		= &init_user_ns,
> +	.rlimit_ns		= &init_user_ns,
>  	.group_info		= &init_groups,
>  };
>  
> @@ -120,6 +121,7 @@ static void put_cred_rcu(struct rcu_head *rcu)
>  		put_group_info(cred->group_info);
>  	free_uid(cred->user);
>  	put_user_ns(cred->user_ns);
> +	put_user_ns(cred->rlimit_ns);
>  	kmem_cache_free(cred_jar, cred);
>  }
>  
> @@ -270,6 +272,7 @@ struct cred *prepare_creds(void)
>  	get_group_info(new->group_info);
>  	get_uid(new->user);
>  	get_user_ns(new->user_ns);
> +	get_user_ns(new->rlimit_ns);
>  
>  #ifdef CONFIG_KEYS
>  	key_get(new->session_keyring);
> @@ -345,7 +348,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  #endif
>  		clone_flags & CLONE_THREAD
>  	    ) {
> -		if (!inc_rlimit_counter(&init_user_ns, task_euid(p), UCOUNT_RLIMIT_NPROC))
> +		if (!inc_rlimit_counter(task_rlimit_ns(p), task_euid(p), UCOUNT_RLIMIT_NPROC))
>  			return -EACCES;
>  		p->real_cred = get_cred(p->cred);
>  		get_cred(p->cred);
> @@ -385,7 +388,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  	}
>  #endif
>  
> -	if (!inc_rlimit_counter(&init_user_ns, new->euid, UCOUNT_RLIMIT_NPROC))
> +	if (!inc_rlimit_counter(new->rlimit_ns, new->euid, UCOUNT_RLIMIT_NPROC))
>  		return -EACCES;
>  	p->cred = p->real_cred = get_cred(new);
>  	alter_cred_subscribers(new, 2);
> @@ -487,13 +490,13 @@ int commit_creds(struct cred *new)
>  	 * perhaps this limit is exceeded in the parent user namespace.
>  	 */
>  	alter_cred_subscribers(new, 2);
> -	if (new->user != old->user &&
> -	    !inc_rlimit_counter(&init_user_ns, new->euid, UCOUNT_RLIMIT_NPROC))
> +	if ((new->user != old->user || new->rlimit_ns != old->rlimit_ns) &&
> +	    !inc_rlimit_counter(new->rlimit_ns, new->euid, UCOUNT_RLIMIT_NPROC))
>  		task->flags |= PF_NPROC_UNS_EXCEEDED;
>  	rcu_assign_pointer(task->real_cred, new);
>  	rcu_assign_pointer(task->cred, new);
> -	if (new->user != old->user)
> -		dec_rlimit_counter(&init_user_ns, old->euid, UCOUNT_RLIMIT_NPROC);
> +	if (new->user != old->user || new->rlimit_ns != old->rlimit_ns)
> +		dec_rlimit_counter(old->rlimit_ns, old->euid, UCOUNT_RLIMIT_NPROC);
>  	alter_cred_subscribers(old, -2);
>  
>  	/* send notifications */
> @@ -789,6 +792,26 @@ int set_create_files_as(struct cred *new, struct inode *inode)
>  }
>  EXPORT_SYMBOL(set_create_files_as);
>  
> +/*
> + * Change the rlimit user namespace of the current task, replacing the existing
> + * one. If the given namespace is NULL, then initial user namespace will be
> + * used.
> + *
> + * Return: 0 on success; -errno on failure.
> + */
> +int set_rlimit_ns(struct user_namespace *ns)
> +{
> +	struct cred *new;
> +
> +	new = prepare_creds();
> +	if (!new)
> +		return -ENOMEM;
> +
> +	new->rlimit_ns = ns ? ns : &init_user_ns;
> +
> +	return commit_creds(new);
> +}
> +
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  
>  bool creds_are_invalid(const struct cred *cred)
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 5a0d7dd1ad64..998436d32373 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -187,7 +187,7 @@ void release_task(struct task_struct *p)
>  	/* don't need to get the RCU readlock here - the process is dead and
>  	 * can't be modifying its own credentials. But shut RCU-lockdep up */
>  	rcu_read_lock();
> -	dec_rlimit_counter(&init_user_ns, task_euid(p), UCOUNT_RLIMIT_NPROC);
> +	dec_rlimit_counter(task_rlimit_ns(p), task_euid(p), UCOUNT_RLIMIT_NPROC);
>  	rcu_read_unlock();
>  
>  	cgroup_release(p);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2b28634dc8f..43f3c54fe4c6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1963,7 +1963,7 @@ static __latent_entropy struct task_struct *copy_process(
>  		current->flags &= ~PF_NPROC_UNS_EXCEEDED;
>  		goto bad_fork_free;
>  	}
> -	processes = get_rlimit_counter(&init_user_ns, p->real_cred->euid,
> +	processes = get_rlimit_counter(task_rlimit_ns(p), task_euid(p),
>  			UCOUNT_RLIMIT_NPROC);
>  	if (processes >= task_rlimit(p, RLIMIT_NPROC)) {
>  		if (p->real_cred->user != INIT_USER &&
> @@ -2366,7 +2366,7 @@ static __latent_entropy struct task_struct *copy_process(
>  #endif
>  	delayacct_tsk_free(p);
>  bad_fork_cleanup_count:
> -	dec_rlimit_counter(&init_user_ns, p->cred->euid, UCOUNT_RLIMIT_NPROC);
> +	dec_rlimit_counter(task_rlimit_ns(p), task_euid(p), UCOUNT_RLIMIT_NPROC);
>  	exit_creds(p);
>  bad_fork_free:
>  	p->state = TASK_DEAD;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index db780ec32d86..917cbd7fc674 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -467,7 +467,7 @@ static int set_user(struct cred *new)
>  	if (!new_user)
>  		return -EAGAIN;
>  
> -	processes = get_rlimit_counter(&init_user_ns, new_user->uid, UCOUNT_RLIMIT_NPROC);
> +	processes = get_rlimit_counter(new->rlimit_ns, new_user->uid, UCOUNT_RLIMIT_NPROC);
>  
>  	/*
>  	 * We don't fail in case of NPROC limit excess here because too many
> @@ -2529,6 +2529,26 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +	case PR_SET_RLIMIT_USER_NAMESPACE:
> +		if (!capable(CAP_SYS_RESOURCE))
> +			return -EPERM;
Can you have CAP_SYS_RESOURCE in the init user ns while you're in a non-init 
user ns? Shouldn't that only matter if you want to set yourself to 
PR_RLIMIT_BIND_GLOBAL_USERNS anyways and you just want to make sure they have 
CAP_SYS_RESOURCE in the current namespace for PR_RLIMIT_BIND_CURRENT_USERNS?


> +
> +		switch (arg2) {
> +		case PR_RLIMIT_BIND_GLOBAL_USERNS:
> +			error = set_rlimit_ns(&init_user_ns);
> +			break;
> +		case PR_RLIMIT_BIND_CURRENT_USERNS:
> +			error = set_rlimit_ns(current_user_ns());
> +			break;
To some degree, this isn't so much "per user namespace rlimits", as much as it 
is hierarchical rlimits. I'm not going to nitpick about names, but it might be 
worth exploring. Especially because the way the patch is written, it would be 
easy to introduce a third user namespace for rlimits with different mappings.

The downside I see with a sysctl is that changing it midway through the user 
namespaces lifetime could be confusing, and difficult to get right.

> +		default:
> +			error = -EINVAL;
> +		}
> +		break;
> +	case PR_GET_RLIMIT_USER_NAMESPACE:
> +		error = current_rlimit_ns() == &init_user_ns
> +			? PR_RLIMIT_BIND_GLOBAL_USERNS
> +			: PR_RLIMIT_BIND_CURRENT_USERNS;
> +		break;
It would be nice to have this be a sysctl, so everyone who does
setns() would get the behaviour, and if a process wants to 

>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 87804e0371fe..346df35ceba9 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -56,6 +56,8 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>  #endif
>  	/* tgcred will be cleared in our caller bc CLONE_THREAD won't be set */
>  	cred->user_ns = user_ns;
> +
> +	cred->rlimit_ns = &init_user_ns;
>  }
>  
>  /*
> @@ -121,6 +123,7 @@ int create_user_ns(struct cred *new)
>  	for (i = 0; i < UCOUNT_COUNTS; i++) {
>  		ns->ucount_max[i] = INT_MAX;
>  	}
> +	ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC);
>  	ns->ucounts = ucounts;
>  
>  	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
> -- 
> 2.25.4
> 
