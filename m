Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E157B22B440
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgGWRLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:11:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:6574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgGWRLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:41 -0400
IronPort-SDR: /FyRFpAbDxz4lsY3Vx4OKoIa+BRDxvFRoHasHcXoiIcegR1SVJ1y7FZVs3at6THFj2tTSPvhSv
 8IoNx8ar4Edg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456660"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:40 -0700
IronPort-SDR: 9ZC19q4qYi6Cwpjm9MDUUhvhEf4DoMIJcRqJdsfWvj9uQ1y/xBkypZ4QbHWd+NLDMgz7hzgJPm
 /AR43n95bTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904231"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 01/14] perf/x86: Use event_base_rdpmc for the RDPMC userspace support
Date:   Thu, 23 Jul 2020 10:11:04 -0700
Message-Id: <20200723171117.9918-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The RDPMC index is always re-calculated for the RDPMC userspace support,
which is unnecessary.

The RDPMC index value is stored in the variable event_base_rdpmc for
the kernel usage, which can be used for RDPMC userspace support as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57dc2ac8..8e108ea378e3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2208,17 +2208,12 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 
 static int x86_pmu_event_idx(struct perf_event *event)
 {
-	int idx = event->hw.idx;
+	struct hw_perf_event *hwc = &event->hw;
 
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
-	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
-		idx -= INTEL_PMC_IDX_FIXED;
-		idx |= 1 << 30;
-	}
-
-	return idx + 1;
+	return hwc->event_base_rdpmc + 1;
 }
 
 static ssize_t get_attr_rdpmc(struct device *cdev,
-- 
2.17.1

