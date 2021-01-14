Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AFC2F5CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbhANIu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbhANIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:50:57 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0EC061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:50:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h186so2965198pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ef5N27J/hvqyljLtO2QT2Ao+PMGxMUjFzwbt45lWy80=;
        b=JlvtiglqlW/4VDbsrnE4bfF23ZtUjnqlxjuEzDYHFjleZ/p5MtNxEi9QpP1OWy/s6U
         mLYhT/fk2j76leNtMyPWmzn89gKwQWlucHg7g8Z1lBlxl3ze+lW7SjgZR+UnH6JlyMCU
         4R0ox42L/l4ID2qICYdYVDXmdGxh4JEiNbiiFO83gin1gcf00LrNG/SMRc6bMm2PAWjV
         DcmKXVKg4rhBucjKrNEHL8L0BJEYI6HETUfK8/62EBFH6ue7M4pcAEjI5zZapT7Nrlbq
         7XA3kI6t++xrRRbQG8tLo79dmUZ7rJL1wbtCgul9uviJqkNqCPWCNkX+/4uWWPhg5MGe
         0Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ef5N27J/hvqyljLtO2QT2Ao+PMGxMUjFzwbt45lWy80=;
        b=tNmJTwXi2o7f/8onLjBoYZDTWCHQgRtSzYfH5i/nhKbOHtGYZUriDgcvcw3mT/1pO8
         eNhBnjwuSnBmA94hgozxagQEowYjr4xt6tAtbEOb40iT+NrgRtb7xKUvHRufQeOIeXXP
         NknYyC2WFtP4ml8od7A+bMnQx4Mqm2Y4Iz/1dOGL5F+f4TTiy3YsF8FwlPKfwv+PZVhb
         jnVlfY1CBDBGW1aoLGKJoLHyLe0VFzby6IhbcqDgE7KJCGxws6m9P9T4ZXVG21eFoSte
         /sVX2JhQmyM+W0vtiJ6qx8GBfRHYJASwC9WXvsdYYRVK9YDv04ntGWGawL6/Ute7cRoS
         1kwQ==
X-Gm-Message-State: AOAM5333B3inaU6jri4YeCmoMzhwNGUSSdtqueMXGqneWp6v8pPHhboO
        7KeJhMROfP8XYlcxvBb17dJlPMRz6G6fpA==
X-Google-Smtp-Source: ABdhPJwgzIKsqBDT/Vq9hAMzjH/KJWPDYShr3iM/dZd93iv63xYNpyOr7844c45sin0teorVY4n+4Q==
X-Received: by 2002:a63:5463:: with SMTP id e35mr6452204pgm.151.1610614210474;
        Thu, 14 Jan 2021 00:50:10 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id gz5sm4992131pjb.15.2021.01.14.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:50:09 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Date:   Thu, 14 Jan 2021 17:50:03 +0900
Message-Id: <20210114085004.26606-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new software event to count context switches
involving cgroup switches.  So it's counted only if cgroups of
previous and next tasks are different.  Note that it only checks the
cgroups in the perf_event subsystem.  For cgroup v2, it shouldn't
matter anyway.

One can argue that we can do this by using existing sched_switch event
with eBPF.  But some systems might not have eBPF for some reason so
I'd like to add this as a simple way.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      | 38 +++++++++++++++------------------
 include/uapi/linux/perf_event.h |  1 +
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f579bc76..304ef42d42d1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1174,30 +1174,24 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
  * which is guaranteed by us not actually scheduling inside other swevents
  * because those disable preemption.
  */
-static __always_inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
+static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id])) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
+	struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
 
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(event_id, nr, regs, addr);
-	}
+	perf_fetch_caller_regs(regs);
+	___perf_sw_event(event_id, nr, regs, addr);
 }
 
 extern struct static_key_false perf_sched_events;
 
-static __always_inline bool
-perf_sw_migrate_enabled(void)
+static __always_inline bool __perf_sw_enabled(int swevt)
 {
-	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
-		return true;
-	return false;
+	return static_key_false(&perf_swevent_enabled[swevt]);
 }
 
 static inline void perf_event_task_migrate(struct task_struct *task)
 {
-	if (perf_sw_migrate_enabled())
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
 		task->sched_migrated = 1;
 }
 
@@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_in(prev, task);
 
-	if (perf_sw_migrate_enabled() && task->sched_migrated) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
-
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
+	    task->sched_migrated) {
+		__perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
 		task->sched_migrated = 0;
 	}
 }
@@ -1219,7 +1211,13 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 static inline void perf_event_task_sched_out(struct task_struct *prev,
 					     struct task_struct *next)
 {
-	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
+		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+
+	if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
+	    (task_css_check(prev, perf_event_cgrp_id, 1)->cgroup !=
+	     task_css_check(next, perf_event_cgrp_id, 1)->cgroup))
+		__perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
 
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
@@ -1475,8 +1473,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)			{ }
-static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
 static inline int perf_register_guest_info_callbacks
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e3447cd9f..16b9538ad89b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
-- 
2.30.0.284.gd98b1dd5eaa7-goog

