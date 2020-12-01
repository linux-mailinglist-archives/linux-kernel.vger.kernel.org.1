Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D532CADD5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgLAUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:54:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgLAUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:54:23 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606856022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OOCNvL7SE61EO1OMfIYIJlIVPJFwHzAYHNMjWpVi6U=;
        b=j/AteXD9cZS7kdQ/qJf3bLzetr+EMv2hpbi5edVxvANuu1/gbgmur0oTWE4HgFQxigw40e
        r2tzMSY8wxdHAmVuh4zS9WL+6rYWjmy+G2Ax3oZ+gB3Pp8t5tWABIbH5QltKsjbBFZixtk
        iPBpoqvf6lzhbJXOwTk04DU975PfTTHFg9bB98NiSBbPQW1waMJPTpcGWRynDv31ti6XFD
        hRaI3z+gd8Oal6ic6WMoa4AkY+1zjYWu7vCxeU3zpSvdMIkvl5wnxvHHfITETuYVW8G+qg
        b2vD1AOFQ14z5wpXim2Pm0AVE8MBn52Y40lnZUU4A2FoCBZqHBvgAmw1JRYR8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606856022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OOCNvL7SE61EO1OMfIYIJlIVPJFwHzAYHNMjWpVi6U=;
        b=TY+rBXtAXVfppeKxJ9YNJZ+OkBqgDjfosb88+i0tBeTAm2KdvoOfhu8cb0nBpIPavGyPZ3
        5EtiEPxQatBTpYAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2 0/3] printk: remove logbuf_lock
Date:   Tue,  1 Dec 2020 21:59:38 +0106
Message-Id: <20201201205341.3871-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a v2 of the next series for the printk-rework. It
removes the @logbuf_lock. v1 is here [0]. Since this lock
protected more than just the ringbuffer, a new
finer-grained @syslog_lock is introduced.

With this series, vprintk_store() becomes lockless.

A consequence of this locklessness is that a buffer for
temporary sprint space is no longer available. To get
around this, vsnprintf() is used to determine the full
length to reserve in the ringbuffer and then the message is
directly sprint'ed to the reserved space.

Since the sprint'ed message may include syslog prefix and
newline (both of which get stripped), there will be some
bytes of wasted space per message. This space could be
reclaimed by introducing a "trimming function" to the
ringbuffer, which could reduce the size of a reserved data
block if no newer block is reserved. However, such a
function is not part of this series.

This series falls in line with the printk-rework plan as
presented [1] at Linux Plumbers in Lisbon 2019.

The series is based on next-20201201.

John Ogness

[0] https://lkml.kernel.org/r/20200922153816.5883-1-john.ogness@linutronix.de
[1] https://linuxplumbersconf.org/event/4/contributions/290/attachments/276/463/lpc2019_jogness_printk.pdf (slide 23)

John Ogness (3):
  printk: inline log_output(),log_store() in vprintk_store()
  printk: change @clear_seq to atomic64_t
  printk: remove logbuf_lock, add syslog_lock

 include/linux/printk.h      |   1 +
 kernel/printk/internal.h    |   4 +-
 kernel/printk/printk.c      | 411 ++++++++++++++++++------------------
 kernel/printk/printk_safe.c |  18 +-
 4 files changed, 212 insertions(+), 222 deletions(-)

-- 
2.20.1

