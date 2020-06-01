Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120EE1EA310
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFALr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 07:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:32930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:47:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3AB25AC4A;
        Mon,  1 Jun 2020 11:47:27 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:47:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.8
Message-ID: <20200601114724.GE27273@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.8

===============================

+ Benjamin Herrenschmidt solved problem with non-matched console aliases
  by first checking consoles defined on the command line. It is more
  conservative approach than the previous attempts.

+ Benjamin also made sure that the console accessible via /dev/console
  always has CON_CONSDEV flag.

+ Andy Shevchenko added %ptT modifier for printing struct time64_t.
  It extended the existing %ptR handling for struct rtc_time.

+ Bruno Meneguele fixed /dev/kmsg error value returned by unsupported SEEK_CUR.

+ Tetsuo Handa removed unused pr_cont_once().

+ And few small fixes.

==============================

Some changes were originally scheduled already for 5.7. I did not send them
because of non-working hands. We have switched to printk/linux.git with
shared write access to avoid such delays in the future.


----------------------------------------------------------------
Andy Shevchenko (4):
      lib/vsprintf: update comment about simple_strto<foo>() functions
      lib/vsprintf: Print time64_t in human readable format
      ARM: bcm2835: Switch to use %ptT
      usb: pulse8-cec: Switch to use %ptT

Benjamin Herrenschmidt (3):
      printk: Move console matching logic into a separate function
      printk: Fix preferred console selection with multiple matches
      printk: Correctly set CON_CONSDEV even when preferred console was not registered

Bruno Meneguele (1):
      kernel/printk: add kmsg SEEK_CUR handling

Ethon Paul (1):
      printk: Fix a typo in comment "interator"->"iterator"

Nathan Chancellor (1):
      printk: Convert a use of sprintf to snprintf in console_unlock

Petr Mladek (3):
      Merge branch 'for-5.7-preferred-console' into for-linus
      Merge branch 'for-5.8' into for-linus
      Merge branch 'for-5.8-printf-time64_t' into for-linus

Shreyas Joshi (1):
      printk: handle blank console arguments passed in.

Tetsuo Handa (1):
      printk: Remove pr_cont_once()

 Documentation/ABI/testing/dev-kmsg        |   5 ++
 Documentation/core-api/printk-formats.rst |  22 ++---
 drivers/firmware/raspberrypi.c            |  12 +--
 drivers/media/usb/pulse8-cec/pulse8-cec.c |   6 +-
 include/linux/console.h                   |   2 +-
 include/linux/printk.h                    |   3 +-
 kernel/printk/console_cmdline.h           |   1 +
 kernel/printk/printk.c                    | 145 ++++++++++++++++++++----------
 lib/test_printf.c                         |  13 ++-
 lib/vsprintf.c                            |  39 ++++++--
 10 files changed, 163 insertions(+), 85 deletions(-)
