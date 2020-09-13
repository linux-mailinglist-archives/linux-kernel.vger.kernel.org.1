Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2227268143
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgIMVEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbgIMVEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-mhLi_TS_N7SOq_Eja_3X2A-1; Sun, 13 Sep 2020 17:04:18 -0400
X-MC-Unique: mhLi_TS_N7SOq_Eja_3X2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 490C52FD14;
        Sun, 13 Sep 2020 21:04:16 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE5691002388;
        Sun, 13 Sep 2020 21:04:12 +0000 (UTC)
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
Subject: [PATCH 12/26] perf tools: Set build id for kernel dso objects
Date:   Sun, 13 Sep 2020 23:02:59 +0200
Message-Id: <20200913210313.1985612-13-jolsa@kernel.org>
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

Setting build id for kernel dso objects when parsed
from mmap3 event.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 17d6fd19ef79..863d949ef967 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1590,7 +1590,8 @@ static int machine__process_extra_kernel_map(struct machine *machine,
 }
 
 static int machine__process_kernel_mmap_event(struct machine *machine,
-					      struct extra_kernel_map *xm)
+					      struct extra_kernel_map *xm,
+					      __u8 *buildid)
 {
 	struct map *map;
 	enum dso_space_type dso_space;
@@ -1615,6 +1616,9 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			goto out_problem;
 
 		map->end = map->start + xm->end - xm->start;
+
+		if (build_id__is_defined(buildid))
+			dso__set_build_id(map->dso, buildid);
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = (xm->name + strlen(machine->mmap_name));
 		/*
@@ -1672,6 +1676,9 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 
 		machine__update_kernel_mmap(machine, xm->start, xm->end);
 
+		if (build_id__is_defined(buildid))
+			dso__set_build_id(kernel, buildid);
+
 		/*
 		 * Avoid using a zero address (kptr_restrict) for the ref reloc
 		 * symbol. Effectively having zero here means that at record
@@ -1724,7 +1731,7 @@ int machine__process_mmap3_event(struct machine *machine,
 		};
 
 		strlcpy(xm.name, event->mmap3.filename, KMAP_NAME_LEN);
-		ret = machine__process_kernel_mmap_event(machine, &xm);
+		ret = machine__process_kernel_mmap_event(machine, &xm, event->mmap3.buildid);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1791,7 +1798,7 @@ int machine__process_mmap2_event(struct machine *machine,
 		};
 
 		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
-		ret = machine__process_kernel_mmap_event(machine, &xm);
+		ret = machine__process_kernel_mmap_event(machine, &xm, NULL);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1848,7 +1855,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 		};
 
 		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
-		ret = machine__process_kernel_mmap_event(machine, &xm);
+		ret = machine__process_kernel_mmap_event(machine, &xm, NULL);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
-- 
2.26.2

