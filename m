Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF042A9F18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgKFVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:31:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:22692 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbgKFVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:31:12 -0500
IronPort-SDR: vNe7jyWpul8sO7FbdokONBjy3rq7FXEivY75UuUnpSx6znjfQhxpC20fIXbJsR4rwid/M+oLUg
 pJEqU7HRq4Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="254311013"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="254311013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 13:31:11 -0800
IronPort-SDR: Hi0nkYd7s31ULTUspQiYweq+XD4Q+bc/ziUURBvhfhN2WuhNKGkxRW+ogU6pXYAf9g1FgWjv9x
 zIlW+A4l0vnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="337697738"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2020 13:31:11 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/3] perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large PEBS
Date:   Fri,  6 Nov 2020 13:29:34 -0800
Message-Id: <20201106212935.28943-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106212935.28943-1-kan.liang@linux.intel.com>
References: <20201106212935.28943-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To supply a PID/TID for large PEBS, it requires flushing the PEBS buffer
in a context switch.

Set PERF_ATTACH_SCHED_CB for the event with large PEBS.

Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c79748f6921d..fe922be94b6d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3565,8 +3565,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
-- 
2.17.1

