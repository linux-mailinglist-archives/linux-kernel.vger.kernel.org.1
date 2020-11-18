Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1CF2B7488
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgKRDFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgKRDFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605668706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=BC+R55JrBQj8lQ/l07npoVOBAJzecs7/KqVicWEiAKY=;
        b=gq95q7eOWxP4oiNikWEpnC52UeSWOjaJ43enkPTRs/Yv56jZPV4kUnp/FcqbZMaQPnaeTm
        DL7tbPX/18QIpT5TrwKaWsO9XFxC9wIuW51grv6Z2v2D8jF+jR3cYobxUCeC47A67loDTA
        fV6QQPus+eGE4wcvXKOCvSFUrBN14Ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-iDUFYabPP7OL5bRpJunDnA-1; Tue, 17 Nov 2020 22:05:04 -0500
X-MC-Unique: iDUFYabPP7OL5bRpJunDnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CF36414C;
        Wed, 18 Nov 2020 03:05:03 +0000 (UTC)
Received: from llong.com (ovpn-113-17.rdu2.redhat.com [10.10.113.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D8C05C1A3;
        Wed, 18 Nov 2020 03:05:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED
Date:   Tue, 17 Nov 2020 22:04:28 -0500
Message-Id: <20201118030429.23017-5-longman@redhat.com>
In-Reply-To: <20201118030429.23017-1-longman@redhat.com>
References: <20201118030429.23017-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rwsem wakeup logic has been modified by commit d3681e269fff
("locking/rwsem: Wake up almost all readers in wait queue") to wake up
all readers in the wait queue if the first waiter is a reader. In the
case of RWSEM_WAKE_READ_OWNED, not all readers can be woken up if the
first waiter happens to be a writer. Complete the logic by waking up
all readers even for this case.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 930dd4af3639..23654e3950b5 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -426,7 +426,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			lockevent_inc(rwsem_wake_writer);
 		}
 
-		return;
+		/*
+		 * If rwsem has already been owned by reader, wake up other
+		 * readers in the wait queue even if first one is a writer.
+		 */
+		if (wake_type != RWSEM_WAKE_READ_OWNED)
+			return;
 	}
 
 	/*
@@ -1052,8 +1057,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
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

