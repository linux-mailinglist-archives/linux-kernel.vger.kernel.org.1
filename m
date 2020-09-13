Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2281626814D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgIMVFy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47796 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbgIMVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-Zz0J52RoMGGFghnReHuj4g-1; Sun, 13 Sep 2020 17:05:07 -0400
X-MC-Unique: Zz0J52RoMGGFghnReHuj4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A281882FA1;
        Sun, 13 Sep 2020 21:05:05 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5927F1002388;
        Sun, 13 Sep 2020 21:05:00 +0000 (UTC)
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
Subject: [PATCH 23/26] perf tools: Add __perf_session__cache_build_ids function
Date:   Sun, 13 Sep 2020 23:03:10 +0200
Message-Id: <20200913210313.1985612-24-jolsa@kernel.org>
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

Adding __perf_session__cache_build_ids function as an
interface for caching sessions build ids with callback
function and its data pointer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 10 ++++++++--
 tools/perf/util/build-id.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 22968504c6de..9335a535e547 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -902,7 +902,8 @@ machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
 	return ret ? -1 : 0;
 }
 
-int perf_session__cache_build_ids(struct perf_session *session)
+int __perf_session__cache_build_ids(struct perf_session *session,
+				    machine__dso_t fn, void *priv)
 {
 	if (no_buildid_cache)
 		return 0;
@@ -910,7 +911,12 @@ int perf_session__cache_build_ids(struct perf_session *session)
 	if (mkdir(buildid_dir, 0755) != 0 && errno != EEXIST)
 		return -1;
 
-	return machines__for_each_dso(&session->machines, dso__cache_build_id, NULL) ?  -1 : 0;
+	return machines__for_each_dso(&session->machines, fn, priv) ?  -1 : 0;
+}
+
+int perf_session__cache_build_ids(struct perf_session *session)
+{
+	return __perf_session__cache_build_ids(session, dso__cache_build_id, NULL);
 }
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 6d1c7180047b..ec128e8f7dd3 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -5,6 +5,7 @@
 #define BUILD_ID_SIZE	20
 #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
 
+#include "machine.h"
 #include "tool.h"
 #include <linux/types.h>
 
@@ -36,6 +37,8 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
 int perf_session__write_buildid_table(struct perf_session *session,
 				      struct feat_fd *fd);
 int perf_session__cache_build_ids(struct perf_session *session);
+int __perf_session__cache_build_ids(struct perf_session *session,
+				    machine__dso_t fn, void *priv);
 
 char *build_id_cache__origname(const char *sbuild_id);
 char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size);
-- 
2.26.2

