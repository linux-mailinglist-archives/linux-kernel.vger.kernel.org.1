Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A92752D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:06:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8DFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so14553504pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4U3AzapGvgmMsnQHbvcSd1VwlZHpmVJu4r3ZUnhDwA=;
        b=va42ZCKcdMDs8vdw5QkBJ0fuUb+LtgwLlAr0nNeuY2CaSA3sWQTkbkfikLWjxtBY9e
         6KrLKlcXukyNS2vA9zhW7TmJOXqtRVMmTau1Azv4bQ7TJrb7+sN3AiYSvQMLps/TavKf
         bMsg3bfyX6yS10HGYMquUcolrnF5Us/7OKl2jUGMYnJY8dNYZbRrkJL+w73mClXx3bm2
         FOVaz4Y0ItKEdOnlTChiixXcPr+p8lwXsqD7twxle56qnm6lOUVM84+qq8SqPr5Wn3mi
         qzHZQmICRqn8nbSKWlxVrEt+6HpO5wB9HkMrmoR9IbPkqCTt7u3KZG+Yc7ilmmIMf1cr
         kOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q4U3AzapGvgmMsnQHbvcSd1VwlZHpmVJu4r3ZUnhDwA=;
        b=TI5CxANwEt1tl3PMgRu3jYcSubKvUTGRaY4ujQVMwa5IOpqb2AYKLZQjQOphk+7BzA
         3P2emQkaLkD9Yj8dYkLgdu6SJoLf31wbbUYtyKzyv7UjtlR/OhylRIRQAjoRe+9cAMZ1
         7n9ZfoSU96VqHDWomPpK5EappZQ1y1HWIssRio/IcyxnVsDDTffC7ZJCQV5xXqDyfE4n
         Yr4487oCLZdfT2FXHDwgbxsTf0MLy616YnOmE3VCJk4CtH86IINDh6LwWRWerJpvYdJ5
         Y9u/LlOtgA3WBW26lpLrfImRYTiJ1gNdWW2OCRPmb3MGmJmkPByiBvPN0az8fjKCfXcO
         12uQ==
X-Gm-Message-State: AOAM530L+JyHma8SSnd9rpbpI9qpU4Uuyc1bQ/QLP/eVY/S0mJgo8+P4
        HnBRagf06gvEgm6DPLO7MWQ=
X-Google-Smtp-Source: ABdhPJzbhW2xQ62SmqdzyIh5IwairLU2IPviph/oAWGvy3t+J7dHGmICVcgfLh+zptXOg6i37EjeaA==
X-Received: by 2002:aa7:9823:0:b029:150:a96f:c8b7 with SMTP id q3-20020aa798230000b0290150a96fc8b7mr7720186pfl.34.1600848362105;
        Wed, 23 Sep 2020 01:06:02 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:06:01 -0700 (PDT)
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
Subject: [PATCH 5/7] perf inject: Add --buildid-all option
Date:   Wed, 23 Sep 2020 17:05:35 +0900
Message-Id: <20200923080537.155264-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
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
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-inject.txt |   6 +-
 tools/perf/builtin-inject.c              | 112 ++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 6 deletions(-)

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
index d0aa365e7294..500428aaa576 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -10,6 +10,7 @@
 
 #include "util/color.h"
 #include "util/dso.h"
+#include "util/vdso.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/map.h"
@@ -36,6 +37,7 @@ struct perf_inject {
 	struct perf_tool	tool;
 	struct perf_session	*session;
 	bool			build_ids;
+	bool			build_id_all;
 	bool			sched_stat;
 	bool			have_auxtrace;
 	bool			strip;
@@ -55,6 +57,9 @@ struct event_entry {
 	union perf_event event[];
 };
 
+static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
+				struct machine *machine, u8 cpumode);
+
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
 {
 	ssize_t size;
@@ -318,6 +323,68 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
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
+		dso__inject_build_id(dso, tool, machine, sample->cpumode);
+		dso__put(dso);
+	}
+
+	return perf_event__repipe(tool, event, sample, machine);
+}
+
 static int perf_event__repipe_mmap2(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
@@ -356,6 +423,33 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
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
+		dso__inject_build_id(dso, tool, machine, sample->cpumode);
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
@@ -613,7 +707,7 @@ static int __cmd_inject(struct perf_inject *inject)
 	signal(SIGINT, sig_handler);
 
 	if (inject->build_ids || inject->sched_stat ||
-	    inject->itrace_synth_opts.set) {
+	    inject->itrace_synth_opts.set || inject->build_id_all) {
 		inject->tool.mmap	  = perf_event__repipe_mmap;
 		inject->tool.mmap2	  = perf_event__repipe_mmap2;
 		inject->tool.fork	  = perf_event__repipe_fork;
@@ -622,7 +716,10 @@ static int __cmd_inject(struct perf_inject *inject)
 
 	output_data_offset = session->header.data_offset;
 
-	if (inject->build_ids) {
+	if (inject->build_id_all) {
+		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
+		inject->tool.mmap2	  = perf_event__repipe_buildid_mmap2;
+	} else if (inject->build_ids) {
 		inject->tool.sample = perf_event__inject_buildid;
 	} else if (inject->sched_stat) {
 		struct evsel *evsel;
@@ -766,6 +863,8 @@ int cmd_inject(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
 			    "Inject build-ids into the output stream"),
+		OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
+			    "Inject build-ids of all DSOs into the output stream"),
 		OPT_STRING('i', "input", &inject.input_name, "file",
 			   "input file name"),
 		OPT_STRING('o', "output", &inject.output.path, "file",
@@ -814,8 +913,6 @@ int cmd_inject(int argc, const char **argv)
 		return -1;
 	}
 
-	inject.tool.ordered_events = inject.sched_stat;
-
 	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
 	if (IS_ERR(inject.session))
@@ -824,7 +921,7 @@ int cmd_inject(int argc, const char **argv)
 	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
 		pr_warning("Decompression initialization failed.\n");
 
-	if (inject.build_ids) {
+	if (inject.build_ids && !inject.build_id_all) {
 		/*
 		 * to make sure the mmap records are ordered correctly
 		 * and so that the correct especially due to jitted code
@@ -834,6 +931,11 @@ int cmd_inject(int argc, const char **argv)
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

