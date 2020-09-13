Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908B268142
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgIMVE3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbgIMVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-RRmJ6c-aPQ2elIluj34x6g-1; Sun, 13 Sep 2020 17:04:14 -0400
X-MC-Unique: RRmJ6c-aPQ2elIluj34x6g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F5DE802B72;
        Sun, 13 Sep 2020 21:04:12 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC6C21002388;
        Sun, 13 Sep 2020 21:04:08 +0000 (UTC)
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
Subject: [PATCH 11/26] perf tools: Add mmap3 support
Date:   Sun, 13 Sep 2020 23:02:58 +0200
Message-Id: <20200913210313.1985612-12-jolsa@kernel.org>
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

Adding support to process mmap3 events. Adding the event struct
perf_record_mmap3 object and perf_event__process_mmap3 function
to process and store its build id data directly in map's dso
object.

Adding all standard callbacks for new event type and mmap3 swap
function. The mmap3 event trace dump contains in addition the
build id data.

The mmap3 report -D dump looks like:

0 0 0x418 [0x98]: PERF_RECORD_MMAP3 -1/0: <44f35083700d2fc423d4c3f7238b31f5c6500444> \
[0xffffffff81000000(0xe00d17) @ 0xffffffff81000000 00:00 0 0]: ---p [kernel.kallsyms]_text

with build id displayed within <> braces.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 18 +++++++
 tools/perf/util/event.c             | 32 +++++++++++++
 tools/perf/util/event.h             |  5 ++
 tools/perf/util/machine.c           | 74 ++++++++++++++++++++++++++++-
 tools/perf/util/machine.h           |  2 +
 tools/perf/util/map.c               |  8 +++-
 tools/perf/util/map.h               |  2 +-
 tools/perf/util/session.c           | 28 +++++++++++
 tools/perf/util/tool.h              |  1 +
 9 files changed, 165 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 842028858d66..03f7313beee0 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -32,6 +32,23 @@ struct perf_record_mmap2 {
 	char			 filename[PATH_MAX];
 };
 
+struct perf_record_mmap3 {
+	struct perf_event_header header;
+	__u32			 pid, tid;
+	__u64			 start;
+	__u64			 len;
+	__u64			 pgoff;
+	__u32			 maj;
+	__u32			 min;
+	__u64			 ino;
+	__u64			 ino_generation;
+	__u32			 prot;
+	__u32			 flags;
+	__u32			 reserved;
+	__u8			 buildid[20];
+	char			 filename[PATH_MAX];
+};
+
 struct perf_record_comm {
 	struct perf_event_header header;
 	__u32			 pid, tid;
@@ -364,6 +381,7 @@ union perf_event {
 	struct perf_event_header		header;
 	struct perf_record_mmap			mmap;
 	struct perf_record_mmap2		mmap2;
+	struct perf_record_mmap3		mmap3;
 	struct perf_record_comm			comm;
 	struct perf_record_namespaces		namespaces;
 	struct perf_record_cgroup		cgroup;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 317a26571845..35e5a088e591 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -57,6 +57,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
+	[PERF_RECORD_MMAP3]			= "MMAP3",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -301,6 +302,26 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 		       event->mmap2.filename);
 }
 
