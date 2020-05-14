Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16821D3072
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 14:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 08:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENM6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:58:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCFB820727;
        Thu, 14 May 2020 12:58:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jZDRi-000GAE-L9; Thu, 14 May 2020 08:58:42 -0400
Message-ID: <20200514125842.537090292@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 May 2020 08:58:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 2/3] ring-buffer: Dont deactivate the ring buffer on failed iterator
 reads
References: <20200514125817.850882486@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the function tracer is running and the trace file is read (which uses the
ring buffer iterator), the iterator can get in sync with the writes, and
caues it to fail to find a page with content it can read three times. This
causes a warning and deactivation of the ring buffer code.

Looking at the other cases of failure to get an event, it appears that
there's a chance that the writer could cause them too. Since the iterator is
a "best effort" to read the ring buffer if there's an active writer (the
consumer reader is made for this case "see trace_pipe"), if it fails to get
an event after three tries, simply give up and return NULL. Don't warn, nor
disable the ring buffer on this failure.

Link: https://lore.kernel.org/r/20200429090508.GG5770@shao2-debian

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ff84c50cfb4b ("ring-buffer: Do not die if rb_iter_peek() fails more than thrice")
Tested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6f0b42ceeb00..448d5f528764 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4034,7 +4034,6 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct ring_buffer_event *event;
 	int nr_loops = 0;
-	bool failed = false;
 
 	if (ts)
 		*ts = 0;
@@ -4056,19 +4055,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 		return NULL;
 
 	/*
-	 * We repeat when a time extend is encountered or we hit
-	 * the end of the page. Since the time extend is always attached
-	 * to a data event, we should never loop more than three times.
-	 * Once for going to next page, once on time extend, and
-	 * finally once to get the event.
-	 * We should never hit the following condition more than thrice,
-	 * unless the buffer is very small, and there's a writer
-	 * that is causing the reader to fail getting an event.
+	 * As the writer can mess with what the iterator is trying
+	 * to read, just give up if we fail to get an event after
+	 * three tries. The iterator is not as reliable when reading
+	 * the ring buffer with an active write as the consumer is.
+	 * Do not warn if the three failures is reached.
 	 */
-	if (++nr_loops > 3) {
-		RB_WARN_ON(cpu_buffer, !failed);
+	if (++nr_loops > 3)
 		return NULL;
-	}
 
 	if (rb_per_cpu_empty(cpu_buffer))
 		return NULL;
@@ -4079,10 +4073,8 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	}
 
 	event = rb_iter_head_event(iter);
-	if (!event) {
-		failed = true;
+	if (!event)
 		goto again;
-	}
 
 	switch (event->type_len) {
 	case RINGBUF_TYPE_PADDING:
-- 
2.26.2


