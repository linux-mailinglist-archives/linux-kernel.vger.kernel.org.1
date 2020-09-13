Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE14268156
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgIMVHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:07:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725979AbgIMVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:07:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-z4vsygBsNESlJJ56zBzIlw-1; Sun, 13 Sep 2020 17:05:25 -0400
X-MC-Unique: z4vsygBsNESlJJ56zBzIlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9F3634914;
        Sun, 13 Sep 2020 21:05:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ABE410021AA;
        Sun, 13 Sep 2020 21:05:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 26/26] perf tools: Add report --store option
Date:   Sun, 13 Sep 2020 23:03:13 +0200
Message-Id: <20200913210313.1985612-27-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding report --store option as a wrapper for 'buildid-list --store'
to save some typing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  3 +++
 tools/perf/builtin-report.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index d068103690cc..698fe90d6e1d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -548,6 +548,9 @@ include::itrace.txt[]
 	Configure time quantum for time sort key. Default 100ms.
 	Accepts s, us, ms, ns units.
 
+--store::
+	Store build id DSOs in .debug cache. See `--store` option n perf-buildid-list.
+
 --total-cycles::
 	When --total-cycles is specified, it supports sorting for all blocks by
 	'Sampled Cycles%'. This is useful to concentrate on the globally hottest
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3dd37513eb94..3450e441d894 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1098,6 +1098,18 @@ static int process_attr(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int build_id_store(const char *file)
+{
+	const char *argv[4];
+
+	argv[0] = "buildid-list";
+	argv[1] = "-i";
+	argv[2] = file;
+	argv[3] = "--store";
+
+	return cmd_buildid_list(4, argv);
+}
+
 int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
@@ -1107,6 +1119,7 @@ int cmd_report(int argc, const char **argv)
 	int branch_mode = -1;
 	int last_key = 0;
 	bool branch_call_mode = false;
+	bool store = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
 						    CALLCHAIN_REPORT_HELP
@@ -1301,6 +1314,7 @@ int cmd_report(int argc, const char **argv)
 	OPTS_EVSWITCH(&report.evswitch),
 	OPT_BOOLEAN(0, "total-cycles", &report.total_cycles_mode,
 		    "Sort all blocks by 'Sampled Cycles%'"),
+	OPT_BOOLEAN(0, "store", &store, "Store build id dsos in .debug cache"),
 	OPT_END()
 	};
 	struct perf_data data = {
@@ -1367,6 +1381,9 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+	if (store)
+		return build_id_store(input_name);
+
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-- 
2.26.2

