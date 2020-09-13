Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A649268141
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgIMVEV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:21 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:42688 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgIMVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:05 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-9OVmYjGAMyuIRCsYvSCWEQ-1; Sun, 13 Sep 2020 17:03:56 -0400
X-MC-Unique: 9OVmYjGAMyuIRCsYvSCWEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72BA72FD14;
        Sun, 13 Sep 2020 21:03:54 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78EF1002388;
        Sun, 13 Sep 2020 21:03:50 +0000 (UTC)
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
Subject: [PATCH 07/26] perf tools: Add check for existing link in buildid dir
Date:   Sun, 13 Sep 2020 23:02:54 +0200
Message-Id: <20200913210313.1985612-8-jolsa@kernel.org>
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

When adding new build id link we fail if the link is already
there. Adding check for existing link and warn/replace the
link with new target.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bdee4e08e60d..ecdc167aa1a0 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -751,8 +751,26 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
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
+			pr_err("Inconsistent .debug record, updating [%s]\n",
+				linkname);
+
+			unlink(linkname);
+
+			if (symlink(tmp, linkname))
+				goto out_free;
+		}
+		err = 0;
+	}
 
 	/* Update SDT cache : error is just warned */
 	if (realname &&
-- 
2.26.2

