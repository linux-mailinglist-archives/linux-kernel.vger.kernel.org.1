Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB6296CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462348AbgJWK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462263AbgJWKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77297C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=896ftKko4ii1JA7nc9qWN3Sk3Y+nbBbPeT44iuxDq4M=; b=i8JxNCrhZCJr8mzQWXV2GOyEnR
        TZGrlEkLmBXgnIQ6M99HVmQDT1LViU3sq3XpWJiu+UnCLoN725pp+7zR97L01oLBrcKM8gEyal5nY
        HQhN6dGK+DVFVGQ8ZGp314IDfm2oCuf/0QShl5X52itIKG3X9CSAWh1Z15terA0W2be4m9pG+6xJj
        2Ejk7N7a3u4t0nF6XbLGRpxtI8nyTKf5aCDraljj1BrOBIxIr5NlxVTMp4ZRvNWRPBWMXk/fD5zJ6
        SpHIVi6ETM6nxWv0ne5g4yExbxS9x7oo3WAnXxwQmcOYOnomE5uMT4DXvAc7cBB8SH3H/5ER8373S
        Bl2AanHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFn-0002t0-Bs; Fri, 23 Oct 2020 10:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62E8F304D2B;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3683C22E98D2C; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102346.116513635@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:11:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 01/19] stop_machine: Add function and caller debug info
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashes in stop-machine are hard to connect to the calling code, add a
little something to help with that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/stop_machine.h |    5 +++++
 kernel/stop_machine.c        |   23 ++++++++++++++++++++---
 lib/dump_stack.c             |    2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -24,6 +24,7 @@ typedef int (*cpu_stop_fn_t)(void *arg);
 struct cpu_stop_work {
 	struct list_head	list;		/* cpu_stopper->works */
 	cpu_stop_fn_t		fn;
+	unsigned long		caller;
 	void			*arg;
 	struct cpu_stop_done	*done;
 };
@@ -36,6 +37,8 @@ void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
 void stop_machine_yield(const struct cpumask *cpumask);
 
+extern void print_stop_info(const char *log_lvl, struct task_struct *task);
+
 #else	/* CONFIG_SMP */
 
 #include <linux/workqueue.h>
@@ -80,6 +83,8 @@ static inline bool stop_one_cpu_nowait(u
 	return false;
 }
 
+static inline void print_stop_info(const char *log_lvl, struct task_struct *task) { }
+
 #endif	/* CONFIG_SMP */
 
 /*
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -42,11 +42,23 @@ struct cpu_stopper {
 	struct list_head	works;		/* list of pending works */
 
 	struct cpu_stop_work	stop_work;	/* for stop_cpus */
+	unsigned long		caller;
+	cpu_stop_fn_t		fn;
 };
 
 static DEFINE_PER_CPU(struct cpu_stopper, cpu_stopper);
 static bool stop_machine_initialized = false;
 
+void print_stop_info(const char *log_lvl, struct task_struct *task)
+{
+	struct cpu_stopper *stopper = this_cpu_ptr(&cpu_stopper);
+
+	if (task != stopper->thread)
+		return;
+
+	printk("%sStopper: %pS <- %pS\n", log_lvl, stopper->fn, (void *)stopper->caller);
+}
+
 /* static data for stop_cpus */
 static DEFINE_MUTEX(stop_cpus_mutex);
 static bool stop_cpus_in_progress;
@@ -123,7 +135,7 @@ static bool cpu_stop_queue_work(unsigned
 int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
-	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done };
+	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
 
 	cpu_stop_init_done(&done, 1);
 	if (!cpu_stop_queue_work(cpu, &work))
@@ -331,7 +343,8 @@ int stop_two_cpus(unsigned int cpu1, uns
 	work1 = work2 = (struct cpu_stop_work){
 		.fn = multi_cpu_stop,
 		.arg = &msdata,
-		.done = &done
+		.done = &done,
+		.caller = _RET_IP_,
 	};
 
 	cpu_stop_init_done(&done, 2);
@@ -367,7 +380,7 @@ int stop_two_cpus(unsigned int cpu1, uns
 bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
 			struct cpu_stop_work *work_buf)
 {
-	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, };
+	*work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
 	return cpu_stop_queue_work(cpu, work_buf);
 }
 
@@ -487,6 +500,8 @@ static void cpu_stopper_thread(unsigned
 		int ret;
 
 		/* cpu stop callbacks must not sleep, make in_atomic() == T */
+		stopper->caller = work->caller;
+		stopper->fn = fn;
 		preempt_count_inc();
 		ret = fn(arg);
 		if (done) {
@@ -495,6 +510,8 @@ static void cpu_stopper_thread(unsigned
 			cpu_stop_signal_done(done);
 		}
 		preempt_count_dec();
+		stopper->fn = NULL;
+		stopper->caller = 0;
 		WARN_ONCE(preempt_count(),
 			  "cpu_stop: %ps(%p) leaked preempt count\n", fn, arg);
 		goto repeat;
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/kexec.h>
 #include <linux/utsname.h>
+#include <linux/stop_machine.h>
 
 static char dump_stack_arch_desc_str[128];
 
@@ -57,6 +58,7 @@ void dump_stack_print_info(const char *l
 		       log_lvl, dump_stack_arch_desc_str);
 
 	print_worker_info(log_lvl, current);
+	print_stop_info(log_lvl, current);
 }
 
 /**


