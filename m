Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D252C27A916
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgI1HxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1HxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:53:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so226855pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LH8yYegKYOJ5SIS5dlkWTTqhQljumI79x2/1iboWSM=;
        b=DxxN6L/Dh3WLwWy4HlSCBGeggB8zVWvyOrfasCL2Q83HgGH4nNvFPsud40lVYvfuX4
         Fi4JnQ9xVsoDjgptIIjYNQBbEUKEIUiyejbc4OMqP7E8jN6oLjjnH8mYtw2s52/+ufPA
         8qeCTADKVPUnqJO2pQX13TBO8DK5M6sa8qIUZ3wb4bFpBOjOQsi6OqKB/bDPLokJfHrW
         tbat5VE+nUIqiapE8yy5LyerPUEBrJ5bKy1wrFx7T/c16jLzNmyx7GSGCsitjBdM6Dhx
         U7PIqcrCE+LhDBxcj6yLbBzK5pmSWBjrUlERSvNPFE0TWGVAZMbhfsH3X6/ThYsxnWol
         mrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7LH8yYegKYOJ5SIS5dlkWTTqhQljumI79x2/1iboWSM=;
        b=hUi9z6BNQwgEetpwk5U7l70aDBcwqs/1hwBXaLh6G4RFxyg5KHb9qOLIvBz4YCUFdX
         YAsuZPoBvQyVydqvs3vL/9LqMt08nsyM8ELkWp0taO79BuHRG/bvW3JG9RmoK86f6LeB
         AWiVT+0i11PEOevnnpoziVyGaDINM94RPXrAHWJcrXcD271ZXlX1SzZx8rQlPQ6Jjf4W
         zdkGbSFV9rOC5YzteVnvT7BfXY0CK8Fdrfm/PRqQny5w61uvYMFfbXTgu2P85PRxPHgm
         FKH232Hca07htlwfZNoummkr3jYWssEbAva4BXbpCFfmy62W9FZhZ8IOS3LMceczpRv4
         pn7Q==
X-Gm-Message-State: AOAM5313+5qnh7AFjR2aGJYTc2V50JPHJIuiX1/7zA8SAgaX7GCN12DZ
        MWTYv+MI9OUQ77RT16K/NeA=
X-Google-Smtp-Source: ABdhPJx/RR6+tLg5tPw79mqHAfV8uq1rQrNneHqBl6C3vY8rvP5rAuSH9+xb34ZSam4Uio2NwpkDxA==
X-Received: by 2002:a62:16cd:0:b029:13e:d13d:a13f with SMTP id 196-20020a6216cd0000b029013ed13da13fmr394230pfw.39.1601279598953;
        Mon, 28 Sep 2020 00:53:18 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:53:18 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 5/6] perf inject: Add --buildid-all option
Date:   Mon, 28 Sep 2020 16:52:45 +0900
Message-Id: <20200928075246.853729-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200928075246.853729-1-namhyung@kernel.org>
References: <20200928075246.853729-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like perf record, we can even more speedup build-id processing by just
using all DSOs.  Then we don't need to look at all the sample events
anymore.  The following patch will update perf bench to show the
result of the --buildid-all option too.

Original-patch-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-inject.txt |   6 +-
 tools/perf/builtin-inject.c              | 113 ++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 70969ea73e01..a8eccff21281 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -24,8 +24,12 @@ information could make use of this facility.
 OPTIONS
 -------
 -b::
---build-ids=::
+--build-ids::
         Inject build-ids into the output stream
+
+--buildid-all:
+	Inject build-ids of all DSOs into the output stream
+
 -v::
 --verbose::
 	Be more verbose.
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 248cd9f3e5bb..f3f965157d69 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -10,6 +10,7 @@
 
 #include "util/color.h"
 #include "util/dso.h"
+#include "util/vdso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/map.h"
@@ -37,6 +38,7 @@ struct perf_inject {
 	struct perf_tool	tool;
 	struct perf_session	*session;
 	bool			build_ids;
+	bool			build_id_all;
 	bool			sched_stat;
 	bool			have_auxtrace;
 	bool			strip;
@@ -56,6 +58,9 @@ struct event_entry {
 	union perf_event event[];
 };
 
+static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
+				struct machine *machine, u8 cpumode, u32 flags);
+
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
 	ssize_t size;
@@ -319,6 +324,68 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
 }
 #endif
 
