Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603C81B080D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgDTLxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:53:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63115221F4;
        Mon, 20 Apr 2020 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383622;
        bh=UX2AIXKQ6r0jvUhx10zLTeHYWqsG+eFORiDSNhAyhQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7Vh2sPjTjKecvhj5pbz+rKFrLu397VtAne2PPgJVG/QkpiMb78lJ5Jmrt7AsFDql
         +QKgyhI07OjKtkcLlknye3+Tlk64V91s2ORFX4KVQfM1tu7kefOJYGRak0iZUNHr2H
         eCr4Tdn28r5TbHC2bVBTvOk123BYetcmkZPfOij4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?q?Bj=C3=83=C2=B6rn=20T=C3=83=C2=B6pel?= 
        <bjorn.topel@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/60] perf annotate: Add basic support for bpf_image
Date:   Mon, 20 Apr 2020 08:52:20 -0300
Message-Id: <20200420115316.18781-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the DSO_BINARY_TYPE__BPF_IMAGE dso binary type to recognize BPF
images that carry trampoline or dispatcher.

Upcoming patches will add support to read the image data, store it
within the BPF feature in perf.data and display it for annotation
purposes.

Currently we only display following message:

  # ./perf annotate bpf_trampoline_24456 --stdio
   Percent |      Source code & Disassembly of . for cycles (504  ...
  --------------------------------------------------------------- ...
           :       to be implemented

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: BjÃ¶rn TÃ¶pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200312195610.346362-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 20 ++++++++++++++++++++
 tools/perf/util/dso.c      |  1 +
 tools/perf/util/dso.h      |  1 +
 tools/perf/util/machine.c  | 11 +++++++++++
 tools/perf/util/symbol.c   |  1 +
 5 files changed, 34 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f1ea0d61eb5b..9760d58e979a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1821,6 +1821,24 @@ static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
 }
 #endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 
+static int
+symbol__disassemble_bpf_image(struct symbol *sym,
+			      struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl;
+
+	args->offset = -1;
+	args->line = strdup("to be implemented");
+	args->line_nr = 0;
+	dl = disasm_line__new(args);
+	if (dl)
+		annotation_line__add(&dl->al, &notes->src->source);
+
+	free(args->line);
+	return 0;
+}
+
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1920,6 +1938,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 		return symbol__disassemble_bpf(sym, args);
+	} else if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE) {
+		return symbol__disassemble_bpf_image(sym, args);
 	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 91f21239608b..f338990e0fe6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -191,6 +191,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b79617a..9553a1fd9e8a 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -40,6 +40,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
+	DSO_BINARY_TYPE__BPF_IMAGE,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 06aa4e4db63d..09845eae9c03 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -736,6 +736,12 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int is_bpf_image(const char *name)
+{
+	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
+	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
+}
+
 static int machine__process_ksymbol_register(struct machine *machine,
 					     union perf_event *event,
 					     struct perf_sample *sample __maybe_unused)
@@ -760,6 +766,11 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
 		dso__set_loaded(dso);
+
+		if (is_bpf_image(event->ksymbol.name)) {
+			dso->binary_type = DSO_BINARY_TYPE__BPF_IMAGE;
+			dso__set_long_name(dso, "", false);
+		}
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 26bc6a0096ce..8f4300492dc7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1544,6 +1544,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		return true;
 
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
-- 
2.21.1

