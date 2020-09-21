Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897127338D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIUUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:19:46 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:19:46 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4BwG4s4cTWzKm58;
        Mon, 21 Sep 2020 22:19:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id AGXsDqjfAYbH; Mon, 21 Sep 2020 22:19:38 +0200 (CEST)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     linux-kernel@vger.kernel.org
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] perf script: autopep8 futex-contention
Date:   Mon, 21 Sep 2020 22:19:27 +0200
Message-Id: <20200921201928.799498-1-hagen@jauu.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.14 / 15.00 / 15.00
X-Rspamd-Queue-Id: BBC771696
X-Rspamd-UID: 699e87
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10 years leaves its mark! Python has evolved and so has its style guide.
Even with vim it is getting hard to follow the no longer valid
guidelines (spaces vs. tabs).

Autopep8 this code to modernize it!

Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/futex-contention.py | 51 ++++++++++---------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index 0c4841acf75d..c440f02627dd 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -12,41 +12,46 @@
 
 from __future__ import print_function
 
-import os, sys
-sys.path.append(os.environ['PERF_EXEC_PATH'] + '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+import os
+import sys
+sys.path.append(os.environ['PERF_EXEC_PATH'] +
+                '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 from Util import *
 
 process_names = {}
 thread_thislock = {}
 thread_blocktime = {}
 
-lock_waits = {} # long-lived stats on (tid,lock) blockage elapsed time
-process_names = {} # long-lived pid-to-execname mapping
+lock_waits = {}  # long-lived stats on (tid,lock) blockage elapsed time
+process_names = {}  # long-lived pid-to-execname mapping
+
 
 def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
-			      nr, uaddr, op, val, utime, uaddr2, val3):
-	cmd = op & FUTEX_CMD_MASK
-	if cmd != FUTEX_WAIT:
-		return # we don't care about originators of WAKE events
+                              nr, uaddr, op, val, utime, uaddr2, val3):
+    cmd = op & FUTEX_CMD_MASK
+    if cmd != FUTEX_WAIT:
+        return  # we don't care about originators of WAKE events
+
+    process_names[tid] = comm
+    thread_thislock[tid] = uaddr
+    thread_blocktime[tid] = nsecs(s, ns)
 
-	process_names[tid] = comm
-	thread_thislock[tid] = uaddr
-	thread_blocktime[tid] = nsecs(s, ns)
 
 def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
-			     nr, ret):
-	if tid in thread_blocktime:
-		elapsed = nsecs(s, ns) - thread_blocktime[tid]
-		add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
-		del thread_blocktime[tid]
-		del thread_thislock[tid]
+                             nr, ret):
+    if tid in thread_blocktime:
+        elapsed = nsecs(s, ns) - thread_blocktime[tid]
+        add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
+        del thread_blocktime[tid]
+        del thread_thislock[tid]
+
 
 def trace_begin():
-	print("Press control+C to stop and show the summary")
+    print("Press control+C to stop and show the summary")
 
-def trace_end():
-	for (tid, lock) in lock_waits:
-		min, max, avg, count = lock_waits[tid, lock]
-		print("%s[%d] lock %x contended %d times, %d avg ns" %
-			(process_names[tid], tid, lock, count, avg))
 
+def trace_end():
+    for (tid, lock) in lock_waits:
+        min, max, avg, count = lock_waits[tid, lock]
+        print("%s[%d] lock %x contended %d times, %d avg ns" %
+              (process_names[tid], tid, lock, count, avg))
-- 
2.28.0

