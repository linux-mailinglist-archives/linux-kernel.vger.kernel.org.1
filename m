Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91902C4DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbgKZDZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:25:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:4721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733292AbgKZDZe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:25:34 -0500
IronPort-SDR: c/zNtjc8WxEaTX19DpOvQ5STsNpIx6XmAExC38C2y7bmyzwTVZ3FAwSbKQsx7Yr9uCj6zjZSmJ
 qLYuL4S/uH0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="152066049"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="152066049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:25:34 -0800
IronPort-SDR: 0p0zQFnp/nV4sdpeR8GknjgIF+cjyfePjt8MaCBrnejL5ilpP9gLazIPRWaPRhjGqfG0WvCAI7
 VFrCPPRPYs9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="362650725"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2020 19:25:31 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, drian.hunter@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf script: Fix overrun issue for dynamically-allocated pmu type number
Date:   Thu, 26 Nov 2020 11:24:25 +0800
Message-Id: <20201126032425.19226-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unpacking the event which is from dynamic pmu, the array
output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
PERF_TYPE_MAX + 1).

/* In builtin-script.c */
process_event()
{
	unsigned int type = output_type(attr->type);

	if (output[type].fields == 0)
		return;
}

output[10] is overrun.

Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
output_type(attr->type) will return OUTPUT_TYPE_OTHER here.

Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
between old perf.data files that had a dynamicaliy allocated PMU number
that would then be the same as a fixed PERF_TYPE.

Example:

perf record --switch-events -C 0 -e "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a -- sleep 1
perf script

Before:
         swapper     0 [000] 1479253.987551:     277766               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.987797:     246709               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.988127:     329883               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.988273:     146393               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.988523:     249977               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.988877:     354090               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.989023:     145940               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.989383:     359856               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1479253.989523:     140082               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])

After:
         swapper     0 [000] 1397040.402011:     272384               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1397040.402011:       5396  uncore_imc/data_reads/:
         swapper     0 [000] 1397040.402011:        967 uncore_imc/data_writes/:
         swapper     0 [000] 1397040.402259:     249153               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1397040.402259:       7231  uncore_imc/data_reads/:
         swapper     0 [000] 1397040.402259:       1297 uncore_imc/data_writes/:
         swapper     0 [000] 1397040.402508:     249108               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
         swapper     0 [000] 1397040.402508:       5333  uncore_imc/data_reads/:
         swapper     0 [000] 1397040.402508:       1008 uncore_imc/data_writes/:

Fixes: 1405720d4f26 ("perf script: Add 'synth' event type for synthesized events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-script.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 48588ccf902e..d68684fb9b53 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -183,6 +183,7 @@ struct output_option {
 
 enum {
 	OUTPUT_TYPE_SYNTH = PERF_TYPE_MAX,
+	OUTPUT_TYPE_OTHER,
 	OUTPUT_TYPE_MAX
 };
 
@@ -279,6 +280,18 @@ static struct {
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
+
+	[OUTPUT_TYPE_OTHER] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
 };
 
 struct evsel_script {
@@ -339,8 +352,11 @@ static inline int output_type(unsigned int type)
 	case PERF_TYPE_SYNTH:
 		return OUTPUT_TYPE_SYNTH;
 	default:
-		return type;
+		if (type < PERF_TYPE_MAX)
+			return type;
 	}
+
+	return OUTPUT_TYPE_OTHER;
 }
 
 static inline unsigned int attr_type(unsigned int type)
-- 
2.17.1

