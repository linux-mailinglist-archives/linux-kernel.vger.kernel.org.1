Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98772DA7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgLOFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgLOFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:35:09 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E3C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:29 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g20so9527911plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 21:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgJQB0DZGeyzhCL0iUrGx8mWydeXs5tsx4bv2Z8klnQ=;
        b=MycjyOgezkR8Zbn91/11XWPtpVKZlNKSu0I3+WAXAIKiVYVnH+6n1Wcdz5BAXn6ovI
         GWYiThlTjt2dkewgfYxLm1gArJXGb+Il69Bx1brJZQVrJhisHmzo/EiYvDfgCmW6gHkT
         lc3ux9NZiDS91AInrbBzpNjj6DuiuCqCZgvOnn4xE90ZCZam/EckgdG5vqvbC79rdy+Y
         iYdTPRHF2w+Xd+yqZfHDmbzi1O0PmRlxvRJCjffM3df5S4rPyqklQzE25+Iy9nFlgDpT
         qHd7xfO8XKt09vGuYh4YeJE7lwnRkg7sq9PVl8nMXQe+af4vl0BR1lPOvCy0lrzrzHVN
         zW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgJQB0DZGeyzhCL0iUrGx8mWydeXs5tsx4bv2Z8klnQ=;
        b=QQ61jvy8qGWMSSVv4W2OVvjmx8M/er+KZlfETEGxieG1ifC1KvMAxzYXrqtVmpqrPi
         4MrO/nnNZ3ZaAtPJp9srHjqlpDyQdUk+dR2RF5Tmq0gO+9Znsig/wUvFXlxyZ6KoqQdQ
         59EqDNKVHTdbeoEMkpnRSbXysQzjmT9vpunv1Fno8WWF5vZMGTYFFPeFxc6tdQOFCI9a
         5SWFRp46o/gp1mjOjBdRdGeRiqJRkez7LyMUxXpHH83wYq+i9ApA2+e2EWYW3J1lu7ZV
         XrBGvf1s71+JqD7tlyxP92iDUt86n9Z/ePq/QOH9exinGvwSf2JlkShbQJ3gsp1A2XXI
         YE0g==
X-Gm-Message-State: AOAM532Dg259RZxQ4wh9zlGymvvAeEqHuoIm6rZ78quLT/cdVWpwBZeX
        goJWHLUCXi2lhOLhsmUmf5DW5Q==
X-Google-Smtp-Source: ABdhPJyn0xBCA0AwIHZzUhyyaq89Ym+SBCQknUnzclvYEEjNa/dnV3CD8q9Jf5M/SaBY26gjy7Ksig==
X-Received: by 2002:a17:90b:1886:: with SMTP id mn6mr28569544pjb.31.1608010468750;
        Mon, 14 Dec 2020 21:34:28 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id u12sm21037339pfn.88.2020.12.14.21.34.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 21:34:28 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] arm64: topology: Reorder init_amu_fie() a bit
Date:   Tue, 15 Dec 2020 11:04:15 +0530
Message-Id: <87d517c24630494afd9ba5769c2e2b10ee1d3f5d.1608010334.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3:
- Skipped the enable/disable dance.
- No need to call topology_scale_freq_invariant() multiple times.

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

