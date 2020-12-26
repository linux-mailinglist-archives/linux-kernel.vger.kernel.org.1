Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681742E2F5E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLZXVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Dec 2020 18:21:45 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:26473 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgLZXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:21:44 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-KLrpdgcxNgagS2YLj6Gi9A-1; Sat, 26 Dec 2020 18:20:50 -0500
X-MC-Unique: KLrpdgcxNgagS2YLj6Gi9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8DBC180A092;
        Sat, 26 Dec 2020 23:20:48 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43F7260C0F;
        Sat, 26 Dec 2020 23:20:45 +0000 (UTC)
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
Subject: [PATCH 2/4] perf tools: Add evlist control command
Date:   Sun, 27 Dec 2020 00:20:36 +0100
Message-Id: <20201226232038.390883-3-jolsa@kernel.org>
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

Adding new evlist control event to display all evlist events.
When it is received, perf will scan and print current evlist
into perf record terminal.

The interface string for control file is:
  evlist [-v|-g|-F]

The syntax follows perf evlist command:
  -F  Show just the sample frequency used for each event.
  -v  Show all fields.
  -g  Show event group information.

Example session:

  terminal 1:
    # mkfifo control ack
    # perf record --control=fifo:control,ack -e '{cycles,instructions}'

  terminal 2:
    # echo evlist > control

  terminal 1:
    cycles
    instructions
    dummy:HG

  terminal 2:
    # echo 'evlist -v' > control

  terminal 1:
    cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type:            \
    IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, freq: 1,    \
    sample_id_all: 1, exclude_guest: 1
    instructions: size: 120, config: 0x1, { sample_period, sample_freq }: 4000,      \
    sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, inherit: 1, freq: 1,    \
    sample_id_all: 1, exclude_guest: 1
    dummy:HG: type: 1, size: 120, config: 0x9, { sample_period, sample_freq }: 4000, \
    sample_type: IP|TID|TIME|ID|CPU|PERIOD, read_format: ID, inherit: 1, mmap: 1,    \
    comm: 1, freq: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, \
     bpf_event: 1

  terminal 2:
    # echo 'evlist -g' > control

  terminal 1:
    {cycles,instructions}
    dummy:HG

  terminal 2:
    # echo 'evlist -F' > control

  terminal 1:
    cycles: sample_freq=4000
    instructions: sample_freq=4000
    dummy:HG: sample_freq=4000

This new evlist command is handy to get real event names when
wildcards are used.

Adding evsel_fprintf.c object to python/perf.so build, because
it's now evlist.c dependency.

Adding PYTHON_PERF define for python/perf.so compilation, so we
can use it to compile in only evsel__fprintf from evsel_fprintf.c
object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 15 ++++++---
 tools/perf/builtin-record.c              |  1 +
 tools/perf/builtin-stat.c                |  1 +
 tools/perf/util/evlist.c                 | 41 ++++++++++++++++++++++++
 tools/perf/util/evlist.h                 |  2 ++
 tools/perf/util/evsel_fprintf.c          |  2 ++
 tools/perf/util/python-ext-sources       |  1 +
 tools/perf/util/setup.py                 |  2 +-
 8 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 05a85da0f7c5..5cf103f28eb0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -640,11 +640,16 @@ ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
 Listen on ctl-fd descriptor for command to control measurement.
 
 Available commands:
-  'enable'       : enable events
-  'disable'      : disable events
-  'enable name'  : enable event 'name'
-  'disable name' : disable event 'name'
-  'snapshot'     : AUX area tracing snapshot).
+  'enable'           : enable events
+  'disable'          : disable events
+  'enable name'      : enable event 'name'
+  'disable name'     : disable event 'name'
+  'snapshot'         : AUX area tracing snapshot).
+
+  'evlist [-v|-g|-F] : display all events
+                       -F  Show just the sample frequency used for each event.
+                       -v  Show all fields.
+                       -g  Show event group information.
 
 Measurements can be started with events disabled using --delay=-1 option. Optionally
 send control command completion ('ack\n') to ack-fd descriptor to synchronize with the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7302e7527d40..389be92c5a65 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1945,6 +1945,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			case EVLIST_CTL_CMD_UNSUPPORTED:
 			case EVLIST_CTL_CMD_ENABLE:
 			case EVLIST_CTL_CMD_DISABLE:
