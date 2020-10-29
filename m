Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50029EED5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgJ2OyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:54:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:3374 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgJ2OyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:54:18 -0400
IronPort-SDR: eIN2GZAjTIe7om0fRi2qfNubWHc44Z+ksm2+uKf2ZQKEW6Kklf5H2+1K84Po5JGD9/5e+jkjlE
 An6K7K3KGPrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168574311"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="168574311"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:54:17 -0700
IronPort-SDR: W24IjKne2qJjwMOlma7BukBsVka41DYDqEozjSqKgM97mmg4yAr6pgASQ0EyFXIsa5ul2imIdd
 vHTmelfxrEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="525537083"
Received: from aubrey-skl.sh.intel.com ([10.239.53.22])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2020 07:54:09 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     joel@joelfernandes.org, naravamudan@digitalocean.com,
        jdesfossez@digitalocean.com, peterz@infradead.org,
        tim.c.chen@linux.intel.com, viremana@linux.microsoft.com,
        aaron.lwe@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        pauld@redhat.com, valentin.schneider@arm.com,
        mgorman@techsingularity.net, pawan.kumar.gupta@linux.intel.com,
        pbonzini@redhat.com, vineeth@bitbyteword.org, yu.c.chen@intel.com,
        christian.brauner@ubuntu.com, agata.gruza@intel.com,
        antonio.gomez.iglesias@intel.com, graf@amazon.com,
        konrad.wilk@oracle.com, dfaggioli@suse.com, pjt@google.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        alexandre.chartre@oracle.com,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        dhaval.giani@oracle.com, junaids@google.com, jsbarnes@google.com,
        chris.hyser@oracle.com, paulmck@kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v1] coresched/proc: add forceidle report with coresched enabled
Date:   Thu, 29 Oct 2020 15:16:58 +0800
Message-Id: <20201029071658.8501-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is running a task with coresched enabled, its sibling will
be forced idle if the sibling does not have a trusted task to run. It
is useful to report forceidle to understand the performance of different
cookies of tasks throughout the system.

forceidle is added at the last column of /proc/stat:

  $ cat /proc/stat
  cpu  102034 0 11992 8347016 1046 0 11 0 0 0 991
  cpu0 59 0 212 80364 59 0 0 0 0 0 0
  cpu1 72057 0 89 9102 0 0 0 0 0 0 90

So forceidle% can be computed by any user space tools, for example:

  CPU	user%	system%	iowait%	forceidle%	idle%
  cpu53	24.75	0.00	0.00%	0.99%		74.26%
  CPU	user%	system%	iowait%	forceidle%	idle%
  cpu53	25.74	0.00	0.00%	0.99%		73.27%
  CPU	user%	system%	iowait%	forceidle%	idle%
  cpu53	24.75	0.00	0.00%	0.99%		74.26%
  CPU	user%	system%	iowait%	forceidle%	idle%
  cpu53	25.24	0.00	0.00%	3.88%		70.87%

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 fs/proc/stat.c              | 48 +++++++++++++++++++++++++++++++++++++
 include/linux/kernel_stat.h |  1 +
 include/linux/tick.h        |  2 ++
 kernel/time/tick-sched.c    | 48 +++++++++++++++++++++++++++++++++++++
 kernel/time/tick-sched.h    |  3 +++
 5 files changed, 102 insertions(+)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..b27ccac7b5a4 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -28,7 +28,11 @@ static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 	u64 idle;
 
 	idle = kcs->cpustat[CPUTIME_IDLE];
+#ifdef CONFIG_SCHED_CORE
+	if (cpu_online(cpu) && !nr_iowait_cpu(cpu) && !cpu_rq(cpu)->core->core_forceidle)
+#else
 	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
+#endif
 		idle += arch_idle_time(cpu);
 	return idle;
 }
@@ -43,6 +47,17 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 	return iowait;
 }
 
+#ifdef CONFIG_SCHED_CORE
+static u64 get_forceidle_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 forceidle;
+
+	forceidle = kcs->cpustat[CPUTIME_FORCEIDLE];
+	if (cpu_online(cpu) && cpu_rq(cpu)->core->core_forceidle)
+		forceidle += arch_idle_time(cpu);
+	return forceidle;
+}
+#endif
 #else
 
 static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
@@ -77,6 +92,21 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 	return iowait;
 }
 
+static u64 get_forceidle_time(struct kernel_cpustat *kcs, int cpu)
+{
+	u64 forceidle, forceidle_usecs = -1ULL;
+
+	if (cpu_online(cpu))
+		forceidle_usecs = get_cpu_forceidle_time_us(cpu, NULL);
+
+	if (forceidle_usecs == -1ULL)
+		/* !NO_HZ or cpu offline so we can rely on cpustat.forceidle */
+		forceidle = kcs->cpustat[CPUTIME_FORCEIDLE];
+	else
+		forceidle = forceidle_usecs * NSEC_PER_USEC;
+
+	return forceidle;
+}
 #endif
 
 static void show_irq_gap(struct seq_file *p, unsigned int gap)
