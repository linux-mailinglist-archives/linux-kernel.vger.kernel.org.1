Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BB8274571
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIVPiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIVPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0185C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:38:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNu6KmlvpGHW0KsXBSTK9VRP7pcSV7g9SWT1cxE87NM=;
        b=0NbO4bgKWakfcvejolHeuqm0Gc43C1RljvlzgF1Y+XxUXBZrnCYycKdQIBOKdqfZzMScEJ
        5RvYBNzBlhzpn+mhsCWiYKX/UvjSnSwYOogeCpPeV1sgZR7q66LP3cvACdyh59w0yXhf9v
        2Yma9T15I8aImvNpEyRoL4IXlgtbN80D0mBPO9H7cLnlxK5T0p7Cezq48BNSmwQFKi/UIF
        zP987m9d4xsJ/GMAPhV8xCuKCyQUJCVDNgcdT/Fw1FPbfovIE1NyNsx7rBzpwJ8sp5UGAr
        VgBOGBend9QJrEOe7BGGQDz9L7ioNZMgBNVJY3b6DQpPKvhr4ecoFCGFKNEDiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNu6KmlvpGHW0KsXBSTK9VRP7pcSV7g9SWT1cxE87NM=;
        b=Q9wgsfDdJBYqpuT6PpIawGiY6ix0oyrJjB3FA2rYSLjkLl8jUjhAiaLoVujORdMH7sRov8
        W0vefcYc1Lud2kCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 1/5] printk: get new seq before enabling interrupts
Date:   Tue, 22 Sep 2020 17:44:12 +0206
Message-Id: <20200922153816.5883-2-john.ogness@linutronix.de>
In-Reply-To: <20200922153816.5883-1-john.ogness@linutronix.de>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After copying all records to the dynamic ringbuffer, setup_log_buf()
checks to see if any records were dropped during the switch. However,
it needs to check before enabling interrupts since new records could
arrive in an interrupt, thus causing setup_log_buf() to erroneously
think that it had dropped messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1fe3d0cb2fe0..00bc1fce3299 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1181,12 +1181,12 @@ void __init setup_log_buf(int early)
 	 */
 	prb = &printk_rb_dynamic;
 
+	seq = prb_next_seq(&printk_rb_static) - seq;
+
 	logbuf_unlock_irqrestore(flags);
 
-	if (seq != prb_next_seq(&printk_rb_static)) {
-		pr_err("dropped %llu messages\n",
-		       prb_next_seq(&printk_rb_static) - seq);
-	}
+	if (seq)
+		pr_err("dropped %llu messages\n", seq);
 
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
 	pr_info("early log buf free: %u(%u%%)\n",
-- 
2.20.1

