Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106242A9651
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKFMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7606 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgKFMkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:13 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC1w02zLvLb;
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
Subject: [PATCH RFC v5 06/13] perf vendor events arm64: Add hip09 SMMUv3 PMCG events
Date:   Fri, 6 Nov 2020 20:35:46 +0800
Message-ID: <1604666153-4187-7-git-send-email-john.garry@huawei.com>
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

Add the SMMUv3 PMCG (Performance Monitor Event Group) events for hip09
platform.

This contains a mix of architected and IMP def events, but for now only a
single event is added.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../hisilicon/hip09/sys/smmu-v3-pmcg.json     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
new file mode 100644
index 000000000000..9f4c35a0b499
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
@@ -0,0 +1,42 @@
+[
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CYCLES"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANSACTION"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TLB_MISS"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_CACHE_MISS"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED"
+	    "Compat": "0x00030736"
+   },
+   {
+	    "EventCode": "0x8a",
+	    "EventName": "smmuv3_pmcg.L1_TLB",
+	    "BriefDescription": "SMMUv3 PMCG command received by L1 TLB",
+	    "PublicDescription": "SMMUv3 PMCG command received by L1 TLB",
+	    "Unit": "smmuv3_pmcg",
+	    "Compat": "0x00030736"
+   },
+]
-- 
2.26.2

