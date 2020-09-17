Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE20226DCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIQNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgIQNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:17:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF0AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:16:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600348605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qqrugSgV949CdzvU7pgK3gjGPRkrAVHp23YNTmFYong=;
        b=KH4wirRGbuCkTMQqBJfaIozz94hpwkoDaQ4VbqARGKCRh7ShB+/Rye8aZwYJlspikHGlTu
        Xma7mt7fKSHq5PriwtTsQDQZrFC0ebENQ2yq0Wkipyhz/rT+7DtwHv3f7zKoAaUJNGFKD2
        YAlyBb6jQyO7gHSXf75KNtJbWVqZPfYAVM+lpGMx9xjazvcgoJFVx7wr0Us1CJu3+I2Q9M
        WrE9Lju//YSKOAF5wxWT8zMLIyc+zn73Kd5Kvc7esj+oHsHEXXpIFxRvwQKOCzeZZj62Ic
        IA0CrLmkxmE6/MGid45klq6RQINhHoSW02l3BrCIv61KKS5RPqVqquNtK5VtXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600348605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qqrugSgV949CdzvU7pgK3gjGPRkrAVHp23YNTmFYong=;
        b=xniQY8t5qTNQKqGhv4vO4a9boZ0iGYUmmJPoD1IOlz25IBCANtxtGTkCj11LmumOiuCqRh
        9Ox/QJfQtTsxJXAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH printk 0/3] printk: move dictionaries to meta data
Date:   Thu, 17 Sep 2020 15:22:41 +0206
Message-Id: <20200917131644.25838-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a series to move dictionary properties (currently only
SUBSYSTEM and DEVICE exist) into the meta data of a record,
thus eliminating the need for the dict ring. This change
affects how the dictionaries are stored, but does not affect
how they are presented to userspace.

The main purpose of the change is to address concerns [0]
about the reliability of dictionary properties as well as
allowing to efficiently expand the type and number of
properties available [1].

This series is based heavily on the proof of concept [2] from
Petr Mladek. (Petr, feel free to add Co-developed-by tags.)

The series is based on the printk-rework branch of the printk git                                          
tree:                                                                                                      
                                                                                                           
f5f022e53b87 ("printk: reimplement log_cont using record extension")

John Ogness

[0] https://lkml.kernel.org/r/20200904151336.GC20558@alley
[1] https://lkml.kernel.org/r/008801d684f9$43e1c140$cba543c0$@samsung.com
[2] https://lkml.kernel.org/r/20200911095035.GI3864@alley

John Ogness (3):
  printk: move printk_info into separate array
  printk: move dictionary keys to dev_printk_info
  printk: remove dict ring

 Documentation/admin-guide/kdump/gdbmacros.txt |  73 ++---
 drivers/base/core.c                           |  46 +--
 include/linux/dev_printk.h                    |   8 +
 include/linux/printk.h                        |   6 +-
 kernel/printk/internal.h                      |   4 +-
 kernel/printk/printk.c                        | 209 ++++++-------
 kernel/printk/printk_ringbuffer.c             | 292 ++++++++----------
 kernel/printk/printk_ringbuffer.h             |  95 ++----
 kernel/printk/printk_safe.c                   |   2 +-
 scripts/gdb/linux/dmesg.py                    |  16 +-
 10 files changed, 336 insertions(+), 415 deletions(-)

-- 
2.20.1

