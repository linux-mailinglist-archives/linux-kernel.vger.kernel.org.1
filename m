Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD92AD570
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgKJLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKJLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:39:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:39:02 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3oeOkLLouVbqqGfVcpW+lYSuKMG6m519p+FAwlNDqw=;
        b=0UVx1N9CIToUCWKTDynWeVc8LeP7lq+NrVHnfF644Q42x2mrOpLBBTyU+nIjFJaKRo63c6
        qHuWi1uqW6oX2HKp6mXfSXFFYrd0853G11QhMjZXrw9v8vuwYKTvJOs1G+OIJY0oQ0n3I7
        39O2mX5mxZ6RZm2t9Ff8tfEylhVDih25VdZP6FtJsa8aasuJW7ed53eKCnvWwACGoJJ8T/
        gyn/mD+Rz+ebp1iftZK7UTGnqvlIU6HGJihxrPnF6luaUiaogA1D2ZEBVb9DhwWRdDHyDw
        YeekiztxNTwNsh1waRryP7iYcWjjXmyCXxrKxKIbUwdyGl2SF0yC0nEn1M/RXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3oeOkLLouVbqqGfVcpW+lYSuKMG6m519p+FAwlNDqw=;
        b=XW/ut54LbVh1kcCx9R8d0XzGnCnerc9k2me/IIV+b+LGBpqc0Nb3rsE/HQevx4lImS+X8j
        ndbZ6KQnfwBuoAAA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] genirq: Move prio assignment into the newly created thread
Date:   Tue, 10 Nov 2020 12:38:48 +0100
Message-Id: <20201110113848.801379-3-bigeasy@linutronix.de>
In-Reply-To: <20201110113848.801379-1-bigeasy@linutronix.de>
References: <20201110113848.801379-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

With enabled threaded interrupts the nouveau driver reported the
following:
| Chain exists of:
|   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
|
|  Possible unsafe locking scenario:
|
|        CPU0                    CPU1
|        ----                    ----
|   lock(&cpuset_rwsem);
|                                lock(&device->mutex);
|                                lock(&cpuset_rwsem);
|   lock(&mm->mmap_lock#2);

The device->mutex is nvkm_device::mutex.

Unblocking the lockchain at `cpuset_rwsem' is probably the easiest thing
to do.
Move the priority assignment to the start of the newly created thread.

Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset an=
d __sched_setscheduler()")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: Patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.ca=
mel@gmx.de
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006e..079688d122a70 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1155,6 +1155,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
=20
+	sched_set_fifo(current);
+
 	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
 					&action->thread_flags))
 		handler_fn =3D irq_forced_thread_fn;
@@ -1320,8 +1322,6 @@ setup_irq_thread(struct irqaction *new, unsigned int =
irq, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
=20
-	sched_set_fifo(t);
-
 	/*
 	 * We keep the reference to the task struct even if
 	 * the thread dies to avoid that the interrupt code
--=20
2.29.2

