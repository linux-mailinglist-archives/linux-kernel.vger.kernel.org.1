Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC8212F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGBV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 17:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgGBV6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267C92193E;
        Thu,  2 Jul 2020 21:58:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E1-004BiX-7M; Thu, 02 Jul 2020 17:58:33 -0400
Message-ID: <20200702215833.101705360@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 11/18] ring-buffer: Incorporate absolute timestamp into add_timestamp logic
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of calling out the absolute test for each time to check if the
ring buffer wants absolute time stamps for all its recording, incorporate it
with the add_timestamp field and turn it into flags for faster processing
between wanting a absolute tag and needing to force one.

Link: http://lkml.kernel.org/r/20200629025259.154892368@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 40 +++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 026238c55b0c..7ee6619951ea 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -422,13 +422,15 @@ struct rb_event_info {
 /*
  * Used for the add_timestamp
  *  NONE
- *  NORMAL - may be for either time extend or absolute
+ *  EXTEND - wants a time extend
+ *  ABSOLUTE - the buffer requests all events to have absolute time stamps
  *  FORCE - force a full time stamp.
  */
 enum {
-	RB_ADD_STAMP_NONE,
-	RB_ADD_STAMP_NORMAL,
-	RB_ADD_STAMP_FORCE
+	RB_ADD_STAMP_NONE		= 0,
+	RB_ADD_STAMP_EXTEND		= BIT(1),
+	RB_ADD_STAMP_ABSOLUTE		= BIT(2),
+	RB_ADD_STAMP_FORCE		= BIT(3)
 };
 /*
  * Used for which event context the event is in.
@@ -2434,8 +2436,8 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 	 * add it to the start of the reserved space.
 	 */
 	if (unlikely(info->add_timestamp)) {
-		bool abs = info->add_timestamp == RB_ADD_STAMP_FORCE ||
-			ring_buffer_time_stamp_abs(cpu_buffer->buffer);
+		bool abs = info->add_timestamp &
+			(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE);
 
 		event = rb_add_time_stamp(event, abs ? info->delta : delta, abs);
 		length -= RB_LEN_TIME_EXTEND;
@@ -2884,8 +2886,8 @@ int ring_buffer_unlock_commit(struct trace_buffer *buffer,
 EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
 static noinline void
-rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
-		    struct rb_event_info *info)
+rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
+		   struct rb_event_info *info)
 {
 	WARN_ONCE(info->delta > (1ULL << 59),
 		  KERN_WARNING "Delta way too big! %llu ts=%llu write stamp = %llu\n%s",
@@ -2897,7 +2899,6 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  "please switch to the trace global clock:\n"
 		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
 		  "or add trace_clock=global to the kernel command line\n");
-	info->add_timestamp = RB_ADD_STAMP_NORMAL;
 }
 
 static struct ring_buffer_event *
@@ -2908,7 +2909,6 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w;
 	u64 before, after;
-	bool abs = false;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
@@ -2922,20 +2922,23 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		info->delta = info->ts;
-		abs = true;
+		info->add_timestamp = RB_ADD_STAMP_ABSOLUTE;
 	} else {
 		info->delta = info->ts - after;
 	}
 
-	if (unlikely(test_time_stamp(info->delta)))
-		rb_handle_timestamp(cpu_buffer, info);
+	if (unlikely(test_time_stamp(info->delta))) {
+		rb_check_timestamp(cpu_buffer, info);
+		info->add_timestamp |= RB_ADD_STAMP_EXTEND;
+	}
 
 	/*
 	 * If interrupting an event time update, we may need an absolute timestamp.
 	 * Don't bother if this is the start of a new page (w == 0).
 	 */
 	if (unlikely(before != after && w))
-		info->add_timestamp = RB_ADD_STAMP_FORCE;
+		info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
+
 	/*
 	 * If the time delta since the last event is too big to
 	 * hold in the time field of the event, then we append a
@@ -2972,7 +2975,8 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
  /*D*/		local64_set(&cpu_buffer->write_stamp, info->ts);
 		barrier();
  /*E*/		save_before = local64_read(&cpu_buffer->before_stamp);
-		if (likely(info->add_timestamp != RB_ADD_STAMP_FORCE))
+		if (likely(!(info->add_timestamp &
+			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
 			info->delta = info->ts - after;
 		else
@@ -3015,15 +3019,15 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			 */
 			info->delta = 0;
 		}
-		if (info->add_timestamp == RB_ADD_STAMP_FORCE)
-			info->add_timestamp = RB_ADD_STAMP_NORMAL;
+		info->add_timestamp &= ~RB_ADD_STAMP_FORCE;
 	}
 
 	/*
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && info->add_timestamp != RB_ADD_STAMP_FORCE && !abs))
+	if (unlikely(!tail && !(info->add_timestamp &
+				(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
-- 
2.26.2


