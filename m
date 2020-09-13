Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBF26814C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgIMVFq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34631 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgIMVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:07 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-I8B8Bx1vO-SDjVEPXhwciQ-1; Sun, 13 Sep 2020 17:05:02 -0400
X-MC-Unique: I8B8Bx1vO-SDjVEPXhwciQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF21B1005E62;
        Sun, 13 Sep 2020 21:04:59 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6683C10021AA;
        Sun, 13 Sep 2020 21:04:56 +0000 (UTC)
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
Subject: [PATCH 22/26] perf tools: Use machine__for_each_dso in perf_session__cache_build_ids
Date:   Sun, 13 Sep 2020 23:03:09 +0200
Message-Id: <20200913210313.1985612-23-jolsa@kernel.org>
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

Using machine__for_each_dso in perf_session__cache_build_ids,
so we can reuse perf_session__cache_build_ids with different
callback in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 41 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bf044e52ad1f..22968504c6de 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -869,12 +869,16 @@ int build_id_cache__remove_s(const char *sbuild_id)
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
@@ -883,43 +887,30 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
 				     dso->nsinfo, is_kallsyms, is_vdso);
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

