Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F162EB3DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhAEUBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:01:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:12058 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbhAEUBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:01:35 -0500
IronPort-SDR: 5pd2d+qOnRUxTTffWUNRbiF6PA/g9UL4A0QQTeaaZqoH0+7w4lTIk0hrj8ROTF2I7ikUc4h3h7
 ZUM5iliUYvxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174594265"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="174594265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 11:58:32 -0800
IronPort-SDR: fWLClAzmvrJkRD55wcAbd/9euO+pNnJN9nNhIn7UULeeYu4wNMaO43aKeISOFLdM+o1WRwQoqR
 Dk1HE//X/PXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421901283"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 11:58:32 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 3/6] perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Tue,  5 Jan 2021 11:57:49 -0800
Message-Id: <20210105195752.43489-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105195752.43489-1-kan.liang@linux.intel.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Adds the infrastructure to sample the code address page size.

Introduce a new --code-page-size option for perf record.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Originally-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt  |  3 +++
 tools/perf/builtin-record.c               |  2 ++
 tools/perf/util/event.h                   |  1 +
 tools/perf/util/evsel.c                   | 18 +++++++++++++++++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/synthetic-events.c        |  8 ++++++++
 8 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 0042ff7f6f33..9087b223e324 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -296,6 +296,9 @@ OPTIONS
 --data-page-size::
 	Record the sampled data address data page size.
 
+--code-page-size::
+	Record the sampled code address (ip) page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7bb10e9863bd..7704c33bfe31 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2477,6 +2477,8 @@ static struct option __record_options[] = {
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
index dc0cfa5f2610..d1463d6c9336 100644
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
 
@@ -1875,7 +1878,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-        if (!perf_missing_features.data_page_size &&
+	if (!perf_missing_features.code_page_size &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
+		perf_missing_features.code_page_size = true;
+		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.data_page_size &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
 		perf_missing_features.data_page_size = true;
 		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
@@ -2371,6 +2379,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
@@ -2680,6 +2694,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 	"We found oprofile daemon running, please stop it and try again.");
 		break;
 	case EINVAL:
+		if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE && perf_missing_features.code_page_size)
+			return scnprintf(msg, size, "Asking for the code page size isn't supported by this kernel.");
 		if (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE && perf_missing_features.data_page_size)
 			return scnprintf(msg, size, "Asking for the data page size isn't supported by this kernel.");
 		if (evsel->core.attr.write_backward && perf_missing_features.write_backward)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd1d8dd43199..157d7c27d6e3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -145,6 +145,7 @@ struct perf_missing_features {
 	bool branch_hw_idx;
 	bool cgroup;
 	bool data_page_size;
+	bool code_page_size;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 22b417f43470..1bd6cfd74257 100644
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
index b996ce61fadd..68f471d9a88b 100644
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
index 69688f20db11..3a898520f05c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1473,6 +1473,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		result += sizeof(u64);
+
 	if (type & PERF_SAMPLE_AUX) {
 		result += sizeof(u64);
 		result += sample->aux_sample.size;
@@ -1657,6 +1660,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
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
2.25.1

