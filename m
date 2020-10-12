Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF69728AD78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgJLFDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:03:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgJLFDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:03:31 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C520v5192134;
        Mon, 12 Oct 2020 01:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iKQf7LdQvJn0ZeNWL4eaEdmrKfzGXTrvZDDocgTXJPg=;
 b=pdpJMRHx/8c7WHcoyOy4OXAM6b72ri4fsihYZ7YQo5tjcTbSS5kFOJRZfSY55/AT6u8x
 y4eONkaAnlS6vgk1TQI0mo3HonMfzpcaIhJDxwW6yXwSjI2zuQK7/37oKlwEyUinTJuS
 Yqx0Ee7Cc8GZGBBwLSsrGRzSMalzCClq5oxV1jcCQLXFzs/5zyuWm8l83mWzMCmzsMyD
 bENLSF7ce+yTlxcpulv0Cxr2K9AJOX2Ss9CfJXU7USaGUvHobYV+uidOr55e+Ew74NE7
 m+nhZSAPF3ifqVGysntmxD8tdiznXjASg68A0zhKxCVDYzV2OeoPJCqmY8QXsHIi3bct Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344g6d0gu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 01:03:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09C5396D195031;
        Mon, 12 Oct 2020 01:03:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344g6d0g51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 01:03:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09C52BBW020774;
        Mon, 12 Oct 2020 05:02:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3434k7sn92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 05:02:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09C528Gm32047432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 05:02:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EA6CAE05F;
        Mon, 12 Oct 2020 05:02:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92DFBAE056;
        Mon, 12 Oct 2020 05:02:06 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Oct 2020 05:02:06 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        jolsa@redhat.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf vendor events: Fix typos in power8 PMU events
Date:   Mon, 12 Oct 2020 10:32:05 +0530
Message-Id: <20201012050205.328523-1-sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_02:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 suspectscore=1 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces the incorrectly spelled word "localtion"
with "location" in some power8 PMU event descriptions.

Fixes: 2a81fa3bb5ed ("perf vendor events: Add power8 PMU events")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 .../pmu-events/arch/powerpc/power8/cache.json    | 10 +++++-----
 .../pmu-events/arch/powerpc/power8/frontend.json | 12 ++++++------
 .../pmu-events/arch/powerpc/power8/marked.json   | 10 +++++-----
 .../pmu-events/arch/powerpc/power8/other.json    | 16 ++++++++--------
 .../arch/powerpc/power8/translation.json         |  2 +-
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/cache.json b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
index 6b792b2c87e2..05a17084d939 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
@@ -32,8 +32,8 @@
   {
     "EventCode": "0x1c04e",
     "EventName": "PM_DATA_FROM_L2MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to a demand load",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to a demand load",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x3c040",
@@ -74,8 +74,8 @@
   {
     "EventCode": "0x4c04e",
     "EventName": "PM_DATA_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a demand load",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a demand load",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x3c042",
@@ -134,7 +134,7 @@
   {
     "EventCode": "0x4e04e",
     "EventName": "PM_DPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a data side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
index 1ddc30655d43..1c902a8263b6 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
@@ -116,8 +116,8 @@
   {
     "EventCode": "0x1404e",
     "EventName": "PM_INST_FROM_L2MISS",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to an instruction fetch (not prefetch)",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to an instruction fetch (not prefetch)",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x34040",
@@ -158,8 +158,8 @@
   {
     "EventCode": "0x4404e",
     "EventName": "PM_INST_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x34042",
@@ -320,7 +320,7 @@
   {
     "EventCode": "0x1504e",
     "EventName": "PM_IPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a instruction side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a instruction side request",
     "PublicDescription": ""
   },
   {
@@ -344,7 +344,7 @@
   {
     "EventCode": "0x4504e",
     "EventName": "PM_IPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a instruction side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a instruction side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/marked.json b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
index 94dc58b83b7e..6de61a797bbd 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
@@ -92,7 +92,7 @@
   {
     "EventCode": "0x4c12e",
     "EventName": "PM_MRK_DATA_FROM_L2MISS_CYC",
-    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L2 due to a marked load",
+    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L2 due to a marked load",
     "PublicDescription": ""
   },
   {
@@ -158,13 +158,13 @@
   {
     "EventCode": "0x201e4",
     "EventName": "PM_MRK_DATA_FROM_L3MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a marked load",
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
   {
     "EventCode": "0x2d12e",
     "EventName": "PM_MRK_DATA_FROM_L3MISS_CYC",
-    "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L3 due to a marked load",
+    "BriefDescription": "Duration in cycles to reload from a location other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
   {
@@ -392,7 +392,7 @@
   {
     "EventCode": "0x1f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a marked data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a marked data side request",
     "PublicDescription": ""
   },
   {
@@ -416,7 +416,7 @@
   {
     "EventCode": "0x4f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L3MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a marked data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a marked data side request",
     "PublicDescription": ""
   },
   {
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index f4e760cab111..84a0cedf1fd9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -410,8 +410,8 @@
   {
     "EventCode": "0x61c04e",
     "EventName": "PM_DATA_ALL_FROM_L2MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either demand loads or data prefetch",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either demand loads or data prefetch",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x63c040",
@@ -470,8 +470,8 @@
   {
     "EventCode": "0x64c04e",
     "EventName": "PM_DATA_ALL_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either demand loads or data prefetch",
-    "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
+    "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either demand loads or data prefetch",
+    "PublicDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
   {
     "EventCode": "0x63c042",
@@ -1280,8 +1280,8 @@
   {
     "EventCode": "0x51404e",
     "EventName": "PM_INST_ALL_FROM_L2MISS",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to instruction fetches and prefetches",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to instruction fetches and prefetches",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x534040",
@@ -1340,8 +1340,8 @@
   {
     "EventCode": "0x54404e",
     "EventName": "PM_INST_ALL_FROM_L3MISS_MOD",
-    "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
-    "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
+    "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch",
+    "PublicDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
   {
     "EventCode": "0x534042",
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/translation.json b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
index 623e7475b010..a1657f5fdc6b 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
@@ -44,7 +44,7 @@
   {
     "EventCode": "0x1e04e",
     "EventName": "PM_DPTEG_FROM_L2MISS",
-    "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a data side request",
+    "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a data side request",
     "PublicDescription": ""
   },
   {
-- 
2.25.1

