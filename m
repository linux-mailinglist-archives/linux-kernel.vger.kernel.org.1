Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5062E88D9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhABWGr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:47 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23947 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbhABWGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:45 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-HTNjv4bhNR6tV2Ek4FsyJg-1; Sat, 02 Jan 2021 17:05:46 -0500
X-MC-Unique: HTNjv4bhNR6tV2Ek4FsyJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A61107ACE3;
        Sat,  2 Jan 2021 22:05:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84B361A838;
        Sat,  2 Jan 2021 22:05:42 +0000 (UTC)
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 18/22] perf test: Add daemon list command test
Date:   Sat,  2 Jan 2021 23:04:37 +0100
Message-Id: <20210102220441.794923-19-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding test for basic perf daemon listing via the CSV
output mode (-x option).

Checking that configured sessions display expected values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 184 +++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)
 create mode 100755 tools/perf/tests/shell/daemon.sh

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
new file mode 100755
index 000000000000..52abd2f015ed
--- /dev/null
+++ b/tools/perf/tests/shell/daemon.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+# daemon operations
+# SPDX-License-Identifier: GPL-2.0
+
+check_line_first()
+{
+	local line=$1
+	local name=$2
+	local base=$3
+	local output=$4
+	local lock=$5
+	local up=$6
+
+	local line_name=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $2 }'`
+	local line_base=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $3 }'`
+	local line_output=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $4 }'`
+	local line_lock=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $5 }'`
+	local line_up=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $6 }'`
+
+	if [ "${name}" != "${line_name}" ]; then
+		echo "FAILED: wrong name"
+		error=1
+	fi
+
+	if [ "${base}" != "${line_base}" ]; then
+		echo "FAILED: wrong base"
+		error=1
+	fi
+
+	if [ "${output}" != "${line_output}" ]; then
+		echo "FAILED: wrong output"
+		error=1
+	fi
+
+	if [ "${lock}" != "${line_lock}" ]; then
+		echo "FAILED: wrong lock"
+		error=1
+	fi
+
+	if [ "${up}" != "${line_up}" ]; then
+		echo "FAILED: wrong up"
+		error=1
+	fi
+}
+
+check_line_other()
+{
+	local line=$1
+	local name=$2
+	local run=$3
+	local base=$4
+	local output=$5
+	local control=$6
+	local ack=$7
+	local up=$8
+
+	local line_name=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $2 }'`
+	local line_run=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $3 }'`
+	local line_base=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $4 }'`
+	local line_output=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $5 }'`
+	local line_control=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $6 }'`
+	local line_ack=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $7 }'`
+	local line_up=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $8 }'`
+
+	if [ "${name}" != "${line_name}" ]; then
+		echo "FAILED: wrong name"
+		error=1
+	fi
+
+	if [ "${run}" != "${line_run}" ]; then
+		echo "FAILED: wrong run"
+		error=1
+	fi
+
+	if [ "${base}" != "${line_base}" ]; then
+		echo "FAILED: wrong base"
+		error=1
+	fi
+
+	if [ "${output}" != "${line_output}" ]; then
+		echo "FAILED: wrong output"
+		error=1
+	fi
+
+	if [ "${control}" != "${line_control}" ]; then
+		echo "FAILED: wrong control"
+		error=1
+	fi
+
+	if [ "${ack}" != "${line_ack}" ]; then
+		echo "FAILED: wrong ack"
+		error=1
+	fi
+
+	if [ "${up}" != "${line_up}" ]; then
+		echo "FAILED: wrong up"
+		error=1
+	fi
+}
+
+daemon_start()
+{
+	local config=$1
+	local session=$2
+
+	perf daemon start --config ${config}
+
+	# wait for the session to ping
+	local state="FAIL"
+	while [ "${state}" != "OK" ]; do
+		state=`perf daemon ping --config ${config} --session ${session} | awk '{ print $1 }'`
+		sleep 0.05
+	done
+}
+
+daemon_exit()
+{
+	local base=$1
+	local config=$2
+
+	local line=`perf daemon --config ${config} -x | head -1`
+	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
+
+	# stop daemon
+	perf daemon stop --config ${config}
+
+	# ... and wait for the pid to go away
+	tail --pid=${pid} -f /dev/null
+}
+
+test_list()
+{
+	echo "test daemon list"
+
+	local config=$(mktemp /tmp/perf.daemon.config.XXX)
+	local base=$(mktemp -d /tmp/perf.daemon.base.XXX)
+
+	cat <<EOF > ${config}
+[daemon]
+base=BASE
+
+[session-size]
+run = -e cpu-clock
+
+[session-time]
+run = -e task-clock
+EOF
+
+	sed -i -e "s|BASE|${base}|" ${config}
+
+	# start daemon
+	daemon_start ${config} size
+
+	# check first line
+	# pid:daemon:base:base/output:base/lock
+	local line=`perf daemon --config ${config} -x | head -1`
+	check_line_first ${line} daemon ${base} ${base}/output ${base}/lock "0"
+
+	# check 1st session
+	# pid:size:-e cpu-clock:base/size:base/size/output:base/size/control:base/size/ack:0
+	local line=`perf daemon --config ${config} -x | head -2 | tail -1`
+	check_line_other "${line}" size "-e cpu-clock" ${base}/session-size \
+			 ${base}/session-size/output ${base}/session-size/control \
+			 ${base}/session-size/ack "0"
+
+	# check 2nd session
+	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
+	local line=`perf daemon --config ${config} -x | head -3 | tail -1`
+	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+			 ${base}/session-time/output ${base}/session-time/control \
+			 ${base}/session-time/ack "0"
+
+	# stop daemon
+	daemon_exit ${base} ${config}
+
+	rm -rf ${base}
+	rm -f ${config}
+}
+
+error=0
+
+test_list
+
+exit ${error}
-- 
2.26.2

