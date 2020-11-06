Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D62A9647
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKFMkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7607 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgKFMkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:13 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC2q0czLvKT;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:39:59 +0800
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
Subject: [PATCH RFC v5 07/13] perf vendor events arm64: Add hip09 uncore events
Date:   Fri, 6 Nov 2020 20:35:47 +0800
Message-ID: <1604666153-4187-8-git-send-email-john.garry@huawei.com>
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

Add uncore events for DDRC, HHA, and L3C. We use "Compat" property to
match to specific implementations of the PMUs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../hisilicon/hip09/sys/uncore-ddrc.json      |  58 ++++++++++
 .../arm64/hisilicon/hip09/sys/uncore-hha.json |  82 ++++++++++++++
 .../arm64/hisilicon/hip09/sys/uncore-l3c.json | 106 ++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json
new file mode 100644
index 000000000000..a91c97813ae0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json
@@ -0,0 +1,58 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_ddrc.cycles",
+	    "BriefDescription": "DDRC total clock cycles",
+	    "PublicDescription": "DDRC total clock cycles",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_ddrc.act_cmd",
+	    "BriefDescription": "DDRC active commands",
+	    "PublicDescription": "DDRC active commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_ddrc.rw_cmd",
+	    "BriefDescription": "DDRC read and write commands",
+	    "PublicDescription": "DDRC read and write commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   }
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_ddrc.refresh_cmd",
+	    "BriefDescription": "DDRC total refresh commands",
+	    "PublicDescription": "DDRC total refresh commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x05",
+	    "EventName": "uncore_hisi_ddrc.preall_cmd",
+	    "BriefDescription": "DDRC precharge-all commands",
+	    "PublicDescription": "DDRC precharge-all commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x41",
+	    "EventName": "uncore_hisi_ddrc.read_cmd",
+	    "BriefDescription": "DDRC read commands",
+	    "PublicDescription": "DDRC read commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x44",
+	    "EventName": "uncore_hisi_ddrc.write_cmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc"
+	    "Compat": "0x00000030"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json
new file mode 100644
index 000000000000..5a39f1083ee6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json
@@ -0,0 +1,82 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_hha.rx_ops_num",
+	    "BriefDescription": "The number of all operations received by the HHA",
+	    "PublicDescription": "The number of all operations received by the HHA",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_hha.rx_outer",
+	    "BriefDescription": "The number of all operations received by the HHA from another socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another socket",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_hha.rx_sccl",
+	    "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_hha.rx_ccix",
+	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x1c",
+	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x1d",
+	    "EventName": "uncore_hisi_hha.wr_ddr_64b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x1e",
+	    "EventName": "uncore_hisi_hha.rd_ddr_128b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x1f",
+	    "EventName": "uncore_hisi_hha.wr_ddr_128b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_hha.spill_num",
+	    "BriefDescription": "Count of the number of spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_hha.spill_success",
+	    "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
+	    "Unit": "hisi_sccl,hha"
+	    "Compat": "0x00000030"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json
new file mode 100644
index 000000000000..3ae7948982ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json
@@ -0,0 +1,106 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_l3c.rd_cpipe",
+	    "BriefDescription": "Total read accesses",
+	    "PublicDescription": "Total read accesses",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_l3c.wr_cpipe",
+	    "BriefDescription": "Total write accesses",
+	    "PublicDescription": "Total write accesses",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
+	    "BriefDescription": "Total read hits",
+	    "PublicDescription": "Total read hits",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_l3c.wr_hit_cpipe",
+	    "BriefDescription": "Total write hits",
+	    "PublicDescription": "Total write hits",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_l3c.victim_num",
+	    "BriefDescription": "l3c precharge commands",
+	    "PublicDescription": "l3c precharge commands",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x20",
+	    "EventName": "uncore_hisi_l3c.rd_spipe",
+	    "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x21",
+	    "EventName": "uncore_hisi_l3c.wr_spipe",
+	    "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x22",
+	    "EventName": "uncore_hisi_l3c.rd_hit_spipe",
+	    "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x23",
+	    "EventName": "uncore_hisi_l3c.wr_hit_spipe",
+	    "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x29",
+	    "EventName": "uncore_hisi_l3c.back_invalid",
+	    "BriefDescription": "Count of the number of L3C back invalid operations",
+	    "PublicDescription": "Count of the number of L3C back invalid operations",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x40",
+	    "EventName": "uncore_hisi_l3c.retry_cpu",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x41",
+	    "EventName": "uncore_hisi_l3c.retry_ring",
+	    "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   },
+   {
+	    "EventCode": "0x42",
+	    "EventName": "uncore_hisi_l3c.prefetch_drop",
+	    "BriefDescription": "Count of the number of prefetch drops from this L3C",
+	    "PublicDescription": "Count of the number of prefetch drops from this L3C",
+	    "Unit": "hisi_sccl,l3c"
+	    "Compat": "0x00000030"
+   }
+]
-- 
2.26.2

