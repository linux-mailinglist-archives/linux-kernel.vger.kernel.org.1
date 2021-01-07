Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6E2ED00E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbhAGMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:41:44 -0500
Received: from foss.arm.com ([217.140.110.172]:59984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbhAGMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:41:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3062C152F;
        Thu,  7 Jan 2021 04:39:44 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFC453F719;
        Thu,  7 Jan 2021 04:39:42 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        liuqi115@huawei.com
Subject: [PATCH v6 22/26] coresight: etm4x: Run arch feature detection on the CPU
Date:   Thu,  7 Jan 2021 12:38:55 +0000
Message-Id: <20210107123859.674252-23-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210107123859.674252-1-suzuki.poulose@arm.com>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to add support for system register based devices,
we don't get an AMBA pid. So, the detection code could check
the system registers running on the CPU to check for the architecture
specific features. Thus we move the arch feature detection to
run on the CPU. We cannot always read the PID from the HW (i.e even
for AMBA devices), as the as the PID could be overridden by DT for
broken devices. So, use the PID from AMBA layer if available.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: liuqi115@huawei.com
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 228845f6fdd8..f4fbb65b4cc1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -60,6 +60,7 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
 static enum cpuhp_state hp_online;
 
 struct etm4_init_arg {
+	unsigned int		pid;
 	struct etmv4_drvdata	*drvdata;
 	struct csdev_access	*csa;
 };
@@ -884,6 +885,8 @@ static void etm4_init_arch_data(void *info)
 	etm4_os_unlock_csa(drvdata, csa);
 	etm4_cs_unlock(drvdata, csa);
 
+	etm4_check_arch_features(drvdata, init_arg->pid);
+
 	/* find all capabilities of the tracing unit */
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
@@ -1750,6 +1753,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 
 	init_arg.drvdata = drvdata;
 	init_arg.csa = &desc.access;
+	init_arg.pid = etm_pid;
 
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  &init_arg, 1))
@@ -1794,8 +1798,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 		drvdata->boot_enable = true;
 	}
 
-	etm4_check_arch_features(drvdata, etm_pid);
-
 	return 0;
 }
 
-- 
2.24.1

