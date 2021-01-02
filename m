Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6882E88D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhABWG3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:06:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39264 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbhABWG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:06:28 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-nxm3-xakMWWB9WcPQPnwqg-1; Sat, 02 Jan 2021 17:05:31 -0500
X-MC-Unique: nxm3-xakMWWB9WcPQPnwqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C75E59;
        Sat,  2 Jan 2021 22:05:29 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C66C1A353;
        Sat,  2 Jan 2021 22:05:27 +0000 (UTC)
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
Subject: [PATCH 13/22] perf daemon: Set control fifo for session
Date:   Sat,  2 Jan 2021 23:04:32 +0100
Message-Id: <20210102220441.794923-14-jolsa@kernel.org>
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

Setup control fifos for session and add --control
option to session arguments.

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

Use can list control fifos with (control and ack files):

  # perf daemon -v
  [776459:daemon] base: /opt/perfdata
    output:  /opt/perfdata/output
    lock:    /opt/perfdata/lock
  [776460:cycles] perf record -m 20M -e cycles --overwrite --switch-output -a
    base:    /opt/perfdata/session-cycles
    output:  /opt/perfdata/session-cycles/output
    control: /opt/perfdata/session-cycles/control
    ack:     /opt/perfdata/session-cycles/ack
  [776461:sched] perf record -m 20M -e sched:* --overwrite --switch-output -a
    base:    /opt/perfdata/session-sched
    output:  /opt/perfdata/session-sched/output
    control: /opt/perfdata/session-sched/control
    ack:     /opt/perfdata/session-sched/ack

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-daemon.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 1982eedd3f3f..0c82fe9603e8 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -35,6 +35,8 @@
 #include <sys/signalfd.h>
 
 #define SESSION_OUTPUT  "output"
+#define SESSION_CONTROL "control"
+#define SESSION_ACK     "ack"
 
 enum session_state {
 	SESSION_STATE__OK,
@@ -46,6 +48,7 @@ struct session {
 	char			*base;
 	char			*name;
 	char			*run;
+	char			*control;
 	int			 pid;
 	struct list_head	 list;
 	enum session_state	 state;
@@ -288,7 +291,18 @@ static int session__run(struct session *session, struct daemon *daemon)
 	dup2(fd, 2);
 	close(fd);
 
-	scnprintf(buf, sizeof(buf), "%s record %s", daemon->perf, session->run);
+	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
+		perror("failed to create control fifo");
+		return -1;
+	}
+
+	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
+		perror("failed to create ack fifo");
+		return -1;
+	}
+
+	scnprintf(buf, sizeof(buf), "%s record --control=fifo:%s,%s %s",
+		  daemon->perf, SESSION_CONTROL, SESSION_ACK, session->run);
 
 	argv = argv_split(buf, &argc);
 	if (!argv)
@@ -594,6 +608,12 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session output */
 				csv_sep, session->base, SESSION_OUTPUT);
 
+			fprintf(out, "%c%s/%s%c%s/%s",
+				/* session control */
+				csv_sep, session->base, SESSION_CONTROL,
+				/* session ack */
+				csv_sep, session->base, SESSION_ACK);
+
 			fprintf(out, "\n");
 		} else {
 			fprintf(out, "[%d:%s] perf record %s\n",
@@ -604,6 +624,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base);
 			fprintf(out, "  output:  %s/%s\n",
 				session->base, SESSION_OUTPUT);
+			fprintf(out, "  control: %s/%s\n",
+				session->base, SESSION_CONTROL);
+			fprintf(out, "  ack:     %s/%s\n",
+				session->base, SESSION_ACK);
 		}
 	}
 
-- 
2.26.2