+size_t perf_event__fprintf_mmap3(union perf_event *event, FILE *fp)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+
+	build_id__sprintf(event->mmap3.buildid, BUILD_ID_SIZE, sbuild_id);
+
+	return fprintf(fp, " %d/%d: <%s> [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
+			   " %02x:%02x %"PRI_lu64" %"PRI_lu64"]: %c%c%c%c %s\n",
+		       event->mmap3.pid, event->mmap3.tid,
+		       sbuild_id, event->mmap3.start,
+		       event->mmap3.len, event->mmap3.pgoff, event->mmap3.maj,
+		       event->mmap3.min, event->mmap3.ino,
+		       event->mmap3.ino_generation,
+		       (event->mmap3.prot & PROT_READ) ? 'r' : '-',
+		       (event->mmap3.prot & PROT_WRITE) ? 'w' : '-',
+		       (event->mmap3.prot & PROT_EXEC) ? 'x' : '-',
+		       (event->mmap3.flags & MAP_SHARED) ? 's' : 'p',
+		       event->mmap3.filename);
+}
+
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)
 {
 	struct perf_thread_map *threads = thread_map__new_event(&event->thread_map);
@@ -349,6 +370,14 @@ int perf_event__process_mmap2(struct perf_tool *tool __maybe_unused,
 	return machine__process_mmap2_event(machine, event, sample);
 }
 
+int perf_event__process_mmap3(struct perf_tool *tool __maybe_unused,
+			     union perf_event *event,
+			     struct perf_sample *sample,
+			     struct machine *machine)
+{
+	return machine__process_mmap3_event(machine, event, sample);
+}
+
 size_t perf_event__fprintf_task(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, "(%d:%d):(%d:%d)\n",
@@ -493,6 +522,9 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	case PERF_RECORD_MMAP2:
 		ret += perf_event__fprintf_mmap2(event, fp);
 		break;
+	case PERF_RECORD_MMAP3:
+		ret += perf_event__fprintf_mmap3(event, fp);
+		break;
 	case PERF_RECORD_AUX:
 		ret += perf_event__fprintf_aux(event, fp);
 		break;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b828b99176f4..6e6d5c5e9ad5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -335,6 +335,10 @@ int perf_event__process_mmap2(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__process_mmap3(struct perf_tool *tool,
+			     union perf_event *event,
+			     struct perf_sample *sample,
+			     struct machine *machine);
 int perf_event__process_fork(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -379,6 +383,7 @@ const char *perf_event__name(unsigned int id);
 size_t perf_event__fprintf_comm(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_mmap3(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_task(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_aux(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2805aedc1062..17d6fd19ef79 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1697,6 +1697,74 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	return -1;
 }
 
+int machine__process_mmap3_event(struct machine *machine,
+				 union perf_event *event,
+				 struct perf_sample *sample)
+{
+	struct thread *thread;
+	struct map *map;
+	struct dso_id dso_id = {
+		.maj = event->mmap3.maj,
+		.min = event->mmap3.min,
+		.ino = event->mmap3.ino,
+		.ino_generation = event->mmap3.ino_generation,
+	};
+	u8 *buildid = NULL;
+	int ret = 0;
+
+	if (dump_trace)
+		perf_event__fprintf_mmap3(event, stdout);
+
+	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
+	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
+		struct extra_kernel_map xm = {
+			.start = event->mmap3.start,
+			.end   = event->mmap3.start + event->mmap3.len,
+			.pgoff = event->mmap3.pgoff,
+		};
+
+		strlcpy(xm.name, event->mmap3.filename, KMAP_NAME_LEN);
+		ret = machine__process_kernel_mmap_event(machine, &xm);
+		if (ret < 0)
+			goto out_problem;
+		return 0;
+	}
+
+	thread = machine__findnew_thread(machine, event->mmap3.pid,
+					event->mmap3.tid);
+	if (thread == NULL)
+		goto out_problem;
+
+	/* If we got empty build id, do not set it. */
+	if (build_id__is_defined(event->mmap3.buildid))
+		buildid = event->mmap3.buildid;
+
+	map = map__new(machine, event->mmap3.start,
+			event->mmap3.len, event->mmap3.pgoff,
+			&dso_id, event->mmap3.prot,
+			event->mmap3.flags, buildid,
+			event->mmap3.filename, thread);
+
+	if (map == NULL)
+		goto out_problem_map;
+
+	ret = thread__insert_map(thread, map);
+	if (ret)
+		goto out_problem_insert;
+
+	thread__put(thread);
+	map__put(map);
+	return 0;
+
+out_problem_insert:
+	map__put(map);
+out_problem_map:
+	thread__put(thread);
+out_problem:
+	dump_printf("problem processing PERF_RECORD_MMAP2, skipping event.\n");
+	return 0;
+}
+
 int machine__process_mmap2_event(struct machine *machine,
 				 union perf_event *event,
 				 struct perf_sample *sample)
@@ -1737,7 +1805,7 @@ int machine__process_mmap2_event(struct machine *machine,
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
 			&dso_id, event->mmap2.prot,
-			event->mmap2.flags,
+			event->mmap2.flags, NULL,
 			event->mmap2.filename, thread);
 
 	if (map == NULL)
@@ -1796,7 +1864,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
-			NULL, prot, 0, event->mmap.filename, thread);
+			NULL, prot, 0, NULL, event->mmap.filename, thread);
 
 	if (map == NULL)
 		goto out_problem_map;
@@ -1956,6 +2024,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_cgroup_event(machine, event, sample); break;
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
+	case PERF_RECORD_MMAP3:
+		ret = machine__process_mmap3_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
 		ret = machine__process_fork_event(machine, event, sample); break;
 	case PERF_RECORD_EXIT:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 062c36a8433c..a3c1d0bf89e5 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -135,6 +135,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
 				 struct perf_sample *sample);
+int machine__process_mmap3_event(struct machine *machine, union perf_event *event,
+				 struct perf_sample *sample);
 int machine__process_ksymbol(struct machine *machine,
 			     union perf_event *event,
 			     struct perf_sample *sample);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cc0faf8f1321..697e87d9fd66 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -145,8 +145,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, struct dso_id *id,
-		     u32 prot, u32 flags, char *filename,
-		     struct thread *thread)
+		     u32 prot, u32 flags, u8 *buildid,
+		     char *filename, struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
 	struct nsinfo *nsi = NULL;
@@ -209,6 +209,10 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 				dso__set_loaded(dso);
 		}
 		dso->nsinfo = nsi;
+
+		if (build_id__is_defined(buildid))
+			dso__set_build_id(dso, buildid);
+
 		dso__put(dso);
 	}
 	return map;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c2f5d28fe73a..99b3036ffcc7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -107,7 +107,7 @@ struct dso_id;
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
-		     char *filename, struct thread *thread);
+		     u8 *buildid, char *filename, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso);
 void map__delete(struct map *map);
 struct map *map__clone(struct map *map);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7a5f03764702..45e062d4029f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -466,6 +466,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->mmap = process_event_stub;
 	if (tool->mmap2 == NULL)
 		tool->mmap2 = process_event_stub;
