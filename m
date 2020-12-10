Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082932D5776
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgLJJnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgLJJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:43:13 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA31C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:42:33 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so3724242pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtvCgTzFUBGsUNcdgDa+auavrqoDFdovqrXwRiSLhnU=;
        b=vaHlq5UdrrasmXTd3NvOcRuwNbBv0DnOdxbmGIdC+wLZi8tO0J5I9/N/Lv2O3KlLbr
         fZLm2Fhgk+zlNgVGODtqPpkXMCafl3lH+7OSCksw1AES1b+eSHz/QUmNzMw7VuC2vWzt
         /NCNQAinWk6zDcCEq43ivF4+zi3X+Pw4HQifZLHDalH9OMIVrNpJ2154/92FH3Kf2L6S
         Jp8k3kz7UwQThJuKqkUhYWcPV3Te5g+kRULU+8BZ7py4RKvu8OvxPu3kMLZoblmcAsVv
         EygWLTHQJX3OGOpJLgzUGvsOMt0Shozf5wG4jGPVnhdfmbwPQ+DSDmDsuEkDJKuIwdNN
         hRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtvCgTzFUBGsUNcdgDa+auavrqoDFdovqrXwRiSLhnU=;
        b=rkn2ZtVcXi/qEdDu6mnd3kb+QFjXSMDXoC6pcQSXVhVbe1Z9EnFUJxRf7vyxlQszO2
         beiCHAGGw+yYhZszDMkqrk7sefsu3u0SATK701O/ARz4s6kCZB5b4teCgtKrv6cSUa0J
         y4heMGz/xFMK+F3R8taM+uN66rAtbpfIGarkQifWVH2GhBmirM1fDPC1l/6zRvziyDqQ
         4afTK9L70F2ruGrak3tgy2zjg8+PLvJfyBN2gDgE+a34tVm4N2kqfBfLzQKIyrGWz5IX
         OjValCZFqxTUUZ+OKrcZ/hj1mIKHK9gUW+qtpGTT+Gm5+QA0lScMIlgMcHWeAsqXdeRB
         fPlg==
X-Gm-Message-State: AOAM531PakqxDBTJRzr9I2/4q3YEplfub4sx894EXYA2Q3H3eZ6pKQ3m
        Wg2QuoixcEN2QfD5k1WMeKqA2g==
X-Google-Smtp-Source: ABdhPJxySeJx+xlUvznUbnXJtKJhcnebaCZyKDqohqeG56RLoCVg2RV3j/zrZt4B9kNETyckzxht8A==
X-Received: by 2002:a63:943:: with SMTP id 64mr5999750pgj.80.1607593352804;
        Thu, 10 Dec 2020 01:42:32 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id a23sm5521642pju.31.2020.12.10.01.42.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 01:42:32 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: topology: Avoid the static_branch_{enable|disable} dance
Date:   Thu, 10 Dec 2020 15:12:25 +0530
Message-Id: <10396de8046ada347d681eb84ea4dc6ec27e1742.1607593250.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the static_branch_enable() and static_branch_disable() dance by
redoing the code in a different way. We will be fully invariant here
only if amu_fie_cpus is set with all present CPUs, use that instead of
yet another call to topology_scale_freq_invariant().

This also avoids running rest of the routine if we enabled the static
branch, followed by a disable.

Also make the first call to topology_scale_freq_invariant() just when we
need it, instead of at the top of the routine. This makes it further
clear on why we need it, i.e. just around enabling AMUs use here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 7f7d8de325b6..6dedc6ee91cf 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -221,7 +221,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
-	bool invariance_status = topology_scale_freq_invariant();
+	bool invariance_status;
 	cpumask_var_t valid_cpus;
 	int ret = 0;
 	int cpu;
@@ -255,18 +255,15 @@ static int __init init_amu_fie(void)
 	    cpumask_equal(valid_cpus, cpu_present_mask))
 		cpumask_copy(amu_fie_cpus, cpu_present_mask);
 
-	if (!cpumask_empty(amu_fie_cpus)) {
-		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
-			cpumask_pr_args(amu_fie_cpus));
-		static_branch_enable(&amu_fie_key);
-	}
+	/* Disallow partial use of counters for frequency invariance */
+	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
+		goto free_valid_mask;
 
-	/*
-	 * If the system is not fully invariant after AMU init, disable
-	 * partial use of counters for frequency invariance.
-	 */
-	if (!topology_scale_freq_invariant())
-		static_branch_disable(&amu_fie_key);
+	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
+		cpumask_pr_args(amu_fie_cpus));
+
+	invariance_status = topology_scale_freq_invariant();
+	static_branch_enable(&amu_fie_key);
 
 	/*
 	 * Task scheduler behavior depends on frequency invariance support,
-- 
2.25.0.rc1.19.g042ed3e048af

