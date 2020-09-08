Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ACC26211A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIHU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:29:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIHU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:29:03 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599596941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GeMX4JSy1GZpRJplBMiAWVplasXuGz3lSGPOcXC3PA=;
        b=b2qr79h6aExdAYFHFQw/8iBomP9A/1cDYfzHRdveS11ms5JTBuCBXcHOebLFkD0Nbxrdmj
        daIbTcmqzHeCmMAfw17Imf5sF2tXJu9b+YNtfzfbuJ3esfggJ70jcKOJzfGTEJ2wANQRnQ
        1iQZFewkUq2crrYej3GG0CNDPL2EuY8cfKQotzA7T/tyrMMtF5ehf/hqR5JPMJEMWsuEto
        /vHEoqbm3mxR4xmQ6X4C+FAIv2Vp8TXR5s5uwA+gWQUV+Ap+SIGwJT03O8vNq2EfLAvoaE
        tqgQVTwgSnHwuisaOSgwsCMpNF/FPiuPJ4/+6GUfVfyotg4FxiaU5r+QeTAfTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599596941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GeMX4JSy1GZpRJplBMiAWVplasXuGz3lSGPOcXC3PA=;
        b=CU6OJr8cRk9gTMe0oCCULvXJmHo7FLPhBnSZoa+IvjoTGXgYN0E7JmxHEdS3vA1VKPwxcM
        jLzhg+JyRjiilRCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 2/6] printk: ringbuffer: add BLK_DATALESS() macro
Date:   Tue,  8 Sep 2020 22:34:55 +0206
Message-Id: <20200908202859.2736-3-john.ogness@linutronix.de>
In-Reply-To: <20200908202859.2736-1-john.ogness@linutronix.de>
References: <20200908202859.2736-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than continually needing to explicitly check @begin and @next
to identify a dataless block, introduce and use a BLK_DATALESS()
macro.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index aa6e31a27601..6ee5ebce1450 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -266,6 +266,8 @@
 
 /* Determine if a logical position refers to a data-less block. */
 #define LPOS_DATALESS(lpos)		((lpos) & 1UL)
+#define BLK_DATALESS(blk)		(LPOS_DATALESS((blk)->begin) && \
+					 LPOS_DATALESS((blk)->next))
 
 /* Get the logical position at index 0 of the current wrap. */
 #define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
@@ -1021,7 +1023,7 @@ static unsigned int space_used(struct prb_data_ring *data_ring,
 			       struct prb_data_blk_lpos *blk_lpos)
 {
 	/* Data-less blocks take no space. */
-	if (LPOS_DATALESS(blk_lpos->begin))
+	if (BLK_DATALESS(blk_lpos))
 		return 0;
 
 	if (DATA_WRAPS(data_ring, blk_lpos->begin) == DATA_WRAPS(data_ring, blk_lpos->next)) {
@@ -1054,7 +1056,7 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	struct prb_data_block *db;
 
 	/* Data-less data block description. */
-	if (LPOS_DATALESS(blk_lpos->begin) && LPOS_DATALESS(blk_lpos->next)) {
+	if (BLK_DATALESS(blk_lpos)) {
 		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
 			*data_size = 0;
 			return "";
-- 
2.20.1

