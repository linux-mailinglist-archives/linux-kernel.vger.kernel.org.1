Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98320274572
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIVPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgIVPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:38:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCCVgMcycqiESfhtnp0v+kLf2CKu8F8FiQ7NWkVtMBo=;
        b=uZwhRFYRj8v0Vd9rM1JFfvO+bTFu8V97oBFsYJ+PbpjDLjRvu41+hclsjGqagvOZ7O/ch6
        Udb0rKO1k+olT9ey5EASBYnMdP/yqrU5IZJ4P2pcbTqJb7smFEMKfFp9rxONf9bRx6lfje
        m2Ha3XR0/2SfRJ79vQ/2ioW3gKHwTICTd4K/9TPuDU+w2noDQz/Mn7YmDfMekkUDPpMPQY
        ZHWVrmt7T5G2p144LdXiZTtQ4RIuP88t0/Auejz/Gzcar3H41LC7zlDi2rr+p6XKKdI83k
        pRkfiEvtsfO/buj/Bip3gyGi7xUvDXMjizBtP7zgYVoKqAJZyODzVcGXnkJhNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCCVgMcycqiESfhtnp0v+kLf2CKu8F8FiQ7NWkVtMBo=;
        b=V8gofiI/fyx/zVF97kud1sB8OfqVKP69dqBfpTRj1p850+SvWvx0y1Ly8E5QcZW0CQXXSC
        EPDy/DEiTtkezHDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 2/5] printk: kmsg_dump_rewind_nolock: start from first record
Date:   Tue, 22 Sep 2020 17:44:13 +0206
Message-Id: <20200922153816.5883-3-john.ogness@linutronix.de>
In-Reply-To: <20200922153816.5883-1-john.ogness@linutronix.de>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump_rewind_nolock() accesses @clear_seq without any locking.
However, accessing this global variable requires holding
@logbuf_lock. For the _nolock() variant, start from the first record
in the ringbuffer rather than the @clear_seq record.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 00bc1fce3299..cff13b33e926 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3410,11 +3410,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
  *
- * The function is similar to kmsg_dump_rewind(), but grabs no locks.
+ * The function is similar to kmsg_dump_rewind(), but grabs no locks
+ * and starts from the oldest record rather than from @clear_seq.
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = clear_seq;
+	dumper->cur_seq = 0;
 	dumper->next_seq = prb_next_seq(prb);
 }
 
@@ -3431,7 +3432,8 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 	unsigned long flags;
 
 	logbuf_lock_irqsave(flags);
-	kmsg_dump_rewind_nolock(dumper);
+	dumper->cur_seq = clear_seq;
+	dumper->next_seq = prb_next_seq(prb);
 	logbuf_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
-- 
2.20.1

