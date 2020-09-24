Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3D276539
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIXAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIXAiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:38:10 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC67B2145D;
        Thu, 24 Sep 2020 00:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600907888;
        bh=9awzRaoqx4njRrUSpD0KxkC+hOlmQhjM4yHaI+H32Fo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t915jaG1FY+0DxstNGY4j/1t1bjTEVMYBCZYG7ePF4e9YxACgiTDIeXhfqKiNhSQ1
         t0CxxXBUOkTBRcIJ13Jo5UcHMIwo4fOlijp3Xj1YltaXhq52iz9vRooudmnSjbswBe
         9nrurNvjyABrzDpwUY7t/Bg6DqKvgl2/7QeLOQB0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 77DF935226CB; Wed, 23 Sep 2020 17:38:08 -0700 (PDT)
Date:   Wed, 23 Sep 2020 17:38:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 12/12] rcu: Nocb (de)activate through sysfs
Message-ID: <20200924003808.GT29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-13-frederic@kernel.org>
 <20200922002629.GS29330@paulmck-ThinkPad-P72>
 <20200923152745.GB31465@lenoir>
 <20200923154716.GP29330@paulmck-ThinkPad-P72>
 <20200923190050.GA1026@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923190050.GA1026@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:00:50PM +0200, Frederic Weisbecker wrote:
> On Wed, Sep 23, 2020 at 08:47:16AM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 23, 2020 at 05:27:46PM +0200, Frederic Weisbecker wrote:
> > > On Mon, Sep 21, 2020 at 05:26:29PM -0700, Paul E. McKenney wrote:
> > > > On Mon, Sep 21, 2020 at 02:43:51PM +0200, Frederic Weisbecker wrote:
> > > > > Not for merge.
> > > > > 
> > > > > Make nocb toggable for a given CPU using:
> > > > > 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> > > > > 
> > > > > This is only intended for those who want to test this patchset. The real
> > > > > interfaces will be cpuset/isolation and rcutorture.
> > > > 
> > > > Excellent choice for testing in the near term!
> > > > 
> > > > How does rcutorture fare with this series if an additional kthread toggles
> > > > offloading on and off continually?
> > > 
> > > So yeah that would be the plan: having something that randomly toggles
> > > offloading from the RCU tests themselves. I'm not quite familiar with
> > > rcutorture internals yet though.
> > 
> > If you supply a function that selects a CPU and does the toggle, I
> > can quickly and easily wire it into rcutorture.  I of course have no
> > objection to your learning to do this yourself, but the offer stands.
> 
> I gladly accept your proposal! This way I will integrate it in the set
> and start testing.
> 
> The functions to call would be:
> 
> void rcu_nocb_cpu_offload(int cpu);
> void rcu_nocb_cpu_deoffload(int cpu);

I freely confess that I am surprised that there are no error returns
(offline CPU?  non-existent CPU?), but here is a first-cut patch to
rcutorture that tests the above interfaces.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 156f033..6528c48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4302,6 +4302,14 @@
 			stress RCU, they don't participate in the actual
 			test, hence the "fake".
 
+	rcutorture.nocbs_nthreads= [KNL]
+			Set number of RCU callback-offload togglers.
+			Zero (the default) disables toggling.
+
+	rcutorture.nocbs_toggle= [KNL]
+			Set the delay in milliseconds between successive
+			callback-offload toggling attempts.
+
 	rcutorture.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N-1, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1f1db7a..beba9e7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -97,6 +97,8 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
+torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, read_exit_delay, 13,
 	      "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16,
@@ -127,10 +129,12 @@ static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
+static int nrealnocbers;
 static int nrealreaders;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
@@ -174,6 +178,8 @@ static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 static unsigned long start_gp_seq;
+static atomic_long_t n_nocb_offload;
+static atomic_long_t n_nocb_deoffload;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -1498,6 +1504,56 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
+void __weak rcu_nocb_cpu_offload(int cpu) {}
+void __weak rcu_nocb_cpu_deoffload(int cpu) {}
+
+/*
+ * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
+ * increase race probabilities and fuzzes the interval between toggling.
+ */
+static int rcu_nocb_toggle(void *arg)
+{
+	int cpu;
+	int maxcpu = -1;
+	int oldnice = task_nice(current);
+	long r;
+	DEFINE_TORTURE_RANDOM(rand);
+	ktime_t toggle_delay;
+	unsigned long toggle_fuzz;
+	ktime_t toggle_interval = ms_to_ktime(nocbs_toggle);
+
+	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
+	for_each_online_cpu(cpu)
+		maxcpu = cpu;
+	WARN_ON(maxcpu < 0);
+	if (toggle_interval > ULONG_MAX)
+		toggle_fuzz = ULONG_MAX >> 3;
+	else
+		toggle_fuzz = toggle_interval >> 3;
+	if (toggle_fuzz <= 0)
+		toggle_fuzz = NSEC_PER_USEC;
+	do {
+		r = torture_random(&rand);
+		cpu = (r >> 4) % (maxcpu + 1);
+		if (r & 0x1) {
+			rcu_nocb_cpu_offload(cpu);
+			atomic_long_inc(&n_nocb_offload);
+		} else {
+			rcu_nocb_cpu_deoffload(cpu);
+			atomic_long_inc(&n_nocb_deoffload);
+		}
+		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
+		if (stutter_wait("rcu_nocb_toggle"))
+			sched_set_normal(current, oldnice);
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_nocb_toggle");
+	return 0;
+}
+
 /*
  * Print torture statistics.  Caller must ensure that there is only
  * one call to this function at a given time!!!  This is normally
@@ -1553,7 +1609,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
-	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
+	pr_cont("read-exits: %ld ", data_race(n_read_exits));
+	pr_cont("nocb-toggles: %ld:%ld\n",
+		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1647,7 +1705,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
-		 "read_exit_delay=%d read_exit_burst=%d\n",
+		 "read_exit_delay=%d read_exit_burst=%d "
+		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1657,7 +1716,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
-		 read_exit_delay, read_exit_burst);
+		 read_exit_delay, read_exit_burst,
+		 nocbs_nthreads, nocbs_toggle);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2498,6 +2558,13 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
+	if (nocb_tasks) {
+		for (i = 0; i < nrealnocbers; i++)
+			torture_stop_kthread(rcu_nocb_toggle, nocb_tasks[i]);
+		kfree(nocb_tasks);
+		nocb_tasks = NULL;
+	}
+
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -2760,6 +2827,22 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	nrealnocbers = nocbs_nthreads;
+	if (WARN_ON(nrealnocbers < 0))
+		nrealnocbers = 1;
+	if (WARN_ON(nocbs_toggle < 0))
+		nocbs_toggle = HZ;
+	nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
+	if (nocb_tasks == NULL) {
+		VERBOSE_TOROUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nrealnocbers; i++) {
+		firsterr = torture_create_kthread(rcu_nocb_toggle, NULL, nocb_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(rcu_torture_stats, NULL,
 						  stats_task);
