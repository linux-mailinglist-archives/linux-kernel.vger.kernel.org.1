Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17D2A8291
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgKEPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbgKEPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:46:55 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF44C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:46:55 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id c27so1539540qko.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=husb/1FEMNFlq3RVDBJUIWhrV+3tTW9SMChSt/tUpo4=;
        b=RIaM8e6fZ433KnfNMB4OE/xPTpBkRfwkRYwn1SCiiFcZ8tlMGILDbYX5NBPIadcZhL
         WR0jHJMzehbAV23j3sea2oGq0/1Sw11RiZe1/eI0bJsS2CLT7FsajEqjpwoQR4bFjf3e
         eOeBXCr1Dy2nQYJXRXNgE/JOks3hrCZnMqVA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=husb/1FEMNFlq3RVDBJUIWhrV+3tTW9SMChSt/tUpo4=;
        b=cxtVMFhjvAzIS+pvaEAx0OeKGb4hznBHSHkn/IcDGlKpo75rMQLaSxjkJJDy9FkYx0
         0mkr3LkMuG5fvlVM9MSzwuLaBP0yropu94AmRnqgPjaqWtfNpaVlVQ4jmmDKFim4UjtG
         LpaMdVTYN/kZi1Sum88idf0iwQwP9Rn7/5m/cye1UESxoQrkEumIq5gIKLFjqlGmP76D
         2JA4F7dDEe44soOp4/DhcrdW4CGmZKuTf6vHsXB5qUzCLiPmDHoqqzKmIeEqw8/ho1jh
         FUH5dNYl6fgmvbBxhHMBMoe4uBfuU9hK6p5jexlWU/FPK86ignEqq53eztbfxkdgI7wb
         zpHQ==
X-Gm-Message-State: AOAM533fF4rpu+2X2JP5lbFyXrDEvZpC4+8+xrft+WwcsPpBegZOUvD6
        xxbSMgG7tPTd4lCoBrwzIwkR9w==
X-Google-Smtp-Source: ABdhPJyoKeZCGtovViGG94qMV3ASKqC4crxd7/fFQNu8Pb83Y1vYBVCiXsS3M70J9u/6aOjOz8Sr0Q==
X-Received: by 2002:a05:620a:210c:: with SMTP id l12mr2475018qkl.469.1604591214712;
        Thu, 05 Nov 2020 07:46:54 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 64sm1052679qtc.92.2020.11.05.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:46:53 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:46:53 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     chris hyser <chris.hyser@oracle.com>
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 20/26] sched: Release references to the per-task
 cookie on exit
Message-ID: <20201105154653.GB2656962@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-21-joel@joelfernandes.org>
 <bc98f399-c69a-20c9-10cc-18291723eff9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc98f399-c69a-20c9-10cc-18291723eff9@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:50:42PM -0500, chris hyser wrote:
> On 10/19/20 9:43 PM, Joel Fernandes (Google) wrote:
> > During exit, we have to free the references to a cookie that might be shared by
> > many tasks. This commit therefore ensures when the task_struct is released, any
> > references to cookies that it holds are also released.
> > 
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   include/linux/sched.h | 2 ++
> >   kernel/fork.c         | 1 +
> >   kernel/sched/core.c   | 8 ++++++++
> >   3 files changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 4cb76575afa8..eabd96beff92 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2079,12 +2079,14 @@ void sched_core_unsafe_exit(void);
> >   bool sched_core_wait_till_safe(unsigned long ti_check);
> >   bool sched_core_kernel_protected(void);
> >   int sched_core_share_pid(pid_t pid);
> > +void sched_tsk_free(struct task_struct *tsk);
> >   #else
> >   #define sched_core_unsafe_enter(ignore) do { } while (0)
> >   #define sched_core_unsafe_exit(ignore) do { } while (0)
> >   #define sched_core_wait_till_safe(ignore) do { } while (0)
> >   #define sched_core_kernel_protected(ignore) do { } while (0)
> >   #define sched_core_share_pid(pid_t pid) do { } while (0)
> > +#define sched_tsk_free(tsk) do { } while (0)
> >   #endif
> >   #endif
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index b9c289d0f4ef..a39248a02fdd 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
> >   	exit_creds(tsk);
> >   	delayacct_tsk_free(tsk);
> >   	put_signal_struct(tsk->signal);
> > +	sched_tsk_free(tsk);
> >   	if (!profile_handoff_task(tsk))
> >   		free_task(tsk);
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 42aa811eab14..61e1dcf11000 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9631,6 +9631,14 @@ static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
> >   	return 0;
> >   }
> > +
> > +void sched_tsk_free(struct task_struct *tsk)
> > +{
> > +	if (!tsk->core_task_cookie)
> > +		return;
> > +	sched_core_put_task_cookie(tsk->core_task_cookie);
> > +	sched_core_put();
> 
> 
> sched_tsk_free() can be called under softirq. sched_core_put() is riddled with things that may want to sleep.

Right, that breaks. Can you try the diff I attached below and see if it does
not crash now?

> I tried a number of things like replacing the mutexes in put/get with spin_lock_bh() and just kept finding things like:
> 
> 
> [root@chyser-vm5 bin]# [ 1123.516209] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49

Indeed, stop machine cannot be called from an atomic context, which is what
spin_lock_bh gives you.

---8<-----------------------

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 6c008e5471d7..9967f37c5df0 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -16,6 +16,7 @@
  */
 struct sched_core_cookie {
 	refcount_t refcnt;
+	struct work_struct work; /* to free in WQ context. */;
 };
 
 static DEFINE_MUTEX(sched_core_tasks_mutex);
@@ -54,21 +55,24 @@ void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool gr
 }
 
 /* Per-task interface: Used by fork(2) and prctl(2). */
+static void sched_core_put_cookie_work(struct work_struct *ws);
+
 static unsigned long sched_core_alloc_task_cookie(void)
 {
-	struct sched_core_cookie *ptr =
+	struct sched_core_cookie *ck =
 		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
 
-	if (!ptr)
+	if (!ck)
 		return 0;
-	refcount_set(&ptr->refcnt, 1);
+	refcount_set(&ck->refcnt, 1);
+	INIT_WORK(&ck->work, sched_core_put_cookie_work);
 
 	/*
 	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
 	 * is done after the stopper runs.
 	 */
 	sched_core_get();
-	return (unsigned long)ptr;
+	return (unsigned long)ck;
 }
 
 static bool sched_core_get_task_cookie(unsigned long cookie)
@@ -91,6 +95,15 @@ static void sched_core_put_task_cookie(unsigned long cookie)
 		kfree(ptr);
 }
 
+static void sched_core_put_cookie_work(struct work_struct *ws)
+{
+	struct sched_core_cookie *ck =
+		container_of(ws, struct sched_core_cookie, work);
+
+	sched_core_put_task_cookie((unsigned long)ck);
+	sched_core_put();
+}
+
 struct sched_core_task_write_tag {
 	struct task_struct *tasks[2];
 	unsigned long cookies[2];
@@ -461,8 +474,11 @@ int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
 
 void sched_tsk_free(struct task_struct *tsk)
 {
+	struct sched_core_cookie *ck;
+
 	if (!tsk->core_task_cookie)
 		return;
-	sched_core_put_task_cookie(tsk->core_task_cookie);
-	sched_core_put();
+
+	ck = (struct sched_core_cookie *)tsk->core_task_cookie;
+	queue_work(system_wq, &ck->work);
 }
