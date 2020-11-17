Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951082B5DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKQLBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:37 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52016 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbgKQLBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-1K72BBnjNKONLWYVBjS1-Q-1; Tue, 17 Nov 2020 06:01:29 -0500
X-MC-Unique: 1K72BBnjNKONLWYVBjS1-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03EF3108E1AC;
        Tue, 17 Nov 2020 11:01:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90915C1CF;
        Tue, 17 Nov 2020 11:01:23 +0000 (UTC)
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
Subject: [PATCH 07/24] perf tools: Add filename__decompress function
Date:   Tue, 17 Nov 2020 12:00:36 +0100
Message-Id: <20201117110053.1303113-8-jolsa@kernel.org>
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

Factor filename__decompress from decompress_kmodule function.
It can decompress files with compressions supported in perf -
xz and gz, the support needs to be compiled in.

It will to be used in following changes to get build id out of
compressed elf objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 31 +++++++++++++++++++------------
 tools/perf/util/dso.h |  2 ++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 89b5fd2b5de3..d786cf6b0cfa 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -279,18 +279,12 @@ bool dso__needs_decompress(struct dso *dso)
 		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
 }
 
-static int decompress_kmodule(struct dso *dso, const char *name,
-			      char *pathname, size_t len)
+int filename__decompress(const char *name, char *pathname,
+			 size_t len, int comp, int *err)
 {
 	char tmpbuf[] = KMOD_DECOMP_NAME;
 	int fd = -1;
 
-	if (!dso__needs_decompress(dso))
-		return -1;
-
-	if (dso->comp == COMP_ID__NONE)
-		return -1;
-
 	/*
 	 * We have proper compression id for DSO and yet the file
 	 * behind the 'name' can still be plain uncompressed object.
@@ -304,17 +298,17 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 	 * To keep this transparent, we detect this and return the file
 	 * descriptor to the uncompressed file.
 	 */
-	if (!compressions[dso->comp].is_compressed(name))
+	if (!compressions[comp].is_compressed(name))
 		return open(name, O_RDONLY);
 
 	fd = mkstemp(tmpbuf);
 	if (fd < 0) {
-		dso->load_errno = errno;
+		*err = errno;
 		return -1;
 	}
 
-	if (compressions[dso->comp].decompress(name, fd)) {
-		dso->load_errno = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
+	if (compressions[comp].decompress(name, fd)) {
+		*err = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
 		close(fd);
 		fd = -1;
 	}
@@ -328,6 +322,19 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 	return fd;
 }
 
+static int decompress_kmodule(struct dso *dso, const char *name,
+			      char *pathname, size_t len)
+{
+	if (!dso__needs_decompress(dso))
+		return -1;
+
+	if (dso->comp == COMP_ID__NONE)
+		return -1;
+
+	return filename__decompress(name, pathname, len, dso->comp,
+				    &dso->load_errno);
+}
+
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
 {
 	return decompress_kmodule(dso, name, NULL, 0);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d8cb4f5680a4..cd2fe64a3c5d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -274,6 +274,8 @@ bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
 				 char *pathname, size_t len);
+int filename__decompress(const char *name, char *pathname,
+			 size_t len, int comp, int *err);
 
 #define KMOD_DECOMP_NAME  "/tmp/perf-kmod-XXXXXX"
 #define KMOD_DECOMP_LEN   sizeof(KMOD_DECOMP_NAME)
-- 
2.26.2

