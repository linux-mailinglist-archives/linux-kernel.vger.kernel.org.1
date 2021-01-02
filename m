Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20C2E88CF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhABWGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:11 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56097 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbhABWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:10 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-AGSvRA6BNrK6rfLLOqmTSw-1; Sat, 02 Jan 2021 17:05:15 -0500
X-MC-Unique: AGSvRA6BNrK6rfLLOqmTSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72705C287;
        Sat,  2 Jan 2021 22:05:12 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C28B19727;
        Sat,  2 Jan 2021 22:05:09 +0000 (UTC)
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
Subject: [PATCH 08/22] perf daemon: Add config file change check
Date:   Sat,  2 Jan 2021 23:04:27 +0100
Message-Id: <20210102220441.794923-9-jolsa@kernel.org>
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

Adding support to detect daemon's config file changes
and re-read the configuration when that happens.

Using inotify file descriptor pluged into the main
fdarray object for polling.

Example:

  # cat ~/.perfconfig
  [daemon]
  base=/opt/perfdata

  [session-cycles]
  run = -m 10M -e cycles --overwrite --switch-output -a

Starting the daemon:

  # perf daemon start

Check sessions:

  # perf daemon
  [772262:daemon] base: /opt/perfdata
  [772263:cycles] perf record -m 10M -e cycles --overwrite --switch-output -a

Change '-m 10M' to '-m 20M', and check daemon log:

  # tail -f /opt/perfdata/output
  [2021-01-02 20:31:41.234045] daemon started (pid 772262)
  [2021-01-02 20:31:41.235072] reconfig: ruining session [cycles:772263]: -m 10M -e cycles --overwrite --switch-output -a
  [2021-01-02 20:32:08.310137] reconfig: session 'cycles' killed
  [2021-01-02 20:32:08.310847] reconfig: ruining session [cycles:772338]: -m 20M -e cycles --overwrite --switch-output -a

And the session list:

  # perf daemon
  [772262:daemon] base: /opt/perfdata
  [772338:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a

Note the changed '-m 20M' option is in place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 84 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index c2a7738a6a4a..16b24c30722d 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -547,6 +547,77 @@ static int setup_client_socket(struct daemon *daemon)
 	return fd;
 }
 
+static int setup_config_changes(struct daemon *daemon)
+{
+	char *basen = strdup(daemon->config_real);
+	char *dirn  = strdup(daemon->config_real);
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
 static int go_background(struct daemon *daemon)
 {
 	int pid, fd;
@@ -617,7 +688,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 		OPT_PARENT(parent_options),
 		OPT_END()
 	};
-	int sock_pos, sock_fd;
+	int sock_pos, file_pos, sock_fd, conf_fd;
 	struct fdarray fda;
 	int err = 0;
 
@@ -645,6 +716,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (sock_fd < 0)
 		return -1;
 
+	conf_fd = setup_config_changes(daemon);
+	if (conf_fd < 0)
+		return -1;
+
 	/* socket, inotify */
 	fdarray__init(&fda, 2);
 
@@ -652,6 +727,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (sock_pos < 0)
 		return -1;
 
+	file_pos = fdarray__add(&fda, conf_fd, POLLIN|POLLERR|POLLHUP, 0);
+	if (file_pos < 0)
+		return -1;
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -663,6 +742,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 
 			if (fda.entries[sock_pos].revents & POLLIN)
 				err = handle_server_socket(daemon, sock_fd);
+			if (fda.entries[file_pos].revents & POLLIN)
+				err = handle_config_changes(daemon, conf_fd, &reconfig);
 
 			if (reconfig)
 				err = setup_server_config(daemon);
@@ -673,6 +754,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	daemon__exit(daemon);
 
 	close(sock_fd);
+	close(conf_fd);
 	return err;
 }
 
-- 
2.26.2

