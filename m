Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18362D9E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408713AbgLNRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502539AbgLNRm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:42:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75AE920643;
        Mon, 14 Dec 2020 17:41:45 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:41:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH] Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"
Message-ID: <20201214124143.675d78bf@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

It was believed that metag was the only architecture that required the ring
buffer to keep 8 byte words aligned on 8 byte architectures, and with its
removal, it was assumed that the ring buffer code did not need to handle
this case. It appears that sparc64 also requires this.

The following was reported on a sparc64 boot up:

   kernel: futex hash table entries: 65536 (order: 9, 4194304 bytes, linear)
   kernel: Running postponed tracer tests:
   kernel: Testing tracer function:
   kernel: Kernel unaligned access at TPC[552a20] trace_function+0x40/0x140
   kernel: Kernel unaligned access at TPC[552a24] trace_function+0x44/0x140
   kernel: Kernel unaligned access at TPC[552a20] trace_function+0x40/0x140
   kernel: Kernel unaligned access at TPC[552a24] trace_function+0x44/0x140
   kernel: Kernel unaligned access at TPC[552a20] trace_function+0x40/0x140
   kernel: PASSED

Need to put back the 64BIT aligned code for the ring buffer.

Link: https://lore.kernel.org/r/CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com

Cc: stable@vger.kernel.org
Fixes: 86b3de60a0b6 ("ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/Kconfig               | 16 ++++++++++++++++
 kernel/trace/ring_buffer.c | 17 +++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..fa716994f77e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -143,6 +143,22 @@ config UPROBES
 	    managed by the kernel and kept transparent to the probed
 	    application. )
 
+config HAVE_64BIT_ALIGNED_ACCESS
+	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	help
+	  Some architectures require 64 bit accesses to be 64 bit
+	  aligned, which also requires structs containing 64 bit values
+	  to be 64 bit aligned too. This includes some 32 bit
+	  architectures which can do 64 bit accesses, as well as 64 bit
+	  architectures without unaligned access.
+
+	  This symbol should be selected by an architecture if 64 bit
+	  accesses are required to be 64 bit aligned in this way even
+	  though it is not a 64 bit architecture.
+
+	  See Documentation/unaligned-memory-access.txt for more
+	  information on the topic of unaligned memory accesses.
+
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	bool
 	help
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e03bc4e5d482..926845eb5ab5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -130,7 +130,16 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 #define RB_ALIGNMENT		4U
 #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
 #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
-#define RB_ALIGN_DATA		__aligned(RB_ALIGNMENT)
+
+#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
+# define RB_FORCE_8BYTE_ALIGNMENT	0
+# define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
+#else
+# define RB_FORCE_8BYTE_ALIGNMENT	1
+# define RB_ARCH_ALIGNMENT		8U
+#endif
+
+#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
 
 /* define RINGBUF_TYPE_DATA for 'case RINGBUF_TYPE_DATA:' */
 #define RINGBUF_TYPE_DATA 0 ... RINGBUF_TYPE_DATA_TYPE_LEN_MAX
@@ -2718,7 +2727,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event->time_delta = delta;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA) {
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
 		event->type_len = 0;
 		event->array[0] = length;
 	} else
@@ -2733,11 +2742,11 @@ static unsigned rb_calculate_event_length(unsigned length)
 	if (!length)
 		length++;
 
-	if (length > RB_MAX_SMALL_DATA)
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
 		length += sizeof(event.array[0]);
 
 	length += RB_EVNT_HDR_SIZE;
-	length = ALIGN(length, RB_ALIGNMENT);
+	length = ALIGN(length, RB_ARCH_ALIGNMENT);
 
 	/*
 	 * In case the time delta is larger than the 27 bits for it
-- 
2.25.4

