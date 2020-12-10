Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761E2D6910
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393863AbgLJUpV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 15:45:21 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:52333 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730646AbgLJUos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:44:48 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-aXNS7N4AO7yYx4iIvxIv4Q-1; Thu, 10 Dec 2020 15:43:46 -0500
X-MC-Unique: aXNS7N4AO7yYx4iIvxIv4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07CCE1804969;
        Thu, 10 Dec 2020 20:43:44 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79D4E5D9CC;
        Thu, 10 Dec 2020 20:43:41 +0000 (UTC)
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
Subject: [PATCH 3/3] perf tools: Add evlist/evlist-verbose control commands
Date:   Thu, 10 Dec 2020 21:43:30 +0100
Message-Id: <20201210204330.233864-4-jolsa@kernel.org>
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

Adding new control events to display all evlist events.

The interface string for control file is 'evlist' and
'evlist-verbose'.

When evlist is received, perf will scan and print current
evlist into perf record terminal.

When evlist-verbose is received perf will scan and print
current evlist details (like perf evlist -v) into perf
record terminal.

Example session:

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -e 'sched:*'

  terminal 2:
    # echo evlist > control

  terminal 1:
    # perf record --control=fifo:control,ack -e 'sched:*'
    ...
    sched:sched_kthread_stop
    sched:sched_kthread_stop_ret
    sched:sched_waking
    sched:sched_wakeup
    sched:sched_wakeup_new
    sched:sched_switch
    sched:sched_migrate_task
    sched:sched_process_free
    sched:sched_process_exit
    ...

  terminal 2:
    # echo evlist-vebose > control

  terminal 1:
    ...
    sched:sched_kthread_stop: type: 2, size: 120, config: 0x145,      \
    { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU   \
    |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit:    \
    1, sample_id_all: 1, exclude_guest: 1
    sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x144   \
    , { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU \
    |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, \
    sample_id_all: 1, exclude_guest: 1
    ...

This new evlist command is handy to get real event names when
wildcards are used.

The evlist-verbose is handy to check on actually enabled perf_event_attr
values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/builtin-stat.c   |  2 ++
 tools/perf/util/evlist.c    | 15 +++++++++++++++
 tools/perf/util/evlist.h    |  4 ++++
 4 files changed, 23 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 582b8fba012c..d40406880722 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1951,6 +1951,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			case EVLIST_CTL_CMD_UNSUPPORTED:
 			case EVLIST_CTL_CMD_ENABLE_EVSEL:
 			case EVLIST_CTL_CMD_DISABLE_EVSEL:
+			case EVLIST_CTL_CMD_EVLIST:
+			case EVLIST_CTL_CMD_EVLIST_VERBOSE:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6a21fb665008..425e2a8ebde6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -592,6 +592,8 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_UNSUPPORTED:
 		case EVLIST_CTL_CMD_ENABLE_EVSEL:
 		case EVLIST_CTL_CMD_DISABLE_EVSEL:
+		case EVLIST_CTL_CMD_EVLIST:
+		case EVLIST_CTL_CMD_EVLIST_VERBOSE:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 729c98d10628..571d2ad61f4a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -24,6 +24,7 @@
 #include "bpf-event.h"
 #include "util/string2.h"
 #include "util/perf_api_probe.h"
+#include "util/evsel_fprintf.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -1931,6 +1932,12 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
 			pr_debug("is snapshot\n");
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG,
+				    (sizeof(EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_EVLIST_VERBOSE;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_TAG,
+				    (sizeof(EVLIST_CTL_CMD_EVLIST_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_EVLIST;
 		}
 	}
 
@@ -1954,6 +1961,7 @@ int evlist__ctlfd_ack(struct evlist *evlist)
 
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 {
+	struct perf_attr_details details = { .verbose = false, };
 	int err = 0;
 	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
 	int ctlfd_pos = evlist->ctl_fd.pos;
@@ -1995,6 +2003,13 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 					pr_info("failed: can't find '%s' event\n", evsel_name);
 				}
 				break;
+			case EVLIST_CTL_CMD_EVLIST_VERBOSE:
+				details.verbose = true;
+				__fallthrough;
+			case EVLIST_CTL_CMD_EVLIST:
+				evlist__for_each_entry(evlist, evsel)
+					evsel__fprintf(evsel, &details, stderr);
+				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				break;
 			case EVLIST_CTL_CMD_ACK:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e4e8ff8831a3..7892f084632d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -332,6 +332,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
 #define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
 #define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
+#define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
+#define EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG "evlist-verbose"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -343,6 +345,8 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_DISABLE_EVSEL,
 	EVLIST_CTL_CMD_ACK,
 	EVLIST_CTL_CMD_SNAPSHOT,
+	EVLIST_CTL_CMD_EVLIST,
+	EVLIST_CTL_CMD_EVLIST_VERBOSE,
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
-- 
2.26.2

