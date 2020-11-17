Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD53C2B5DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKQLCO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:14 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28344 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgKQLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:13 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-FS01xKvgMuiQ96-QNTgZjA-1; Tue, 17 Nov 2020 06:02:06 -0500
X-MC-Unique: FS01xKvgMuiQ96-QNTgZjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C03D6D241;
        Tue, 17 Nov 2020 11:02:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1A505C1D0;
        Tue, 17 Nov 2020 11:02:01 +0000 (UTC)
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
Subject: [PATCH 18/24] perf tools: Add __perf_session__cache_build_ids function
Date:   Tue, 17 Nov 2020 12:00:47 +0100
Message-Id: <20201117110053.1303113-19-jolsa@kernel.org>
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

Adding __perf_session__cache_build_ids function as an
interface for caching sessions build ids with callback
function and its data pointer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 10 ++++++++--
 tools/perf/util/build-id.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 9f14d5851bb5..dc8f864fe15a 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -887,7 +887,8 @@ machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
 	return ret ? -1 : 0;
 }
 
-int perf_session__cache_build_ids(struct perf_session *session)
+int __perf_session__cache_build_ids(struct perf_session *session,
+				    machine__dso_t fn, void *priv)
 {
 	if (no_buildid_cache)
 		return 0;
@@ -895,7 +896,12 @@ int perf_session__cache_build_ids(struct perf_session *session)
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
index f1a2f67df6e4..c6f10e3d2152 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -5,6 +5,7 @@
 #define BUILD_ID_SIZE	20
 #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
 
+#include "machine.h"
 #include "tool.h"
 #include <linux/types.h>
 
@@ -46,6 +47,8 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
 int perf_session__write_buildid_table(struct perf_session *session,
 				      struct feat_fd *fd);
 int perf_session__cache_build_ids(struct perf_session *session);
+int __perf_session__cache_build_ids(struct perf_session *session,
+				    machine__dso_t fn, void *priv);
 
 char *build_id_cache__origname(const char *sbuild_id);
 char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size);
-- 
2.26.2

