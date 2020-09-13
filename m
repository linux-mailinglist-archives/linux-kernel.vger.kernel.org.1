Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56A268153
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIMVGe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:06:34 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:37861 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbgIMVFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:06 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-ptSxF1tZNJO5KmHrmddyQQ-1; Sun, 13 Sep 2020 17:03:52 -0400
X-MC-Unique: ptSxF1tZNJO5KmHrmddyQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4D4185A0E5;
        Sun, 13 Sep 2020 21:03:50 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6D2D10021AA;
        Sun, 13 Sep 2020 21:03:46 +0000 (UTC)
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
Subject: [PATCH 06/26] perf tools: Add support to read build id from compressed elf
Date:   Sun, 13 Sep 2020 23:02:53 +0200
Message-Id: <20200913210313.1985612-7-jolsa@kernel.org>
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

Adding support to decompress file before reading build id.

Adding filename__read_build_id and change its current
versions to read_build_id.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol-elf.c | 37 ++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 94a156df22d5..6770572620f3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -534,7 +534,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, void *bf, size_t size)
+static int read_build_id(const char *filename, void *bf, size_t size)
 {
 	int err = -1;
 	bfd *abfd;
@@ -562,7 +562,7 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 
 #else // HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, void *bf, size_t size)
+static int read_build_id(const char *filename, void *bf, size_t size)
 {
 	int fd, err = -1;
 	Elf *elf;
@@ -591,6 +591,39 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 
 #endif // HAVE_LIBBFD_BUILDID_SUPPORT
 
+int filename__read_build_id(const char *filename, void *bf, size_t size)
+{
+	struct kmod_path m = { .name = NULL, };
+	char path[PATH_MAX];
+	int err;
+
+	if (!filename)
+		return -EFAULT;
+
+	err = kmod_path__parse(&m, filename);
+	if (err)
+		return -1;
+
+	if (m.comp) {
+		int error = 0, fd;
+
+		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
+		if (fd < 0) {
+			pr_debug("Failed to decompress (error %d) %s\n",
+				 error, filename);
+			return -1;
+		}
+		close(fd);
+		filename = path;
+	}
+
+	err = read_build_id(filename, bf, size);
+
+	if (m.comp)
+		unlink(filename);
+	return err;
+}
+
 int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 {
 	int fd, err = -1;
-- 
2.26.2

