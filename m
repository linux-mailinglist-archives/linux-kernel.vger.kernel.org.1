Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46A27EAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgI3Oct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:32:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:42544 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3Ocs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:32:48 -0400
IronPort-SDR: 2rVbEPdIY2WU7PbKTjr1f1SAE4PS0ea1oLRzC3DWeCsBQfYyza5sb0KLDGgiomBfqkfR8GzPn5
 GK6zK55eoHHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="142470184"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="142470184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 07:32:48 -0700
IronPort-SDR: GG3YsJgu3sXZdvEOzP8vnRPd99f8P11Eqgd2TR0qwobegZimMUu66WO+U8Ru/iNnWrfz0Y4eiN
 7W2YTOFE4AhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="515098531"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by fmsmga005.fm.intel.com with ESMTP; 30 Sep 2020 07:32:47 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix n_metric for the canceled group
Date:   Wed, 30 Sep 2020 07:29:35 -0700
Message-Id: <20200930142935.13482-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When a group that has TopDown members is failed to be scheduled, any
later TopDown groups will not return valid values.

Here is an example.

A background perf that occupies all the GP counters and the fixed
counter 1.
 $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
                 cycles,cycles}:D" -a

A user monitors a TopDown group. It works well, because the fixed
counter 3 and the PERF_METRICS are available.
 $perf stat -x, --topdown -- ./workload
   retiring,bad speculation,frontend bound,backend bound,
   18.0,16.1,40.4,25.5,

Then the user tries to monitor a group that has TopDown members.
Because of the cycles event, the group is failed to be scheduled.
 $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
                     topdown-fe-bound,topdown-bad-spec,cycles}'
                     -- ./workload
    <not counted>,,slots,0,0.00,,
    <not counted>,,topdown-retiring,0,0.00,,
    <not counted>,,topdown-be-bound,0,0.00,,
    <not counted>,,topdown-fe-bound,0,0.00,,
    <not counted>,,topdown-bad-spec,0,0.00,,
    <not counted>,,cycles,0,0.00,,

The user tries to monitor a TopDown group again. It doesn't work anymore.
 $perf stat -x, --topdown -- ./workload

    ,,,,,

In a txn, cancel_txn() is to truncate the event_list for a canceled
group and update the number of events added in this transaction.
However, the number of TopDown events added in this transaction is not
updated. The kernel will probably fail to add new Topdown events.

Check if the canceled group has Topdown events. If so, subtract the
TopDown events from n_metric accordingly.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0f3d01562ded..4cb3ccbe2d62 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2017,6 +2017,7 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 {
 	unsigned int txn_flags;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
 
 	WARN_ON_ONCE(!cpuc->txn_flags);	/* no txn in flight */
 
@@ -2031,6 +2032,15 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 	 */
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
+
+	/* Subtract Topdown events in the canceled group from n_metric */
+	if (x86_pmu.intel_cap.perf_metrics && cpuc->n_metric) {
+		for (i = 0; i < cpuc->n_txn; i++) {
+			if (is_metric_event(cpuc->event_list[i + cpuc->n_events]))
+				__this_cpu_dec(cpu_hw_events.n_metric);
+		}
+		WARN_ON_ONCE(__this_cpu_read(cpu_hw_events.n_metric) < 0);
+	}
 	perf_pmu_enable(pmu);
 }
 
-- 
2.17.1

