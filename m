Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90242FC17A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbhASUp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:45:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:26412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbhASUn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:43:56 -0500
IronPort-SDR: nfN4aBw0OfWaAX6nuppp8U2uBOXv3lJZbbOFLdT6XsWsVHIHZ+G0d29q2BPYWS2Zq1JY4p+cY0
 qzaVfQDgDPyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064926"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064926"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:02 -0800
IronPort-SDR: 4MSVm10axK5OiaJrZ1c9NkGwWb6ZQDm+Moa1qfWb0RCnekOlxmcfkvFyHU3Wjrp5OS6rkTIwhv
 9oiJkooX5r4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990782"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:02 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/12] perf/core: Add PERF_SAMPLE_WEIGHT_EXT
Date:   Tue, 19 Jan 2021 12:38:20 -0800
Message-Id: <1611088711-17177-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current PERF_SAMPLE_WEIGHT sample type is very useful to expresses the
cost of an action represented by the sample. This allows the profiler
to scale the samples to be more informative to the programmer. It could
also help to locate a hotspot, e.g., when profiling by memory latencies,
the expensive load appear higher up in the histograms. But current
PERF_SAMPLE_WEIGHT sample type is solely determined by one factor. This
could be a problem, if users want two or more factors to contribute to
the weight. For example, Golden Cove core PMU can provide both the
instruction latency and the cache Latency information as factors for the
memory profiling.

Add a new sample type, PERF_SAMPLE_WEIGHT_EXT, as an extension of the
PERF_SAMPLE_WEIGHT sample type.

The first 16-bit is used as the weight value for the instruction
latency, defined by the delay measured between the dispatch of an
instruction for execution and its completion. This is quite generic and
can be extended to other kinds of architectures, as long as the hardware
provides suitable values. Other fields are reserved for future usage.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h | 18 +++++++++++++++++-
 kernel/events/core.c            |  6 ++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f57..005b6b8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1030,6 +1030,7 @@ struct perf_sample_data {
 	u64				cgroup;
 	u64				data_page_size;
 	u64				code_page_size;
+	union perf_weight_ext		weight_ext;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e344..d0129e5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -145,8 +145,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
+	PERF_SAMPLE_WEIGHT_EXT			= 1U << 24,
 
-	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -900,6 +901,13 @@ enum perf_event_type {
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ union {
+	 *		u64		weight_ext;
+	 *		struct {
+	 *			u64	instr_latency:16,
+	 *				reserved:48;
+	 *		};
+	 *	} && PERF_SAMPLE_WEIGHT_EXT
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1248,4 +1256,12 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+union perf_weight_ext {
+	__u64		val;
+	struct {
+		__u64	instr_latency:16,
+			reserved:48;
+	};
+};
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d1879..9363d12 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1903,6 +1903,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		size += sizeof(data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
+		size += sizeof(data->weight_ext);
+
 	event->header_size = size;
 }
 
@@ -6952,6 +6955,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type & PERF_SAMPLE_WEIGHT_EXT)
+		perf_output_put(handle, data->weight_ext);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
-- 
2.7.4

