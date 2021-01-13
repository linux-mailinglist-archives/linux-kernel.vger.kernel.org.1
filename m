Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDA2F45A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAMICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:02:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbhAMICL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:02:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F25FAE40;
        Wed, 13 Jan 2021 08:01:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: Resolve symbols against debug file first
Date:   Wed, 13 Jan 2021 09:01:28 +0100
Message-Id: <20210113080128.10286-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With LTO, there are symbols like these:
/usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
 10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7

This comes from a runtime/debug split done by the standard way:
objcopy --only-keep-debug $runtime $debug
objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime

perf currently cannot resolve such symbols (relicts of LTO), as section
29 exists only in the debug file (29 is .debug_info). And perf resolves
symbols only against runtime file. This results in all symbols from such
a library being unresolved:
     0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0

So try resolving against the debug file first. And only if it fails (the
section has NOBITS set), try runtime file. We can do this, as "objcopy
--only-keep-debug" per documentation preserves all sections, but clears
data of some of them (the runtime ones) and marks them as NOBITS.

The correct result is now:
     0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream

Note that these LTO symbols are properly skipped anyway as they belong
neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
secstrs) is true).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol-elf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index f3577f7d72fe..a31b716fa61c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		if (sym.st_shndx == SHN_ABS)
 			continue;
 
-		sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
+		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
 		if (!sec)
 			goto out_elf_end;
 
 		gelf_getshdr(sec, &shdr);
 
+		if (shdr.sh_type == SHT_NOBITS) {
+			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
+			if (!sec)
+				goto out_elf_end;
+
+			gelf_getshdr(sec, &shdr);
+		}
+
 		if (is_label && !elf_sec__filter(&shdr, secstrs))
 			continue;
 
-- 
2.30.0

