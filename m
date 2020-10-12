Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799DC28BB51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbgJLOtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:49:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387930AbgJLOtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:49:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602514157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1vRD/40cn0Mgjqxi0TGYf0IEQXZbRN0N31IatMsCpag=;
        b=S2a1EoKBYMSWt3dq6nkBQNUV/HKUFaxOj5mhHzzKlWt8K+1l1SdDg66xXmxz+0RP5T3Ly9
        TWc9qFz7r36NcamQzexjgHA8vXf5nKIZBQRcCqBD+ZHntrjAiWfJwSD7Lv2RdwuM9s0UUs
        Jdh0sedMowVtHXFPxmrPSE+MpiDT6Ms=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E823ACB0;
        Mon, 12 Oct 2020 14:49:17 +0000 (UTC)
Date:   Mon, 12 Oct 2020 16:49:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
Message-ID: <20201012144916.GB10602@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10

============================

- Fully lockless ringbuffer implementation, including the support for
  continuous lines. It will allow to store and read messages in any
  situation wihtout the risk of deadlocks and without the need
  of temporary per-CPU buffers.

  The access is still serialized by logbuf_lock. It synchronizes few more
  operations, for example, temporary buffer for formatting the message,
  syslog and kmsg_dump operations. The lock removal is being discussed
  and should be ready for the next release.

  The continuous lines are handled exactly the same way as before
  to avoid regressions in user space. It means that they are appended
  to the last message when the caller is the same. Only the last
  message can be extended.

  The data ring includes plain text of the messages. Except for
  an integer at the beginning of each message that points back
  to the descriptor ring with other metadata.

  The dictionary has to stay. journalctl uses it to filter the log.
  It allows to show messages related to a given device. The dictionary
  values are stored in the descriptor ring with the other metadata.

  This is the first part of the printk rework as discussed at Plumbers 2019,
  see https://lore.kernel.org/r/87k1acz5rx.fsf@linutronix.de. The next
  big step will be handling consoles by kthreads during the normal
  system operation. It will require special handling of situations
  when the kthreads could not get scheduled, for example, early boot,
  suspend, panic.


Other changes:

+ Add John Ogness as a reviewer for printk subsystem. He is author of
  the rework and is familiar with the code and history.

+ Fix locking in serial8250_do_startup() to prevent lockdep report.

+ Few code cleanups.


=========================

The fully lockless ringbuffer code has been tested in linux-next
since Jul 10. The pr_cont() handling has been pushed in Sep 15.
I am not aware of any regression at the moment. But of course,
there will be some. And we are ready to work on the fixes.

----------------------------------------------------------------
Andy Shevchenko (1):
      kernel.h: Move oops_in_progress to printk.h

Gustavo A. R. Silva (1):
      printk: Use fallthrough pseudo-keyword

John Ogness (22):
      crash: add VMCOREINFO macro to define offset in a struct declared by typedef
      printk: add lockless ringbuffer
      Revert "printk: lock/unlock console only for new logbuf entries"
      printk: use the lockless ringbuffer
      printk: ringbuffer: support dataless records
      printk: reduce LOG_BUF_SHIFT range for H8300
      docs: vmcoreinfo: add lockless printk ringbuffer vmcoreinfo
      scripts/gdb: add utils.read_ulong()
      scripts/gdb: update for lockless printk ringbuffer
      printk: ringbuffer: fix setting state in desc_read()
      printk: ringbuffer: avoid memcpy() on state_var
      printk: ringbuffer: relocate get_data()
      printk: ringbuffer: add BLK_DATALESS() macro
      printk: ringbuffer: clear initial reserved fields
      printk: ringbuffer: change representation of states
      printk: ringbuffer: add finalization/extension support
      printk: reimplement log_cont using record extension
      printk: move printk_info into separate array
      printk: move dictionary keys to dev_printk_info
      printk: remove dict ring
      printk: avoid and/or handle record truncation
      printk: reduce setup_text_buf size to LOG_LINE_MAX

Petr Mladek (2):
      MAINTAIERS: Add John Ogness as printk reviewer
      Merge branch 'printk-rework' into for-linus

Randy Dunlap (1):
      kernel: printk: delete repeated words in comments

Sergey Senozhatsky (1):
      serial: 8250: change lock order in serial8250_do_startup()

 Documentation/admin-guide/kdump/gdbmacros.txt  |  159 +-
 Documentation/admin-guide/kdump/vmcoreinfo.rst |  131 +-
 MAINTAINERS                                    |    1 +
 drivers/base/core.c                            |   46 +-
 drivers/tty/serial/8250/8250_port.c            |    9 +-
 include/linux/crash_core.h                     |    3 +
 include/linux/debug_locks.h                    |    2 +-
 include/linux/dev_printk.h                     |    8 +
 include/linux/kernel.h                         |    1 -
 include/linux/printk.h                         |    8 +-
 init/Kconfig                                   |    3 +-
 kernel/printk/Makefile                         |    1 +
 kernel/printk/internal.h                       |    4 +-
 kernel/printk/printk.c                         | 1153 +++++++------
 kernel/printk/printk_ringbuffer.c              | 2083 ++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h              |  382 +++++
 kernel/printk/printk_safe.c                    |    2 +-
 scripts/gdb/linux/dmesg.py                     |  147 +-
 scripts/gdb/linux/utils.py                     |    7 +
 19 files changed, 3416 insertions(+), 734 deletions(-)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h
