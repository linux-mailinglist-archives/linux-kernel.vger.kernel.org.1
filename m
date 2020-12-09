Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A422D37EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgLIApg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:45:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgLIApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:45:36 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607474693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ae9uzxlxHpW5A/C82t4ibLw8BtYB7x7/rGLRuHPYU60=;
        b=oP1C51DBdC+gY7X9SubEpdM7I+lgKs52bQDUaK8JXi+O6DqeVn4dpXG5ZiWOcH/Eforo28
        RcqhBmE6FKtnSUFSGuQNyj8OjPPxwBYS9RtgnOIseqiAL+qjN1KGq4ihAB85b9myyy0s2i
        bZnU/Ti0ot6jNAhsxxEiqdX9CjL9bb2LN1XcOULGvQHMMLYcE7E0FF4WPn0n1wqSF1rI2f
        Ewy83uGV36XVCKHJZQI3FUTcFMVh+uQy2DCtSIzHbm6GfaX1HIqUVh9oLSDDaXYksHuN1i
        uGwgGTJ9aGbj8wSxyMVq/Z3a5WEj8YiZEFyEu38nSwJLQchfyFGthX37eMviiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607474693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ae9uzxlxHpW5A/C82t4ibLw8BtYB7x7/rGLRuHPYU60=;
        b=VsRjxxGEnhZN9QKRcMsKkdQP2D8sjJuQRwDGRM9n5H2dr6K0a+8QO3WNgRayG5vPNHPm0P
        NWBcFNb1PNZNYOAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 0/2] printk: remove logbuf_lock writer-protection of ringbuffer
Date:   Wed,  9 Dec 2020 01:50:51 +0106
Message-Id: <20201209004453.17720-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v4 of the series to partially remove logbuf_lock.
v3 is here[0]. This series removes logbuf_lock usage of most
ringbuffer writers. The remaining logbuf_lock users are
using the lock to synchronize other variables. These other
users will be addressed in a later series.

I have tried to keep these changes minimal so that we can feel
comfortable for the upcoming 5.11 merge window.

Although small, this series is significant because it allows
printk callers direct lockless access to the ringbuffer and
it replaces the use of a static sprint buffer with sprint'ing
directly to the reserved ringbuffer data block.

This series is based on next-20201208.

John Ogness

[0] https://lkml.kernel.org/r/20201207222020.2923-1-john.ogness@linutronix.de

John Ogness (2):
  printk: inline log_output(),log_store() in vprintk_store()
  printk: remove logbuf_lock writer-protection of ringbuffer

 kernel/printk/printk.c | 247 ++++++++++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 100 deletions(-)

-- 
2.20.1

