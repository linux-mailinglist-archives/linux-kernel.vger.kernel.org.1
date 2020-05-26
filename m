Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861E319EDE1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgDEUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 16:15:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgDEUPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:12 -0400
IronPort-SDR: Jw9i18m0ov1ieo5FQTrLUV2MiyqGc/H4QyRyClJC+bnkqxeANkxRNuccEf+TweWSJFtU9Z6Bfl
 ci4CvFNkj9vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:15:10 -0700
IronPort-SDR: 4hhu+z8/PgRLJj76LGLDhQiRtZ2x0gZI2auWvhD6Oj5ksHbuxmU75FY0itBjbKUeYEP5YESrCU
 J/+ylxFgsBUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688501"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:15:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 13/15] perf intel-pt: Add support for text poke events
Date:   Sun,  5 Apr 2020 23:13:25 +0300
Message-Id: <20200405201327.7332-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select text poke events when available and the kernel is being traced.
Process text poke events to invalidate entries in Intel PT's instruction
cache.

Example:

  The example requires kernel config:
    CONFIG_PROC_SYSCTL=y
    CONFIG_SCHED_DEBUG=y
    CONFIG_SCHEDSTATS=y

  Before:

    # perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
    # cat /proc/sys/kernel/sched_schedstats
    0
    # echo 1 > /proc/sys/kernel/sched_schedstats
    # cat /proc/sys/kernel/sched_schedstats
    1
    # echo 0 > /proc/sys/kernel/sched_schedstats
    # cat /proc/sys/kernel/sched_schedstats
    0
    # kill %1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 3.341 MB perf.data.before ]
    [1]+  Terminated                 perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M
    # perf script -i perf.data.before --itrace=e >/dev/null
    Warning:
    474 instruction trace errors

  After:

    # perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
    # cat /proc/sys/kernel/sched_schedstats
    0
    # echo 1 > /proc/sys/kernel/sched_schedstats
    # cat /proc/sys/kernel/sched_schedstats
    1
    # echo 0 > /proc/sys/kernel/sched_schedstats
    # cat /proc/sys/kernel/sched_schedstats
    0
    # kill %1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 2.646 MB perf.data.after ]
    [1]+  Terminated                 perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M
    # perf script -i perf.data.after --itrace=e >/dev/null

Example:

  The example requires kernel config:
    # CONFIG_FUNCTION_TRACER is not set

  Before:
    # perf record --kcore -m,64M -o t1 -a -e intel_pt//k &
    # perf probe __schedule
    Added new event:
      probe:__schedule     (on __schedule)

    You can now use it in all perf tools, such as:

            perf record -e probe:__schedule -aR sleep 1

    # perf record -e probe:__schedule -aR sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.026 MB perf.data (68 samples) ]
    # perf probe -d probe:__schedule
    Removed event: probe:__schedule
    # kill %1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 41.268 MB t1 ]
    [1]+  Terminated                 perf record --kcore -m,64M -o t1 -a -e intel_pt//k
    # perf script -i t1 --itrace=e >/dev/null
    Warning:
    207 instruction trace errors

  After:
    # perf record --kcore -m,64M -o t1 -a -e intel_pt//k &
    # perf probe __schedule
    Added new event:
      probe:__schedule     (on __schedule)

    You can now use it in all perf tools, such as:

        perf record -e probe:__schedule -aR sleep 1

    # perf record -e probe:__schedule -aR sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.028 MB perf.data (107 samples) ]
    # perf probe -d probe:__schedule
    Removed event: probe:__schedule
    # kill %1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 39.978 MB t1 ]
    [1]+  Terminated                 perf record --kcore -m,64M -o t1 -a -e intel_pt//k
    # perf script -i t1 --itrace=e >/dev/null
    # perf script -i t1 --no-itrace -D | grep 'POKE\|KSYMBOL'
    6 565303693547 0x291f18 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc027a000 len 4096 type 2 flags 0x0 name kprobe_insn_page
    6 565303697010 0x291f68 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffc027a000 old len 0 new len 6
    6 565303838278 0x291fa8 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc027c000 len 4096 type 2 flags 0x0 name kprobe_optinsn_page
    6 565303848286 0x291ff8 [0xa0]: PERF_RECORD_TEXT_POKE addr 0xffffffffc027c000 old len 0 new len 106
    6 565369336743 0x292af8 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffff88ab8890 old len 5 new len 5
    7 566434327704 0x217c208 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffff88ab8890 old len 5 new len 5
    6 566456313475 0x293198 [0xa0]: PERF_RECORD_TEXT_POKE addr 0xffffffffc027c000 old len 106 new len 0
    6 566456314935 0x293238 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffc027a000 old len 6 new len 0

