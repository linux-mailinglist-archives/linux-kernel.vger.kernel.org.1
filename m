Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31628076B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbgJATFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbgJATFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601579139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfBG+cx6VtcGF4Sy+n7iPvKZO2kHCYic1u6Kfe1sfD8=;
        b=XAFbtFBxszOTkCqRdJfFT8LfZM47AgNAM4FLTj9NP1mpmcoK0Q8HtgTEN58IoWYCn+WAuC
        PQWjwtVC3wIa3egDuYmdmcR9GLfZim0+CV/hQCCMB6NcpzBNpEiMZ/J5e29WHwhyoAfQbq
        YJdW5VU3TN8u3A0X/vjiDaaT31tdZCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-o7MdtWPUMz2RlfXoPwsKtA-1; Thu, 01 Oct 2020 15:05:36 -0400
X-MC-Unique: o7MdtWPUMz2RlfXoPwsKtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B15A80F055;
        Thu,  1 Oct 2020 19:05:34 +0000 (UTC)
Received: from krava (ovpn-115-79.ams2.redhat.com [10.36.115.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6479A19C59;
        Thu,  1 Oct 2020 19:05:31 +0000 (UTC)
Date:   Thu, 1 Oct 2020 21:05:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCHv2 1/9] perf tools: Add build id shell test
Message-ID: <20201001190530.GD3999500@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930171512.3986425-2-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
v2 changes:
  - detect perf build directory when checking for build-ex* binaries

 tools/perf/Makefile.perf          |  14 +++++
 tools/perf/tests/shell/buildid.sh | 101 ++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
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
index 000000000000..dd9f9c306c34
--- /dev/null
+++ b/tools/perf/tests/shell/buildid.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+# build id cache operations
+# SPDX-License-Identifier: GPL-2.0
+
+ex_md5=buildid-ex-md5
+ex_sha1=buildid-ex-sha1
+
+# skip if there are no test binaries
+if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
+	ex_dir=$(dirname `which perf`)
+	ex_md5=${ex_dir}/buildid-ex-md5
+	ex_sha1=${ex_dir}/buildid-ex-sha1
+
+	if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
+		echo "failed: no test binaries"
+		exit 2
+	fi
+fi
+
+echo "test binaries: ${ex_sha1} ${ex_md5}"
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
+test_add ${ex_sha1}
+test_add ${ex_md5}
+
+# add binaries via perf record post processing
+test_record ${ex_sha1}
+test_record ${ex_md5}
+
+exit ${err}
-- 
2.26.2

