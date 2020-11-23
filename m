Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4F92C1947
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgKWXIg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:08:36 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:48548 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388237AbgKWXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:06:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Eb7NYfDRPiWJ68hJw_jukg-1; Mon, 23 Nov 2020 18:06:26 -0500
X-MC-Unique: Eb7NYfDRPiWJ68hJw_jukg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A175F100A240;
        Mon, 23 Nov 2020 23:06:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336535D9CA;
        Mon, 23 Nov 2020 23:06:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/25] perf tools: Add support to display build id for mmap2 events
Date:   Tue, 24 Nov 2020 00:05:04 +0100
Message-Id: <20201123230512.2097312-18-jolsa@kernel.org>
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

Adding support to display build id in mmap2 events:

  $ perf script --show-mmap-events | head -4
  swapper ... @ 0xffffffff81000000 <ff1969b3ba5e43911208bb46fa7d5b1eb809e422>]: ---p [kernel.kallsyms]_text
  swapper ... @ 0 <5f62adb730272c9417883ae8b8a8ec224df8cddd>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/drivers/firmware/qemu_fw_cfg.ko
  swapper ... @ 0 <c9ac6e1dafc1ebdadb048f967854e810706c8bab>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/drivers/char/virtio_console.ko
  swapper ... @ 0 <86441a4c5b2c2ff5b440682f4c612bd4b426eb5c>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/lib/libcrc32c.ko

  $ perf report -D | grep MMAP2 | head -4
  0 0 ... @ 0xffffffff81000000 <ff1969b3ba5e43911208bb46fa7d5b1eb809e422>]: ---p [kernel.kallsyms]_text
  0 0 ... @ 0 <5f62adb730272c9417883ae8b8a8ec224df8cddd>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/drivers/firmware/qemu_fw_cfg.ko
  0 0 ... @ 0 <c9ac6e1dafc1ebdadb048f967854e810706c8bab>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/drivers/char/virtio_console.ko
  0 0 ... @ 0 <86441a4c5b2c2ff5b440682f4c612bd4b426eb5c>]: ---p /lib/modules/5.9.0-rc5buildid+/kernel/lib/libcrc32c.ko

Adding build id data into <> brackets.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/event.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 05616d4138a9..fbe8578e4c47 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -288,17 +288,36 @@ size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
-			   " %02x:%02x %"PRI_lu64" %"PRI_lu64"]: %c%c%c%c %s\n",
-		       event->mmap2.pid, event->mmap2.tid, event->mmap2.start,
-		       event->mmap2.len, event->mmap2.pgoff, event->mmap2.maj,
-		       event->mmap2.min, event->mmap2.ino,
-		       event->mmap2.ino_generation,
-		       (event->mmap2.prot & PROT_READ) ? 'r' : '-',
-		       (event->mmap2.prot & PROT_WRITE) ? 'w' : '-',
-		       (event->mmap2.prot & PROT_EXEC) ? 'x' : '-',
-		       (event->mmap2.flags & MAP_SHARED) ? 's' : 'p',
-		       event->mmap2.filename);
+	if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
+		char sbuild_id[SBUILD_ID_SIZE];
+		struct build_id bid;
+
+		build_id__init(&bid, event->mmap2.build_id,
+			       event->mmap2.build_id_size);
+		build_id__sprintf(&bid, sbuild_id);
+
+		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
+				   " <%s>]: %c%c%c%c %s\n",
+			       event->mmap2.pid, event->mmap2.tid, event->mmap2.start,
+			       event->mmap2.len, event->mmap2.pgoff, sbuild_id,
+			       (event->mmap2.prot & PROT_READ) ? 'r' : '-',
+			       (event->mmap2.prot & PROT_WRITE) ? 'w' : '-',
+			       (event->mmap2.prot & PROT_EXEC) ? 'x' : '-',
+			       (event->mmap2.flags & MAP_SHARED) ? 's' : 'p',
+			       event->mmap2.filename);
+	} else {
+		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
+				   " %02x:%02x %"PRI_lu64" %"PRI_lu64"]: %c%c%c%c %s\n",
+			       event->mmap2.pid, event->mmap2.tid, event->mmap2.start,
+			       event->mmap2.len, event->mmap2.pgoff, event->mmap2.maj,
+			       event->mmap2.min, event->mmap2.ino,
+			       event->mmap2.ino_generation,
+			       (event->mmap2.prot & PROT_READ) ? 'r' : '-',
+			       (event->mmap2.prot & PROT_WRITE) ? 'w' : '-',
+			       (event->mmap2.prot & PROT_EXEC) ? 'x' : '-',
+			       (event->mmap2.flags & MAP_SHARED) ? 's' : 'p',
+			       event->mmap2.filename);
+	}
 }
 
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp)
-- 
2.26.2

