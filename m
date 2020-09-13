Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF092268147
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIMVFN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46643 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgIMVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141--LVBIL1EO26YGFiBLsw-_A-1; Sun, 13 Sep 2020 17:04:35 -0400
X-MC-Unique: -LVBIL1EO26YGFiBLsw-_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC9603625D;
        Sun, 13 Sep 2020 21:04:32 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E13EE1002388;
        Sun, 13 Sep 2020 21:04:28 +0000 (UTC)
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
Subject: [PATCH 16/26] perf tools: Synthesize modules with mmap3
Date:   Sun, 13 Sep 2020 23:03:03 +0200
Message-Id: <20200913210313.1985612-17-jolsa@kernel.org>
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

Synthesizing modules with mmap3 events so we can
get build id data for module's maps as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/synthetic-events.c | 37 +++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index bd6e7b84283d..6bd2423ce2f3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -605,7 +605,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	int rc = 0;
 	struct map *pos;
 	struct maps *maps = machine__kernel_maps(machine);
-	union perf_event *event = zalloc((sizeof(event->mmap) +
+	union perf_event *event = zalloc((sizeof(event->mmap3) +
 					  machine->id_hdr_size));
 	if (event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
@@ -613,8 +613,6 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 		return -1;
 	}
 
-	event->header.type = PERF_RECORD_MMAP;
-
 	/*
 	 * kernel uses 0 for user space maps, see kernel/perf_event.c
 	 * __perf_event_mmap
@@ -631,17 +629,30 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 			continue;
 
 		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
-		event->mmap.header.type = PERF_RECORD_MMAP;
-		event->mmap.header.size = (sizeof(event->mmap) -
-				        (sizeof(event->mmap.filename) - size));
-		memset(event->mmap.filename + size, 0, machine->id_hdr_size);
-		event->mmap.header.size += machine->id_hdr_size;
-		event->mmap.start = pos->start;
-		event->mmap.len   = pos->end - pos->start;
-		event->mmap.pid   = machine->pid;
-
-		memcpy(event->mmap.filename, pos->dso->long_name,
+		event->mmap3.header.type = PERF_RECORD_MMAP3;
+		event->mmap3.header.size = (sizeof(event->mmap3) -
+					   (sizeof(event->mmap3.filename) - size));
+		memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
+		event->mmap3.header.size += machine->id_hdr_size;
+		event->mmap3.start = pos->start;
+		event->mmap3.len   = pos->end - pos->start;
+		event->mmap3.pid   = machine->pid;
+
+		memcpy(event->mmap3.filename, pos->dso->long_name,
 		       pos->dso->long_name_len + 1);
+
+		rc = filename__read_build_id(event->mmap3.filename, event->mmap3.buildid,
+					     BUILD_ID_SIZE);
+		if (rc != BUILD_ID_SIZE) {
+			if (event->mmap3.filename[0] == '/') {
+				pr_debug2("Failed to read build ID for %s\n",
+					  event->mmap3.filename);
+			}
+			memset(event->mmap3.buildid, 0x0, sizeof(event->mmap3.buildid));
+		}
+
+		rc = 0;
+
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
 			break;
-- 
2.26.2

