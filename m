Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1226813B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgIMVDl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:03:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgIMVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:03:38 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-oOEGkZPTOM-e36T6JUMgVg-1; Sun, 13 Sep 2020 17:03:29 -0400
X-MC-Unique: oOEGkZPTOM-e36T6JUMgVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE6E801AAE;
        Sun, 13 Sep 2020 21:03:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10B1410021AA;
        Sun, 13 Sep 2020 21:03:23 +0000 (UTC)
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
Subject: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Date:   Sun, 13 Sep 2020 23:02:49 +0200
Message-Id: <20200913210313.1985612-3-jolsa@kernel.org>
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

Add new version of mmap event. The MMAP3 record is an
augmented version of MMAP2, it adds build id value to
identify the exact binary object behind memory map:

  struct {
    struct perf_event_header header;

    u32                      pid, tid;
    u64                      addr;
    u64                      len;
    u64                      pgoff;
    u32                      maj;
    u32                      min;
    u64                      ino;
    u64                      ino_generation;
    u32                      prot, flags;
    u32                      reserved;
    u8                       buildid[20];
    char                     filename[];
    struct sample_id         sample_id;
  };

Adding 4 bytes reserved field to align buildid data to 8 bytes,
so sample_id data is properly aligned.

The mmap3 event is enabled by new mmap3 bit in perf_event_attr
struct.  When set for an event, it enables the build id retrieval
and will use mmap3 format for the event.

Keeping track of mmap3 events and calling build_id_parse
in perf_event_mmap_event only if we have any defined.

Having build id attached directly to the mmap event will help
tool like perf to skip final search through perf data for
binaries that are needed in the report time. Also it prevents
possible race when the binary could be removed or replaced
during profiling.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++-
 kernel/events/core.c            | 38 +++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee69e3d..facfc3c673ed 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -384,7 +384,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				mmap3          :  1, /* include bpf events */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1060,6 +1061,30 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * The MMAP3 records are an augmented version of MMAP2, they add
