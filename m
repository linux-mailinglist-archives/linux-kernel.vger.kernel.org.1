Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2783A2D61E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392349AbgLJQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbgLJQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:30:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8236EC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:29:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id c12so4196095pgm.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gv4YPjz2g4HSduKeRhW9TiUO1Jvr8v2DzdEJIoyTN5Y=;
        b=gSeFsdVVpQp+bz1eXdJhj5qFWrMbHhW2RW2z/sNL0f2/SbSoRHT4T2RyMc0eCWqDej
         08ve8H0J/geDYo2CHvOn70cv3ixK2rJvcZQSAGelyDGRKQEuYjGxFwDPYowrXkHRJGAY
         3C1zyUuw4kgnFdI9jdCZ+Cv8YBdk10w8ovoM8rB+QLKCqSnFYzpz9vt6OREe5zIlhMsq
         ThetTsU/o7JVh6O7G3gE0SPbfec7+JhlnWT9ly7rDPKxZnzKOV5uP78d8dgWRu+DEwAE
         hvJnP+m9YWQzOeEbZpVDCrDs5BwpDCONyGBwC8WVsb+0b9wji50d5/esIzfIlCIbX2Q/
         FXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gv4YPjz2g4HSduKeRhW9TiUO1Jvr8v2DzdEJIoyTN5Y=;
        b=OzulEOf564xH1AQA1Qn96Ox235nlegr7cXTKrABVquNLsgpaM17wE61cE+Bgf+Sp0I
         C/JwBh+tpFd8qUMiCHbUzXoi/74EJDdCET+QbLaMaraKEynBBnTCW5/wSGxzGjV45Oc1
         8lTkid+gjS/hxHe5qMVNRnkPD6QFFg+WVBFD8AOHLRA09mQwrqEdORU84QDR6bpsb9gn
         XAiGHOIU+7FI1QyickRMKQp2olqT4nJEuwL7l6xaWhQcxagAEAmeCKvy5JUMlWZ9Nk8H
         waqFd6qq3+U8ZkFmYKEc1KJBatD+I++UqCBGH8eX+EyhbR77AUC0D7DS2GAFg/MSKVjA
         Gv7g==
X-Gm-Message-State: AOAM533753Y5pZXEoOD6eiF+k5D4t2G9XP6u3iwnmc31liu+mUxMheTS
        BOg22UdU9P4FInJBWSUMJdKlU+bGou/THQ==
X-Google-Smtp-Source: ABdhPJxSqm5Mc0cj/FdswgJ2J75MSczz7gOD2cn9HTmBKGRMclhzv/c3n0IlwqI6qLR8Vs5PawbL4A==
X-Received: by 2002:a63:a62:: with SMTP id z34mr7397468pgk.193.1607617777096;
        Thu, 10 Dec 2020 08:29:37 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id s13sm7181323pfd.99.2020.12.10.08.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 08:29:35 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] arm64: topology: Reorder init_amu_fie() a bit
Date:   Thu, 10 Dec 2020 21:59:23 +0530
Message-Id: <202f775d57bd143602f9100ba3d9619d15d43409.1607617625.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
References: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does a couple of optimizations in init_amu_fie(), like early
exits from paths where we don't need to continue any further, moving the
calls to topology_scale_freq_invariant() just when we need
them, instead of at the top of the routine, and avoiding calling it for
the third time.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- The enable/disable dance is actually required, just made a bunch of
  other optimizations to make it look better.

 arch/arm64/kernel/topology.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index ebadc73449f9..1ebdb667f0d1 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -221,7 +221,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
-	bool invariance_status = topology_scale_freq_invariant();
+	bool prev, now;
 	cpumask_var_t valid_cpus;
 	int ret = 0;
 	int cpu;
@@ -249,18 +249,24 @@ static int __init init_amu_fie(void)
 	if (cpumask_equal(valid_cpus, cpu_present_mask))
 		cpumask_copy(amu_fie_cpus, cpu_present_mask);
 
-	if (!cpumask_empty(amu_fie_cpus)) {
-		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-			cpumask_pr_args(amu_fie_cpus));
-		static_branch_enable(&amu_fie_key);
-	}
+	if (cpumask_empty(amu_fie_cpus))
+		goto free_valid_mask;
+
+	prev = topology_scale_freq_invariant();
+	static_branch_enable(&amu_fie_key);
+	now = topology_scale_freq_invariant();
 
 	/*
 	 * If the system is not fully invariant after AMU init, disable
 	 * partial use of counters for frequency invariance.
 	 */
-	if (!topology_scale_freq_invariant())
+	if (!now) {
 		static_branch_disable(&amu_fie_key);
+		goto free_valid_mask;
+	}
+
+	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
+		cpumask_pr_args(amu_fie_cpus));
 
 	/*
 	 * Task scheduler behavior depends on frequency invariance support,
@@ -268,7 +274,7 @@ static int __init init_amu_fie(void)
 	 * a result of counter initialisation and use, retrigger the build of
 	 * scheduling domains to ensure the information is propagated properly.
 	 */
-	if (invariance_status != topology_scale_freq_invariant())
+	if (prev != now)
 		rebuild_sched_domains_energy();
 
 free_valid_mask:
-- 
2.25.0.rc1.19.g042ed3e048af

