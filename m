Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C6287264
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgJHKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:19:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729453AbgJHKTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:19:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B638BFDF8286598EC7F;
        Thu,  8 Oct 2020 18:19:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 18:19:02 +0800
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
Subject: [PATCH RFC v4 13/13] perf vendor events: Add JSON metrics for imx8mm DDR Perf
Date:   Thu, 8 Oct 2020 18:15:21 +0800
Message-ID: <1602152121-240367-14-git-send-email-john.garry@huawei.com>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Add JSON metrics for imx8mm DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/freescale/imx8mm/sys/ddrc.json | 39 +++++++++++++++++++
 .../arm64/freescale/imx8mm/sys/metrics.json   | 18 +++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 3 files changed, 58 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
new file mode 100644
index 000000000000..3404a880542d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
@@ -0,0 +1,39 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MM"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MM"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MM"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MM"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MM"
+   }
+]
+
+
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
new file mode 100644
index 000000000000..ec00212336de
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mm_ddr_read.all",
+	    "MetricExpr": "imx8_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MM"
+    },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mm_ddr_write.all",
+	    "MetricExpr": "imx8_ddr.write_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MM"
+    }
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 2e581bd9b0a6..b4bd48b076fd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -257,6 +257,7 @@ static struct map {
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
 	/* it's not realistic to keep adding these, we need something more scalable ... */
+	{ "imx8_ddr", "imx8_ddr" },
 	{ "smmuv3_pmcg", "smmuv3_pmcg" },
 	{ "L3PMC", "amd_l3" },
 	{}
-- 
2.26.2

