Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5F268146
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgIMVEz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38821 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgIMVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:38 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-KHZAJ5DVMBCB8w9JIXIOHQ-1; Sun, 13 Sep 2020 17:04:30 -0400
X-MC-Unique: KHZAJ5DVMBCB8w9JIXIOHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73BF01074654;
        Sun, 13 Sep 2020 21:04:28 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1B0310021AA;
        Sun, 13 Sep 2020 21:04:24 +0000 (UTC)
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
Subject: [PATCH 15/26] perf tools: Synthesize proc tasks with mmap3
Date:   Sun, 13 Sep 2020 23:03:02 +0200
Message-Id: <20200913210313.1985612-16-jolsa@kernel.org>
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

Synthesizing proc tasks with mmap3 events so we can
get build id data for synthesized maps as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/mmap.c             |  2 +-
 tools/perf/util/synthetic-events.c | 72 +++++++++++++++++-------------
 2 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428..51f6f86580a9 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -33,7 +33,7 @@ void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
 
 	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
 	buf[len] = '\0';
-	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
+	pr_debug2("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
 }
 
 size_t mmap__mmap_len(struct mmap *map)
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 89b390623b63..bd6e7b84283d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -379,7 +379,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	}
 	io__init(&io, io.fd, bf, sizeof(bf));
 
-	event->header.type = PERF_RECORD_MMAP2;
+	event->header.type = PERF_RECORD_MMAP3;
 	t = rdclock();
 
 	while (!io.eof) {
@@ -387,20 +387,20 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		size_t size;
 
 		/* ensure null termination since stack will be reused. */
-		event->mmap2.filename[0] = '\0';
+		event->mmap3.filename[0] = '\0';
 
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
 		if (!read_proc_maps_line(&io,
-					&event->mmap2.start,
-					&event->mmap2.len,
-					&event->mmap2.prot,
-					&event->mmap2.flags,
-					&event->mmap2.pgoff,
-					&event->mmap2.maj,
-					&event->mmap2.min,
-					&event->mmap2.ino,
-					sizeof(event->mmap2.filename),
-					event->mmap2.filename))
+					&event->mmap3.start,
+					&event->mmap3.len,
+					&event->mmap3.prot,
+					&event->mmap3.flags,
+					&event->mmap3.pgoff,
+					&event->mmap3.maj,
+					&event->mmap3.min,
+					&event->mmap3.ino,
+					sizeof(event->mmap3.filename),
+					event->mmap3.filename))
 			continue;
 
 		if ((rdclock() - t) > timeout) {
@@ -412,7 +412,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			goto out;
 		}
 
-		event->mmap2.ino_generation = 0;
+		event->mmap3.ino_generation = 0;
 
 		/*
 		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
@@ -422,8 +422,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		else
 			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
 
-		if ((event->mmap2.prot & PROT_EXEC) == 0) {
-			if (!mmap_data || (event->mmap2.prot & PROT_READ) == 0)
+		if ((event->mmap3.prot & PROT_EXEC) == 0) {
+			if (!mmap_data || (event->mmap3.prot & PROT_READ) == 0)
 				continue;
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
@@ -433,25 +433,37 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		if (truncation)
 			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
 
-		if (!strcmp(event->mmap2.filename, ""))
-			strcpy(event->mmap2.filename, anonstr);
+		if (!strcmp(event->mmap3.filename, ""))
+			strcpy(event->mmap3.filename, anonstr);
 
 		if (hugetlbfs_mnt_len &&
-		    !strncmp(event->mmap2.filename, hugetlbfs_mnt,
+		    !strncmp(event->mmap3.filename, hugetlbfs_mnt,
 			     hugetlbfs_mnt_len)) {
-			strcpy(event->mmap2.filename, anonstr);
-			event->mmap2.flags |= MAP_HUGETLB;
+			strcpy(event->mmap3.filename, anonstr);
+			event->mmap3.flags |= MAP_HUGETLB;
 		}
 
-		size = strlen(event->mmap2.filename) + 1;
+		size = strlen(event->mmap3.filename) + 1;
 		size = PERF_ALIGN(size, sizeof(u64));
-		event->mmap2.len -= event->mmap.start;
-		event->mmap2.header.size = (sizeof(event->mmap2) -
-					(sizeof(event->mmap2.filename) - size));
-		memset(event->mmap2.filename + size, 0, machine->id_hdr_size);
-		event->mmap2.header.size += machine->id_hdr_size;
-		event->mmap2.pid = tgid;
-		event->mmap2.tid = pid;
+		event->mmap3.len -= event->mmap.start;
+		event->mmap3.header.size = (sizeof(event->mmap3) -
+					(sizeof(event->mmap3.filename) - size));
+		memset(event->mmap3.filename + size, 0, machine->id_hdr_size);
+		event->mmap3.header.size += machine->id_hdr_size;
+		event->mmap3.pid = tgid;
+		event->mmap3.tid = pid;
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
 
 		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
 			rc = -1;
@@ -744,7 +756,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 	if (comm_event == NULL)
 		goto out;
 
-	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
+	mmap_event = malloc(sizeof(mmap_event->mmap3) + machine->id_hdr_size);
 	if (mmap_event == NULL)
 		goto out_free_comm;
 
@@ -826,7 +838,7 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
 	if (comm_event == NULL)
 		goto out;
 
-	mmap_event = malloc(sizeof(mmap_event->mmap2) + machine->id_hdr_size);
+	mmap_event = malloc(sizeof(mmap_event->mmap3) + machine->id_hdr_size);
 	if (mmap_event == NULL)
 		goto out_free_comm;
 
-- 
2.26.2

