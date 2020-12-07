Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19FB2D1D32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgLGWVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgLGWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:21:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64705C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:20:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607379621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAfcZmWOM842kq7Iv7jjX5gIZPUwOVLjWIPUr+d73xg=;
        b=CdXmMpVB/h3WuEaRiyKwfND0YGSif9UUBKfBsqIN0/E3oruQz1FByS6zSxD7C5+PaXZ/Un
        KFQZAMoUrzioRwGplHCTe2sixytBiZSmngPu4BW1e91kyQ7q7/nEPJZ7vtI+s/sC6Z5CKU
        1Stuum9Fz3ujAbJVgwh8WS936gvx4DAWAZf99owWAm5GJpWQo/FS/00NpS5zTmTpzddsWg
        TcM5pJd0Yqlx0DUiACRMKnzjYSScqg4MkZdVjTLgLp28kK2KtsTSkWbIfJBGCXLX/K8XGe
        q5tdPn+UhAvO729yW78UPH2FktYeFakQYokEZ12RSMkYi4bhwW+6tDJqbI1TgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607379621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LAfcZmWOM842kq7Iv7jjX5gIZPUwOVLjWIPUr+d73xg=;
        b=ucurhlXw1ar7V6YqelWG0n2roSwjpN9Ir5l28JenAe8PbNnwm2+gMzNXAAtF9rBOZedjYM
        4joGCcIK4CrkVGCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 0/3] printk: remove logbuf_lock protection of ringbuffer
Date:   Mon,  7 Dec 2020 23:26:17 +0106
Message-Id: <20201207222020.2923-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v3 of the series to remove logbuf_lock. v2 is
here[0]. Rather than completely removing logbuf_lock, this
version only removes logbuf_lock usage protecting the
ringbuffer. I have tried to keep the changes minimal so that
we can feel comfortable for the upcoming 5.11 merge window.

Although small, this series is significant because it allows
printk callers direct lockless access to the ringbuffer and
it replaces the use of a temporary static sprint buffer with
sprint'ing directly to the reserved ringbuffer data block.

The other changes from v2 (recursion limiting, introduction
of syslog_lock, using clear_seq as seqcount_latch, and full
removal of logbuf_lock) will be included in a later series,
which may or may not make the 5.11 merge window.

This series is based on next-20201207.

John Ogness

[0] https://lkml.kernel.org/r/20201201205341.3871-1-john.ogness@linutronix.de

John Ogness (3):
  printk: inline log_output(),log_store() in vprintk_store()
  printk: define CONSOLE_LOG_MAX in printk.h
  printk: remove logbuf_lock protection for ringbuffer

 include/linux/printk.h      |   1 +
 kernel/printk/printk.c      | 248 +++++++++++++++++++++---------------
 kernel/printk/printk_safe.c |  18 +--
 3 files changed, 149 insertions(+), 118 deletions(-)

-- 
2.20.1

