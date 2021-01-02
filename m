Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE02E88DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbhABWG7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:59 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50573 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbhABWG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:58 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-weeSOveWOFOUU-SzXPu64Q-1; Sat, 02 Jan 2021 17:06:03 -0500
X-MC-Unique: weeSOveWOFOUU-SzXPu64Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0FD59;
        Sat,  2 Jan 2021 22:06:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE9319481;
        Sat,  2 Jan 2021 22:05:56 +0000 (UTC)
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
Subject: [PATCH 22/22] perf test: Add daemon ping command test
Date:   Sat,  2 Jan 2021 23:04:41 +0100
Message-Id: <20210102220441.794923-23-jolsa@kernel.org>
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

Adding test for perf daemon ping command. The tests
verifies the ping command gets proper answer from
sessions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/shell/daemon.sh | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 792a7a846830..242470ff8d06 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -338,11 +338,51 @@ EOF
 	rm -f ${config}
 }
 
+test_ping()
+{
+	echo "test daemon ping"
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
+	size=`perf daemon ping --config ${config} --session size | awk '{ print $1 }'`
+	type=`perf daemon ping --config ${config} --session time | awk '{ print $1 }'`
+
+	if [ ${size} != "OK" -o ${type} != "OK" ]; then
+		error=1
+		echo "FAILED: daemon ping failed"
+	fi
+
+	# stop daemon
+	daemon_exit ${base} ${config}
+
+	rm -rf ${base}
+	rm -f ${config}
+}
+
 error=0
 
 test_list
 test_reconfig
 test_stop
 test_signal
+test_ping
 
 exit ${error}
-- 
2.26.2

