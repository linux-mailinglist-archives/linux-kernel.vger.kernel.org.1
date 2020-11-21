Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83C42BBCF3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKUEOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:14:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgKUEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605932075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kgixr/oMk3balv7uJBJGiQ4W+lRjKloXOaf9fFYf5eI=;
        b=LslS0ynDLQUsMkYl5VyrWq+E2PMfwSfePwENA1QvaFkzdRG23YLo5p5ESyldm57vyVRnLe
        jz8RTIFkhFQmaNx8Fpj1qemHqw3n+r4MyrDMKoGl+EE2rWVncYUc3pSQk9x1lD00SOHXb8
        IIpq2sb1Ftzpgp6VRd6Z7dqHJjYo7+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-RxkqTAvZPnynDemglKXvzg-1; Fri, 20 Nov 2020 23:14:33 -0500
X-MC-Unique: RxkqTAvZPnynDemglKXvzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10881DDE7;
        Sat, 21 Nov 2020 04:14:31 +0000 (UTC)
Received: from llong.com (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E54D9CA0;
        Sat, 21 Nov 2020 04:14:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/5] locking/rwsem: Enable reader optimistic lock stealing
Date:   Fri, 20 Nov 2020 23:14:14 -0500
Message-Id: <20201121041416.12285-4-longman@redhat.com>
In-Reply-To: <20201121041416.12285-1-longman@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the optimistic spinning queue is empty and the rwsem does not have
the handoff or write-lock bits set, it is actually not necessary to
call rwsem_optimistic_spin() to spin on it. Instead, it can steal the
lock directly as its reader bias is in the count already.  If it is
the first reader in this state, it will try to wake up other readers
in the wait queue.

With this patch applied, the following were the lock event counts
after rebooting a 2-socket system and a "make -j96" kernel rebuild.

  rwsem_opt_rlock=4437
  rwsem_rlock=29
  rwsem_rlock_steal=19

So lock stealing represents about 0.4% of all the read locks acquired
in the slow path.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..270a0d351932 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -63,6 +63,7 @@ LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
 LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
 LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
 LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index a961c5c53b70..b373990fcab8 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -957,6 +957,12 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	}
 	return false;
 }
+
+static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
+{
+	return !osq_is_locked(&sem->osq);
+}
+
 #else
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 					   unsigned long nonspinnable)
@@ -977,6 +983,11 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	return false;
 }
 
+static inline bool rwsem_no_spinners(sem)
+{
+	return false;
+}
+
 static inline int
 rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 {
@@ -1007,6 +1018,22 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 	   !(count & RWSEM_WRITER_LOCKED))
 		goto queue;
 
+	/*
+	 * Reader optimistic lock stealing
+	 *
+	 * We can take the read lock directly without doing
+	 * rwsem_optimistic_spin() if the conditions are right.
+	 * Also wake up other readers if it is the first reader.
+	 */
+	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
+	    rwsem_no_spinners(sem)) {
+		rwsem_set_reader_owned(sem);
+		lockevent_inc(rwsem_rlock_steal);
+		if (rcnt == 1)
+			goto wake_readers;
+		return sem;
+	}
+
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
@@ -1029,6 +1056,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 		 * Wake up other readers in the wait list if the front
 		 * waiter is a reader.
 		 */
+wake_readers:
 		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
-- 
2.18.1

