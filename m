Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF712B5DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgKQLCC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:02 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23437 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgKQLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:01 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-_KGSjmpOPkGtaNOfD3r7dA-1; Tue, 17 Nov 2020 06:01:56 -0500
X-MC-Unique: _KGSjmpOPkGtaNOfD3r7dA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E14B873183;
        Tue, 17 Nov 2020 11:01:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90EDB5C1CF;
        Tue, 17 Nov 2020 11:01:51 +0000 (UTC)
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
Subject: [PATCH 15/24] perf tools: Synthesize build id for kernel/modules/tasks
Date:   Tue, 17 Nov 2020 12:00:44 +0100
Message-Id: <20201117110053.1303113-16-jolsa@kernel.org>
In-Reply-To: <20201117110053.1303113-1-jolsa@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding build id to synthesized mmap2 events for
everything - kernel/modules/tasks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/synthetic-events.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a18ae502d765..91b1962d399c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -347,6 +347,31 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 	}
 }
 
+static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
+					     bool is_kernel)
+{
+	struct build_id bid;
+	int rc;
+
+	if (is_kernel)
+		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
+	else
+		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+
+	if (rc == 0) {
+		memcpy(event->build_id, bid.data, sizeof(bid.data));
+		event->build_id_size = (u8) bid.size;
+		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
+		event->__reserved_1 = 0;
+		event->__reserved_2 = 0;
+	} else {
+		if (event->filename[0] == '/') {
+			pr_debug2("Failed to read build ID for %s\n",
+				  event->filename);
+		}
+	}
+}
+
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid,
@@ -453,6 +478,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		event->mmap2.pid = tgid;
 		event->mmap2.tid = pid;
 
+		if (symbol_conf.buildid_mmap2)
+			perf_record_mmap2__read_build_id(&event->mmap2, false);
+
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
 			break;
@@ -630,6 +658,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 
 			memcpy(event->mmap2.filename, pos->dso->long_name,
 			       pos->dso->long_name_len + 1);
+
+			perf_record_mmap2__read_build_id(&event->mmap2, false);
 		} else {
 			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
@@ -1050,6 +1080,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->mmap2.start = map->start;
 		event->mmap2.len   = map->end - event->mmap.start;
 		event->mmap2.pid   = machine->pid;
+
+		perf_record_mmap2__read_build_id(&event->mmap2, true);
 	} else {
 		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
 				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
-- 
2.26.2

