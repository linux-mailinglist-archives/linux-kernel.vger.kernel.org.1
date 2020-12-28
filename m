Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922412E42CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392677AbgL1P2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406569AbgL1N5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:57:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CED0208B3;
        Mon, 28 Dec 2020 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609163791;
        bh=qB52qylM7enfnTfEGNh6vriMJ0syRQJGkOSmCJRAxwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctYxM3JavEFNmEek5D5kgIC9E+/VHB40QkE4jHZ+HlMO/l9O1Vpz1BoMXhMcaWhA0
         9hRL2rdURr0LHzXKRfVZA80sdpLo27rbmM8IY4RapjzNS7/jJMBaDPDrMCKRUGvJ4d
         2kLNGUzweyuchK8BzD6FwNNYSrLR/lLyYsAgWW5mWO+YX3/qTDWhFSdGIkMUvoPHTC
         H9zi4xdZDoIf9XVRlBY+ZKyDjbTAHvCiq4SoatbrMDAbaihiPEYHrD4YGjgdDeeT91
         0punEVrDeNNrllO1DIkhIlCtHBxeaSXvV8J8p1CtddinjENB1knmsEa3fssoG/mGtf
         0EGBQhc+h711A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35A9F411E9; Mon, 28 Dec 2020 10:56:48 -0300 (-03)
Date:   Mon, 28 Dec 2020 10:56:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/15] perf: Add build id data in mmap2 event
Message-ID: <20201228135648.GD521329@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214105457.543111-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 14, 2020 at 11:54:45AM +0100, Jiri Olsa escreveu:
> Adding support to carry build id data in mmap2 event.
> 
> The build id data replaces maj/min/ino/ino_generation
> fields, which are also used to identify map's binary,
> so it's ok to replace them with build id data:
> 
>   union {
>           struct {
>                   u32       maj;
>                   u32       min;
>                   u64       ino;
>                   u64       ino_generation;
>           };
>           struct {
>                   u8        build_id_size;
>                   u8        __reserved_1;
>                   u16       __reserved_2;
>                   u8        build_id[20];
>           };
>   };
> 
> Replaced maj/min/ino/ino_generation fields give us size
> of 24 bytes. We use 20 bytes for build id data, 1 byte
> for size and rest is unused.
> 
> There's new misc bit for mmap2 to signal there's build
> id data in it:
> 
>   #define PERF_RECORD_MISC_MMAP_BUILD_ID   (1 << 14)
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

this one isn't applying cleanly, minor header addition problem in
kernel/events/core.c:

[acme@five linux]$ git am --show-current-patch=diff > a
[acme@five linux]$ patch -p1 < a
patching file include/uapi/linux/perf_event.h
Hunk #1 succeeded at 386 (offset 2 lines).
Hunk #2 succeeded at 660 (offset 2 lines).
Hunk #3 succeeded at 707 (offset 2 lines).
Hunk #4 succeeded at 717 (offset 2 lines).
Hunk #5 succeeded at 937 (offset 4 lines).
patching file kernel/events/core.c
Hunk #1 FAILED at 51.
Hunk #2 succeeded at 397 (offset 2 lines).
Hunk #3 succeeded at 4674 (offset 8 lines).
Hunk #4 succeeded at 8049 (offset 112 lines).
Hunk #5 succeeded at 8082 (offset 112 lines).
Hunk #6 succeeded at 8107 (offset 112 lines).
Hunk #7 succeeded at 8254 (offset 112 lines).
Hunk #8 succeeded at 11193 (offset 112 lines).
1 out of 8 hunks FAILED -- saving rejects to file kernel/events/core.c.rej
[acme@five linux]$ vim kernel/events/core.c.rej
[acme@five linux]$ cat kernel/events/core.c.rej
--- kernel/events/core.c
+++ kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/buildid.h>

 #include "internal.h"

[acme@five linux]$ vim kernel/events/core.c

I'm testing with/without the kernel bits, then you can refresh just the
kernel parts, the tooling side will be in my perf/core branch.

- Arnaldo

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e3447cd9fead8..cb6f841035608e9b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -386,7 +386,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				build_id       :  1, /* use build id in mmap2 events */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -659,6 +660,22 @@ struct perf_event_mmap_page {
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
@@ -690,6 +707,7 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -699,9 +717,13 @@ struct perf_event_mmap_page {
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
@@ -915,10 +937,20 @@ enum perf_event_type {
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
index 55d18791a72de38b..c37401e3e5f7326b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -53,6 +53,7 @@
 #include <linux/min_heap.h>
 #include <linux/highmem.h>
 #include <linux/pgtable.h>
+#include <linux/buildid.h>
 
 #include "internal.h"
 
@@ -397,6 +398,7 @@ static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
 static atomic_t nr_cgroup_events __read_mostly;
 static atomic_t nr_text_poke_events __read_mostly;
+static atomic_t nr_build_id_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4673,6 +4675,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_dec(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -8046,6 +8050,8 @@ struct perf_mmap_event {
 	u64			ino;
 	u64			ino_generation;
 	u32			prot, flags;
+	u8			build_id[BUILD_ID_SIZE_MAX];
+	u32			build_id_size;
 
 	struct {
 		struct perf_event_header	header;
@@ -8077,6 +8083,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
 	u32 type = mmap_event->event_id.header.type;
+	bool use_build_id;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -8101,13 +8108,25 @@ static void perf_event_mmap_output(struct perf_event *event,
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
+	use_build_id = event->attr.build_id && mmap_event->build_id_size;
+
+	if (event->attr.mmap2 && use_build_id)
+		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+
 	perf_output_put(&handle, mmap_event->event_id);
 
 	if (event->attr.mmap2) {
-		perf_output_put(&handle, mmap_event->maj);
-		perf_output_put(&handle, mmap_event->min);
-		perf_output_put(&handle, mmap_event->ino);
-		perf_output_put(&handle, mmap_event->ino_generation);
+		if (use_build_id) {
+			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
+
+			__output_copy(&handle, size, 4);
+			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE_MAX);
+		} else {
+			perf_output_put(&handle, mmap_event->maj);
+			perf_output_put(&handle, mmap_event->min);
+			perf_output_put(&handle, mmap_event->ino);
+			perf_output_put(&handle, mmap_event->ino_generation);
+		}
 		perf_output_put(&handle, mmap_event->prot);
 		perf_output_put(&handle, mmap_event->flags);
 	}
@@ -8236,6 +8255,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
+	if (atomic_read(&nr_build_id_events))
+		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
 		       NULL);
@@ -11172,6 +11194,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
+	if (event->attr.build_id)
+		atomic_inc(&nr_build_id_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
