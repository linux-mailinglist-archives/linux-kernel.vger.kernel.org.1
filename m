Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCC268144
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgIMVEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgIMVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-LUpQ8VGgMDi6pPSNbV-hQw-1; Sun, 13 Sep 2020 17:04:22 -0400
X-MC-Unique: LUpQ8VGgMDi6pPSNbV-hQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B08E801AAE;
        Sun, 13 Sep 2020 21:04:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACBE910021AA;
        Sun, 13 Sep 2020 21:04:16 +0000 (UTC)
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
Subject: [PATCH 13/26] perf tools: Plug in mmap3 event
Date:   Sun, 13 Sep 2020 23:03:00 +0200
Message-Id: <20200913210313.1985612-14-jolsa@kernel.org>
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

Add mmap3 event processing to all perf tools that process
events and let them call the perf_event__process_mmap3
function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-annotate.c     |  1 +
 tools/perf/builtin-c2c.c          |  1 +
 tools/perf/builtin-diff.c         |  1 +
 tools/perf/builtin-inject.c       | 38 +++++++++++++++++++++++++++++++
 tools/perf/builtin-kmem.c         |  1 +
 tools/perf/builtin-mem.c          |  1 +
 tools/perf/builtin-record.c       | 14 ++++++++++++
 tools/perf/builtin-report.c       |  2 ++
 tools/perf/builtin-script.c       |  1 +
 tools/perf/builtin-trace.c        |  1 +
 tools/perf/util/build-id.c        |  1 +
 tools/perf/util/data-convert-bt.c |  1 +
 12 files changed, 63 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4940d10074c3..f68e86bfeb3b 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -474,6 +474,7 @@ int cmd_annotate(int argc, const char **argv)
 			.sample	= process_sample_event,
 			.mmap	= perf_event__process_mmap,
 			.mmap2	= perf_event__process_mmap2,
+			.mmap3	= perf_event__process_mmap3,
 			.comm	= perf_event__process_comm,
 			.exit	= perf_event__process_exit,
 			.fork	= perf_event__process_fork,
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5938b100eaf4..a7d1061fde98 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -365,6 +365,7 @@ static struct perf_c2c c2c = {
 		.sample		= process_sample_event,
 		.mmap		= perf_event__process_mmap,
 		.mmap2		= perf_event__process_mmap2,
+		.mmap3		= perf_event__process_mmap3,
 		.comm		= perf_event__process_comm,
 		.exit		= perf_event__process_exit,
 		.fork		= perf_event__process_fork,
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8c9bdd8269a..f8c77fe8f7a4 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -450,6 +450,7 @@ static struct perf_diff pdiff = {
 		.sample	= diff__process_sample_event,
 		.mmap	= perf_event__process_mmap,
 		.mmap2	= perf_event__process_mmap2,
+		.mmap3	= perf_event__process_mmap3,
 		.comm	= perf_event__process_comm,
 		.exit	= perf_event__process_exit,
 		.fork	= perf_event__process_fork,
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6d2f410d773a..ef31603d126e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -316,6 +316,19 @@ static int perf_event__repipe_mmap2(struct perf_tool *tool,
 	return err;
 }
 
+static int perf_event__repipe_mmap3(struct perf_tool *tool,
+				   union perf_event *event,
+				   struct perf_sample *sample,
+				   struct machine *machine)
+{
+	int err;
+
+	err = perf_event__process_mmap3(tool, event, sample, machine);
+	perf_event__repipe(tool, event, sample, machine);
+
+	return err;
+}
+
 #ifdef HAVE_JITDUMP
 static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 					union perf_event *event,
@@ -339,6 +352,29 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 	}
 	return perf_event__repipe_mmap2(tool, event, sample, machine);
 }
+
+static int perf_event__jit_repipe_mmap3(struct perf_tool *tool,
+					union perf_event *event,
+					struct perf_sample *sample,
+					struct machine *machine)
+{
+	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
+	u64 n = 0;
+	int ret;
+
+	/*
+	 * if jit marker, then inject jit mmaps and generate ELF images
+	 */
+	ret = jit_process(inject->session, &inject->output, machine,
+			  event->mmap3.filename, sample->pid, &n);
+	if (ret < 0)
+		return ret;
+	if (ret) {
+		inject->bytes_written += n;
+		return 0;
+	}
+	return perf_event__repipe_mmap3(tool, event, sample, machine);
+}
 #endif
 
 static int perf_event__repipe_fork(struct perf_tool *tool,
@@ -609,6 +645,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	    inject->itrace_synth_opts.set) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
+		inject->tool.mmap3	  = perf_event__repipe_mmap3;
 		inject->tool.fork	  = perf_event__repipe_fork;
 		inject->tool.tracing_data = perf_event__repipe_tracing_data;
 	}
