Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E0304820
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbhAZFuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:50:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11154 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbhAYMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:19:34 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPSxv236qz15yFW;
        Mon, 25 Jan 2021 19:56:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 19:57:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kjain@linux.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        <james.clark@arm.com>, <nakamura.shun@jp.fujitsu.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/4] perf vendor events arm64: Fix Ampere eMag event typo
Date:   Mon, 25 Jan 2021 19:53:17 +0800
Message-ID: <1611575600-2440-2-git-send-email-john.garry@huawei.com>
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

The "briefdescription" for event 0x35 has a typo - fix it.

Fixes: d35c595bf005 ("perf vendor events arm64: Revise core JSON events for eMAG")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
index 40010a8724b3..ce6e7e796057 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -114,7 +114,7 @@
         "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
         "EventCode": "0x35",
         "EventName": "L2I_TLB_ACCESS",
-        "BriefDescription": "L2D TLB access"
+        "BriefDescription": "L2I TLB access"
     },
     {
         "PublicDescription": "Branch target buffer misprediction",
-- 
2.26.2

