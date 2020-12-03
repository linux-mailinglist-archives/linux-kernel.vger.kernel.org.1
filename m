Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCB2CDCC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgLCRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbgLCRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:51:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641B5207B5;
        Thu,  3 Dec 2020 17:51:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kksl0-002qvR-9T; Thu, 03 Dec 2020 12:51:06 -0500
Message-ID: <20201203175106.173081168@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Dec 2020 12:50:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/3] ring-buffer: Add test to validate the time stamp deltas
References: <20201203175013.038902435@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While debugging a situation where a delta for an event was calucalted wrong,
I realize there was nothing making sure that the delta of events are
correct. If a single event has an incorrect delta, then all events after it
will also have one. If the discrepency gets large enough, it could cause
the time stamps to go backwards when crossing sub buffers, that record a
full 64 bit time stamp, and the new deltas are added to that.

Add a way to validate the events at most events and when crossing a buffer
page. This will help make sure that the deltas are always correct. This test
will detect if they are ever corrupted.

The test adds a high overhead to the ring buffer recording, as it does the
audit for almost every event, and should only be used for testing the ring
buffer.

This will catch the bug that is fixed by commit 55ea4cf40380 ("ring-buffer:
Update write stamp with the correct ts"), which is not applied when this
commit is applied.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig       |  20 +++++
 kernel/trace/ring_buffer.c | 150 +++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c9b64dea1216..fe60f9d7a0e6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -845,6 +845,26 @@ config RING_BUFFER_STARTUP_TEST
 
 	 If unsure, say N
 
+config RING_BUFFER_VALIDATE_TIME_DELTAS
+	bool "Verify ring buffer time stamp deltas"
+	depends on RING_BUFFER
+	help
+	  This will audit the time stamps on the ring buffer sub
+	  buffer to make sure that all the time deltas for the
+	  events on a sub buffer matches the current time stamp.
+	  This audit is performed for every event that is not
+	  interrupted, or interrupting another event. A check
+	  is also made when traversing sub buffers to make sure
+	  that all the deltas on the previous sub buffer do not
+	  add up to be greater than the current time stamp.
+
+	  NOTE: This adds significant overhead to recording of events,
+	  and should only be used to test the logic of the ring buffer.
+	  Do not use it on production systems.
+
+	  Only say Y if you understand what this does, and you
+	  still want it enabled. Otherwise say N
+
 config MMIOTRACE_TEST
 	tristate "Test module for mmiotrace"
 	depends on MMIOTRACE && m
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ab68f28b8f4b..7cd888ee9ac7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3193,6 +3193,153 @@ int ring_buffer_unlock_commit(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
+/* Special value to validate all deltas on a page. */
+#define CHECK_FULL_PAGE		1L
+
+#ifdef CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS
+static void dump_buffer_page(struct buffer_data_page *bpage,
+			     struct rb_event_info *info,
+			     unsigned long tail)
+{
+	struct ring_buffer_event *event;
+	u64 ts, delta;
+	int e;
+
+	ts = bpage->time_stamp;
+	pr_warn("  [%lld] PAGE TIME STAMP\n", ts);
+
+	for (e = 0; e < tail; e += rb_event_length(event)) {
+
+		event = (struct ring_buffer_event *)(bpage->data + e);
+
+		switch (event->type_len) {
+
+		case RINGBUF_TYPE_TIME_EXTEND:
+			delta = ring_buffer_event_time_stamp(event);
+			ts += delta;
+			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
+			break;
+
+		case RINGBUF_TYPE_TIME_STAMP:
+			delta = ring_buffer_event_time_stamp(event);
+			ts = delta;
+			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
+			break;
+
+		case RINGBUF_TYPE_PADDING:
+			ts += event->time_delta;
+			pr_warn("  [%lld] delta:%d PADDING\n", ts, event->time_delta);
+			break;
+
+		case RINGBUF_TYPE_DATA:
+			ts += event->time_delta;
+			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
+			break;
+
+		default:
+			break;
+		}
+	}
+}
+
+static DEFINE_PER_CPU(atomic_t, checking);
+static atomic_t ts_dump;
+
+/*
+ * Check if the current event time stamp matches the deltas on
+ * the buffer page.
+ */
+static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
+			 struct rb_event_info *info,
+			 unsigned long tail)
+{
+	struct ring_buffer_event *event;
+	struct buffer_data_page *bpage;
+	u64 ts, delta;
+	bool full = false;
+	int e;
+
+	bpage = info->tail_page->page;
+
+	if (tail == CHECK_FULL_PAGE) {
+		full = true;
+		tail = local_read(&bpage->commit);
+	} else if (info->add_timestamp &
+		   (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE)) {
+		/* Ignore events with absolute time stamps */
+		return;
+	}
+
+	/*
+	 * Do not check the first event (skip possible extends too).
+	 * Also do not check if previous events have not been committed.
+	 */
+	if (tail <= 8 || tail > local_read(&bpage->commit))
+		return;
+
+	/*
+	 * If this interrupted another event, 
+	 */
+	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
+		goto out;
+
+	ts = bpage->time_stamp;
+
+	for (e = 0; e < tail; e += rb_event_length(event)) {
+
+		event = (struct ring_buffer_event *)(bpage->data + e);
+
+		switch (event->type_len) {
+
+		case RINGBUF_TYPE_TIME_EXTEND:
+			delta = ring_buffer_event_time_stamp(event);
+			ts += delta;
+			break;
+
+		case RINGBUF_TYPE_TIME_STAMP:
+			delta = ring_buffer_event_time_stamp(event);
+			ts = delta;
+			break;
+
+		case RINGBUF_TYPE_PADDING:
+			if (event->time_delta == 1)
+				break;
+			/* fall through */
+		case RINGBUF_TYPE_DATA:
+			ts += event->time_delta;
+			break;
+
+		default:
+			RB_WARN_ON(cpu_buffer, 1);
+		}
+	}
+	if ((full && ts > info->ts) ||
+	    (!full && ts + info->delta != info->ts)) {
+		/* If another report is happening, ignore this one */
+		if (atomic_inc_return(&ts_dump) != 1) {
+			atomic_dec(&ts_dump);
+			goto out;
+		}
+		atomic_inc(&cpu_buffer->record_disabled);
+		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld after:%lld\n",
+		       cpu_buffer->cpu,
+		       ts + info->delta, info->ts, info->delta, info->after);
+		dump_buffer_page(bpage, info, tail);
+		atomic_dec(&ts_dump);
+		/* Do not re-enable checking */
+		return;
+	}
+out:
+	atomic_dec(this_cpu_ptr(&checking));
+}
+#else
+static inline void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
+			 struct rb_event_info *info,
+			 unsigned long tail)
+{
+}
+#endif /* CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS */
+
 static struct ring_buffer_event *
 __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct rb_event_info *info)
@@ -3252,6 +3399,8 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
 						      info->before, info->after);
 		}
+		if (a_ok && b_ok)
+			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
@@ -3272,6 +3421,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			/* Just use full timestamp for inerrupting event */
 			info->delta = info->ts;
 		barrier();
+		check_buffer(cpu_buffer, info, tail);
 		if (unlikely(info->ts != save_before)) {
 			/* SLOW PATH - Interrupted between C and E */
 
-- 
2.28.0


