Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00672E88D5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhABWGe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:34 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:25231 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbhABWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-nvJRArs6NemFXO5dF49RFw-1; Sat, 02 Jan 2021 17:05:34 -0500
X-MC-Unique: nvJRArs6NemFXO5dF49RFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0CD59;
        Sat,  2 Jan 2021 22:05:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 026A219727;
        Sat,  2 Jan 2021 22:05:29 +0000 (UTC)
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
Subject: [PATCH 14/22] perf daemon: Add ping command
Date:   Sat,  2 Jan 2021 23:04:33 +0100
Message-Id: <20210102220441.794923-15-jolsa@kernel.org>
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

Adding ping command to verify the perf record session
is up and operational.

It's used in following patches via test code to make
sure perf record is ready to receive signals.

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

Ping all sessions:

  # perf daemon ping
  OK   cycles
  OK   sched

Ping specific session:

  # perf daemon ping
  OK   sched

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 141 ++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 0c82fe9603e8..260bcffd9ae8 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -431,6 +431,75 @@ static int daemon__wait(struct daemon *daemon, int secs)
 	return 0;
 }
 
+static int
+session__control(struct session *session, const char *msg, bool do_ack)
+{
+	struct pollfd pollfd = { 0, };
+	char control_path[PATH_MAX];
+	char ack_path[PATH_MAX];
+	int control, ack, len;
+	char buf[20];
+	int ret = -1;
+	ssize_t err;
+
+	scnprintf(control_path, sizeof(control_path), "%s/%s",
+		  session->base, SESSION_CONTROL);
+
+	scnprintf(ack_path, sizeof(ack_path), "%s/%s",
+		  session->base, SESSION_ACK);
+
+	control = open(control_path, O_WRONLY|O_NONBLOCK);
+	if (!control)
+		return -1;
+
+	if (do_ack) {
+		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
+		if (!ack) {
+			close(control);
+			return -1;
+		}
+	}
+
+	len = strlen(msg);
+
+	do {
+		err = write(control, msg, len);
+		if (err == -1 && errno != EAGAIN) {
+			pr_err("failed to write to control pipe: %d (%s)\n",
+			       errno, control_path);
+			goto out;
+		}
+	} while (err != len);
+
+	if (!do_ack)
+		goto out;
+
+	pollfd.fd = ack;
+	pollfd.events = POLLIN;
+
+	if (!poll(&pollfd, 1, 2000)) {
+		pr_err("control ack timeout\n");
+		goto out;
+	}
+
+	if (!pollfd.revents & POLLIN) {
+		pr_err("control: fid not receiveed ack\n");
+		goto out_ack;
+	}
+
+	err = read(ack, buf, sizeof(buf));
+	if (err > 0)
+		ret = strcmp(buf, "ack\n");
+	else
+		pr_err("errno read control %d\n", errno);
+
+out_ack:
+	close(ack);
+out:
+	close(control);
+	return ret;
+}
+
 static void session__kill(struct session *session, struct daemon *daemon)
 {
 	session__signal(session, SIGTERM);
@@ -540,6 +609,7 @@ enum {
 	CMD_LIST   = 0,
 	CMD_SIGNAL = 1,
 	CMD_STOP   = 2,
+	CMD_PING   = 3,
 	CMD_MAX,
 };
 
@@ -561,8 +631,25 @@ union cmd {
 		int	sig;
 		char	name[SESSION_MAX];
 	} signal;
+
+	/* CMD_PING */
+	struct {
+		int	cmd;
+		char	name[SESSION_MAX];
+	} ping;
 };
 
+enum {
+	PING_OK	  = 0,
+	PING_FAIL = 1,
+	PING_MAX,
+};
+
+static int session__ping(struct session *session)
+{
+	return session__control(session, "ping", true) ?  PING_FAIL : PING_OK;
+}
+
 static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 {
 	char csv_sep = cmd->list.csv_sep;
@@ -652,6 +739,29 @@ static int cmd_session_kill(struct daemon *daemon, union cmd *cmd, FILE *out)
 	return 0;
 }
 
+static const char *ping_str[PING_MAX] = {
+	[PING_OK]   = "OK",
+	[PING_FAIL] = "FAIL",
+};
+
+static int cmd_session_ping(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	struct session *session;
+	bool all = false;
+
+	all = !strcmp(cmd->ping.name, "all");
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (all || !strcmp(cmd->ping.name, session->name)) {
+			int state = session__ping(session);
+
+			fprintf(out, "%-4s %s\n", ping_str[state], session->name);
+		}
+	}
+
+	return 0;
+}
+
 static int handle_server_socket(struct daemon *daemon, int sock_fd)
 {
 	int ret = -EINVAL, fd;
@@ -686,6 +796,9 @@ static int handle_server_socket(struct daemon *daemon, int sock_fd)
 		done = 1;
 		pr_debug("perf daemon is exciting\n");
 		break;
+	case CMD_PING:
+		ret = cmd_session_ping(daemon, &cmd, out);
+		break;
 	default:
 		break;
 	}
@@ -971,6 +1084,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
+	signal(SIGPIPE, SIG_IGN);
 
 	while (!done && !err) {
 		err = daemon__reconfig(daemon);
@@ -1091,6 +1205,31 @@ static int __cmd_stop(struct daemon *daemon, struct option parent_options[],
 	return send_cmd(daemon, &cmd);
 }
 
+static int __cmd_ping(struct daemon *daemon, struct option parent_options[],
+		      int argc, const char **argv)
+{
+	const char *name = "all";
+	struct option ping_options[] = {
+		OPT_STRING(0, "session", &name, "session",
+			"Ping to specific session"),
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	union cmd cmd = { .cmd = CMD_PING, };
+
+	argc = parse_options(argc, argv, ping_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, ping_options);
+
+	if (setup_config(daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
+	scnprintf(cmd.ping.name, sizeof(cmd.ping.name), "%s", name);
+	return send_cmd(daemon, &cmd);
+}
+
 int cmd_daemon(int argc, const char **argv)
 {
 	struct option daemon_options[] = {
@@ -1116,6 +1255,8 @@ int cmd_daemon(int argc, const char **argv)
 			return __cmd_signal(&__daemon, daemon_options, argc, argv);
 		else if (!strcmp(argv[0], "stop"))
 			return __cmd_stop(&__daemon, daemon_options, argc, argv);
+		else if (!strcmp(argv[0], "ping"))
+			return __cmd_ping(&__daemon, daemon_options, argc, argv);
 
 		pr_err("failed: unknown command '%s'\n", argv[0]);
 		return -1;
-- 
2.26.2

