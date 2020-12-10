Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811062D546A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgLJHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 02:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgLJHTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:19:09 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F2C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 23:18:29 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so3211788pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 23:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBXex/ZelVI7w49KD0gBWxx/5J6ZYKqlJeM7WHAEYXw=;
        b=M+s924MO4M5ZTfUHaDGTd8L7wU1msR4qkCgosWTH6Uy3+kyBirOemVAcetLXdxB7/9
         pZmCGPbuPZDtoObMgY1wrchDBhY6MxkmVaphYTBlc5MOIcKDll6HIYBkMWb1nU6EhVM3
         GRATZ/qv2dQO7QHn2wiye9UTQoIBpMJWRWmTvcX+soSH7732G7swROAixtxHr5uwqhxP
         sNM9u6OZMSo4TPs0XhnCGGUl1LAqccLzbjKHPSSIvou95ApBQPyRJPgEzRsj6ZbVTdcj
         WSzDgT2UyCeTeSDQ4/oNmztQgzEOFYljfEw4AxYK71plPkoZUuWquA9ARJsvWlRl/8vt
         f+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBXex/ZelVI7w49KD0gBWxx/5J6ZYKqlJeM7WHAEYXw=;
        b=NEJpcKhqHfDxGyMFtZ4D5/ocynGbpGGQBpLNJYT4znfqDoXppSEt0MZpI6Oz+l4dwf
         oXBPkewZdQqDdD211qVrrVoJ+JzghcIxGICu1dj27eicg45wNLFn5kKnwfXBS9A/xY3a
         9NsYgmZ4X2D1K23TGRE4R3Yb4PzPoQettUn8S7a/zgVZ7Vt3muSyc9m6s+ajIgUFPOl1
         oUNzRe49niUrCEDi/HK3Kcq7xNgXExIzImHyCzbI5gyXW0dCraT3DbSpdpkZNiU93Nsq
         zoamrIMpnubhsK4TAzIl8JbtJv38DzaQZfTvRFc78gbwlUbKZMldUz2pQtg0If1Z1bdK
         RcuA==
X-Gm-Message-State: AOAM532X7lJ5v7AlJW5gJ2+o28K2BmBqcLsrtRwRgchDezTQGNN/grwV
        LA5L9OOJ1hx5lfOu59h8mrSryA==
X-Google-Smtp-Source: ABdhPJzC09mjqTwrtWrQGDv0Va44dlq/EpHr1y8bkNPfTxmJcFid0rpvmzCZ/XAFOfK0gqnKV5h5LA==
X-Received: by 2002:a65:4642:: with SMTP id k2mr5535370pgr.338.1607584708513;
        Wed, 09 Dec 2020 23:18:28 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id h36sm5143759pgb.28.2020.12.09.23.18.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 23:18:27 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Date:   Thu, 10 Dec 2020 12:48:20 +0530
Message-Id: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I have stumbled upon this routine, I get confused with the
way 'have_policy' is used and I have to dig in to understand why is it
so.

Here is an attempt to make it easier to understand, and hopefully it is
an improvement. This is based on the logic that amu_fie_cpus will be
empty if cpufreq policy wasn't available for any CPU.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

Ionela, I think it would be even better to do this over this patch

-       /*
-        * If none of the CPUs have cpufreq support, we only enable
-        * the use of the AMU feature for FIE if all CPUs support AMU.
-        * Otherwise, enable_policy_freq_counters has already enabled
-        * policy cpus.
-        */
-       if (cpumask_empty(amu_fie_cpus) &&
-           cpumask_equal(valid_cpus, cpu_present_mask))
+       /* Overwrite amu_fie_cpus if all CPUs support AMU */
+       if (cpumask_equal(valid_cpus, cpu_present_mask))
                cpumask_copy(amu_fie_cpus, cpu_present_mask);

This will also take care of the case where the cpufreq policy isn't
there for a small group of CPUs, which do have AMUs enabled for them.
(This doesn't normally happen though).

---
 arch/arm64/kernel/topology.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f6faa697e83e..7f7d8de325b6 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -199,14 +199,14 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	return 0;
 }
 
-static inline bool
+static inline void
 enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 
 	if (!policy) {
 		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
-		return false;
+		return;
 	}
 
 	if (cpumask_subset(policy->related_cpus, valid_cpus))
@@ -214,8 +214,6 @@ enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
 			   amu_fie_cpus);
 
 	cpufreq_cpu_put(policy);
-
-	return true;
 }
 
 static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
@@ -225,7 +223,6 @@ static int __init init_amu_fie(void)
 {
 	bool invariance_status = topology_scale_freq_invariant();
 	cpumask_var_t valid_cpus;
-	bool have_policy = false;
 	int ret = 0;
 	int cpu;
 
@@ -245,17 +242,18 @@ static int __init init_amu_fie(void)
 			continue;
 
 		cpumask_set_cpu(cpu, valid_cpus);
-		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
+		enable_policy_freq_counters(cpu, valid_cpus);
 	}
 
 	/*
-	 * If we are not restricted by cpufreq policies, we only enable
+	 * If none of the CPUs have cpufreq support, we only enable
 	 * the use of the AMU feature for FIE if all CPUs support AMU.
 	 * Otherwise, enable_policy_freq_counters has already enabled
 	 * policy cpus.
 	 */
-	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
-		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
+	if (cpumask_empty(amu_fie_cpus) &&
+	    cpumask_equal(valid_cpus, cpu_present_mask))
+		cpumask_copy(amu_fie_cpus, cpu_present_mask);
 
 	if (!cpumask_empty(amu_fie_cpus)) {
 		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-- 
2.25.0.rc1.19.g042ed3e048af

