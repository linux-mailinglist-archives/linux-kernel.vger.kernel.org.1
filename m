Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E632DA7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLOFfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgLOFfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:35:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A2C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id q4so4645720plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcFcGYpvBy6tnBdPjWwdyiQjWcBUe6C5DCH1A2Cba4E=;
        b=NBE0rtLi/ltbqXo56JM6EWTuLmeSbxa4lmf8EspxvTDjPj9NIzdDjd+2I9OJJRKdFU
         svttQRs/nH84xvWccKeKVAqpzF1G96MyoH6HQ7/Oj8md2llvsIMI+wYDMPPGcgL3QuAF
         wu9RtWN6ghHA2IBIostWyvOPTzmlF04OaAodzYhbwpDexfk/Hw6ve9z+UiXdUDm5Ope9
         cDGP4kwpDWniu1GY9hf4QXVHTw81K68TgUr/rKuf1g4ThCsnipeS6AsIHhqCJhUjh6BA
         uv1lp591T8OIPxvlyGhRTMwZHG0zS/KREq5S/IQxXN78UsdU3YvNaOrEEL8XwAYzLwzJ
         Wj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wcFcGYpvBy6tnBdPjWwdyiQjWcBUe6C5DCH1A2Cba4E=;
        b=SzodGYXyHKNOPaf4GN0acxYkjw4oyS6IwChWQe7AgabmbQ4muYzGjhgSNjXiZXBUtN
         VZAaH5PHqVK+J8+zNmS1XwUwSkxdf+2pOJdGGooE5JmmMUx/sB+l2weIc3kGOpRG+82q
         eaQEKTAIdHbChmxCDPP0siKC+wv7Sijhyx7e+aXrFQrZ30GJmM0WahFK/RrkjsujJazg
         P1bD9gQiGTnGm857f8uavi8Hot6WXReLbZPaaiM6IKrrgrUnjU1q2cZc9+RZT8rRruFL
         VnLS+NN8H695cS8dTqptDrifQMwSzhTJwsO1ZOeA6sl/gw+tPx8GTKmBT0zbE0kAqaZw
         on0Q==
X-Gm-Message-State: AOAM530EY9I6aDecwWGrlO583Scz7vvAQDrUd/J8OpPk6fHWaG0iV/xg
        FoaYBVSLRS/gPHzaj1WKTIENqQ==
X-Google-Smtp-Source: ABdhPJx4r4T2MdTwUyAXuYYXxheqGSt/gbNyj9qbwtRertqW0XA/0EJb0C5m9Kg6dsXyVn7SiLAbwA==
X-Received: by 2002:a17:902:b90b:b029:da:97e2:722d with SMTP id bf11-20020a170902b90bb02900da97e2722dmr16686967plb.3.1608010465421;
        Mon, 14 Dec 2020 21:34:25 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id d6sm21177494pfo.199.2020.12.14.21.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 21:34:24 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] arm64: topology: Avoid the have_policy check
Date:   Tue, 15 Dec 2020 11:04:14 +0530
Message-Id: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
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

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3:
- Added Reviewed by tag.

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