+	 * build id value to identify the exact binary behind map
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *
+	 *	u32				pid, tid;
+	 *	u64				addr;
+	 *	u64				len;
+	 *	u64				pgoff;
+	 *	u32				maj;
+	 *	u32				min;
+	 *	u64				ino;
+	 *	u64				ino_generation;
+	 *	u32				prot, flags;
+	 *	u32				reserved;
+	 *	u8				buildid[20];
+	 *	char				filename[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_MMAP3			= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ed5248f0445..719894492dac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -51,6 +51,7 @@
 #include <linux/proc_ns.h>
 #include <linux/mount.h>
 #include <linux/min_heap.h>
+#include <linux/buildid.h>
 
 #include "internal.h"
 
@@ -386,6 +387,7 @@ static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
+static atomic_t nr_mmap3_events __read_mostly;
 static atomic_t nr_comm_events __read_mostly;
 static atomic_t nr_namespaces_events __read_mostly;
 static atomic_t nr_task_events __read_mostly;
@@ -4588,7 +4590,7 @@ static bool is_sb_event(struct perf_event *event)
 		return false;
 
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
-	    attr->comm || attr->comm_exec ||
+	    attr->mmap3 || attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
 	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
@@ -4644,6 +4646,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
+	if (event->attr.mmap3)
+		atomic_dec(&nr_mmap3_events);
 	if (event->attr.comm)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
@@ -7465,7 +7469,7 @@ static void perf_pmu_output_stop(struct perf_event *event)
 /*
  * task tracking -- fork/exit
  *
- * enabled by: attr.comm | attr.mmap | attr.mmap2 | attr.mmap_data | attr.task
+ * enabled by: attr.comm | attr.mmap | attr.mmap2 | attr.mmap3 | attr.mmap_data | attr.task
  */
 
 struct perf_task_event {
@@ -7486,8 +7490,8 @@ struct perf_task_event {
 static int perf_event_task_match(struct perf_event *event)
 {
 	return event->attr.comm  || event->attr.mmap ||
-	       event->attr.mmap2 || event->attr.mmap_data ||
-	       event->attr.task;
+	       event->attr.mmap2 || event->attr.mmap3 ||
+	       event->attr.mmap_data || event->attr.task;
 }
 
 static void perf_event_task_output(struct perf_event *event,
@@ -7913,6 +7917,7 @@ struct perf_mmap_event {
 	u64			ino;
 	u64			ino_generation;
 	u32			prot, flags;
+	u8			buildid[BUILD_ID_SIZE];
 
 	struct {
 		struct perf_event_header	header;
@@ -7933,7 +7938,7 @@ static int perf_event_mmap_match(struct perf_event *event,
 	int executable = vma->vm_flags & VM_EXEC;
 
 	return (!executable && event->attr.mmap_data) ||
-	       (executable && (event->attr.mmap || event->attr.mmap2));
+	       (executable && (event->attr.mmap || event->attr.mmap2 || event->attr.mmap3));
 }
 
 static void perf_event_mmap_output(struct perf_event *event,
@@ -7949,7 +7954,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	if (!perf_event_mmap_match(event, data))
 		return;
 
-	if (event->attr.mmap2) {
+	if (event->attr.mmap2 || event->attr.mmap3) {
 		mmap_event->event_id.header.type = PERF_RECORD_MMAP2;
 		mmap_event->event_id.header.size += sizeof(mmap_event->maj);
 		mmap_event->event_id.header.size += sizeof(mmap_event->min);
@@ -7959,6 +7964,12 @@ static void perf_event_mmap_output(struct perf_event *event,
 		mmap_event->event_id.header.size += sizeof(mmap_event->flags);
 	}
 
+	if (event->attr.mmap3) {
+		mmap_event->event_id.header.type = PERF_RECORD_MMAP3;
+		mmap_event->event_id.header.size += sizeof(u32);
+		mmap_event->event_id.header.size += sizeof(mmap_event->buildid);
+	}
+
 	perf_event_header__init_id(&mmap_event->event_id.header, &sample, event);
 	ret = perf_output_begin(&handle, event,
 				mmap_event->event_id.header.size);
@@ -7970,7 +7981,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 
 	perf_output_put(&handle, mmap_event->event_id);
 
-	if (event->attr.mmap2) {
+	if (event->attr.mmap2 || event->attr.mmap3) {
 		perf_output_put(&handle, mmap_event->maj);
 		perf_output_put(&handle, mmap_event->min);
 		perf_output_put(&handle, mmap_event->ino);
@@ -7979,6 +7990,13 @@ static void perf_event_mmap_output(struct perf_event *event,
 		perf_output_put(&handle, mmap_event->flags);
 	}
 
+	if (event->attr.mmap3) {
+		u32 reserved = 0;
+
+		perf_output_put(&handle, reserved);
+		__output_copy(&handle, mmap_event->buildid, BUILD_ID_SIZE);
+	}
+
 	__output_copy(&handle, mmap_event->file_name,
 				   mmap_event->file_size);
 
@@ -8098,6 +8116,9 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->prot = prot;
 	mmap_event->flags = flags;
 
+	if (atomic_read(&nr_mmap3_events))
+		build_id_parse(vma, mmap_event->buildid);
+
 	if (!(vma->vm_flags & VM_EXEC))
 		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_DATA;
 
@@ -8241,6 +8262,7 @@ void perf_event_mmap(struct vm_area_struct *vma)
 		/* .ino_generation (attr_mmap2 only) */
 		/* .prot (attr_mmap2 only) */
 		/* .flags (attr_mmap2 only) */
+		/* .buildid (attr_mmap3 only) */
 	};
 
 	perf_addr_filters_adjust(vma);
@@ -11040,6 +11062,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
+	if (event->attr.mmap3)
+		atomic_inc(&nr_mmap3_events);
 	if (event->attr.comm)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
-- 
2.26.2

