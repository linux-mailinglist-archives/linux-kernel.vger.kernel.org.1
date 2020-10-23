Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE1297339
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbgJWQHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465063AbgJWQHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:07:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A60222210;
        Fri, 23 Oct 2020 16:07:52 +0000 (UTC)
Date:   Fri, 23 Oct 2020 12:07:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [GIT PULL] ring-buffer: Updates for 5.10
Message-ID: <20201023120750.72f73a97@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

ring-buffer fix:

The success return value of ring_buffer_resize() is stated to be zero,
and checked that way. But it is incorrectly returning the size allocated.

Also, a fix to a comment.


Please pull the latest trace-v5.10-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-3

Tag SHA1: 9e0dd73391c8f6cf700fe46cd65415b41676ba16
Head SHA1: e1981f75d398c0afe83c8ffa4e5864f037967409


Qiujun Huang (2):
      ring-buffer: Return 0 on success from ring_buffer_resize()
      ring-buffer: Update the description for ring_buffer_wait

----
 kernel/trace/ring_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 15bf28b13e50..7f45fd9d5a45 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -793,7 +793,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
  * @cpu: the cpu buffer to wait on
- * @full: wait until a full page is available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
@@ -1952,18 +1952,18 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long nr_pages;
-	int cpu, err = 0;
+	int cpu, err;
 
 	/*
 	 * Always succeed at resizing a non-existent buffer:
 	 */
 	if (!buffer)
-		return size;
+		return 0;
 
 	/* Make sure the requested buffer exists */
 	if (cpu_id != RING_BUFFER_ALL_CPUS &&
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
-		return size;
+		return 0;
 
 	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
 
@@ -2119,7 +2119,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	}
 
 	mutex_unlock(&buffer->mutex);
-	return size;
+	return 0;
 
  out_err:
 	for_each_buffer_cpu(buffer, cpu) {
