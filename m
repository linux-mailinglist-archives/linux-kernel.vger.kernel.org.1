Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786872A946F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgKFKgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgKFKgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:36:13 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30CAE22210;
        Fri,  6 Nov 2020 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604658972;
        bh=/vTTl0pkJzaD4ZRo9JTNRTkKRqgmwGOEBRJhwSNSILM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKAnkjgF3YVzWr1IFN+8GQyhF1yJskb6G5SJjSwypMqm4mF0fi7nEHqiYLztUO23P
         IfMfpMD1Cfk3YcrHhnxjVWyhzAworBF7JBYFeIJAgxl8s6wroSCTjaYNCS5+6Apllz
         xHpwdMasrSMdGE6THyLkzl2GnB3MuB2oa5vj05og=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <cai@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/2] arm64: smp: Tell RCU about CPUs that fail to come online
Date:   Fri,  6 Nov 2020 10:36:02 +0000
Message-Id: <20201106103602.9849-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106103602.9849-1-will@kernel.org>
References: <20201106103602.9849-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ce3d31ad3cac ("arm64/smp: Move rcu_cpu_starting() earlier") ensured
that RCU is informed early about incoming CPUs that might end up calling
into printk() before they are online. However, if such a CPU fails the
early CPU feature compatibility checks in check_local_cpu_capabilities(),
then it will be powered off or parked without informing RCU, leading to
an endless stream of stalls:

  | rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  | rcu:	2-O...: (0 ticks this GP) idle=002/1/0x4000000000000000 softirq=0/0 fqs=2593
  | (detected by 0, t=5252 jiffies, g=9317, q=136)
  | Task dump for CPU 2:
  | task:swapper/2       state:R  running task     stack:    0 pid:    0 ppid:     1 flags:0x00000028
  | Call trace:
  | ret_from_fork+0x0/0x30

Ensure that the dying CPU invokes rcu_report_dead() prior to being powered
off or parked.

Cc: Qian Cai <cai@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Suggested-by: Qian Cai <cai@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/smp.c | 1 +
 kernel/rcu/tree.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 09c96f57818c..18e9727d3f64 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -413,6 +413,7 @@ void cpu_die_early(void)
 
 	/* Mark this CPU absent */
 	set_cpu_present(cpu, 0);
+	rcu_report_dead(cpu);
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 		update_cpu_boot_status(CPU_KILL_ME);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a52f42f64b6..bd04b09b84b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4077,7 +4077,6 @@ void rcu_cpu_starting(unsigned int cpu)
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 /*
  * The outgoing function has no further need of RCU, so remove it from
  * the rcu_node tree's ->qsmaskinitnext bit masks.
@@ -4117,6 +4116,7 @@ void rcu_report_dead(unsigned int cpu)
 	rdp->cpu_started = false;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * The outgoing CPU has just passed through the dying-idle state, and we
  * are being invoked from the CPU that was IPIed to continue the offline
-- 
2.29.1.341.ge80a0c044ae-goog

