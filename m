Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5698629506C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502842AbgJUQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:10:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:32739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387937AbgJUQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:10:46 -0400
IronPort-SDR: cF4IhorR6wBWX+Cto3bWM2g6gYuJ113+JKiq4Djw64Gl/zuljwKTc9l4+T2Rcbj0f4Mh2F8YVp
 FGdU2PUgowlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="229017993"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="229017993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 09:10:45 -0700
IronPort-SDR: KfR9d9dXIDT96ge6ObLKWI1NIsTd5rBu33FLKNLQvctuvu3WW9z57aWsJl8Z6Mu+W3L9wtD0ne
 /aDCiK80aiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="321059502"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2020 09:10:45 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 4BF22580720;
        Wed, 21 Oct 2020 09:10:43 -0700 (PDT)
Subject: [PATCH v2 15/15] perf record: introduce --threads command line option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <343e4186-dcf0-03fa-1797-ee776eea4483@linux.intel.com>
Date:   Wed, 21 Oct 2020 19:10:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Provide --threads option in perf record command line interface.
Threaded streaming mode mitigates profiling data losses and
resolves scalability issues of serial and asynchronous (--aio) trace
streaming modes on multicore server systems. The implementation is
based on the prototype [1], [2] and the most closely relates to mode 3)
"mode that creates thread for every monitored memory map".

Threaded streaming mode is available with Zstd compression/decompression
(--compression-level) and handling of external commands (--control).
AUX area tracing, related and derived modes like --snapshot or
--aux-sample are not enabled. --switch-output, --switch-output-event,
--switch-max-files and --timestamp-filename options are not enabled.
Threaded trace streaming is not enabled for pipe mode. Initial intent
to enable AUX area tracing faced the need to define some optimal way
to store index data at data directory thus left aside. --switch-output-*
and --timestamp-filename use cases are not yet clear for data directories.

Asynchronous (--aio) trace streaming and affinity (--affinity) modes
are mutually exclusive to the exposed threaded streaming mode.

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  7 ++++
 tools/perf/builtin-record.c              | 45 +++++++++++++++++++++---
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 768888b9326a..d8fa387da973 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -671,6 +671,13 @@ Example of bash shell script to enable and disable events during measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads::
+Write collected trace data into per-CPU trace files using parallel threads.
+List of monitored CPUs can be configured by a mask provided via --cpu option.
+Trace writing threads correspond one-to-one to mapped data buffers. Threads
+and buffers are affined to monitored CPUs and NUMA nodes according to system
+topology. Threaded trace streaming mode is mutually exclusive to asynchronous
+trace streaming (--aio) and affinity (--affinity) modes.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1d41e996a994..575b0b595081 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -780,6 +780,12 @@ static int record__auxtrace_init(struct record *rec)
 {
 	int err;
 
+	if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
+	    && record__threads_enabled(rec)) {
+		pr_err("AUX area tracing options are not available in threaded streaming mode.\n");
+		return -EINVAL;
+	}
+
 	if (!rec->itr) {
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
@@ -2008,6 +2014,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	if (record__threads_enabled(rec) && perf_data__is_pipe(&rec->data)) {
+		pr_err("Threaded trace streaming is not available in pipe mode.\n");
+		return -1;
+	}
+
 	fd = perf_data__fd(data);
 	rec->session = session;
 
@@ -2680,12 +2691,22 @@ static int switch_output_setup(struct record *rec)
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-	if (rec->switch_output_event_set)
+	if (rec->switch_output_event_set) {
+		if (record__threads_enabled(rec)) {
+			pr_warning("WARNING: --switch-output-event option is not available in threaded streaming mode.\n");
+			return 0;
+		}
 		goto do_signal;
+	}
 
 	if (!s->set)
 		return 0;
 
+	if (record__threads_enabled(rec)) {
+		pr_warning("WARNING: --switch-output option is not available in threaded streaming mode.\n");
+		return 0;
+	}
+
 	if (!strcmp(s->str, "signal")) {
 do_signal:
 		s->signal = true;
@@ -2964,8 +2985,8 @@ static struct option __record_options[] = {
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
 #ifdef HAVE_ZSTD_SUPPORT
-	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
-			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
+	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default, "n",
+			    "Compress records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
 			    record__parse_comp_level),
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
@@ -2984,6 +3005,8 @@ static struct option __record_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_BOOLEAN(0, "threads", &record.opts.threads,
+		    "write collected trace data into per-CPU trace files using parallel threads"),
 	OPT_END()
 };
 
@@ -3046,8 +3069,17 @@ int cmd_record(int argc, const char **argv)
 	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
-	if (record__threads_enabled(rec))
+	if (record__threads_enabled(rec)) {
+		if (rec->opts.affinity != PERF_AFFINITY_SYS) {
+			pr_err("--affinity option is mutually exclusive to threaded streaming mode.\n");
+			goto out_opts;
+		}
 		rec->opts.affinity = PERF_AFFINITY_CPU;
+		if (record__aio_enabled(rec)) {
+			pr_err("Asynchronous streaming mode (--aio) is mutually exclusive to threaded streaming mode.\n");
+			goto out_opts;
+		}
+	}
 
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
@@ -3082,6 +3114,11 @@ int cmd_record(int argc, const char **argv)
 		}
 	}
 
+	if (rec->timestamp_filename && record__threads_enabled(rec)) {
+		rec->timestamp_filename = false;
+		pr_warning("WARNING: --timestamp-filename option is not available in threaded streaming mode.\n");
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
-- 
2.24.1


