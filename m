Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3642DBCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgLPIk3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 03:40:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:48123 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgLPIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:40:28 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-G-Y3rPGJNCyurP0bdryu0Q-1; Wed, 16 Dec 2020 03:39:31 -0500
X-MC-Unique: G-Y3rPGJNCyurP0bdryu0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBD6E107ACE4;
        Wed, 16 Dec 2020 08:39:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5959E27C3D;
        Wed, 16 Dec 2020 08:39:26 +0000 (UTC)
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
Subject: [PATCH 3/4] perf tools: Allow to enable/disable events via control file
Date:   Wed, 16 Dec 2020 09:39:13 +0100
Message-Id: <20201216083914.47215-4-jolsa@kernel.org>
In-Reply-To: <20201216083914.47215-1-jolsa@kernel.org>
References: <20201216083914.47215-1-jolsa@kernel.org>
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
    Events disabled

  terminal 2:
    # cat perf.pipe | perf --no-pager script -i -

  terminal 3:
    # echo 'enable sched:sched_process_fork' > control

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    ...
    event sched:sched_process_fork enabled

  terminal 2:
    # cat perf.pipe | perf --no-pager script -i -
    bash 33349 [034] 149587.674295: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34056
    bash 33349 [034] 149588.239521: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34057

  terminal 3:
    # echo 'enable sched:sched_wakeup_new' > control

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    ...
    event sched:sched_wakeup_new enabled

  terminal 2:
    # cat perf.pipe | perf --no-pager script -i -
    ...
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
index f896c4b791e1..55d2d335b8a8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -637,9 +637,11 @@ ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
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
index d832c108a1ca..e9874832dc27 100644
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
index 89c32692f40c..4c43c5e14fd4 100644
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
index 70aff26612a9..7e0bcd1d1516 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1946,6 +1946,64 @@ int evlist__ctlfd_ack(struct evlist *evlist)
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
@@ -1962,10 +2020,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
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

