Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA12AC7B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgKIVzF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 16:55:05 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:59973 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731378AbgKIVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:55:02 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-lRZeVI7TO1yXqibKYF5EYw-1; Mon, 09 Nov 2020 16:54:57 -0500
X-MC-Unique: lRZeVI7TO1yXqibKYF5EYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6942D5F9C0;
        Mon,  9 Nov 2020 21:54:55 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C6766EF46;
        Mon,  9 Nov 2020 21:54:52 +0000 (UTC)
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
Subject: [PATCH 09/24] perf tools: Add check for existing link in buildid dir
Date:   Mon,  9 Nov 2020 22:54:00 +0100
Message-Id: <20201109215415.400153-10-jolsa@kernel.org>
In-Reply-To: <20201109215415.400153-1-jolsa@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 tools/perf/util/build-id.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 7d9ecc37849c..ef9a31b54ba2 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -754,8 +754,21 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 	tmp = dir_name + strlen(buildid_dir) - 5;
 	memcpy(tmp, "../..", 5);
 
-	if (symlink(tmp, linkname) == 0)
+	if (symlink(tmp, linkname) == 0) {
 		err = 0;
+	} else if (errno == EEXIST) {
+		char path[PATH_MAX];
+
+		if (readlink(linkname, path, sizeof(path)) == -1) {
+			pr_err("Cant read link: %s\n", linkname);
+			goto out_free;
+		}
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

