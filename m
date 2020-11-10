Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52202ADE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbgKJSXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:23:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605032625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I5Cl+OPYzioHNx4Hx5khW/jPI3m/VTSp/HKEOcwrU0o=;
        b=OMGnwDRKAOjmBpDNeuyBuhWIS1mbSWdNuZAlyxW7PdbNr7/zs5P8LLJzo+Ye8I0Fr0sQno
        E+s8BDb2cgiktYXOCDBZdPDHZjXt3DfnAa4Zg+f21btQlDL7DLvLp+xq4WvKs4ZBLG7c0W
        H6ZG/fSsB6Ko+gVpJ0m42kTX7qvTWJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-h8dMhcRRMYyxUmT9ykC4DA-1; Tue, 10 Nov 2020 13:23:41 -0500
X-MC-Unique: h8dMhcRRMYyxUmT9ykC4DA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03896805EF4;
        Tue, 10 Nov 2020 18:23:39 +0000 (UTC)
Received: from krava (unknown [10.40.194.170])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E3606EF78;
        Tue, 10 Nov 2020 18:23:34 +0000 (UTC)
Date:   Tue, 10 Nov 2020 19:23:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/24] perf: Add build id data in mmap2 event
Message-ID: <20201110182334.GG387652@krava>
References: <20201109215415.400153-1-jolsa@kernel.org>
 <20201109215415.400153-4-jolsa@kernel.org>
 <20201110082851.GV2594@hirez.programming.kicks-ass.net>
 <20201110101041.GC387652@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110101041.GC387652@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:10:46AM +0100, Jiri Olsa wrote:
> On Tue, Nov 10, 2020 at 09:28:51AM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 09, 2020 at 10:53:54PM +0100, Jiri Olsa wrote:
> > > There's new misc bit for mmap2 to signal there's build
> > > id data in it:
> > > 
> > >   #define PERF_RECORD_MISC_BUILD_ID              (1 << 14)
> > 
> > PERF_RECORD_MISC_MMAP_BUILD_ID would be consistent with the existing
> > PERF_RECORD_MISC_MMAP_DATA naming.
> 
> ok
> 
> > 
> > Also, AFAICT there's still a bunch of unused bits in misc.
> > 
> > 	012	    CDEF
> > 	|||---------||||
> > 
> > Where:
> > 	0-2	CPUMODE_MASK
> > 
> > 	C	PROC_MAP_PARSE_TIMEOUT
> > 	D	MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
> > 	E	EXACT_IP / SCHED_OUT_PREEMPT
> > 	F	(reserved)
> > 
> > Maybe we should put in a comment to keep track of the hole ?
> 
> ook

how about the change below.. I also switch the build_id with the size,
but I kept the build_id size 20, because I think there's bigger chance
we will use those reserved bytes for something, than that we will need
those extra 3 bytes in build_id array

  struct {
          u8              build_id_size;
          u8              __reserved_1;
          u16             __reserved_2;
          u8              build_id[20];
  };

jirka


---
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b95d3c485d27..45a216bea048 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -384,7 +384,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				build_id       :  1, /* use build id in mmap2 events */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -657,6 +658,22 @@ struct perf_event_mmap_page {
 	__u64	aux_size;
 };
 
+/*
+ * The current state of perf_event_header::misc bits usage:
+ * ('|' used bit, '-' unused bit)
+ *
+ *  012         CDEF
+ *  |||---------||||
+ *
+ *  Where:
+ *    0-2     CPUMODE_MASK
+ *
+ *    C       PROC_MAP_PARSE_TIMEOUT
+ *    D       MMAP_DATA / COMM_EXEC / FORK_EXEC / SWITCH_OUT
+ *    E       MMAP_BUILD_ID / EXACT_IP / SCHED_OUT_PREEMPT
+ *    F       (reserved)
+ */
+
 #define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
 #define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
 #define PERF_RECORD_MISC_KERNEL			(1 << 0)
