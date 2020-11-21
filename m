Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB02BBCF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgKUEOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgKUEOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605932074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZUL8orKAEpAzaSF4r0ktk6KgtJ/ngdVfWUObCmncbxA=;
        b=ZdMhkq/Ols7ViVJOaS6etCMgq+K5Xjf8qumOrC1T9jQSyubtymWyHCgUcuEvyavmP6PZW9
        /SoUjDSbpYRyS1+ngZfzA97Zs1Fw7IFmNGghAgXnxFVbF4uluddqNweKPcUeEr5vkbDAD5
        wOOzgQhwIq7pORkASttp1p25dvZcsIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-5_FF4mBkOEmaDg55osem7w-1; Fri, 20 Nov 2020 23:14:32 -0500
X-MC-Unique: 5_FF4mBkOEmaDg55osem7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07B588049C8;
        Sat, 21 Nov 2020 04:14:31 +0000 (UTC)
Received: from llong.com (ovpn-119-225.rdu2.redhat.com [10.10.119.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34A4460BD8;
        Sat, 21 Nov 2020 04:14:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/5] locking/rwsem: Prevent potential lock starvation
Date:   Fri, 20 Nov 2020 23:14:13 -0500
Message-Id: <20201121041416.12285-3-longman@redhat.com>
In-Reply-To: <20201121041416.12285-1-longman@redhat.com>
References: <20201121041416.12285-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock handoff bit is added in commit 4f23dbc1e657 ("locking/rwsem:
Implement lock handoff to prevent lock starvation") to avoid lock
starvation. However, allowing readers to do optimistic spinning does
introduce an unlikely scenario where lock starvation can happen.

The lock handoff bit may only be set when a waiter is being woken up.
In the case of reader unlock, wakeup happens only when the reader count
reaches 0. If there is a continuous stream of incoming readers acquiring
read lock via optimistic spinning, it is possible that the reader count
may never reach 0 and so the handoff bit will never be asserted.

One way to prevent this scenario from happening is to disallow optimistic
spinning if the rwsem is currently owned by readers. If the previous
or current owner is a writer, optimistic spinning will be allowed.

If the previous owner is a reader but the reader count has reached 0
before, a wakeup should have been issued. So the handoff mechanism
will be kicked in to prevent lock starvation. As a result, it should
be OK to do optimistic spinning in this case.

This patch may have some impact on reader performance as it reduces
reader optimistic spinning especially if the lock critical sections
are short the number of contending readers are small.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 12761e02ab9b..a961c5c53b70 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -991,16 +991,27 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
 {
-	long adjustment = -RWSEM_READER_BIAS;
+	long owner, adjustment = -RWSEM_READER_BIAS;
+	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 	bool wake = false;
 
+	/*
+	 * To prevent a constant stream of readers from starving a sleeping
+	 * waiter, don't attempt optimistic spinning if the lock is currently
+	 * owned by readers.
+	 */
+	owner = atomic_long_read(&sem->owner);
+	if ((owner & RWSEM_READER_OWNED) && (rcnt > 1) &&
+	   !(count & RWSEM_WRITER_LOCKED))
+		goto queue;
+
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
 	 */
-	waiter.last_rowner = atomic_long_read(&sem->owner);
+	waiter.last_rowner = owner;
 	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
 		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
 
-- 
2.18.1

