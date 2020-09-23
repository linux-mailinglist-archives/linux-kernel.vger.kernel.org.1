Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6810E2764AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIWXiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:38:04 -0400
Received: from z5.mailgun.us ([104.130.96.5]:54628 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWXiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:38:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600904283; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Bj+5WM36OBYaYaJ70VrcSWSbLrbdIOYy4LnLId1Zr9g=; b=wG2uEi8lFucX2HyqklbQtGJBdOOU2maLW35X3YcNsdoRNKIz0f5uSfW8hlWbt1Ij/epfh+HS
 M3JKItXT19y77QPxk0rmDLzz1CYgYmeqamTnz7Pes6YEggMlBAl1OaWBXBPJPk+186jptKqh
 u2QthTHwniV2t0Rb7cEicZglbnc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f6bdc5ad8a57df5abe3c107 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 23:38:02
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A34EC43385; Wed, 23 Sep 2020 23:38:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20CEAC433FE;
        Wed, 23 Sep 2020 23:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20CEAC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rostedt@goodmis.org, tglx@linutronix.de, qais.yousef@arm.com,
        peterz@infradead.org, mingo@kernel.org, cai@lca.pw,
        tyhicks@canonical.com, arnd@arndb.de
Cc:     rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 1/2] cpu/hotplug: Add cpuhp_latency trace event
Date:   Wed, 23 Sep 2020 16:37:45 -0700
Message-Id: <1600904266-102397-2-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ftrace event trace_cpuhp_latency to track cpu
hotplug latency. It helps to track the hotplug latency
impact by firmware changes and kernel cpu hotplug callbacks.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 include/trace/events/cpuhp.h | 29 +++++++++++++++++++++++++++++
 kernel/cpu.c                 |  9 +++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/trace/events/cpuhp.h b/include/trace/events/cpuhp.h
index ad16f77..c871850 100644
--- a/include/trace/events/cpuhp.h
+++ b/include/trace/events/cpuhp.h
@@ -6,6 +6,7 @@
 #define _TRACE_CPUHP_H
 
 #include <linux/tracepoint.h>
+#include <linux/sched/clock.h>
 
 TRACE_EVENT(cpuhp_enter,
 
@@ -89,6 +90,34 @@ TRACE_EVENT(cpuhp_exit,
 		  __entry->cpu, __entry->state, __entry->idx,  __entry->ret)
 );
 
+TRACE_EVENT(cpuhp_latency,
+
+	TP_PROTO(unsigned int cpu, unsigned int state,
+		 u64 start_time,  int ret),
+
+	TP_ARGS(cpu, state, start_time, ret),
+
+	TP_STRUCT__entry(
+		__field(unsigned int,	cpu)
+		__field(unsigned int,	state)
+		__field(u64,		time)
+		__field(int,		ret)
+	),
+
+	TP_fast_assign(
+		__entry->cpu	= cpu;
+		__entry->state	= state;
+		__entry->time	= div64_u64(sched_clock() - start_time, 1000);
+		__entry->ret	= ret;
+	),
+
+	TP_printk(" cpu:%d state:%s latency:%llu USEC ret: %d",
+		__entry->cpu, __entry->state ? "online" : "offline",
+		__entry->time, __entry->ret)
+);
+
+
+
 #endif
 
 /* This part must be outside protection */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578..68b3740 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -36,6 +36,7 @@
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/cpuhp.h>
+#include <linux/sched/clock.h>
 
 #include "smpboot.h"
 
@@ -994,6 +995,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	int prev_state, ret = 0;
+	u64 start_time = 0;
 
 	if (num_online_cpus() == 1)
 		return -EBUSY;
@@ -1002,6 +1004,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 		return -EINVAL;
 
 	cpus_write_lock();
+	if (trace_cpuhp_latency_enabled())
+		start_time = sched_clock();
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
@@ -1040,6 +1044,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	}
 
 out:
+	trace_cpuhp_latency(cpu, 0, start_time, ret);
 	cpus_write_unlock();
 	/*
 	 * Do post unplug cleanup. This is still protected against
@@ -1192,8 +1197,11 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	struct task_struct *idle;
 	int ret = 0;
+	u64 start_time = 0;
 
 	cpus_write_lock();
+	if (trace_cpuhp_latency_enabled())
+		start_time = sched_clock();
 
 	if (!cpu_present(cpu)) {
 		ret = -EINVAL;
@@ -1241,6 +1249,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	target = min((int)target, CPUHP_BRINGUP_CPU);
 	ret = cpuhp_up_callbacks(cpu, st, target);
 out:
+	trace_cpuhp_latency(cpu, 1, start_time, ret);
 	cpus_write_unlock();
 	arch_smt_update();
 	return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

