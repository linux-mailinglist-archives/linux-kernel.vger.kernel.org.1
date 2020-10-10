Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41428A40E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbgJJWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbgJJTT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:19:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81BC08EC3B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 11:02:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so10057492pgo.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHJ0OmfqVbDcuyKc17afvXjM3ddyTaCnk0goaZMLWNk=;
        b=dSSADXfSgODXfERpRj2rYpCuetEBefp5wRKDz4bFoF8Ydkyu50cJFN/ThGSn/Y+eFy
         cYZfr4Mk+XCGhT0rPdxpgFmGgL+mViztcbhGlgT590Q1yZCuuy8AYwNr5TC8oOgr0gPe
         mSR3LSaMcBWG19POYLaJIBmIH2CRK+rFZtfOPYmww10YnhJD8yq0xW5BPgWDx8O10l82
         7sH6yYVp6uj9+b7B3v43iXuJAhnDfCKXpRQ4uVhFWSKLkZPqQtrrDG0GcCMyCW45AYLN
         ldRdqY9rguk15MExW/yOHjxkNOmXamAZjV4hNo9I2JRh5PnBprXr2Ok13iGkmOtkyrja
         uA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHJ0OmfqVbDcuyKc17afvXjM3ddyTaCnk0goaZMLWNk=;
        b=qoy1Ipaj5blcl3zKa03l5NxwgvOUBDOeVS5zyMF453PK3b1jHJGLHLMRoxZYxM+DpU
         Vwhn/iWfI39EtEupeok8+HAYKIE2DelzFvzSHZ4zGmkEsFW/UDRvB74VqqmDKKkNPXpP
         MJ1OCO0D19gNoUwlkzB3jyU1Ofev+pi8bM5/yr7gs8G4BMUqBzbffuM0T0gCW3Od4YvZ
         jSvmrdUcJkyFMHeMKXtW0RIrO/89l8LnuhszDvlafK2WeeBlCINj+WMc1/H81zAzlYMX
         euA1nW6FhvaMt5UiHMhrPwfyU6UFjAyIZXlDLHl+RhwRC70Tu1BF6kwJLj7Z/hg5Q+8L
         uWXA==
X-Gm-Message-State: AOAM532TeA/SOkQ09WK1EGMe0ZQKKUHgJsEb+pWPkxJtI6LR7PJ8V7HP
        h3Yor/tlLEfyF7ZzF7GODWPo3SFPmLq82w==
X-Google-Smtp-Source: ABdhPJxoP3h85r9EBn+e3C9OMQvQZH2U+FznmQDsvhGARlHkCbbbnRfRFLhbbDfEWX/XfVRsV3Napg==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr11269010pjs.109.1602352937795;
        Sat, 10 Oct 2020 11:02:17 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id d128sm14983464pfd.94.2020.10.10.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 11:02:16 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] kthread: Add kthread_work tracepoints
Date:   Sat, 10 Oct 2020 11:03:22 -0700
Message-Id: <20201010180323.126634-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

While migrating some code from wq to kthread_worker, I found that I
missed the execute_start/end tracepoints.  So add similar tracepoints
for kthread_work.  And for completeness, queue_work tracepoint (although
this one differs slightly from the matching workqueue tracepoint).

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/trace/events/sched.h | 84 ++++++++++++++++++++++++++++++++++++
 kernel/kthread.c             |  9 ++++
 2 files changed, 93 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fec25b9cfbaf..349d9872e807 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_SCHED_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_SCHED_H
 
+#include <linux/kthread.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -51,6 +52,89 @@ TRACE_EVENT(sched_kthread_stop_ret,
 	TP_printk("ret=%d", __entry->ret)
 );
 
+/**
+ * sched_kthread_work_queue_work - called when a work gets queued
+ * @worker:	pointer to the kthread_worker
+ * @work:	pointer to struct kthread_work
+ *
+ * This event occurs when a work is queued immediately or once a
+ * delayed work is actually queued (ie: once the delay has been
+ * reached).
+ */
+TRACE_EVENT(sched_kthread_work_queue_work,
+
+	TP_PROTO(struct kthread_worker *worker,
+		 struct kthread_work *work),
+
+	TP_ARGS(worker, work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( void *,	worker)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->worker		= worker;
+	),
+
+	TP_printk("work struct=%p function=%ps worker=%p",
+		  __entry->work, __entry->function, __entry->worker)
+);
+
+/**
+ * sched_kthread_work_execute_start - called immediately before the work callback
+ * @work:	pointer to struct kthread_work
+ *
+ * Allows to track kthread work execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_start,
+
+	TP_PROTO(struct kthread_work *work),
+
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
+/**
+ * sched_kthread_work_execute_end - called immediately after the work callback
+ * @work:	pointer to struct work_struct
+ * @function:   pointer to worker function
+ *
+ * Allows to track workqueue execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_end,
+
+	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
+
+	TP_ARGS(work, function),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
 /*
  * Tracepoint for waking up a task:
  */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..c1e59d6bf802 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -704,8 +704,15 @@ int kthread_worker_fn(void *worker_ptr)
 	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
+		kthread_work_func_t func = work->func;
 		__set_current_state(TASK_RUNNING);
+		trace_sched_kthread_work_execute_start(work);
 		work->func(work);
+		/*
+		 * Avoid dereferencing work after this point.  The trace
+		 * event only cares about the address.
+		 */
+		trace_sched_kthread_work_execute_end(work, func);
 	} else if (!freezing(current))
 		schedule();
 
@@ -834,6 +841,8 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	trace_sched_kthread_work_queue_work(worker, work);
+
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
-- 
2.26.2

