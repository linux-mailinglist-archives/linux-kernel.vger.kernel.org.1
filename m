Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC8302868
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAYRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:05:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:52260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbhAYREa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:04:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611585750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=6j41zuwZS4U0/a6eaue4VCJ3fLIyOlwf1H3oBhd/Kxk=;
        b=Uo774o+ySnauq746Z6FeFgdByl7SOvzucyh0Bzd8mq0CHiOO+/cwjNUrucBEP30kZPRYOK
        1s20sFZ6OdFC5/lCtZnBtKxW+j1P7eovQl1nfyv5DMRa1G4VVV3goR9AlRVlARft/ltX08
        RKEX6jYVc2NMkVYTo+r6GqSJu2kp7ek=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3C73AD17;
        Mon, 25 Jan 2021 14:42:30 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:42:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL] printk urgent fix for 5.11-rc6
Message-ID: <YA7Y1WIjM3Oy2O7Y@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull an urgent fixup from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-urgent-fixup

===============================

- Prevent writing the trailing '\0' past the reader buffer.

===============================

The fix of a potential buffer overflow in 5.11-rc5 introduced another one.
The trailing '\0' might be written up to the message "len" past the buffer.
Fortunately, it is not that easy to hit[*].

Most readers use 1kB buffers for a single message. Typical messages fit into
the temporary buffer with enough reserve.

Also readers do not rely on the '\0'. It is related to the previous
fix. Some readers required the space for the trailing '\0'. We decided
to write it there to avoid such regressions in the future.

The most realistic victims are message dumpers using kmsg_dump_get_buffer().
They are filling the entire buffer with as many messages as possible. They
are typically used when handling panic().

The problem has been reported twice by a test suite and a robot:
https://lore.kernel.org/r/yt9dk0s48y70.fsf@linux.ibm.com
https://lore.kernel.org/r/000000000000bc67d205b9b8feb2@google.com

[*] This is not an excuse for such a mistake. We really should have caught
    it during development,review, or testing.

----------------------------------------------------------------
John Ogness (1):
      printk: fix string termination for record_print_text()

Petr Mladek (1):
      Merge branch 'printk-rework' into for-linus

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
