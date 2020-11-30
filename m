Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1362C8E45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgK3Tko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:40:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:56584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbgK3Tko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:44 -0500
IronPort-SDR: wZ4IR5zjX7eIQZrAV9QdjL6SFDq6ENiQhfuieJHCuvPppSSEWfhhcpizFc1Nv/KuT8bLxo3RaD
 7WGugXOkyl+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170134964"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170134964"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:39:03 -0800
IronPort-SDR: RUp1T01X4j+GNbMhvYxj8V1/A6nW0WJQtgg5+4+JgeqUWZwLw0Xl+/8g7F978yLz8/AgmMDeCm
 RGYmDSeQnybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480781843"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 11:39:03 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/3] perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large PEBS and LBR
Date:   Mon, 30 Nov 2020 11:38:41 -0800
Message-Id: <20201130193842.10569-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130193842.10569-1-kan.liang@linux.intel.com>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To supply a PID/TID for large PEBS, it requires flushing the PEBS buffer
in a context switch.

For normal LBRs, a context switch can flip the address space and LBR
entries are not tagged with an identifier, we need to wipe the LBR, even
for per-cpu events.

For LBR callstack, save/restore the stack is required during a context
switch.

Set PERF_ATTACH_SCHED_CB for the event with large PEBS & LBR.

Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1
- Set PERF_ATTACH_SCHED_CB for a LBR event as well

 arch/x86/events/intel/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f1926e9f2143..534e0c84f7f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3564,8 +3564,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (!(event->attr.freq || (event->attr.wakeup_events && !event->attr.watermark))) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
-			      ~intel_pmu_large_pebs_flags(event)))
+			      ~intel_pmu_large_pebs_flags(event))) {
 				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
+				event->attach_state |= PERF_ATTACH_SCHED_CB;
+			}
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
@@ -3578,6 +3580,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
 			return ret;
+		event->attach_state |= PERF_ATTACH_SCHED_CB;
 
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
-- 
2.17.1

