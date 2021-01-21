Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A682FE351
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbhAUHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbhAUG5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:57:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEEDE2396F;
        Thu, 21 Jan 2021 06:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212193;
        bh=wv9R3YbMmDZpuBvKea9U3IYMvPqDbPWPeoVQyx3W8hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrN50/yDb1bSJCqsMyNSj5/C8MYnLLAXf7wP3zFVk0M2n7xxTIQDcf7lSTVqes8BK
         VJcH9y4y9Vm9IRhi0hStF9107kpcD+KSMHDlSSKYBOoQrksxzVnKs37IrhjL1lOZch
         hPEOx+iXLrfY0Hpuz9xlx2yj76y1nxVCZtDj1d8e0QcPrmidYPc5FR1a7X3IyzO1TX
         cthOFYW298rpSJ/ltGJLouxp9V9lr0oUSnSy+GTXafX4x9eU3CH1WssAFJ+E65VYQn
         fUVk9nLp+aBLgAWrxaXl5BE6t5mA6Lvzb071TdaHW1Z43K6zWhTwNMS8fcP+C1Kyin
         hxWYkQ9l2toVA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/29] csky: Fixup perf probe failed
Date:   Thu, 21 Jan 2021 14:53:22 +0800
Message-Id: <20210121065349.3188251-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current perf init will failed with:
[    1.452433] csky-pmu: probe of soc:pmu failed with error -16

This patch fix it up with adding CPUHP_AP_PERF_CSKY_ONLINE in
cpuhotplug.h.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 arch/csky/kernel/perf_event.c | 2 +-
 include/linux/cpuhotplug.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 1a29f1157449..55d5a5379483 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1319,7 +1319,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 		pr_notice("[perf] PMU request irq fail!\n");
 	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_ONLINE, "AP_PERF_ONLINE",
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_CSKY_ONLINE, "AP_PERF_ONLINE",
 				csky_pmu_starting_cpu,
 				csky_pmu_dying_cpu);
 	if (ret) {
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0042ef362511..d3e26dc81494 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -185,6 +185,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_TRACE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
+	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.17.1

