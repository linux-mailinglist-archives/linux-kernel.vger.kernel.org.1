Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9B2D61DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392064AbgLJQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbgLJQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:30:14 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:29:33 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w5so3909149pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uW7jPDAJP0W04jlB4xyfWMLexo3zn7jvZAA+I5zJHp0=;
        b=rfbCw2pDR9L3wrIjols0HhZZ+nbrQq7ayfwaLPo9A5f/YDf+wcNW0WMWhYomSw/2Y6
         ije2M5566hxUfHBWNtc0KkEZBuS/NsJNJQHaAH0cW6hc7HqSGuStC2bG5xYcWJsIGV+b
         jCwDNlChUCyc8g8LB9eoogC3eHhZYb51MpkbDYz6349H3OHfyBQBwyYqb2bzn50TLCQH
         SHeGPvucXyyuiRaOa5FzQZ3Vn+kyraGVogTk7M0H6qHk63VWNFG/HtNXXY6MTkK7m2PR
         4r6FrbAshrINB+COW8A9/15fPHoabOuEnNWcoaj6WykEg9eku9af2c7c3i7ApKrTSFGj
         cyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uW7jPDAJP0W04jlB4xyfWMLexo3zn7jvZAA+I5zJHp0=;
        b=aX+VEbZgqiD4WJAnoj2nmGR8Y5JeY/TwyUCp114pQlgnI1MFR9Aosv1bG0J3nX7n7/
         HK/eZYlvRFsZ53AC719nwpPhX4PqGHMT8FLuBFeG+3qSwFTi62bYnztQWryHJp7ROPly
         RjqgDv6eHBtlErf8K0BIVfi3oZpdsOMNZQsGUuz73Fnth07bcEQ1tWAQCLSyY79Dtd2R
         DTwnRshD9cQrsdpvfsR3srnHxWF7srPFO3KqYPspZcO6uZH964LXNF+UNdWC/wF7n0+5
         3Bi9Ek46VZ+WJjEYacH035kfPDS8M6Ae9AVwgA7B6t06fyAkcCbUJYbVaxfV4KcDeVtT
         ntow==
X-Gm-Message-State: AOAM530oBjr6qbwwdK2YOyrLi6y73GjPsRnLztphknm9gRUk85Eoey6b
        63iHMJHTCDm2DYqImhnNSPE8ug==
X-Google-Smtp-Source: ABdhPJwtzzxEFMY808WWjp/6A+1rJeaDRULKBdPL3epPOOV5Xprf8FqEKOHkYblFqy8Y89ieyJgGAQ==
X-Received: by 2002:a17:90a:a012:: with SMTP id q18mr8242051pjp.223.1607617772619;
        Thu, 10 Dec 2020 08:29:32 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id x15sm6764754pfn.118.2020.12.10.08.29.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 08:29:31 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] arm64: topology: Avoid the have_policy check
Date:   Thu, 10 Dec 2020 21:59:22 +0530
Message-Id: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I have stumbled upon this routine, I get confused with the
way 'have_policy' is used and I have to dig in to understand why is it
so. Here is an attempt to make it easier to understand, and hopefully it
is an improvement.

The 'have_policy' check was just an optimization to avoid writing
to amu_fie_cpus in case we don't have to, but that optimization itself
is creating more confusion than the real work. Lets just do that if all
the CPUs support AMUs. It is much cleaner that way.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Skip the have_policy check altogether
- Updated subject and log

 arch/arm64/kernel/topology.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f6faa697e83e..ebadc73449f9 100644
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
 
@@ -245,17 +242,12 @@ static int __init init_amu_fie(void)
 			continue;
 
 		cpumask_set_cpu(cpu, valid_cpus);
-		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
+		enable_policy_freq_counters(cpu, valid_cpus);
 	}
 
-	/*
-	 * If we are not restricted by cpufreq policies, we only enable
-	 * the use of the AMU feature for FIE if all CPUs support AMU.
-	 * Otherwise, enable_policy_freq_counters has already enabled
-	 * policy cpus.
-	 */
-	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))
-		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
+	/* Overwrite amu_fie_cpus if all CPUs support AMU */
+	if (cpumask_equal(valid_cpus, cpu_present_mask))
+		cpumask_copy(amu_fie_cpus, cpu_present_mask);
 
 	if (!cpumask_empty(amu_fie_cpus)) {
 		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-- 
2.25.0.rc1.19.g042ed3e048af