@@ -111,12 +141,18 @@ static int show_stat(struct seq_file *p, void *v)
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
+#ifdef CONFIG_SCHED_CORE
+	u64 forceidle;
+#endif
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = 0;
 	guest = guest_nice = 0;
+#ifdef CONFIG_SCHED_CORE
+	forceidle = 0;
+#endif
 	getboottime64(&boottime);
 
 	for_each_possible_cpu(i) {
@@ -130,6 +166,9 @@ static int show_stat(struct seq_file *p, void *v)
 		system		+= cpustat[CPUTIME_SYSTEM];
 		idle		+= get_idle_time(&kcpustat, i);
 		iowait		+= get_iowait_time(&kcpustat, i);
+#ifdef CONFIG_SCHED_CORE
+		forceidle	+= get_forceidle_time(&kcpustat, i);
+#endif
 		irq		+= cpustat[CPUTIME_IRQ];
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
@@ -157,6 +196,9 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+#ifdef CONFIG_SCHED_CORE
+	seq_put_decimal_ull(p, " ", nsec_to_clock_t(forceidle));
+#endif
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
@@ -171,6 +213,9 @@ static int show_stat(struct seq_file *p, void *v)
 		system		= cpustat[CPUTIME_SYSTEM];
 		idle		= get_idle_time(&kcpustat, i);
 		iowait		= get_iowait_time(&kcpustat, i);
+#ifdef CONFIG_SCHED_CORE
+		forceidle	= get_forceidle_time(&kcpustat, i);
+#endif
 		irq		= cpustat[CPUTIME_IRQ];
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
@@ -187,6 +232,9 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+#ifdef CONFIG_SCHED_CORE
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(forceidle));
+#endif
 		seq_putc(p, '\n');
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745c096d..c7ce4bfe757e 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -25,6 +25,7 @@ enum cpu_usage_stat {
 	CPUTIME_IRQ,
 	CPUTIME_IDLE,
 	CPUTIME_IOWAIT,
+	CPUTIME_FORCEIDLE,
 	CPUTIME_STEAL,
 	CPUTIME_GUEST,
 	CPUTIME_GUEST_NICE,
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..7fce78f46930 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,6 +139,7 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_forceidle_time_us(int cpu, u64 *last_update_time);
 
 static inline void tick_nohz_idle_stop_tick_protected(void)
 {
@@ -169,6 +170,7 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
+static inline u64 get_cpu_forceidle_time_us(int cpu, u64 *unused) { return -1; }
 
 static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1b734070f028..de94e5bab5a1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -29,6 +29,7 @@
 #include <asm/irq_regs.h>
 
 #include "tick-internal.h"
+#include "../sched/sched.h"
 
 #include <trace/events/timer.h>
 
@@ -547,6 +548,10 @@ update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_upda
 		delta = ktime_sub(now, ts->idle_entrytime);
 		if (nr_iowait_cpu(cpu) > 0)
 			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
+#ifdef CONFIG_SCHED_CORE
+		else if (cpu_rq(cpu)->core->core_forceidle)
+			ts->forceidle_sleeptime = ktime_add(ts->forceidle_sleeptime, delta);
+#endif
 		else
 			ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
 		ts->idle_entrytime = now;
@@ -653,6 +658,49 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
+#ifdef CONFIG_SCHED_CORE
+/**
+ * get_cpu_forceidle_time_us - get the total force idle time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative force idle time (since boot) for a given
+ * CPU, in microseconds.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * This function returns -1 if NOHZ is not enabled.
+ */
+u64 get_cpu_forceidle_time_us(int cpu, u64 *last_update_time)
+{
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t now, forceidle;
+
+	if (!tick_nohz_active)
+		return -1;
+
+	now = ktime_get();
+	if (last_update_time) {
+		update_ts_time_stats(cpu, ts, now, last_update_time);
+		forceidle = ts->forceidle_sleeptime;
+	} else {
+		if (ts->idle_active && cpu_rq(cpu)->core->core_forceidle) {
+			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
+
+			forceidle = ktime_add(ts->forceidle_sleeptime, delta);
+		} else {
+			forceidle = ts->forceidle_sleeptime;
+		}
+	}
+
+	return ktime_to_us(forceidle);
+
+}
+EXPORT_SYMBOL_GPL(get_cpu_forceidle_time_us);
+#endif
+
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 4fb06527cf64..4c00c5399055 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -71,6 +71,9 @@ struct tick_sched {
 	ktime_t				idle_exittime;
 	ktime_t				idle_sleeptime;
 	ktime_t				iowait_sleeptime;
+#ifdef CONFIG_SCHED_CORE
+	ktime_t				forceidle_sleeptime;
+#endif
 	unsigned long			last_jiffies;
 	u64				timer_expires;
 	u64				timer_expires_base;
-- 
2.17.1

