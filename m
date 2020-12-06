Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB62D062F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLFRGa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Dec 2020 12:06:30 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:23463 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgLFRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 12:06:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-M7Uruhx8NyKfQTlNjRUPXA-1; Sun, 06 Dec 2020 12:05:33 -0500
X-MC-Unique: M7Uruhx8NyKfQTlNjRUPXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14475180A086;
        Sun,  6 Dec 2020 17:05:32 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A41C060657;
        Sun,  6 Dec 2020 17:05:29 +0000 (UTC)
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
Subject: [PATCH 3/3] perf tools: Allow to list events via control file
Date:   Sun,  6 Dec 2020 18:05:19 +0100
Message-Id: <20201206170519.4010606-4-jolsa@kernel.org>
In-Reply-To: <20201206170519.4010606-1-jolsa@kernel.org>
References: <20201206170519.4010606-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new control event to display all evlist events.

The interface string for control file is 'list'. When
received, perf will scan and print current evlist into
perf record terminal.

Example session:

  terminal 1:
    # mkfifo control ack perf.pipe
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
    Events disabled

  terminal 2:
    # echo list > control

  terminal 1:
    # perf record --control=fifo:control,ack -D -1 --no-buffering -e 'sched:*' -o - > perf.pipe
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
    sched:sched_wait_task
    sched:sched_process_wait
    sched:sched_process_fork
    sched:sched_process_exec
    sched:sched_stat_wait
    sched:sched_stat_sleep
    sched:sched_stat_iowait
    sched:sched_stat_blocked
    sched:sched_stat_runtime
    sched:sched_pi_setprio
    sched:sched_move_numa
    sched:sched_stick_numa
    sched:sched_swap_numa
    sched:sched_wake_idle_without_ipi
    dummy:HG

This new command is handy to get real event names when
wildcards are used.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 1 +
 tools/perf/builtin-stat.c   | 1 +
 tools/perf/util/evlist.c    | 6 ++++++
 tools/perf/util/evlist.h    | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 582b8fba012c..f620ed056c89 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1951,6 +1951,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			case EVLIST_CTL_CMD_UNSUPPORTED:
 			case EVLIST_CTL_CMD_ENABLE_EVSEL:
 			case EVLIST_CTL_CMD_DISABLE_EVSEL:
+			case EVLIST_CTL_CMD_LIST:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6a21fb665008..56f2206b5991 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -592,6 +592,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_UNSUPPORTED:
 		case EVLIST_CTL_CMD_ENABLE_EVSEL:
 		case EVLIST_CTL_CMD_DISABLE_EVSEL:
+		case EVLIST_CTL_CMD_LIST:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05723227bebf..c05476ca2ff4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1931,6 +1931,9 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
 			pr_debug("is snapshot\n");
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_LIST_TAG,
+				    (sizeof(EVLIST_CTL_CMD_LIST_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_LIST;
 		}
 	}
 
@@ -1995,6 +1998,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 					pr_info("failed: can't find %s event\n", evsel_name);
 				}
 				break;
+			case EVLIST_CTL_CMD_LIST:
+				evlist__for_each_entry(evlist, evsel)
+					pr_info("%s\n", evsel__name(evsel));
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				break;
 			case EVLIST_CTL_CMD_ACK:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e4e8ff8831a3..6b8a9918fdb2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -332,6 +332,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
 #define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
 #define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
+#define EVLIST_CTL_CMD_LIST_TAG "list"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -343,6 +344,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_DISABLE_EVSEL,
 	EVLIST_CTL_CMD_ACK,
 	EVLIST_CTL_CMD_SNAPSHOT,
+	EVLIST_CTL_CMD_LIST,
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
-- 
2.26.2

