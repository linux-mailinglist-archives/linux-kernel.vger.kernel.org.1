Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848027FC83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgJAJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgJAJeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:34:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 785B5AD49;
        Thu,  1 Oct 2020 09:34:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     acme@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] perf: fix off by ones in memset after realloc
Date:   Thu,  1 Oct 2020 11:34:19 +0200
Message-Id: <20201001093419.15761-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'perf trace ls' started crashing after commit d21cb73a9025 on
!HAVE_SYSCALL_TABLE_SUPPORT configs (armv7l here) like this:
0  strlen () at ../sysdeps/arm/armv6t2/strlen.S:126
1  0xb6800780 in __vfprintf_internal (s=0xbeff9908, s@entry=0xbeff9900, format=0xa27160 "]: %s()", ap=..., mode_flags=<optimized out>) at vfprintf-internal.c:1688
...
5  0x0056ecdc in fprintf (__fmt=0xa27160 "]: %s()", __stream=<optimized out>) at /usr/include/bits/stdio2.h:100
6  trace__sys_exit (trace=trace@entry=0xbeffc710, evsel=evsel@entry=0xd968d0, event=<optimized out>, sample=sample@entry=0xbeffc3e8) at builtin-trace.c:2475
7  0x00566d40 in trace__handle_event (sample=0xbeffc3e8, event=<optimized out>, trace=0xbeffc710) at builtin-trace.c:3122
...
15 main (argc=2, argv=0xbefff6e8) at perf.c:538

It is because memset in trace__read_syscall_info zeroes wrong memory:
1) when initializing for the first time, it does not reset the last id.
2) in other cases, it resets the last id of previous buffer.

ad 1) it causes the crash above as sc->name used in the fprintf above
      contains garbage.

ad 2) it sets nonexistent from true back to false for id 11 here. Not
      sure, what the consequences are.

So fix it by introducing a special case for the initial initialization
and do the right +1 in both cases.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: d21cb73a9025 ("perf trace: Grow the syscall table as needed when using libaudit")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bea461b6f937..44a75f234db1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1762,7 +1762,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 		if (table == NULL)
 			return -ENOMEM;
 
-		memset(table + trace->sctbl->syscalls.max_id, 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
+		// Need to memset from offset 0 and +1 members if brand new
+		if (trace->syscalls.table == NULL)
+			memset(table, 0, (id + 1) * sizeof(*sc));
+		else
+			memset(table + trace->sctbl->syscalls.max_id + 1, 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
 
 		trace->syscalls.table	      = table;
 		trace->sctbl->syscalls.max_id = id;
-- 
2.28.0