@@ -688,6 +705,7 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -697,9 +715,13 @@ struct perf_event_mmap_page {
  *
  * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
  *   Indicates that thread was preempted in TASK_RUNNING state.
+ *
+ * PERF_RECORD_MISC_MMAP_BUILD_ID:
+ *   Indicates that mmap2 event carries build id data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
+#define PERF_RECORD_MISC_MMAP_BUILD_ID		(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
@@ -911,10 +933,20 @@ enum perf_event_type {
 	 *	u64				addr;
 	 *	u64				len;
 	 *	u64				pgoff;
-	 *	u32				maj;
-	 *	u32				min;
-	 *	u64				ino;
-	 *	u64				ino_generation;
+	 *	union {
+	 *		struct {
+	 *			u32		maj;
+	 *			u32		min;
+	 *			u64		ino;
+	 *			u64		ino_generation;
+	 *		};
+	 *		struct {
+	 *			u8		build_id_size;
+	 *			u8		__reserved_1;
+	 *			u16		__reserved_2;
+	 *			u8		build_id[20];
+	 *		};
+	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
 	 * 	struct sample_id		sample_id;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1dd49a..5b2b8ec82399 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/buildid.h>
 
 #include "internal.h"
 
@@ -395,6 +396,7 @@ static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
+static atomic_t nr_build_id_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4672,6 +4674,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_dec(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -7942,6 +7946,8 @@ struct perf_mmap_event {
 	u64			ino;
 	u64			ino_generation;
 	u32			prot, flags;
+	u8			build_id[BUILD_ID_SIZE];
+	u32			build_id_size;
 
 	struct {
 		struct perf_event_header	header;
@@ -7997,13 +8003,23 @@ static void perf_event_mmap_output(struct perf_event *event,
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
+	if (event->attr.mmap2 && event->attr.build_id)
+		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+
 	perf_output_put(&handle, mmap_event->event_id);
 
 	if (event->attr.mmap2) {
-		perf_output_put(&handle, mmap_event->maj);
-		perf_output_put(&handle, mmap_event->min);
-		perf_output_put(&handle, mmap_event->ino);
-		perf_output_put(&handle, mmap_event->ino_generation);
+		if (event->attr.build_id) {
+			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
+
+			__output_copy(&handle, size, 4);
+			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE);
+		} else {
+			perf_output_put(&handle, mmap_event->maj);
+			perf_output_put(&handle, mmap_event->min);
+			perf_output_put(&handle, mmap_event->ino);
+			perf_output_put(&handle, mmap_event->ino_generation);
+		}
 		perf_output_put(&handle, mmap_event->prot);
 		perf_output_put(&handle, mmap_event->flags);
 	}
@@ -8132,6 +8148,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
+	if (atomic_read(&nr_build_id_events))
+		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
 		       NULL);
@@ -11069,6 +11088,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_inc(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 768888b9326a..1bcf51e24979 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -482,6 +482,9 @@ Specify vmlinux path which has debuginfo.
 --buildid-all::
 Record build-id of all DSOs regardless whether it's actually hit or not.
 
+--buildid-mmap::
+Record build ids in mmap2 events, disables build id cache (implies --no-buildid).
+
 --aio[=n]::
 Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default: 1, max: 4).
 Asynchronous mode is supported only when linking Perf tool with libc library
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..47bae9d82d43 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -102,6 +102,7 @@ struct record {
 	bool			no_buildid_cache;
 	bool			no_buildid_cache_set;
 	bool			buildid_all;
+	bool			buildid_mmap;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
@@ -2139,6 +2140,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 			rec->no_buildid_cache = true;
 		else if (!strcmp(value, "skip"))
 			rec->no_buildid = true;
+		else if (!strcmp(value, "mmap"))
+			rec->buildid_mmap = true;
 		else
 			return -1;
 		return 0;
@@ -2554,6 +2557,8 @@ static struct option __record_options[] = {
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
 		    "Record build-id of all DSOs regardless of hits"),
+	OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
+		    "Record build-id in map events"),
 	OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
 		    "append timestamp to output filename"),
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
@@ -2657,6 +2662,21 @@ int cmd_record(int argc, const char **argv)
 
 	}
 
+	if (rec->buildid_mmap) {
+		if (!perf_can_record_build_id()) {
+			pr_err("Failed: no support to record build id in mmap events, update your kernel.\n");
+			err = -EINVAL;
+			goto out_opts;
+		}
+		pr_debug("Enabling build id in mmap2 events.\n");
+		/* Enable mmap build id synthesizing. */
+		symbol_conf.buildid_mmap2 = true;
+		/* Enable perf_event_attr::build_id bit. */
+		rec->opts.build_id = true;
+		/* Disable build id cache. */
+		rec->no_buildid = true;
+	}
+
 	if (rec->opts.kcore)
 		rec->data.is_dir = true;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1cad6051d8b0..749d806ee1d1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1170,10 +1170,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (opts->sample_weight)
 		evsel__set_sample_bit(evsel, WEIGHT);
 
-	attr->task  = track;
-	attr->mmap  = track;
-	attr->mmap2 = track && !perf_missing_features.mmap2;
-	attr->comm  = track;
+	attr->task     = track;
+	attr->mmap     = track;
+	attr->mmap2    = track && !perf_missing_features.mmap2;
+	attr->comm     = track;
+	attr->build_id = track && opts->build_id;
+
 	/*
 	 * ksymbol is tracked separately with text poke because it needs to be
 	 * system wide and enabled immediately.
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 3840d02f0f7b..829af17a0867 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -98,6 +98,11 @@ static void perf_probe_text_poke(struct evsel *evsel)
 	evsel->core.attr.text_poke = 1;
 }
 
+static void perf_probe_build_id(struct evsel *evsel)
+{
+	evsel->core.attr.build_id = 1;
+}
+
 bool perf_can_sample_identifier(void)
 {
 	return perf_probe_api(perf_probe_sample_identifier);
@@ -172,3 +177,8 @@ bool perf_can_aux_sample(void)
 
 	return true;
 }
+
+bool perf_can_record_build_id(void)
+{
+	return perf_probe_api(perf_probe_build_id);
+}
diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
index d5506a983a94..f12ca55f509a 100644
--- a/tools/perf/util/perf_api_probe.h
+++ b/tools/perf/util/perf_api_probe.h
@@ -11,5 +11,6 @@ bool perf_can_record_cpu_wide(void);
 bool perf_can_record_switch_events(void);
 bool perf_can_record_text_poke_events(void);
 bool perf_can_sample_identifier(void);
+bool perf_can_record_build_id(void);
 
 #endif // __PERF_API_PROBE_H
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index e67a227c0ce7..0f1c62d40a89 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -134,6 +134,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
 	PRINT_ATTRf(cgroup, p_unsigned);
+	PRINT_ATTRf(build_id, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 266760ac9143..609e706f4282 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -49,6 +49,7 @@ struct record_opts {
 	bool	      no_bpf_event;
 	bool	      kcore;
 	bool	      text_poke;
+	bool	      build_id;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;

