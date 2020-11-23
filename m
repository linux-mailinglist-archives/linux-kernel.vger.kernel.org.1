Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE62C1937
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgKWXGI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:06:08 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:25059 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387710AbgKWXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:06:07 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-lNVJRUwEN-aj9WnsYi8PyQ-1; Mon, 23 Nov 2020 18:06:00 -0500
X-MC-Unique: lNVJRUwEN-aj9WnsYi8PyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF89A100A26D;
        Mon, 23 Nov 2020 23:05:57 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCEA45D9CA;
        Mon, 23 Nov 2020 23:05:54 +0000 (UTC)
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
Subject: [PATCH 10/25] perf tools: Add check for existing link in buildid dir
Date:   Tue, 24 Nov 2020 00:04:57 +0100
Message-Id: <20201123230512.2097312-11-jolsa@kernel.org>
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

When adding new build id link we fail if the link is already
there. Adding check for existing link and output debug message
that the build id is already linked.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 2aacc8b29f7e..4a391f13f40d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -755,8 +755,25 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 	tmp = dir_name + strlen(buildid_dir) - 5;
 	memcpy(tmp, "../..", 5);
 
-	if (symlink(tmp, linkname) == 0)
+	if (symlink(tmp, linkname) == 0) {
 		err = 0;
+	} else if (errno == EEXIST) {
+		char path[PATH_MAX];
+		ssize_t len;
+
+		len = readlink(linkname, path, sizeof(path) - 1);
+		if (len <= 0) {
+			pr_err("Cant read link: %s\n", linkname);
+			goto out_free;
+		}
+		path[len] = '\0';
+
+		if (strcmp(tmp, path)) {
+			pr_debug("build <%s> already linked to %s\n",
+				 sbuild_id, linkname);
+		}
+		err = 0;
+	}
 
 	/* Update SDT cache : error is just warned */
 	if (realname &&
-- 
2.26.2

