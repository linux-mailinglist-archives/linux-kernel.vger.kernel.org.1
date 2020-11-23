Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F2D2C193B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbgKWXGg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:06:36 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29541 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388090AbgKWXGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:06:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-2gTQ_S_MN26Ov5Qs8-S8tw-1; Mon, 23 Nov 2020 18:06:14 -0500
X-MC-Unique: 2gTQ_S_MN26Ov5Qs8-S8tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA57100A25A;
        Mon, 23 Nov 2020 23:06:12 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBBFC5D9CA;
        Mon, 23 Nov 2020 23:06:09 +0000 (UTC)
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
Subject: [PATCH 14/25] perf tools: Allow mmap2 event to synthesize kernel image
Date:   Tue, 24 Nov 2020 00:05:01 +0100
Message-Id: <20201123230512.2097312-15-jolsa@kernel.org>
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

Allow mmap2 event to synthesize kernel image,
so we can synthesize kernel build id data in
following changes.

It's enabled by new symbol_conf.buildid_mmap2
bool, which will be switched in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol_conf.h      |  3 ++-
 tools/perf/util/synthetic-events.c | 40 ++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index b916afb95ec5..b18f9c8dbb75 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -42,7 +42,8 @@ struct symbol_conf {
 			report_block,
 			report_individual_block,
 			inline_name,
-			disable_add2line_warn;
+			disable_add2line_warn,
+			buildid_mmap2;
 	const char	*vmlinux_name,
 			*kallsyms_name,
 			*source_prefix,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8a23391558cf..872df6d6dbef 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -988,11 +988,12 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 						perf_event__handler_t process,
 						struct machine *machine)
 {
-	size_t size;
+	union perf_event *event;
+	size_t size = symbol_conf.buildid_mmap2 ?
+			sizeof(event->mmap2) : sizeof(event->mmap);
 	struct map *map = machine__kernel_map(machine);
 	struct kmap *kmap;
 	int err;
-	union perf_event *event;
 
 	if (map == NULL)
 		return -1;
@@ -1006,7 +1007,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 	 * available use this, and after it is use this as a fallback for older
 	 * kernels.
 	 */
-	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
+	event = zalloc(size + machine->id_hdr_size);
 	if (event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
@@ -1023,16 +1024,29 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 	}
 
-	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
-			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
-	size = PERF_ALIGN(size, sizeof(u64));
-	event->mmap.header.type = PERF_RECORD_MMAP;
-	event->mmap.header.size = (sizeof(event->mmap) -
-			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
-	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
-	event->mmap.start = map->start;
-	event->mmap.len   = map->end - event->mmap.start;
-	event->mmap.pid   = machine->pid;
+	if (symbol_conf.buildid_mmap2) {
+		size = snprintf(event->mmap2.filename, sizeof(event->mmap2.filename),
+				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
+		size = PERF_ALIGN(size, sizeof(u64));
+		event->mmap2.header.type = PERF_RECORD_MMAP2;
+		event->mmap2.header.size = (sizeof(event->mmap2) -
+				(sizeof(event->mmap2.filename) - size) + machine->id_hdr_size);
+		event->mmap2.pgoff = kmap->ref_reloc_sym->addr;
+		event->mmap2.start = map->start;
+		event->mmap2.len   = map->end - event->mmap.start;
+		event->mmap2.pid   = machine->pid;
+	} else {
+		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
+				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
+		size = PERF_ALIGN(size, sizeof(u64));
+		event->mmap.header.type = PERF_RECORD_MMAP;
+		event->mmap.header.size = (sizeof(event->mmap) -
+				(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
+		event->mmap.pgoff = kmap->ref_reloc_sym->addr;
+		event->mmap.start = map->start;
+		event->mmap.len   = map->end - event->mmap.start;
+		event->mmap.pid   = machine->pid;
+	}
 
 	err = perf_tool__process_synth_event(tool, event, machine, process);
 	free(event);
-- 
2.26.2

