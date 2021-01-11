Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73B2F1911
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbhAKPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730300AbhAKPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:00:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47DC0225AC;
        Mon, 11 Jan 2021 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610377216;
        bh=rtirb3fjqCCH9U1KaB7/dG6Wh9fR3Tril3LbNgaV7iE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=j7qh6/eMuRqJsv0NxBZtm6vvT4kdkB/oyAjt0gVhITLwIT8lhzM/FXCH2YJOtiiNW
         Loq9VSqWa2mN6qWsaZWzITjv17m7oq+PafYYEw5+jDnursC99fxg3j8NuB+fsE9yob
         ZAz42c3TK9Hl68aWFhQtloeMg6mbDz176eErrTOuH6zN7wX/InZS0i8PjHdaW1JICA
         M3U/jnn+jMrnIzYyTk4fKeCgEOAHbWg2Ru2yUOXHlH17cOkt7DMZvtvQclFtzQ31rO
         MWv1shBzjKguv5V92P1vAlqZ1e7wJpiW0VqyA0vDWI14k+CROlRsNBpNKgiiseO6dG
         DyV/aVmATXjwA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 191A835226C6; Mon, 11 Jan 2021 07:00:16 -0800 (PST)
Date:   Mon, 11 Jan 2021 07:00:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <20210111150016.GC2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:01:03PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 11:07:34AM +0100, Thomas Gleixner wrote:
> > On Fri, Jan 08 2021 at 12:46, Peter Zijlstra wrote:
> > > On Sat, Dec 26, 2020 at 10:51:08AM +0800, Lai Jiangshan wrote:
> > >> From: Lai Jiangshan <laijs@linux.alibaba.com>
> > >> 
> > >> 06249738a41a ("workqueue: Manually break affinity on hotplug")
> > >> said that scheduler will not force break affinity for us.
> > >
> > > So I've been looking at this the past day or so, and the more I look,
> > > the more I think commit:
> > >
> > >   1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
> > >
> > > is a real problem and we need to revert it (at least for now).
> > >
> > > Let me attempt a brain dump:
> > >
> > >  - the assumption that per-cpu kernel threads are 'well behaved' on
> > >    hot-plug has, I think, been proven incorrect, it's far worse than
> > >    just bounded workqueue. Therefore, it makes sense to provide the old
> > >    semantics.
> > 
> > I disagree. Per-cpu kernel threads which are magically stopped during
> > hotplug and then migrated to a random other CPU are just wrong.
> > 
> > We really need to fix that and not proliferate the sloppy and ill
> > defined behaviour.
> 
> Well yes, but afaict the workqueue stuff hasn't been settled yet, and
> the rcutorture patch Paul did was just plain racy and who knows what
> other daft kthread users are out there. That and we're at -rc3.

