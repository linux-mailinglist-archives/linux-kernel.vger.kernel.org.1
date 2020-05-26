Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95101C7475
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbgEFPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbgEFPYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F4D21835;
        Wed,  6 May 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778676;
        bh=bNKM//IyHVYfGrgXXqIMLLJ/0wxvYDLHdX9C7yilYX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAJcOAXJ/RNjDEYEKCN/jww4/tKYz/r/JWfRTBXqugOh5iRy1FSbmt03K25qKgsmh
         V+YiSfEVpnwSj1I597qoFO7a2GUHcrVTtZBUr0qhJw5N43NcXD9zJQv8vk4CjyQo0X
         8NQ6Nahf7qgJiLH/nT3I42tM+vbqhzXJmYrXrQ80=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 30/91] perf record: Introduce --switch-output-event
Date:   Wed,  6 May 2020 12:21:33 -0300
Message-Id: <20200506152234.21977-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now we can use it with --overwrite to have a flight recorder mode that
gets snapshot requests from arbitrary events that are processed in the
side band thread together with the PERF_RECORD_BPF_EVENT processing.

Example:

To collect scheduler events until a recvmmsg syscall happens, system
wide:

  [root@five a]# rm -f perf.data.2020042717*
  [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717585458 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717590235 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717590398 ]
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Dump perf.data.2020042717590511 ]
  [ perf record: Captured and wrote 7.244 MB perf.data.<timestamp> ]

So in the above case we had 3 snapshots, the fourth was forced by
control+C:

  [root@five a]# ls -la
  total 20440
  drwxr-xr-x.  2 root root    4096 Apr 27 17:59 .
  dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
  -rw-------.  1 root root 3936125 Apr 27 17:58 perf.data.2020042717585458
  -rw-------.  1 root root 5074869 Apr 27 17:59 perf.data.2020042717590235
  -rw-------.  1 root root 4291037 Apr 27 17:59 perf.data.2020042717590398
  -rw-------.  1 root root 7617037 Apr 27 17:59 perf.data.2020042717590511
  [root@five a]#

One can make this more precise by adding the switch output event to the
main -e events list, as since this is done asynchronously, a few events
after the signal event will appear in the snapshots, as can be seen
with:

  [root@five a]# rm -f perf.data.20200427175*
  [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024203 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024301 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024484 ]
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Dump perf.data.2020042718024562 ]
  [ perf record: Captured and wrote 7.337 MB perf.data.<timestamp> ]
  [root@five a]# perf script -i perf.data.2020042718024203 | tail -15
       PacerThread 148586 [005] 122.830729: sched:sched_switch: prev_comm=PacerThread prev_pid=148586...
           swapper      0 [000] 122.833588: sched:sched_switch: prev_comm=swapper/0 prev_pid=...
    NetworkManager   1251 [000] 122.833619: syscalls:sys_enter_recvmmsg: fd: 0x0000001c, mmsg: 0x7ffe83054a1...
           swapper      0 [002] 122.833624: sched:sched_switch: prev_comm=swapper/2 prev_pid=...
           swapper      0 [003] 122.833624: sched:sched_switch: prev_comm=swapper/3 prev_pid=...
    NetworkManager   1251 [000] 122.833626: syscalls:sys_exit_recvmmsg: 0x1
   kworker/3:3-eve 158946 [003] 122.833628: sched:sched_switch: prev_comm=kworker/3:3 prev_pid=15894...
           swapper      0 [004] 122.833641: sched:sched_switch: prev_comm=swapper/4 prev_pid=...
    NetworkManager   1251 [000] 122.833642: sched:sched_switch: prev_comm=NetworkManage...
              perf 228273 [002] 122.833645: sched:sched_switch: prev_comm=perf prev_pid=22827...
           swapper      0 [011] 122.833646: sched:sched_switch: prev_comm=swapper/1...
           swapper      0 [002] 122.833648: sched:sched_switch: prev_comm=swapper/...
   kworker/0:2-eve 207387 [000] 122.833648: sched:sched_switch: prev_comm=kworker/0:2 prev_pid=20738...
   kworker/2:3-eve 232038 [002] 122.833652: sched:sched_switch: prev_comm=kworker/2:3 prev_pid=23203...
              perf 235825 [003] 122.833653: sched:sched_switch: prev_comm=perf prev_pid=23582...
  [root@five a]#

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-8-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 13 ++++++++
 tools/perf/builtin-record.c              | 41 +++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6e8b4649307c..561ef55743e2 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -556,6 +556,19 @@ overhead. You can still switch them on with:
 
   --switch-output --no-no-buildid  --no-no-buildid-cache
 
+--switch-output-event::
+Events that will cause the switch of the perf.data file, auto-selecting
+--switch-output=signal, the results are similar as internally the side band
+thread will also send a SIGUSR2 to the main one.
+
+Uses the same syntax as --event, it will just not be recorded, serving only to
+switch the perf.data file as soon as the --switch-output event is processed by
+a separate sideband thread.
+
+This sideband thread is also used to other purposes, like processing the
+PERF_RECORD_BPF_EVENT records as they happen, asking the kernel for extra BPF
+information, etc.
+
 --switch-max-files=N::
 
 When rotating perf.data with --switch-output, only keep N files.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5b6a1d23efe5..bb5b4d2fc32b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -88,7 +88,9 @@ struct record {
 	struct evlist	*evlist;
 	struct perf_session	*session;
 	struct evlist		*sb_evlist;
+	pthread_t		thread_id;
 	int			realtime_prio;
+	bool			switch_output_event_set;
 	bool			no_buildid;
 	bool			no_buildid_set;
 	bool			no_buildid_cache;
@@ -1437,6 +1439,13 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
+{
+	struct record *rec = data;
+	pthread_kill(rec->thread_id, SIGUSR2);
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1581,12 +1590,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (!opts->no_bpf_event) {
-		rec->sb_evlist = evlist__new();
+	if (rec->sb_evlist != NULL) {
+		/*
+		 * We get here if --switch-output-event populated the
+		 * sb_evlist, so associate a callback that will send a SIGUSR2
+		 * to the main thread.
+		 */
+		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
+		rec->thread_id = pthread_self();
+	}
 
+	if (!opts->no_bpf_event) {
 		if (rec->sb_evlist == NULL) {
-			pr_err("Couldn't create side band evlist.\n.");
-			goto out_child;
+			rec->sb_evlist = evlist__new();
+
+			if (rec->sb_evlist == NULL) {
+				pr_err("Couldn't create side band evlist.\n.");
+				goto out_child;
+			}
 		}
 
 		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
@@ -2180,10 +2201,19 @@ static int switch_output_setup(struct record *rec)
 	};
 	unsigned long val;
 
+	/*
+	 * If we're using --switch-output-events, then we imply its 
+	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
+	 *  thread to its parent.
+	 */
+	if (rec->switch_output_event_set)
+		goto do_signal;
+
 	if (!s->set)
 		return 0;
 
 	if (!strcmp(s->str, "signal")) {
+do_signal:
 		s->signal = true;
 		pr_debug("switch-output with SIGUSR2 signal\n");
 		goto enabled;
@@ -2441,6 +2471,9 @@ static struct option __record_options[] = {
 			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
 			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
+	OPT_CALLBACK_SET(0, "switch-output-event", &record.sb_evlist, &record.switch_output_event_set, "switch output event",
+			 "switch output event selector. use 'perf list' to list available events",
+			 parse_events_option_new_evlist),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
-- 
2.21.1

