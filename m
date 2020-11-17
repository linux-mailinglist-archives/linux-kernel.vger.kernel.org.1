Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7073B2B5DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgKQLCJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:09 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:57297 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgKQLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:08 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-HFtlcSCTPuWMlBwUGcU59A-1; Tue, 17 Nov 2020 06:02:03 -0500
X-MC-Unique: HFtlcSCTPuWMlBwUGcU59A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496916D261;
        Tue, 17 Nov 2020 11:02:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494EA5C1CF;
        Tue, 17 Nov 2020 11:01:58 +0000 (UTC)
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
Subject: [PATCH 17/24] perf tools: Use machine__for_each_dso in perf_session__cache_build_ids
Date:   Tue, 17 Nov 2020 12:00:46 +0100
Message-Id: <20201117110053.1303113-18-jolsa@kernel.org>
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

Using machine__for_each_dso in perf_session__cache_build_ids,
so we can reuse perf_session__cache_build_ids with different
callback in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 41 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 2755d7b37a44..9f14d5851bb5 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -854,12 +854,16 @@ int build_id_cache__remove_s(const char *sbuild_id)
 	return err;
 }
 
-static int dso__cache_build_id(struct dso *dso, struct machine *machine)
+static int dso__cache_build_id(struct dso *dso, struct machine *machine,
+			       void *priv __maybe_unused)
 {
 	bool is_kallsyms = dso__is_kallsyms(dso);
 	bool is_vdso = dso__is_vdso(dso);
 	const char *name = dso->long_name;
 
+	if (!dso->has_build_id)
+		return 0;
+
 	if (dso__is_kcore(dso)) {
 		is_kallsyms = true;
 		name = machine->mmap_name;
@@ -868,43 +872,30 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
 				     is_kallsyms, is_vdso);
 }
 
-static int __dsos__cache_build_ids(struct list_head *head,
-				   struct machine *machine)
+static int
+machines__for_each_dso(struct machines *machines, machine__dso_t fn, void *priv)
 {
-	struct dso *pos;
-	int err = 0;
-
-	dsos__for_each_with_build_id(pos, head)
-		if (dso__cache_build_id(pos, machine))
-			err = -1;
+	int ret = machine__for_each_dso(&machines->host, fn, priv);
+	struct rb_node *nd;
 
-	return err;
-}
+	for (nd = rb_first_cached(&machines->guests); nd;
+	     nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 
-static int machine__cache_build_ids(struct machine *machine)
-{
-	return __dsos__cache_build_ids(&machine->dsos.head, machine);
+		ret |= machine__for_each_dso(pos, fn, priv);
+	}
+	return ret ? -1 : 0;
 }
 
 int perf_session__cache_build_ids(struct perf_session *session)
 {
-	struct rb_node *nd;
-	int ret;
-
 	if (no_buildid_cache)
 		return 0;
 
 	if (mkdir(buildid_dir, 0755) != 0 && errno != EEXIST)
 		return -1;
 
-	ret = machine__cache_build_ids(&session->machines.host);
-
-	for (nd = rb_first_cached(&session->machines.guests); nd;
-	     nd = rb_next(nd)) {
-		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret |= machine__cache_build_ids(pos);
-	}
-	return ret ? -1 : 0;
+	return machines__for_each_dso(&session->machines, dso__cache_build_id, NULL) ?  -1 : 0;
 }
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
-- 
2.26.2

