Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AD2B5DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKQLC2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:28 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:39132 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgKQLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-_GDK0vTWNeeflQFST4f50Q-1; Tue, 17 Nov 2020 06:02:19 -0500
X-MC-Unique: _GDK0vTWNeeflQFST4f50Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0898A10B9CA6;
        Tue, 17 Nov 2020 11:02:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06CE85C1CF;
        Tue, 17 Nov 2020 11:02:14 +0000 (UTC)
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
Subject: [PATCH 22/24] perf buildid-cache: Add --debuginfod option
Date:   Tue, 17 Nov 2020 12:00:51 +0100
Message-Id: <20201117110053.1303113-23-jolsa@kernel.org>
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

Adding --debuginfod option to specify debuginfod url and
support to do that through config file as well.

Use following in ~/.perfconfig file:

  [buildid-cache]
  debuginfod=http://192.168.122.174:8002

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../perf/Documentation/perf-buildid-cache.txt |  6 ++++
 tools/perf/Documentation/perf-config.txt      |  7 +++++
 tools/perf/builtin-buildid-cache.c            | 28 +++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index b77da5138bca..75385f4dc11f 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -84,6 +84,12 @@ OPTIONS
 	used when creating a uprobe for a process that resides in a
 	different mount namespace from the perf(1) utility.
 
+--debuginfod=URL::
+	Specify debuginfod URL to be used when retrieving perf.data binaries,
+	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+	  buildid-cache.debuginfod=http://192.168.122.174:8002
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 31069d8a5304..15fad32b9885 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -238,6 +238,13 @@ buildid.*::
 		cache location, or to disable it altogether. If you want to disable it,
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
+buildid-cache.*::
+	buildid-cache.debuginfod=URL
+		Specify debuginfod URL to be used when retrieving perf.data binaries,
+		it follows the same syntax as the DEBUGINFOD_URLS variable, like:
+
+		  buildid-cache.debuginfod=http://192.168.122.174:8002
+
 annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 0bfb54ee1e5e..fc03de7d2a28 100644
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
@@ -552,12 +553,21 @@ build_id_cache__add_perf_data(const char *path, bool all)
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
@@ -567,7 +577,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		   *purge_name_list_str = NULL,
 		   *missing_filename = NULL,
 		   *update_name_list_str = NULL,
-		   *kcore_filename = NULL;
+		   *kcore_filename = NULL,
+		   *debuginfod = NULL;
 	char sbuf[STRERR_BUFSIZE];
 
 	struct perf_data data = {
@@ -592,6 +603,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
 	OPT_STRING('u', "update", &update_name_list_str, "file list",
 		    "file(s) to update"),
+	OPT_STRING(0, "debuginfod", &debuginfod, "debuginfod url",
+		    "set debuginfod url"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
 	OPT_END()
@@ -601,6 +614,10 @@ int cmd_buildid_cache(int argc, const char **argv)
 		NULL
 	};
 
+	ret = perf_config(perf_buildid_cache_config, &debuginfod);
+	if (ret)
+		return ret;
+
 	argc = parse_options(argc, argv, buildid_cache_options,
 			     buildid_cache_usage, 0);
 
@@ -612,6 +629,11 @@ int cmd_buildid_cache(int argc, const char **argv)
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

