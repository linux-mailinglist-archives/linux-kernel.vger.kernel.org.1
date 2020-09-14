Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69A9268B58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgINMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:43:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgINMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:34:45 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600086835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dZ5TYwH4vMZ+mXqJdNF+1k7rK0dHej1wLlZdVM4kZyw=;
        b=3CaChOKWICs0qlp/tKZ34pyt7YERhPfiHC34x/qYetE76Rr99w6od9XDEPyPuKxzG1OH/N
        hDt4JBsbA7eg856fY4oALHK/OypCJI99koOqXiRm1wMTRrv4TAZA6/tk5LI0QMSVcjjZnx
        KhukLVW1zONltGBp6v1Q0kNaWSStJ04cOoKIilbD6AFz2DmwwpzGf7MVNBY8Xe5f/Aq5P0
        faq+CJhu37RDtjikOLA8UhsNfSmPcgyqmQgXxkTz2RaJ8pfj1wAJuxPYYXKtcJuizZWipT
        1xuobCGCjSwY7SUfq/T8PKA241ABCj0HBf6yFOkpEfV5NbfNl7gmNeGFN149xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600086835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dZ5TYwH4vMZ+mXqJdNF+1k7rK0dHej1wLlZdVM4kZyw=;
        b=FKpzDBe1+FOOuXulLu2OuGuPvWiyMCYuAW2a8Zh4Lwo6p18pFjnjO2qhTd7QFb48kBHlwx
        zmBh7NMUlO91x6DA==
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
Subject: [PATCH printk v5 0/6] printk: reimplement LOG_CONT handling
Date:   Mon, 14 Sep 2020 14:39:48 +0206
Message-Id: <20200914123354.832-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v5 for the second series to rework the printk subsystem.
(The v4 is here [0].) This series implements a new ringbuffer
feature that allows the last record to be extended. Petr Mladek
provided the initial proof of concept [1] for this.

Using the record extension feature, LOG_CONT is re-implemented
in a way that exactly preserves its behavior, but avoids the
need for an extra buffer. In particular, it avoids the need for
any synchronization that such a buffer requires.

This series deviates from the agreements [2] made at the meeting
during LPC2019 in Lisbon. The test results of the v1 series,
which implemented LOG_CONT as agreed upon, showed that the
effects on existing userspace tools using /dev/kmsg (journalctl,
dmesg) were not acceptable [3].

Patch 5 introduces *four* new memory barrier pairs. Two of them
are insignificant additions (data_realloc:A/desc_read:D and
data_realloc:A/data_push_tail:B) because they are alternate path
memory barriers that exactly match the purpose and context of
the two existing memory barrier pairs they provide an alternate
path for. The other two new memory barrier pairs are significant
additions:

desc_reopen_last:A / _prb_commit:B - When reopening a descriptor,
    ensure the state transitions back to desc_reserved before
    fully trusting the descriptor data.

_prb_commit:B / desc_reserve:D - When committing a descriptor,
    ensure the state transitions to desc_committed before checking
    the head ID to see if the descriptor needs to be finalized.

The test module used to test the ringbuffer is available
here [4].

The series is based on the printk-rework branch of the printk git
tree:

e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")

The list of changes since v4:

printk_ringbuffer
=================

- desc_read(): revert setting @state_var when inconsistent (a
  separate series [5] is addressing this bug)

- desc_reserve(): use DESC_SV() when setting reserved

- data_realloc(): also do nothing if the size is the same

- prb_reserve_in_last(): adjust dataless checks/warnings to match
  the non-dataless case

- prb_reserve_in_last(): fix length modifier in warnings

- change comments about "state flags" to just talk about "states"

John Ogness

[0] https://lkml.kernel.org/r/20200908202859.2736-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200812163908.GH12903@alley
[2] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[3] https://lkml.kernel.org/r/20200811160551.GC12903@alley
[4] https://github.com/Linutronix/prb-test.git
[5] https://lkml.kernel.org/r/20200914094803.27365-1-john.ogness@linutronix.de

John Ogness (6):
  printk: ringbuffer: relocate get_data()
  printk: ringbuffer: add BLK_DATALESS() macro
  printk: ringbuffer: clear initial reserved fields
  printk: ringbuffer: change representation of states
  printk: ringbuffer: add finalization/extension support
  printk: reimplement log_cont using record extension

 Documentation/admin-guide/kdump/gdbmacros.txt |  13 +-
 kernel/printk/printk.c                        | 110 +--
 kernel/printk/printk_ringbuffer.c             | 683 ++++++++++++++----
 kernel/printk/printk_ringbuffer.h             |  35 +-
 scripts/gdb/linux/dmesg.py                    |  12 +-
 5 files changed, 615 insertions(+), 238 deletions(-)

-- 
2.20.1

