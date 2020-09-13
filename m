Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184126814E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIMVF4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgIMVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:14 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-G-9DW2UkNyKLTH3yIdPWtw-1; Sun, 13 Sep 2020 17:04:04 -0400
X-MC-Unique: G-9DW2UkNyKLTH3yIdPWtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AEB61074651;
        Sun, 13 Sep 2020 21:04:02 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 994CE10021AA;
        Sun, 13 Sep 2020 21:03:58 +0000 (UTC)
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
Subject: [PATCH 09/26] perf tools: Try load vmlinux from buildid database
Date:   Sun, 13 Sep 2020 23:02:56 +0200
Message-Id: <20200913210313.1985612-10-jolsa@kernel.org>
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

Currently we don't check on kernel's vmlinux the same way as
we do for normal binaries, but we either look for kallsyms
file in build id database or check on known vmlinux locations
(plus some other optional paths).

This patch adds the check for standard build id binary location,
so we are ready once we start to store it there from debuginfod
in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 13 ++++++++++---
 tools/perf/util/build-id.h |  2 ++
 tools/perf/util/symbol.c   | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index ecdc167aa1a0..6165f9d1d941 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -259,10 +259,9 @@ static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
 	    "debug" : "elf"));
 }
 
-char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
-			     bool is_debug)
+char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			       bool is_debug, bool is_kallsyms)
 {
-	bool is_kallsyms = dso__is_kallsyms((struct dso *)dso);
 	bool is_vdso = dso__is_vdso((struct dso *)dso);
 	char sbuild_id[SBUILD_ID_SIZE];
 	char *linkname;
@@ -291,6 +290,14 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 	return bf;
 }
 
+char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			     bool is_debug)
+{
+	bool is_kallsyms = dso__is_kallsyms((struct dso *)dso);
+
+	return __dso__build_id_filename(dso, bf, size, is_debug, is_kallsyms);
+}
+
 #define dsos__for_each_with_build_id(pos, head)	\
 	list_for_each_entry(pos, head, node)	\
 		if (!pos->has_build_id)		\
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 1ceede45c231..2cf87b7304e2 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -23,6 +23,8 @@ char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
 
 char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 			     bool is_debug);
+char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			       bool is_debug, bool is_kallsyms);
 
 int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct evsel *evsel,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5ddf76fb691c..7e1aac4931e1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2183,6 +2183,8 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	int err;
 	const char *kallsyms_filename = NULL;
 	char *kallsyms_allocated_filename = NULL;
+	char *filename;
+
 	/*
 	 * Step 1: if the user specified a kallsyms or vmlinux filename, use
 	 * it and only it, reporting errors to the user if it cannot be used.
@@ -2207,6 +2209,18 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		return dso__load_vmlinux(dso, map, symbol_conf.vmlinux_name, false);
 	}
 
+	/*
+	 * Before checking on common vmlinux locations, check if it's
+	 * stored as standard build id binary under .debug tree.
+	 */
+	filename = __dso__build_id_filename(dso, NULL, 0, false, false);
+	if (filename != NULL) {
+		err = dso__load_vmlinux(dso, map, filename, true);
+		if (err > 0)
+			return err;
+		free(filename);
+	}
+
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
 		err = dso__load_vmlinux_path(dso, map);
 		if (err > 0)
-- 
2.26.2

