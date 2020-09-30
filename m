Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0C27F01B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbgI3RRH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 13:17:07 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29853 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731362AbgI3RRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:17:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-3NfpagqANtSRUdXYvayFpw-1; Wed, 30 Sep 2020 13:15:20 -0400
X-MC-Unique: 3NfpagqANtSRUdXYvayFpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4244710BBECD;
        Wed, 30 Sep 2020 17:15:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB4EF702E7;
        Wed, 30 Sep 2020 17:15:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/9] perf tools: Add build id shell test
Date:   Wed, 30 Sep 2020 19:15:04 +0200
Message-Id: <20200930171512.3986425-2-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-1-jolsa@kernel.org>
References: <20200930171512.3986425-1-jolsa@kernel.org>
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

Adding test for build id cache that adds binary
with sha1 and md5 build ids and verifies it's
added properly.

The test updates build id cache with perf record
and perf buildid-cache -a.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf          | 14 +++++
 tools/perf/tests/shell/buildid.sh | 90 +++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tools/perf/tests/shell/buildid.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 920d8afb9238..b2aeefa64e92 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -126,6 +126,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
+# Define NO_BUILDID_EX if you do not want buildid-ex-* binaries
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -349,6 +351,11 @@ ifndef NO_PERF_READ_VDSOX32
 PROGRAMS += $(OUTPUT)perf-read-vdsox32
 endif
 
+ifndef NO_BUILDID_EX
+PROGRAMS += $(OUTPUT)buildid-ex-sha1
+PROGRAMS += $(OUTPUT)buildid-ex-md5
+endif
+
 LIBJVMTI = libperf-jvmti.so
 
 ifndef NO_JVMTI
@@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
+ifndef NO_BUILDID_EX
+$(OUTPUT)buildid-ex-sha1:
+	$(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
+$(OUTPUT)buildid-ex-md5:
+	$(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
+endif
+
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
 
diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
new file mode 100755
index 000000000000..57fcd28bc4bd
--- /dev/null
+++ b/tools/perf/tests/shell/buildid.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+# build id cache operations
+# SPDX-License-Identifier: GPL-2.0
+
+# skip if there are no test binaries
+if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
+	echo "failed: no test binaries"
+	exit 2
+fi
+
+# skip if there's no readelf
+if [ ! -x `which readelf` ]; then
+	echo "failed: no readelf, install binutils"
+	exit 2
+fi
+
+check()
+{
+	id=`readelf -n $1 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
+
+	echo "build id: ${id}"
+
+	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
+	echo "link: ${link}"
+
+	if [ ! -h $link ]; then
+		echo "failed: link ${link} does not exist"
+		exit 1
+	fi
+
+	file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
+	echo "file: ${file}"
+
+	if [ ! -x $file ]; then
+		echo "failed: file ${file} does not exist"
+		exit 1
+	fi
+
+	diff ${file} ${1}
+	if [ $? -ne 0 ]; then
+		echo "failed: ${file} do not match"
+		exit 1
+	fi
+
+	echo "OK for ${1}"
+}
+
+test_add()
+{
+	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
+	perf="perf --buildid-dir ${build_id_dir}"
+
+	${perf} buildid-cache -v -a ${1}
+	if [ $? -ne 0 ]; then
+		echo "failed: add ${1} to build id cache"
+		exit 1
+	fi
+
+	check ${1}
+
+	rm -rf ${build_id_dir}
+}
+
+test_record()
+{
+	data=$(mktemp /tmp/perf.data.XXX)
+	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
+	perf="perf --buildid-dir ${build_id_dir}"
+
+	${perf} record --buildid-all -o ${data} ${1}
+	if [ $? -ne 0 ]; then
+		echo "failed: record ${1}"
+		exit 1
+	fi
+
+	check ${1}
+
+	rm -rf ${build_id_dir}
+	rm -rf ${data}
+}
+
+# add binaries manual via perf buildid-cache -a
+test_add buildid-ex-sha1
+test_add buildid-ex-md5
+
+# add binaries via perf record post processing
+test_record buildid-ex-sha1
+test_record buildid-ex-md5
+
+exit ${err}
-- 
2.26.2

