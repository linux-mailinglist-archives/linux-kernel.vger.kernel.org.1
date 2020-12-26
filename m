Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53DF2E2F5F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLZXVu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Dec 2020 18:21:50 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:25783 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgLZXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:21:50 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-RH_Cy_c6M82ZutXGoCCJsA-1; Sat, 26 Dec 2020 18:20:54 -0500
X-MC-Unique: RH_Cy_c6M82ZutXGoCCJsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19A3A1005504;
        Sat, 26 Dec 2020 23:20:53 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7297E60C0F;
        Sat, 26 Dec 2020 23:20:49 +0000 (UTC)
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
Subject: [PATCH 3/4] perf tools: Add stop control command
Date:   Sun, 27 Dec 2020 00:20:37 +0100
Message-Id: <20201226232038.390883-4-jolsa@kernel.org>
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

Adding control 'stop' command to stop perf record.
When it is received, perf will set done = 1.

Example session:

  terminal 1:
    # mkfifo control ack
    # perf record --control=fifo:control,ack

  terminal 2:
    # echo stop > control

  terminal 1:
    [ perf record: Woken up 7 times to write data ]
    [ perf record: Captured and wrote 3.214 MB perf.data (38280 samples) ]
    #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/builtin-record.c              | 3 +++
 tools/perf/builtin-stat.c                | 1 +
 tools/perf/util/evlist.c                 | 4 ++++
 tools/perf/util/evlist.h                 | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 5cf103f28eb0..539230955dbc 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -645,6 +645,7 @@ Available commands:
   'enable name'      : enable event 'name'
   'disable name'     : disable event 'name'
   'snapshot'         : AUX area tracing snapshot).
+  'stop'             : stop perf record
 
   'evlist [-v|-g|-F] : display all events
                        -F  Show just the sample frequency used for each event.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 389be92c5a65..9aa051c3c722 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1941,6 +1941,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				hit_auxtrace_snapshot_trigger(rec);
 				evlist__ctlfd_ack(rec->evlist);
 				break;
+			case EVLIST_CTL_CMD_STOP:
+				done = 1;
+				break;
 			case EVLIST_CTL_CMD_ACK:
 			case EVLIST_CTL_CMD_UNSUPPORTED:
 			case EVLIST_CTL_CMD_ENABLE:
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 02fbf0dc8119..5681cbabbec5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -589,6 +589,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_ACK:
 		case EVLIST_CTL_CMD_UNSUPPORTED:
 		case EVLIST_CTL_CMD_EVLIST:
+		case EVLIST_CTL_CMD_STOP:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9e890b482220..c6de70cefbae 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1940,6 +1940,9 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_TAG,
 				    (sizeof(EVLIST_CTL_CMD_EVLIST_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_EVLIST;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_STOP_TAG,
+				    (sizeof(EVLIST_CTL_CMD_STOP_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_STOP;
 		}
 	}
 
@@ -2077,6 +2080,7 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 				err = evlist__ctlfd_list(evlist, cmd_data);
 				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
+			case EVLIST_CTL_CMD_STOP:
 				break;
 			case EVLIST_CTL_CMD_ACK:
 			case EVLIST_CTL_CMD_UNSUPPORTED:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e79c64d81d21..6f45c3630355 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -331,6 +331,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
 #define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
+#define EVLIST_CTL_CMD_STOP_TAG "stop"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -341,6 +342,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_ACK,
 	EVLIST_CTL_CMD_SNAPSHOT,
 	EVLIST_CTL_CMD_EVLIST,
+	EVLIST_CTL_CMD_STOP,
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
-- 
2.26.2

