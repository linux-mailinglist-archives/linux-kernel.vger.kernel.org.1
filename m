Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816FA304FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhA0D2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhAZVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QouCh4sBxe4Uney6Y/oO3QyDWthD3YsxY73q7hXjmik=;
        b=H76M2jfOg6Ik3nf/7/XZovdtuvJthM7K3jywAwtQjrHSoeWJwFS5p9LS5gNoZCQ5d3ITQU
        ynp4vPNcm7Vuo4qQVX8pp6vZthudAH4dlvL9pFWzPWS+uUarHZcwlEcMdrFbpy+dw8sH8z
        rVSEIqTFNK9mSUkw/5XuExji5V47/rxhzClHcNzYnYfadADf1Wri8iFZ1vHtnlFBTJYGjb
        DKL65Xl31PXdEDxVfQQg2UEqEf93954d8NwygESHfy6bLQXD305ifZGCazIlIWYjo/mTQ9
        zR2hTI8Awonkr6AW5LMGaSJu3lD0a29uNPeoeIRF9VlXqNEXFcT3NFE5QCgUCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QouCh4sBxe4Uney6Y/oO3QyDWthD3YsxY73q7hXjmik=;
        b=I/Hy/PKA3EO91VBMdno7DgnvGGONWVwHOBPP6dDNJ4aGYda2c2fT4tWQLXRozX670GMFab
        LN6MgM1KukoUMDDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 00/12] printk: remove logbuf_lock
Date:   Tue, 26 Jan 2021 22:21:39 +0106
Message-Id: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series removes @logbuf_lock, exposing the ringbuffer locklessly
to both readers and writers. And since @logbuf_lock was protecting
much more than just the ringbuffer, this series clarifies and cleans
up the various protections using comments, lockless accessors,
atomic types, and a new finer-grained @syslog_log.

This series takes into account the feedback from [0], which was a
series that was partially merged in 5.11.

The first few patches (1-5) are general cleanups to help simplify
later patches. They probably are important enough to stand alone.

John Ogness

[0] https://lkml.kernel.org/r/20201201205341.3871-1-john.ogness@linutronix.de

John Ogness (12):
  printk: kmsg_dump: remove unused fields
  printk: refactor kmsg_dump_get_buffer()
  printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
  printk: define CONSOLE_LOG_MAX in printk.h
  printk: use seqcount_latch for clear_seq
  printk: use atomic64_t for devkmsg_user.seq
  printk: add syslog_lock
  printk: introduce a kmsg_dump iterator
  um: synchronize kmsg_dumper
  hv: synchronize kmsg_dumper
  printk: remove logbuf_lock
  printk: kmsg_dump: remove _nolock() variants

 arch/powerpc/kernel/nvram_64.c             |  12 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c |   3 +-
 arch/powerpc/xmon/xmon.c                   |   6 +-
 arch/um/kernel/kmsg_dump.c                 |  13 +-
 drivers/hv/vmbus_drv.c                     |  17 +-
 drivers/mtd/mtdoops.c                      |   5 +-
 fs/pstore/platform.c                       |   5 +-
 include/linux/kmsg_dump.h                  |  52 +--
 include/linux/printk.h                     |   1 +
 kernel/debug/kdb/kdb_main.c                |  10 +-
 kernel/printk/internal.h                   |   4 +-
 kernel/printk/printk.c                     | 427 ++++++++++-----------
 kernel/printk/printk_safe.c                |  29 +-
 13 files changed, 281 insertions(+), 303 deletions(-)

-- 
2.20.1

