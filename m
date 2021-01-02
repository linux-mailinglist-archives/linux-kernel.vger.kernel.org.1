Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4C2E88D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbhABWG0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:26 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:57601 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbhABWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:25 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-qCLXG6HDNd26471zNmt5YQ-1; Sat, 02 Jan 2021 17:05:28 -0500
X-MC-Unique: qCLXG6HDNd26471zNmt5YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7040107ACE3;
        Sat,  2 Jan 2021 22:05:26 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DF3B19727;
        Sat,  2 Jan 2021 22:05:22 +0000 (UTC)
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
Subject: [PATCH 12/22] perf daemon: Allow only one daemon over base directory
Date:   Sat,  2 Jan 2021 23:04:31 +0100
Message-Id: <20210102220441.794923-13-jolsa@kernel.org>
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

Add 'lock' file under daemon base and flock it, so only one
perf daemon can run on top of it.

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

And try once more:

  # perf daemon start
  failed: another perf daemon (pid 775594) owns /opt/perfdata

will end up with an error, because there's already one running
on top of /opt/perfdata.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 45748bb471ec..1982eedd3f3f 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -8,6 +8,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/file.h>
 #include <signal.h>
 #include <stdlib.h>
 #include <time.h>
@@ -562,12 +563,18 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* output */
 			csv_sep, daemon->base, SESSION_OUTPUT);
 
+		fprintf(out, "%c%s/%s",
+			/* lock */
+			csv_sep, daemon->base, "lock");
+
 		fprintf(out, "\n");
 	} else {
 		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
 		if (cmd->list.verbose) {
 			fprintf(out, "  output:  %s/%s\n",
 				daemon->base, SESSION_OUTPUT);
+			fprintf(out, "  lock:    %s/lock\n",
+				daemon->base);
 		}
 	}
 
@@ -761,6 +768,42 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
 	return 0;
 }
 
+static int check_lock(struct daemon *daemon)
+{
+	char path[PATH_MAX];
+	char buf[20];
+	int fd, pid;
+	ssize_t len;
+
+	scnprintf(path, sizeof(path), "%s/lock", daemon->base);
+
+	fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0640);
+	if (fd < 0)
+		return -1;
+
+	if (lockf(fd, F_TLOCK, 0) < 0) {
+		filename__read_int(path, &pid);
+		fprintf(stderr, "failed: another perf daemon (pid %d) owns %s\n",
+			pid, daemon->base);
+		return -1;
+	}
+
+	scnprintf(buf, sizeof(buf), "%d", getpid());
+	len = strlen(buf);
+
+	if (write(fd, buf, len) != len) {
+		perror("write failed");
+		return -1;
+	}
+
+	if (ftruncate(fd, len)) {
+		perror("ftruncate failed");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int go_background(struct daemon *daemon)
 {
 	int pid, fd;
@@ -775,6 +818,9 @@ static int go_background(struct daemon *daemon)
 	if (setsid() < 0)
 		return -1;
 
+	if (check_lock(daemon))
+		return -1;
+
 	umask(0);
 
 	if (chdir(daemon->base)) {
@@ -861,6 +907,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (setup_server_config(daemon))
 		return -1;
 
+	if (foreground && check_lock(daemon))
+		return -1;
+
 	if (!foreground && go_background(daemon))
 		return -1;
 
-- 
2.26.2

