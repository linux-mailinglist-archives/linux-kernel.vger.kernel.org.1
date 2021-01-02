Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993AE2E88D0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbhABWGN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:13 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:28140 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbhABWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:12 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-kpr3W_FTNmqE3jOvpf5gow-1; Sat, 02 Jan 2021 17:05:17 -0500
X-MC-Unique: kpr3W_FTNmqE3jOvpf5gow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD55210054FF;
        Sat,  2 Jan 2021 22:05:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7ED71A353;
        Sat,  2 Jan 2021 22:05:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 09/22] perf daemon: Add signalfd support
Date:   Sat,  2 Jan 2021 23:04:28 +0100
Message-Id: <20210102220441.794923-10-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using signalfd fd for tracking SIGCHLD signals as
notification for perf session termination.

Suggested-by: Alexei Budankov <abudankov@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 142 ++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 16b24c30722d..644f196d7f39 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -31,6 +31,7 @@
 #include "asm/bug.h"
 #include "util.h"
 #include <api/fs/fs.h>
+#include <sys/signalfd.h>
 
 #define SESSION_OUTPUT  "output"
 
@@ -58,6 +59,7 @@ struct daemon {
 	struct list_head	 sessions;
 	FILE			*out;
 	char			 perf[PATH_MAX];
+	int			 signal_fd;
 };
 
 static struct daemon __daemon = {
@@ -317,9 +319,110 @@ static void session__remove(struct session *session)
 	session__free(session);
 }
 
-static void session__kill(struct session *session)
+static pid_t handle_signalfd(struct daemon *daemon)
+{
+	struct signalfd_siginfo si;
+	struct session *session;
+	ssize_t err;
+	int status;
+	pid_t pid;
+
+	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
+	if (err != sizeof(struct signalfd_siginfo))
+		return -1;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+
+		if (session->pid != (int) si.ssi_pid)
+			continue;
+
+		pid = waitpid(session->pid, &status, 0);
+		if (pid == session->pid) {
+			if (WIFEXITED(status)) {
+				pr_info("session '%s' exited, status=%d\n",
+					session->name, WEXITSTATUS(status));
+			} else if (WIFSIGNALED(status)) {
+				pr_info("session '%s' killed (signal %d)\n",
+					session->name, WTERMSIG(status));
+			} else if (WIFSTOPPED(status)) {
+				pr_info("session '%s' stopped (signal %d)\n",
+					session->name, WSTOPSIG(status));
+			} else {
+				pr_info("session '%s' Unexpected status (0x%x)\n",
+					session->name, status);
+			}
+		}
+
+		session->state = SESSION_STATE__KILL;
+		session->pid = -1;
+		return pid;
+	}
+
+	return 0;
+}
+
+static int session__wait(struct session *session, struct daemon *daemon, int secs)
+{
+	struct pollfd pollfd = {
+		.fd	= daemon->signal_fd,
+		.events	= POLLIN,
+	};
+	pid_t wpid = 0, pid = session->pid;
+	time_t start;
+
+	start = time(NULL);
+
+	do {
+		if (poll(&pollfd, 1, 1000))
+			wpid = handle_signalfd(daemon);
+
+		if (start + secs < time(NULL))
+			return -1;
+	} while (wpid != pid);
+
+	return 0;
+}
+
+static bool daemon__has_alive_session(struct daemon *daemon)
+{
+	struct session *session;
+
+	list_for_each_entry(session, &daemon->sessions, list) {
+		if (session->state == SESSION_STATE__OK)
+			return true;
+	}
+
+	return false;
+}
+
+static int daemon__wait(struct daemon *daemon, int secs)
+{
+	struct pollfd pollfd = {
+		.fd	= daemon->signal_fd,
+		.events	= POLLIN,
+	};
+	time_t start;
+
+	start = time(NULL);
+
+	do {
+		if (poll(&pollfd, 1, 1000))
+			handle_signalfd(daemon);
+
+		if (start + secs < time(NULL))
+			return -1;
+	} while (daemon__has_alive_session(daemon));
+
+	return 0;
+}
+
+static void session__kill(struct session *session, struct daemon *daemon)
 {
 	session__signal(session, SIGTERM);
+	if (session__wait(session, daemon, 10)) {
+		session__signal(session, SIGKILL);
+		session__wait(session, daemon, 10);
+	}
 }
 
 static int daemon__reconfig(struct daemon *daemon)
@@ -334,7 +437,7 @@ static int daemon__reconfig(struct daemon *daemon)
 		/* Remove session. */
 		if (session->state == SESSION_STATE__KILL) {
 			if (session->pid > 0) {
-				session__kill(session);
+				session__kill(session, daemon);
 				pr_info("reconfig: session '%s' killed\n", session->name);
 			}
 			session__remove(session);
@@ -344,7 +447,7 @@ static int daemon__reconfig(struct daemon *daemon)
 		/* Reconfig session. */
 		pr_debug2("reconfig: session '%s' start\n", session->name);
 		if (session->pid > 0) {
-			session__kill(session);
+			session__kill(session, daemon);
 			pr_info("reconfig: session '%s' killed\n", session->name);
 		}
 		if (session__run(session, daemon))
@@ -359,6 +462,10 @@ static int daemon__reconfig(struct daemon *daemon)
 static void daemon__kill(struct daemon *daemon)
 {
 	daemon__signal(daemon, SIGTERM);
+	if (daemon__wait(daemon, 10)) {
+		daemon__signal(daemon, SIGKILL);
+		daemon__wait(daemon, 10);
+	}
 }
 
 static void daemon__free(struct daemon *daemon)
@@ -679,6 +786,20 @@ static int setup_config(struct daemon *daemon)
 	return daemon->config_real ? 0 : -1;
 }
 
+static int setup_signalfd(struct daemon *daemon)
+{
+	sigset_t mask;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		return -1;
+
+	daemon->signal_fd = signalfd(-1, &mask, SFD_NONBLOCK|SFD_CLOEXEC);
+	return daemon->signal_fd;
+}
+
 static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		       int argc, const char **argv)
 {
@@ -688,7 +809,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	int sock_pos, file_pos, sock_fd, conf_fd;
+	int sock_pos, file_pos, signal_pos, sock_fd, conf_fd, signal_fd;
 	struct fdarray fda;
 	int err = 0;
 
@@ -720,8 +841,12 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (conf_fd < 0)
 		return -1;
 
+	signal_fd = setup_signalfd(daemon);
+	if (signal_fd < 0)
+		return -1;
+
 	/* socket, inotify */
-	fdarray__init(&fda, 2);
+	fdarray__init(&fda, 3);
 
 	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
 	if (sock_pos < 0)
@@ -731,6 +856,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (file_pos < 0)
 		return -1;
 
+	signal_pos = fdarray__add(&fda, signal_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (signal_pos < 0)
+		return -1;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -744,6 +873,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 				err = handle_server_socket(daemon, sock_fd);
 			if (fda.entries[file_pos].revents & POLLIN)
 				err = handle_config_changes(daemon, conf_fd, &reconfig);
+			if (fda.entries[signal_pos].revents & POLLIN)
+				err = handle_signalfd(daemon) < 0;
 
 			if (reconfig)
 				err = setup_server_config(daemon);
@@ -755,6 +886,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 	close(sock_fd);
 	close(conf_fd);
+	close(signal_fd);
 	return err;
 }
 
-- 
2.26.2

