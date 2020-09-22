Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289AF27456F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVPiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIVPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB63C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:38:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C3xWt4Ci5igCgIFK/Nm1a3v2HdT6L5CdsmqX9DuinYQ=;
        b=jaaJudmC5kYdzw9HUY0OXheMijFTaIb9HTccF0umU4XQ03mFWKXGM/a5fx+P0mxsvjSkhZ
        CkxwVpM5jgUdAPblfIXkCd37h7lfVyGYxH0ar4GrGoqdM1mmB4Navc6JckqBt3PJdz8QNG
        CDcU9aXelOaPETJoVU2ELMRJJ9rs48TyTioqOI4xyVdLiVXEkr91zO9UWJVjvLGPzZgNRB
        OCn91ZHY9FbUiybYmtFJgWUW/LyQwycWaAiCC5wyS+nD/m2LLxCt5JF8SlZc1SNXdIsShU
        Cg4+HnoCYJ7Dh5oyrRRiZIC7pQyJYrHxV/HqLcFhzas/14QPpwRdFEq7G9V4xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C3xWt4Ci5igCgIFK/Nm1a3v2HdT6L5CdsmqX9DuinYQ=;
        b=5gN8aBAEU4T3tAYBz9rWMhvE9xBAjH3XwimkVrEDMuQY5POaFJLj/WDKL0skNBbuUUlDfs
        /8Yp0vtbdNO1+JDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 0/5] printk: remove logbuf_lock
Date:   Tue, 22 Sep 2020 17:44:11 +0206
Message-Id: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the next series for the printk-rework to remove
@logbuf_lock. Since this lock protected more than just the
ringbuffer, a new finer-grained @syslog_lock is introduced.

With this series, vprintk_store() is lockless.

A consequence of this locklessness is that a different method
for using temporary sprint space was needed. A DIY memory
buffer pool has been implemented for this. Since printk is
used before per-cpu variables are available, I felt that this
was the simplest approach. Feel free to throw tomatoes at me
if another approach should be taken. (And please suggest that
other approach.)

Also as a consequence of a lockless vprintk_store() is that
there is no longer a need for the NMI safe buffers. They are
also removed. The safe buffers for printk recursion are still
used.

This series falls in line with the printk-rework plan as
presented [0] at Linux Plumbers in Lisbon 2019.

The series is based on the printk-rework branch of the printk
git tree:

f35efc78add6 ("printk: remove dict ring")

John Ogness

[0] https://linuxplumbersconf.org/event/4/contributions/290/attachments/276/463/lpc2019_jogness_printk.pdf (slide 23)

John Ogness (5):
  printk: get new seq before enabling interrupts
  printk: kmsg_dump_rewind_nolock: start from first record
  printk: use buffer pool for sprint buffers
  printk: remove logbuf_lock, add syslog_lock
  printk: remove nmi safe buffers

 kernel/printk/internal.h    |   4 +-
 kernel/printk/printk.c      | 320 ++++++++++++++++++++++++------------
 kernel/printk/printk_safe.c |  64 +-------
 3 files changed, 218 insertions(+), 170 deletions(-)

-- 
2.20.1

