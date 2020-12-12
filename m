Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACD2D8600
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438813AbgLLKrX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:47:23 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52915 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407388AbgLLKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:20 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-tpCFv_FMOLqULqSaVG5lGQ-1; Sat, 12 Dec 2020 05:44:20 -0500
X-MC-Unique: tpCFv_FMOLqULqSaVG5lGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69159180A092;
        Sat, 12 Dec 2020 10:44:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E26660CCE;
        Sat, 12 Dec 2020 10:44:15 +0000 (UTC)
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
Subject: [PATCH 4/8] perf daemon: Add daemon command
Date:   Sat, 12 Dec 2020 11:43:54 +0100
Message-Id: <20201212104358.412065-5-jolsa@kernel.org>
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

Adding daemon command that allows to run record sessions
on background. Each session represents one perf record
process and is configured in config file.

Example:

  # cat config.daemon
  [daemon]
  base=/opt/perfdata

  [session-1]
  run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a

  [session-2]
  run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a

Default perf config has the same daemon base:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

Starting the daemon:

  # perf daemon --config config.daemon

Check sessions:

  # perf daemon
  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a

Check sessions with more info:

  # perf daemon -v
  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
    output:  /opt/perfdata/1/output
  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
    output:  /opt/perfdata/2/output

The 'output' file is perf record output for specific session.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Build                         |   3 +
 tools/perf/Documentation/perf-daemon.txt |  97 +++
 tools/perf/builtin-daemon.c              | 794 +++++++++++++++++++++++
 tools/perf/builtin.h                     |   1 +
 tools/perf/command-list.txt              |   1 +
 tools/perf/perf.c                        |   1 +
 6 files changed, 897 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/builtin-daemon.c

diff --git a/tools/perf/Build b/tools/perf/Build
index 5f392dbb88fc..54aa38996fff 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -24,6 +24,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-y += builtin-daemon.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
@@ -53,3 +54,5 @@ perf-y += scripts/
 perf-$(CONFIG_TRACE) += trace/beauty/
 
 gtk-y += ui/gtk/
