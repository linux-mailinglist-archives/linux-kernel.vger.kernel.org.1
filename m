Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E092E2F60
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLZXVx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Dec 2020 18:21:53 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:25046 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgLZXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:21:53 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-lO0wBGE9MTeCfUqAYJ2NQA-1; Sat, 26 Dec 2020 18:20:58 -0500
X-MC-Unique: lO0wBGE9MTeCfUqAYJ2NQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40A49800D53;
        Sat, 26 Dec 2020 23:20:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79A7D60C0F;
        Sat, 26 Dec 2020 23:20:53 +0000 (UTC)
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
Subject: [PATCH 4/4] perf tools: Add ping control command
Date:   Sun, 27 Dec 2020 00:20:38 +0100
Message-Id: <20201226232038.390883-5-jolsa@kernel.org>
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

Adding control 'ping' command to detect if perf is up and
control interface is operational.

It will be used in following daemon patches to synchronize
with record session - when control interface is up and
running, we know that perf record is monitoring and ready
to receive signals.

Example session:

  terminal 1:
    # mkfifo control ack
    # perf record --control=fifo:control,ack

  terminal 2:
    # echo ping > control
    # cat ack
    ack

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 1 +
 tools/perf/builtin-record.c              | 1 +
 tools/perf/builtin-stat.c                | 1 +
 tools/perf/util/evlist.c                 | 4 ++++
 tools/perf/util/evlist.h                 | 2 ++
 5 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 539230955dbc..aa2da60ff12b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -646,6 +646,7 @@ Available commands:
   'disable name'     : disable event 'name'
   'snapshot'         : AUX area tracing snapshot).
   'stop'             : stop perf record
+  'ping'             : ping
 
   'evlist [-v|-g|-F] : display all events
                        -F  Show just the sample frequency used for each event.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9aa051c3c722..3de81453ff8a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1949,6 +1949,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			case EVLIST_CTL_CMD_ENABLE:
 			case EVLIST_CTL_CMD_DISABLE:
 			case EVLIST_CTL_CMD_EVLIST:
+			case EVLIST_CTL_CMD_PING:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5681cbabbec5..d5d08ffae31b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -590,6 +590,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_UNSUPPORTED:
 		case EVLIST_CTL_CMD_EVLIST:
 		case EVLIST_CTL_CMD_STOP:
+		case EVLIST_CTL_CMD_PING:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c6de70cefbae..61b2408821e5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1943,6 +1943,9 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_STOP_TAG,
 				    (sizeof(EVLIST_CTL_CMD_STOP_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_STOP;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_PING_TAG,
+				    (sizeof(EVLIST_CTL_CMD_PING_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_PING;
 		}
 	}
 
@@ -2081,6 +2084,7 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 			case EVLIST_CTL_CMD_STOP:
+			case EVLIST_CTL_CMD_PING:
 				break;
 			case EVLIST_CTL_CMD_ACK:
 			case EVLIST_CTL_CMD_UNSUPPORTED:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6f45c3630355..7c2521cb6b09 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -332,6 +332,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
 #define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
 #define EVLIST_CTL_CMD_STOP_TAG "stop"
+#define EVLIST_CTL_CMD_PING_TAG "ping"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -343,6 +344,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_SNAPSHOT,
 	EVLIST_CTL_CMD_EVLIST,
 	EVLIST_CTL_CMD_STOP,
+	EVLIST_CTL_CMD_PING,
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
-- 
2.26.2

