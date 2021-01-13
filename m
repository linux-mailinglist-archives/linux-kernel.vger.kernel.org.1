Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5592F5045
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbhAMQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbhAMQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:44:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:44:16 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610556254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3lktWn95asAPBOJ45VL7o2mFHW8GNuSfujEYucsY3QE=;
        b=KbdX8ByTxMx3dIi728whtjUjw7I4XD2vpAkIKVFvtzqK7ldxLbYjLDBHJHUmBlIJo8zElc
        7FnnfAMHSWlCKXBqeC1WvnXmA4aGu8bXt6FnBRIzmqbhCOg73y6hrcdBw5MR6yP5z/n3UL
        N4lqlzT+IzjLIqbW6VdwLuvlHhVkvLLU/YiGru7GBoZs0B92ydJo+pGdjkoHhEFm/w/SUy
        4bPPLd7iPkRIqDLrKpCxU3dWjeg4EXs7nGa3Pv289W1eSR07AXL3TBiyS5svsMdXwxKdrW
        LBQNLemzs+BTFJiYWwbAydlvl0vHyAzqJYaN6W+jQBz8c1WjpN0m0SjpG+yLHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610556254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3lktWn95asAPBOJ45VL7o2mFHW8GNuSfujEYucsY3QE=;
        b=QRgsFmJ4hEGBa3F++PiF6ZVh75IT0kmBiPY1mi8jCxqldber5JmBcODKmV9T9ucf6VLkOA
        9LZmMED4KIHe6tDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: fix kmsg_dump_get_buffer length calulations
Date:   Wed, 13 Jan 2021 17:50:13 +0106
Message-Id: <20210113164413.1599-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_get_buffer() uses @syslog to determine if the syslog
prefix should be written to the buffer. However, when calculating
the maximum number of records that can fit into the buffer, it
always counts the bytes from the syslog prefix.

Use @syslog when calculating the maximum number of records that can
fit into the buffer.

Fixes: e2ae715d66bf ("kmsg - kmsg_dump() use iterator to receive log buffer content")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ffdd0dc7ec6d..848b56efc9d7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3427,7 +3427,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (prb_read_valid_info(prb, seq, &info, &line_count)) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
-		l += get_record_print_text_size(&info, line_count, true, time);
+		l += get_record_print_text_size(&info, line_count, syslog, time);
 		seq = r.info->seq + 1;
 	}
 
@@ -3437,7 +3437,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 						&info, &line_count)) {
 		if (r.info->seq >= dumper->next_seq)
 			break;
-		l -= get_record_print_text_size(&info, line_count, true, time);
+		l -= get_record_print_text_size(&info, line_count, syslog, time);
 		seq = r.info->seq + 1;
 	}
 
-- 
2.20.1

