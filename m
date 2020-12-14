Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA2B2D96D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407422AbgLNK5r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Dec 2020 05:57:47 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:56604 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407343AbgLNK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:57:00 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-qgEGsDKMMi6b2TwnfViS_A-1; Mon, 14 Dec 2020 05:56:05 -0500
X-MC-Unique: qgEGsDKMMi6b2TwnfViS_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA0C3107ACE3;
        Mon, 14 Dec 2020 10:56:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC687048B;
        Mon, 14 Dec 2020 10:56:00 +0000 (UTC)
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
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/15] perf tools: Synthesize build id for kernel/modules/tasks
Date:   Mon, 14 Dec 2020 11:54:52 +0100
Message-Id: <20201214105457.543111-11-jolsa@kernel.org>
In-Reply-To: <20201214105457.543111-1-jolsa@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index c209377106f5..a8d951a79f5e 100644
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
@@ -633,6 +661,8 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 
 			memcpy(event->mmap2.filename, pos->dso->long_name,
 			       pos->dso->long_name_len + 1);
+
+			perf_record_mmap2__read_build_id(&event->mmap2, false);
 		} else {
 			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
 			event->mmap.header.type = PERF_RECORD_MMAP;
@@ -1053,6 +1083,8 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
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

