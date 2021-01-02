Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821002E88D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbhABWGU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:20 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:51322 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbhABWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:19 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-4DduToGYP-i2lJ8aM3uO6w-1; Sat, 02 Jan 2021 17:05:20 -0500
X-MC-Unique: 4DduToGYP-i2lJ8aM3uO6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DF6D107ACE3;
        Sat,  2 Jan 2021 22:05:19 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45CE819727;
        Sat,  2 Jan 2021 22:05:16 +0000 (UTC)
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
Subject: [PATCH 10/22] perf daemon: Add signal command
Date:   Sat,  2 Jan 2021 23:04:29 +0100
Message-Id: <20210102220441.794923-11-jolsa@kernel.org>
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

Allow perf daemon to send SIGUSR2 to all running sessions
or just to a specific session.

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

Send signal to all running sessions:

  # perf daemon signal
  signal 12 sent to session 'cycles [773738]'
  signal 12 sent to session 'sched [773739]'

Or to specific one:

  # perf daemon signal --session sched
  signal 12 sent to session 'sched [773739]'

And verify signals were delivered and perf.data dumped:

  # cat /opt/perfdata/session-cycles/output
  rounding mmap pages size to 32M (8192 pages)
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220382490 ]

  # car /opt/perfdata/session-sched/output
  rounding mmap pages size to 32M (8192 pages)
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220382489 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2021010220393745 ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 64 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 644f196d7f39..a7ffbecf8d14 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -522,10 +522,13 @@ static int setup_server_socket(struct daemon *daemon)
 }
 
 enum {
-	CMD_LIST = 0,
+	CMD_LIST   = 0,
+	CMD_SIGNAL = 1,
 	CMD_MAX,
 };
 
+#define SESSION_MAX 64
+
 union cmd {
 	int cmd;
 
@@ -535,6 +538,13 @@ union cmd {
 		int	verbose;
 		char	csv_sep;
 	} list;
+
+	/* CMD_SIGNAL */
+	struct {
+		int	cmd;
+		int	sig;
+		char	name[SESSION_MAX];
+	} signal;
 };
 
 static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
@@ -592,6 +602,24 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 	return 0;
 }
 
+static int cmd_session_kill(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	struct session *session;
+	bool all = false;
+
+	all = !strcmp(cmd->signal.name, "all");
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (all || !strcmp(cmd->signal.name, session->name)) {
+			session__signal(session, cmd->signal.sig);
+			fprintf(out, "signal %d sent to session '%s [%d]'\n",
+				cmd->signal.sig, session->name, session->pid);
+		}
+	}
+
+	return 0;
+}
+
 static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
@@ -619,6 +647,9 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_LIST:
 		ret = cmd_session_list(daemon, &cmd, out);
 		break;
+	case CMD_SIGNAL:
+		ret = cmd_session_kill(daemon, &cmd, out);
+		break;
 	default:
 		break;
 	}
@@ -933,6 +964,34 @@ static int send_cmd_list(struct daemon *daemon)
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
+			int argc, const char **argv)
+{
+	const char *name = "all";
+	struct option start_options[] = {
+		OPT_STRING(0, "session", &name, "session",
+			"Sent signal to specific session"),
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd;
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
+	cmd.signal.cmd = CMD_SIGNAL,
+	cmd.signal.sig = SIGUSR2;
+	strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
+
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -954,6 +1013,9 @@ int cmd_daemon(int argc, const char **argv)
 		return __cmd_start(&__daemon, daemon_options, argc, argv);
 
 	if (argc) {
+		if (!strcmp(argv[0], "signal"))
+			return __cmd_signal(&__daemon, daemon_options, argc, argv);
+
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
 	}
-- 
2.26.2

