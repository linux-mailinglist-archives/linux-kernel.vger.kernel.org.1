Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E572D065B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLFRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgLFRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 12:35:07 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237AC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 09:34:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id q5so10483812qkc.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 09:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YGNK6vnxuX/+i7igiTa8YcXKVI+Wij6INn6A+7tROrI=;
        b=PLZy1cOKMA+vfRN9XoPVg0lk3jA0VG4r46CxjKKBATmRwxpYva86tmo7midrAjkw4j
         ck2Rv3ncNWt75LcKHMK4Y1t0wcJmlLTWxNWYS/x91YXOh/yuOpEtu6HMgupxnRVl5Tqo
         tkyM9qEh2Vvxxq3veev3sTQwabrw6eirFsKrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGNK6vnxuX/+i7igiTa8YcXKVI+Wij6INn6A+7tROrI=;
        b=NVlbrLAeZxxZOIAWR5XNoB4z9KjjElxYcCxLJNvlpNjmABdj3arel73PF1Cn/n8K0L
         s3IXag/eLva6v4C5awlGB5HJKbR3PEiSkUpwYfwi8Qa0kzs6ZqXlljCsMCojdryWLSQE
         z9P68AOBGjSjuCk1HyGvDIEys6BjNeE6Sijez0mEtBuKdnQS1dz71r4aaNdN7VpAwGeU
         jhmQOVm0EHnHfzU9jSW5B2xVmMqKLQCqYX9W+wjE6iuPcikdryOcPKmzJEhkPJxnYbkS
         WzULCEJd/up46FP1QwhNQBn+HFh+KF34o56U0sD8OAKZDW/S7MZxzker+8YEwbjB0UmD
         ul4A==
X-Gm-Message-State: AOAM5335w9n7TnBlAutQahamObsM9DxJs87sd+mR+zdsYSaEzq+dkBfL
        0Ta8iaYMS2rTF7krtFsZcWFooQ==
X-Google-Smtp-Source: ABdhPJyUXmtCH4ecLcbj2mlA2IEGMTwC3cLhz4944fqehyEiDW8XR5DcMTdCqsqWUgN6XSTPUT3zyA==
X-Received: by 2002:a37:6189:: with SMTP id v131mr31224qkb.337.1607276060259;
        Sun, 06 Dec 2020 09:34:20 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f8sm9887293qtp.91.2020.12.06.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 09:34:19 -0800 (PST)
Date:   Sun, 6 Dec 2020 12:34:18 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Chris Hyser <chris.hyser@oracle.com>
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
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <20201206173418.GC201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202214717.GA27531@chyser-vm-1.appad1iad.osdevelopmeniad.oraclevcn.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:47:17PM -0500, Chris Hyser wrote:
> On Tue, Nov 17, 2020 at 06:19:53PM -0500, Joel Fernandes (Google) wrote:
> > Add a per-thread core scheduling interface which allows a thread to share a
> > core with another thread, or have a core exclusively for itself.
> > 
> > ChromeOS uses core-scheduling to securely enable hyperthreading.  This cuts
> > down the keypress latency in Google docs from 150ms to 50ms while improving
> > the camera streaming frame rate by ~3%.
> > 
> 
> Inline is a patch for comment to extend this interface to make it more useful.
> This patch would still need to provide doc and selftests updates as well.
> 
> -chrish
> 
> ---8<-----------------------
[..]  
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 217b048..f8e4e96 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -250,5 +250,8 @@ struct prctl_mm_map {
>  
>  /* Request the scheduler to share a core */
>  #define PR_SCHED_CORE_SHARE		59
> +# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
> +# define PR_SCHED_CORE_SHARE_FROM	1  /* get core_sched cookie from pid */
> +# define PR_SCHED_CORE_SHARE_TO		2  /* push core_sched cookie to pid */
>  
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
> index 800c0f8..14feac1 100644
> --- a/kernel/sched/coretag.c
> +++ b/kernel/sched/coretag.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include "sched.h"
> +#include "linux/prctl.h"
>  
>  /*
>   * Wrapper representing a complete cookie. The address of the cookie is used as
> @@ -456,40 +457,45 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
>  }
>  
>  /* Called from prctl interface: PR_SCHED_CORE_SHARE */
> -int sched_core_share_pid(pid_t pid)
> +int sched_core_share_pid(unsigned long flags, pid_t pid)
>  {
> +	struct task_struct *dest;
> +	struct task_struct *src;
>  	struct task_struct *task;
>  	int err;
>  
> -	if (pid == 0) { /* Recent current task's cookie. */
> -		/* Resetting a cookie requires privileges. */
> -		if (current->core_task_cookie)
> -			if (!capable(CAP_SYS_ADMIN))
> -				return -EPERM;
> -		task = NULL;
> -	} else {
> -		rcu_read_lock();
> -		task = pid ? find_task_by_vpid(pid) : current;
> -		if (!task) {
> -			rcu_read_unlock();
> -			return -ESRCH;
> -		}
> -
> -		get_task_struct(task);
> -
> -		/*
> -		 * Check if this process has the right to modify the specified
> -		 * process. Use the regular "ptrace_may_access()" checks.
> -		 */
> -		if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -			rcu_read_unlock();
> -			err = -EPERM;
> -			goto out;
> -		}
> +	rcu_read_lock();
> +	task = find_task_by_vpid(pid);
> +	if (!task) {
>  		rcu_read_unlock();
> +		return -ESRCH;
>  	}
>  
> -	err = sched_core_share_tasks(current, task);
> +	get_task_struct(task);
> +
> +	/*
> +	 * Check if this process has the right to modify the specified
> +	 * process. Use the regular "ptrace_may_access()" checks.
> +	 */
> +	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> +		rcu_read_unlock();
> +		err = -EPERM;
> +		goto out;
> +	}
> +	rcu_read_unlock();
> +
> +	if (flags == PR_SCHED_CORE_CLEAR) {
> +		dest = task;
> +		src = NULL;
> +	} else if (flags == PR_SCHED_CORE_SHARE_TO) {
> +		dest = task;
> +		src = current;
> +	} else if (flags == PR_SCHED_CORE_SHARE_FROM) {
> +		dest = current;
> +		src = task;
> +	}

Looks ok to me except the missing else { } clause you found. Also, maybe
dest/src can be renamed to from/to to make meaning of variables more clear?

Also looking forward to the docs/test updates.

thanks!

 - Joel


> +
> +	err = sched_core_share_tasks(dest, src);
>  out:
>  	if (task)
>  		put_task_struct(task);
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index cffdfab..50c31f3 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1030,6 +1030,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  
>  #ifdef CONFIG_SCHED_CORE
>  	__PS("core_cookie", p->core_cookie);
> +	__PS("core_task_cookie", p->core_task_cookie);
>  #endif
>  
>  	sched_show_numa(p, m);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b3b89bd..eafb399 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1202,7 +1202,7 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p);
>  void sched_core_get(void);
>  void sched_core_put(void);
>  
> -int sched_core_share_pid(pid_t pid);
> +int sched_core_share_pid(unsigned long flags, pid_t pid);
>  int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
>  
>  #ifdef CONFIG_CGROUP_SCHED
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 61a3c98..da52a0d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2530,9 +2530,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +#ifdef CONFIG_SCHED_CORE
>  	case PR_SCHED_CORE_SHARE:
> -		error = sched_core_share_pid(arg2);
> +		if (arg4 || arg5)
> +			return -EINVAL;
> +		error = sched_core_share_pid(arg2, arg3);
>  		break;
> +#endif
>  	default:
>  		error = -EINVAL;
>  		break;
