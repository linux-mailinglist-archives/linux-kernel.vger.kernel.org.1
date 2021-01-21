Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6063D2FEC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbhAUOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:05:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:15529 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbhAUOFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:05:15 -0500
IronPort-SDR: trkLDEy6ZyshJE6KJzsgj3cdpmlvHY5iRJZ0GMFUfJGjnq3F9cZ2Lx3Jz0HNDcI05fVYZnKjDl
 TZkGFvsyBZvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="198008803"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="198008803"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 06:04:14 -0800
IronPort-SDR: bUnefDbu9ylWHGHb3rbC3Q00oXM8Z5Asw+lIx2qhuhZ9X7wrB1bAjeqF7PYUVjteD2JCwjp266
 cjurINTo6fsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="571707934"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2021 06:04:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf auxtrace: Automatically group aux-output events
Date:   Thu, 21 Jan 2021 16:04:18 +0200
Message-Id: <20210121140418.14705-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aux-output events need to have an AUX area event as the group leader.
However, grouping events does not allow the AUX area event to be given
an address filter because the --filter option must come after the event,
which conflicts with the grouping syntax.

To allow filtering in that case, automatically create a group since that
is the requirement anyway.

Example: (requires Intel Tremont)

  perf record -c 500 -e 'intel_pt//u' --filter 'filter main @ /bin/ls' -e 'cycles/aux-output/pp' ls

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/util/auxtrace.c  | 15 +++++++++++++++
 tools/perf/util/auxtrace.h  |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8a0127d4fb52..687f1449a845 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -731,6 +731,8 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
+	auxtrace_regroup_aux_output(rec->evlist);
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index a60878498139..953f4afacd3b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -788,6 +788,21 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	return auxtrace_validate_aux_sample_size(evlist, opts);
 }
 
+void auxtrace_regroup_aux_output(struct evlist *evlist)
+{
+	struct evsel *evsel, *aux_evsel = NULL;
+	struct evsel_config_term *term;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel))
+			aux_evsel = evsel;
+		term = evsel__get_config_term(evsel, AUX_OUTPUT);
+		/* If possible, group with the AUX event */
+		if (term && aux_evsel)
+			evlist__regroup(evlist, aux_evsel, evsel);
+	}
+}
+
 struct auxtrace_record *__weak
 auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 7e5c9e1552bd..a4fbb33b7245 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -559,6 +559,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 				  struct evlist *evlist,
 				  struct record_opts *opts, const char *str);
+void auxtrace_regroup_aux_output(struct evlist *evlist);
 int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts);
@@ -740,6 +741,11 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
 	return -EINVAL;
 }
 
+static inline
+void auxtrace_regroup_aux_output(struct evlist *evlist __maybe_unused)
+{
+}
+
 static inline
 int auxtrace__process_event(struct perf_session *session __maybe_unused,
 			    union perf_event *event __maybe_unused,
-- 
2.17.1

