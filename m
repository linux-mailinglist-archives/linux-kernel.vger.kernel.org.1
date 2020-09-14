Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F62688BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgINJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgINJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A653C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:48:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600076883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGiB2FPFcaHsJ8i8JedzfeevufBh2uLkpUuv6GcGZMo=;
        b=q9GqdbAaFsIC40aPgHPualmtFw7Thk2mPSXN6GJYLzTzCGU48DIe27cYgTaMSDM3obntcj
        a99SxVZ9nUA+nHoLbVB1GDtVi3lyboF4rfiQC6iqFD76xbrvO9L29J+VM5yHzvkih14EDB
        xwnQ6XvpYjMa+TZZbt+jVp5kz6eUhEpX93/i975oO2Ef0IcNrTXpEqr3xAqkHnPGTsFSSi
        0GiYJwMzMJe9zgbiWOTKVeXsbKct6Av4+Aygui4YMn4XcokaesYeR+iPy4fosc/yLBolfY
        Wv53NA230Mv9ug67hEqcnyeU+pMM+NV+xTNv2rKdvOJVrugg23ELON2D0qSocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600076883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xGiB2FPFcaHsJ8i8JedzfeevufBh2uLkpUuv6GcGZMo=;
        b=4o7QVecD4yvJxtOhZDd+jN0/uBe7mkTid420Cs7841KXvYlBHatdLj7AfBlfB0HpkyVj0p
        3M0CcZPRmTW8wwBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] printk: ringbuffer: fix setting state in desc_read()
Date:   Mon, 14 Sep 2020 11:54:02 +0206
Message-Id: <20200914094803.27365-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that desc_read() will always set at least the
@state_var field. However, if the descriptor is in an inconsistent
state, no fields are set.

Also, the second load of @state_var is not stored in @desc_out and
so might not match the state value that is returned.

Always set the last loaded @state_var into @desc_out, regardless of
the descriptor consistency.

Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 0659b50872b5..88f7dd4cb0c1 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -368,9 +368,9 @@ static enum desc_state get_desc_state(unsigned long id,
 }
 
 /*
- * Get a copy of a specified descriptor and its queried state. A descriptor
- * that is not in the committed or reusable state must be considered garbage
- * by the reader.
+ * Get a copy of a specified descriptor and return its queried state. If the
+ * descriptor is in an inconsistent state (miss or reserved), the caller can
+ * only expect the descriptor's @state_var field to be valid.
  */
 static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 				 unsigned long id, struct prb_desc *desc_out)
@@ -383,8 +383,14 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	/* Check the descriptor state. */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:A) */
 	d_state = get_desc_state(id, state_val);
-	if (d_state != desc_committed && d_state != desc_reusable)
-		return d_state;
+	if (d_state == desc_miss || d_state == desc_reserved) {
+		/*
+		 * The descriptor is in an inconsistent state. Set at least
+		 * @state_var so that the caller can see the details of
+		 * the inconsistent state.
+		 */
+		goto out;
+	}
 
 	/*
 	 * Guarantee the state is loaded before copying the descriptor
@@ -449,9 +455,15 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 */
 	smp_rmb(); /* LMM(desc_read:D) */
 
-	/* Re-check the descriptor state. */
+	/*
+	 * The data has been copied. Return the current descriptor state,
+	 * which may have changed since the load above.
+	 */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:E) */
-	return get_desc_state(id, state_val);
+	d_state = get_desc_state(id, state_val);
+out:
+	atomic_long_set(&desc_out->state_var, state_val);
+	return d_state;
 }
 
 /*
-- 
2.19.0

