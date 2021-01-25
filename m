Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FBC3035AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbhAZFtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:49:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11586 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbhAYMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:19:33 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPSxd1Tx1zMPfH;
        Mon, 25 Jan 2021 19:56:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 19:57:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <james.clark@arm.com>, <nakamura.shun@jp.fujitsu.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] perf vendor events arm64: Reference common and uarch events for A76
Date:   Mon, 25 Jan 2021 19:53:20 +0800
Message-ID: <1611575600-2440-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
References: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce duplication in the JSONs by referencing standard events from
armv8-common-and-microarch.json

In general the "PublicDescription" fields are not modified when somewhat
significantly worded differently than the standard.

Apart from that, description and names for events slightly different to
standard are changed (to standard) for consistency.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  12 +-
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  19 ++-
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 118 ++++++------------
 .../arm64/arm/cortex-a76-n1/exception.json    |  10 +-
 .../arm64/arm/cortex-a76-n1/instruction.json  |  45 +++----
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |   6 +-
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   4 +-
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  12 +-
 8 files changed, 76 insertions(+), 150 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
index b5e5d055c70d..ec0dc92288ab 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
@@ -1,14 +1,10 @@
 [
     {
-        "PublicDescription": "Mispredicted or not predicted branch speculatively executed. This event counts any predictable branch instruction which is mispredicted either due to dynamic misprediction or because the MMU is off and the branches are statically predicted not taken.",
-        "EventCode": "0x10",
-        "EventName": "BR_MIS_PRED",
-        "BriefDescription": "Mispredicted or not predicted branch speculatively executed."
+        "PublicDescription": "This event counts any predictable branch instruction which is mispredicted either due to dynamic misprediction or because the MMU is off and the branches are statically predicted not taken",
+        "ArchStdEvent": "BR_MIS_PRED",
     },
     {
-        "PublicDescription": "Predictable branch speculatively executed. This event counts all predictable branches.",
-        "EventCode": "0x12",
-        "EventName": "BR_PRED",
-        "BriefDescription": "Predictable branch speculatively executed."
+        "PublicDescription": "This event counts all predictable branches.",
+        "ArchStdEvent": "BR_PRED",
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
index fce7309ae624..6263929efce2 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
@@ -1,24 +1,21 @@
 [
     {
-        "EventCode": "0x11",
-        "EventName": "CPU_CYCLES",
+        "PublicDescription": "The number of core clock cycles"
+        "ArchStdEvent": "CPU_CYCLES",
         "BriefDescription": "The number of core clock cycles."
     },
     {
-        "PublicDescription": "Bus access. This event counts for every beat of data transferred over the data channels between the core and the SCU. If both read and write data beats are transferred on a given cycle, this event is counted twice on that cycle. This event counts the sum of BUS_ACCESS_RD and BUS_ACCESS_WR.",
-        "EventCode": "0x19",
-        "EventName": "BUS_ACCESS",
-        "BriefDescription": "Bus access."
+        "PublicDescription": "This event counts for every beat of data transferred over the data channels between the core and the SCU. If both read and write data beats are transferred on a given cycle, this event is counted twice on that cycle. This event counts the sum of BUS_ACCESS_RD and BUS_ACCESS_WR.",
+        "ArchStdEvent": "BUS_ACCESS",
     },
     {
-        "EventCode": "0x1D",
-        "EventName": "BUS_CYCLES",
-        "BriefDescription": "Bus cycles. This event duplicates CPU_CYCLES."
+        "PublicDescription": "This event duplicates CPU_CYCLES."
+        "ArchStdEvent": "BUS_CYCLES",
     },
     {
-        "ArchStdEvent":  "BUS_ACCESS_RD"
+        "ArchStdEvent":  "BUS_ACCESS_RD",
     },
     {
-        "ArchStdEvent":  "BUS_ACCESS_WR"
+        "ArchStdEvent":  "BUS_ACCESS_WR",
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
index 24594081c199..cd67bb9df139 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
@@ -1,133 +1,95 @@
 [
     {
-        "PublicDescription": "L1 instruction cache refill. This event counts any instruction fetch which misses in the cache.",
-        "EventCode": "0x01",
-        "EventName": "L1I_CACHE_REFILL",
-        "BriefDescription": "L1 instruction cache refill"
+        "PublicDescription": "This event counts any instruction fetch which misses in the cache.",
+        "ArchStdEvent": "L1I_CACHE_REFILL",
     },
     {
-        "PublicDescription": "L1 instruction TLB refill. This event counts any refill of the instruction L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
-        "EventCode": "0x02",
-        "EventName": "L1I_TLB_REFILL",
-        "BriefDescription": "L1 instruction TLB refill"
+        "PublicDescription": "This event counts any refill of the instruction L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
+        "ArchStdEvent": "L1I_TLB_REFILL",
     },
     {
-        "PublicDescription": "L1 data cache refill. This event counts any load or store operation or page table walk access which causes data to be read from outside the L1, including accesses which do not allocate into L1.",
-        "EventCode": "0x03",
-        "EventName": "L1D_CACHE_REFILL",
-        "BriefDescription": "L1 data cache refill"
+        "PublicDescription": "This event counts any load or store operation or page table walk access which causes data to be read from outside the L1, including accesses which do not allocate into L1.",
+        "ArchStdEvent": "L1D_CACHE_REFILL",
     },
     {
-        "PublicDescription": "L1 data cache access. This event counts any load or store operation or page table walk access which looks up in the L1 data cache. In particular, any access which could count the L1D_CACHE_REFILL event causes this event to count.",
-        "EventCode": "0x04",
-        "EventName": "L1D_CACHE",
-        "BriefDescription": "L1 data cache access"
+        "PublicDescription": "This event counts any load or store operation or page table walk access which looks up in the L1 data cache. In particular, any access which could count the L1D_CACHE_REFILL event causes this event to count.",
+        "ArchStdEvent": "L1D_CACHE",
     },
     {
-        "PublicDescription": "L1 data TLB refill. This event counts any refill of the data L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
-        "EventCode": "0x05",
-        "EventName": "L1D_TLB_REFILL",
-        "BriefDescription": "L1 data TLB refill"
+        "PublicDescription": "This event counts any refill of the data L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
+        "ArchStdEvent": "L1D_TLB_REFILL",
     },
-    {
+    {,
         "PublicDescription": "Level 1 instruction cache access or Level 0 Macro-op cache access. This event counts any instruction fetch which accesses the L1 instruction cache or L0 Macro-op cache.",
-        "EventCode": "0x14",
-        "EventName": "L1I_CACHE",
-        "BriefDescription": "L1 instruction cache access"
+        "ArchStdEvent": "L1I_CACHE",
     },
     {
-        "PublicDescription": "L1 data cache Write-Back. This event counts any write-back of data from the L1 data cache to L2 or L3. This counts both victim line evictions and snoops, including cache maintenance operations.",
-        "EventCode": "0x15",
-        "EventName": "L1D_CACHE_WB",
-        "BriefDescription": "L1 data cache Write-Back"
+        "PublicDescription": "This event counts any write-back of data from the L1 data cache to L2 or L3. This counts both victim line evictions and snoops, including cache maintenance operations.",
+        "ArchStdEvent": "L1D_CACHE_WB",
     },
     {
-        "PublicDescription": "L2 data cache access. This event counts any transaction from L1 which looks up in the L2 cache, and any write-back from the L1 to the L2. Snoops from outside the core and cache maintenance operations are not counted.",
-        "EventCode": "0x16",
-        "EventName": "L2D_CACHE",
-        "BriefDescription": "L2 data cache access"
+        "PublicDescription": "This event counts any transaction from L1 which looks up in the L2 cache, and any write-back from the L1 to the L2. Snoops from outside the core and cache maintenance operations are not counted.",
+        "ArchStdEvent": "L2D_CACHE",
     },
     {
         "PublicDescription": "L2 data cache refill. This event counts any cacheable transaction from L1 which causes data to be read from outside the core. L2 refills caused by stashes into L2 should not be counted",
-        "EventCode": "0x17",
-        "EventName": "L2D_CACHE_REFILL",
-        "BriefDescription": "L2 data cache refill"
+        "ArchStdEvent": "L2D_CACHE_REFILL",
     },
     {
-        "PublicDescription": "L2 data cache write-back. This event counts any write-back of data from the L2 cache to outside the core. This includes snoops to the L2 which return data, regardless of whether they cause an invalidation. Invalidations from the L2 which do not write data outside of the core and snoops which return data from the L1 are not counted",
-        "EventCode": "0x18",
-        "EventName": "L2D_CACHE_WB",
-        "BriefDescription": "L2 data cache write-back"
+        "PublicDescription": "This event counts any write-back of data from the L2 cache to outside the core. This includes snoops to the L2 which return data, regardless of whether they cause an invalidation. Invalidations from the L2 which do not write data outside of the core and snoops which return data from the L1 are not counted",
+        "ArchStdEvent": "L2D_CACHE_WB",
     },
     {
-        "PublicDescription": "L2 data cache allocation without refill. This event counts any full cache line write into the L2 cache which does not cause a linefill, including write-backs from L1 to L2 and full-line writes which do not allocate into L1.",
-        "EventCode": "0x20",
-        "EventName": "L2D_CACHE_ALLOCATE",
-        "BriefDescription": "L2 data cache allocation without refill"
+        "PublicDescription": "This event counts any full cache line write into the L2 cache which does not cause a linefill, including write-backs from L1 to L2 and full-line writes which do not allocate into L1.",
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
     },
     {
-        "PublicDescription": "Level 1 data TLB access. This event counts any load or store operation which accesses the data L1 TLB. If both a load and a store are executed on a cycle, this event counts twice. This event counts regardless of whether the MMU is enabled.",
-        "EventCode": "0x25",
-        "EventName": "L1D_TLB",
+        "PublicDescription": "This event counts any load or store operation which accesses the data L1 TLB. If both a load and a store are executed on a cycle, this event counts twice. This event counts regardless of whether the MMU is enabled.",
+        "ArchStdEvent": "L1D_TLB",
         "BriefDescription": "Level 1 data TLB access."
     },
     {
-        "PublicDescription": "Level 1 instruction TLB access. This event counts any instruction fetch which accesses the instruction L1 TLB.This event counts regardless of whether the MMU is enabled.",
-        "EventCode": "0x26",
-        "EventName": "L1I_TLB",
+        "PublicDescription": "This event counts any instruction fetch which accesses the instruction L1 TLB.This event counts regardless of whether the MMU is enabled.",
+        "ArchStdEvent": "L1I_TLB",
         "BriefDescription": "Level 1 instruction TLB access"
     },
     {
         "PublicDescription": "This event counts any full cache line write into the L3 cache which does not cause a linefill, including write-backs from L2 to L3 and full-line writes which do not allocate into L2",
-        "EventCode": "0x29",
-        "EventName": "L3D_CACHE_ALLOCATE",
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
         "BriefDescription": "Allocation without refill"
     },
     {
-        "PublicDescription": "Attributable Level 3 unified cache refill. This event counts for any cacheable read transaction returning datafrom the SCU for which the data source was outside the cluster. Transactions such as ReadUnique are counted here as 'read' transactions, even though they can be generated by store instructions.",
-        "EventCode": "0x2A",
-        "EventName": "L3D_CACHE_REFILL",
+        "PublicDescription": "This event counts for any cacheable read transaction returning datafrom the SCU for which the data source was outside the cluster. Transactions such as ReadUnique are counted here as 'read' transactions, even though they can be generated by store instructions.",
+        "ArchStdEvent": "L3D_CACHE_REFILL",
         "BriefDescription": "Attributable Level 3 unified cache refill."
     },
     {
-        "PublicDescription": "Attributable Level 3 unified cache access. This event counts for any cacheable read transaction returning datafrom the SCU, or for any cacheable write to the SCU.",
-        "EventCode": "0x2B",
-        "EventName": "L3D_CACHE",
+        "PublicDescription": "This event counts for any cacheable read transaction returning datafrom the SCU, or for any cacheable write to the SCU.",
+        "ArchStdEvent": "L3D_CACHE",
         "BriefDescription": "Attributable Level 3 unified cache access."
     },
     {
-        "PublicDescription": "Attributable L2 data or unified TLB refill. This event counts on anyrefill of the L2 TLB, caused by either an instruction or data access.This event does not count if the MMU is disabled.",
-        "EventCode": "0x2D",
-        "EventName": "L2D_TLB_REFILL",
+        "PublicDescription": "This event counts on anyrefill of the L2 TLB, caused by either an instruction or data access.This event does not count if the MMU is disabled.",
+        "ArchStdEvent": "L2D_TLB_REFILL",
         "BriefDescription": "Attributable L2 data or unified TLB refill"
     },
     {
-        "PublicDescription": "Attributable L2 data or unified TLB access. This event counts on any access to the L2 TLB (caused by a refill of any of the L1 TLBs). This event does not count if the MMU is disabled.",
-        "EventCode": "0x2F",
-        "EventName": "L2D_TLB",
-        "BriefDescription": "Attributable L2 data or unified TLB access"
+        "PublicDescription": "This event counts on any access to the L2 TLB (caused by a refill of any of the L1 TLBs). This event does not count if the MMU is disabled.",
+        "ArchStdEvent": "L2D_TLB",
     },
     {
-        "PublicDescription": "Access to data TLB that caused a page table walk. This event counts on any data access which causes L2D_TLB_REFILL to count.",
-        "EventCode": "0x34",
-        "EventName": "DTLB_WALK",
-        "BriefDescription": "Access to data TLB that caused a page table walk."
+        "PublicDescription": "This event counts on any data access which causes L2D_TLB_REFILL to count.",
+        "ArchStdEvent": "DTLB_WALK",
     },
     {
-        "PublicDescription": "Access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2D_TLB_REFILL to count.",
-        "EventCode": "0x35",
-        "EventName": "ITLB_WALK",
-        "BriefDescription": "Access to instruction TLB that caused a page table walk."
+        "PublicDescription": "This event counts on any instruction access which causes L2D_TLB_REFILL to count.",
+        "ArchStdEvent": "ITLB_WALK",
     },
     {
-        "EventCode": "0x36",
-        "EventName": "LL_CACHE_RD",
-        "BriefDescription": "Last level cache access, read"
+        "ArchStdEvent": "LL_CACHE_RD",
     },
     {
-        "EventCode": "0x37",
-        "EventName": "LL_CACHE_MISS_RD",
-        "BriefDescription": "Last level cache miss, read"
+        "ArchStdEvent": "LL_CACHE_MISS_RD",
     },
     {
         "ArchStdEvent": "L1D_CACHE_INVAL"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
index 98d29c862320..ea4631db41b5 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
@@ -1,14 +1,10 @@
 [
     {
-        "EventCode": "0x09",
-        "EventName": "EXC_TAKEN",
-        "BriefDescription": "Exception taken."
+        "ArchStdEvent": "EXC_TAKEN",
     },
     {
-        "PublicDescription": "Local memory error. This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
-        "EventCode": "0x1A",
-        "EventName": "MEMORY_ERROR",
-        "BriefDescription": "Local memory error."
+        "PublicDescription": "This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
+        "ArchStdEvent": "MEMORY_ERROR",
     },
     {
         "ArchStdEvent": "EXC_DABORT"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
index c153ac706d8d..8e59566cba8b 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
@@ -1,49 +1,32 @@
 [
     {
-        "PublicDescription": "Software increment. Instruction architecturally executed (condition code check pass).",
-        "EventCode": "0x00",
-        "EventName": "SW_INCR",
-        "BriefDescription": "Software increment."
+        "ArchStdEvent": "SW_INCR",
     },
     {
-        "PublicDescription": "Instruction architecturally executed. This event counts all retired instructions, including those that fail their condition check.",
-        "EventCode": "0x08",
-        "EventName": "INST_RETIRED",
-        "BriefDescription": "Instruction architecturally executed."
+        "PublicDescription": "This event counts all retired instructions, including those that fail their condition check.",
+        "ArchStdEvent": "INST_RETIRED",
     },
     {
-        "EventCode": "0x0A",
-        "EventName": "EXC_RETURN",
-        "BriefDescription": "Instruction architecturally executed, condition code check pass, exception return."
+        "ArchStdEvent": "EXC_RETURN",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR. This event only counts writes to CONTEXTIDR in AArch32 state, and via the CONTEXTIDR_EL1 mnemonic in AArch64 state.",
-        "EventCode": "0x0B",
-        "EventName": "CID_WRITE_RETIRED",
-        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR."
+        "PublicDescription": "This event only counts writes to CONTEXTIDR in AArch32 state, and via the CONTEXTIDR_EL1 mnemonic in AArch64 state.",
+        "ArchStdEvent": "CID_WRITE_RETIRED",
     },
     {
-        "EventCode": "0x1B",
-        "EventName": "INST_SPEC",
-        "BriefDescription": "Operation speculatively executed"
+        "ArchStdEvent": "INST_SPEC",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to TTBR. This event only counts writes to TTBR0/TTBR1 in AArch32 state and TTBR0_EL1/TTBR1_EL1 in AArch64 state.",
-        "EventCode": "0x1C",
-        "EventName": "TTBR_WRITE_RETIRED",
-        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to TTBR"
+        "PublicDescription": "This event only counts writes to TTBR0/TTBR1 in AArch32 state and TTBR0_EL1/TTBR1_EL1 in AArch64 state.",
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
     },
-    {
-        "PublicDescription": "Instruction architecturally executed, branch. This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches.",
-        "EventCode": "0x21",
-        "EventName": "BR_RETIRED",
-        "BriefDescription": "Instruction architecturally executed, branch."
+    {,
+        "PublicDescription": "This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches.",
+        "ArchStdEvent": "BR_RETIRED",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, mispredicted branch. This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush.",
-        "EventCode": "0x22",
-        "EventName": "BR_MIS_PRED_RETIRED",
-        "BriefDescription": "Instruction architecturally executed, mispredicted branch."
+        "PublicDescription": "This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush.",
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
     },
     {
         "ArchStdEvent": "ASE_SPEC"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
index b86643253f19..f06f399051c1 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
@@ -1,9 +1,7 @@
 [
     {
-        "PublicDescription": "Data memory access. This event counts memory accesses due to load or store instructions. This event counts the sum of MEM_ACCESS_RD and MEM_ACCESS_WR.",
-        "EventCode": "0x13",
-        "EventName": "MEM_ACCESS",
-        "BriefDescription": "Data memory access"
+        "PublicDescription": "This event counts memory accesses due to load or store instructions. This event counts the sum of MEM_ACCESS_RD and MEM_ACCESS_WR.",
+        "ArchStdEvent": "MEM_ACCESS",
     },
     {
          "ArchStdEvent": "MEM_ACCESS_RD"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
index 8bde029a62d5..c2ccbf6fbfa0 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
@@ -1,7 +1,5 @@
 [
     {
-        "EventCode": "0x31",
-        "EventName": "REMOTE_ACCESS",
-        "BriefDescription": "Access to another socket in a multi-socket system"
+        "ArchStdEvent": "REMOTE_ACCESS",
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
index 010a647f9d02..d79f0aeaf7f1 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
@@ -1,14 +1,10 @@
 [
     {
-        "PublicDescription": "No operation issued because of the frontend. The counter counts on any cycle when there are no fetched instructions available to dispatch.",
-        "EventCode": "0x23",
-        "EventName": "STALL_FRONTEND",
-        "BriefDescription": "No operation issued because of the frontend."
+        "PublicDescription": "The counter counts on any cycle when there are no fetched instructions available to dispatch.",
+        "ArchStdEvent": "STALL_FRONTEND",
     },
     {
-        "PublicDescription": "No operation issued because of the backend. The counter counts on any cycle fetched instructions are not dispatched due to resource constraints.",
-        "EventCode": "0x24",
-        "EventName": "STALL_BACKEND",
-        "BriefDescription": "No operation issued because of the backend."
+        "PublicDescription": "The counter counts on any cycle fetched instructions are not dispatched due to resource constraints.",
+        "ArchStdEvent": "STALL_BACKEND",
     }
 ]
-- 
2.26.2

