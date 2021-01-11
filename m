Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0722F1841
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbhAKO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbhAKO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q20so7779939pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHXu/wbWlBd02iW6Nq7oVJiV5+CuOT2SBdiRkf0MLa8=;
        b=OQykYFgs/Sw6v1dilu5eM+DNPHAw8JWxURnt9scT7zczl9oG2jv1u8tcapGAG7yMQ8
         ZLdQr1t7HU0a0OBdxEH/Cvk4QvVSasqBffCKmUE2yhRmFBz1+7rocfQwSavurqMkN5aX
         GZ7Hd6xk0YzTRFlkfeTCGopX7+8ZMDciDPo4Y/UT+mtxFlSMbR4u6eBKeug+1TS5l2RH
         ZN/eWhSq/1HCl/avNiY0nky43HGje+XDDc0E1JU/iaTitUJ2T2abtMP0z47jARBCw6W+
         BzRn66thiWkibE198PyuRRVWr6+U9fQKv5uhnLDyGUVyMlV3e9kI9z42CxPBdGenfV5l
         Dr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHXu/wbWlBd02iW6Nq7oVJiV5+CuOT2SBdiRkf0MLa8=;
        b=MSlDG6pXAWt3jk4TYxbv28RoqksV0I+reXEixAlnt1Vs/jwZjBY8amtQZa0DNVrBFO
         248tYBPeLOlsiVY2J65o8SPVaA9LF6zazdCS6ZcQCxsY6bJNFcTKuRuciUxbv5wdM8YY
         zqDOESPvJQ7cb3Ag2VviIp6HSCi+V2v2N9Ca2wpTfjemQEvQuP/7IyWY6EhwreDiVszH
         gFb371FlPOmJBTZpJaKwgL7L2z/zRXZPQLH30I2wQ3MzY8N+vqTW6EprvbiQWYS6vP+7
         k/AT2wxvqZUVwbt8aVHIT6mHOUiJupZ/W7PaDxrLyrSiW1P1+IVDbqzwMC/C8dsUI2p7
         BsDQ==
X-Gm-Message-State: AOAM5306EbJJsxbZ32hV9Me+xWfWr3lYsk2Nj1798O0aYNT9rgLJn1Hn
        6VCS2rrrotDnG8Gm/Tw1DS1Q3uOg66k=
X-Google-Smtp-Source: ABdhPJy3L2W792CfZ2ZWWWQoTzFrV9tvDyVsFs9zTPCMb9D6qsxWqNVJcfCKkvq2h96k6Uor0UAZhg==
X-Received: by 2002:aa7:804f:0:b029:1a9:5aa1:6235 with SMTP id y15-20020aa7804f0000b02901a95aa16235mr16529850pfm.1.1610375171029;
        Mon, 11 Jan 2021 06:26:11 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id o129sm18559690pfg.66.2021.01.11.06.26.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:26:10 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Tejun Heo <tj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hillf Danton <hdanton@sina.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Jones <drjones@redhat.com>,
        Zqiang <qiang.zhang@windriver.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ethon Paul <ethp@qq.com>
Subject: [PATCH -tip V4 1/8] workqueue: split cpuhotplug callbacks for unbound workqueue
Date:   Mon, 11 Jan 2021 23:26:31 +0800
Message-Id: <20210111152638.2417-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210111152638.2417-1-jiangshanlai@gmail.com>
References: <20210111152638.2417-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Unbound workers are normally non-per-cpu-kthread, but when cpu hotplug,
we also need to update the pools of unbound workqueues based on the info
that whether the relevant node has CPUs online or not for every workqueue.

The code reuses current cpu hotplug callbacks which are designed for
per-cpu workqueues and not well fit with unbound workqueues/pool/workers.

For example workqueue_offline_cpu() is very late, work items of unbound
workqueue might delay offline process or even worse it might cause
offline stopped due to back-to-back work items which are not really
needed to be per-cpu.

And it is also very bad when unbound worker are created after
sched_cpu_deactivate().  set_cpus_allowed_ptr() with online&!active
cpumasks (multi CPUs) will cause warning, and no one will deactivate
such late spawned workers and might cause later BUG_ON().

