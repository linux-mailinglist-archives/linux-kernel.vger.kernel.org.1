Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97B2268151
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgIMVGS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:06:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgIMVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:27 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-jZcu63FlN1usIGdkvRUT5g-1; Sun, 13 Sep 2020 17:05:20 -0400
X-MC-Unique: jZcu63FlN1usIGdkvRUT5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3BEF1074651;
        Sun, 13 Sep 2020 21:05:18 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2903F1002388;
        Sun, 13 Sep 2020 21:05:14 +0000 (UTC)
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
Subject: [PATCH 25/26] perf tools: Move debuginfo download code into get_debuginfo
Date:   Sun, 13 Sep 2020 23:03:12 +0200
Message-Id: <20200913210313.1985612-26-jolsa@kernel.org>
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

Moving debuginfo download code into get_debuginfo
to align with get_executable function added earlier.
The functionality stays intact apart from some extra
debug output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 45 ++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 9335a535e547..ea217bb30626 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -626,6 +626,35 @@ static int build_id_cache__add_sdt_cache(const char *sbuild_id,
 #define build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) (0)
 #endif
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+static int get_debuginfo(const char *sbuild_id, char **path)
+{
+	debuginfod_client *c;
+	int fd;
+
+	c = debuginfod_begin();
+	if (c == NULL)
+		return -1;
+
+	pr_debug("trying debuginfod for debuginfo <%s> ... ", sbuild_id);
+
+	fd = debuginfod_find_debuginfo(c, (const unsigned char *) sbuild_id,
+				       0, path);
+	if (fd >= 0)
+		close(fd); /* retaining reference by realname */
+
+	debuginfod_end(c);
+	pr_debug("%s%s\n", *path ? "OK " : "FAILED", *path ? *path : "");
+	return *path ? 0 : -1;
+}
+#else
+static int get_debuginfo(const char *sbuild_id __maybe_unused,
+			  char **path __maybe_unused)
+{
+	return -1;
+}
+#endif
+
 static char *build_id_cache__find_debug(const char *sbuild_id,
 					struct nsinfo *nsi)
 {
@@ -649,20 +678,8 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 		zfree(&realname);
 	nsinfo__mountns_exit(&nsc);
 
-#ifdef HAVE_DEBUGINFOD_SUPPORT
-        if (realname == NULL) {
-                debuginfod_client* c = debuginfod_begin();
-                if (c != NULL) {
-                        int fd = debuginfod_find_debuginfo(c,
-                                                           (const unsigned char*)sbuild_id, 0,
-                                                           &realname);
-                        if (fd >= 0)
-                                close(fd); /* retaining reference by realname */
-                        debuginfod_end(c);
-                }
-        }
-#endif
-
+	if (realname == NULL)
+		get_debuginfo(sbuild_id, &realname);
 out:
 	free(debugfile);
 	return realname;
-- 
2.26.2

