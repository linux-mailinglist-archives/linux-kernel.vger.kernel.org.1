Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60EB27960C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgIZBz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgIZBz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:55:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:55:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601085326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ebjds/y6Ik+WNL7AzXFOt7nkRoMOnpMzIAggoQnKroA=;
        b=x2meIfRHNDw+/kckISTk7U/A8YOX0VzzDVpWpTl3gUO8lkg3Azm/wBPL1G1q5XJVu+Pwpa
        3D5YsGWQOrCmSsvGrLBNveYg/oIfxAjm2WRaw1yzKnhXAo+XyiQVOt7gvFMv2y2Mi/BT4S
        7Pq39BDBzeXQChgnR4gX3cpoMjVM9qEs5r8mfD3ZFl8QdGt1Ws3wRoU+7EJn/MlG+LcddV
        OBCurhw2HoXxzhmHVfdiMPvyJE53CxEYjIuWseqMmGoY6h48Sw55gUNmW1T2v7/iiSSJQz
        5YW0drg7bNwBQMJxvQOsIo6cyd45P3Iq39Qmh0OH+yV8RoIuHPRKz5SuW4E0BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601085326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ebjds/y6Ik+WNL7AzXFOt7nkRoMOnpMzIAggoQnKroA=;
        b=mgVGX0lsSO7osOM1MIKxUKCX3IQACLSQqLfrkPI41clKQ3taH4ifjpYm/Po+RAScw3EUfN
        45qOUVd7QmDWJ0DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 0/2] printk: fix reading beyond buffer
Date:   Sat, 26 Sep 2020 04:01:24 +0206
Message-Id: <20200926015526.8921-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Marek Szyprowski reported [0] a problem with a particular printk
usage. This particular usage performs thousands of LOG_CONT calls.
The printk.c implementation was only limiting the growing record by
the maximum size available in the ringbuffer, thus creating a record
that was several kilobytes in size. This in and of itself is not
a problem.

However, the various readers used buffers that were about 1KB in
size. The ringbuffer would only fill the reader's 1KB buffer, but the
meta data stated that the message was actually much larger. The
reader code was not checking this and assumed its buffer contained
the full message.

I have solved this problem by adding the necessary check to the
functions where the situation can occur and also adding an argument
when extending records so that a maximum size is specified. This
will prevent the records from growing beyond the size that we know
our readers are using.

I did not add the check where it is certain that the reader's
buffer is large enough to contain the largest possible message.

The 2nd patch in this series reduces the size of the initial setup
buffer. I noticed it was too big while verifying all the sizes for
this series.

John Ogness

[0] https://lkml.kernel.org/r/f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com

John Ogness (2):
  printk: avoid and/or handle record truncation
  printk: reduce setup_text_buf size to LOG_LINE_MAX

 kernel/printk/printk.c            |  9 +++++++--
 kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
 kernel/printk/printk_ringbuffer.h |  2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.20.1

