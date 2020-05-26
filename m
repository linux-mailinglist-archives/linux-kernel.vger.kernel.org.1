Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFA1B9A63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 10:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD0Iho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 04:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0Iho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F00011B3;
        Mon, 27 Apr 2020 01:37:43 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FAD93F68F;
        Mon, 27 Apr 2020 01:37:39 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] sched/deadline: Add dl_bw_capacity()
Date:   Mon, 27 Apr 2020 10:37:06 +0200
Message-Id: <20200427083709.30262-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427083709.30262-1-dietmar.eggemann@arm.com>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Capacity-aware SCHED_DEADLINE admission control needs rd (root domain)
CPU capacity sum.

The design of this function follows that of dl_bw_cpus().

That is, return the rd CPU capacity sum in case the rd span a subset of
the cpu_active_mask.

Compute the CPU capacity sum over rd span and cpu_active_mask when in
hotplug.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4ae22bfc37ae..eb23e6921d94 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -69,6 +69,25 @@ static inline int dl_bw_cpus(int i)
 
 	return cpus;
 }
+
+static inline unsigned long dl_bw_capacity(int i)
+{
+	struct root_domain *rd = cpu_rq(i)->rd;
+	unsigned long cap;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "sched RCU must be held");
+
+	if (cpumask_subset(rd->span, cpu_active_mask))
+		return rd->sum_cpu_capacity;
+
+	cap = 0;
+
+	for_each_cpu_and(i, rd->span, cpu_active_mask)
+		cap += capacity_orig_of(i);
+
+	return cap;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -79,6 +98,11 @@ static inline int dl_bw_cpus(int i)
 {
 	return 1;
 }
+
+static inline unsigned long dl_bw_capacity(int i)
+{
+	return SCHED_CAPACITY_SCALE;
+}
 #endif
 
 static inline
-- 
2.17.1