+	if (tool->mmap3 == NULL)
+		tool->mmap3 = process_event_stub;
 	if (tool->comm == NULL)
 		tool->comm = process_event_stub;
 	if (tool->namespaces == NULL)
@@ -603,6 +605,27 @@ static void perf_event__mmap2_swap(union perf_event *event,
 		swap_sample_id_all(event, data);
 	}
 }
+
+static void perf_event__mmap3_swap(union perf_event *event,
+				  bool sample_id_all)
+{
+	event->mmap3.pid   = bswap_32(event->mmap3.pid);
+	event->mmap3.tid   = bswap_32(event->mmap3.tid);
+	event->mmap3.start = bswap_64(event->mmap3.start);
+	event->mmap3.len   = bswap_64(event->mmap3.len);
+	event->mmap3.pgoff = bswap_64(event->mmap3.pgoff);
+	event->mmap3.maj   = bswap_32(event->mmap3.maj);
+	event->mmap3.min   = bswap_32(event->mmap3.min);
+	event->mmap3.ino   = bswap_64(event->mmap3.ino);
+
+	if (sample_id_all) {
+		void *data = &event->mmap3.filename;
+
+		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+}
+
 static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
 {
 	event->fork.pid	 = bswap_32(event->fork.pid);
@@ -938,6 +961,7 @@ typedef void (*perf_event__swap_op)(union perf_event *event,
 static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_MMAP]		  = perf_event__mmap_swap,
 	[PERF_RECORD_MMAP2]		  = perf_event__mmap2_swap,
+	[PERF_RECORD_MMAP3]		  = perf_event__mmap3_swap,
 	[PERF_RECORD_COMM]		  = perf_event__comm_swap,
 	[PERF_RECORD_FORK]		  = perf_event__task_swap,
 	[PERF_RECORD_EXIT]		  = perf_event__task_swap,
@@ -1453,6 +1477,10 @@ static int machines__deliver_event(struct machines *machines,
 		if (event->header.misc & PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT)
 			++evlist->stats.nr_proc_map_timeout;
 		return tool->mmap2(tool, event, sample, machine);
+	case PERF_RECORD_MMAP3:
+		if (event->header.misc & PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT)
+			++evlist->stats.nr_proc_map_timeout;
+		return tool->mmap3(tool, event, sample, machine);
 	case PERF_RECORD_COMM:
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index bbbc0dcd461f..8f5ee25bfa35 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -44,6 +44,7 @@ struct perf_tool {
 			read;
 	event_op	mmap,
 			mmap2,
+			mmap3,
 			comm,
 			namespaces,
 			cgroup,
-- 
2.26.2