+
+CFLAGS_builtin-daemon.o += -DPERF="BUILD_STR($(bindir_SQ)/perf)"
diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
new file mode 100644
index 000000000000..dee39be110ba
--- /dev/null
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -0,0 +1,97 @@
+perf-daemon(1)
+==============
+
+NAME
+----
+perf-daemon - Run record sessions on background
+
+SYNOPSIS
+--------
+[verse]
+'perf daemon'
+'perf daemon' [<options>]
+
+DESCRIPTION
+-----------
+This command allows to run simple daemon process that starts and
+monitors configured record sessions.
+
+Each session represents one perf record process.
+
+These sessions are configured through config file, see CONFIG FILE
+section with EXAMPLES.
+
+OPTIONS
+-------
+--config=<PATH>::
+	Config file path.
+
+-f::
+--foreground::
+	Do not put the process in background.
+
+-v::
+--verbose::
+	Be more verbose.
+
+CONFIG FILE
+-----------
+The daemon is configured within standard perf config file by
+following new variables:
+
+daemon.base:
+	Base path for daemon data. All sessions data are
+	stored under this path.
+
+session-<NAME>.run:
+	Defines new record session. The value is record's command
+	line without the 'record' keyword.
+
+EXAMPLES
+--------
+Example with 2 record sessions:
+
+  # cat config.daemon
+  [daemon]
+  base=/opt/perfdata
+
+  [session-1]
+  run = -m 10M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
+
+  [session-2]
+  run = -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
+
+
+Default perf config has the same daemon base:
+
+  # cat ~/.perfconfig
+  [daemon]
+  base=/opt/perfdata
+
+
+Starting the daemon:
+
+  # perf daemon --config config.daemon
+
+
+Check sessions:
+
+  # perf daemon
+  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
+  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
+
+
+Check sessions with more info:
+
+  # perf daemon -v
+  [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
+    output:  /opt/perfdata/1/output
+  [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
+    output:  /opt/perfdata/2/output
+
+The 'output' file is perf record output for specific session.
+
+
+SEE ALSO
+--------
+linkperf:perf-record[1], linkperf:perf-config[1]
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
new file mode 100644
index 000000000000..7f455837d58a
--- /dev/null
+++ b/tools/perf/builtin-daemon.c
@@ -0,0 +1,794 @@
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
+	char			*name;
+	char			*run;
+	int			 pid;
+	struct list_head	 list;
+	enum session_state	 state;
+};
+
+struct daemon {
+	char			*config;
+	char			*config_base;
+	char			*base;
+	struct list_head	 sessions;
+	FILE			*out;
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
+static int session_name(const char *var, char *session, int len)
+{
+	const char *p = var + sizeof("session-") - 1;
+
+	while (*p != '.' && len--)
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
+	if (session_name(var, name, sizeof(name)))
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
+	set = perf_config_set__new_file(daemon->config);
+	if (set) {
+		err = perf_config_set(set, server_config, daemon);
+		perf_config_set__delete(set);
+	}
+
+	return err;
+}
+
+static int session__check(struct session *session, struct daemon *daemon)
+{
+	int err, status;
+
+	err = waitpid(session->pid, &status, WNOHANG);
+	if (err < 0) {
+		session->pid = -1;
+		return -1;
+	}
+
+	if (err && WIFEXITED(status)) {
+		fprintf(daemon->out, "session(%d) %s excited with %d\n",
+			session->pid, session->name, WEXITSTATUS(status));
+		session->state = SESSION_STATE__KILL;
+		session->pid = -1;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int session__wait(struct session *session, struct daemon *daemon,
+			 int secs)
+{
+	time_t current, start = 0;
+	int cnt;
+
+	start = current = time(NULL);
+
+	do {
+		usleep(500);
+		cnt = session__check(session, daemon);
+		if (cnt)
+			break;
+
+		current = time(NULL);
+	} while ((start + secs > current));
+
+	return cnt;
+}
+
+static int session__signal(struct session *session, int sig)
+{
+	if (session->pid < 0)
+		return -1;
+	return kill(session->pid, sig);
+}
+
+static void session__kill(struct session *session, struct daemon *daemon)
+{
+	session__signal(session, SIGTERM);
+	if (session__wait(session, daemon, 30))
+		session__signal(session, SIGKILL);
+}
+
+static int session__run(struct session *session, struct daemon *daemon)
+{
+	char base[PATH_MAX];
+	char buf[PATH_MAX];
+	char **argv;
+	int argc, fd;
+
+	scnprintf(base, PATH_MAX, "%s/%s", daemon->base, session->name);
+
+	if (mkdir(base, 0755) && errno != EEXIST) {
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
+	if (chdir(base)) {
+		perror("chdir failed");
+		return -1;
+	}
+
+	fd = open(SESSION_OUTPUT, O_RDWR|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("open failed");
+		return -1;
+	}
+
+	close(0);
+	dup2(fd, 1);
+	dup2(fd, 2);
+	close(fd);
+
+	scnprintf(buf, sizeof(buf), "%s record %s", PERF, session->run);
+
+	argv = argv_split(buf, &argc);
+	if (!argv)
+		exit(-1);
+
+	exit(execve(PERF, argv, NULL));
+	return -1;
+}
+
+static int daemon__check(struct daemon *daemon)
+{
+	struct session *session;
+	int cnt = 0;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (session__check(session, daemon))
+			continue;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+static int daemon__wait(struct daemon *daemon, int secs)
+{
+	time_t current, start = 0;
+	int cnt;
+
+	start = current = time(NULL);
+
+	do {
+		usleep(100);
+		cnt = daemon__check(daemon);
+		if (!cnt)
+			break;
+
+		current = time(NULL);
+	} while ((start + secs > current));
+
+	return cnt;
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
+				session__kill(session, daemon);
+				pr_info("reconfig: session '%s' killed\n", session->name);
+			}
+			session__remove(session);
+			continue;
+		}
+
+		/* Reconfig session. */
+		pr_debug2("reconfig: session '%s' start\n", session->name);
+		if (session->pid > 0) {
+			session__kill(session, daemon);
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
+	if (daemon__wait(daemon, 30))
+		daemon__signal(daemon, SIGKILL);
+}
+
+static void daemon__free(struct daemon *daemon)
+{
+	struct session *session, *h;
+
+	list_for_each_entry_safe(session, h, &daemon->sessions, list)
+		session__remove(session);
+
+	free(daemon->config);
+}
+
+static void daemon__exit(struct daemon *daemon)
+{
+	daemon__kill(daemon);
+	daemon__free(daemon);
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
+enum cmd {
+	CMD_LIST         = 0,
+	CMD_LIST_VERBOSE = 1,
+	CMD_MAX,
+};
+
+static int cmd_session_list(struct daemon *daemon, FILE *out, bool simple)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		fprintf(out, "[%s:%d] perf record %s\n",
+			session->name, session->pid, session->run);
+		if (simple)
+			continue;
+		fprintf(out, "  output:  %s/%s/" SESSION_OUTPUT "\n",
+			daemon->base, session->name);
+	}
+
+	return 0;
+}
+
+static int handle_server_socket(struct daemon *daemon, int sock_fd)
+{
+	int ret = -EINVAL, fd;
+	FILE *out;
+	u64 cmd;
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
+	switch (cmd) {
+	case CMD_LIST:
+	case CMD_LIST_VERBOSE:
+		ret = cmd_session_list(daemon, out, cmd == CMD_LIST);
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
+static int setup_config_changes(struct daemon *daemon)
+{
+	char *basen = strdup(daemon->config);
+	char *dirn  = strdup(daemon->config);
+	char *base, *dir;
+	int fd, wd;
+
+	if (!dirn || !basen)
+		return -ENOMEM;
+
+	fd = inotify_init1(IN_NONBLOCK|O_CLOEXEC);
+	if (fd < 0) {
+		perror("inotify_init failed");
+		return -1;
+	}
+
+	dir = dirname(dirn);
+	base = basename(basen);
+	pr_debug("config file: %s, dir: %s\n", base, dir);
+
+	wd = inotify_add_watch(fd, dir, IN_CLOSE_WRITE);
+	if (wd < 0)
+		perror("inotify_add_watch failed");
+	else
+		daemon->config_base = base;
+
+	free(dirn);
+	return wd < 0 ? -1 : fd;
+}
+
+static bool process_inotify_event(struct daemon *daemon, char *buf, ssize_t len)
+{
+	char *p = buf;
+
+	while (p < (buf + len)) {
+		struct inotify_event *event = (struct inotify_event *) p;
+
+		/*
+		 * We monitor config directory, check if our
+		 * config file was changes.
+		 */
+		if ((event->mask & IN_CLOSE_WRITE) &&
+		    !(event->mask & IN_ISDIR)) {
+			if (!strcmp(event->name, daemon->config_base))
+				return true;
+		}
+		p += sizeof(*event) + event->len;
+	}
+	return false;
+}
+
+static int handle_config_changes(struct daemon *daemon, int conf_fd,
+				 bool *config_changed)
+{
+	char buf[4096];
+	ssize_t len;
+
+	while (!(*config_changed)) {
+		len = read(conf_fd, buf, sizeof(buf));
+		if (len == -1) {
+			if (errno != EAGAIN) {
+				perror("read failed");
+				return -1;
+			}
+			return 0;
+		}
+		*config_changed = process_inotify_event(daemon, buf, len);
+	}
+	return 0;
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
+static int set_daemon_config(struct daemon *daemon, const char *config)
+{
+	char *real = realpath(config, NULL);
+
+	if (!real) {
+		perror("realpath failed");
+		return -1;
+	}
+	daemon->config = real;
+	return 0;
+}
+
+static int __cmd_daemon(struct daemon *daemon, bool foreground, const char *config)
+{
+	int sock_pos, file_pos, sock_fd, conf_fd;
+	bool reconfig = true;
+	struct fdarray fda;
+	int err = 0;
+
+	if (set_daemon_config(daemon, config))
+		return -1;
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
+	conf_fd = setup_config_changes(daemon);
+	if (conf_fd < 0)
+		return -1;
+
+	/* socket, inotify */
+	fdarray__init(&fda, 2);
+
+	sock_pos = fdarray__add(&fda, sock_fd, POLLIN | POLLERR | POLLHUP, 0);
+	if (sock_pos < 0)
+		return -1;
+
+	file_pos = fdarray__add(&fda, conf_fd, POLLIN | POLLERR | POLLHUP, 0);
+	if (file_pos < 0)
+		return -1;
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	while (!done && !err) {
+		if (reconfig) {
+			err = daemon__reconfig(daemon);
+			reconfig = false;
+		}
+
+		if (fdarray__poll(&fda, 500)) {
+			if (fda.entries[sock_pos].revents & POLLIN)
+				err = handle_server_socket(daemon, sock_fd);
+			if (fda.entries[file_pos].revents & POLLIN)
+				err = handle_config_changes(daemon, conf_fd, &reconfig);
+
+			if (reconfig)
+				err = setup_server_config(daemon);
+		}
+
+		if (!daemon__check(daemon)) {
+			fprintf(daemon->out, "no sessions left, bailing out\n");
+			break;
+		}
+	}
+
+	pr_info("daemon exited\n");
+
+	close(sock_fd);
+	close(conf_fd);
+
+	fdarray__exit(&fda);
+	daemon__exit(daemon);
+	return err;
+}
+
+static int send_cmd(struct daemon *daemon, u64 cmd)
+{
+	char *line = NULL;
+	size_t len = 0;
+	ssize_t nread;
+	FILE *in;
+	int fd;
+
+	perf_config(client_config, daemon);
+
+	fd = setup_client_socket(daemon);
+	if (fd < 0)
+		return -1;
+
+	if (sizeof(cmd) != write(fd, &cmd, sizeof(cmd)))
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
+static const char * const daemon_usage[] = {
+	"perf daemon [<options>]",
+	NULL
+};
+
+int cmd_daemon(int argc, const char **argv)
+{
+	bool foreground = false;
+	const char *config = NULL;
+	struct daemon daemon = {
+		.sessions = LIST_HEAD_INIT(daemon.sessions),
+		.out	  = stdout,
+	};
+	struct option daemon_options[] = {
+		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+		OPT_STRING(0, "config", &config,
+			   "config file", "config file path"),
+		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, daemon_options, daemon_usage, 0);
+	if (argc)
+		usage_with_options(daemon_usage, daemon_options);
+
+	if (config)
+		return __cmd_daemon(&daemon, foreground, config);
+
+	return send_cmd(&daemon, verbose ? CMD_LIST_VERBOSE : CMD_LIST);
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

