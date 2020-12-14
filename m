Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFA2D96D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407525AbgLNK7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Dec 2020 05:59:10 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:32300 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407351AbgLNK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:57:39 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Ay5cmk_RPu6uMcAuQyMurQ-1; Mon, 14 Dec 2020 05:56:39 -0500
X-MC-Unique: Ay5cmk_RPu6uMcAuQyMurQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ACDA107ACE3;
        Mon, 14 Dec 2020 10:56:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D64F1704D9;
        Mon, 14 Dec 2020 10:56:30 +0000 (UTC)
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
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/15] perf buildid-cache: Add --debuginfod option
Date:   Mon, 14 Dec 2020 11:54:55 +0100
Message-Id: <20201214105457.543111-14-jolsa@kernel.org>
In-Reply-To: <20201214105457.543111-1-jolsa@kernel.org>
References: <20201214105457.543111-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --debuginfod option to specify debuginfod url and
support to do that through config file as well.

Use following in ~/.perfconfig file:

  [buildid-cache]
  debuginfod=http://192.168.122.174:8002

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../perf/Documentation/perf-buildid-cache.txt |  6 ++++
 tools/perf/Documentation/perf-config.txt      |  7 +++++
 tools/perf/builtin-buildid-cache.c            | 28 +++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index b77da5138bca..b9987d1399ca 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -84,6 +84,12 @@ OPTIONS
 	used when creating a uprobe for a process that resides in a
 	different mount namespace from the perf(1) utility.
 
+--debuginfod=URLs::
+	Specify debuginfod URL to be used when retrieving perf.data binaries,
+	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+	  buildid-cache.debuginfod=http://192.168.122.174:8002
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 31069d8a5304..e3672c5d801b 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -238,6 +238,13 @@ buildid.*::
 		cache location, or to disable it altogether. If you want to disable it,
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
+buildid-cache.*::
+	buildid-cache.debuginfod=URLs
+		Specify debuginfod URLs to be used when retrieving perf.data binaries,
+		it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+		  buildid-cache.debuginfod=http://192.168.122.174:8002
+
 annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index f0afb2c89e03..864597fd9cf6 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -27,6 +27,7 @@
 #include "util/time-utils.h"
 #include "util/util.h"
 #include "util/probe-file.h"
+#include "util/config.h"
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/zalloc.h>
@@ -550,12 +551,21 @@ build_id_cache__add_perf_data(const char *path, bool all)
 	return err;
 }
 
+static int perf_buildid_cache_config(const char *var, const char *value, void *cb)
+{
+	const char **debuginfod = cb;
+
+	if (!strcmp(var, "buildid-cache.debuginfod"))
+		*debuginfod = strdup(value);
+
+	return 0;
+}
+
 int cmd_buildid_cache(int argc, const char **argv)
 {
 	struct strlist *list;
 	struct str_node *pos;
-	int ret = 0;
-	int ns_id = -1;
+	int ret, ns_id = -1;
 	bool force = false;
 	bool list_files = false;
 	bool opts_flag = false;
@@ -565,7 +575,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		   *purge_name_list_str = NULL,
 		   *missing_filename = NULL,
 		   *update_name_list_str = NULL,
-		   *kcore_filename = NULL;
+		   *kcore_filename = NULL,
+		   *debuginfod = NULL;
 	char sbuf[STRERR_BUFSIZE];
 
 	struct perf_data data = {
@@ -590,6 +601,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_STRING('u', "update", &update_name_list_str, "file list",
 		    "file(s) to update"),
+	OPT_STRING(0, "debuginfod", &debuginfod, "debuginfod url",
+		    "set debuginfod url"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
 	OPT_END()
@@ -599,6 +612,10 @@ int cmd_buildid_cache(int argc, const char **argv)
 		NULL
 	};
 
+	ret = perf_config(perf_buildid_cache_config, &debuginfod);
+	if (ret)
+		return ret;
+
 	argc = parse_options(argc, argv, buildid_cache_options,
 			     buildid_cache_usage, 0);
 
@@ -610,6 +627,11 @@ int cmd_buildid_cache(int argc, const char **argv)
 	if (argc || !(list_files || opts_flag))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
 
+	if (debuginfod) {
+		pr_debug("DEBUGINFOD_URLS=%s\n", debuginfod);
+		setenv("DEBUGINFOD_URLS", debuginfod, 1);
+	}
+
 	/* -l is exclusive. It can not be used with other options. */
 	if (list_files && opts_flag) {
 		usage_with_options_msg(buildid_cache_usage,
-- 
2.26.2

