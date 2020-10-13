Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D128D46E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgJMTZp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 15:25:45 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:29430 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbgJMTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:25:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-ViS-rgrgMDWrBCn5dzXgaQ-1; Tue, 13 Oct 2020 15:25:38 -0400
X-MC-Unique: ViS-rgrgMDWrBCn5dzXgaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E14D88EF2E;
        Tue, 13 Oct 2020 19:25:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E8005D994;
        Tue, 13 Oct 2020 19:25:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 9/9] perf tools: Add build id shell test
Date:   Tue, 13 Oct 2020 21:24:41 +0200
Message-Id: <20201013192441.1299447-10-jolsa@kernel.org>
In-Reply-To: <20201013192441.1299447-1-jolsa@kernel.org>
References: <20201013192441.1299447-1-jolsa@kernel.org>
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

Adding test for build id cache that adds binary
with sha1 and md5 build ids and verifies it's
added properly.

The test updates build id cache with perf record
and perf buildid-cache -a.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/buildid.sh | 101 ++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 tools/perf/tests/shell/buildid.sh

diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
new file mode 100755
index 000000000000..4861a20edee2
--- /dev/null
+++ b/tools/perf/tests/shell/buildid.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+# build id cache operations
+# SPDX-License-Identifier: GPL-2.0
+
+# skip if there's no readelf
+if ! [ -x "$(command -v readelf)" ]; then
+	echo "failed: no readelf, install binutils"
+	exit 2
+fi
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "failed: no compiler, install gcc"
+	exit 2
+fi
+
+ex_md5=$(mktemp /tmp/perf.ex.MD5.XXX)
+ex_sha1=$(mktemp /tmp/perf.ex.SHA1.XXX)
+
+echo 'int main(void) { return 0; }' | cc -Wl,--build-id=sha1 -o ${ex_sha1} -x c -
+echo 'int main(void) { return 0; }' | cc -Wl,--build-id=md5 -o ${ex_md5} -x c -
+
+echo "test binaries: ${ex_sha1} ${ex_md5}"
+
+check()
+{
+	id=`readelf -n ${1} 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
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
+# cleanup
+rm ${ex_sha1} ${ex_md5}
+
+exit ${err}
-- 
2.26.2

