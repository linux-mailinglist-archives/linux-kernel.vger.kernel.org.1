Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8142D85FC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438720AbgLLKqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:46:20 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:20046 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407389AbgLLKpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:21 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-tVdVljN7N3K6hhcWFX1Dbw-1; Sat, 12 Dec 2020 05:44:26 -0500
X-MC-Unique: tVdVljN7N3K6hhcWFX1Dbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDB6801AA5;
        Sat, 12 Dec 2020 10:44:24 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEE9F7086D;
        Sat, 12 Dec 2020 10:44:21 +0000 (UTC)
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
Subject: [PATCH 6/8] perf daemon: Add stop command
Date:   Sat, 12 Dec 2020 11:43:56 +0100
Message-Id: <20201212104358.412065-7-jolsa@kernel.org>
In-Reply-To: <20201212104358.412065-1-jolsa@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow 'perf daemon' to stop daemon process:

  # perf daemon --stop
  perf daemon is exciting

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  8 ++++++++
 tools/perf/builtin-daemon.c              | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 203ec4bf704c..87de2c77e4c7 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -35,6 +35,9 @@ OPTIONS
 	Send SIGUSR2 to specific session, if session is not specified,
 	send SIGUSR2 to all sessions.
 
+--stop::
+	Stop daemon.
+
 -v::
 --verbose::
 	Be more verbose.
@@ -116,6 +119,11 @@ And check that the perf data dump was trigered:
   [ perf record: Dump /opt/perfdata/2/perf.data.2020120715220385 ]
 
 
+Stop daemon:
+
+  # perf daemon --stop
+  perf daemon is exciting
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-config[1]
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index c53d4ddc2b49..855fed2fe364 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -451,6 +451,7 @@ enum cmd {
 	CMD_LIST         = 0,
 	CMD_LIST_VERBOSE = 1,
 	CMD_SIGNAL       = 2,
+	CMD_STOP         = 3,
 	CMD_MAX,
 };
 
@@ -528,6 +529,10 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_SIGNAL:
 		ret = cmd_session_kill(daemon, out, fd);
 		break;
+	case CMD_STOP:
+		done = 1;
+		pr_debug("perf daemon is exciting\n");
+		break;
 	default:
 		break;
 	}
@@ -811,6 +816,7 @@ int cmd_daemon(int argc, const char **argv)
 {
 	bool foreground = false;
 	bool signal = false;
+	bool stop = false;
 	const char *config = NULL;
 	const char *signal_str = NULL;
 	struct daemon daemon = {
@@ -821,6 +827,7 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING(0, "config", &config,
 			   "config file", "config file path"),
+		OPT_BOOLEAN(0, "stop", &stop, "stop daemon"),
 		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
 		OPT_STRING_OPTARG_SET('s', "signal", &signal_str, &signal,
 				      "signal", "send signal to session", "all"),
@@ -837,5 +844,8 @@ int cmd_daemon(int argc, const char **argv)
 	if (signal)
 		return send_cmd(&daemon, CMD_SIGNAL, signal_str);
 
+	if (stop)
+		return send_cmd(&daemon, CMD_STOP, NULL);
+
 	return send_cmd(&daemon, verbose ? CMD_LIST_VERBOSE : CMD_LIST, NULL);
 }
-- 
2.26.2

