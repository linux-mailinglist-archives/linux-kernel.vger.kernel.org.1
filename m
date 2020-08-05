Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FDC23C95A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgHEJi0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Aug 2020 05:38:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39501 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728423AbgHEJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:35:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-y0P2Dls-O0mTW2M-3s0o-g-1; Wed, 05 Aug 2020 05:35:23 -0400
X-MC-Unique: y0P2Dls-O0mTW2M-3s0o-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0326158;
        Wed,  5 Aug 2020 09:35:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11872726A5;
        Wed,  5 Aug 2020 09:35:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH v2 7/7] perf script: Add tod field to display time of day
Date:   Wed,  5 Aug 2020 11:34:44 +0200
Message-Id: <20200805093444.314999-8-jolsa@kernel.org>
In-Reply-To: <20200805093444.314999-1-jolsa@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding tod field to display time of day column with
time of date (wallclock) time.

  # perf record -k CLOCK_MONOTONIC kill
  kill: not enough arguments
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.033 MB perf.data (8 samples) ]

  # perf script
            perf 261340 152919.481538:          1 cycles:  ffffffff8106d104 ...
            perf 261340 152919.481543:          1 cycles:  ffffffff8106d104 ...
            perf 261340 152919.481545:          7 cycles:  ffffffff8106d104 ...
  ...

  # perf script --ns
            perf 261340 152919.481538922:          1 cycles:  ffffffff8106d ...
            perf 261340 152919.481543286:          1 cycles:  ffffffff8106d ...
            perf 261340 152919.481545397:          7 cycles:  ffffffff8106d ...
  ...

  # perf script -F+tod
            perf 261340 2020-07-13 18:26:55.620971 152919.481538:           ...
            perf 261340 2020-07-13 18:26:55.620975 152919.481543:           ...
            perf 261340 2020-07-13 18:26:55.620978 152919.481545:           ...
  ...

  # perf script -F+tod --ns
            perf 261340 2020-07-13 18:26:55.620971621 152919.481538922:     ...
            perf 261340 2020-07-13 18:26:55.620975985 152919.481543286:     ...
            perf 261340 2020-07-13 18:26:55.620978096 152919.481545397:     ...
  ...

It's available only for recording with clockid specified,
because it's the only case where we can get reference time
to wallclock time. It's can't do that with perf clock yet.

Error is display if you want to use --tod on data without
clockid specified:

  # perf script -F+tod
  Can't provide 'tod' time, missing clock data. Please record with -k/--clockid option.

Original-patch-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 131 +++++++++++++++++++++++++++---------
 1 file changed, 98 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index eb45f678dc2f..484ce6067d23 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -114,6 +114,32 @@ enum perf_output_field {
 	PERF_OUTPUT_MISC            = 1ULL << 29,
 	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
 	PERF_OUTPUT_IPC             = 1ULL << 31,
+	PERF_OUTPUT_TOD             = 1ULL << 32,
+};
+
+struct perf_script {
+	struct perf_tool	tool;
+	struct perf_session	*session;
+	bool			show_task_events;
+	bool			show_mmap_events;
+	bool			show_switch_events;
+	bool			show_namespace_events;
+	bool			show_lost_events;
+	bool			show_round_events;
+	bool			show_bpf_events;
+	bool			show_cgroup_events;
+	bool			show_text_poke_events;
+	bool			allocated;
+	bool			per_event_dump;
+	bool			stitch_lbr;
+	struct evswitch		evswitch;
+	struct perf_cpu_map	*cpus;
+	struct perf_thread_map *threads;
+	int			name_width;
+	const char              *time_str;
+	struct perf_time_interval *ptime_range;
+	int			range_size;
+	int			range_num;
 };
 
 struct output_option {
@@ -152,6 +178,7 @@ struct output_option {
 	{.str = "misc", .field = PERF_OUTPUT_MISC},
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
 	{.str = "ipc", .field = PERF_OUTPUT_IPC},
+	{.str = "tod", .field = PERF_OUTPUT_TOD},
 };
 
 enum {
@@ -502,6 +529,7 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
  */
 static int perf_session__check_output_opt(struct perf_session *session)
 {
+	bool tod = false;
 	unsigned int j;
 	struct evsel *evsel;
 
@@ -528,6 +556,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 			continue;
 
 		set_print_ip_opts(&evsel->core.attr);
+		tod |= output[j].fields & PERF_OUTPUT_TOD;
 	}
 
 	if (!no_callchain) {
@@ -568,13 +597,17 @@ static int perf_session__check_output_opt(struct perf_session *session)
 		}
 	}
 
+	if (tod && !session->header.env.clock.enabled) {
+		pr_err("Can't provide 'tod' time, missing clock data. "
+		       "Please record with -k/--clockid option.\n");
+		return -1;
+	}
 out:
 	return 0;
 }
 
 static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
-				     FILE *fp
-)
+				     FILE *fp)
 {
 	unsigned i = 0, r;
 	int printed = 0;
@@ -592,6 +625,56 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 	return printed;
 }
 
