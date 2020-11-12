Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C92AFC81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgKLBhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgKLAfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:35:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C30D216FD;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002DE-9X; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003335.178219652@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 14/17] ring-buffer: Add recording of ring buffer recursion into
 recursed_functions
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a new config RING_BUFFER_RECORD_RECURSION that will place functions that
recurse from the ring buffer into the ftrace recused_functions file.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig       | 14 ++++++++++++++
 kernel/trace/ring_buffer.c | 12 +++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 9b11c096d139..6aa36ec73ccb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -752,6 +752,20 @@ config FTRACE_RECORD_RECURSION_SIZE
 	  This file can be reset, but the limit can not change in
 	  size at runtime.
 
+config RING_BUFFER_RECORD_RECURSION
+	bool "Record functions that recurse in the ring buffer"
+	depends on FTRACE_RECORD_RECURSION
+	# default y, because it is coupled with FTRACE_RECORD_RECURSION
+	default y
+	help
+	  The ring buffer has its own internal recursion. Although when
+	  recursion happens it wont cause harm because of the protection,
+	  but it does cause an unwanted overhead. Enabling this option will
+	  place where recursion was detected into the ftrace "recursed_functions"
+	  file.
+
+	  This will add more overhead to cases that have recursion.
+
 config GCOV_PROFILE_FTRACE
 	bool "Enable GCOV profiling on ftrace subsystem"
 	depends on GCOV_KERNEL
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dc83b3fa9fe7..ab68f28b8f4b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
+#include <linux/trace_recursion.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -3006,6 +3007,13 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	irq_work_queue(&cpu_buffer->irq_work.work);
 }
 
+#ifdef CONFIG_RING_BUFFER_RECORD_RECURSION
+# define do_ring_buffer_record_recursion()	\
+	do_ftrace_record_recursion(_THIS_IP_, _RET_IP_)
+#else
+# define do_ring_buffer_record_recursion() do { } while (0)
+#endif
+
 /*
  * The lock and unlock are done within a preempt disable section.
  * The current_context per_cpu variable can only be modified
@@ -3088,8 +3096,10 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		 * been updated yet. In this case, use the TRANSITION bit.
 		 */
 		bit = RB_CTX_TRANSITION;
-		if (val & (1 << (bit + cpu_buffer->nest)))
+		if (val & (1 << (bit + cpu_buffer->nest))) {
+			do_ring_buffer_record_recursion();
 			return 1;
+		}
 	}
 
 	val |= (1 << (bit + cpu_buffer->nest));
-- 
2.28.0


