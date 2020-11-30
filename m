Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB502C8B33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgK3Re1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:34:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:3528 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbgK3Re0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:34:26 -0500
IronPort-SDR: oSwhgyR3xxMNOalJG57tux9hXIQivX4YoUHvFqLUT9Bzz8Vd6ZuSufTsj1f0DN9JXcjgPFITEK
 2NVi1Bd3F8Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151926529"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151926529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 09:29:08 -0800
IronPort-SDR: gH6NeupBmcbVQzlempVXtolofgouJ/K3Znmqf+qrT37PGjl82PwdQobwxXy6OZDCbhmyotD/iy
 6oKD6qaf8MvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334736333"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2020 09:29:08 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au
Subject: [PATCH V2 09/12] perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 30 Nov 2020 09:28:00 -0800
Message-Id: <20201130172803.2676-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Adds the infrastructure to sample the code address page size.

Introduce a new --code-page-size option for perf record.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Stephane Eranian <eranian@google.com>
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
index e6605b2ecd55..4d1531289124 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -296,6 +296,9 @@ OPTIONS
 --data-page-size::
 	Record the sampled data address data page size
 
+--code-page-size::
+	Record the sampled code address (ip) page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 29901f6a51bb..50c2593623e3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2478,6 +2478,8 @@ static struct option __record_options[] = {
 		    "Record the sample physical addresses"),
 	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
 		    "Record the sampled data address data page size"),
+	OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
+		    "Record the sampled code address (ip) page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ff403ea578e1..2afea7247dd3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -136,6 +136,7 @@ struct perf_sample {
 	u64 data_src;
 	u64 phys_addr;
 	u64 data_page_size;
+	u64 code_page_size;
 	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3190cb165183..806b39b7988d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1193,6 +1193,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->sample_data_page_size)
 		evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
 
+	if (opts->sample_code_page_size)
+		evsel__set_sample_bit(evsel, CODE_PAGE_SIZE);
+
 	if (opts->record_switch_events)
 		attr->context_switch = track;
 
@@ -2374,6 +2377,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->code_page_size = 0;
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		data->code_page_size = *array;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		OVERFLOW_CHECK_u64(array);
 		sz = *array++;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index fb0bb6684438..3a2eb25d07a7 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 694b351dcd27..22dc86b1dab5 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -23,6 +23,7 @@ struct record_opts {
 	bool	      sample_address;
 	bool	      sample_phys_addr;
 	bool	      sample_data_page_size;
+	bool	      sample_code_page_size;
 	bool	      sample_weight;
 	bool	      sample_time;
 	bool	      sample_time_set;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0884a19f313b..81bc174f83f3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1409,6 +1409,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1593,6 +1596,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		*array = sample->code_page_size;
+		array++;
+	}
+
 	if (type & PERF_SAMPLE_AUX) {
 		sz = sample->aux_sample.size;
 		*array++ = sz;
-- 
2.17.1

