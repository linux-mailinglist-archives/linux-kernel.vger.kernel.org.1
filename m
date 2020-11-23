Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E382C2C193F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgKWXGt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:06:49 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:41142 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388268AbgKWXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:06:45 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-ZAmwqwsPNtil_dr7LyrCng-1; Mon, 23 Nov 2020 18:06:40 -0500
X-MC-Unique: ZAmwqwsPNtil_dr7LyrCng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32EDE100A241;
        Mon, 23 Nov 2020 23:06:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30DBC5D9CA;
        Mon, 23 Nov 2020 23:06:35 +0000 (UTC)
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
Subject: [PATCH 21/25] perf tools: Add build_id_cache__add function
Date:   Tue, 24 Nov 2020 00:05:08 +0100
Message-Id: <20201123230512.2097312-22-jolsa@kernel.org>
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

Adding build_id_cache__add function as core function
that adds file into build id database. It will be
set from another callers in following changes.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 42 ++++++++++++++++++++++++--------------
 tools/perf/util/build-id.h |  2 ++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 6bf3cc79c5d5..02df36b30ac5 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -671,24 +671,15 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 	return realname;
 }
 
-int build_id_cache__add_s(const char *sbuild_id, const char *name,
-			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
+int
+build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
+		    struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
 {
 	const size_t size = PATH_MAX;
-	char *realname = NULL, *filename = NULL, *dir_name = NULL,
-	     *linkname = zalloc(size), *tmp;
+	char *filename = NULL, *dir_name = NULL, *linkname = zalloc(size), *tmp;
 	char *debugfile = NULL;
 	int err = -1;
 
-	if (!is_kallsyms) {
-		if (!is_vdso)
-			realname = nsinfo__realpath(name, nsi);
-		else
-			realname = realpath(name, NULL);
-		if (!realname)
-			goto out_free;
-	}
-
 	dir_name = build_id_cache__cachedir(sbuild_id, name, nsi, is_kallsyms,
 					    is_vdso);
 	if (!dir_name)
@@ -788,8 +779,6 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 		pr_debug4("Failed to update/scan SDT cache for %s\n", realname);
 
 out_free:
-	if (!is_kallsyms)
-		free(realname);
 	free(filename);
 	free(debugfile);
 	free(dir_name);
@@ -797,6 +786,29 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 	return err;
 }
 
+int build_id_cache__add_s(const char *sbuild_id, const char *name,
+			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
+{
+	char *realname = NULL;
+	int err = -1;
+
+	if (!is_kallsyms) {
+		if (!is_vdso)
+			realname = nsinfo__realpath(name, nsi);
+		else
+			realname = realpath(name, NULL);
+		if (!realname)
+			goto out_free;
+	}
+
+	err = build_id_cache__add(sbuild_id, name, realname, nsi, is_kallsyms, is_vdso);
+
+out_free:
+	if (!is_kallsyms)
+		free(realname);
+	return err;
+}
+
 static int build_id_cache__add_b(const struct build_id *bid,
 				 const char *name, struct nsinfo *nsi,
 				 bool is_kallsyms, bool is_vdso)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index c6f10e3d2152..02613f4b2c29 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -63,6 +63,8 @@ char *build_id_cache__complement(const char *incomplete_sbuild_id);
 int build_id_cache__list_build_ids(const char *pathname, struct nsinfo *nsi,
 				   struct strlist **result);
 bool build_id_cache__cached(const char *sbuild_id);
+int build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
+			struct nsinfo *nsi, bool is_kallsyms, bool is_vdso);
 int build_id_cache__add_s(const char *sbuild_id,
 			  const char *name, struct nsinfo *nsi,
 			  bool is_kallsyms, bool is_vdso);
-- 
2.26.2

