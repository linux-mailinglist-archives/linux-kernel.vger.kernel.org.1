Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8226BB87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIPEcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:32:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:36468 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgIPEci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:32:38 -0400
IronPort-SDR: JpGYiVj9SXhsvlfVGT7IIAZ6qXkwOBGUnmK2JJzRQky9xaNM9rxY/M2En5S5F1FLkgY6wD4BsV
 sRCVcX51ar1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="177472633"
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="177472633"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 21:32:37 -0700
IronPort-SDR: B4IqtkCpykAqBWQfc8IZVQIhZ6JmyZHUz8w0vgR4M2EKqXzTCXWgWQGjs4Jkg1rFlfhKgwxbGG
 R/SsfXI3nqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,431,1592895600"; 
   d="scan'208";a="331516508"
Received: from aubrey-work.sh.intel.com ([10.239.53.113])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2020 21:32:34 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in sched domain
Date:   Wed, 16 Sep 2020 12:31:03 +0800
Message-Id: <20200916043103.606132-1-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added idle cpumask to track idle cpus in sched domain. When a CPU
enters idle, its corresponding bit in the idle cpumask will be set,
and when the CPU exits idle, its bit will be cleared.

When a task wakes up to select an idle cpu, scanning idle cpumask
has low cost than scanning all the cpus in last level cache domain,
especially when the system is heavily loaded.

The following benchmarks were tested on a x86 4 socket system with
24 cores per socket and 2 hyperthreads per core, total 192 CPUs:

uperf throughput: netperf workload, tcp_nodelay, r/w size = 90

  threads	baseline-avg	%std	patch-avg	%std
  96		1               1.24	0.98		2.76
  144		1		1.13	1.35		4.01
  192		1		0.58	1.67		3.25
  240		1		2.49	1.68		3.55

hackbench: process mode, 100000 loops, 40 file descriptors per group

  group		baseline-avg	%std	patch-avg	%std
  2(80)		1		12.05	0.97		9.88
  3(120)	1		12.48	0.95		11.62
  4(160)	1		13.83	0.97		13.22
  5(200)	1		2.76	1.01		2.94

schbench: 99th percentile latency, 16 workers per message thread

  mthread	baseline-avg	%std	patch-avg	%std
  6(96)		1		1.24	0.993		1.73
  9(144)	1		0.38	0.998		0.39
  12(192)	1		1.58	0.995		1.64
  15(240)	1		51.71	0.606		37.41

sysbench mysql throughput: read/write, table size = 10,000,000

  thread	baseline-avg	%std	patch-avg	%std
  96		1               1.77	1.015		1.71
  144		1		3.39	0.998		4.05
  192		1		2.88	1.002		2.81
  240		1		2.07	1.011		2.09

kbuild: kexec reboot every time

  baseline-avg	patch-avg
  1		1

v1->v2:
- idle cpumask is updated in the nohz routines, by initializing idle
  cpumask with sched_domain_span(sd), nohz=off case remains the original
  behavior.

Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jiang Biao <benbjiang@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 include/linux/sched/topology.h | 13 +++++++++++++
 kernel/sched/fair.c            |  9 ++++++++-
 kernel/sched/topology.c        |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..43a641d26154 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -65,8 +65,21 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	/*
+	 * Span of all idle CPUs in this domain.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	idle_cpus_span[];
 };
 
+static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->idle_cpus_span);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b3b59cc51d6..cfe78fcf69da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6136,7 +6136,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	/*
+	 * sched_domain_shared is set only at shared cache level,
+	 * this works only because select_idle_cpu is called with
+	 * sd_llc.
+	 */
+	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
@@ -10182,6 +10187,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	sd->nohz_idle = 0;
 
 	atomic_inc(&sd->shared->nr_busy_cpus);
+	cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
 unlock:
 	rcu_read_unlock();
 }
@@ -10212,6 +10218,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	sd->nohz_idle = 1;
 
 	atomic_dec(&sd->shared->nr_busy_cpus);
+	cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
 unlock:
 	rcu_read_unlock();
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9079d865a935..f14a6ef4de57 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1407,6 +1407,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
 	}
 
 	sd->private = sdd;
@@ -1769,7 +1770,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.25.1

