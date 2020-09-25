Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6552F279321
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgIYVS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgIYVSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:18:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87328221EC;
        Fri, 25 Sep 2020 21:18:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kLv6h-002CtJ-SY; Fri, 25 Sep 2020 17:18:19 -0400
Message-ID: <20200925211819.767526657@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Sep 2020 17:12:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 1/3 v2] tracepoints: Add helper to test if tracepoint is enabled in a header
References: <20200925211206.423598568@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As tracepoints are discouraged from being added in a header because it can
cause side effects if other tracepoints are in headers, as well as bloat the
kernel as the trace_<tracepoint>() function is not a small inline, the common
workaround is to add a function call that calls a wrapper function in a
C file that then calls the tracepoint. But as function calls add overhead,
this function should only be called when the tracepoint in question is
enabled. To get around this overhead, a static_branch can be used to only
have the tracepoint wrapper get called when the tracepoint is enabled.

Add a tracepoint_enabled(tp) macro that gets passed the name of the
tracepoint, and this becomes a static_branch that is enabled when the
tracepoint is enabled and is a nop when the tracepoint is disabled.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/tracepoints.rst | 27 +++++++++++++++++++++++
 include/linux/tracepoint-defs.h     | 34 +++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
index 6e3ce3bf3593..68579ebd1e4c 100644
--- a/Documentation/trace/tracepoints.rst
+++ b/Documentation/trace/tracepoints.rst
@@ -146,3 +146,30 @@ with jump labels and avoid conditional branches.
       define tracepoints. Check http://lwn.net/Articles/379903,
       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
       for a series of articles with more details.
+
+If you require calling a tracepoint from a header file, it is not
+recommended to call one directly or to use the trace_<tracepoint>_enabled()
+function call, as tracepoints in header files can have side effects if a
+header is included from a file that has CREATE_TRACE_POINTS set, as
+well as the trace_<tracepoint>() is not that small of an inline
+and can bloat the kernel if used by other inlined functions. Instead,
+include tracepoint-defs.h and use tracepoint_enabled().
+
+In a C file::
+
+	void do_trace_foo_bar_wrapper(args)
+	{
+		trace_foo_bar(args);
+	}
+
+In the header file::
+
+	DECLEARE_TRACEPOINT(foo_bar);
+
+	static inline void some_inline_function()
+	{
+		[..]
+		if (tracepoint_enabled(foo_bar))
+			do_trace_foo_bar_wrapper(args);
+		[..]
+	}
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index b29950a19205..60625973faaf 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -48,4 +48,38 @@ struct bpf_raw_event_map {
 	u32			writable_size;
 } __aligned(32);
 
+/*
+ * If a tracepoint needs to be called from a header file, it is not
+ * recommended to call it directly, as tracepoints in header files
+ * may cause side-effects and bloat the kernel. Instead, use
+ * tracepoint_enabled() to test if the tracepoint is enabled, then if
+ * it is, call a wrapper function defined in a C file that will then
+ * call the tracepoint.
+ *
+ * For "trace_foo_bar()", you would need to create a wrapper function
+ * in a C file to call trace_foo_bar():
+ *   void do_trace_foo_bar(args) { trace_foo_bar(args); }
+ * Then in the header file, declare the tracepoint:
+ *   DECLARE_TRACEPOINT(foo_bar);
+ * And call your wrapper:
+ *   static inline void some_inlined_function() {
+ *            [..]
+ *            if (tracepoint_enabled(foo_bar))
+ *                    do_trace_foo_bar(args);
+ *            [..]
+ *   }
+ *
+ * Note: tracepoint_enabled(foo_bar) is equivalent to trace_foo_bar_enabled()
+ *   but is safe to have in headers, where trace_foo_bar_enabled() is not.
+ */
+#define DECLARE_TRACEPOINT(tp) \
+	extern struct tracepoint __tracepoint_##tp
+
+#ifdef CONFIG_TRACEPOINTS
+# define tracepoint_enabled(tp) \
+	static_key_false(&(__tracepoint_##tp).key)
+#else
+# define tracepoint_enabled(tracepoint) false
+#endif
+
 #endif
-- 
2.28.0


