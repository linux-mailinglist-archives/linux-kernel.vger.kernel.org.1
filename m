Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4A2AD6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgKJMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:50:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:57042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbgKJMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:50:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605012614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AyasKoO398SHHadIhPXYPxCl+JwOOzWURsu0g0VOKG0=;
        b=aycdkPGXmUVBkKRRgCixWRxMH6aRqOsA0qlya5DnRaSsythOt9kZGU8BNNDTSBvv11Ex2u
        RtrQ6rz8JP1tyZxWq45ZLFEW83Yz3Hc3KPIWBufdIZCWqtXHY720EG3hD8JojpE1tjgDAX
        /VaIcbE61T3KyBm6BB6aBlVO5meagwY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D196ABCC;
        Tue, 10 Nov 2020 12:50:14 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com
Cc:     john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] printk: ringbuffer: Convert function argument to local variable
Date:   Tue, 10 Nov 2020 14:50:12 +0200
Message-Id: <20201110125012.353456-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

data_alloc's 2nd argument is always rb::text_data_ring and that functino
always takes a struct printk_ringbuffer. Instead of passing the data
ring buffer as an argument simply make it a local variable.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 6b1525685277..7f2713e1bbcc 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1021,10 +1021,10 @@ static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
  * if necessary. This function also associates the data block with
  * a specified descriptor.
  */
-static char *data_alloc(struct printk_ringbuffer *rb,
-			struct prb_data_ring *data_ring, unsigned int size,
+static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
 {
+	struct prb_data_ring *data_ring = &rb->text_data_ring;
 	struct prb_data_block *blk;
 	unsigned long begin_lpos;
 	unsigned long next_lpos;
@@ -1397,7 +1397,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 		if (r->text_buf_size > max_size)
 			goto fail;
 
-		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
+		r->text_buf = data_alloc(rb, r->text_buf_size,
 					 &d->text_blk_lpos, id);
 	} else {
 		if (!get_data(&rb->text_data_ring, &d->text_blk_lpos, &data_size))
@@ -1549,8 +1549,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	if (info->seq > 0)
 		desc_make_final(desc_ring, DESC_ID(id - 1));
 
-	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
-				 &d->text_blk_lpos, id);
+	r->text_buf = data_alloc(rb, r->text_buf_size, &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
 	if (r->text_buf_size && !r->text_buf) {
 		prb_commit(e);
-- 
2.25.1

