Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6550C2AC7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgKIVyu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 16:54:50 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52779 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731122AbgKIVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:54:48 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-9nkhzuXgNwOVNlF1t36SRQ-1; Mon, 09 Nov 2020 16:54:41 -0500
X-MC-Unique: 9nkhzuXgNwOVNlF1t36SRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90BE3879532;
        Mon,  9 Nov 2020 21:54:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A4F06EF46;
        Mon,  9 Nov 2020 21:54:35 +0000 (UTC)
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
Subject: [PATCH 04/24] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
Date:   Mon,  9 Nov 2020 22:53:55 +0100
Message-Id: <20201109215415.400153-5-jolsa@kernel.org>
In-Reply-To: <20201109215415.400153-1-jolsa@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 tools/include/uapi/linux/perf_event.h | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b95d3c485d27..b6caf61bf9fd 100644
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
@@ -688,6 +689,7 @@ struct perf_event_mmap_page {
  *
  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *   PERF_RECORD_MISC_BUILD_ID           - PERF_RECORD_MMAP2 event
  *
  *
  * PERF_RECORD_MISC_EXACT_IP:
@@ -697,9 +699,13 @@ struct perf_event_mmap_page {
  *
  * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
  *   Indicates that thread was preempted in TASK_RUNNING state.
+ *
+ * PERF_RECORD_MISC_BUILD_ID:
+ *   Indicates that mmap2 event carries build id data.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
 #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
+#define PERF_RECORD_MISC_BUILD_ID		(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
@@ -911,10 +917,20 @@ enum perf_event_type {
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
+	 *			u8		build_id[20];
+	 *			u8		build_id_size;
+	 *			u8		__reserved_1;
+	 *			u16		__reserved_2;
+	 *		};
+	 *	};
 	 *	u32				prot, flags;
 	 *	char				filename[];
 	 * 	struct sample_id		sample_id;
-- 
2.26.2

