Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16A82D96E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgLNLCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Dec 2020 06:02:42 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:29857 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393730AbgLNK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:56:41 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-XqTgu3ZVOmKMyhgRvYOuEA-1; Mon, 14 Dec 2020 05:55:44 -0500
X-MC-Unique: XqTgu3ZVOmKMyhgRvYOuEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A4DF1936B68;
        Mon, 14 Dec 2020 10:55:42 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A55667047D;
        Mon, 14 Dec 2020 10:55:38 +0000 (UTC)
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
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/15] perf tools: Add support to read build id from compressed elf
Date:   Mon, 14 Dec 2020 11:54:48 +0100
Message-Id: <20201214105457.543111-7-jolsa@kernel.org>
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

Adding support to decompress file before reading build id.

Adding filename__read_build_id and change its current
versions to read_build_id.

Shutting down stderr output of perf list in the shell test:
  82: Check open filename arg using perf trace + vfs_getname          : Ok

because with decompression code in the place we the
filename__read_build_id function is more verbose in case
of error and the test did not account for that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../tests/shell/trace+probe_vfs_getname.sh    |  2 +-
 tools/perf/util/symbol-elf.c                  | 37 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 11cc2af13f2b..3d31c1d560d6 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	evts=$(echo $(perf list syscalls:sys_enter_open* 2>/dev/null | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
 	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 44dd86a4f25f..f3577f7d72fe 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -534,7 +534,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
 	int err = -1;
@@ -563,7 +563,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 
 #else // HAVE_LIBBFD_BUILDID_SUPPORT
 
-int filename__read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
 	int fd, err = -1;
@@ -595,6 +595,39 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 
 #endif // HAVE_LIBBFD_BUILDID_SUPPORT
 
+int filename__read_build_id(const char *filename, struct build_id *bid)
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
+	err = read_build_id(filename, bid);
+
+	if (m.comp)
+		unlink(filename);
+	return err;
+}
+
 int sysfs__read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
-- 
2.26.2

