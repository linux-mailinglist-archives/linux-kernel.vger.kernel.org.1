Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634662A9648
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKFMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7608 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKFMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC2BkSzLvLf;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:39:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <linux-imx@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v5 05/13] perf vendor events arm64: Add Architected events smmuv3-pmcg.json
Date:   Fri, 6 Nov 2020 20:35:45 +0800
Message-ID: <1604666153-4187-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON for Architected events from [0], Section 10.3 .

[0] https://static.docs.arm.com/ihi0070/a/IHI_0070A_SMMUv3.pdf

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../pmu-events/arch/arm64/smmuv3-pmcg.json    | 58 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  2 +
 2 files changed, 60 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
new file mode 100644
index 000000000000..8a59ce48bf06
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
@@ -0,0 +1,58 @@
+[
+    {
+        "PublicDescription": "Clock cycles",
+        "EventCode": "0x00",
+        "EventName": "smmuv3_pmcg.CYCLES",
+        "BriefDescription": "Clock cycles"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Transaction",
+        "EventCode": "0x01",
+        "EventName": "smmuv3_pmcg.TRANSACTION",
+        "BriefDescription": "Transaction"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "TLB miss caused by incoming transaction or (ATS or non-ATS) translation request",
+        "EventCode": "0x02",
+        "EventName": "smmuv3_pmcg.TLB_MISS",
+        "BriefDescription": "TLB miss caused by incoming transaction or (ATS or non-ATS) translation request"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request",
+        "EventCode": "0x03",
+        "EventName": "smmuv3_pmcg.CONFIG_CACHE_MISS",
+        "BriefDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Translation table walk access",
+        "EventCode": "0x04",
+        "EventName": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS",
+        "BriefDescription": "Translation table walk access"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "Configuration structure access",
+        "EventCode": "0x05",
+        "EventName": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS",
+        "BriefDescription": "Configuration structure access"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "PCIe ATS Translation Request received",
+        "EventCode": "0x06",
+        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ",
+        "BriefDescription": "PCIe ATS Translation Request received"
+        "Unit": "smmuv3_pmcg",
+    },
+    {
+        "PublicDescription": "PCIe ATS Translated Transaction passed through SMMU",
+        "EventCode": "0x07",
+        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED",
+        "BriefDescription": "PCIe ATS Translated Transaction passed through SMMU"
+        "Unit": "smmuv3_pmcg",
+    }
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 7a65fd2d25bb..46e5253b0862 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -281,6 +281,8 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	/* it's not realistic to keep adding these, we need something more scalable ... */
+	{ "smmuv3_pmcg", "smmuv3_pmcg" },
 	{ "L3PMC", "amd_l3" },
 	{ "DFPMC", "amd_df" },
 	{}
-- 
2.26.2

