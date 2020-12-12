Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6D2D85FE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438798AbgLLKqt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:46:49 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52972 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407392AbgLLKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-taTX-HrMNk6yMqdfLr3e8g-1; Sat, 12 Dec 2020 05:44:31 -0500
X-MC-Unique: taTX-HrMNk6yMqdfLr3e8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345AE107ACE3;
        Sat, 12 Dec 2020 10:44:29 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6059E60CCE;
        Sat, 12 Dec 2020 10:44:25 +0000 (UTC)
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
Subject: [PATCH 7/8] perf daemon: Allow only one daemon over base directory
Date:   Sat, 12 Dec 2020 11:43:57 +0100
Message-Id: <20201212104358.412065-8-jolsa@kernel.org>
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

Add 'lock' file under daemon base and flock it, so only one
perf daemon can run on top of it.

  # perf daemon --config ./config.daemon
  # perf daemon --config ./config.daemon
  failed: another perf daemon (pid 369675) owns /opt/perfdata

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 855fed2fe364..1bd5432a57a3 100644
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
@@ -639,6 +640,42 @@ static int handle_config_changes(struct daemon *daemon, int conf_fd,
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
+	fd = open(path, O_RDWR|O_CREAT, 0640);
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
@@ -653,6 +690,9 @@ static int go_background(struct daemon *daemon)
 	if (setsid() < 0)
 		return -1;
 
+	if (check_lock(daemon))
+		return -1;
+
 	umask(0);
 
 	if (chdir(daemon->base)) {
@@ -704,6 +744,9 @@ static int __cmd_daemon(struct daemon *daemon, bool foreground, const char *conf
 	if (setup_server_config(daemon))
 		return -1;
 
+	if (foreground && check_lock(daemon))
+		return -1;
+
 	if (!foreground && go_background(daemon))
 		return -1;
 
-- 
2.26.2