+			case EVLIST_CTL_CMD_EVLIST:
 			default:
 				break;
 			}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c6712ed5af7..02fbf0dc8119 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -588,6 +588,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
 		case EVLIST_CTL_CMD_SNAPSHOT:
 		case EVLIST_CTL_CMD_ACK:
 		case EVLIST_CTL_CMD_UNSUPPORTED:
+		case EVLIST_CTL_CMD_EVLIST:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c71c7e035641..9e890b482220 100644
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
@@ -1936,6 +1937,9 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
 				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
 			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
 			pr_debug("is snapshot\n");
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_TAG,
+				    (sizeof(EVLIST_CTL_CMD_EVLIST_TAG)-1))) {
+			*cmd = EVLIST_CTL_CMD_EVLIST;
 		}
 	}
 
@@ -2015,6 +2019,40 @@ static int evlist__ctlfd_enable(struct evlist *evlist, char *cmd_data, bool enab
 	return 0;
 }
 
+static int evlist__ctlfd_list(struct evlist *evlist, char *cmd_data)
+{
+	struct perf_attr_details details = { .verbose = false, };
+	struct evsel *evsel;
+	char *arg;
+	int err;
+
+	err = get_cmd_arg(cmd_data,
+			  sizeof(EVLIST_CTL_CMD_EVLIST_TAG) - 1,
+			  &arg);
+	if (err < 0) {
+		pr_info("failed: wrong command\n");
+		return -1;
+	}
+
+	if (err) {
+		if (!strcmp(arg, "-v")) {
+			details.verbose = true;
+		} else if (!strcmp(arg, "-g")) {
+			details.event_group = true;
+		} else if (!strcmp(arg, "-F")) {
+			details.freq = true;
+		} else {
+			pr_info("failed: wrong command\n");
+			return -1;
+		}
+	}
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__fprintf(evsel, &details, stderr);
+
+	return 0;
+}
+
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 {
 	int err = 0;
@@ -2035,6 +2073,9 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 				err = evlist__ctlfd_enable(evlist, cmd_data,
 							   *cmd == EVLIST_CTL_CMD_ENABLE);
 				break;
+			case EVLIST_CTL_CMD_EVLIST:
+				err = evlist__ctlfd_list(evlist, cmd_data);
+				break;
 			case EVLIST_CTL_CMD_SNAPSHOT:
 				break;
 			case EVLIST_CTL_CMD_ACK:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae75895dea..e79c64d81d21 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -330,6 +330,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
 #define EVLIST_CTL_CMD_DISABLE_TAG "disable"
 #define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
 #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
+#define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
 
 #define EVLIST_CTL_CMD_MAX_LEN 64
 
@@ -339,6 +340,7 @@ enum evlist_ctl_cmd {
 	EVLIST_CTL_CMD_DISABLE,
 	EVLIST_CTL_CMD_ACK,
 	EVLIST_CTL_CMD_SNAPSHOT,
+	EVLIST_CTL_CMD_EVLIST,
 };
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index fb498a723a00..bfedd7b23521 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -100,6 +100,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 	return ++printed;
 }
 
+#ifndef PYTHON_PERF
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      struct strlist *bt_stop_list, FILE *fp)
@@ -239,3 +240,4 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 
 	return printed;
 }
+#endif /* PYTHON_PERF */
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index a9d9c142eb7c..71b753523fac 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/python.c
 util/cap.c
 util/evlist.c
 util/evsel.c
+util/evsel_fprintf.c
 util/perf_event_attr_fprintf.c
 util/cpumap.c
 util/memswap.c
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index c5e3e9a68162..483f05004e68 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -43,7 +43,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
 if not cc_is_clang:
     cflags += ['-Wno-cast-function-type' ]
 
-- 
2.26.2

