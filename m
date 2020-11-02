Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474FA2A2D66
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgKBOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKBOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:52:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:52:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so9032539pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imqL4ZI7SVadxqzQXSnH8+LbIrgVC3m2vlSFu6DyUZQ=;
        b=iLS+4e6Ov6lWJxWFWt56MZIw3R0JoLnW4St45mLHG0b7FBCO+3OFusi/6l2tjTB8Hx
         7pj6MyFwGBfwByku4p1tF08sE2Q8u1ql4Jv6uAvZ/EJgYz8aWGTOdpMfJkGPDVqr5k0p
         8bV6KOSoq7Ycsv463zqbJ7UG9w0uz/6Mblaqtj17a/kfa90pQVxsftuJ2TQCixTVrE9R
         g5qvyoLjBb3glEw+D/dDwNP5DQ5wPuKBa4i1sIxqaB7cL6YSxS82G+C+F/iBm57qyCQT
         93iWD81fWJFFwMxRjv8galOISLvK+pwEOx99sBaTJzFLvFkaDMi988jHvM3o+V7vwxV5
         uHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=imqL4ZI7SVadxqzQXSnH8+LbIrgVC3m2vlSFu6DyUZQ=;
        b=t6+z2o0vCzbqgA2btmW7doRN2Q5pKVEkCpZTFxsmwcHV+MdrahE2xmmdJiOno4+Z1y
         D47DU3ZhVe4FF59XB/SkbKUzIuqVakuxXlcczUPwsvOyOdqQVXn7qO4KqZnueOlVAU0y
         /2JGYpHg0aHSSpzjATBypJTGaqF31B7Hvvh3axRhdqMhYOueSSe41vOL6g2KPU2INmtQ
         hb7lUQES3W2ad17XYMJOSdn9EgYDVnhLZ1CE8/MUnXMoX8eySyNgSqM3lEFMElP3UXR7
         DtTM76i4SA5ACkJ1F0PVsB5Rl5ZulkH3XuasRUQ8gp+iRXCOMAL4x+ia7yokVLBOYM/b
         Amgg==
X-Gm-Message-State: AOAM532jKw9prtC9Z7vHGpsdxBuTe5UH7sFmgNE3QN3neioR5+34RH/P
        K9DjSEGxFwJfYL2LJ2NcZSw=
X-Google-Smtp-Source: ABdhPJwPtGIMRUUy+rhvSalkfx2xVYeRpoxvbVAeGU32zzSVw736F5dlhy01oGZORyGn+9PthrxIlw==
X-Received: by 2002:a62:ea13:0:b029:18a:adb3:b6fe with SMTP id t19-20020a62ea130000b029018aadb3b6femr11315754pfh.67.1604328761782;
        Mon, 02 Nov 2020 06:52:41 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id y4sm13513091pjc.53.2020.11.02.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:52:41 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Gabriel Marin <gmx@google.com>
Subject: [RFC 2/2] perf/core: Invoke pmu::sched_task callback for per-cpu events
Date:   Mon,  2 Nov 2020 23:52:21 +0900
Message-Id: <20201102145221.309001-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102145221.309001-1-namhyung@kernel.org>
References: <20201102145221.309001-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 44fae179ce73 ("perf/core: Pull pmu::sched_task() into
perf_event_context_sched_out()") moved the pmu::sched_task callback to
be called for task event context.  But it missed to call it for
per-cpu events to flush PMU internal buffers (i.e. for PEBS, ...).

This commit basically reverts the commit but keeps the optimization
for task events and only add missing calls for cpu events.

Fixes: 44fae179ce73 ("perf/core: Pull pmu::sched_task() into perf_event_context_sched_out()")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0defb526cd0c..abb70a557cb5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -872,6 +872,7 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
+	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
 	int				online;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aaa0155c4142..c04d9a913537 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -383,6 +383,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
+static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -3480,11 +3481,16 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 	}
 }
 
+static DEFINE_PER_CPU(struct list_head, sched_cb_list);
+
 void perf_sched_cb_dec(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	--cpuctx->sched_cb_usage;
+	this_cpu_dec(perf_sched_cb_usages);
+
+	if (!--cpuctx->sched_cb_usage)
+		list_del(&cpuctx->sched_cb_entry);
 }
 
 
@@ -3492,7 +3498,10 @@ void perf_sched_cb_inc(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	cpuctx->sched_cb_usage++;
+	if (!cpuctx->sched_cb_usage++)
+		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+
+	this_cpu_inc(perf_sched_cb_usages);
 }
 
 /*
@@ -3521,6 +3530,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
+static void perf_pmu_sched_task(struct task_struct *prev,
+				struct task_struct *next,
+				bool sched_in)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (prev == next)
+		return;
+
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		/* will be handled in perf_event_context_sched_in/out */
+		if (cpuctx->task_ctx)
+			continue;
+
+		__perf_pmu_sched_task(cpuctx, sched_in);
+	}
+}
+
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
@@ -3543,6 +3570,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
 {
 	int ctxn;
 
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(task, next, false);
+
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
@@ -3850,6 +3880,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
+
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
@@ -12999,6 +13032,7 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
+		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

