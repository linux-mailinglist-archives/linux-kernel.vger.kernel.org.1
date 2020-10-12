Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736A128AEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgJLHDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgJLHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA6C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so12661328pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSQQ8xPv3MnH+0o9+JdBt0KK9ksdjRSJlvL0MXcAaHw=;
        b=qQUaHhqdmU3WDvhWTGCpqCURFMC13eQTz2sxf9+EYzsidZ3tujYElzg6/lgaHVj2Cv
         Fa1xEbYk3pZaFzJjhvxlqK+XPgYRHDiYgdFxvR0S9q2/aHEUVU7C7oLpJ7rjkqoY0PeW
         q5zn26Sq/XVpQXSkVLyWguldtbYoQ8Vl3QwDZ7CeHWWweCdBVYYCrN/w2H0i0CrgoV4/
         vyOhl2CinZzZQGzZBbgC9FdcxQZhpIIU0YemVxzsCF4T7/wsuXe5CpvrOZgGFYAku/Mg
         rHz7AvziUXHXQNbjC3m0aakG5HbDwKkfRL5ZDpryUzdyA90NFjnZBvcGa9mbSSPhuUDz
         KnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LSQQ8xPv3MnH+0o9+JdBt0KK9ksdjRSJlvL0MXcAaHw=;
        b=jMDATMbeO2nZd+ifboC0+AGOT9cNZUn9JzsuhKoApKeXaIpqzsqG1iCFotyDoJwTgF
         8cy3i+iGiu+Dlq/Po9ua9Y6NP7GaQH1IvGDJsNwwkcNJOEUPgS1KDvf0DH1Atz5Hn/jP
         2mdNIzp+0utUi5K7gwA2lbLbYuAsue82VWoLO7ZKfNFeXDzQugY9fsmyP76fGOz1O8Ls
         TAlvPH+z6rs2M59A5Lv5T2PEnxHupeQqajiDdOdE0Dk0unHIFKFtaf0Z4L5sV5asIXvX
         Yfkap5DsnCdjCV2a78g4tU19MCuDTpCIMaNM+nSL1pvKOHoLArS7XQA+1h1CByw4EQ2X
         t0VQ==
X-Gm-Message-State: AOAM532UMJwGxiVnhr0NhNoYnfgRHjA3rxhRHQD8FiGI8WOQ46wEaQOM
        ttSYwlkpKu8aEmDp05iU2MnhYw+E7yI=
X-Google-Smtp-Source: ABdhPJysBsBmfABHD+2dxqoql4HRJvf5oRKWM4bt9tJtqA8NSLAME4sUGBzRvuLFZgsNnxucGLVdTw==
X-Received: by 2002:a17:90b:ed3:: with SMTP id gz19mr18985853pjb.53.1602486156733;
        Mon, 12 Oct 2020 00:02:36 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:36 -0700 (PDT)
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
Date:   Mon, 12 Oct 2020 16:02:13 +0900
Message-Id: <20201012070214.2074921-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
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
2.28.0.1011.ga647a8990f-goog