+#define DEFAULT_TOD_FMT "%F %H:%M:%S"
+
+static char*
+tod_scnprintf(struct perf_script *script, char *buf, int buflen,
+	     u64 timestamp)
+{
+	u64 tod_ns, clockid_ns;
+	struct perf_env *env;
+	unsigned long nsec;
+	struct tm ltime;
+	char date[64];
+	time_t sec;
+
+	buf[0] = '\0';
+	if (buflen < 64 || !script)
+		return buf;
+
+	env = &script->session->header.env;
+	if (!env->clock.enabled) {
+		scnprintf(buf, buflen, "disabled");
+		return buf;
+	}
+
+	clockid_ns = env->clock.clockid_ns;
+	tod_ns     = env->clock.tod_ns;
+
+	if (timestamp > clockid_ns)
+		tod_ns += timestamp - clockid_ns;
+	else
+		tod_ns -= clockid_ns - timestamp;
+
+	sec  = (time_t) (tod_ns / NSEC_PER_SEC);
+	nsec = tod_ns - sec * NSEC_PER_SEC;
+
+	if (localtime_r(&sec, &ltime) == NULL) {
+		scnprintf(buf, buflen, "failed");
+	} else {
+		strftime(date, sizeof(date), DEFAULT_TOD_FMT, &ltime);
+
+		if (symbol_conf.nanosecs) {
+			snprintf(buf, buflen, "%s.%09lu", date, nsec);
+		} else {
+			snprintf(buf, buflen, "%s.%06lu",
+				 date, nsec / NSEC_PER_USEC);
+		}
+	}
+
+	return buf;
+}
+
 static int perf_sample__fprintf_iregs(struct perf_sample *sample,
 				      struct perf_event_attr *attr, FILE *fp)
 {
@@ -606,7 +689,8 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 					 attr->sample_regs_user, fp);
 }
 
-static int perf_sample__fprintf_start(struct perf_sample *sample,
+static int perf_sample__fprintf_start(struct perf_script *script,
+				      struct perf_sample *sample,
 				      struct thread *thread,
 				      struct evsel *evsel,
 				      u32 type, FILE *fp)
@@ -615,6 +699,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	unsigned long secs;
 	unsigned long long nsecs;
 	int printed = 0;
+	char tstr[128];
 
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
@@ -683,6 +768,11 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 		printed += ret;
 	}
 
+	if (PRINT_FIELD(TOD)) {
+		tod_scnprintf(script, tstr, sizeof(tstr), sample->time);
+		printed += fprintf(fp, "%s ", tstr);
+	}
+
 	if (PRINT_FIELD(TIME)) {
 		u64 t = sample->time;
 		if (reltime) {
@@ -1667,31 +1757,6 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
-struct perf_script {
-	struct perf_tool	tool;
-	struct perf_session	*session;
-	bool			show_task_events;
-	bool			show_mmap_events;
-	bool			show_switch_events;
-	bool			show_namespace_events;
-	bool			show_lost_events;
-	bool			show_round_events;
-	bool			show_bpf_events;
-	bool			show_cgroup_events;
-	bool			show_text_poke_events;
-	bool			allocated;
-	bool			per_event_dump;
-	bool			stitch_lbr;
-	struct evswitch		evswitch;
-	struct perf_cpu_map	*cpus;
-	struct perf_thread_map *threads;
-	int			name_width;
-	const char              *time_str;
-	struct perf_time_interval *ptime_range;
-	int			range_size;
-	int			range_num;
-};
-
 static int evlist__max_name_len(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -1739,7 +1804,7 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
 
 	if (!fmt)
 		return;
-	perf_sample__fprintf_start(mctx->sample, mctx->thread, mctx->evsel,
+	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
 				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
 	if (color)
@@ -1754,7 +1819,7 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 {
 	struct metric_ctx *mctx = ctx;
 
-	perf_sample__fprintf_start(mctx->sample, mctx->thread, mctx->evsel,
+	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
 				   PERF_RECORD_SAMPLE, mctx->fp);
 	fputs("\tmetric: ", mctx->fp);
 }
@@ -1865,7 +1930,7 @@ static void process_event(struct perf_script *script,
 
 	++es->samples;
 
-	perf_sample__fprintf_start(sample, thread, evsel,
+	perf_sample__fprintf_start(script, sample, thread, evsel,
 				   PERF_RECORD_SAMPLE, fp);
 
 	if (PRINT_FIELD(PERIOD))
@@ -2174,7 +2239,7 @@ static int print_event_with_time(struct perf_tool *tool,
 		thread = machine__findnew_thread(machine, pid, tid);
 
 	if (thread && evsel) {
-		perf_sample__fprintf_start(sample, thread, evsel,
+		perf_sample__fprintf_start(script, sample, thread, evsel,
 					   event->header.type, stdout);
 	}
 
@@ -3439,7 +3504,7 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc",
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.25.4

