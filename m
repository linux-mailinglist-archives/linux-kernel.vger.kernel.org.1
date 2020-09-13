Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F759268149
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgIMVFZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbgIMVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-AEloILrnPkKE0o-_c_2Umw-1; Sun, 13 Sep 2020 17:04:41 -0400
X-MC-Unique: AEloILrnPkKE0o-_c_2Umw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BF1B1882FA1;
        Sun, 13 Sep 2020 21:04:39 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47A0610021AA;
        Sun, 13 Sep 2020 21:04:33 +0000 (UTC)
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
Subject: [PATCH 17/26] perf tools: Synthesize kernel with mmap3
Date:   Sun, 13 Sep 2020 23:03:04 +0200
Message-Id: <20200913210313.1985612-18-jolsa@kernel.org>
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

Synthesizing kernel with mmap3 events so we can
get build id data for kernel map as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/synthetic-events.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 6bd2423ce2f3..844ca87b6e97 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1029,7 +1029,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 	 * available use this, and after it is use this as a fallback for older
 	 * kernels.
 	 */
-	event = zalloc((sizeof(event->mmap) + machine->id_hdr_size));
+	event = zalloc((sizeof(event->mmap3) + machine->id_hdr_size));
 	if (event == NULL) {
 		pr_debug("Not enough memory synthesizing mmap event "
 			 "for kernel modules\n");
@@ -1046,16 +1046,21 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		event->header.misc = PERF_RECORD_MISC_GUEST_KERNEL;
 	}
 
-	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
+	size = snprintf(event->mmap3.filename, sizeof(event->mmap3.filename),
 			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
 	size = PERF_ALIGN(size, sizeof(u64));
-	event->mmap.header.type = PERF_RECORD_MMAP;
-	event->mmap.header.size = (sizeof(event->mmap) -
-			(sizeof(event->mmap.filename) - size) + machine->id_hdr_size);
-	event->mmap.pgoff = kmap->ref_reloc_sym->addr;
-	event->mmap.start = map->start;
-	event->mmap.len   = map->end - event->mmap.start;
-	event->mmap.pid   = machine->pid;
+	event->mmap3.header.type = PERF_RECORD_MMAP3;
+	event->mmap3.header.size = (sizeof(event->mmap3) -
+			(sizeof(event->mmap3.filename) - size) + machine->id_hdr_size);
+	event->mmap3.pgoff = kmap->ref_reloc_sym->addr;
+	event->mmap3.start = map->start;
+	event->mmap3.len   = map->end - event->mmap3.start;
+	event->mmap3.pid   = machine->pid;
+
+	err = sysfs__read_build_id("/sys/kernel/notes", event->mmap3.buildid,
+				   BUILD_ID_SIZE);
+	if (err)
+		pr_err("Failed to read kernel build ID\n");
 
 	err = perf_tool__process_synth_event(tool, event, machine, process);
 	free(event);
-- 
2.26.2

