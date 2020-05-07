Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7A1C89F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEGMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 08:02:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbgEGMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:02:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C823112467B10D8A5B61;
        Thu,  7 May 2020 20:02:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 20:01:58 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v3 05/12] perf vendor events arm64: Add hip08 SMMUv3 PMCG events
Date:   Thu, 7 May 2020 19:57:44 +0800
Message-ID: <1588852671-61996-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SMMUv3 PMCG (Performance Monitor Event Group) events for hip08
platform.

This contains a mix of architected and IMP def events

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json    | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
new file mode 100644
index 000000000000..f2a1cb0332a6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
@@ -0,0 +1,42 @@
+[
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CYCLES"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANSACTION"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TLB_MISS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_CACHE_MISS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ"
+	    "Compat": "hip08"
+   },
+   {
+	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED"
+	    "Compat": "hip08"
+   },
+   {
+	    "EventCode": "0x8a",
+	    "EventName": "smmuv3_pmcg.L1_TLB",
+	    "BriefDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "PublicDescription": "SMMUv3 PMCG L1 TABLE transation",
+	    "Unit": "smmuv3_pmcg",
+	    "Compat": "hip08"
+   },
+]
-- 
2.16.4

