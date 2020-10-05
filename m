Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1960C283BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgJEP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbgJEP63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601913507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dN5gsjMnqyqI5A2jup6ulYvntmGtep/DzBd0lOh8y1w=;
        b=KxLCYd3ODn1QSzzSW+dS/LnTpqOt+tKzNgPpuD5GoqP0HkTAt6Tf44WD2yxveZs9sDOaE3
        z/4o+8vnjON7+/hrMTJ5Q88OnZ+VDtvUbtUOTovN1vft2lhQiMHkb7xyFGCItQrfXBOGhS
        HPVYsh5dYW3T8B9adP5CHA6vBfscdeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-qgIJrjfmM7yoddD5iKTd2A-1; Mon, 05 Oct 2020 11:58:23 -0400
X-MC-Unique: qgIJrjfmM7yoddD5iKTd2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D7B107ACF5;
        Mon,  5 Oct 2020 15:58:22 +0000 (UTC)
Received: from krava (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 650DD75120;
        Mon,  5 Oct 2020 15:58:19 +0000 (UTC)
Date:   Mon, 5 Oct 2020 17:58:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCHv3 1/9] perf tools: Add build id shell test
Message-ID: <20201005155818.GA249615@krava>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava>
 <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
 <CAP-5=fW=y4jJJfcY81wa8zjUXfOJrun=djT5ZL+6W826r4pERg@mail.gmail.com>
 <20201002205527.GA7581@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002205527.GA7581@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
  v3 changes:
    - compile examples directly in the test
    - using 'command' instead of 'which' for detection

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

