Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707AF28B05A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgJLIhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:37:02 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:15638 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgJLIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:37:01 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 04:37:01 EDT
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH] trace: Return ENOTCONN instead of EBADF
Date:   Mon, 12 Oct 2020 10:26:42 +0200
Message-ID: <20201012082642.1394-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=X8Is11be c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=afefHYAZSVUA:10 a=z6gsHLkEAAAA:8 a=iexfoQ0RlwQR1pufzXEA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no clients listening on event the trace return
EBADF. The file is not a bad file descriptor and to get the
userspace able to do a proper error handling it need a different
error code that separate a bad file descriptor from a empty listening.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3e5de717df2..6e592bf736df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6651,8 +6651,8 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    irq_flags, preempt_count());
 	if (unlikely(!event))
-		/* Ring buffer disabled, return as if not open for write */
-		return -EBADF;
+		/* Ring buffer disabled, return as if not connected */
+		return -ENOTCONN;
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = _THIS_IP_;
@@ -6731,8 +6731,8 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
 					    irq_flags, preempt_count());
 	if (!event)
-		/* Ring buffer disabled, return as if not open for write */
-		return -EBADF;
+		/* Ring buffer disabled, return not connected */
+		return -ENOTCONN;
 
 	entry = ring_buffer_event_data(event);
 
-- 
2.17.1

