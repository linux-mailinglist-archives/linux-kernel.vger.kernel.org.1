Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF72F83CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbhAOSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:38 -0500
Received: from smtp.uniroma2.it ([160.80.6.22]:46866 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388117AbhAOSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:21 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 13:15:19 EST
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 10FI7vZW015460;
        Fri, 15 Jan 2021 19:08:03 +0100
Received: from localhost.localdomain (unknown [160.80.103.223])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id D87ED121201;
        Fri, 15 Jan 2021 19:07:53 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1610734073; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LJEA/5MtyWxj0SJkJfYLMUOcHhaFD/6OGDjv8d8oG1Y=;
        b=KXsnZX4soY8XZ++3aZhKn0UZAKN1jU0QkE4m4D9xgFJ6lb5EoDW1C5Hn2rQNbHUBzOD/38
        1QjpnQxI9QXcCgCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1610734073; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=LJEA/5MtyWxj0SJkJfYLMUOcHhaFD/6OGDjv8d8oG1Y=;
        b=Dc18PDg7V1yUyKfsISC2vRrzBHfXTvigAFvp7f6sAgYIYJ8hwc7GWtpZAFkNuwRcLCS2Yc
        n/EcfycPVKvHhviNza8g8uEMvH09eNZTSN6JStvCpvDcWpQ6eZE/b4h2wOZZ6ZbfyWjFu0
        MP7qdGTXKrWKFjlgOGE5ciSuCCpZoAdVtLvxD46fVUudQgP8SePFEN06xGL35A4EfSQ9On
        loiXffDR9mP1Vd/5Ram4A8U6X1NFZqVWEJAxlgWXu5gVcR25eqoTZShIME2MzyGy0vL9/r
        jDKVKo/G3hnyQp3pm3CaKKMARhFrN66iIJITvh3YCdghqyfYvSJCHLgXBSuhrg==
From:   Marco Faltelli <marco.faltelli@uniroma2.it>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Marco Faltelli <marco.faltelli@uniroma2.it>
Subject: [PATCH] kernel/time: Add hr_sleep syscall, a high-resolution sleep service
Date:   Fri, 15 Jan 2021 18:07:33 +0000
Message-Id: <20210115180733.5663-1-marco.faltelli@uniroma2.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hr_sleep is a new system call engineered for nanosecond time scale
granularities.
With respect to nanosleep, it uses a single value representation
of the sleep period.
hr_sleep achieves 15x improvement for microsecond scale timers
w.r.t. nanosleep: the reason is the use of a CPU register for
passing the sleep period (avoiding cross-ring data move) and
the use of the thread's kernel stack area (avoiding in-kernel
memory allocations).
Further details about hr_sleep and the evaluation compared
to nanosleep can be found in Section 3 of our paper "Metronome:
adaptive and precise intermittent packet retrieval in DPDK"
hr_sleep in this patch has syscall number 442, so you can try it
calling syscall(442, sleep_period)

Signed-off-by: Marco Faltelli <marco.faltelli@uniroma2.it>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 kernel/time/hrtimer.c                  | 61 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78672124d28b..27343c016e42 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,6 +363,7 @@
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
+442	common	hr_sleep		sys_hr_sleep
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852e10f2..422410c60a9f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1988,6 +1988,67 @@ SYSCALL_DEFINE2(nanosleep_time32, struct old_timespec32 __user *, rqtp,
 }
 #endif
 
+#ifdef CONFIG_64BIT
+
+
+typedef struct _control_record {
+	struct task_struct *task;
+	int pid;
+	int awake;
+	struct hrtimer hr_timer;
+} control_record;
+
+
+static enum hrtimer_restart hr_sleep_callback(struct hrtimer *timer)
+{
+	control_record *control;
+	struct task_struct *the_task;
+
+	control = (control_record *)container_of(timer, control_record, hr_timer);
+	control->awake = 1;
+	the_task = control->task;
+	wake_up_process(the_task);
+
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * hr_sleep - a high-resolution sleep service for fine-grained timeouts
+ * @nanoseconds:	the requested sleep period in nanoseconds
+ *
+ * Returns:
+ * 0 when the sleep request successfully terminated
+ * -EINVAL if a sleep period < 0 is requested
+ */
+SYSCALL_DEFINE1(hr_sleep, long, nanoseconds)
+{
+	DECLARE_WAIT_QUEUE_HEAD(the_queue);//here we use a private queue
+	control_record *control;
+	ktime_t ktime_interval;
+
+	if (nanoseconds < 0)
+		return -EINVAL;
+
+	if (nanoseconds == 0)
+		return 0;
+
+	ktime_interval = ktime_set(0, nanoseconds);
+	control = (control_record *)((void *) current->stack + sizeof(struct thread_info));
+	hrtimer_init(&(control->hr_timer), CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	control->hr_timer.function = &hr_sleep_callback;
+	control->task = current;
+	control->pid  = control->task->pid; //current->pid is more costly
+	control->awake = 0;
+	hrtimer_start(&(control->hr_timer), ktime_interval, HRTIMER_MODE_REL);
+	wait_event_interruptible(the_queue, control->awake == 1);
+	hrtimer_cancel(&(control->hr_timer));
+
+	return 0;
+
+}
+
+#endif
+
 /*
  * Functions related to boot-time initialization:
  */
-- 
2.25.1

