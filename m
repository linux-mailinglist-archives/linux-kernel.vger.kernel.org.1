Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545132BBCF4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKUEOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgKUEOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605932079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=vnEZUYLC2xyGs/0aDy7v0yDibUbjWdzQbjg6281cSHk=;
        b=RAxtzyFOhZSIK7YBpPc07Y0mcVLrNfhnG2srT23WMUmhXFEcO7M8BmeUrdJPSPTpe7Vrcq
        fOQvhM8hopW4h6zrIJc5kY/P/SRZ/cQiv6nabh70RIzWuTSpEYfsGllXY81AqWL2FP9Trt
        aQR4C7Xci5jcaU7s1i0CbNTb2ebd0do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-ogjwaVmHMlKY4JSFfy4_tg-1; Fri, 20 Nov 2020 23:14:34 -0500
X-MC-Unique: ogjwaVmHMlKY4JSFfy4_tg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E817A107AD3A;
        Sat, 21 Nov 2020 04:14:32 +0000 (UTC)
Received: from llong.com (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22DCC60BD8;
        Sat, 21 Nov 2020 04:14:32 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/5] locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
Date:   Fri, 20 Nov 2020 23:14:15 -0500
Message-Id: <20201121041416.12285-5-longman@redhat.com>
In-Reply-To: <20201121041416.12285-1-longman@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwsem wakeup logic has been modified by commit d3681e269fff
("locking/rwsem: Wake up almost all readers in wait queue") to wake up
all readers in the wait queue if the first waiter is a reader. This
change was made to implement a phase-fair reader/writer lock. Once a
reader gets the lock, all the current waiting readers will be allowed
to join. Other readers that come after that will not be allowed to
prevent writer starvation.

In the case of RWSEM_WAKE_READ_OWNED, not all currently waiting readers
can be woken up if the first waiter happens to be a writer. Complete
the phase-fair logic by waking up all readers even for this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b373990fcab8..e0ad2019c518 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -404,6 +404,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
 	struct list_head wlist;
+	bool first_is_reader = true;
 
 	lockdep_assert_held(&sem->wait_lock);
 
@@ -426,7 +427,13 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			lockevent_inc(rwsem_wake_writer);
 		}
 
-		return;
+		/*
+		 * If rwsem has already been owned by reader, wake up other
+		 * readers in the wait queue even if first one is a writer.
+		 */
+		if (wake_type != RWSEM_WAKE_READ_OWNED)
+			return;
+		first_is_reader = false;
 	}
 
 	/*
@@ -520,10 +527,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	/*
-	 * When we've woken a reader, we no longer need to force writers
-	 * to give up the lock and we can clear HANDOFF.
+	 * When readers are woken, we no longer need to force writers to
+	 * give up the lock and we can clear HANDOFF unless the first
+	 * waiter is a writer.
 	 */
-	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
+	if (woken && first_is_reader &&
+	   (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
 		adjustment -= RWSEM_FLAG_HANDOFF;
 
 	if (adjustment)
@@ -1053,8 +1062,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 	if (rwsem_optimistic_spin(sem, false)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		/*
-		 * Wake up other readers in the wait list if the front
-		 * waiter is a reader.
+		 * Wake up other readers in the wait queue.
 		 */
 wake_readers:
 		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
-- 
2.18.1

