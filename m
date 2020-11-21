Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04D2BBCF2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKUEOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbgKUEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605932074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Km5uaO7gRr1nPX+/XjbMGoi2DLABbzIXF5OZYikrBXo=;
        b=AmZr7z02LiiyFzdz5OP+kYysizIU4eM6v/FkO4sA8V+Ohs+qkSPUZfYrDDIxIQ6MN22bbt
        tCs3sZxKmaFzW1EixvRBmt7Go1r5G+0bOWgvDozCZ7q5hEjKAMm2FDrYpUGLi9dOug4K8t
        F0kpa//L+QKY7rFWB32g+nn6EuDau0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-vs42czFfPneEUJG-nVskmg-1; Fri, 20 Nov 2020 23:14:31 -0500
X-MC-Unique: vs42czFfPneEUJG-nVskmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CC901005D68;
        Sat, 21 Nov 2020 04:14:30 +0000 (UTC)
Received: from llong.com (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF5B9CA0;
        Sat, 21 Nov 2020 04:14:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/5] locking/rwsem: Pass the current atomic count to rwsem_down_read_slowpath()
Date:   Fri, 20 Nov 2020 23:14:12 -0500
Message-Id: <20201121041416.12285-2-longman@redhat.com>
In-Reply-To: <20201121041416.12285-1-longman@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic count value right after reader count increment can be useful
to determine the rwsem state at trylock time. So the count value is
passed down to rwsem_down_read_slowpath() to be used when appropriate.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f11b9bd3431d..12761e02ab9b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -270,12 +270,12 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 					  owner | RWSEM_NONSPINNABLE));
 }
 
-static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
+static inline long rwsem_read_trylock(struct rw_semaphore *sem)
 {
 	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
 	if (WARN_ON_ONCE(cnt < 0))
 		rwsem_set_nonspinnable(sem);
-	return !(cnt & RWSEM_READ_FAILED_MASK);
+	return cnt;
 }
 
 /*
@@ -989,9 +989,9 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 	bool wake = false;
@@ -1337,8 +1337,10 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+	long count = rwsem_read_trylock(sem);
+
+	if (count & RWSEM_READ_FAILED_MASK) {
+		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, count);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
 		rwsem_set_reader_owned(sem);
@@ -1347,8 +1349,10 @@ static inline void __down_read(struct rw_semaphore *sem)
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
+	long count = rwsem_read_trylock(sem);
+
+	if (count & RWSEM_READ_FAILED_MASK) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE, count)))
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
-- 
2.18.1

