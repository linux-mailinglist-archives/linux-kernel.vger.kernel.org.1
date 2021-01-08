Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70F2EF129
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhAHLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbhAHLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:17:44 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FF4C0612F6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:17:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j1so5507659pld.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCcDgh0i+zZIwuGlOkZqwb7cDfW6szxmER5g+Fox0OI=;
        b=jQtweiu0EQCwa0n5N0MACj6E5NeMoogNmlyAu8mr4PeTcuFEzgGnHmLImfS/GtjYTG
         FpOrFJ2Dl+r78QU2DSfjYnFG8cuAUtLiGlqjZ6FUCCOsSSrPhJD1dI1uFw93vcrPRaU7
         PjTdx8Iqu2Kolp+hnogqb/dVm58fIwSNB+7ps/29ZhPYOg+AUF1H1RAo01qgnDLOUcWq
         W8YZIFyOwpBFCXHdTop6lUCmVfzy/Y+4Td/ouCoQQzqvM84aXXMfFSOwt+uDqCDmAWrT
         HLoPLV4h58tZZw0YeIm1EZ2FrYlb3X+CQt9cBjvZMpBHd4ohsgPvYMALxpiqz4TqWCvS
         K0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCcDgh0i+zZIwuGlOkZqwb7cDfW6szxmER5g+Fox0OI=;
        b=emESAhEllMSA1Syr2LX4CMJZsUe+wo2rawvRTb1KPvcfyqznMhXB+4bcSmWJeNX/oY
         F1Hskt7audTLyCHBCGvXi8Nz66MNPldlhY0is9fEW+ccZSR09dKuKBpb/rXEBslQM/oS
         G91LP46S+12UqV5Eq/6oEKq9ILAzYR0b0q/e3YzAYpjDJNaE9brEL0uRjXKftGh1NZ5c
         6SRMP2wo56CcSq7jEOyGcABixAN8/rW66JDGmdlXu+kd1wicMQFsiDnoELlUhyOaYQsf
         ZZNKS6UP8zOxaGkUjtJ/OhDT/lLcDyXQxcoowl7X1Tba/gmLNiiB0ZlKrVqi5HAsACws
         0nBg==
X-Gm-Message-State: AOAM531XXE/KySoZGcoG9GN88GAW8WZEcTY+mEIwB6/DUvHKBeKd488P
        KFAn/PyLnMjec858oOfeCYFbAQ==
X-Google-Smtp-Source: ABdhPJws2pZSQnc5mQxgob96ELDVgdGdbSDdBRBZPtFpc9ANSIcXIXOQymUYsfknlPJ/K7etNjbc1Q==
X-Received: by 2002:a17:902:aa07:b029:dc:240a:8a71 with SMTP id be7-20020a170902aa07b02900dc240a8a71mr3316203plb.32.1610104623938;
        Fri, 08 Jan 2021 03:17:03 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id t1sm4791974pju.43.2021.01.08.03.17.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:17:03 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] arm64: topology: Reorder init_amu_fie() a bit
Date:   Fri,  8 Jan 2021 16:46:52 +0530
Message-Id: <a732e71ab9ec28c354eb28dd898c9b47d490863f.1610104461.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does a couple of optimizations in init_amu_fie(), like early
exits from paths where we don't need to continue any further, avoid the
enable/disable dance, moving the calls to
topology_scale_freq_invariant() just when we need them, instead of at
the top of the routine, and avoiding calling it for the third time.

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index ebadc73449f9..57267d694495 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -221,8 +221,8 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
-	bool invariance_status = topology_scale_freq_invariant();
 	cpumask_var_t valid_cpus;
+	bool invariant;
 	int ret = 0;
 	int cpu;
 
@@ -249,18 +249,19 @@ static int __init init_amu_fie(void)
 	if (cpumask_equal(valid_cpus, cpu_present_mask))
 		cpumask_copy(amu_fie_cpus, cpu_present_mask);
 
-	if (!cpumask_empty(amu_fie_cpus)) {
-		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-			cpumask_pr_args(amu_fie_cpus));
-		static_branch_enable(&amu_fie_key);
-	}
+	if (cpumask_empty(amu_fie_cpus))
+		goto free_valid_mask;
 
-	/*
-	 * If the system is not fully invariant after AMU init, disable
-	 * partial use of counters for frequency invariance.
-	 */
-	if (!topology_scale_freq_invariant())
-		static_branch_disable(&amu_fie_key);
+	invariant = topology_scale_freq_invariant();
+
+	/* We aren't fully invariant yet */
+	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
+		goto free_valid_mask;
+
+	static_branch_enable(&amu_fie_key);
+
+	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
+		cpumask_pr_args(amu_fie_cpus));
 
 	/*
 	 * Task scheduler behavior depends on frequency invariance support,
@@ -268,7 +269,7 @@ static int __init init_amu_fie(void)
 	 * a result of counter initialisation and use, retrigger the build of
 	 * scheduling domains to ensure the information is propagated properly.
 	 */
-	if (invariance_status != topology_scale_freq_invariant())
+	if (!invariant)
 		rebuild_sched_domains_energy();
 
 free_valid_mask:
-- 
2.25.0.rc1.19.g042ed3e048af

