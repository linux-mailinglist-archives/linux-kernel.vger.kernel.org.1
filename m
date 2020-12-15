Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A772DA7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLOFgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgLOFfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:35:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB60C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x18so4259394pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Inc8dinYQAlGT5BgcNFExipWp8kF8aKZc4Rc2pdmTFE=;
        b=F3W+30NrFnYS6OxRVpnS+92LFlMqyuIbh9uJUupi+IxFLS2veW9RdhalGL98lqI6ra
         1X/KaQFt/n6vWSx+jA4aq3UDPQyAl4u1lbX2qQ5kdIjKqYFlbDilQ8yPbaiFkPtQCYO4
         r0fwng4GMd0TIizdbGRB4y9UoC1noNoxbtnn3OkO9J+YuqZBXrsjtyZqo91mHaN6+HQ/
         YVCp0YYpOTAPaLiy5Ypwa3EBhz9MwqqJPP+P5mNJX2VB2y2Tfzjj65MbYNSLcGS/4ByG
         Pd8V9R2Jzkuc56Jo3XaVOgZeeyH1i6uusBr5pQ3BKmAZchk8SPfI7o8o3t/pj8QaCwyh
         DP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Inc8dinYQAlGT5BgcNFExipWp8kF8aKZc4Rc2pdmTFE=;
        b=LI9d7U4c3uS/6aQr2DdQMYzK+MSHUVVWANILWlJdcSmVY3A/bZYUyyHulIWQ+HR+EB
         A/4njs6bcxOsCtjQpuJAH2oK2lfowS5a5sD5VLVPv1wf2ot+I0zP50zQ3YZZeDeoNFd+
         4lK9n2z2sbUXjGiBTemRJmZaBGByB1OAbDhkVxmFA6zFJJXGTskBzIZKivtId6D4rXlL
         VndJfsQo7L5C/rK85x0SlTCjMfFq3yOZlSMhUr8TMVB0AZbv2x0vmHX1lhqXXBW2aUS7
         i11giPZKzNezlPZ4nNtRh0qljzme6pUhYM6dP+zlKn55lZPXOmGFZNYKRw9xYfKnmzaX
         BGzA==
X-Gm-Message-State: AOAM531dGOasHPcrLXcTpezaq2Z8hFns9PrCm661jOmRVRSGFHvkkXdc
        3X2MtbSSoAgpcTaFSz0LQywrAznqHJc4hw==
X-Google-Smtp-Source: ABdhPJwVjo6+JEYhHW0Dd+3SfomSsbXagYooBEySexBFGqYOe+ZXGwmoVAvstSesdzKx8PaRD0XAow==
X-Received: by 2002:a17:90a:a394:: with SMTP id x20mr27698233pjp.24.1608010472084;
        Mon, 14 Dec 2020 21:34:32 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id l141sm23656776pfd.124.2020.12.14.21.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 21:34:31 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular cpufreq drivers
Date:   Tue, 15 Dec 2020 11:04:16 +0530
Message-Id: <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMU counters won't get used today if the cpufreq driver is built as
a module as the amu core requires everything to be ready by late init.

Fix that properly by registering for cpufreq policy notifier. Note that
the amu core don't have any cpufreq dependency after the first time
CPUFREQ_CREATE_POLICY notifier is called for all the CPUs. And so we
don't need to do anything on the CPUFREQ_REMOVE_POLICY notifier. And for
the same reason we check if the CPUs are already parsed in the beginning
of amu_fie_setup() and skip if that is true. Alternatively we can shoot
a work from there to unregister the notifier instead, but that seemed
too much instead of this simple check.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3:
- This is a new patch.

Ionela,

I don't have a way to test the AMU stuff, will it be possible for you to
give it a try ?

 arch/arm64/kernel/topology.c | 88 +++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 57267d694495..0fc2b32ddb45 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,64 +199,33 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	return 0;
 }
 
-static inline void
-enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-
-	if (!policy) {
-		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
-		return;
-	}
-
-	if (cpumask_subset(policy->related_cpus, valid_cpus))
-		cpumask_or(amu_fie_cpus, policy->related_cpus,
-			   amu_fie_cpus);
-
-	cpufreq_cpu_put(policy);
-}
-
 static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 #define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
 
-static int __init init_amu_fie(void)
+static void amu_fie_setup(const struct cpumask *cpus)
 {
-	cpumask_var_t valid_cpus;
 	bool invariant;
-	int ret = 0;
 	int cpu;
 
-	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto free_valid_mask;
-	}
+	/* We are already set since the last insmod of cpufreq driver */
+	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
+		return;
 
-	for_each_present_cpu(cpu) {
+	for_each_cpu(cpu, cpus) {
 		if (!freq_counters_valid(cpu) ||
 		    freq_inv_set_max_ratio(cpu,
 					   cpufreq_get_hw_max_freq(cpu) * 1000,
 					   arch_timer_get_rate()))
-			continue;
-
-		cpumask_set_cpu(cpu, valid_cpus);
-		enable_policy_freq_counters(cpu, valid_cpus);
+			return;
 	}
 
-	/* Overwrite amu_fie_cpus if all CPUs support AMU */
-	if (cpumask_equal(valid_cpus, cpu_present_mask))
-		cpumask_copy(amu_fie_cpus, cpu_present_mask);
-
-	if (cpumask_empty(amu_fie_cpus))
-		goto free_valid_mask;
+	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
 
 	invariant = topology_scale_freq_invariant();
 
 	/* We aren't fully invariant yet */
 	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
-		goto free_valid_mask;
+		return;
 
 	static_branch_enable(&amu_fie_key);
 
@@ -271,13 +240,48 @@ static int __init init_amu_fie(void)
 	 */
 	if (!invariant)
 		rebuild_sched_domains_energy();
+}
+
+static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
+				 void *data)
+{
+	struct cpufreq_policy *policy = data;
+
+	if (val == CPUFREQ_CREATE_POLICY)
+		amu_fie_setup(policy->related_cpus);
+
+	/*
+	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
+	 * counters don't have any dependency on cpufreq driver once we have
+	 * initialized AMU support and enabled invariance. The AMU counters will
+	 * keep on working just fine in the absence of the cpufreq driver, and
+	 * for the CPUs for which there are no counters availalbe, the last set
+	 * value of freq_scale will remain valid as that is the frequency those
+	 * CPUs are running at.
+	 */
+
+	return 0;
+}
+
+static struct notifier_block init_amu_fie_notifier = {
+	.notifier_call = init_amu_fie_callback,
+};
+
+static int __init init_amu_fie(void)
+{
+	int ret;
+
+	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
+		return -ENOMEM;
 
-free_valid_mask:
-	free_cpumask_var(valid_cpus);
+	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
+					CPUFREQ_POLICY_NOTIFIER);
+	if (ret)
+		free_cpumask_var(amu_fie_cpus);
 
 	return ret;
 }
-late_initcall_sync(init_amu_fie);
+core_initcall(init_amu_fie);
 
 bool arch_freq_counters_available(const struct cpumask *cpus)
 {
-- 
2.25.0.rc1.19.g042ed3e048af

