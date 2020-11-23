Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3932C1933
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgKWXFx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:05:53 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:37829 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733150AbgKWXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:05:50 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-yIffSHEZMwq6x5GH3ysMiw-1; Mon, 23 Nov 2020 18:05:45 -0500
X-MC-Unique: yIffSHEZMwq6x5GH3ysMiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B07381CBE1;
        Mon, 23 Nov 2020 23:05:43 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56C0A5D9CA;
        Mon, 23 Nov 2020 23:05:40 +0000 (UTC)
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
Subject: [PATCH 06/25] perf tools: Do not swap mmap2 fields in case it contains build id
Date:   Tue, 24 Nov 2020 00:04:53 +0100
Message-Id: <20201123230512.2097312-7-jolsa@kernel.org>
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

If PERF_RECORD_MISC_MMAP_BUILD_ID misc bit is set,
mmap2 event carries build id, placed in following union:

  union {
          struct {
                  u32       maj;
                  u32       min;
                  u64       ino;
                  u64       ino_generation;
          };
          struct {
                  u8        build_id[20];
                  u8        build_id_size;
                  u8        __reserved_1;
                  u16       __reserved_2;
          };
  };

In this case we can't swap above fields.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5cc722b6fe7c..cc1c11ca94fd 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -592,10 +592,13 @@ static void perf_event__mmap2_swap(union perf_event *event,
 	event->mmap2.start = bswap_64(event->mmap2.start);
 	event->mmap2.len   = bswap_64(event->mmap2.len);
 	event->mmap2.pgoff = bswap_64(event->mmap2.pgoff);
-	event->mmap2.maj   = bswap_32(event->mmap2.maj);
-	event->mmap2.min   = bswap_32(event->mmap2.min);
-	event->mmap2.ino   = bswap_64(event->mmap2.ino);
-	event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
+
+	if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
+		event->mmap2.maj   = bswap_32(event->mmap2.maj);
+		event->mmap2.min   = bswap_32(event->mmap2.min);
+		event->mmap2.ino   = bswap_64(event->mmap2.ino);
+		event->mmap2.ino_generation = bswap_64(event->mmap2.ino_generation);
+	}
 
 	if (sample_id_all) {
 		void *data = &event->mmap2.filename;
-- 
2.26.2

