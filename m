Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775972C8B19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgK3RbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:31:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:3449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387528AbgK3RbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:31:03 -0500
IronPort-SDR: 2krms38pIwjQ0YSNaR7l5UQfdOWiqtmoObQ+mb1hKysHrSLu2ZzjV0ebWu+JomiPEVUfa6/cP+
 hhG1nl+uCFzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151926501"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151926501"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 09:29:00 -0800
IronPort-SDR: z1kkjqvxkHaP5R9BVfU2R9x6+ujYUdgPY+qS4DEXi8MEldC9vdXhEKxtv0HKiEZfx70eSLy7+O
 lM26opXy9yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334736297"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2020 09:29:00 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 02/12] perf record: Support new sample type for data page size
Date:   Mon, 30 Nov 2020 09:27:53 -0800
Message-Id: <20201130172803.2676-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.

Add new option --data-page-size to record sample data page size.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt  | 3 +++
 tools/perf/builtin-record.c               | 2 ++
 tools/perf/util/event.h                   | 1 +
 tools/perf/util/evsel.c                   | 9 +++++++++
 tools/perf/util/perf_event_attr_fprintf.c | 2 +-
 tools/perf/util/record.h                  | 1 +
 tools/perf/util/synthetic-events.c        | 8 ++++++++
 7 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 768888b9326a..e6605b2ecd55 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -293,6 +293,9 @@ OPTIONS
 --phys-data::
 	Record the sample physical addresses.
 
+--data-page-size::
+	Record the sampled data address data page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..29901f6a51bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2476,6 +2476,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
 	OPT_BOOLEAN(0, "phys-data", &record.opts.sample_phys_addr,
 		    "Record the sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
+		    "Record the sampled data address data page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b828b99176f4..448ac30c2fc4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -135,6 +135,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 data_page_size;
 	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cad6051d8b0..3190cb165183 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1190,6 +1190,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__set_sample_bit(evsel, CGROUP);
 	}
 
+	if (opts->sample_data_page_size)
+		evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -2365,6 +2368,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->data_page_size = 0;
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		data->data_page_size = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index e67a227c0ce7..fb0bb6684438 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 266760ac9143..694b351dcd27 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -22,6 +22,7 @@ struct record_opts {
 	bool	      raw_samples;
 	bool	      sample_address;
 	bool	      sample_phys_addr;
+	bool	      sample_data_page_size;
 	bool	      sample_weight;
 	bool	      sample_time;
 	bool	      sample_time_set;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8a23391558cf..0884a19f313b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1406,6 +1406,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_CGROUP)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1585,6 +1588,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		*array = sample->data_page_size;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
-- 
2.17.1