Example:

  The example requires kernel config:
    CONFIG_FUNCTION_TRACER=y

  Before:
    # perf record --kcore -m,64M -o t1 -a -e intel_pt//k &
    # perf probe __kmalloc
    Added new event:
      probe:__kmalloc      (on __kmalloc)

    You can now use it in all perf tools, such as:

        perf record -e probe:__kmalloc -aR sleep 1

    # perf record -e probe:__kmalloc -aR sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.022 MB perf.data (6 samples) ]
    # perf probe -d probe:__kmalloc
    Removed event: probe:__kmalloc
    # kill %1
    [ perf record: Woken up 2 times to write data ]
    [ perf record: Captured and wrote 43.850 MB t1 ]
    [1]+  Terminated                 perf record --kcore -m,64M -o t1 -a -e intel_pt//k
    # perf script -i t1 --itrace=e >/dev/null
    Warning:
    8 instruction trace errors

  After:
    # perf record --kcore -m,64M -o t1 -a -e intel_pt//k &
    # perf probe __kmalloc
    Added new event:
      probe:__kmalloc      (on __kmalloc)

    You can now use it in all perf tools, such as:

            perf record -e probe:__kmalloc -aR sleep 1

    # perf record -e probe:__kmalloc -aR sleep 1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.037 MB perf.data (206 samples) ]
    # perf probe -d probe:__kmalloc
    Removed event: probe:__kmalloc
    # kill %1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 41.442 MB t1 ]
    [1]+  Terminated                 perf record --kcore -m,64M -o t1 -a -e intel_pt//k
    # perf script -i t1 --itrace=e >/dev/null
    # perf script -i t1 --no-itrace -D | grep 'POKE\|KSYMBOL'
    5 312216133258 0x8bafe0 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0360000 len 415 type 2 flags 0x0 name ftrace_trampoline
    5 312216133494 0x8bb030 [0x1d8]: PERF_RECORD_TEXT_POKE addr 0xffffffffc0360000 old len 0 new len 415
    5 312216229563 0x8bb208 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac6016f5 old len 5 new len 5
    5 312216239063 0x8bb248 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac601803 old len 5 new len 5
    5 312216727230 0x8bb288 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffabbea190 old len 5 new len 5
    5 312216739322 0x8bb2c8 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac6016f5 old len 5 new len 5
    5 312216748321 0x8bb308 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac601803 old len 5 new len 5
    7 313287163462 0x2817430 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac6016f5 old len 5 new len 5
    7 313287174890 0x2817470 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac601803 old len 5 new len 5
    7 313287818979 0x28174b0 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffabbea190 old len 5 new len 5
    7 313287829357 0x28174f0 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac6016f5 old len 5 new len 5
    7 313287841246 0x2817530 [0x40]: PERF_RECORD_TEXT_POKE addr 0xffffffffac601803 old len 5 new len 5

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  4 ++
 tools/perf/util/intel-pt.c          | 75 +++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1643aed8c4c8..0140b4466209 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -827,6 +827,10 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (have_timing_info && !intel_pt_evsel->core.attr.exclude_kernel &&
+	    perf_can_record_text_poke_events() && perf_can_record_cpu_wide())
+		opts->text_poke = true;
+
 	if (intel_pt_evsel) {
 		/*
 		 * To obtain the auxtrace buffer file descriptor, the auxtrace
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23c8289c2472..470a3b413869 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -514,6 +514,17 @@ intel_pt_cache_lookup(struct dso *dso, struct machine *machine, u64 offset)
 	return auxtrace_cache__lookup(dso->auxtrace_cache, offset);
 }
 
+static void intel_pt_cache_invalidate(struct dso *dso, struct machine *machine,
+				      u64 offset)
+{
+	struct auxtrace_cache *c = intel_pt_cache(dso, machine);
+
+	if (!c)
+		return;
+
+	auxtrace_cache__remove(dso->auxtrace_cache, offset);
+}
+
 static inline u8 intel_pt_cpumode(struct intel_pt *pt, uint64_t ip)
 {
 	return ip >= pt->kernel_start ?
@@ -2594,6 +2605,67 @@ static int intel_pt_process_itrace_start(struct intel_pt *pt,
 					event->itrace_start.tid);
 }
 
+static int intel_pt_find_map(struct thread *thread, u8 cpumode, u64 addr,
+			     struct addr_location *al)
+{
+	if (!al->map || addr < al->map->start || addr >= al->map->end) {
+		if (!thread__find_map(thread, cpumode, addr, al))
+			return -1;
+	}
+
+	return 0;
+}
+
+/* Invalidate all instruction cache entries that overlap the text poke */
+static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
+{
+	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	u64 addr = event->text_poke.addr + event->text_poke.new_len - 1;
+	/* Assume text poke begins in a basic block no more than 4096 bytes */
+	int cnt = 4096 + event->text_poke.new_len;
+	struct thread *thread = pt->unknown_thread;
+	struct addr_location al = { .map = NULL };
+	struct machine *machine = pt->machine;
+	struct intel_pt_cache_entry *e;
+	u64 offset;
+
+	if (!event->text_poke.new_len)
+		return 0;
+
+	for (; cnt; cnt--, addr--) {
+		if (intel_pt_find_map(thread, cpumode, addr, &al)) {
+			if (addr < event->text_poke.addr)
+				return 0;
+			continue;
+		}
+
+		if (!al.map->dso || !al.map->dso->auxtrace_cache)
+			continue;
+
+		offset = al.map->map_ip(al.map, addr);
+
+		e = intel_pt_cache_lookup(al.map->dso, machine, offset);
+		if (!e)
+			continue;
+
+		if (addr + e->byte_cnt + e->length <= event->text_poke.addr) {
+			/*
+			 * No overlap. Working backwards there cannot be another
+			 * basic block that overlaps the text poke if there is a
+			 * branch instruction before the text poke address.
+			 */
+			if (e->branch != INTEL_PT_BR_NO_BRANCH)
+				return 0;
+		} else {
+			intel_pt_cache_invalidate(al.map->dso, machine, offset);
+			intel_pt_log("Invalidated instruction cache for %s at %#"PRIx64"\n",
+				     al.map->dso->long_name, addr);
+		}
+	}
+
+	return 0;
+}
+
 static int intel_pt_process_event(struct perf_session *session,
 				  union perf_event *event,
 				  struct perf_sample *sample,
@@ -2655,6 +2727,9 @@ static int intel_pt_process_event(struct perf_session *session,
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
 
+	if (!err && event->header.type == PERF_RECORD_TEXT_POKE)
+		err = intel_pt_text_poke(pt, event);
+
 	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
 		     event->header.type, sample->cpu, sample->time, timestamp);
 	intel_pt_log_event(event);
-- 
2.17.1

