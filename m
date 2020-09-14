Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFCC2688BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgINJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:48:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:48:06 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600076884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ8xDT57l3kwK2JVOXn5PnNSsbbW0bh9ktoeIeY6kgo=;
        b=eiXc1W6vbu/JFngSIfH0w0yMSzFgS6T46vTOjqOGHkfUmoV0CaDd71RI0dLpkzh4lj93YD
        ljxU0exxynLXwkIGWtY9yEtclE+q5LsKlAnLJYZevS6LbBCRnewIMCDB20u4MvXJ0Kkmq5
        HTN38OgZEf1NIH3rgoRZa/CQgMkDPdkS7P4Q21XfXeO2mjTbd3OKIWGEXfZaM/mrjONESf
        7mDcbNUfygsF9sWILTjQN4LI3FsGVwP+v+0Sg2ldCpYaQ4+bchBhvuWdoovOGixIh8/FPl
        raCPEaHghVHNR0+gN9DHKrkNyQ2JQBxSLWmR0ovcViVMVoQrSFf7Eh4t2bok7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600076884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZ8xDT57l3kwK2JVOXn5PnNSsbbW0bh9ktoeIeY6kgo=;
        b=Oj8e2RPZzIYT/efsN2TTr7rDQjiYlbb/X5HIDpJA5Y5PfSrMOf3H1CWwcl4yW782kOAMvr
        TKtajiPD1tXuriAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] printk: ringbuffer: avoid memcpy() on state_var
Date:   Mon, 14 Sep 2020 11:54:03 +0206
Message-Id: <20200914094803.27365-2-john.ogness@linutronix.de>
In-Reply-To: <20200914094803.27365-1-john.ogness@linutronix.de>
References: <20200914094803.27365-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@state_var is copied as part of the descriptor copying via
memcpy(). This is not allowed because @state_var is an atomic type,
which in some implementations may contain a spinlock.

Avoid using memcpy() with @state_var by explicitly copying the other
fields of the descriptor. @state_var is set using atomic set
operator before returning.

Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 88f7dd4cb0c1..11b860ad5264 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -412,9 +412,14 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 
 	/*
 	 * Copy the descriptor data. The data is not valid until the
-	 * state has been re-checked.
+	 * state has been re-checked. A memcpy() for all of @desc
+	 * cannot be used because of the atomic_t @state_var field.
 	 */
-	memcpy(desc_out, desc, sizeof(*desc_out)); /* LMM(desc_read:C) */
+	memcpy(&desc_out->info, &desc->info, sizeof(desc_out->info)); /* LMM(desc_read:C) */
+	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
+	       sizeof(desc_out->text_blk_lpos)); /* also part of desc_read:C */
+	memcpy(&desc_out->dict_blk_lpos, &desc->dict_blk_lpos,
+	       sizeof(desc_out->dict_blk_lpos)); /* also part of desc_read:C */
 
 	/*
 	 * 1. Guarantee the descriptor content is loaded before re-checking
-- 
2.19.0

