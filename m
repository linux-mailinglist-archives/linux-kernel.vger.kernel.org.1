Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5C27E470
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgI3JBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:01:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgI3JBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:01:37 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601456495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tlqOr9t8cKfu5RTznS8M2rCZNaJHuFCY6fFem8EcYU4=;
        b=nmnjyMrR6VUF65lUCLTNmG21JkKmR2N79F0LPhV2YtQdb7x2bpCzLCcEKA8HzaZhATiAWo
        paVHA5pnRE29kb9yWueKUvjL2IAfF5nx+EgAlKF+wCdGiLU6nHm0FO0AqB9xb7LrwU4xd6
        KbiNaJuZMHkcsIoHHCUnealJkXHJTuPlyWVrZtXnxOufAlvUFH0Fzi4W0MXsLTpJHXEV+a
        n8pZtLy0FdksF1eFAverarOFxiQBeiAlY9QK/gv/o40ovmSr8g3rj1HgYe86rhiZNkWGzR
        o8xkdPKhC/eazNPCK+ARxMTvoRMHpe3G+0BMTeIkTGSYebuDiU3/PgerD7P91w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601456495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tlqOr9t8cKfu5RTznS8M2rCZNaJHuFCY6fFem8EcYU4=;
        b=+p4InHoV9G4n3eNwKbHsl0uDqfvocBAfD/g5fJjeDmydyYwmZSnAF+TiErDeUUV+9e0NdC
        SiGXL/aY1CG1vLCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2 0/2] printk: fix reading beyond buffer
Date:   Wed, 30 Sep 2020 11:07:32 +0206
Message-Id: <20200930090134.8723-1-john.ogness@linutronix.de>
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

 kernel/printk/printk.c            | 11 +++++++++--
 kernel/printk/printk_ringbuffer.c | 12 ++++++++++--
 kernel/printk/printk_ringbuffer.h |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.20.1

