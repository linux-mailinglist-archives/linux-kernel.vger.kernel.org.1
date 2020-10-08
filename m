Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3238C287263
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgJHKTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729428AbgJHKTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63E3C7345297BDC8FA46;
        Thu,  8 Oct 2020 18:19:10 +0800 (CST)
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
Subject: [PATCH RFC v4 06/13] perf vendor events arm64: Add hip09 SMMUv3 PMCG events
Date:   Thu, 8 Oct 2020 18:15:14 +0800
Message-ID: <1602152121-240367-7-git-send-email-john.garry@huawei.com>
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

Add the SMMUv3 PMCG (Performance Monitor Event Group) events for hip09
platform.

This contains a mix of architected and IMP def events

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../hisilicon/hip09/sys/smmu-v3-pmcg.json     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
new file mode 100644
index 000000000000..8abafbb2dcb4
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
+	    "BriefDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "PublicDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "Unit": "smmuv3_pmcg",
+	    "Compat": "0x00030736"
+   },
+]
-- 
2.26.2

