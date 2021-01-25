Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FD3035A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbhAZFtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:49:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11153 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbhAYMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:19:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPSxv2Stlz15yFc;
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
Subject: [PATCH 2/4] perf vendor events arm64: Add common and uarch event JSON
Date:   Mon, 25 Jan 2021 19:53:18 +0800
Message-ID: <1611575600-2440-3-git-send-email-john.garry@huawei.com>
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

Add a common and microarch JSON, which can be referenced from CPU JSONs.

For now, brief and public description are as event brief event
description from the ARMv8 ARM [0], D7-11.

The list of events is not complete, as not all events will be referenced
yet.

Reference document is at the following:
[0] https://documentation-service.arm.com/static/5fa3bd1eb209f547eebd4141?token=

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/armv8-common-and-microarch.json     | 248 ++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
new file mode 100644
index 000000000000..430a023ccf6a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
@@ -0,0 +1,248 @@
+[
+    {
+        "PublicDescription": "Instruction architecturally executed, Condition code check pass, software increment",
+        "EventCode": "0x00",
+        "EventName": "SW_INCR",
+        "BriefDescription": "Instruction architecturally executed, Condition code check pass, software increment"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache refill",
+        "EventCode": "0x01",
+        "EventName": "L1I_CACHE_REFILL",
+        "BriefDescription": "Level 1 instruction cache refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction TLB refill",
+        "EventCode": "0x02",
+        "EventName": "L1I_TLB_REFILL",
+        "BriefDescription": "Attributable Level 1 instruction TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache refill",
+        "EventCode": "0x03",
+        "EventName": "L1D_CACHE_REFILL",
+        "BriefDescription": "Level 1 data cache refill"
+    },
+    {
+        "PublicDescription": "Level 1 data cache access",
+        "EventCode": "0x04",
+        "EventName": "L1D_CACHE",
+        "BriefDescription": "Level 1 data cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill",
+        "EventCode": "0x05",
+        "EventName": "L1D_TLB_REFILL",
+        "BriefDescription": "Attributable Level 1 data TLB refill"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed",
+        "EventCode": "0x08",
+        "EventName": "INST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed"
+    },
+    {
+        "PublicDescription": "Exception taken",
+        "EventCode": "0x09",
+        "EventName": "EXC_TAKEN",
+        "BriefDescription": "Exception taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition check pass, exception return",
+        "EventCode": "0x0a",
+        "EventName": "EXC_RETURN",
+        "BriefDescription": "Instruction architecturally executed, condition check pass, exception return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR",
+        "EventCode": "0x0b",
+        "EventName": "CID_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR"
+    },
+    {
+        "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
+        "EventCode": "0x10",
+        "EventName": "BR_MIS_PRED",
+        "BriefDescription": "Mispredicted or not predicted branch speculatively executed"
+    },
+    {
+        "PublicDescription": "Cycle",
+        "EventCode": "0x11",
+        "EventName": "CPU_CYCLES",
+        "BriefDescription": "Cycle"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed",
+        "EventCode": "0x12",
+        "EventName": "BR_PRED",
+        "BriefDescription": "Predictable branch speculatively executed"
+    },
+    {
+        "PublicDescription": "Data memory access",
+        "EventCode": "0x13",
+        "EventName": "MEM_ACCESS",
+        "BriefDescription": "Data memory access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction cache access",
+        "EventCode": "0x14",
+        "EventName": "L1I_CACHE",
+        "BriefDescription": "Attributable Level 1 instruction cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache write-back",
+        "EventCode": "0x15",
+        "EventName": "L1D_CACHE_WB",
+        "BriefDescription": "Attributable Level 1 data cache write-back"
+    },
+    {
+        "PublicDescription": "Level 2 data cache access",
+        "EventCode": "0x16",
+        "EventName": "L2D_CACHE",
+        "BriefDescription": "Level 2 data cache access"
+    },
+    {
+        "PublicDescription": "Level 2 data refill",
+        "EventCode": "0x17",
+        "EventName": "L2D_CACHE_REFILL",
+        "BriefDescription": "Level 2 data refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data cache write-back",
+        "EventCode": "0x18",
+        "EventName": "L2D_CACHE_WB",
+        "BriefDescription": "Attributable Level 2 data cache write-back"
+    },
+    {
+        "PublicDescription": "Attributable Bus access",
+        "EventCode": "0x19",
+        "EventName": "BUS_ACCESS",
+        "BriefDescription": "Attributable Bus access",
+    },
+    {
+        "PublicDescription": "Local memory error",
+        "EventCode": "0x1a",
+        "EventName": "MEMORY_ERROR",
+        "BriefDescription": "Local memory error"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed",
+        "EventCode": "0x1b",
+        "EventName": "INST_SPEC",
+        "BriefDescription": "Operation speculatively executed"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, Condition code check pass, write to TTBR",
+        "EventCode": "0x1c",
+        "EventName": "TTBR_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, Condition code check pass, write to TTBR"
+    },
+    {
+        "PublicDescription": "Bus cycle"
+        "EventCode": "0x1D",
+        "EventName": "BUS_CYCLES",
+        "BriefDescription": "Bus cycle"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data cache allocation without refill",
+        "EventCode": "0x20",
+        "EventName": "L2D_CACHE_ALLOCATE",
+        "BriefDescription": "Attributable Level 2 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch",
+        "EventCode": "0x21",
+        "EventName": "BR_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch",
+        "EventCode": "0x22",
+        "EventName": "BR_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted branch"
+    },
+    {
+        "PublicDescription": "No operation issued because of the frontend",
+        "EventCode": "0x23",
+        "EventName": "STALL_FRONTEND",
+        "BriefDescription": "No operation issued because of the frontend"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend",
+        "EventCode": "0x24",
+        "EventName": "STALL_BACKEND",
+        "BriefDescription": "No operation issued due to the backend"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access",
+        "EventCode": "0x25",
+        "EventName": "L1D_TLB",
+        "BriefDescription": "Attributable Level 1 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Attributable Level 1 instruction TLB access",
+        "EventCode": "0x26",
+        "EventName": "L1I_TLB",
+        "BriefDescription": "Attributable Level 1 instruction TLB access"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache allocation without refill",
+        "EventCode": "0x29",
+        "EventName": "L3D_CACHE_ALLOCATE",
+        "BriefDescription": "Attributable Level 3 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache refill",
+        "EventCode": "0x2A",
+        "EventName": "L3D_CACHE_REFILL",
+        "BriefDescription": "Attributable Level 3 data cache refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 data cache access",
+        "EventCode": "0x2B",
+        "EventName": "L3D_CACHE",
+        "BriefDescription": "Attributable Level 3 data cache access"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data TLB refill",
+        "EventCode": "0x2D",
+        "EventName": "L2D_TLB_REFILL",
+        "BriefDescription": "Attributable Level 2 data TLB refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 2 data or unified TLB access",
+        "EventCode": "0x2F",
+        "EventName": "L2D_TLB",
+        "BriefDescription": "Attributable Level 2 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Access to another socket in a multi-socket system",
+        "EventCode": "0x31",
+        "EventName": "REMOTE_ACCESS",
+        "BriefDescription": "Access to another socket in a multi-socket system"
+    },
+    {
+        "PublicDescription": "Access to data TLB causes a translation table walk",
+        "EventCode": "0x34",
+        "EventName": "DTLB_WALK",
+        "BriefDescription": "Access to data TLB causes a translation table walk"
+    },
+    {
+        "PublicDescription": "Access to instruction TLB that causes a translation table walk",
+        "EventCode": "0x35",
+        "EventName": "ITLB_WALK",
+        "BriefDescription": "Access to instruction TLB that causes a translation table walk"
+    },
+    {
+        "PublicDescription": "Attributable Last level cache memory read"
+        "EventCode": "0x36",
+        "EventName": "LL_CACHE_RD",
+        "BriefDescription": "Attributable Last level cache memory read"
+    },
+    {
+        "PublicDescription": "Last level cache miss, read"
+        "EventCode": "0x37",
+        "EventName": "LL_CACHE_MISS_RD",
+        "BriefDescription": "Last level cache miss, read"
+    },
+]
-- 
2.26.2

