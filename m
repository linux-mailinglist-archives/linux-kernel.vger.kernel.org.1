Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDE26814B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIMVFh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgIMVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:01 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-qETf2qFUPxe894uLK0xPGQ-1; Sun, 13 Sep 2020 17:04:54 -0400
X-MC-Unique: qETf2qFUPxe894uLK0xPGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27FE7801AAE;
        Sun, 13 Sep 2020 21:04:52 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 831BD1002388;
        Sun, 13 Sep 2020 21:04:47 +0000 (UTC)
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
Subject: [PATCH 20/26] perf tools: Add build_id_cache__add function
Date:   Sun, 13 Sep 2020 23:03:07 +0200
Message-Id: <20200913210313.1985612-21-jolsa@kernel.org>
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

Adding build_id_cache__add function as core function
that adds file into build id database. It will be
sed from another callers in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 42 ++++++++++++++++++++++++--------------
 tools/perf/util/build-id.h |  2 ++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index b281c97894e0..bf044e52ad1f 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -668,24 +668,15 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
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
@@ -786,8 +777,6 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 		pr_debug4("Failed to update/scan SDT cache for %s\n", realname);
 
 out_free:
-	if (!is_kallsyms)
-		free(realname);
 	free(filename);
 	free(debugfile);
 	free(dir_name);
@@ -795,6 +784,29 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
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
 static int build_id_cache__add_b(const u8 *build_id, size_t build_id_size,
 				 const char *name, struct nsinfo *nsi,
 				 bool is_kallsyms, bool is_vdso)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 2cf87b7304e2..6d1c7180047b 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -50,6 +50,8 @@ char *build_id_cache__complement(const char *incomplete_sbuild_id);
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

