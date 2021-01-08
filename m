Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF092EF12A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbhAHLRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbhAHLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:17:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C8C0612F8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:17:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so5966123pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQSpo9wPGFWd6ND2Dx/PvXRhV79s0OllfFs8qsmLEds=;
        b=T7BQnDakWGV4h7fCNx86iyaVp7/Nq3EbsmJDTpTr3xWVSsIcdZiNSE01n3qylOeHub
         AtyoC888q1UKe1Z738WG3YS9o3fDSvTRyN0Q8R5VSYJ0ZgB8P0GAnUFqlTseDprThW6B
         CKVz3/qs/S6oZ2GwQ2ldVYPLF7pedlyTNBpNsCumGNJM0MFguGYV/7KMVWCXk7upv6PU
         MfRZhIFUXUex+wNPtMs77hH1CHb99iPcHlZ2b1g7aETXjttUgv2EHHIpp0w3ZvLVaHBd
         hnnEt+F0E8WpXaxMHemtYGJ3k2he8sxuBOQ58EIDvEw46Z7pAWRH/VVMcTFzLL0FEX/R
         7snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQSpo9wPGFWd6ND2Dx/PvXRhV79s0OllfFs8qsmLEds=;
        b=SQVLzSz93j+eTqObvZTDb0ToNIhR4IrAKN+jVqtn1Ln4E8OJFADnezaK2wZi/RrCkM
         1odPZw72cMeXWpY8gfeaffZRqjRmrbLzcmPGIp1TQX+tdUiOax6FyinsmGn4z9EYA8dJ
         8w7AurVMcG5NH+qVLUVfghVnk0XKXbwT+0rZoWeTiHcpal+ycOP5vDcIF3nlwsOqw4aL
         yspJ1qQyJ8KHVEUP416rF2Ra+JvjhKDaoEAgENyziK2JL5DWiW8R50iD9HfZYwmmGsIA
         ejw9FFL3k6F9otSrCugq+S4oA+tmZ3qW/BwioBE3lLnPwtw7RIx7v959XrkaIhZuQHar
         vvdQ==
X-Gm-Message-State: AOAM531/9crnJNdze6jc68DNLVTQc5p7+8zYmQR1ss13vx0fqzJzSBf9
        hL+iIXy2dKNii7z+/mZMrvkG3g==
X-Google-Smtp-Source: ABdhPJwUtt8daot/gexutLZfaIc49DNONUydWkf19B4RHEwJTZIFLz91Y60h4LEYWN6XAzdnk2nSfw==
X-Received: by 2002:a17:902:bd85:b029:dc:1875:b7d7 with SMTP id q5-20020a170902bd85b02900dc1875b7d7mr3304252pls.0.1610104626929;
        Fri, 08 Jan 2021 03:17:06 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id c24sm10212678pgi.71.2021.01.08.03.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:17:06 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/3] arm64: topology: Make AMUs work with modular cpufreq drivers
Date:   Fri,  8 Jan 2021 16:46:53 +0530
Message-Id: <89c1921334443e133c9c8791b4693607d65ed9f5.1610104461.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
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

While at it, convert the print message to pr_debug instead of pr_info.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
 arch/arm64/kernel/topology.c | 92 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 57267d694495..e08a4126453a 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,69 +199,38 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
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
 
-	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-		cpumask_pr_args(amu_fie_cpus));
+	pr_debug("CPUs[%*pbl]: counters will be used for FIE.",
+		 cpumask_pr_args(cpus));
 
 	/*
 	 * Task scheduler behavior depends on frequency invariance support,
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
+	 * for the CPUs for which there are no counters available, the last set
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

