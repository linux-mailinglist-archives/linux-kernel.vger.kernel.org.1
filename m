Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99F19EDE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 22:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgDEUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 16:15:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgDEUPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:15:07 -0400
IronPort-SDR: Jem/vxYhmuQR07wD0D6OtGhtFRLPhHGddUrgOMvb6SDI7iOMG0gFjLUklhbaZqz1LxDZpKIPbY
 CZgy3DE7iRWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:15:05 -0700
IronPort-SDR: Jp5kVJApLr9kqiJaUi9aKNyYtJX3u0KiLvNu3/UxtZzHp0S1jSjeACHMzXtZAVCN1x5sPkYmkW
 xsrtU+PU6Y6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688490"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:15:03 -0700
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
Subject: [PATCH V6 12/15] perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
Date:   Sun,  5 Apr 2020 23:13:24 +0300
Message-Id: <20200405201327.7332-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_RECORD_KSYMBOL_TYPE_OOL marks an executable page. Create a map backed
only by memory, which will be populated as necessary by text poke events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h | 5 +++++
 tools/perf/util/dso.c                 | 3 +++
 tools/perf/util/dso.h                 | 1 +
 tools/perf/util/machine.c             | 6 ++++++
 tools/perf/util/map.c                 | 5 +++++
 tools/perf/util/map.h                 | 3 ++-
 tools/perf/util/symbol.c              | 1 +
 7 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index e5bee6c17b86..52ca2093831c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1049,6 +1049,11 @@ enum perf_event_type {
 enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	/*
+	 * Out of line code such as kprobe-replaced instructions or optimized
+	 * kprobes or ftrace trampolines.
+	 */
+	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
 };
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 91f21239608b..9eb50ff6da96 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -191,6 +191,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
@@ -881,6 +882,8 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		*ret = bpf_read(dso, cache_offset, cache->data);
+	else if (dso->binary_type == DSO_BINARY_TYPE__OOL)
+		*ret = DSO__DATA_CACHE_SIZE;
 	else
 		*ret = file_read(dso, machine, cache_offset, cache->data);
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b79617a..b482453bc3d1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -40,6 +40,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
+	DSO_BINARY_TYPE__OOL,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0fff43cf15e5..8447334ac056 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -756,6 +756,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			return -ENOMEM;
 		}
 
+		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
+			map->dso->binary_type = DSO_BINARY_TYPE__OOL;
+			map->dso->data.file_size = event->ksymbol.len;
+			dso__set_loaded(map->dso);
+		}
+
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 53d96611e6a6..f9dc8c5493ea 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -267,6 +267,11 @@ bool __map__is_bpf_prog(const struct map *map)
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
+bool __map__is_ool(const struct map *map)
+{
+	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 067036e8970c..9e312ae2d656 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -147,11 +147,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
 bool __map__is_bpf_prog(const struct map *map);
+bool __map__is_ool(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
 	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
-	       !__map__is_bpf_prog(map);
+	       !__map__is_bpf_prog(map) && !__map__is_ool(map);
 }
 
 bool map__has_symbols(const struct map *map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 26bc6a0096ce..7d4b5ca0bd12 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1544,6 +1544,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		return true;
 
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
-- 
2.17.1

