Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3F2E88CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhABWGK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:10 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50302 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhABWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:08 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-tma47r6UPsSt8rQmlkGJzQ-1; Sat, 02 Jan 2021 17:05:10 -0500
X-MC-Unique: tma47r6UPsSt8rQmlkGJzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F06D800D62;
        Sat,  2 Jan 2021 22:05:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7BBF1A353;
        Sat,  2 Jan 2021 22:05:05 +0000 (UTC)
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
Subject: [PATCH 07/22] perf daemon: Add daemon command
Date:   Sat,  2 Jan 2021 23:04:26 +0100
Message-Id: <20210102220441.794923-8-jolsa@kernel.org>
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

Adding daemon command that allows to run record sessions
on background. Each session represents one perf record
process and is configured in config file.

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

Check sessions:

  # perf daemon
  [771394:daemon] base: /opt/perfdata
  [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
  [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a

Check sessions with more info:

  # perf daemon -v
  [771394:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
  [771395:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
  [771396:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output

The 'output' file is perf record output for specific session.

Note you have to stop all running perf processes manually at
this point, stop command is coming in following patches.

Adding empty perf-daemon.txt to skip compile warning,
the man page is populated in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Build                         |   1 +
 tools/perf/Documentation/perf-daemon.txt |   0
 tools/perf/builtin-daemon.c              | 753 +++++++++++++++++++++++
 tools/perf/builtin.h                     |   1 +
 tools/perf/command-list.txt              |   1 +
 tools/perf/perf.c                        |   1 +
 6 files changed, 757 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c

diff --git a/tools/perf/Build b/tools/perf/Build
index 5f392dbb88fc..db61dbe2b543 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -24,6 +24,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-y += builtin-daemon.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
new file mode 100644
index 000000000000..c2a7738a6a4a
--- /dev/null
+++ b/tools/perf/builtin-daemon.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <subcmd/parse-options.h>
+#include <linux/compiler.h>
+#include <linux/list.h>
+#include <linux/zalloc.h>
+#include <linux/limits.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <api/fd/array.h>
+#include <poll.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/inotify.h>
+#include <libgen.h>
+#include "builtin.h"
+#include "perf.h"
+#include "debug.h"
+#include "config.h"
+#include "string2.h"
+#include "asm/bug.h"
+#include "util.h"
+#include <api/fs/fs.h>
+
+#define SESSION_OUTPUT  "output"
+
+enum session_state {
+	SESSION_STATE__OK,
+	SESSION_STATE__RECONFIG,
+	SESSION_STATE__KILL,
+};
+
+struct session {
+	char			*base;
+	char			*name;
+	char			*run;
+	int			 pid;
+	struct list_head	 list;
+	enum session_state	 state;
+};
+
+struct daemon {
+	const char		*config;
+	char			*config_real;
+	char			*config_base;
+	const char		*csv_sep;
+	char			*base;
+	struct list_head	 sessions;
+	FILE			*out;
+	char			 perf[PATH_MAX];
+};
+
+static struct daemon __daemon = {
+	.sessions = LIST_HEAD_INIT(__daemon.sessions),
+};
+
+static const char * const daemon_usage[] = {
+	"perf daemon start [<options>]",
+	"perf daemon [<options>]",
+	NULL
+};
+
+static bool done;
+
+static void sig_handler(int sig __maybe_unused)
+{
+	done = true;
+}
+
+static struct session*
+daemon__add_session(struct daemon *config, char *name)
+{
+	struct session *session;
+
+	session = zalloc(sizeof(*session));
+	if (!session)
+		return NULL;
+
+	session->name = strdup(name);
+	if (!session->name) {
+		free(session);
+		return NULL;
+	}
+
+	session->pid = -1;
+	list_add_tail(&session->list, &config->sessions);
+	return session;
+}
+
+static struct session*
+daemon__find_session(struct daemon *daemon, char *name)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (!strcmp(session->name, name))
+			return session;
+	}
+
+	return NULL;
+}
+
+static int get_session_name(const char *var, char *session, int len)
+{
+	const char *p = var + sizeof("session-") - 1;
+
+	while (*p != '.' && *p != 0x0 && len--)
+		*session++ = *p++;
+
+	*session = 0;
+	return *p == '.' ? 0 : -EINVAL;
+}
+
+static int session_config(struct daemon *daemon, const char *var, const char *value)
+{
+	struct session *session;
+	char name[100];
+
+	if (get_session_name(var, name, sizeof(name)))
+		return -EINVAL;
+
+	var = strchr(var, '.');
+	if (!var)
+		return -EINVAL;
+
+	var++;
+
+	session = daemon__find_session(daemon, name);
+	if (!session) {
+		session = daemon__add_session(daemon, name);
+		if (!session)
+			return -ENOMEM;
+
+		pr_debug("reconfig: found new session %s\n", name);
+		/* This is new session, trigger reconfig to start it. */
+		session->state = SESSION_STATE__RECONFIG;
+	} else if (session->state == SESSION_STATE__KILL) {
+		/*
+		 * The session was marked to kill and we still
+		 * found it in config file.
+		 */
+		pr_debug("reconfig: found current session %s\n", name);
+		session->state = SESSION_STATE__OK;
+	}
+
+	if (!strcmp(var, "run")) {
+		if (session->run && strcmp(session->run, value)) {
+			free(session->run);
+			pr_debug("reconfig: session %s is changed\n", name);
+			session->state = SESSION_STATE__RECONFIG;
+		}
+		session->run = strdup(value);
+	}
+
+	return 0;
+}
+
+static int server_config(const char *var, const char *value, void *cb)
+{
+	struct daemon *daemon = cb;
+
+	if (strstarts(var, "session-"))
+		return session_config(daemon, var, value);
+	else if (!strcmp(var, "daemon.base"))
+		daemon->base = strdup(value);
+
+	return 0;
+}
+
+static int client_config(const char *var, const char *value, void *cb)
+{
+	struct daemon *daemon = cb;
+
+	if (!strcmp(var, "daemon.base"))
+		daemon->base = strdup(value);
+
+	return 0;
+}
+
+static int setup_client_config(struct daemon *daemon)
+{
+	struct perf_config_set *set;
+	int err = -ENOMEM;
+
+	set = perf_config_set__load_file(daemon->config_real);
+	if (set) {
+		err = perf_config_set(set, client_config, daemon);
+		perf_config_set__delete(set);
+	}
+
+	return err;
+}
+
+static int setup_server_config(struct daemon *daemon)
+{
+	struct perf_config_set *set;
+	struct session *session;
+	int err = -ENOMEM;
+
+	pr_debug("reconfig: started\n");
+
+	/*
+	 * Mark all session for kill, the server config will
+	 * set proper state for found sessions.
+	 */
+	list_for_each_entry(session, &daemon->sessions, list)
+		session->state = SESSION_STATE__KILL;
+
+	set = perf_config_set__load_file(daemon->config_real);
+	if (set) {
+		err = perf_config_set(set, server_config, daemon);
+		perf_config_set__delete(set);
+	}
+
+	return err;
+}
+
+static int session__signal(struct session *session, int sig)
+{
+	if (session->pid < 0)
+		return -1;
+	return kill(session->pid, sig);
+}
+
+static int session__run(struct session *session, struct daemon *daemon)
+{
+	char buf[PATH_MAX];
+	char **argv;
+	int argc, fd;
+
+	if (asprintf(&session->base, "%s/session-%s",
+		     daemon->base, session->name) < 0) {
+		perror("asprintf failed");
+		return -1;
+	}
+
+	if (mkdir(session->base, 0755) && errno != EEXIST) {
+		perror("mkdir failed");
+		return -1;
+	}
+
+	session->pid = fork();
+	if (session->pid < 0)
+		return -1;
+	if (session->pid > 0) {
+		pr_info("reconfig: ruining session [%s:%d]: %s\n",
+			session->name, session->pid, session->run);
+		return 0;
+	}
+
+	if (chdir(session->base)) {
+		perror("chdir failed");
+		return -1;
+	}
+
+	fd = open("/dev/null", O_RDONLY);
+	if (fd < 0) {
+		perror("failed to open /dev/null");
+		return -1;
+	}
+
+	close(0);
+	dup2(fd, 0);
+	close(fd);
+
+	fd = open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("failed to open session output");
+		return -1;
+	}
+
+	close(1);
+	close(2);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	close(fd);
+
+	scnprintf(buf, sizeof(buf), "%s record %s", daemon->perf, session->run);
+
+	argv = argv_split(buf, &argc);
+	if (!argv)
+		exit(-1);
+
+	exit(execve(daemon->perf, argv, NULL));
+	return -1;
+}
+
+static void daemon__signal(struct daemon *daemon, int sig)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list)
+		session__signal(session, sig);
+}
+
+static void session__free(struct session *session)
+{
+	free(session->base);
+	free(session->name);
+	free(session->run);
+	free(session);
+}
+
+static void session__remove(struct session *session)
+{
+	list_del(&session->list);
+	session__free(session);
+}
+
+static void session__kill(struct session *session)
+{
+	session__signal(session, SIGTERM);
+}
+
+static int daemon__reconfig(struct daemon *daemon)
+{
+	struct session *session, *n;
+
+	list_for_each_entry_safe(session, n, &daemon->sessions, list) {
+		/* No change. */
+		if (session->state == SESSION_STATE__OK)
+			continue;
+
+		/* Remove session. */
+		if (session->state == SESSION_STATE__KILL) {
+			if (session->pid > 0) {
+				session__kill(session);
+				pr_info("reconfig: session '%s' killed\n", session->name);
+			}
+			session__remove(session);
+			continue;
+		}
+
+		/* Reconfig session. */
+		pr_debug2("reconfig: session '%s' start\n", session->name);
+		if (session->pid > 0) {
+			session__kill(session);
+			pr_info("reconfig: session '%s' killed\n", session->name);
+		}
+		if (session__run(session, daemon))
+			return -1;
+		pr_debug2("reconfig: session '%s' done\n", session->name);
+		session->state = SESSION_STATE__OK;
+	}
+
+	return 0;
+}
+
+static void daemon__kill(struct daemon *daemon)
+{
+	daemon__signal(daemon, SIGTERM);
+}
+
+static void daemon__free(struct daemon *daemon)
+{
+	struct session *session, *h;
+
+	list_for_each_entry_safe(session, h, &daemon->sessions, list)
+		session__remove(session);
+
+	free(daemon->config_real);
+}
+
+static void daemon__exit(struct daemon *daemon)
+{
+	daemon__kill(daemon);
+	daemon__free(daemon);
+	pr_info("daemon exited\n");
+	fclose(daemon->out);
+}
+
+static int setup_server_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[100];
+	int fd;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0) {
+		fprintf(stderr, "socket: %s\n", strerror(errno));
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	unlink(path);
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
+		perror("bind error");
+		return -1;
+	}
+
+	if (listen(fd, 1) == -1) {
+		perror("listen error");
+		return -1;
+	}
+
+	return fd;
+}
+
+enum {
+	CMD_LIST = 0,
+	CMD_MAX,
+};
+
+union cmd {
+	int cmd;
+
+	/* CMD_LIST */
+	struct {
+		int	cmd;
+		int	verbose;
+		char	csv_sep;
+	} list;
+};
+
+static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
+{
+	char csv_sep = cmd->list.csv_sep;
+	struct session *session;
+
+	if (csv_sep) {
+		fprintf(out, "%d%c%s%c%s%c%s/%s",
+			/* pid daemon  */
+			getpid(), csv_sep, "daemon",
+			/* base */
+			csv_sep, daemon->base,
+			/* output */
+			csv_sep, daemon->base, SESSION_OUTPUT);
+
+		fprintf(out, "\n");
+	} else {
+		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
+		if (cmd->list.verbose) {
+			fprintf(out, "  output:  %s/%s\n",
+				daemon->base, SESSION_OUTPUT);
+		}
+	}
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (csv_sep) {
+			fprintf(out, "%d%c%s%c%s",
+				/* pid */
+				session->pid,
+				/* name */
+				csv_sep, session->name,
+				/* base */
+				csv_sep, session->run);
+
+			fprintf(out, "%c%s%c%s/%s",
+				/* session dir */
+				csv_sep, session->base,
+				/* session output */
+				csv_sep, session->base, SESSION_OUTPUT);
+
+			fprintf(out, "\n");
+		} else {
+			fprintf(out, "[%d:%s] perf record %s\n",
+				session->pid, session->name, session->run);
+			if (!cmd->list.verbose)
+				continue;
+			fprintf(out, "  base:    %s\n",
+				session->base);
+			fprintf(out, "  output:  %s/%s\n",
+				session->base, SESSION_OUTPUT);
+		}
+	}
+
+	return 0;
+}
+
+static int handle_server_socket(struct daemon *daemon, int sock_fd)
+{
+	int ret = -EINVAL, fd;
+	union cmd cmd;
+	FILE *out;
+
+	fd = accept(sock_fd, NULL, NULL);
+	if (fd < 0) {
+		fprintf(stderr, "accept: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (sizeof(cmd) != read(fd, &cmd, sizeof(cmd))) {
+		fprintf(stderr, "read: %s\n", strerror(errno));
+		return -1;
+	}
+
+	out = fdopen(fd, "w");
+	if (!out) {
+		perror("fopen");
+		return -1;
+	}
+
+	switch (cmd.cmd) {
+	case CMD_LIST:
+		ret = cmd_session_list(daemon, &cmd, out);
+		break;
+	default:
+		break;
+	}
+
+	fclose(out);
+	close(fd);
+	return ret;
+}
+
+static int setup_client_socket(struct daemon *daemon)
+{
+	struct sockaddr_un addr;
+	char path[100];
+	int fd;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd == -1) {
+		perror("socket error");
+		return -1;
+	}
+
+	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+
+	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
+		perror("connect error");
+		return -1;
+	}
+
+	return fd;
+}
+
+static int go_background(struct daemon *daemon)
+{
+	int pid, fd;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+
+	if (pid > 0)
+		return 1;
+
+	if (setsid() < 0)
+		return -1;
+
+	umask(0);
+
+	if (chdir(daemon->base)) {
+		perror("chdir failed");
+		return -1;
+	}
+
+	fd = open("output", O_RDWR|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("open failed");
+		return -1;
+	}
+
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+	daemon->out = fdopen(fd, "w");
+	if (!daemon->out)
+		return -1;
+
+	close(0);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	setbuf(daemon->out, NULL);
+	return 0;
+}
+
+static int setup_config(struct daemon *daemon)
+{
+	if (daemon->config) {
+		char *real = realpath(daemon->config, NULL);
+
+		if (!real) {
+			perror("realpath failed");
+			return -1;
+		}
+		daemon->config_real = real;
+		return 0;
+	}
+
+	if (perf_config_system() && !access(perf_etc_perfconfig(), R_OK))
+		daemon->config_real = strdup(perf_etc_perfconfig());
+	else if (perf_config_global() && perf_home_perfconfig())
+		daemon->config_real = strdup(perf_home_perfconfig());
+
+	return daemon->config_real ? 0 : -1;
+}
+
+static int __cmd_start(struct daemon *daemon, struct option parent_options[],
+		       int argc, const char **argv)
+{
+	bool foreground = false;
+	struct option start_options[] = {
+		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
+		OPT_PARENT(parent_options),
+		OPT_END()
+	};
+	int sock_pos, sock_fd;
+	struct fdarray fda;
+	int err = 0;
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
+	if (setup_server_config(daemon))
+		return -1;
+
+	if (!foreground && go_background(daemon))
+		return -1;
+
+	debug_set_file(daemon->out);
+	debug_set_display_time(true);
+
+	pr_info("daemon started (pid %d)\n", getpid());
+
+	sock_fd = setup_server_socket(daemon);
+	if (sock_fd < 0)
+		return -1;
+
+	/* socket, inotify */
+	fdarray__init(&fda, 2);
+
+	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (sock_pos < 0)
+		return -1;
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	while (!done && !err) {
+		err = daemon__reconfig(daemon);
+
+		if (!err && fdarray__poll(&fda, -1)) {
+			bool reconfig = false;
+
+			if (fda.entries[sock_pos].revents & POLLIN)
+				err = handle_server_socket(daemon, sock_fd);
+
+			if (reconfig)
+				err = setup_server_config(daemon);
+		}
+	}
+
+	fdarray__exit(&fda);
+	daemon__exit(daemon);
+
+	close(sock_fd);
+	return err;
+}
+
+static int send_cmd(struct daemon *daemon, union cmd *cmd)
+{
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	FILE *in;
+	int fd;
+
+	setup_client_config(daemon);
+
+	fd = setup_client_socket(daemon);
+	if (fd < 0)
+		return -1;
+
+	if (sizeof(*cmd) != write(fd, cmd, sizeof(*cmd)))
+		return -1;
+
+	in = fdopen(fd, "r");
+	if (!in) {
+		perror("fopen");
+		return -1;
+	}
+
+	while ((nread = getline(&line, &len, in)) != -1) {
+		fwrite(line, nread, 1, stdout);
+		fflush(stdout);
+	}
+
+	close(fd);
+	return 0;
+}
+
+static int send_cmd_list(struct daemon *daemon)
+{
+	union cmd cmd = {
+		.list.cmd	= CMD_LIST,
+		.list.verbose	= verbose,
+	};
+
+	cmd.list.csv_sep = daemon->csv_sep ? *daemon->csv_sep : 0;
+	return send_cmd(daemon, &cmd);
+}
+
+int cmd_daemon(int argc, const char **argv)
+{
+	struct option daemon_options[] = {
+		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+		OPT_STRING(0, "config", &__daemon.config,
+			"config file", "config file path"),
+		OPT_STRING_OPTARG('x', "field-separator", &__daemon.csv_sep,
+			"field separator", "print counts with custom separator", ":"),
+		OPT_END()
+	};
+
+	perf_exe(__daemon.perf, sizeof(__daemon.perf));
+	__daemon.out = stdout;
+
+	argc = parse_options(argc, argv, daemon_options, daemon_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc && !strcmp(argv[0], "start"))
+		return __cmd_start(&__daemon, daemon_options, argc, argv);
+
+	if (argc) {
+		pr_err("failed: unknown command '%s'\n", argv[0]);
+		return -1;
+	}
+
+	if (setup_config(&__daemon)) {
+		pr_err("failed: config not found\n");
+		return -1;
+	}
+
+	return send_cmd_list(&__daemon);
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 14a2db622a7b..7303e80a639c 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -37,6 +37,7 @@ int cmd_inject(int argc, const char **argv);
 int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
+int cmd_daemon(int argc, const char **argv);
 
 int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen);
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index bc6c585f74fc..825a12e8d694 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -31,3 +31,4 @@ perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
 perf-version			mainporcelain common
+perf-daemon			mainporcelain common
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 27f94b0bb874..20cb91ef06ff 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -88,6 +88,7 @@ static struct cmd_struct commands[] = {
 	{ "mem",	cmd_mem,	0 },
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
+	{ "daemon",	cmd_daemon,	0 },
 };
 
 struct pager_config {
-- 
2.26.2