Here is what I currently have, which passed 40 hours of each flavor of
rcutorture last night (with Lai Jiangshan's patches).

Except that I cannot explain why the "onoff_task && num_online_cpus"
is needed, just that it doesn't pass otherwise.  So either I am blind
or something else is also messed up.  (Why did I think to add it?
Because experimenting with suppressing individual rcutorture options
pointed in that direction.)

Also, adding that condition to that "if" statement is removing CPU
shuffling entirely from two-CPU runs, which is at best suboptimal.

> So I'm really tempted to revert for now and try again later.

I am not feeling at all good about this being in mainline quite yet.  I do
agree that the semantic might be in some sense cleaner, but let's face it,
rcutorture is a very focused test.  There are large parts of the kernel
that it does not stress at all.  There could be any number of other bugs
involving other parts of the kernel.  It would be good to have a rationale
for why this is safe beforehand rather than random experiment-driven
changes like that added "if" condition in the patch below.

							Thanx, Paul

------------------------------------------------------------------------
commit dd0d40aecf506ed6982d7c98f48b4327d7d59485
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 23 11:23:48 2020 -0800

    torture: Break affinity of kthreads last running on outgoing CPU
    
    The advent of commit 06249738a41a ("workqueue: Manually break affinity
    on hotplug") means that the scheduler no longer silently breaks affinity
    for kthreads pinned to the outgoing CPU.  This can happen for many of
    rcutorture's kthreads due to shuffling, which periodically affinities
    these ktheads away from a randomly chosen CPU.  This usually works fine
    because these kthreads are allowed to run on any other CPU and because
    shuffling is a no-op any time there is but one online CPU.
    
    However, consider the following sequence of events:
    
    1.      CPUs 0 and 1 are initially online.
    
    2.      The torture_shuffle_tasks() function affinities all the tasks
            away from CPU 0.
    
    3.      CPU 1 goes offline.
    
    4.      All the tasks are now affinitied to an offline CPU, triggering
            the warning added by the commit noted above.
    
    This can trigger the following in sched_cpu_dying() in kernel/sched/core.c:
    
            BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq))
    
    This commit therefore adds a new torture_shuffle_tasks_offline() function
    that is invoked from torture_offline() prior to offlining a CPU.  This new
    function scans the list of shuffled kthreads and for any thread that
    last ran (or is set to run) on the outgoing CPU, sets its affinity to
    all online CPUs.  Thus there will never be a kthread that is affinitied
    only to the outgoing CPU.
    
    Of course, if the sysadm manually applies affinity to any of these
    kthreads, all bets are off.  However, such a sysadm must be fast because
    the torture_shuffle_tasks_offline() function is invoked immediately before
    offlining the outgoing CPU.  Therefore, let it be known that with great
    speed and great power comes great responsibility.
    
    Fixes: 1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
    [ paulmck: Applied synchronization feedback from Peter Zijlstra. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/torture.c b/kernel/torture.c
index 01e336f..9208a03 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -65,6 +65,7 @@ static int fullstop = FULLSTOP_RMMOD;
 static DEFINE_MUTEX(fullstop_mutex);
 
 static atomic_t verbose_sleep_counter;
+static DEFINE_MUTEX(shuffle_task_mutex);
 
 /*
  * Sleep if needed from VERBOSE_TOROUT*().
@@ -153,14 +154,17 @@ int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
 
+static struct task_struct *onoff_task;
+
 #ifdef CONFIG_HOTPLUG_CPU
 
+static void torture_shuffle_tasks_offline(int cpu);
+
 /*
  * Variables for online-offline handling.  Only present if CPU hotplug
  * is enabled, otherwise does nothing.
  */
 
-static struct task_struct *onoff_task;
 static long onoff_holdoff;
 static long onoff_interval;
 static torture_ofl_func *onoff_f;
@@ -212,6 +216,8 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_offl_attempts)++;
+	mutex_lock(&shuffle_task_mutex);
+	torture_shuffle_tasks_offline(cpu);
 	ret = remove_cpu(cpu);
 	if (ret) {
 		s = "";
@@ -245,6 +251,7 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 		WRITE_ONCE(torture_online_cpus, torture_online_cpus - 1);
 		WARN_ON_ONCE(torture_online_cpus <= 0);
 	}
+	mutex_unlock(&shuffle_task_mutex);
 
 	return true;
 }
@@ -474,7 +481,6 @@ static struct task_struct *shuffler_task;
 static cpumask_var_t shuffle_tmp_mask;
 static int shuffle_idle_cpu;	/* Force all torture tasks off this CPU */
 static struct list_head shuffle_task_list = LIST_HEAD_INIT(shuffle_task_list);
-static DEFINE_MUTEX(shuffle_task_mutex);
 
 /*
  * Register a task to be shuffled.  If there is no memory, just splat
@@ -512,6 +518,19 @@ static void torture_shuffle_task_unregister_all(void)
 	mutex_unlock(&shuffle_task_mutex);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+// Unbind all tasks from a CPU that is to be taken offline.
+static void torture_shuffle_tasks_offline(int cpu)
+{
+	struct shuffle_task *stp;
+
+	lockdep_assert_held(&shuffle_task_mutex);
+	list_for_each_entry(stp, &shuffle_task_list, st_l)
+		if (task_cpu(stp->st_t) == cpu)
+			set_cpus_allowed_ptr(stp->st_t, cpu_present_mask);
+}
+#endif // #ifdef CONFIG_HOTPLUG_CPU
+
 /* Shuffle tasks such that we allow shuffle_idle_cpu to become idle.
  * A special case is when shuffle_idle_cpu = -1, in which case we allow
  * the tasks to run on all CPUs.
@@ -521,11 +540,13 @@ static void torture_shuffle_tasks(void)
 	struct shuffle_task *stp;
 
 	cpumask_setall(shuffle_tmp_mask);
-	get_online_cpus();
+	mutex_lock(&shuffle_task_mutex);
+	cpus_read_lock();
 
 	/* No point in shuffling if there is only one online CPU (ex: UP) */
-	if (num_online_cpus() == 1) {
-		put_online_cpus();
+	if (num_online_cpus() == 1 || (onoff_task && num_online_cpus() <= 2)) {
+		cpus_read_unlock();
+		mutex_unlock(&shuffle_task_mutex);
 		return;
 	}
 
@@ -536,12 +557,11 @@ static void torture_shuffle_tasks(void)
 	else
 		cpumask_clear_cpu(shuffle_idle_cpu, shuffle_tmp_mask);
 
-	mutex_lock(&shuffle_task_mutex);
 	list_for_each_entry(stp, &shuffle_task_list, st_l)
 		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
-	mutex_unlock(&shuffle_task_mutex);
 
-	put_online_cpus();
+	cpus_read_unlock();
+	mutex_unlock(&shuffle_task_mutex);
 }
 
 /* Shuffle tasks across CPUs, with the intent of allowing each CPU in the
