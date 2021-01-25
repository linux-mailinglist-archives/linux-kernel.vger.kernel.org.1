Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8730482F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbhAZFtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:49:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11868 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbhAYMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:19:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DPSxv6c5Sz7ZsH;
        Mon, 25 Jan 2021 19:56:19 +0800 (CST)
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
Subject: [PATCH 3/4] perf vendor events arm64: Reference common and uarch events for Ampere eMag
Date:   Mon, 25 Jan 2021 19:53:19 +0800
Message-ID: <1611575600-2440-4-git-send-email-john.garry@huawei.com>
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

Note that names for events 0x34 and 0x35 are non-standard and remain
unchanged. Those events came from the following originally:
https://github.com/AmpereComputing/ampere-centos-kernel/blob/4c2479c67bbcf35b35224db12a092b33682b181c/Documentation/arm64/eMAG-ARM-CoreImpDefined.pdf

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/ampere/emag/branch.json        |  8 +--
 .../arch/arm64/ampere/emag/bus.json           |  5 +-
 .../arch/arm64/ampere/emag/cache.json         | 56 +++++--------------
 .../arch/arm64/ampere/emag/clock.json         |  4 +-
 .../arch/arm64/ampere/emag/exception.json     | 10 +---
 .../arch/arm64/ampere/emag/instruction.json   | 34 +++--------
 .../arch/arm64/ampere/emag/memory.json        | 11 +---
 7 files changed, 31 insertions(+), 97 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
