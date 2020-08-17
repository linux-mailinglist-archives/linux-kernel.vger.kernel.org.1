Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C04246563
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 13:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHQLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 07:30:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgHQLaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627AA1063;
        Mon, 17 Aug 2020 04:30:16 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0ED763F66B;
        Mon, 17 Aug 2020 04:30:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v6 02/17] ARM: Revert back to default scheduler topology.
Date:   Mon, 17 Aug 2020 12:29:48 +0100
Message-Id: <20200817113003.20802-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM-specific GMC level is meant to be built using the thread sibling
mask, but no devicetree in arch/arm/boot/dts uses the 'thread' cpu-map
binding. With SD_SHARE_POWERDOMAIN gone, this topology level can be
removed, at which point ARM no longer benefits from having a custom defined
topology table.

Delete the GMC topology level by making ARM use the default scheduler
topology table. This essentially reverts commit

  fb2aa85564f4 ("sched, ARM: Create a dedicated scheduler topology table")

No change in functionality is expected.

Cc: Russell King <linux@armlinux.org.uk>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/kernel/topology.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 353f3ee660e4..ef0058de432b 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -177,15 +177,6 @@ static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
-/*
- * The current assumption is that we can power gate each core independently.
- * This will be superseded by DT binding once available.
- */
-const struct cpumask *cpu_corepower_mask(int cpu)
-{
-	return &cpu_topology[cpu].thread_sibling;
-}
-
 /*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
@@ -241,20 +232,6 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }
 
-static inline int cpu_corepower_flags(void)
-{
-	return SD_SHARE_PKG_RESOURCES;
-}
-
-static struct sched_domain_topology_level arm_topology[] = {
-#ifdef CONFIG_SCHED_MC
-	{ cpu_corepower_mask, cpu_corepower_flags, SD_INIT_NAME(GMC) },
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
-
 /*
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
@@ -265,7 +242,4 @@ void __init init_cpu_topology(void)
 	smp_wmb();
 
 	parse_dt_topology();
-
-	/* Set scheduler topology descriptor */
-	set_sched_topology(arm_topology);
 }
-- 
2.27.0

