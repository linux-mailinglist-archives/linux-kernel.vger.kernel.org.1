Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B282E88D7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbhABWGi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:38 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:25607 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbhABWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-rT8cNbYUM5G6EuCTvDjgdA-1; Sat, 02 Jan 2021 17:05:40 -0500
X-MC-Unique: rT8cNbYUM5G6EuCTvDjgdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D714A10054FF;
        Sat,  2 Jan 2021 22:05:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 169E01A353;
        Sat,  2 Jan 2021 22:05:35 +0000 (UTC)
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
Subject: [PATCH 16/22] perf daemon: Add up time for daemon/session list
Date:   Sat,  2 Jan 2021 23:04:35 +0100
Message-Id: <20210102220441.794923-17-jolsa@kernel.org>
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

Display up time for both daemon and sessions.

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

Get the details with up time:

  # perf daemon -v
  [778315:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
    up:      15 minutes
  [778316:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
    up:      10 minutes
  [778317:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack
    up:      2 minutes

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index e45a1acaad18..d99aee2a59da 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -24,6 +24,7 @@
 #include <fcntl.h>
 #include <sys/inotify.h>
 #include <libgen.h>
+#include <time.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
@@ -52,6 +53,7 @@ struct session {
 	int			 pid;
 	struct list_head	 list;
 	enum session_state	 state;
+	time_t			 start;
 };
 
 struct daemon {
@@ -64,6 +66,7 @@ struct daemon {
 	FILE			*out;
 	char			 perf[PATH_MAX];
 	int			 signal_fd;
+	time_t			 start;
 };
 
 static struct daemon __daemon = {
@@ -255,6 +258,8 @@ static int session__run(struct session *session, struct daemon *daemon)
 		return -1;
 	}
 
+	session->start = time(NULL);
+
 	session->pid = fork();
 	if (session->pid < 0)
 		return -1;
@@ -690,6 +695,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 {
 	char csv_sep = cmd->list.csv_sep;
 	struct session *session;
+	time_t curr = time(NULL);
 
 	if (csv_sep) {
 		fprintf(out, "%d%c%s%c%s%c%s/%s",
@@ -704,6 +710,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* lock */
 			csv_sep, daemon->base, "lock");
 
+		fprintf(out, "%c%lu",
+			/* session up time */
+			csv_sep, (curr - daemon->start) / 60);
+
 		fprintf(out, "\n");
 	} else {
 		fprintf(out, "[%d:daemon] base: %s\n", getpid(), daemon->base);
@@ -712,6 +722,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				daemon->base, SESSION_OUTPUT);
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
+			fprintf(out, "  up:      %lu minutes\n",
+				(curr - daemon->start) / 60);
 		}
 	}
 
@@ -737,6 +749,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session ack */
 				csv_sep, session->base, SESSION_ACK);
 
+			fprintf(out, "%c%lu",
+				/* session up time */
+				csv_sep, (curr - session->start) / 60);
+
 			fprintf(out, "\n");
 		} else {
 			fprintf(out, "[%d:%s] perf record %s\n",
@@ -751,6 +767,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base, SESSION_CONTROL);
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
+			fprintf(out, "  up:      %lu minutes\n",
+				(curr - session->start) / 60);
 		}
 	}
 
@@ -1072,6 +1090,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
 	if (argc)
 		usage_with_options(daemon_usage, start_options);
 
+	daemon->start = time(NULL);
+
 	if (setup_config(daemon)) {
 		pr_err("failed: config not found\n");
 		return -1;
-- 
2.26.2

