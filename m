Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43B19EDDF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgDEUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 16:15:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgDEUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:03 -0400
IronPort-SDR: feJC8ZFRXT+cDEZuRiBWRV4Y4NwieeYEh5i8uVxFj4RWK6YxDatffty7u30ZLzUa8y/UgGXkzR
 GAwJnQOmjRPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:15:01 -0700
IronPort-SDR: vPmnBPRbNsGkqKS3wUOR3/EnO091GVCWLO+867zVWasYZ9GQ/d/rO1PA3EkcDwkuvi3E6kDXoB
 a3N6UdnUfVPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688471"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:14:59 -0700
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
Subject: [PATCH V6 11/15] perf tools: Add support for PERF_RECORD_TEXT_POKE
Date:   Sun,  5 Apr 2020 23:13:23 +0300
Message-Id: <20200405201327.7332-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add processing for PERF_RECORD_TEXT_POKE events. When a text poke event is
processed, then the kernel dso data cache is updated with the poked bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 21 +++++++++-
 tools/lib/perf/include/perf/event.h       |  9 +++++
 tools/perf/builtin-record.c               | 45 ++++++++++++++++++++++
 tools/perf/util/event.c                   | 47 +++++++++++++++++++++++
 tools/perf/util/event.h                   |  5 +++
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/evsel.c                   |  7 +++-
 tools/perf/util/machine.c                 | 43 +++++++++++++++++++++
 tools/perf/util/machine.h                 |  3 ++
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/record.c                  | 10 +++++
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/session.c                 | 23 +++++++++++
 tools/perf/util/tool.h                    |  3 +-
 14 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..e5bee6c17b86 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -383,7 +383,8 @@ struct perf_event_attr {
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
-				__reserved_1   : 31;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 30;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1024,6 +1025,24 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_CGROUP			= 19,
 
+	/*
+	 * Records changes to kernel text i.e. self-modified code. 'old_len' is
+	 * the number of old bytes, 'new_len' is the number of new bytes. Either
+	 * 'old_len' or 'new_len' may be zero to indicate, for example, the
+	 * addition or removal of a trampoline. 'bytes' contains the old bytes
+	 * followed immediately by the new bytes.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u16				old_len;
+	 *	u16				new_len;
+	 *	u8				bytes[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_TEXT_POKE			= 20,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 69b44d2cc0f5..842028858d66 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -111,6 +111,14 @@ struct perf_record_cgroup {
 	char			 path[PATH_MAX];
 };
 
+struct perf_record_text_poke_event {
+	struct perf_event_header header;
+	__u64			addr;
+	__u16			old_len;
+	__u16			new_len;
+	__u8			bytes[];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -367,6 +375,7 @@ union perf_event {
 	struct perf_record_sample		sample;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
+	struct perf_record_text_poke_event	text_poke;
 	struct perf_record_header_attr		attr;
 	struct perf_record_event_update		event_update;
 	struct perf_record_header_event_type	event_type;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7d7912e121d6..839edc23242c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -723,6 +723,43 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 
 #endif
 
+static int record__config_text_poke(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int err;
+
+	/* Nothing to do if text poke is already configured */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.text_poke)
+			return 0;
+	}
+
+	err = parse_events(evlist, "dummy:u", NULL);
+	if (err)
+		return err;
+
+	evsel = evlist__last(evlist);
+
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = 1;
+	evsel->core.attr.text_poke = 1;
+	evsel->core.attr.ksymbol = 1;
+
+	evsel->core.system_wide = true;
+	evsel->no_aux_samples = true;
+	evsel->immediate = true;
+
+	/* Text poke must be collected on all CPUs */
+	perf_cpu_map__put(evsel->core.own_cpus);
+	evsel->core.own_cpus = perf_cpu_map__new(NULL);
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
+
+	perf_evsel__set_sample_bit(evsel, TIME);
+
+	return 0;
+}
+
 static bool record__kcore_readable(struct machine *machine)
 {
 	char kcore[PATH_MAX];
@@ -2620,6 +2657,14 @@ int cmd_record(int argc, const char **argv)
 	if (rec->opts.full_auxtrace)
 		rec->buildid_all = true;
 
+	if (rec->opts.text_poke) {
+		err = record__config_text_poke(rec->evlist);
+		if (err) {
+			pr_err("record__config_text_poke failed, error %d\n", err);
+			goto out;
+		}
+	}
+
 	if (record_opts__config(&rec->opts)) {
 		err = -EINVAL;
 		goto out;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index dc0e11214ae1..cdaf58734254 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -31,6 +31,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "print_binary.h"
 #include "tool.h"
 #include "../perf.h"
 
@@ -55,6 +56,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_CGROUP]			= "CGROUP",
+	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -267,6 +269,14 @@ int perf_event__process_bpf(struct perf_tool *tool __maybe_unused,
 	return machine__process_bpf(machine, event, sample);
 }
 
+int perf_event__process_text_poke(struct perf_tool *tool __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine)
+{
+	return machine__process_text_poke(machine, event, sample);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64 "]: %c %s\n",
@@ -413,6 +423,40 @@ size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
+static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
+			     void *extra, FILE *fp)
+{
+	bool old = *(bool *)extra;
+
+	switch ((int)op) {
+	case BINARY_PRINT_LINE_BEGIN:
+		return fprintf(fp, "            %s bytes:", old ? "Old" : "New");
+	case BINARY_PRINT_NUM_DATA:
+		return fprintf(fp, " %02x", val);
+	case BINARY_PRINT_LINE_END:
+		return fprintf(fp, "\n");
+	default:
+		return 0;
+	}
+}
+
+size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
+{
+	struct perf_record_text_poke_event *tp = &event->text_poke;
+	size_t ret;
+	bool old;
+
+	ret = fprintf(fp, " %" PRI_lx64 " old len %u new len %u\n",
+		      tp->addr, tp->old_len, tp->new_len);
+	old = true;
+	ret += binary__fprintf(tp->bytes, tp->old_len, 16, text_poke_printer,
+			       &old, fp);
+	old = false;
+	ret += binary__fprintf(tp->bytes + tp->old_len, tp->new_len, 16,
+			       text_poke_printer, &old, fp);
+	return ret;
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -457,6 +501,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_BPF_EVENT:
 		ret += perf_event__fprintf_bpf(event, fp);
 		break;
+	case PERF_RECORD_TEXT_POKE:
+		ret += perf_event__fprintf_text_poke(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b8289f160f07..dbbba6dea51d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -351,6 +351,10 @@ int perf_event__process_bpf(struct perf_tool *tool,
 			    union perf_event *event,
 			    struct perf_sample *sample,
 			    struct machine *machine);
+int perf_event__process_text_poke(struct perf_tool *tool,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine);
 int perf_event__process(struct perf_tool *tool,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -385,6 +389,7 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..93e9b35e53b0 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -175,6 +175,7 @@ struct callchain_param;
 void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
+bool perf_can_record_text_poke_events(void);
 bool perf_can_record_cpu_wide(void);
 bool perf_can_aux_sample(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eb880efbce16..b617d3b1fa95 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1098,7 +1098,12 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->mmap  = track;
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
-	attr->ksymbol = track && !perf_missing_features.ksymbol;
+	/*
+	 * ksymbol is tracked separately with text poke because it needs to be
+	 * system wide and enabled immediately.
+	 */
+	if (!opts->text_poke)
+		attr->ksymbol = track && !perf_missing_features.ksymbol;
 	attr->bpf_event = track && !opts->no_bpf_event && !perf_missing_features.bpf;
 
 	if (opts->record_namespaces)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 97142e9671be..0fff43cf15e5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -796,6 +796,47 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	return machine__process_ksymbol_register(machine, event, sample);
 }
 
+int machine__process_text_poke(struct machine *machine, union perf_event *event,
+			       struct perf_sample *sample __maybe_unused)
+{
+	struct map *map = maps__find(&machine->kmaps, event->text_poke.addr);
+	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+
+	if (dump_trace)
+		perf_event__fprintf_text_poke(event, stdout);
+
+	if (!event->text_poke.new_len)
+		return 0;
+
+	if (cpumode != PERF_RECORD_MISC_KERNEL) {
+		pr_debug("%s: unsupported cpumode - ignoring\n", __func__);
+		return 0;
+	}
+
+	if (map && map->dso) {
+		u8 *new_bytes = event->text_poke.bytes + event->text_poke.old_len;
+		int ret;
+
+		/*
+		 * Kernel maps might be changed when loading symbols so loading
+		 * must be done prior to using kernel maps.
+		 */
+		map__load(map);
+		ret = dso__data_write_cache_addr(map->dso, map, machine,
+						 event->text_poke.addr,
+						 new_bytes,
+						 event->text_poke.new_len);
+		if (ret != event->text_poke.new_len)
+			pr_debug("Failed to write kernel text poke at %#" PRI_lx64 "\n",
+				 event->text_poke.addr);
+	} else {
+		pr_debug("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
+			 event->text_poke.addr);
+	}
+
+	return 0;
+}
+
 static struct map *machine__addnew_module_map(struct machine *machine, u64 start,
 					      const char *filename)
 {
@@ -1918,6 +1959,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_ksymbol(machine, event, sample); break;
 	case PERF_RECORD_BPF_EVENT:
 		ret = machine__process_bpf(machine, event, sample); break;
+	case PERF_RECORD_TEXT_POKE:
+		ret = machine__process_text_poke(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index fa1be9ea00fa..062c36a8433c 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -138,6 +138,9 @@ int machine__process_mmap2_event(struct machine *machine, union perf_event *even
 int machine__process_ksymbol(struct machine *machine,
 			     union perf_event *event,
 			     struct perf_sample *sample);
+int machine__process_text_poke(struct machine *machine,
+			       union perf_event *event,
+			       struct perf_sample *sample);
 int machine__process_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index b94fa07f5d32..e67a227c0ce7 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -147,6 +147,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
+	PRINT_ATTRf(text_poke, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 7def66168503..207ba2a65008 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -97,6 +97,11 @@ static void perf_probe_context_switch(struct evsel *evsel)
 	evsel->core.attr.context_switch = 1;
 }
 
+static void perf_probe_text_poke(struct evsel *evsel)
+{
+	evsel->core.attr.text_poke = 1;
+}
+
 bool perf_can_sample_identifier(void)
 {
 	return perf_probe_api(perf_probe_sample_identifier);
@@ -112,6 +117,11 @@ bool perf_can_record_switch_events(void)
 	return perf_probe_api(perf_probe_context_switch);
 }
 
+bool perf_can_record_text_poke_events(void)
+{
+	return perf_probe_api(perf_probe_text_poke);
+}
+
 bool perf_can_record_cpu_wide(void)
 {
 	struct perf_event_attr attr = {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 24316458be20..d0fd99864c49 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -47,6 +47,7 @@ struct record_opts {
 	bool	      sample_id;
 	bool	      no_bpf_event;
 	bool	      kcore;
+	bool	      text_poke;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0b0bfe5bef17..9e011f3a83ef 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -491,6 +491,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->ksymbol = perf_event__process_ksymbol;
 	if (tool->bpf == NULL)
 		tool->bpf = perf_event__process_bpf;
+	if (tool->text_poke == NULL)
+		tool->text_poke = perf_event__process_text_poke;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -660,6 +662,24 @@ static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
 		swap_sample_id_all(event, &event->context_switch + 1);
 }
 
+static void perf_event__text_poke_swap(union perf_event *event, bool sample_id_all)
+{
+	event->text_poke.addr    = bswap_64(event->text_poke.addr);
+	event->text_poke.old_len = bswap_16(event->text_poke.old_len);
+	event->text_poke.new_len = bswap_16(event->text_poke.new_len);
+
+	if (sample_id_all) {
+		size_t len = sizeof(event->text_poke.old_len) +
+			     sizeof(event->text_poke.new_len) +
+			     event->text_poke.old_len +
+			     event->text_poke.new_len;
+		void *data = &event->text_poke.old_len;
+
+		data += PERF_ALIGN(len, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+}
+
 static void perf_event__throttle_swap(union perf_event *event,
 				      bool sample_id_all)
 {
@@ -933,6 +953,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
+	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1476,6 +1497,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
 		return tool->bpf(tool, event, sample, machine);
+	case PERF_RECORD_TEXT_POKE:
+		return tool->text_poke(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 3fb67bd31e4a..bbbc0dcd461f 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -57,7 +57,8 @@ struct perf_tool {
 			throttle,
 			unthrottle,
 			ksymbol,
-			bpf;
+			bpf,
+			text_poke;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.17.1

