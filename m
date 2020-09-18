Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECD2708F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRWeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 18:34:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRWeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 18:34:23 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600468462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eFIYYxyTUqTyunlyZpTIJ11KeZ0MoMnhVr4epOoF7k0=;
        b=ChcfV/sccMNUzrZ4mfDDWwSJ8gRbTXglUscqHZJa/CgQBvhFKnw9uFLPFjNknGYrLfPUSL
        HMPXMlr11GGvHMtDp5EEIhgcoMwdWnnzONRjABvTTL52lGRYbRvnjGtNsKHUDD4o6tFKdX
        tJXvz7BE3L4xpKgTLtTcqFyzuHIhGEvB86Hn9RR0OMCbd0Z7I9Nwbv5HzXAIhMbocMOFfH
        WM921vQFuNJzL6P2uu9xnl7L8/SCYDpsk4N7wMyyWnn5+31UL5IGvF7d5BMsQMaoWywyDw
        m2EXapE2NinLzlcrL2vJSj8ZIu0oPxFG0WKViuMKwAmXsQNWZi+WtbhcQm8zTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600468462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eFIYYxyTUqTyunlyZpTIJ11KeZ0MoMnhVr4epOoF7k0=;
        b=78xMfisuuLrqYz5xDwXFgJGiUzI7hD17t2qhxTRoXrqD3Z0H897OFhjdns6Gkz6kX7mjTE
        TizsNKcCxFhjxHBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 0/3] printk: move dictionaries to meta data
Date:   Sat, 19 Sep 2020 00:40:18 +0206
Message-Id: <20200918223421.21621-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 for a series to move all existing dictionary
properties (SUBSYSTEM and DEVICE) into the meta data of a
record, thus eliminating the need for the dict ring. This
change affects how the dictionaries are stored, but does not
affect how they are presented to userspace. (v1 is here [0]).

The main purpose of the change is to address concerns [1]
about the reliability of dictionary properties as well as
allowing to efficiently expand the type and amount of
meta data available [2].

This series is based heavily on the proof of concept [3] from
Petr Mladek. (Petr, feel free to add Co-developed-by tags.)

The series is based on the printk-rework branch of the printk
git tree:

f5f022e53b87 ("printk: reimplement log_cont using record extension")

The list of changes since v1:

drivers/base/core.c
===================

- set_dev_info(): use strscpy() instead of snprintf() (thank
  you Rasmus Villemoes)

kernel/printk/printk.c
======================

- setup_log_buf(): fix cleanup in error handling

- log_buf_vmcoreinfo_setup(): add VMCOREINFO for
  struct dev_printk_info array sizes so that crash tools
  do not need to rely on property value termination

John Ogness

[0] https://lkml.kernel.org/r/20200917131644.25838-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20200904151336.GC20558@alley
[2] https://lkml.kernel.org/r/008801d684f9$43e1c140$cba543c0$@samsung.com
[3] https://lkml.kernel.org/r/20200911095035.GI3864@alley

John Ogness (3):
  printk: move printk_info into separate array
  printk: move dictionary keys to dev_printk_info
  printk: remove dict ring

 Documentation/admin-guide/kdump/gdbmacros.txt |  73 ++---
 drivers/base/core.c                           |  46 +--
 include/linux/dev_printk.h                    |   8 +
 include/linux/printk.h                        |   6 +-
 kernel/printk/internal.h                      |   4 +-
 kernel/printk/printk.c                        | 221 ++++++-------
 kernel/printk/printk_ringbuffer.c             | 292 ++++++++----------
 kernel/printk/printk_ringbuffer.h             |  95 ++----
 kernel/printk/printk_safe.c                   |   2 +-
 scripts/gdb/linux/dmesg.py                    |  16 +-
 10 files changed, 346 insertions(+), 417 deletions(-)

-- 
2.20.1

