Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9E2D9CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440258AbgLNQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:27:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440242AbgLNQ1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:27:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95526227C3;
        Mon, 14 Dec 2020 16:26:31 +0000 (UTC)
Date:   Mon, 14 Dec 2020 11:26:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [sparc64] ftrace: kernel startup-tests unaligned access
Message-ID: <20201214112629.3cf6f240@gandalf.local.home>
In-Reply-To: <20201214111512.415717ac@gandalf.local.home>
References: <CADxRZqzXQRYgKc=y-KV=S_yHL+Y8Ay2mh5ezeZUnpRvg+syWKw@mail.gmail.com>
        <20201214111512.415717ac@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 11:15:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Does sparc64 require 8 byte alignment for 8 byte words?
> 

In other words, does this patch fix anything?

-- Steve

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
index f09d3f5911cb..623657f84b72 100644
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
@@ -2717,7 +2726,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event->time_delta = delta;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA) {
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
 		event->type_len = 0;
 		event->array[0] = length;
 	} else
@@ -2732,11 +2741,11 @@ static unsigned rb_calculate_event_length(unsigned length)
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
