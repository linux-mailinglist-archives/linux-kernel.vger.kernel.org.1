Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365D02FE88E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbhAULK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:10:57 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:3551 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730197AbhAULHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:07:52 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 06:07:50 EST
IronPort-SDR: 2zjCDqhwvpgPITSWngxyWzleCwTvc8tmgzE9nnYv2QkCs75O6Cs30JfLUhedtf5hHrsyzyGKSm
 gXvc/mQL1DXRxVsOe1Sg4+zYlauuzIO7/vaYQRZMpiIX92XYAzrAOjOC6BxA5c6hRTGHWFg7D0
 JW7teDdP7Y2O7aOiaKOrd/uZFo+MsfQkEs27zplGFeB7AQ3X33UnxUtfg+zHmXwx0Ikn6l3PPj
 rF7TRWrNFotVsF0P9Jusvlw7KoYcZ4NRNhMSuYyLEj4C6eZ5AV3c7jH7rfu7po8tlCQcbLPOtG
 Zk0=
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="15977617"
X-IronPort-AV: E=Sophos;i="5.79,363,1602514800"; 
   d="scan'208";a="15977617"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 21 Jan 2021 20:00:15 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E30BEC7E7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EE2256F80
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:12 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 5CEC012CC; Thu, 21 Jan 2021 19:54:25 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v2 1/3] perf vendor events: Add cache refill and DCZVA events
Date:   Thu, 21 Jan 2021 19:54:23 +0900
Message-Id: <20210121105425.2695843-2-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
References: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds L1 data cache refill prefetch, L2 data cache refill prefetch, 
and DCZVA instruction events.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
---
 .../perf/pmu-events/arch/arm64/armv8-recommended.json  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
index d0a1986..ee0e67d 100644
--- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
+++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
@@ -54,6 +54,12 @@
         "BriefDescription": "L1D cache invalidate"
     },
     {
+        "PublicDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch.",
+        "EventCode": "0x49",
+        "EventName": "L1D_CACHE_REFILL_PRF",
+        "BriefDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch."
+    },
+    {
         "PublicDescription": "Attributable Level 1 data TLB refill, read",
         "EventCode": "0x4C",
         "EventName": "L1D_TLB_REFILL_RD",
@@ -120,6 +126,12 @@
         "BriefDescription": "L2D cache invalidate"
     },
     {
+        "PublicDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch.",
+        "EventCode": "0x59",
+        "EventName": "L2D_CACHE_REFILL_PRF",
+        "BriefDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch."
+    },
+    {
         "PublicDescription": "Attributable Level 2 data or unified TLB refill, read",
         "EventCode": "0x5c",
         "EventName": "L2D_TLB_REFILL_RD",
@@ -408,6 +420,12 @@
         "BriefDescription": "Release consistency operation speculatively executed, Store-Release"
    },
    {
+         "PublicDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction.",
+         "EventCode": "0x9f",
+         "EventName": "DCZVA_SPEC",
+         "BriefDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction."
+   },
+   {
         "PublicDescription": "Attributable Level 3 data or unified cache access, read",
         "EventCode": "0xa0",
         "EventName": "L3D_CACHE_RD",
-- 
1.8.3.1

