Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21532C1931
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgKWXFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:05:47 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:60558 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732902AbgKWXFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:05:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-OtPJqGGDOnGBw3bhWNbgAA-1; Mon, 23 Nov 2020 18:05:38 -0500
X-MC-Unique: OtPJqGGDOnGBw3bhWNbgAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA10100A254;
        Mon, 23 Nov 2020 23:05:36 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 807685D9CA;
        Mon, 23 Nov 2020 23:05:32 +0000 (UTC)
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/25] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
Date:   Tue, 24 Nov 2020 00:04:51 +0100
Message-Id: <20201123230512.2097312-5-jolsa@kernel.org>
In-Reply-To: <20201123230512.2097312-1-jolsa@kernel.org>
References: <20201123230512.2097312-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syncing tools's uapi with mmap2 build id data changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 42 +++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b95d3c485d27..45a216bea048 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
-- 
2.26.2

