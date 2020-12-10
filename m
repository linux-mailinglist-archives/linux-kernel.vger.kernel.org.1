Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F62D690B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbgLJUpH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 15:45:07 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:22914 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393845AbgLJUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:44:43 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-UY9vahwlOKKagrR96vKH1Q-1; Thu, 10 Dec 2020 15:43:43 -0500
X-MC-Unique: UY9vahwlOKKagrR96vKH1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20ACC801817;
        Thu, 10 Dec 2020 20:43:41 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918775D9CC;
        Thu, 10 Dec 2020 20:43:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 2/3] perf tools: Allow to enable/disable events via control file
Date:   Thu, 10 Dec 2020 21:43:29 +0100
Message-Id: <20201210204330.233864-3-jolsa@kernel.org>
In-Reply-To: <20201210204330.233864-1-jolsa@kernel.org>
References: <20201210204330.233864-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

  'enable-<EVENT NAME>'
  'disable-<EVENT NAME>'

when received the command, perf will scan the current evlist
for <EVENT NAME> and if found it's enabled/disabled.

Example session:

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    Events disabled

  terminal 2:
    # cat perf.pipe | ./perf --no-pager script -i -

  terminal 3:
    # echo enable-sched:sched_process_fork > control

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    ...
    event sched:sched_process_fork enabled

  terminal 2:
    # cat perf.pipe | ./perf --no-pager script -i -
    bash 33349 [034] 149587.674295: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34056
    bash 33349 [034] 149588.239521: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34057

  terminal 3:
    # echo enable-sched:sched_wakeup_new > control

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    ...
    event sched:sched_wakeup_new enabled

  terminal 2:
    # cat perf.pipe | ./perf --no-pager script -i -
    ...
    bash 33349 [034] 149632.228023: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34059
    bash 33349 [034] 149632.228050:   sched:sched_wakeup_new: bash:34059 [120] success=1 CPU:036
    bash 33349 [034] 149633.950005: sched:sched_process_fork: comm=bash pid=33349 child_comm=bash child_pid=34060
    bash 33349 [034] 149633.950030:   sched:sched_wakeup_new: bash:34060 [120] success=1 CPU:036

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/builtin-stat.c   |  2 ++
 tools/perf/util/evlist.c    | 30 +++++++++++++++++++++++++++++-
 tools/perf/util/evlist.h    |  4 ++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d832c108a1ca..582b8fba012c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1949,6 +1949,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				break;
 			case EVLIST_CTL_CMD_ACK:
 			case EVLIST_CTL_CMD_UNSUPPORTED:
+			case EVLIST_CTL_CMD_ENABLE_EVSEL:
+			case EVLIST_CTL_CMD_DISABLE_EVSEL:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 89c32692f40c..6a21fb665008 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -590,6 +590,8 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_SNAPSHOT:
 		case EVLIST_CTL_CMD_ACK:
 		case EVLIST_CTL_CMD_UNSUPPORTED:
+		case EVLIST_CTL_CMD_ENABLE_EVSEL:
+		case EVLIST_CTL_CMD_DISABLE_EVSEL:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 70aff26612a9..729c98d10628 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1915,7 +1915,13 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
 
 	if (bytes_read > 0) {
-		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
+		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_EVSEL_TAG,
+			     (sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_ENABLE_EVSEL;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_EVSEL_TAG,
+				    (sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_DISABLE_EVSEL;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
 			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_ENABLE;
 		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
@@ -1952,6 +1958,8 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
 	int ctlfd_pos = evlist->ctl_fd.pos;
 	struct pollfd *entries = evlist->core.pollfd.entries;
+	struct evsel *evsel;
+	char *evsel_name;
 
 	if (!evlist__ctlfd_initialized(evlist) || !entries[ctlfd_pos].revents)
 		return 0;
@@ -1967,6 +1975,26 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 			case EVLIST_CTL_CMD_DISABLE:
 				evlist__disable(evlist);
 				break;
+			case EVLIST_CTL_CMD_ENABLE_EVSEL:
+				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_ENABLE_EVSEL_TAG) - 1;
+				evsel = evlist__find_evsel_by_str(evlist, evsel_name);
+				if (evsel) {
+					evlist__enable_evsel(evlist, evsel_name);
+					pr_info("event %s enabled\n", evsel->name);
+				} else {
+					pr_info("failed: can't find '%s' event\n", evsel_name);
+				}
+				break;
+			case EVLIST_CTL_CMD_DISABLE_EVSEL:
+				evsel_name = cmd_data + sizeof(EVLIST_CTL_CMD_DISABLE_EVSEL_TAG) - 1;
+				evsel = evlist__find_evsel_by_str(evlist, evsel_name);
+				if (evsel) {
+					evlist__disable_evsel(evlist, evsel_name);
+					pr_info("event %s disabled\n", evsel->name);
+				} else {
+					pr_info("failed: can't find '%s' event\n", evsel_name);
+				}
+				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				break;
 			case EVLIST_CTL_CMD_ACK:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae75895dea..e4e8ff8831a3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -330,6 +330,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_DISABLE_TAG "disable"
 #define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
+#define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
+#define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -337,6 +339,8 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_UNSUPPORTED = 0,
 	EVLIST_CTL_CMD_ENABLE,
 	EVLIST_CTL_CMD_DISABLE,
+	EVLIST_CTL_CMD_ENABLE_EVSEL,
+	EVLIST_CTL_CMD_DISABLE_EVSEL,
 	EVLIST_CTL_CMD_ACK,
 	EVLIST_CTL_CMD_SNAPSHOT,
 };
-- 
2.26.2