@@ -818,6 +855,7 @@ int cmd_inject(int argc, const char **argv)
 #ifdef HAVE_JITDUMP
 	if (inject.jit_mode) {
 		inject.tool.mmap2	   = perf_event__jit_repipe_mmap2;
+		inject.tool.mmap3	   = perf_event__jit_repipe_mmap3;
 		inject.tool.mmap	   = perf_event__jit_repipe_mmap;
 		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a50dae2c4ae9..59f7fe42cb09 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -969,6 +969,7 @@ static struct perf_tool perf_kmem = {
 	.comm		 = perf_event__process_comm,
 	.mmap		 = perf_event__process_mmap,
 	.mmap2		 = perf_event__process_mmap2,
+	.mmap3		 = perf_event__process_mmap3,
 	.namespaces	 = perf_event__process_namespaces,
 	.ordered_events	 = true,
 };
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..7be8b4d6f2c9 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -383,6 +383,7 @@ int cmd_mem(int argc, const char **argv)
 			.sample		= process_sample_event,
 			.mmap		= perf_event__process_mmap,
 			.mmap2		= perf_event__process_mmap2,
+			.mmap3		= perf_event__process_mmap3,
 			.comm		= perf_event__process_comm,
 			.lost		= perf_event__process_lost,
 			.fork		= perf_event__process_fork,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..5ce293fac103 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2366,6 +2366,19 @@ static int build_id__process_mmap2(struct perf_tool *tool, union perf_event *eve
 	return perf_event__process_mmap2(tool, event, sample, machine);
 }
 
+static int build_id__process_mmap3(struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine)
+{
+	/*
+	 * We already have the kernel maps, put in place via perf_session__create_kernel_maps()
+	 * no need to add them twice.
+	 */
+	if (!(event->header.misc & PERF_RECORD_MISC_USER))
+		return 0;
+
+	return perf_event__process_mmap3(tool, event, sample, machine);
+}
+
 /*
  * XXX Ideally would be local to cmd_record() and passed to a record__new
  * because we need to have access to it in record__exit, that is called
@@ -2400,6 +2413,7 @@ static struct record record = {
 		.namespaces	= perf_event__process_namespaces,
 		.mmap		= build_id__process_mmap,
 		.mmap2		= build_id__process_mmap2,
+		.mmap3		= build_id__process_mmap3,
 		.ordered_events	= true,
 	},
 };
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3c74c9c0f3c3..3dd37513eb94 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -731,6 +731,7 @@ static void tasks_setup(struct report *rep)
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
+		rep->tool.mmap3 = perf_event__process_mmap3;
 	}
 	rep->tool.comm = perf_event__process_comm;
 	rep->tool.exit = perf_event__process_exit;
@@ -1120,6 +1121,7 @@ int cmd_report(int argc, const char **argv)
 			.sample		 = process_sample_event,
 			.mmap		 = perf_event__process_mmap,
 			.mmap2		 = perf_event__process_mmap2,
+			.mmap3		 = perf_event__process_mmap3,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
 			.cgroup		 = perf_event__process_cgroup,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 484ce6067d23..d839983cfb88 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3443,6 +3443,7 @@ int cmd_script(int argc, const char **argv)
 			.sample		 = process_sample_event,
 			.mmap		 = perf_event__process_mmap,
 			.mmap2		 = perf_event__process_mmap2,
+			.mmap3		 = perf_event__process_mmap3,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
 			.cgroup		 = perf_event__process_cgroup,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bea461b6f937..8d00220c842b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4192,6 +4192,7 @@ static int trace__replay(struct trace *trace)
 	trace->tool.sample	  = trace__process_sample;
 	trace->tool.mmap	  = perf_event__process_mmap;
 	trace->tool.mmap2	  = perf_event__process_mmap2;
+	trace->tool.mmap3	  = perf_event__process_mmap3;
 	trace->tool.comm	  = perf_event__process_comm;
 	trace->tool.exit	  = perf_event__process_exit;
 	trace->tool.fork	  = perf_event__process_fork;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 6165f9d1d941..b281c97894e0 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -88,6 +88,7 @@ struct perf_tool build_id__mark_dso_hit_ops = {
 	.sample	= build_id__mark_dso_hit,
 	.mmap	= perf_event__process_mmap,
 	.mmap2	= perf_event__process_mmap2,
+	.mmap3	= perf_event__process_mmap3,
 	.fork	= perf_event__process_fork,
 	.exit	= perf_event__exit_del_thread,
 	.attr		 = perf_event__process_attr,
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 27c5fef9ad54..dbc3eba658a5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1606,6 +1606,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 			.sample          = process_sample_event,
 			.mmap            = perf_event__process_mmap,
 			.mmap2           = perf_event__process_mmap2,
+			.mmap3           = perf_event__process_mmap3,
 			.comm            = perf_event__process_comm,
 			.exit            = perf_event__process_exit,
 			.fork            = perf_event__process_fork,
-- 
2.26.2

