Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE92A8A75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbgKEXJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732587AbgKEXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6149C2151B;
        Thu,  5 Nov 2020 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617766;
        bh=7xS20ktOREQzxIaFwCvXOEYKfqsP1oqb+blfshECMDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFMkNl7FVHe+EQCboSilPckMX+vyolRfMyvYojOzJgYNp774IjUd4f8sJOlT22v5f
         uMeI4l/7XGXhoDo/ry3zMBeAkK8pKo3rhTYkhLf5KSoYAMkFGoQdoGToba+0cYUEQM
         jLhwbazDdz8j9fO5SkTp1EK+vr3AJrYvdWmztJnA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/16] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Date:   Thu,  5 Nov 2020 15:09:12 -0800
Message-Id: <20201105230921.19017-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

This commit clarifies that the "p" and the "s" in the in the RCU_NOCB_CPU
config-option description refer to the "x" in the "rcuox/N" kthread name.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
[ paulmck: While in the area, update description and advice. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..cdc57b4 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -221,19 +221,23 @@ config RCU_NOCB_CPU
 	  Use this option to reduce OS jitter for aggressive HPC or
 	  real-time workloads.	It can also be used to offload RCU
 	  callback invocation to energy-efficient CPUs in battery-powered
-	  asymmetric multiprocessors.
+	  asymmetric multiprocessors.  The price of this reduced jitter
+	  is that the overhead of call_rcu() increases and that some
+	  workloads will incur significant increases in context-switch
+	  rates.
 
 	  This option offloads callback invocation from the set of CPUs
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
-
-	  Say Y here if you want to help to debug reduced OS jitter.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
+
+	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
 config TASKS_TRACE_RCU_READ_MB
-- 
2.9.5

