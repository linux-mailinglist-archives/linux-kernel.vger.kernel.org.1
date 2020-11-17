Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E012B5DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKQLBw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:52 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:58847 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgKQLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:50 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-7O7OghAJMq2Q-lLoLjG-cw-1; Tue, 17 Nov 2020 06:01:43 -0500
X-MC-Unique: 7O7OghAJMq2Q-lLoLjG-cw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E52803F50;
        Tue, 17 Nov 2020 11:01:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7EF5C1CF;
        Tue, 17 Nov 2020 11:01:37 +0000 (UTC)
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
Subject: [PATCH 11/24] perf tools: Try to load vmlinux from buildid database
Date:   Tue, 17 Nov 2020 12:00:40 +0100
Message-Id: <20201117110053.1303113-12-jolsa@kernel.org>
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
 tools/perf/util/symbol.c   | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index ef9a31b54ba2..2755d7b37a44 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -260,10 +260,9 @@ static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
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
@@ -292,6 +291,14 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
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
index d53415feaf69..f1a2f67df6e4 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -29,6 +29,8 @@ char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
 
 char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 			     bool is_debug);
+char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			       bool is_debug, bool is_kallsyms);
 
 int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct evsel *evsel,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0d14abdf3d72..64a039cbba1b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2189,6 +2189,8 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 	int err;
 	const char *kallsyms_filename = NULL;
 	char *kallsyms_allocated_filename = NULL;
+	char *filename = NULL;
+
 	/*
 	 * Step 1: if the user specified a kallsyms or vmlinux filename, use
 	 * it and only it, reporting errors to the user if it cannot be used.
@@ -2213,6 +2215,20 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		return dso__load_vmlinux(dso, map, symbol_conf.vmlinux_name, false);
 	}
 
+	/*
+	 * Before checking on common vmlinux locations, check if it's
+	 * stored as standard build id binary (not kallsyms) under
+	 * .debug cache.
+	 */
+	if (!symbol_conf.ignore_vmlinux_buildid)
+		filename = __dso__build_id_filename(dso, NULL, 0, false, false);
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

