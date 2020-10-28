Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2829D427
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgJ1Vt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgJ1Vt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:49:27 -0400
Date:   Wed, 28 Oct 2020 19:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603908648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AO50ZlsNOKzgistJGx8rcx0DCrsMMCg9sIqOnldD5ak=;
        b=c+7LLYT+6bET4Jh3v/Djkuc3IXM2E2Nsz9UnXbljNFEi09zF+SPZeoyJYf6QzBkTq6xBxj
        STBP1/0WYjPPDFB52Ch86tCSCkP1mBtDdIQplUbech8mTbekmNwMYEz5+iKQ/s9mdjJF6t
        15JDaKKimcCOEx19eCLJvjWYVA9XDR7RDQtHEQIF+1AXfF30fDfaiWqCy63PBaB7hEESe/
        JstpG3mgOflfRDkglCstELRNf8SYgfd/uGXFRZkX38wPU1V1hTDi1ZkGeLNd5irD2WIqh2
        bI3bAmVA2RGxJFEopFc7bOkKT+jFZeaRmR7leHt6KxEbbDsn/OB8WfYoM3Fe9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603908648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AO50ZlsNOKzgistJGx8rcx0DCrsMMCg9sIqOnldD5ak=;
        b=JGgrVbK89BTnWUxWgM/qbSSabb4oFR5gyUsxd+tCUkvTlxNdlNDyMm/0MeTSIbxsdkOPwp
        qG2NCzleHxM7i4Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH] lib/test_lockup: Minimum fix to get it compiled on
 PREEMPT_RT
Message-ID: <20201028181041.xyeothhkouc3p4md@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT the locks are quite different so they can't be tested as
it is done below. The alternative is to test for the waitlock within
rtmutex.

This is the bare minim to get it compiled. Problems which exist on
PREEMP_RT:
- none of the locks (spinlock_t, rwlock_t, mutex_t, rw_semaphore) may be
  acquired with disabled preemption or interrupts.
  If I read the code correct the it is possible to acquire a mutex_t with
  disabled interrupts.
  I don't know how to obtain a lock pointer. Technically they are not
  exported to userland.

- memory can not be allocated with disabled preemption or interrupts
  even with GFP_ATOMIC.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/test_lockup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index f1a020bcc763e..864554e769738 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -480,6 +480,21 @@ static int __init test_lockup_init(void)
 		return -EINVAL;
 
 #ifdef CONFIG_DEBUG_SPINLOCK
+#ifdef CONFIG_PREEMPT_RT
+	if (test_magic(lock_spinlock_ptr,
+		       offsetof(spinlock_t, lock.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwlock_ptr,
+		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_mutex_ptr,
+		       offsetof(struct mutex, lock.wait_lock.magic),
+		       SPINLOCK_MAGIC) ||
+	    test_magic(lock_rwsem_ptr,
+		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
+		       SPINLOCK_MAGIC))
+		return -EINVAL;
+#else
 	if (test_magic(lock_spinlock_ptr,
 		       offsetof(spinlock_t, rlock.magic),
 		       SPINLOCK_MAGIC) ||
@@ -493,6 +508,7 @@ static int __init test_lockup_init(void)
 		       offsetof(struct rw_semaphore, wait_lock.magic),
 		       SPINLOCK_MAGIC))
 		return -EINVAL;
+#endif
 #endif
 
 	if ((wait_state != TASK_RUNNING ||
-- 
2.28.0