Similarly, workqueue_online_cpu is verly early, work items of unbound
workqueue might delay online process.  And it is also very bad when
unbound worker are created before sched_cpu_activate().
set_cpus_allowed_ptr() with online&!active cpumasks (multi CPUs) will
cause warning.  For example, the commit d945b5e9f0e("workqueue: Fix
setting affinity of unbound worker threads") fixed it in some cases
of the problem, leaving other cases unfixed and leaving the comment
does not match with the fixing code.

So we need to split cpuhotplug callback for unbound workqueue and
put the new cpuhotplug callbacks in proper places.

Normally, we can split them and put them to CPUHP_AP_ONLINE_DYN.  But it
doesn't solve the problem of set_cpus_allowed_ptr() with online&!active
cpumasks.  So we have to use an offline callback earlier than
sched_cpu_deactivate() and an online callbck later than sched_cpu_activate().

This patch just introduces CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE and
splits the callbacks.  The follow-up fixes are in the later patches.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/cpuhotplug.h |  4 ++++
 include/linux/workqueue.h  |  2 ++
 kernel/cpu.c               |  5 +++++
 kernel/workqueue.c         | 36 ++++++++++++++++++++++++++----------
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0042ef362511..ac2103deb20b 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -20,6 +20,9 @@
  *		  |				  ^
  *		  v				  |
  *              AP_ACTIVE			AP_ACTIVE
+ *		  |				  ^
+ *		  v				  |
+ *              ONLINE				ONLINE
  */
 
 enum cpuhp_state {
@@ -194,6 +197,7 @@ enum cpuhp_state {
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
 	CPUHP_AP_ACTIVE,
+	CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
 	CPUHP_ONLINE,
 };
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a..98300ddee308 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -663,6 +663,8 @@ static inline void wq_watchdog_touch(int cpu) { }
 int workqueue_prepare_cpu(unsigned int cpu);
 int workqueue_online_cpu(unsigned int cpu);
 int workqueue_offline_cpu(unsigned int cpu);
+int workqueue_unbound_online_cpu(unsigned int cpu);
+int workqueue_unbound_offline_cpu(unsigned int cpu);
 #endif
 
 void __init workqueue_init_early(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91010e1..f654ca0a104e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1665,6 +1665,11 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= sched_cpu_activate,
 		.teardown.single	= sched_cpu_deactivate,
 	},
+	[CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE] = {
+		.name			= "workqueue_unbound:online",
+		.startup.single		= workqueue_unbound_online_cpu,
+		.teardown.single	= workqueue_unbound_offline_cpu,
+	},
 #endif
 
 	/* CPU is fully up and running. */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9880b6c0e272..d7bdb7885e55 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5060,6 +5060,29 @@ int workqueue_prepare_cpu(unsigned int cpu)
 }
 
 int workqueue_online_cpu(unsigned int cpu)
+{
+	struct worker_pool *pool;
+
+	for_each_cpu_worker_pool(pool, cpu) {
+		mutex_lock(&wq_pool_attach_mutex);
+		rebind_workers(pool);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
+
+	return 0;
+}
+
+int workqueue_offline_cpu(unsigned int cpu)
+{
+	/* unbinding per-cpu workers should happen on the local CPU */
+	if (WARN_ON(cpu != smp_processor_id()))
+		return -1;
+
+	unbind_workers(cpu);
+	return 0;
+}
+
+int workqueue_unbound_online_cpu(unsigned int cpu)
 {
 	struct worker_pool *pool;
 	struct workqueue_struct *wq;
@@ -5067,12 +5090,11 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	mutex_lock(&wq_pool_mutex);
 
+	/* update CPU affinity of workers of unbound pools */
 	for_each_pool(pool, pi) {
 		mutex_lock(&wq_pool_attach_mutex);
 
-		if (pool->cpu == cpu)
-			rebind_workers(pool);
-		else if (pool->cpu < 0)
+		if (pool->cpu < 0)
 			restore_unbound_workers_cpumask(pool, cpu);
 
 		mutex_unlock(&wq_pool_attach_mutex);
@@ -5086,16 +5108,10 @@ int workqueue_online_cpu(unsigned int cpu)
 	return 0;
 }
 
-int workqueue_offline_cpu(unsigned int cpu)
+int workqueue_unbound_offline_cpu(unsigned int cpu)
 {
 	struct workqueue_struct *wq;
 
-	/* unbinding per-cpu workers should happen on the local CPU */
-	if (WARN_ON(cpu != smp_processor_id()))
-		return -1;
-
-	unbind_workers(cpu);
-
 	/* update NUMA affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
 	list_for_each_entry(wq, &workqueues, list)
-- 
2.19.1.6.gb485710b

