Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144951C1071
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgEAJkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728365AbgEAJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:40:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A47C08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:40:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jUS9k-00038k-Tk; Fri, 01 May 2020 11:40:29 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] printk: replace ringbuffer
Date:   Fri,  1 May 2020 11:46:07 +0206
Message-Id: <20200501094010.17694-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v2 for the first series to rework the printk subsystem. The
v1 and history are here [0]. This first series only replaces the
existing ringbuffer implementation. No locking is removed. No
semantics/behavior of printk are changed.

The VMCOREINFO is updated. RFC patches for the external tools
crash(8) [1] and makedumpfile(8) [2] have been submitted that allow
the new ringbuffer to be correctly read.

This series is in line with the agreements [3] made at the meeting
during LPC2019 in Lisbon, with 1 exception: support for dictionaries
will not be discontinued [4]. Dictionaries are stored in a separate
buffer so that they cannot interfere with the human-readable buffer.

The list of changes since v1:

printk_ringbuffer
=================
- documentation formatting/wording cleanup
- main memory barrier comments moved from memory accesses to
  memory barriers
- remove all symbol exporting of printk_ringbuffer functions
- add prb_count_lines() for line counting so printk.c can also use
  this functionality
- add prb_read_valid_info() to just read record meta-data
- remove @line_count out of printk_record (there is now an interface
  for line counting)
- to_block(): remove intermediate (char *) typecast
- data_alloc(): use WRITE_ONCE for writing block ID
- data_push_tail(): fix test condition for tail LPOS already pushed
- data_push_tail(): continue loop rather than try cmpxchg() if
  tail LPOS was pushed
- data_push_tail(): add memory barrier before pushing tail LPOS so
  readers can recognize if data has expired while reading the
  descriptor
- data_make_reusable(): added memory barrier and logic to protect
  against invalid read of block ID
- data_alloc(): add memory barrier to guarantee the tail ID is stored
  before updating the block ID
- desc_reserve(): add memory barrier before checking ID to make sure
  the head ID is read before the tail ID
- desc_reserve(): move memory barrier to before the head ID is pushed
  to guarantee the tail ID is stored before the head ID

printk.c
========
- remove static syslog_record/console_record (use dynamic allocation
  and in-place buffer manipulation instead)
- reduce expected average message size from 64 to 32
- add printk_record initializers to simplify reader and writer code
- fix wrong return value when log_store() truncates
- add full VMCOREINFO needed by makedumpfile(8)
- change record_print_text() to add prefix data to the buffer
  in-place instead of requiring a 2nd buffer
- add helper to calculate text size when prefix added:
  get_record_text_size() (used together with prb_count_lines() or
  prb_read_valid_info() to get full text size, rather than abusing
  record_print_text() for this purpose)
- syslog_print_all(): fix missing break if copy_to_user() failed
- moved "messages dropped" printing to call_console_drivers()

John Ogness

[0] https://lkml.kernel.org/r/20200128161948.8524-1-john.ogness@linutronix.de
[1] https://www.redhat.com/archives/crash-utility/2020-April/msg00080.html
[2] https://lists.infradead.org/pipermail/kexec/2020-April/024906.html
[3] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
[4] https://lkml.kernel.org/r/20191007120134.ciywr3wale4gxa6v@pathway.suse.cz

John Ogness (3):
  crash: add VMCOREINFO macro for anonymous structs
  printk: add lockless buffer
  printk: use the lockless ringbuffer

 include/linux/crash_core.h        |    3 +
 include/linux/kmsg_dump.h         |    2 -
 kernel/printk/Makefile            |    1 +
 kernel/printk/printk.c            |  938 +++++++++--------
 kernel/printk/printk_ringbuffer.c | 1626 +++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h |  369 +++++++
 6 files changed, 2491 insertions(+), 448 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

-- 
2.20.1

