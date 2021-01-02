Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAC2E88D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbhABWGS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:18 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:49576 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbhABWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:16 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-JD6mJV6wOO6LXbLw0nBA3w-1; Sat, 02 Jan 2021 17:05:23 -0500
X-MC-Unique: JD6mJV6wOO6LXbLw0nBA3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FAF9180A095;
        Sat,  2 Jan 2021 22:05:22 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72C671A353;
        Sat,  2 Jan 2021 22:05:19 +0000 (UTC)
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
Subject: [PATCH 11/22] perf daemon: Add stop command
Date:   Sat,  2 Jan 2021 23:04:30 +0100
Message-Id: <20210102220441.794923-12-jolsa@kernel.org>
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

Add 'perf daemon stop' command to stop daemon process
and all running sessions.

Example:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

  [session-sched]
  run = -m 20M -e sched:* --overwrite --switch-output -a

Starting the daemon:

  # perf daemon start

Stopping the daemon

  # perf daemon stop

Daemon is not running, nothing to connect to:

  # perf daemon
  connect error: Connection refused

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index a7ffbecf8d14..45748bb471ec 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -524,6 +524,7 @@ static int setup_server_socket(struct daemon *daemon)
 enum {
 	CMD_LIST   = 0,
 	CMD_SIGNAL = 1,
+	CMD_STOP   = 2,
 	CMD_MAX,
 };
 
@@ -650,6 +651,10 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_SIGNAL:
 		ret = cmd_session_kill(daemon, &cmd, out);
 		break;
+	case CMD_STOP:
+		done = 1;
+		pr_debug("perf daemon is exciting\n");
+		break;
 	default:
 		break;
 	}
@@ -992,6 +997,27 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
+			int argc, const char **argv)
+{
+	struct option start_options[] = {
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd = { .cmd = CMD_STOP, };
+
+	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, start_options);
+
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1015,6 +1041,8 @@ int cmd_daemon(int argc, const char **argv)
 	if (argc) {
 		if (!strcmp(argv[0], "signal"))
 			return __cmd_signal(&__daemon, daemon_options, argc, argv);
+		else if (!strcmp(argv[0], "stop"))
+			return __cmd_stop(&__daemon, daemon_options, argc, argv);
 
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
-- 
2.26.2

