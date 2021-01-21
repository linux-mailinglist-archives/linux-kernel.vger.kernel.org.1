Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBE2FE873
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbhAULL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:11:59 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:37151 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730101AbhAULJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:09:25 -0500
IronPort-SDR: vwfKbIQHfqUHZph3JnvRAD7nzXL9CSaemgU8bVmEhcr9qocY8dnS9ZFMLVDTTqvWyvuplM5FTD
 CvG2jWR+18S6eCJz5HzSk1C+bfTjjfhKscetkQ9tbkXaJpj+YGYKQcNoC4Dd3M9EyB/qK/cH7A
 yp/qqr+i6JByHFo7HZFKAxMqm3Dn8/ZBo1xDQeaQ2hKAa9UEMpm0msrr1sikUAgjQEvG7Fq7y6
 hK7u+SXH0ZRiVdyiSFQnhagzkS191PUzQaw3ilg5dE2KTyyDfrS1usb8KOvVku8QSQwmxPlSiO
 9qc=
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="15977626"
X-IronPort-AV: E=Sophos;i="5.79,363,1602514800"; 
   d="scan'208";a="15977626"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 21 Jan 2021 20:00:15 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F661EC7E7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 836E3E60B6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:12 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 5F82C774; Thu, 21 Jan 2021 19:54:25 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v2 3/3] perf vendor events: Add Fujitsu A64FX V1.2 pmu event
Date:   Thu, 21 Jan 2021 19:54:25 +0900
Message-Id: <20210121105425.2695843-4-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pmu events for A64FX.

Documentation source:
https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2.pdf

Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
---
 .../arch/arm64/fujitsu/a64fx/branch.json           |  14 ++
 .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 ++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 164 ++++++++++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   8 +
 .../arch/arm64/fujitsu/a64fx/execution.json        |  32 +++
 .../arch/arm64/fujitsu/a64fx/instruction.json      | 143 ++++++++++++++
 .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 ++++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json         | 200 +++++++++++++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 218 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 11 files changed, 1038 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/execution.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json

diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
new file mode 100644
index 0000000..00aa6b8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
@@ -0,0 +1,14 @@
+[
+  {
+    "PublicDescription": "This event counts each correction to the predicted program flow that occurs because of a misprediction from, or no prediction from, the branch prediction resources and that relates to instructions that the branch prediction resources are capable of predicting.",
+    "EventCode": "0x10",
+    "EventName": "BR_MIS_PRED",
+    "BriefDescription": "This event counts each correction to the predicted program flow that occurs because of a misprediction from, or no prediction from, the branch prediction resources and that relates to instructions that the branch prediction resources are capable of predicting."
+  },
+  {
+    "PublicDescription": "This event counts every branch or other change in the program flow that the branch prediction resources are capable of predicting.",
+    "EventCode": "0x12",
+    "EventName": "BR_PRED",
+    "BriefDescription": "This event counts every branch or other change in the program flow that the branch prediction resources are capable of predicting."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
new file mode 100644
index 0000000..084e88d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
@@ -0,0 +1,62 @@
+[
+  {
+    "PublicDescription": "This event counts read transactions from tofu controller to measured CMG.",
+    "EventCode": "0x314",
+    "EventName": "BUS_READ_TOTAL_TOFU",
+    "BriefDescription": "This event counts read transactions from tofu controller to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts read transactions from PCI controller to measured CMG.",
+    "EventCode": "0x315",
+    "EventName": "BUS_READ_TOTAL_PCI",
+    "BriefDescription": "This event counts read transactions from PCI controller to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts read transactions from measured CMG local memory to measured CMG.",
+    "EventCode": "0x316",
+    "EventName": "BUS_READ_TOTAL_MEM",
+    "BriefDescription": "This event counts read transactions from measured CMG local memory to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG0, if measured CMG is not CMG0.",
+    "EventCode": "0x318",
+    "EventName": "BUS_WRITE_TOTAL_CMG0",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG0, if measured CMG is not CMG0."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG1, if measured CMG is not CMG1.",
+    "EventCode": "0x319",
+    "EventName": "BUS_WRITE_TOTAL_CMG1",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG1, if measured CMG is not CMG1."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG2, if measured CMG is not CMG2.",
+    "EventCode": "0x31A",
+    "EventName": "BUS_WRITE_TOTAL_CMG2",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG2, if measured CMG is not CMG2."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG3, if measured CMG is not CMG3.",
+    "EventCode": "0x31B",
+    "EventName": "BUS_WRITE_TOTAL_CMG3",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG3, if measured CMG is not CMG3."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to tofu controller.",
+    "EventCode": "0x31C",
+    "EventName": "BUS_WRITE_TOTAL_TOFU",
+    "BriefDescription": "This event counts write transactions from measured CMG to tofu controller."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to PCI controller.",
+    "EventCode": "0x31D",
+    "EventName": "BUS_WRITE_TOTAL_PCI",
+    "BriefDescription": "This event counts write transactions from measured CMG to PCI controller."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to measured CMG local memory.",
+    "EventCode": "0x31E",
+    "EventName": "BUS_WRITE_TOTAL_MEM",
+    "BriefDescription": "This event counts write transactions from measured CMG to measured CMG local memory."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
new file mode 100644
index 0000000..984396f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
@@ -0,0 +1,164 @@
+[
+  {
+    "PublicDescription": "This event counts operations that cause a refill of the L1I cache.",
+    "EventCode": "0x1",
+    "EventName": "L1I_CACHE_REFILL",
+    "BriefDescription": "This event counts operations that cause a refill of the L1I cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB refill of the L1I TLB.",
+    "EventCode": "0x2",
+    "EventName": "L1I_TLB_REFILL",
+    "BriefDescription": "This event counts operations that cause a TLB refill of the L1I TLB."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a refill of the L1D cache.",
+    "EventCode": "0x3",
+    "EventName": "L1D_CACHE_REFILL",
+    "BriefDescription": "This event counts operations that cause a refill of the L1D cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a cache access to the L1D cache.",
+    "EventCode": "0x4",
+    "EventName": "L1D_CACHE",
+    "BriefDescription": "This event counts operations that cause a cache access to the L1D cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB refill of the L1D TLB.",
+    "EventCode": "0x5",
+    "EventName": "L1D_TLB_REFILL",
+    "BriefDescription": "This event counts operations that cause a TLB refill of the L1D TLB."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a cache access to the L1I cache.",
+    "EventCode": "0x14",
+    "EventName": "L1I_CACHE",
+    "BriefDescription": "This event counts operations that cause a cache access to the L1I cache."
+  },
+  {
+    "PublicDescription": "This event counts every write-back of data from the L1D cache.",
+    "EventCode": "0x15",
+    "EventName": "L1D_CACHE_WB",
+    "BriefDescription": "This event counts every write-back of data from the L1D cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a cache access to the L2 cache.",
+    "EventCode": "0x16",
+    "EventName": "L2D_CACHE",
+    "BriefDescription": "This event counts operations that cause a cache access to the L2 cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a refill of the L2 cache.",
+    "EventCode": "0x17",
+    "EventName": "L2D_CACHE_REFILL",
+    "BriefDescription": "This event counts operations that cause a refill of the L2 cache."
+  },
+  {
+    "PublicDescription": "This event counts every write-back of data from the L2 cache.",
+    "EventCode": "0x18",
+    "EventName": "L2D_CACHE_WB",
+    "BriefDescription": "This event counts every write-back of data from the L2 cache."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB refill of the L2D TLB.",
+    "EventCode": "0x2D",
+    "EventName": "L2D_TLB_REFILL",
+    "BriefDescription": "This event counts operations that cause a TLB refill of the L2D TLB."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB refill of the L2I TLB.",
+    "EventCode": "0x2E",
+    "EventName": "L2I_TLB_REFILL",
+    "BriefDescription": "This event counts operations that cause a TLB refill of the L2I TLB."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB access to the L2D TLB.",
+    "EventCode": "0x2F",
+    "EventName": "L2D_TLB",
+    "BriefDescription": "This event counts operations that cause a TLB access to the L2D TLB."
+  },
+  {
+    "PublicDescription": "This event counts operations that cause a TLB access to the L2I TLB.",
+    "EventCode": "0x30",
+    "EventName": "L2I_TLB",
+    "BriefDescription": "This event counts operations that cause a TLB access to the L2I TLB."
+  },
+  {
+    "ArchStdEvent": "L1D_CACHE_REFILL_PRF"
+  },
+  {
+    "ArchStdEvent": "L2D_CACHE_REFILL_PRF"
+  },
+  {
+    "PublicDescription": "This event counts L1D_CACHE_REFILL caused by demand access.",
+    "EventCode": "0x200",
+    "EventName": "L1D_CACHE_REFILL_DM",
+    "BriefDescription": "This event counts L1D_CACHE_REFILL caused by demand access."
+  },
+  {
+    "PublicDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch.",
+    "EventCode": "0x202",
+    "EventName": "L1D_CACHE_REFILL_HWPRF",
+    "BriefDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L1D cache miss requests per cycle.",
+    "EventCode": "0x208",
+    "EventName": "L1_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L1D cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L1I cache miss requests per cycle.",
+    "EventCode": "0x209",
+    "EventName": "L1I_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L1I cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts L2D_CACHE_REFILL caused by demand access.",
+    "EventCode": "0x300",
+    "EventName": "L2D_CACHE_REFILL_DM",
+    "BriefDescription": "This event counts L2D_CACHE_REFILL caused by demand access."
+  },
+  {
+    "PublicDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch.",
+    "EventCode": "0x302",
+    "EventName": "L2D_CACHE_REFILL_HWPRF",
+    "BriefDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L2 cache miss requests per cycle.",
+    "EventCode": "0x308",
+    "EventName": "L2_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L2 cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts the number of times of L2 cache miss.",
+    "EventCode": "0x309",
+    "EventName": "L2_MISS_COUNT",
+    "BriefDescription": "This event counts the number of times of L2 cache miss."
+  },
+  {
+    "PublicDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch.",
+    "EventCode": "0x325",
+    "EventName": "L2D_SWAP_DM",
+    "BriefDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access.",
+    "EventCode": "0x326",
+    "EventName": "L2D_CACHE_MIBMCH_PRF",
+    "BriefDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access."
+  },
+  {
+    "PublicDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch.",
+    "EventCode": "0x396",
+    "EventName": "L2D_CACHE_SWAP_LOCAL",
+    "BriefDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of L2 cache.",
+    "EventCode": "0x3E0",
+    "EventName": "EA_L2",
+    "BriefDescription": "This event counts energy consumption per cycle of L2 cache."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
new file mode 100644
index 0000000..93c8997
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
@@ -0,0 +1,8 @@
+[
+  {
+    "PublicDescription": "This event counts every cycle.",
+    "EventCode": "0x11",
+    "EventName": "CPU_CYCLES",
+    "BriefDescription": "This event counts every cycle."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/execution.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/execution.json
new file mode 100644
index 0000000..d42bfbd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/execution.json
@@ -0,0 +1,32 @@
+[
+  {
+    "PublicDescription": "This event counts each exception taken.",
+    "EventCode": "0x9",
+    "EventName": "EXC_TAKEN",
+    "BriefDescription": "This event counts each exception taken."
+  },
+  {
+    "ArchStdEvent": "EXC_UNDEF"
+  },
+  {
+    "ArchStdEvent": "EXC_SVC"
+  },
+  {
+    "ArchStdEvent": "EXC_PABORT"
+  },
+  {
+    "ArchStdEvent": "EXC_DABORT"
+  },
+  {
+    "ArchStdEvent": "EXC_IRQ"
+  },
+  {
+    "ArchStdEvent": "EXC_FIQ"
+  },
+  {
+    "ArchStdEvent": "EXC_SMC"
+  },
+  {
+    "ArchStdEvent": "EXC_HVC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
new file mode 100644
index 0000000..449099b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
@@ -0,0 +1,143 @@
+[
+  {
+    "PublicDescription": "This event counts on writes to the PMSWINC register.",
+    "EventCode": "0x0",
+    "EventName": "SW_INCR",
+    "BriefDescription": "This event counts on writes to the PMSWINC register."
+  },
+  {
+    "PublicDescription": "This event counts every architecturally executed instruction.",
+    "EventCode": "0x8",
+    "EventName": "INST_RETIRED",
+    "BriefDescription": "This event counts every architecturally executed instruction."
+  },
+  {
+    "PublicDescription": "This event counts each executed exception return instruction.",
+    "EventCode": "0xA",
+    "EventName": "EXC_RETURN",
+    "BriefDescription": "This event counts each executed exception return instruction."
+  },
+  {
+    "PublicDescription": "This event counts every write to CONTEXTIDR.",
+    "EventCode": "0xB",
+    "EventName": "CID_WRITE_RETIRED",
+    "BriefDescription": "This event counts every write to CONTEXTIDR."
+  },
+  {
+    "PublicDescription": "This event counts every architecturally executed instruction.",
+    "EventCode": "0x1B",
+    "EventName": "INST_SPEC",
+    "BriefDescription": "This event counts every architecturally executed instruction."
+  },
+  {
+    "ArchStdEvent": "LDREX_SPEC"
+  },
+  {
+    "ArchStdEvent": "STREX_SPEC"
+  },
+  {
+    "ArchStdEvent": "LD_SPEC"
+  },
+  {
+    "ArchStdEvent": "ST_SPEC"
+  },
+  {
+    "ArchStdEvent": "LDST_SPEC"
+  },
+  {
+    "ArchStdEvent": "DP_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SPEC"
+  },
+  {
+    "ArchStdEvent": "VFP_SPEC"
+  },
+  {
+    "ArchStdEvent": "PC_WRITE_SPEC"
+  },
+  {
+    "ArchStdEvent": "CRYPTO_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_IMMED_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_RETURN_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_INDIRECT_SPEC"
+  },
+  {
+    "ArchStdEvent": "ISB_SPEC"
+  },
+  {
+    "ArchStdEvent": "DSB_SPEC"
+  },
+  {
+    "ArchStdEvent": "DMB_SPEC"
+  },
+  {
+    "ArchStdEvent": "DCZVA_SPEC"
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed floating-point move operations.",
+    "EventCode": "0x105",
+    "EventName": "FP_MV_SPEC",
+    "BriefDescription": "This event counts architecturally executed floating-point move operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that using predicate register.",
+    "EventCode": "0x108",
+    "EventName": "PRD_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that using predicate register."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed inter-element manipulation operations.",
+    "EventCode": "0x109",
+    "EventName": "IEL_SPEC",
+    "BriefDescription": "This event counts architecturally executed inter-element manipulation operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed inter-register manipulation operations.",
+    "EventCode": "0x10A",
+    "EventName": "IREG_SPEC",
+    "BriefDescription": "This event counts architecturally executed inter-register manipulation operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed NOSIMD load operations that using SIMD&FP registers.",
+    "EventCode": "0x112",
+    "EventName": "FP_LD_SPEC",
+    "BriefDescription": "This event counts architecturally executed NOSIMD load operations that using SIMD&FP registers."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed NOSIMD store operations that using SIMD&FP registers.",
+    "EventCode": "0x113",
+    "EventName": "FP_ST_SPEC",
+    "BriefDescription": "This event counts architecturally executed NOSIMD store operations that using SIMD&FP registers."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SIMD broadcast floating-point load operations.",
+    "EventCode": "0x11A",
+    "EventName": "BC_LD_SPEC",
+    "BriefDescription": "This event counts architecturally executed SIMD broadcast floating-point load operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed instructions, excluding the MOVPRFX instruction.",
+    "EventCode": "0x121",
+    "EventName": "EFFECTIVE_INST_SPEC",
+    "BriefDescription": "This event counts architecturally executed instructions, excluding the MOVPRFX instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that uses 'pre-index' as its addressing mode.",
+    "EventCode": "0x123",
+    "EventName": "PRE_INDEX_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that uses 'pre-index' as its addressing mode."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that uses 'post-index' as its addressing mode.",
+    "EventCode": "0x124",
+    "EventName": "POST_INDEX_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that uses 'post-index' as its addressing mode."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
new file mode 100644
index 0000000..c1f6479
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
@@ -0,0 +1,8 @@
+[
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of CMG local memory.",
+    "EventCode": "0x3E8",
+    "EventName": "EA_MEMORY",
+    "BriefDescription": "This event counts energy consumption per cycle of CMG local memory."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
new file mode 100644
index 0000000..68b8e46
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
@@ -0,0 +1,188 @@
+[
+  {
+    "PublicDescription": "This event counts the occurrence count of the micro-operation split.",
+    "EventCode": "0x139",
+    "EventName": "UOP_SPLIT",
+    "BriefDescription": "This event counts the occurrence count of the micro-operation split."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no operation was committed because the oldest and uncommitted load/store/prefetch operation waits for memory access.",
+    "EventCode": "0x180",
+    "EventName": "LD_COMP_WAIT_L2_MISS",
+    "BriefDescription": "This event counts every cycle that no operation was committed because the oldest and uncommitted load/store/prefetch operation waits for memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for memory access.",
+    "EventCode": "0x181",
+    "EventName": "LD_COMP_WAIT_L2_MISS_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L2 cache access.",
+    "EventCode": "0x182",
+    "EventName": "LD_COMP_WAIT_L1_MISS",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L2 cache access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L2 cache access.",
+    "EventCode": "0x183",
+    "EventName": "LD_COMP_WAIT_L1_MISS_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L2 cache access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache and memory access.",
+    "EventCode": "0x184",
+    "EventName": "LD_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache and memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache and memory access.",
+    "EventCode": "0x185",
+    "EventName": "LD_COMP_WAIT_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache and memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed due to the lack of an available prefetch port.",
+    "EventCode": "0x186",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed due to the lack of an available prefetch port."
+  },
+  {
+    "PublicDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by an integer load operation.",
+    "EventCode": "0x187",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY_EX",
+    "BriefDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by an integer load operation."
+  },
+  {
+    "PublicDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction.",
+    "EventCode": "0x188",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY_SWPF",
+    "BriefDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is an integer or floating-point/SIMD instruction.",
+    "EventCode": "0x189",
+    "EventName": "EU_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is an integer or floating-point/SIMD instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a floating-point/SIMD instruction.",
+    "EventCode": "0x18A",
+    "EventName": "FL_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a floating-point/SIMD instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a branch instruction.",
+    "EventCode": "0x18B",
+    "EventName": "BR_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a branch instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the CSE is empty.",
+    "EventCode": "0x18C",
+    "EventName": "ROB_EMPTY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the CSE is empty."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the CSE is empty and the store port (SP) is full.",
+    "EventCode": "0x18D",
+    "EventName": "ROB_EMPTY_STQ_BUSY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the CSE is empty and the store port (SP) is full."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that the instruction unit is halted by the WFE/WFI instruction.",
+    "EventCode": "0x18E",
+    "EventName": "WFE_WFI_CYCLE",
+    "BriefDescription": "This event counts every cycle that the instruction unit is halted by the WFE/WFI instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only.",
+    "EventCode": "0x190",
+    "EventName": "0INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that one instruction is committed.",
+    "EventCode": "0x191",
+    "EventName": "1INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that one instruction is committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that two instructions are committed.",
+    "EventCode": "0x192",
+    "EventName": "2INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that two instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that three instructions are committed.",
+    "EventCode": "0x193",
+    "EventName": "3INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that three instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that four instructions are committed.",
+    "EventCode": "0x194",
+    "EventName": "4INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that four instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that only any micro-operations are committed.",
+    "EventCode": "0x198",
+    "EventName": "UOP_ONLY_COMMIT",
+    "BriefDescription": "This event counts every cycle that only any micro-operations are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that only the MOVPRFX instruction is committed.",
+    "EventCode": "0x199",
+    "EventName": "SINGLE_MOVPRFX_COMMIT",
+    "BriefDescription": "This event counts every cycle that only the MOVPRFX instruction is committed."
+  },
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of core.",
+    "EventCode": "0x1E0",
+    "EventName": "EA_CORE",
+    "BriefDescription": "This event counts energy consumption per cycle of core."
+  },
+  {
+    "PublicDescription": "This event counts streaming prefetch requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x230",
+    "EventName": "L1HWPF_STREAM_PF",
+    "BriefDescription": "This event counts streaming prefetch requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts allocation type prefetch injection requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x231",
+    "EventName": "L1HWPF_INJ_ALLOC_PF",
+    "BriefDescription": "This event counts allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x232",
+    "EventName": "L1HWPF_INJ_NOALLOC_PF",
+    "BriefDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher.",
+    "EventCode": "0x233",
+    "EventName": "L2HWPF_STREAM_PF",
+    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher."
+  },
+  {
+    "PublicDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",
+    "EventCode": "0x234",
+    "EventName": "L2HWPF_INJ_ALLOC_PF",
+    "BriefDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts non-allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",
+    "EventCode": "0x235",
+    "EventName": "L2HWPF_INJ_NOALLOC_PF",
+    "BriefDescription": "This event counts non-allocation type prefetch injection requests to L2 cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts prefetch requests to L2 cache generated by the other causes.",
+    "EventCode": "0x236",
+    "EventName": "L2HWPF_OTHER",
+    "BriefDescription": "This event counts prefetch requests to L2 cache generated by the other causes."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
new file mode 100644
index 0000000..dc36934
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
@@ -0,0 +1,200 @@
+[
+  {
+    "PublicDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because there are no operations available to issue for this PE from the frontend.",
+    "EventCode": "0x23",
+    "EventName": "STALL_FRONTEND",
+    "BriefDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because there are no operations available to issue for this PE from the frontend."
+  },
+  {
+    "PublicDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because the backend is unable to accept any operations.",
+    "EventCode": "0x24",
+    "EventName": "STALL_BACKEND",
+    "BriefDescription": "This event counts every cycle counted by the CPU_CYCLES event on that no operation was issued because the backend is unable to accept any operations."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EAGA pipeline.",
+    "EventCode": "0x1A0",
+    "EventName": "EAGA_VAL",
+    "BriefDescription": "This event counts valid cycles of EAGA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EAGB pipeline.",
+    "EventCode": "0x1A1",
+    "EventName": "EAGB_VAL",
+    "BriefDescription": "This event counts valid cycles of EAGB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EXA pipeline.",
+    "EventCode": "0x1A2",
+    "EventName": "EXA_VAL",
+    "BriefDescription": "This event counts valid cycles of EXA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EXB pipeline.",
+    "EventCode": "0x1A3",
+    "EventName": "EXB_VAL",
+    "BriefDescription": "This event counts valid cycles of EXB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of FLA pipeline.",
+    "EventCode": "0x1A4",
+    "EventName": "FLA_VAL",
+    "BriefDescription": "This event counts valid cycles of FLA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of FLB pipeline.",
+    "EventCode": "0x1A5",
+    "EventName": "FLB_VAL",
+    "BriefDescription": "This event counts valid cycles of FLB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of PRX pipeline.",
+    "EventCode": "0x1A6",
+    "EventName": "PRX_VAL",
+    "BriefDescription": "This event counts valid cycles of PRX pipeline."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in FLA pipeline, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x1B4",
+    "EventName": "FLA_VAL_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in FLA pipeline, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in FLB pipeline, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x1B5",
+    "EventName": "FLB_VAL_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in FLB pipeline, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1D cache pipeline#0.",
+    "EventCode": "0x240",
+    "EventName": "L1_PIPE0_VAL",
+    "BriefDescription": "This event counts valid cycles of L1D cache pipeline#0."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1D cache pipeline#1.",
+    "EventCode": "0x241",
+    "EventName": "L1_PIPE1_VAL",
+    "BriefDescription": "This event counts valid cycles of L1D cache pipeline#1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its sce bit of tagged address is 1.",
+    "EventCode": "0x250",
+    "EventName": "L1_PIPE0_VAL_IU_TAG_ADRS_SCE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its sce bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its pfe bit of tagged address is 1.",
+    "EventCode": "0x251",
+    "EventName": "L1_PIPE0_VAL_IU_TAG_ADRS_PFE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its pfe bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its sce bit of tagged address is 1.",
+    "EventCode": "0x252",
+    "EventName": "L1_PIPE1_VAL_IU_TAG_ADRS_SCE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its sce bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its pfe bit of tagged address is 1.",
+    "EventCode": "0x253",
+    "EventName": "L1_PIPE1_VAL_IU_TAG_ADRS_PFE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its pfe bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1D cache pipeline#0.",
+    "EventCode": "0x260",
+    "EventName": "L1_PIPE0_COMP",
+    "BriefDescription": "This event counts completed requests in L1D cache pipeline#0."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1D cache pipeline#1.",
+    "EventCode": "0x261",
+    "EventName": "L1_PIPE1_COMP",
+    "BriefDescription": "This event counts completed requests in L1D cache pipeline#1."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1I cache pipeline.",
+    "EventCode": "0x268",
+    "EventName": "L1I_PIPE_COMP",
+    "BriefDescription": "This event counts completed requests in L1I cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1I cache pipeline.",
+    "EventCode": "0x269",
+    "EventName": "L1I_PIPE_VAL",
+    "BriefDescription": "This event counts valid cycles of L1I cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts aborted requests in L1D pipelines that due to store-load interlock.",
+    "EventCode": "0x274",
+    "EventName": "L1_PIPE_ABORT_STLD_INTLK",
+    "BriefDescription": "This event counts aborted requests in L1D pipelines that due to store-load interlock."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its sector cache ID is not 0.",
+    "EventCode": "0x2A0",
+    "EventName": "L1_PIPE0_VAL_IU_NOT_SEC0",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its sector cache ID is not 0."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its sector cache ID is not 0.",
+    "EventCode": "0x2A1",
+    "EventName": "L1_PIPE1_VAL_IU_NOT_SEC0",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its sector cache ID is not 0."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 2 flows because 2 elements could not be combined.",
+    "EventCode": "0x2B0",
+    "EventName": "L1_PIPE_COMP_GATHER_2FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 2 flows because 2 elements could not be combined."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 1 flow because 2 elements could be combined.",
+    "EventCode": "0x2B1",
+    "EventName": "L1_PIPE_COMP_GATHER_1FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 1 flow because 2 elements could be combined."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 0 flow because both predicate values are 0.",
+    "EventCode": "0x2B2",
+    "EventName": "L1_PIPE_COMP_GATHER_0FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 0 flow because both predicate values are 0."
+  },
+  {
+    "PublicDescription": "This event counts the number of flows of the scatter instructions.",
+    "EventCode": "0x2B3",
+    "EventName": "L1_PIPE_COMP_SCATTER_1FLOW",
+    "BriefDescription": "This event counts the number of flows of the scatter instructions."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#0, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x2B8",
+    "EventName": "L1_PIPE0_COMP_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#0, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#1, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x2B9",
+    "EventName": "L1_PIPE1_COMP_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#1, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L2 cache pipeline.",
+    "EventCode": "0x330",
+    "EventName": "L2_PIPE_VAL",
+    "BriefDescription": "This event counts valid cycles of L2 cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L2 cache pipeline.",
+    "EventCode": "0x350",
+    "EventName": "L2_PIPE_COMP_ALL",
+    "BriefDescription": "This event counts completed requests in L2 cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access.",
+    "EventCode": "0x370",
+    "EventName": "L2_PIPE_COMP_PF_L2MIB_MCH",
+    "BriefDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
new file mode 100644
index 0000000..ec8e18e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
@@ -0,0 +1,218 @@
+[
+  {
+    "PublicDescription": "This event counts architecturally executed SIMD instructions, excluding the Advanced SIMD scalar instructions and the instructions listed in Non-SIMD SVE instructions section of SVE Reference Manual.",
+    "EventCode": "0x8000",
+    "EventName": "SIMD_INST_RETIRED",
+    "BriefDescription": "This event counts architecturally executed SIMD instructions, excluding the Advanced SIMD scalar instructions and the instructions listed in Non-SIMD SVE instructions section of SVE Reference Manual."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SVE instructions, including the instructions listed in Non-SIMD SVE instructions section of SVE Reference Manual.",
+    "EventCode": "0x8002",
+    "EventName": "SVE_INST_RETIRED",
+    "BriefDescription": "This event counts architecturally executed SVE instructions, including the instructions listed in Non-SIMD SVE instructions section of SVE Reference Manual."
+  },
+  {
+    "PublicDescription": "This event counts all architecturally executed micro-operations.",
+    "EventCode": "0x8008",
+    "EventName": "UOP_SPEC",
+    "BriefDescription": "This event counts all architecturally executed micro-operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed math function operations due to the SVE FTSMUL, FTMAD, FTSSEL, and FEXPA instructions.",
+    "EventCode": "0x800E",
+    "EventName": "SVE_MATH_SPEC",
+    "BriefDescription": "This event counts architecturally executed math function operations due to the SVE FTSMUL, FTMAD, FTSSEL, and FEXPA instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations due to scalar, Advanced SIMD, and SVE instructions listed in Floating-point instructions section of SVE Reference Manual.",
+    "EventCode": "0x8010",
+    "EventName": "FP_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations due to scalar, Advanced SIMD, and SVE instructions listed in Floating-point instructions section of SVE Reference Manual."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed floating-point fused multiply-add and multiply-subtract operations.",
+    "EventCode": "0x8028",
+    "EventName": "FP_FMA_SPEC",
+    "BriefDescription": "This event counts architecturally executed floating-point fused multiply-add and multiply-subtract operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed floating-point reciprocal estimate operations due to the Advanced SIMD scalar, Advanced SIMD vector, and SVE FRECPE and FRSQRTE instructions.",
+    "EventCode": "0x8034",
+    "EventName": "FP_RECPE_SPEC",
+    "BriefDescription": "This event counts architecturally executed floating-point reciprocal estimate operations due to the Advanced SIMD scalar, Advanced SIMD vector, and SVE FRECPE and FRSQRTE instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed floating-point convert operations due to the scalar, Advanced SIMD, and SVE floating-point conversion instructions listed in Floating-point conversions section of SVE Reference Manual.",
+    "EventCode": "0x8038",
+    "EventName": "FP_CVT_SPEC",
+    "BriefDescription": "This event counts architecturally executed floating-point convert operations due to the scalar, Advanced SIMD, and SVE floating-point conversion instructions listed in Floating-point conversions section of SVE Reference Manual."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed integer arithmetic operations due to Advanced SIMD and SVE data-processing instructions listed in Integer instructions section of SVE Reference Manual.",
+    "EventCode": "0x8043",
+    "EventName": "ASE_SVE_INT_SPEC",
+    "BriefDescription": "This event counts architecturally executed integer arithmetic operations due to Advanced SIMD and SVE data-processing instructions listed in Integer instructions section of SVE Reference Manual."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SIMD data-processing and load/store operations due to SVE instructions with a Governing predicate operand that determines the Active elements.",
+    "EventCode": "0x8074",
+    "EventName": "SVE_PRED_SPEC",
+    "BriefDescription": "This event counts architecturally executed SIMD data-processing and load/store operations due to SVE instructions with a Governing predicate operand that determines the Active elements."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations due to MOVPRFX instructions, whether or not they were fused with the prefixed instruction.",
+    "EventCode": "0x807C",
+    "EventName": "SVE_MOVPRFX_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations due to MOVPRFX instructions, whether or not they were fused with the prefixed instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations due to MOVPRFX instructions that were not fused with the prefixed instruction.",
+    "EventCode": "0x807F",
+    "EventName": "SVE_MOVPRFX_U_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations due to MOVPRFX instructions that were not fused with the prefixed instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD load instructions.",
+    "EventCode": "0x8085",
+    "EventName": "ASE_SVE_LD_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD load instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD store instructions.",
+    "EventCode": "0x8086",
+    "EventName": "ASE_SVE_ST_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD store instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed prefetch operations due to scalar PRFM and SVE PRF instructions.",
+    "EventCode": "0x8087",
+    "EventName": "PRF_SPEC",
+    "BriefDescription": "This event counts architecturally executed prefetch operations due to scalar PRFM and SVE PRF instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to an instruction that loads a general-purpose register.",
+    "EventCode": "0x8089",
+    "EventName": "BASE_LD_REG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to an instruction that loads a general-purpose register."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to an instruction that stores a general-purpose register, excluding the 'DC ZVA' instruction.",
+    "EventCode": "0x808A",
+    "EventName": "BASE_ST_REG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to an instruction that stores a general-purpose register, excluding the 'DC ZVA' instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to an SVE LDR instruction.",
+    "EventCode": "0x8091",
+    "EventName": "SVE_LDR_REG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to an SVE LDR instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to an SVE STR instruction.",
+    "EventCode": "0x8092",
+    "EventName": "SVE_STR_REG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to an SVE STR instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to an SVE LDR (predicate) instruction.",
+    "EventCode": "0x8095",
+    "EventName": "SVE_LDR_PREG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to an SVE LDR (predicate) instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to an SVE STR (predicate) instruction.",
+    "EventCode": "0x8096",
+    "EventName": "SVE_STR_PREG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to an SVE STR (predicate) instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that prefetch memory due to an SVE predicated single contiguous element prefetch instruction.",
+    "EventCode": "0x809F",
+    "EventName": "SVE_PRF_CONTIG_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that prefetch memory due to an SVE predicated single contiguous element prefetch instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD multiple vector contiguous structure load instructions.",
+    "EventCode": "0x80A5",
+    "EventName": "ASE_SVE_LD_MULTI_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to SVE and Advanced SIMD multiple vector contiguous structure load instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD multiple vector contiguous structure store instructions.",
+    "EventCode": "0x80A6",
+    "EventName": "ASE_SVE_ST_MULTI_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to SVE and Advanced SIMD multiple vector contiguous structure store instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that read from memory due to SVE non-contiguous gather-load instructions.",
+    "EventCode": "0x80AD",
+    "EventName": "SVE_LD_GATHER_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that read from memory due to SVE non-contiguous gather-load instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that write to memory due to SVE non-contiguous scatter-store instructions.",
+    "EventCode": "0x80AE",
+    "EventName": "SVE_ST_SCATTER_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that write to memory due to SVE non-contiguous scatter-store instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that prefetch memory due to SVE non-contiguous gatherprefetch instructions.",
+    "EventCode": "0x80AF",
+    "EventName": "SVE_PRF_GATHER_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that prefetch memory due to SVE non-contiguous gatherprefetch instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed memory read operations due to SVE First-fault and Non-fault load instructions.",
+    "EventCode": "0x80BC",
+    "EventName": "SVE_LDFF_SPEC",
+    "BriefDescription": "This event counts architecturally executed memory read operations due to SVE First-fault and Non-fault load instructions."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SVE arithmetic operations.",
+    "EventCode": "0x80C0",
+    "EventName": "FP_SCALE_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed SVE arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed v8SIMD&FP arithmetic operations.",
+    "EventCode": "0x80C1",
+    "EventName": "FP_FIXED_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed v8SIMD&FP arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SVE half-precision arithmetic operations.",
+    "EventCode": "0x80C2",
+    "EventName": "FP_HP_SCALE_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed SVE half-precision arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed v8SIMD&FP half-precision arithmetic operations.",
+    "EventCode": "0x80C3",
+    "EventName": "FP_HP_FIXED_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed v8SIMD&FP half-precision arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SVE single-precision arithmetic operations.",
+    "EventCode": "0x80C4",
+    "EventName": "FP_SP_SCALE_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed SVE single-precision arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed v8SIMD&FP single-precision arithmetic operations.",
+    "EventCode": "0x80C5",
+    "EventName": "FP_SP_FIXED_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed v8SIMD&FP single-precision arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SVE double-precision arithmetic operations.",
+    "EventCode": "0x80C6",
+    "EventName": "FP_DP_SCALE_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed SVE double-precision arithmetic operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed v8SIMD&FP double-precision arithmetic operations.",
+    "EventCode": "0x80C7",
+    "EventName": "FP_DP_FIXED_OPS_SPEC",
+    "BriefDescription": "This event counts architecturally executed v8SIMD&FP double-precision arithmetic operations."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 0d60914..c43591d 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -20,5 +20,6 @@
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
+0x00000000460f0010,v1,fujitsu/a64fx,core
 0x00000000480fd010,v1,hisilicon/hip08,core
 0x00000000500f0000,v1,ampere/emag,core
-- 
1.8.3.1