+static struct dso *findnew_dso(int pid, int tid, const char *filename,
+			       struct dso_id *id, struct machine *machine)
+{
+	struct thread *thread;
+	struct nsinfo *nsi = NULL;
+	struct nsinfo *nnsi;
+	struct dso *dso;
+	bool vdso;
+
+	thread = machine__findnew_thread(machine, pid, tid);
+	if (thread == NULL) {
+		pr_err("cannot find or create a task %d/%d.\n", tid, pid);
+		return NULL;
+	}
+
+	vdso = is_vdso_map(filename);
+	nsi = nsinfo__get(thread->nsinfo);
+
+	if (vdso) {
+		/* The vdso maps are always on the host and not the
+		 * container.  Ensure that we don't use setns to look
+		 * them up.
+		 */
+		nnsi = nsinfo__copy(nsi);
+		if (nnsi) {
+			nsinfo__put(nsi);
+			nnsi->need_setns = false;
+			nsi = nnsi;
+		}
+		dso = machine__findnew_vdso(machine, thread);
+	} else {
+		dso = machine__findnew_dso_id(machine, filename, id);
+	}
+
+	if (dso)
+		dso->nsinfo = nsi;
+	else
+		nsinfo__put(nsi);
+
+	thread__put(thread);
+	return dso;
+}
+
+static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
+					   union perf_event *event,
+					   struct perf_sample *sample,
+					   struct machine *machine)
+{
+	struct dso *dso;
+
+	dso = findnew_dso(event->mmap.pid, event->mmap.tid,
+			  event->mmap.filename, NULL, machine);
+
+	if (dso && !dso->hit) {
+		dso->hit = 1;
+		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
+		dso__put(dso);
+	}
+
+	return perf_event__repipe(tool, event, sample, machine);
+}
+
 static int perf_event__repipe_mmap2(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
@@ -357,6 +424,34 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 }
 #endif
 
+static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
+					    union perf_event *event,
+					    struct perf_sample *sample,
+					    struct machine *machine)
+{
+	struct dso_id dso_id = {
+		.maj = event->mmap2.maj,
+		.min = event->mmap2.min,
+		.ino = event->mmap2.ino,
+		.ino_generation = event->mmap2.ino_generation,
+	};
+	struct dso *dso;
+
+	dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
+			  event->mmap2.filename, &dso_id, machine);
+
+	if (dso && !dso->hit) {
+		dso->hit = 1;
+		dso__inject_build_id(dso, tool, machine, sample->cpumode,
+				     event->mmap2.flags);
+		dso__put(dso);
+	}
+
+	perf_event__repipe(tool, event, sample, machine);
+
+	return 0;
+}
+
 static int perf_event__repipe_fork(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
@@ -614,7 +709,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	signal(SIGINT, sig_handler);
 
 	if (inject->build_ids || inject->sched_stat ||
-	    inject->itrace_synth_opts.set) {
+	    inject->itrace_synth_opts.set || inject->build_id_all) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
 		inject->tool.fork	  = perf_event__repipe_fork;
@@ -623,7 +718,10 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	output_data_offset = session->header.data_offset;
 
-	if (inject->build_ids) {
+	if (inject->build_id_all) {
+		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
+		inject->tool.mmap2	  = perf_event__repipe_buildid_mmap2;
+	} else if (inject->build_ids) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
 		struct evsel *evsel;
@@ -767,6 +865,8 @@ int cmd_inject(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
 			    "Inject build-ids into the output stream"),
+		OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
+			    "Inject build-ids of all DSOs into the output stream"),
 		OPT_STRING('i', "input", &inject.input_name, "file",
 			   "input file name"),
 		OPT_STRING('o', "output", &inject.output.path, "file",
@@ -815,8 +915,6 @@ int cmd_inject(int argc, const char **argv)
 		return -1;
 	}
 
-	inject.tool.ordered_events = inject.sched_stat;
-
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
 	if (IS_ERR(inject.session))
@@ -825,7 +923,7 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
-	if (inject.build_ids) {
+	if (inject.build_ids && !inject.build_id_all) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
@@ -835,6 +933,11 @@ int cmd_inject(int argc, const char **argv)
 		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 	}
+
+	if (inject.sched_stat) {
+		inject.tool.ordered_events = true;
+	}
+
 #ifdef HAVE_JITDUMP
 	if (inject.jit_mode) {
 		inject.tool.mmap2	   = perf_event__jit_repipe_mmap2;
-- 
2.28.0.681.g6f77f65b4e-goog

