Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44C2CC040
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgLBPC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgLBPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:02:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E53C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:02:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s2so1257811plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3P5loR15urYiOowXymoe974FWWSbatntJueLM6bFHw=;
        b=Ey83Uoj7eYOuQPuaawIKFTLoDeM+Oqb4L+q8Hv9G6nWfj+Flyiixux6PAki+N8df/7
         YB/6I/P+oHFOJ3LtadJfjXe9Ib9AjhoCEPxzYhXM/dI2dmIBEdcps3sbqS3MciJvqVOx
         Yt6j2CMp5DNI4HuUxSGGMK3IPMzS5JrZaSUFYPv8Q5NjvgJseD6QjVVF0RCxQlF9nswP
         Khe8rSP6Ulz4jHtrR0tZvGUhdC4zmdnLZLgdI+nkunJK3qRwQT9vrj/4evT8wJqk9KA4
         wR4DbznE4s4PrNNxboXnU6mha8FI4VgPX3Jo6HbwTvWj2SvUdjXVXHSRbKNx0ssMKARI
         gIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=X3P5loR15urYiOowXymoe974FWWSbatntJueLM6bFHw=;
        b=g1bk76tj1zYtqOTpLspE+puUabikEmujosChsfjQHlETGtpsGdSh8ytIGx98GbJEp5
         lLlGCP1Q/5BudTwvxilvi9tyA4RbcPyEPfjVNq+dSnNTZqS+vDUo/mBu7XlNi8SmTo8t
         D1tMfCQPyobWmmrEob94ojIqK7RfiyIa2tjkrMYecpbXeVTBlUt5Sf6bmY1Knw35drxY
         u1mmCXuDfANItxmp+zYscTk5AitR7WHjXKDL3icBvdUL3dFGUpqU2wFMy36Q061gEcfR
         SqRCZ4nYnoWO4lFOvCxLWbc5thBwv/035hqzhifPXlqd5xHVP4SbPi3qEkiLaAMpXw1c
         EUsA==
X-Gm-Message-State: AOAM531iXhhqNk83vmTZZ0jcuykPrAXueKXLTOiHDG/65sAtjCjUzqix
        RbQMtyCjACVX8O80WJ77rC0=
X-Google-Smtp-Source: ABdhPJwN6//AXRsDOuKw+5Wuo9CxFteWjrwfOQI7ufulTPU8uKRgnPUQAIydg9+QoU6DWIoEXIeRxg==
X-Received: by 2002:a17:90a:7022:: with SMTP id f31mr230533pjk.213.1606921337832;
        Wed, 02 Dec 2020 07:02:17 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id gz2sm82773pjb.2.2020.12.02.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:02:17 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Date:   Thu,  3 Dec 2020 00:02:04 +0900
Message-Id: <20201202150205.35750-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new software event to count context switches
involving cgroup switches.  So it's counted only if cgroups of
previous and next tasks are different.

One can argue that we can do this by using existing sched_switch event
with eBPF.  But some systems might not have eBPF for some reason so
I'd like to add this as a simple way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      | 22 ++++++++++++++++++++++
 include/uapi/linux/perf_event.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f579bc76..d6dec422ba03 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1185,6 +1185,27 @@ perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 	}
 }
 
+#ifdef CONFIG_CGROUP_PERF
+static inline void
+perf_sw_event_cgroup_switch(struct task_struct *prev, struct task_struct *next)
+{
+	struct cgroup *prev_cgrp, *next_cgrp;
+
+	rcu_read_lock();
+
+	prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
+	next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
+
+	if (prev_cgrp != next_cgrp)
+		perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
+
+	rcu_read_unlock();
+}
+#else
+static inline void perf_sw_event_cgroup_switch(struct task_struct *prev,
+					       struct task_struct *next) {}
+#endif  /* CONFIG_CGROUP_PERF */
+
 extern struct static_key_false perf_sched_events;
 
 static __always_inline bool
@@ -1220,6 +1241,7 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 					     struct task_struct *next)
 {
 	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+	perf_sw_event_cgroup_switch(prev, next);
 
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
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
2.29.2.454.gaff20da3a2-goog

