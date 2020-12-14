Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4F2D96B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407483AbgLNK6K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Dec 2020 05:58:10 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39348 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbgLNK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:57:12 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-MhS6hHyYMiS1hb3VZEW9XA-1; Mon, 14 Dec 2020 05:56:17 -0500
X-MC-Unique: MhS6hHyYMiS1hb3VZEW9XA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8FE1005D53;
        Mon, 14 Dec 2020 10:56:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8387F70498;
        Mon, 14 Dec 2020 10:56:04 +0000 (UTC)
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
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/15] perf tools: Add support to display build id for mmap2 events
Date:   Mon, 14 Dec 2020 11:54:53 +0100
Message-Id: <20201214105457.543111-12-jolsa@kernel.org>
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

