Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C542B5DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgKQLB6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:58 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:57092 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgKQLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:58 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-fxckYe3GOe2krc0srXN77Q-1; Tue, 17 Nov 2020 06:01:53 -0500
X-MC-Unique: fxckYe3GOe2krc0srXN77Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37031100855D;
        Tue, 17 Nov 2020 11:01:51 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330295C1CF;
        Tue, 17 Nov 2020 11:01:48 +0000 (UTC)
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
Subject: [PATCH 14/24] perf tools: Allow mmap2 event to synthesize modules
Date:   Tue, 17 Nov 2020 12:00:43 +0100
Message-Id: <20201117110053.1303113-15-jolsa@kernel.org>
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

Allow mmap2 event to synthesize kernel modules,
so we can synthesize module's build id data in
following changes.

It's enabled by new symbol_conf.buildid_mmap2
bool, which will be switched in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 872df6d6dbef..a18ae502d765 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -593,16 +593,17 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	int rc = 0;
 	struct map *pos;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event = zalloc((sizeof(event->mmap) +
-					  machine->id_hdr_size));
+	union perf_event *event;
+	size_t size = symbol_conf.buildid_mmap2 ?
+			sizeof(event->mmap2) : sizeof(event->mmap);
+
+	event = zalloc(size + machine->id_hdr_size);
 	if (event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
 		return -1;
 	}
 
-	event->header.type = PERF_RECORD_MMAP;
-
 	/*
 	 * kernel uses 0 for user space maps, see kernel/perf_event.c
 	 * __perf_event_mmap
@@ -613,23 +614,37 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 
 	maps__for_each_entry(maps, pos) {
-		size_t size;
-
 		if (!__map__is_kmodule(pos))
 			continue;
 
-		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
-		event->mmap.header.type = PERF_RECORD_MMAP;
-		event->mmap.header.size = (sizeof(event->mmap) -
-				        (sizeof(event->mmap.filename) - size));
-		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-		event->mmap.header.size += machine->id_hdr_size;
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pid   = machine->pid;
+		if (symbol_conf.buildid_mmap2) {
+			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			event->mmap2.header.type = PERF_RECORD_MMAP2;
+			event->mmap2.header.size = (sizeof(event->mmap2) -
+						(sizeof(event->mmap2.filename) - size));
+			memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
+			event->mmap2.header.size += machine->id_hdr_size;
+			event->mmap2.start = pos->start;
+			event->mmap2.len   = pos->end - pos->start;
+			event->mmap2.pid   = machine->pid;
+
+			memcpy(event->mmap2.filename, pos->dso->long_name,
+			       pos->dso->long_name_len + 1);
+		} else {
+			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
+			event->mmap.header.type = PERF_RECORD_MMAP;
+			event->mmap.header.size = (sizeof(event->mmap) -
+						(sizeof(event->mmap.filename) - size));
+			memset(event->mmap.filename + size, 0, machine->id_hdr_size);
+			event->mmap.header.size += machine->id_hdr_size;
+			event->mmap.start = pos->start;
+			event->mmap.len   = pos->end - pos->start;
+			event->mmap.pid   = machine->pid;
+
+			memcpy(event->mmap.filename, pos->dso->long_name,
+			       pos->dso->long_name_len + 1);
+		}
 
-		memcpy(event->mmap.filename, pos->dso->long_name,
-		       pos->dso->long_name_len + 1);
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
 			break;
-- 
2.26.2

