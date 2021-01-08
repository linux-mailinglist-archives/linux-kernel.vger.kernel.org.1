Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A52EF128
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbhAHLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbhAHLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:17:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09801C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:17:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m5so5965970pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nUNli654LtMfzP23uxOB/jn47gcZbp/cG1xs2NHv6k=;
        b=mNKEHbJlA6HRZVBSDNcDnB25syiwYDVv+zutOUNgGEzwmw25OpYs+JYD9XcNnhxOsm
         T02YJZ+7xtWfMLv+WicnpvPIssv9/SGPr9I77QkqRSzieEkp342eRkoHBv/Ro193j8Uz
         JojtJLAohak7pHxe6CItU8KS5CY3hLgQU1fd0fElqaVSTe7RaI+gg48gQV6dEgujDPre
         c/qeu3DmrEP73b2xBIG5Q50gnDE/e/W0Allh+irgKCBtm/8c/tdDjdO41pwt681dRiSd
         e1kGnQTbOJnj7pxulEWtDyFpOjEVXhUDr5IT+QktCKYf6nfrcJ5IS9DFdm6azGu+JxxH
         LOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nUNli654LtMfzP23uxOB/jn47gcZbp/cG1xs2NHv6k=;
        b=ddkny+sqsBdAu2Vm/wtDlBtDBfPQXVUguYv4iAFDBWTIAMm7KHykuTZGx61l/rujDO
         ExguGD3NtZODfzWBk1Kr40cX7V/qN9scJbnQdbfagLOQf6mg/Q//3RvgIWdtgln3IyEm
         W8xhrrGASh/q8J2iyIQiG0Da9MCHhZI/O749gC5VXUKr9Cqpi4fXnmgrzkwBmNIdBVz4
         RgRAg37aUNjMN5s1+xPA9eJY7D3rypQb9/XXFs7e42qJIIUz4MnIyqUZm9V8yAozGFq9
         uc2VdX6dr4JX1QJTpmOvTVJ0Qk90wpC8K/xlo3DsqIJKIA9koOTLYYTSYDKvAjqsXLFn
         grIg==
X-Gm-Message-State: AOAM532MemnuHa+ohE9mP/iU0/GHQGmdvTMjeGz/EGlT7PTIiRwXFzNA
        58U/7/tiK6wvlV1WY6TdKGpl9w==
X-Google-Smtp-Source: ABdhPJwA52onY6PEwKGeVt3wn3g0aGel8Nb0QidDMBVRFfrnnId1jGiQ9xvq4jyACWlBAvymi13kRQ==
X-Received: by 2002:a17:90b:1249:: with SMTP id gx9mr3263125pjb.146.1610104620576;
        Fri, 08 Jan 2021 03:17:00 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id g202sm8383292pfb.196.2021.01.08.03.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:16:59 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/3] arm64: topology: Avoid the have_policy check
Date:   Fri,  8 Jan 2021 16:46:51 +0530
Message-Id: <c125766c4be93461772015ac7c9a6ae45d5756f6.1610104461.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
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

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
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

