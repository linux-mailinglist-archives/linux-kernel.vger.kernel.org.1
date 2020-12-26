Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15E02E2F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgLZXVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Dec 2020 18:21:45 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:43611 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLZXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:21:44 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-piWw_4oiMF6lgl1H0_qPOw-1; Sat, 26 Dec 2020 18:20:47 -0500
X-MC-Unique: piWw_4oiMF6lgl1H0_qPOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E61801817;
        Sat, 26 Dec 2020 23:20:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4A7260C43;
        Sat, 26 Dec 2020 23:20:42 +0000 (UTC)
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
Subject: [PATCH 1/4] perf tools: Allow to enable/disable events via control file
Date:   Sun, 27 Dec 2020 00:20:35 +0100
Message-Id: <20201226232038.390883-2-jolsa@kernel.org>
In-Reply-To: <20201226232038.390883-1-jolsa@kernel.org>
References: <20201226232038.390883-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new control events to enable/disable specific event.
The interface string for control file are:

  'enable <EVENT NAME>'
  'disable <EVENT NAME>'

when received the command, perf will scan the current evlist
for <EVENT NAME> and if found it's enabled/disabled.

Example session:

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe

  terminal 2:
    # cat perf.pipe | perf --no-pager script -i -

  terminal 1:
    Events disabled

  NOTE Above message will show only after read side of the pipe ('>')
  is started on 'terminal 2'. The 'terminal 1's bash does not execute
  perf before that, hence the delyaed perf record message.

  terminal 3:
    # echo 'enable sched:sched_process_fork' > control

  terminal 1:
    event sched:sched_process_fork enabled

  terminal 2:
    bash 33349 [034] 149587.674295: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34056
    bash 33349 [034] 149588.239521: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34057

  terminal 3:
    # echo 'enable sched:sched_wakeup_new' > control

  terminal 1:
    event sched:sched_wakeup_new enabled

  terminal 2:
    bash 33349 [034] 149632.228023: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34059
    bash 33349 [034] 149632.228050:   sched:sched_wakeup_new: bash:34059 [120] success=1 CPU:036
    bash 33349 [034] 149633.950005: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34060
    bash 33349 [034] 149633.950030:   sched:sched_wakeup_new: bash:34060 [120] success=1 CPU:036

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  8 +--
 tools/perf/builtin-record.c              |  8 +--
 tools/perf/builtin-stat.c                |  2 -
 tools/perf/util/evlist.c                 | 63 ++++++++++++++++++++++--
 4 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 34cf651ee237..05a85da0f7c5 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -640,9 +640,11 @@ ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
 Listen on ctl-fd descriptor for command to control measurement.
 
 Available commands:
-  'enable'  : enable events
-  'disable' : disable events
-  'snapshot': AUX area tracing snapshot).
+  'enable'       : enable events
+  'disable'      : disable events
+  'enable name'  : enable event 'name'
+  'disable name' : disable event 'name'
+  'snapshot'     : AUX area tracing snapshot).
 
 Measurements can be started with events disabled using --delay=-1 option. Optionally
 send control command completion ('ack\n') to ack-fd descriptor to synchronize with the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fd3911650612..7302e7527d40 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1937,18 +1937,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
 			switch (cmd) {
-			case EVLIST_CTL_CMD_ENABLE:
-				pr_info(EVLIST_ENABLED_MSG);
-				break;
-			case EVLIST_CTL_CMD_DISABLE:
-				pr_info(EVLIST_DISABLED_MSG);
-				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				hit_auxtrace_snapshot_trigger(rec);
 				evlist__ctlfd_ack(rec->evlist);
 				break;
 			case EVLIST_CTL_CMD_ACK:
 			case EVLIST_CTL_CMD_UNSUPPORTED:
+			case EVLIST_CTL_CMD_ENABLE:
+			case EVLIST_CTL_CMD_DISABLE:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8cc24967bc27..3c6712ed5af7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -578,14 +578,12 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
-			pr_info(EVLIST_ENABLED_MSG);
 			if (interval)
 				process_interval();
 			break;
 		case EVLIST_CTL_CMD_DISABLE:
 			if (interval)
 				process_interval();
-			pr_info(EVLIST_DISABLED_MSG);
 			break;
 		case EVLIST_CTL_CMD_SNAPSHOT:
 		case EVLIST_CTL_CMD_ACK:
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05363a7247c4..c71c7e035641 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1957,6 +1957,64 @@ int evlist__ctlfd_ack(struct evlist *evlist)
 	return err;
 }
 
+static int get_cmd_arg(char *cmd_data, size_t cmd_size, char **arg)
+{
+	char *data = cmd_data + cmd_size;
+
+	/* no argument */
+	if (!*data)
+		return 0;
+
+	/* there's argument */
+	if (*data == ' ') {
+		*arg = data + 1;
+		return 1;
+	}
+
+	/* malformed */
+	return -1;
+}
+
+static int evlist__ctlfd_enable(struct evlist *evlist, char *cmd_data, bool enable)
+{
+	struct evsel *evsel;
+	char *name;
+	int err;
+
+	err = get_cmd_arg(cmd_data,
+			  enable ? sizeof(EVLIST_CTL_CMD_ENABLE_TAG) - 1 :
+				   sizeof(EVLIST_CTL_CMD_DISABLE_TAG) - 1,
+			  &name);
+	if (err < 0) {
+		pr_info("failed: wrong command\n");
+		return -1;
+	}
+
+	if (err) {
+		evsel = evlist__find_evsel_by_str(evlist, name);
+		if (evsel) {
+			if (enable)
+				evlist__enable_evsel(evlist, name);
+			else
+				evlist__disable_evsel(evlist, name);
+			pr_info("Event %s %s\n", evsel->name,
+				enable ? "enabled" : "disabled");
+		} else {
+			pr_info("failed: can't find '%s' event\n", name);
+		}
+	} else {
+		if (enable) {
+			evlist__enable(evlist);
+			pr_info(EVLIST_ENABLED_MSG);
+		} else {
+			evlist__disable(evlist);
+			pr_info(EVLIST_DISABLED_MSG);
+		}
+	}
+
+	return 0;
+}
+
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 {
 	int err = 0;
@@ -1973,10 +2031,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 		if (err > 0) {
 			switch (*cmd) {
 			case EVLIST_CTL_CMD_ENABLE:
-				evlist__enable(evlist);
-				break;
 			case EVLIST_CTL_CMD_DISABLE:
-				evlist__disable(evlist);
+				err = evlist__ctlfd_enable(evlist, cmd_data,
+							   *cmd == EVLIST_CTL_CMD_ENABLE);
 				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				break;
-- 
2.26.2

