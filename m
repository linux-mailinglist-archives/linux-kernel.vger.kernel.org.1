Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2902A28BF10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgJLRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbgJLRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:35:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D6C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:35:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i2so14984953pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J88XLDonPMpU62P/Vyh5sLINH9HmaS9+E20ZqHLMFQE=;
        b=dOnx2mdz9d+fQmndBc1i82HhR6Ktt1zHjFEjlFWmSQgSWsdsp0NUvfFbnNprae7K2j
         S7YXhNIYzAIyepk26uav0KHe5UTBEq90zmBMJQl6vmHNuxZb66gFSeuGgNPCG/dU3Vbm
         KLzTUG2996hafXm6D6w5U73OiEcehsjCAbEuSqQeOfV2ZaO5h+5oyDaQSTJ82OstRE47
         xq071LosVgfu8jxX6yAmwud0YMOPJifjMd8uGh9wMPZWxaj2CU5mGdarpNr35DTaF1Du
         2M9Horf7AxDyZaDvdjJ+o7wQpBEnsM1WKjCAOnI171VFj3/VTLOSWmMgG64QeZdxZ28x
         nLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J88XLDonPMpU62P/Vyh5sLINH9HmaS9+E20ZqHLMFQE=;
        b=q+M5UPVcH1Lka90Z2iGRtqmIZ1LJ3ys2ztQLeJdvrXvey+rZvylhWt9Ww7/VIzhDbK
         Xk2zTRicJMOBSyMfe55VITnslRSjaDTCJgy/XXv3ACyJfU7lRpXVwB5ZA9B6SRrVl9Fg
         Qtc2I/qUW+2+YsiPUcPbGSu+r/75oMD88P0/YkRn23NF3Kfs/QCYcO71bu53VcHOjkPb
         khrZCDTjBrQhySyceuC6a1d4LNoTR9NXKXEfn6sN53w9tkZTTA2GQy2tcjE+dVwNxQew
         NTzIau8vxkh0+IZsTa5f9lo3uN90fBF++jcRnP5BFZBd2xiev2G/Ew7fj7XjLCEw5Lox
         4nBw==
X-Gm-Message-State: AOAM530c7tqveCQeOsmXxCUcACo7bUeSGeUi87p2p/e0yQDBbmdro/Ig
        qMpt58WhWHAGunCshl+NtyV40J9fjJs/FT62i18=
X-Google-Smtp-Source: ABdhPJya8Uu8vwew3sFu/HIix0k/36K/vQm+F3Yza43ajnScUlJXWNRRRv2oZHZ/7iZJddlFIrYs8A==
X-Received: by 2002:a63:e802:: with SMTP id s2mr14180707pgh.350.1602524107066;
        Mon, 12 Oct 2020 10:35:07 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id z20sm21042929pfk.199.2020.10.12.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:35:05 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Clark <robdclark@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Phil Auld <pauld@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] kthread: Add kthread_work tracepoints
Date:   Mon, 12 Oct 2020 10:36:28 -0700
Message-Id: <20201012173629.264991-1-robdclark@gmail.com>
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
v2: Use DECLARE_EVENT_CLASS (Steven Rostedt)

 include/trace/events/sched.h | 74 ++++++++++++++++++++++++++++++++++++
 kernel/kthread.c             |  9 +++++
 2 files changed, 83 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fec25b9cfbaf..c89dc6626f01 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_SCHED_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_SCHED_H
 
+#include <linux/kthread.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -51,6 +52,79 @@ TRACE_EVENT(sched_kthread_stop_ret,
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
+DECLARE_EVENT_CLASS(sched_kthread_work_execute_template,
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
+/**
+ * sched_kthread_work_execute_start - called immediately before the work callback
+ * @work:	pointer to struct kthread_work
+ * @function:   pointer to worker function
+ *
+ * Allows to track kthread work execution.
+ */
+DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_start,
+	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
+	TP_ARGS(work, function));
+
+/**
+ * sched_kthread_work_execute_end - called immediately after the work callback
+ * @work:	pointer to struct work_struct
+ * @function:   pointer to worker function
+ *
+ * Allows to track workqueue execution.
+ */
+DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_end,
+	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
+	TP_ARGS(work, function));
+
 /*
  * Tracepoint for waking up a task:
  */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3edaa380dc7b..7da6758283cd 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -704,8 +704,15 @@ int kthread_worker_fn(void *worker_ptr)
 	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
+		kthread_work_func_t func = work->func;
 		__set_current_state(TASK_RUNNING);
+		trace_sched_kthread_work_execute_start(work, work->func);
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

