Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB58E212F28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgGBV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 17:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgGBV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1943721D79;
        Thu,  2 Jul 2020 21:58:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E2-004Bld-58; Thu, 02 Jul 2020 17:58:34 -0400
Message-ID: <20200702215834.018097029@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH 17/18] ring-buffer: Call trace_clock_local() directly for RETPOLINE kernels
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

After doing some benchmarks and examining the code, I found that the ring
buffer clock calls were quite expensive, and noticed that it uses
retpolines. This is because the ring buffer clock is programmable, and can
be set. But in most cases it simply uses the fastest ns unit clock which is
the trace_clock_local(). For RETPOLINE builds, checking if the ring buffer
clock is set to trace_clock_local() and then calling it directly has brought
the time of an event on my i7 box from an average of 93 nanoseconds an event
down to 83 nanoseconds an event, and the minimum time from 81 nanoseconds to
68 nanoseconds!

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a30ca7ec2200..2bb96ee80120 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -970,8 +970,16 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 
 static inline u64 rb_time_stamp(struct trace_buffer *buffer)
 {
+	u64 ts;
+
+	/* Skip retpolines :-( */
+	if (IS_ENABLED(CONFIG_RETPOLINE) && likely(buffer->clock == trace_clock_local))
+		ts = trace_clock_local();
+	else
+		ts = buffer->clock();
+
 	/* shift to debug/test normalization and TIME_EXTENTS */
-	return buffer->clock() << DEBUG_SHIFT;
+	return ts << DEBUG_SHIFT;
 }
 
 u64 ring_buffer_time_stamp(struct trace_buffer *buffer, int cpu)
-- 
2.26.2


