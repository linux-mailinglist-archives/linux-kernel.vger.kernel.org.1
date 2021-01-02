Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940302E88DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhABWGw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:52 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:29781 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbhABWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-nTZLIXgwNF6olH4ByEQ_9A-1; Sat, 02 Jan 2021 17:05:50 -0500
X-MC-Unique: nTZLIXgwNF6olH4ByEQ_9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D80D1005504;
        Sat,  2 Jan 2021 22:05:48 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9301819727;
        Sat,  2 Jan 2021 22:05:45 +0000 (UTC)
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
Subject: [PATCH 19/22] perf test: Add daemon reconfig test
Date:   Sat,  2 Jan 2021 23:04:38 +0100
Message-Id: <20210102220441.794923-20-jolsa@kernel.org>
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

Adding test for daemon reconfiguration. The test changes
the configuration file and checks that the session is
changed properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 52abd2f015ed..8360f61973e2 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -177,8 +177,78 @@ EOF
 	rm -f ${config}
 }
 
+test_reconfig()
+{
+	echo "test daemon reconfig"
+
+	local config=$(mktemp /tmp/perf.daemon.config.XXX)
+	local base=$(mktemp -d /tmp/perf.daemon.base.XXX)
+
+	# prepare config
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
+	# check 2nd session
+	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
+	local line=`perf daemon --config ${config} -x | head -3 | tail -1`
+	check_line_other "${line}" time "-e task-clock" ${base}/session-time \
+			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
+	local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
+
+	# prepare new config
+	local config_new=${config}.new
+	cat <<EOF > ${config_new}
+[daemon]
+base=BASE
+
+[session-size]
+run = -e cpu-clock
+
+[session-time]
+run = -e cpu-clock
+EOF
+
+	# change config
+	sed -i -e "s|BASE|${base}|" ${config_new}
+	cp ${config_new} ${config}
+
+	# wait for old session to finish
+	tail --pid=${pid} -f /dev/null
+
+	# wait for new one to start
+	local state="FAIL"
+	while [ "${state}" != "OK" ]; do
+		state=`perf daemon ping --config ${config} --session time | awk '{ print $1 }'`
+	done
+
+	# check reconfigured 2nd session
+	# pid:time:-e task-clock:base/time:base/time/output:base/time/control:base/time/ack:0
+	local line=`perf daemon --config ${config} -x | head -3 | tail -1`
+	check_line_other "${line}" time "-e cpu-clock" ${base}/session-time \
+			 ${base}/session-time/output ${base}/session-time/control ${base}/session-time/ack "0"
+
+	# stop daemon
+	daemon_exit ${base} ${config}
+
+	rm -rf ${base}
+	rm -f ${config}
+}
 error=0
 
 test_list
+test_reconfig
 
 exit ${error}
-- 
2.26.2

