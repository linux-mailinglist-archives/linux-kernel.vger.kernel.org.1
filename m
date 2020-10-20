Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700B287261
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgJHKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbgJHKTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4430A986425331A543F3;
        Thu,  8 Oct 2020 18:19:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:18:59 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <james.clark@arm.com>,
        <linux-imx@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v4 05/13] perf vendor events arm64: Add Architected events smmuv3-pmcg.json
Date:   Thu, 8 Oct 2020 18:15:13 +0800
Message-ID: <1602152121-240367-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
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
index a1a4bc543a80..2e581bd9b0a6 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -256,6 +256,8 @@ static struct map {
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
+	/* it's not realistic to keep adding these, we need something more scalable ... */
+	{ "smmuv3_pmcg", "smmuv3_pmcg" },
 	{ "L3PMC", "amd_l3" },
 	{}
 };
-- 
2.26.2

