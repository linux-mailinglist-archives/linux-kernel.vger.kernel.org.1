Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF82D85FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438807AbgLLKrT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:47:19 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:21916 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437240AbgLLKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:32 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-emnzXnawPbyxgorlL9n7RA-1; Sat, 12 Dec 2020 05:44:34 -0500
X-MC-Unique: emnzXnawPbyxgorlL9n7RA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12C4107ACE3;
        Sat, 12 Dec 2020 10:44:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9824F60CCE;
        Sat, 12 Dec 2020 10:44:29 +0000 (UTC)
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
Subject: [PATCH 8/8] perf daemon: Set control fifo for session
Date:   Sat, 12 Dec 2020 11:43:58 +0100
Message-Id: <20201212104358.412065-9-jolsa@kernel.org>
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

Setup control fifos for session and add --control
option to session arguments.

Use can list control fifos with:

   # perf daemon -v
   [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
     output:  /opt/perfdata/1/output
     control: /opt/perfdata/1/control
     ack:     /opt/perfdata/1/ack

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  8 +++++++-
 tools/perf/builtin-daemon.c              | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index 87de2c77e4c7..c507ba7c85cc 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -16,7 +16,8 @@ DESCRIPTION
 This command allows to run simple daemon process that starts and
 monitors configured record sessions.
 
-Each session represents one perf record process.
+Each session represents one perf record process started with
+control setup (with perf record --control.. options).
 
 These sessions are configured through config file, see CONFIG FILE
 section with EXAMPLES.
@@ -94,10 +95,15 @@ Check sessions with more info:
   # perf daemon -v
   [1:92187] perf record -m 11M -e cycles -o /opt/perfdata/1/perf.data --overwrite --switch-output -a
     output:  /opt/perfdata/1/output
+    control: /opt/perfdata/1/control
+    ack:     /opt/perfdata/1/ack
   [2:92188] perf record -m 20M -e sched:* -o /opt/perfdata/2/perf.data --overwrite --switch-output -a
     output:  /opt/perfdata/2/output
+    control: /opt/perfdata/2/control
+    ack:     /opt/perfdata/2/ack
 
 The 'output' file is perf record output for specific session.
+The 'control' and 'ack' files are perf control files.
 
 
 Send SIGUSR2 signal to all sessions:
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 1bd5432a57a3..765369a30414 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -33,6 +33,8 @@
 #include <api/fs/fs.h>
 
 #define SESSION_OUTPUT  "output"
+#define SESSION_CONTROL "control"
+#define SESSION_ACK     "ack"
 
 enum session_state {
 	SESSION_STATE__OK,
@@ -43,6 +45,7 @@ enum session_state {
 struct session {
 	char			*name;
 	char			*run;
+	char			*control;
 	int			 pid;
 	struct list_head	 list;
 	enum session_state	 state;
@@ -254,6 +257,8 @@ static void session__kill(struct session *session, struct daemon *daemon)
 
 static int session__run(struct session *session, struct daemon *daemon)
 {
+	char control[PATH_MAX];
+	char ack[PATH_MAX];
 	char base[PATH_MAX];
 	char buf[PATH_MAX];
 	char **argv;
@@ -266,6 +271,18 @@ static int session__run(struct session *session, struct daemon *daemon)
 		return -1;
 	}
 
+	scnprintf(control, sizeof(control), "%s/" SESSION_CONTROL, base);
+	if (mkfifo(control, O_RDWR) && errno != EEXIST) {
+		perror("failed to create control fifo");
+		return -1;
+	}
+
+	scnprintf(ack, sizeof(ack), "%s/" SESSION_ACK, base);
+	if (mkfifo(ack, O_RDWR) && errno != EEXIST) {
+		perror("failed to create ack fifo");
+		return -1;
+	}
+
 	session->pid = fork();
 	if (session->pid < 0)
 		return -1;
@@ -291,7 +308,8 @@ static int session__run(struct session *session, struct daemon *daemon)
 	dup2(fd, 2);
 	close(fd);
 
-	scnprintf(buf, sizeof(buf), "%s record %s", PERF, session->run);
+	scnprintf(buf, sizeof(buf), "%s record --control=fifo:%s,%s %s",
+		  PERF, control, ack, session->run);
 
 	argv = argv_split(buf, &argc);
 	if (!argv)
@@ -472,6 +490,10 @@ static int cmd_session_list(struct daemon *daemon, FILE *out, bool simple)
 			continue;
 		fprintf(out, "  output:  %s/%s/" SESSION_OUTPUT "\n",
 			daemon->base, session->name);
+		fprintf(out, "  control: %s/%s/" SESSION_CONTROL "\n",
+			daemon->base, session->name);
+		fprintf(out, "  ack:     %s/%s/" SESSION_ACK "\n",
+			daemon->base, session->name);
 	}
 
 	return 0;
-- 
2.26.2

