Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D92D85FD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438786AbgLLKqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:46:45 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50110 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407390AbgLLKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-jaS_NqpAMGik9Xkv_yRvPg-1; Sat, 12 Dec 2020 05:44:24 -0500
X-MC-Unique: jaS_NqpAMGik9Xkv_yRvPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B1C7C29B;
        Sat, 12 Dec 2020 10:44:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC4AE6FEE0;
        Sat, 12 Dec 2020 10:44:18 +0000 (UTC)
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
Subject: [PATCH 5/8] perf daemon: Add signal command
Date:   Sat, 12 Dec 2020 11:43:55 +0100
Message-Id: <20201212104358.412065-6-jolsa@kernel.org>
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

Allow perf daemon to send SIGUSR2 to all running sessions:

  # perf daemon
  [1:364758] perf record -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
  [2:364759] perf record -m 10M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a

  # perf daemon -s
  signal 12 sent to session '1 [92187]'
  signal 12 sent to session '2 [92188]'

Or to specific one:

  # perf daemon --signal=1
  signal 12 sent to session '1 [364758]'

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt | 24 +++++++++++
 tools/perf/builtin-daemon.c              | 51 +++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index dee39be110ba..203ec4bf704c 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -30,6 +30,11 @@ OPTIONS
 --foreground::
 	Do not put the process in background.
 
+-s::
+--signal[=session]::
+	Send SIGUSR2 to specific session, if session is not specified,
+	send SIGUSR2 to all sessions.
+
 -v::
 --verbose::
 	Be more verbose.
@@ -92,6 +97,25 @@ Check sessions with more info:
 The 'output' file is perf record output for specific session.
 
 
+Send SIGUSR2 signal to all sessions:
+
+  # perf daemon -s
+  signal 12 sent to session '1 [92187]'
+  signal 12 sent to session '2 [92188]'
+
+Send SIGUSR2 signal to session '1':
+
+  # perf daemon --signal=1
+  signal 12 sent to session '1 [364758]'
+
+And check that the perf data dump was trigered:
+
+  # cat /opt/perfdata/2/output
+  rounding mmap pages size to 32M (8192 pages)
+  [ perf record: dump data: Woken up 1 times ]
+  [ perf record: Dump /opt/perfdata/2/perf.data.2020120715220385 ]
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-config[1]
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 7f455837d58a..c53d4ddc2b49 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -450,9 +450,15 @@ static int setup_server_socket(struct daemon *daemon)
 enum cmd {
 	CMD_LIST         = 0,
 	CMD_LIST_VERBOSE = 1,
+	CMD_SIGNAL       = 2,
 	CMD_MAX,
 };
 
+struct cmd_signal {
+	int	sig;
+	char	name[16];
+};
+
 static int cmd_session_list(struct daemon *daemon, FILE *out, bool simple)
 {
 	struct session *session;
@@ -469,6 +475,28 @@ static int cmd_session_list(struct daemon *daemon, FILE *out, bool simple)
 	return 0;
 }
 
+static int cmd_session_kill(struct daemon *daemon, FILE *out, int fd)
+{
+	struct session *session;
+	struct cmd_signal data;
+	bool all = false;
+
+	if (sizeof(data) != read(fd, &data, sizeof(data)))
+		return -1;
+
+	all = !strcmp(data.name, "all");
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (all || !strcmp(data.name, session->name)) {
+			session__signal(session, data.sig);
+			fprintf(out, "signal %d sent to session '%s [%d]'\n",
+				data.sig, session->name, session->pid);
+		}
+	}
+
+	return 0;
+}
+
 static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
@@ -497,6 +525,9 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 	case CMD_LIST_VERBOSE:
 		ret = cmd_session_list(daemon, out, cmd == CMD_LIST);
 		break;
+	case CMD_SIGNAL:
+		ret = cmd_session_kill(daemon, out, fd);
+		break;
 	default:
 		break;
 	}
@@ -730,8 +761,9 @@ static int __cmd_daemon(struct daemon *daemon, bool foreground, const char *conf
 	return err;
 }
 
-static int send_cmd(struct daemon *daemon, u64 cmd)
+static int send_cmd(struct daemon *daemon, u64 cmd, const char *str)
 {
+	struct cmd_signal data;
 	char *line = NULL;
 	size_t len = 0;
 	ssize_t nread;
@@ -747,6 +779,14 @@ static int send_cmd(struct daemon *daemon, u64 cmd)
 	if (sizeof(cmd) != write(fd, &cmd, sizeof(cmd)))
 		return -1;
 
+	if (cmd == CMD_SIGNAL) {
+		data.sig = SIGUSR2;
+		strncpy(data.name, str, sizeof(data.name) - 1);
+
+		if (sizeof(data) != write(fd, &data, sizeof(data)))
+			return -1;
+	}
+
 	in = fdopen(fd, "r");
 	if (!in) {
 		perror("fopen");
@@ -770,7 +810,9 @@ static const char * const daemon_usage[] = {
 int cmd_daemon(int argc, const char **argv)
 {
 	bool foreground = false;
+	bool signal = false;
 	const char *config = NULL;
+	const char *signal_str = NULL;
 	struct daemon daemon = {
 		.sessions = LIST_HEAD_INIT(daemon.sessions),
 		.out	  = stdout,
@@ -780,6 +822,8 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_STRING(0, "config", &config,
 			   "config file", "config file path"),
 		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
+		OPT_STRING_OPTARG_SET('s', "signal", &signal_str, &signal,
+				      "signal", "send signal to session", "all"),
 		OPT_END()
 	};
 
@@ -790,5 +834,8 @@ int cmd_daemon(int argc, const char **argv)
 	if (config)
 		return __cmd_daemon(&daemon, foreground, config);
 
-	return send_cmd(&daemon, verbose ? CMD_LIST_VERBOSE : CMD_LIST);
+	if (signal)
+		return send_cmd(&daemon, CMD_SIGNAL, signal_str);
+
+	return send_cmd(&daemon, verbose ? CMD_LIST_VERBOSE : CMD_LIST, NULL);
 }
-- 
2.26.2

