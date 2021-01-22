Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732B2FFEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhAVIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:51:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11428 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbhAVIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:49:37 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMXvj4Ldqzj580
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:47:45 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 16:48:33 +0800
From:   Liu Chao <liuchao173@huawei.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
Subject: [PATCH] genirq: Limit irq_calc_affinity_vectors to housekeeping CPUs
Date:   Fri, 22 Jan 2021 08:47:46 +0000
Message-ID: <20210122084746.3407372-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the cpumask used in irq_calc_affinity_vectors from all possible
CPUs to only housekeeping CPUs.

When we have isolated CPUs used by real-time tasks, IRQs will be move to
housekeeping CPUs.

If there are too many IRQ vectors, moving the all to housekeeping CPUs may
exceed per-CPU vector limits. For example, when I only have two
housekeeping CPUs, there are dozens of IRQs on two CPUs, but actually one
IRQ per housekeeping CPU is enough.

Signed-off-by: Liu Chao <liuchao173@huawei.com>
---
 kernel/irq/affinity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..3f22e3314e1b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/sort.h>
+#include <linux/sched/isolation.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -506,7 +507,8 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 		set_vecs = maxvec - resv;
 	} else {
 		get_online_cpus();
-		set_vecs = cpumask_weight(cpu_possible_mask);
+		set_vecs = cpumask_weight(
+				housekeeping_cpumask(HK_FLAG_MANAGED_IRQ));
 		put_online_cpus();
 	}
 
-- 
2.23.0

