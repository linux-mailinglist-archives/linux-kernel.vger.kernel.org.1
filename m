Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49322764AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIWXiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:38:22 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:51996 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgIWXiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:38:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600904302; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=HcFRdBntZxDMQ9D3JZcncRFn0laX1xSNIWgKqLKU/qw=; b=TLX09YYmZXHGjYOEAYFHcO5ug0z8ZR5jVB1WL3Owat/PShNwchuJIeTvKVC0Y9uYO0hKHvE0
 kfuGcHrFUqrKq321U1Nxur1HAZpjn3Ejx7xtkvfyblCtN8DG21toT2nbLW1Jvgz3ZgwtVfvd
 c7NgdKjazGzI3HyMHw5QOEj0tUA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f6bdc5f588e0a98880049e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 23:38:07
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 248ECC433FE; Wed, 23 Sep 2020 23:38:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97B89C433FE;
        Wed, 23 Sep 2020 23:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97B89C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rostedt@goodmis.org, tglx@linutronix.de, qais.yousef@arm.com,
        peterz@infradead.org, mingo@kernel.org, cai@lca.pw,
        tyhicks@canonical.com, arnd@arndb.de
Cc:     rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 2/2] cpu-hotplug: Always use real time scheduling when hotplugging a CPU
Date:   Wed, 23 Sep 2020 16:37:46 -0700
Message-Id: <1600904266-102397-3-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Rameez Mustafa <rameezmustafa@codeaurora.org>

CPU hotplug operations take place in preemptible context. This leaves
the hotplugging thread at the mercy of overall system load and CPU
availability. If the hotplugging thread does not get an opportunity
to execute after it has already begun a hotplug operation, CPUs can
end up being stuck in a quasi online state. In the worst case a CPU
can be stuck in a state where the migration thread is parked while
another task is executing and changing affinity in a loop. This
combination can result in unbounded execution time for the running
task until the hotplugging thread gets the chance to run to complete
the hotplug operation.

Fix the said problem by ensuring that hotplug can only occur from
threads belonging to the RT sched class. This allows the hotplugging
thread priority on the CPU no matter what the system load or the
number of available CPUs are. If a SCHED_NORMAL task attempts to
hotplug a CPU, we temporarily elevate it's scheduling policy to RT.
Furthermore, we disallow hotplugging operations to begin if the
calling task belongs to the idle and deadline classes or those that
use the SCHED_BATCH policy.

Signed-off-by: Syed Rameez Mustafa <rameezmustafa@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/cpu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 68b3740..aea4ce2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -32,6 +32,7 @@
 #include <linux/relay.h>
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
+#include <uapi/linux/sched/types.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1191,6 +1192,33 @@ void cpuhp_online_idle(enum cpuhp_state state)
 	complete_ap_thread(st, true);
 }
 
+static int switch_to_rt_policy(void)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	unsigned int policy = current->policy;
+	int err;
+
+	/* Nobody should be attempting hotplug from these policy contexts. */
+	if (policy == SCHED_BATCH || policy == SCHED_IDLE ||
+					policy == SCHED_DEADLINE)
+		return -EPERM;
+
+	if (policy == SCHED_FIFO || policy == SCHED_RR)
+		return 1;
+
+	/* Only SCHED_NORMAL left. */
+	err = sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
+	return err;
+
+}
+
+static int switch_to_fair_policy(void)
+{
+	struct sched_param param = { .sched_priority = 0 };
+
+	return sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+}
+
 /* Requires cpu_add_remove_lock to be held */
 static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 {
@@ -1258,6 +1286,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 {
 	int err = 0;
+	int switch_err = 0;
 
 	if (!cpu_possible(cpu)) {
 		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
@@ -1268,6 +1297,10 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 		return -EINVAL;
 	}
 
+	switch_err = switch_to_rt_policy();
+	if (switch_err < 0)
+		return switch_err;
+
 	err = try_online_node(cpu_to_node(cpu));
 	if (err)
 		return err;
@@ -1286,6 +1319,14 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 	err = _cpu_up(cpu, 0, target);
 out:
 	cpu_maps_update_done();
+
+	if (!switch_err) {
+		switch_err = switch_to_fair_policy();
+		if (switch_err)
+			pr_err("Hotplug policy switch err=%d Task %s pid=%d\n",
+				switch_err, current->comm, current->pid);
+	}
+
 	return err;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