index 2d15b11e5383..5c69c1e82ef8 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
@@ -9,15 +9,11 @@
         "ArchStdEvent": "BR_INDIRECT_SPEC"
     },
     {
-        "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
-        "EventCode": "0x10",
-        "EventName": "BR_MIS_PRED",
+        "ArchStdEvent": "BR_MIS_PRED",
         "BriefDescription": "Branch mispredicted"
     },
     {
-        "PublicDescription": "Predictable branch speculatively executed",
-        "EventCode": "0x12",
-        "EventName": "BR_PRED",
+        "ArchStdEvent": "BR_PRED",
         "BriefDescription": "Predictable branch"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
index 5c1a9a922ca4..9bea1ba1c4d2 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
@@ -18,9 +18,6 @@
         "ArchStdEvent": "BUS_ACCESS_PERIPH"
     },
     {
-        "PublicDescription": "Bus access",
-        "EventCode": "0x19",
-        "EventName": "BUS_ACCESS",
-        "BriefDescription": "Bus access"
+        "ArchStdEvent": "BUS_ACCESS",
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
index ce6e7e796057..1e25f2ae4ae0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -39,70 +39,40 @@
         "ArchStdEvent": "L2D_CACHE_INVAL"
     },
     {
-        "PublicDescription": "Level 1 instruction cache refill",
-        "EventCode": "0x01",
-        "EventName": "L1I_CACHE_REFILL",
-        "BriefDescription": "L1I cache refill"
+        "ArchStdEvent": "L1I_CACHE_REFILL",
     },
     {
-        "PublicDescription": "Level 1 instruction TLB refill",
-        "EventCode": "0x02",
-        "EventName": "L1I_TLB_REFILL",
-        "BriefDescription": "L1I TLB refill"
+        "ArchStdEvent": "L1I_TLB_REFILL",
     },
     {
-        "PublicDescription": "Level 1 data cache refill",
-        "EventCode": "0x03",
-        "EventName": "L1D_CACHE_REFILL",
-        "BriefDescription": "L1D cache refill"
+        "ArchStdEvent": "L1D_CACHE_REFILL",
     },
     {
-        "PublicDescription": "Level 1 data cache access",
-        "EventCode": "0x04",
-        "EventName": "L1D_CACHE_ACCESS",
-        "BriefDescription": "L1D cache access"
+        "ArchStdEvent": "L1D_CACHE",
     },
     {
-        "PublicDescription": "Level 1 data TLB refill",
-        "EventCode": "0x05",
-        "EventName": "L1D_TLB_REFILL",
-        "BriefDescription": "L1D TLB refill"
+        "ArchStdEvent": "L1D_TLB_REFILL",
     },
     {
-        "PublicDescription": "Level 1 instruction cache access",
-        "EventCode": "0x14",
-        "EventName": "L1I_CACHE_ACCESS",
-        "BriefDescription": "L1I cache access"
+        "ArchStdEvent": "L1I_CACHE",
     },
     {
-        "PublicDescription": "Level 2 data cache access",
-        "EventCode": "0x16",
-        "EventName": "L2D_CACHE_ACCESS",
-        "BriefDescription": "L2D cache access"
+        "ArchStdEvent": "L2D_CACHE",
     },
     {
-        "PublicDescription": "Level 2 data refill",
-        "EventCode": "0x17",
-        "EventName": "L2D_CACHE_REFILL",
-        "BriefDescription": "L2D cache refill"
+        "ArchStdEvent": "L2D_CACHE_REFILL",
     },
     {
-        "PublicDescription": "Level 2 data cache, Write-Back",
-        "EventCode": "0x18",
-        "EventName": "L2D_CACHE_WB",
-        "BriefDescription": "L2D cache Write-Back"
+        "ArchStdEvent": "L2D_CACHE_WB",
     },
     {
-        "PublicDescription": "Level 1 data TLB access. This event counts any load or store operation which accesses the data L1 TLB",
-        "EventCode": "0x25",
-        "EventName": "L1D_TLB_ACCESS",
+        "PublicDescription": "This event counts any load or store operation which accesses the data L1 TLB",
+        "ArchStdEvent": "L1D_TLB",
         "BriefDescription": "L1D TLB access"
     },
     {
-        "PublicDescription": "Level 1 instruction TLB access. This event counts any instruction fetch which accesses the instruction L1 TLB",
-        "EventCode": "0x26",
-        "EventName": "L1I_TLB_ACCESS",
-        "BriefDescription": "L1I TLB access"
+        "PublicDescription": "This event counts any instruction fetch which accesses the instruction L1 TLB",
+        "ArchStdEvent": "L1I_TLB",
     },
     {
         "PublicDescription": "Level 2 access to data TLB that caused a page table walk. This event counts on any data access which causes L2D_TLB_REFILL to count",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
index 51d1dc1519b2..9076ca2daf9e 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
@@ -1,9 +1,7 @@
 [
     {
         "PublicDescription": "The number of core clock cycles",
-        "EventCode": "0x11",
-        "EventName": "CPU_CYCLES",
-        "BriefDescription": "Clock cycles"
+        "ArchStdEvent": "CPU_CYCLES",
     },
     {
         "PublicDescription": "FSU clocking gated off cycle",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
index 66e51bc64b22..9761433ad329 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
@@ -36,15 +36,9 @@
         "ArchStdEvent": "EXC_TRAP_FIQ"
     },
     {
-        "PublicDescription": "Exception taken",
-        "EventCode": "0x09",
-        "EventName": "EXC_TAKEN",
-        "BriefDescription": "Exception taken"
+        "ArchStdEvent": "EXC_TAKEN",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, condition check pass, exception return",
-        "EventCode": "0x0a",
-        "EventName": "EXC_RETURN",
-        "BriefDescription": "Exception return"
+        "ArchStdEvent": "EXC_RETURN",
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
index 0d3e46776642..482aa3f19e58 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
@@ -40,45 +40,29 @@
     },
     {
         "PublicDescription": "Instruction architecturally executed, software increment",
-        "EventCode": "0x00",
-        "EventName": "SW_INCR",
+        "ArchStdEvent": "SW_INCR",
         "BriefDescription": "Software increment"
     },
     {
-        "PublicDescription": "Instruction architecturally executed",
-        "EventCode": "0x08",
-        "EventName": "INST_RETIRED",
-        "BriefDescription": "Instruction retired"
+        "ArchStdEvent": "INST_RETIRED",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR",
-        "EventCode": "0x0b",
-        "EventName": "CID_WRITE_RETIRED",
+        "ArchStdEvent": "CID_WRITE_RETIRED",
         "BriefDescription": "Write to CONTEXTIDR"
     },
     {
-        "PublicDescription": "Operation speculatively executed",
-        "EventCode": "0x1b",
-        "EventName": "INST_SPEC",
-        "BriefDescription": "Speculatively executed"
+        "ArchStdEvent": "INST_SPEC",
     },
     {
-        "PublicDescription": "Instruction architecturally executed (condition check pass), write to TTBR",
-        "EventCode": "0x1c",
-        "EventName": "TTBR_WRITE_RETIRED",
-        "BriefDescription": "Instruction executed, TTBR write"
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, branch. This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches",
-        "EventCode": "0x21",
-        "EventName": "BR_RETIRED",
-        "BriefDescription": "Branch retired"
+        "PublicDescription": "This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches",
+        "ArchStdEvent": "BR_RETIRED",
     },
     {
-        "PublicDescription": "Instruction architecturally executed, mispredicted branch. This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush",
-        "EventCode": "0x22",
-        "EventName": "BR_MISPRED_RETIRED",
-        "BriefDescription": "Mispredicted branch retired"
+        "PublicDescription": "This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush",
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
     },
     {
         "PublicDescription": "Operation speculatively executed, NOP",
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
index c2fe674df960..2e7555696caf 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
@@ -15,15 +15,10 @@
         "ArchStdEvent": "UNALIGNED_LDST_SPEC"
     },
     {
-        "PublicDescription": "Data memory access",
-        "EventCode": "0x13",
-        "EventName": "MEM_ACCESS",
-        "BriefDescription": "Memory access"
+        "ArchStdEvent": "MEM_ACCESS",
     },
     {
-        "PublicDescription": "Local memory error. This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
-        "EventCode": "0x1a",
-        "EventName": "MEM_ERROR",
-        "BriefDescription": "Memory error"
+        "PublicDescription": "This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
+        "ArchStdEvent": "MEMORY_ERROR",
     }
 ]
-- 
2.26.2

