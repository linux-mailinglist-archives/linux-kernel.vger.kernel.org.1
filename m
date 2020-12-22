Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1762E1070
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgLVW5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbgLVW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608677780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=V7Cc/NanMe/ir/qcjakZDVITWKhc58yo1WDobbYxsY0=;
        b=INGaaP5km6F9Hh96t9m9av3Zwl5xy4+ix22XBevjX+XBu0p9/02TXX9oSC0q4ISCa/kkP5
        wY9e/johZ+pnwh8SIMCgx33OcbmqpRkK9uoVcKVvdb3K8wJLq1SsCUub+K7Pag9HiPIbEB
        Mv8AidQdR9GQUGlQUSJk29+c4+suGnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-GdbzA77bP-iXSv5GJlmVtQ-1; Tue, 22 Dec 2020 17:56:16 -0500
X-MC-Unique: GdbzA77bP-iXSv5GJlmVtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744BC1800D42;
        Tue, 22 Dec 2020 22:56:15 +0000 (UTC)
Received: from llong.com (ovpn-116-221.rdu2.redhat.com [10.10.116.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9373E6F985;
        Tue, 22 Dec 2020 22:56:11 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lockdep: Use local_irq_save() with call_rcu()
Date:   Tue, 22 Dec 2020 17:55:53 -0500
Message-Id: <20201222225553.15642-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following lockdep splat was hit:

 [  560.638354] WARNING: CPU: 79 PID: 27458 at kernel/rcu/tree_plugin.h:1749 call_rcu+0x6dc/0xf00
    :
 [  560.647761] RIP: 0010:call_rcu+0x6dc/0xf00
 [  560.647763] Code: 0f 8f 29 04 00 00 e8 93 da 1c 00 48 8b 3c 24 57 9d 0f 1f 44 00 00 e9 19 fa ff ff 65 8b 05 38 83 c4 49 85 c0 0f 84 cd fb ff ff <0f> 0b e9 c6 fb ff ff e8 b8 45 51 00 4c 89 f2 48 b8 00 00 00 00 00
 [  560.647764] RSP: 0018:ff11001050097b58 EFLAGS: 00010002
 [  560.647766] RAX: 0000000000000001 RBX: ffffffffbb1f3360 RCX: 0000000000000001
 [  560.647766] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb99bac9c
 [  560.647767] RBP: 1fe220020a012f73 R08: 000000010004005c R09: dffffc0000000000
 [  560.647768] R10: dffffc0000000000 R11: 0000000000000003 R12: ff1100105b7f70e1
 [  560.647769] R13: ffffffffb635d8a0 R14: ff1100105b7f72d8 R15: ff1100105b7f7040
 [  560.647770] FS:  00007fd9b3437080(0000) GS:ff1100105b600000(0000) knlGS:0000000000000000
 [  560.647771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  560.647772] CR2: 00007fd9b30112bc CR3: 000000105e898006 CR4: 0000000000761ee0
 [  560.647773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [  560.647773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [  560.647774] PKRU: 55555554
 [  560.647774] Call Trace:
 [  560.647778]  ? invoke_rcu_core+0x180/0x180
 [  560.647782]  ? __is_module_percpu_address+0xed/0x440
 [  560.647787]  lockdep_unregister_key+0x2ab/0x5b0
 [  560.647791]  destroy_workqueue+0x40b/0x610
 [  560.647862]  xlog_dealloc_log+0x216/0x2b0 [xfs]
    :

This splat is caused by the fact that lockdep_unregister_key() uses
raw_local_irq_save() which doesn't update the hardirqs_enabled
percpu flag.  The call_rcu() function, however, will call
lockdep_assert_irqs_disabled() to check the hardirqs_enabled flag which
remained set in this case.

Fix this problem by using local_irq_save()/local_irq_restore() pairs
whenever call_rcu() is being called.

I think raw_local_irq_save() function can be used if no external
function is being called except maybe printk() as it means another
lockdep problem exists.

Fixes: a0b0fd53e1e67 ("locking/lockdep: Free lock classes that are no longer in use")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1418b47f625..2a37af77ede6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5884,7 +5884,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
 
-	raw_local_irq_save(flags);
+	local_irq_save(flags);
 	lockdep_lock();
 
 	/* closed head */
@@ -5898,7 +5898,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
 	lockdep_unlock();
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -5941,13 +5941,13 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 
 	init_data_structures_once();
 
-	raw_local_irq_save(flags);
+	local_irq_save(flags);
 	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
 	lockdep_unlock();
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 
 	/*
 	 * Wait for any possible iterators from look_up_lock_class() to pass
@@ -6043,7 +6043,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	unsigned long flags;
 	int locked;
 
-	raw_local_irq_save(flags);
+	local_irq_save(flags);
 	locked = graph_lock();
 	if (!locked)
 		goto out_irq;
@@ -6054,7 +6054,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
 	graph_unlock();
 out_irq:
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -6098,7 +6098,11 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 
-	raw_local_irq_save(flags);
+	/*
+	 * local_irq_save() should be used as call_rcu() will check
+	 * hardirqs_enabled state.
+	 */
+	local_irq_save(flags);
 	if (!graph_lock())
 		goto out_irq;
 
@@ -6115,7 +6119,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	call_rcu_zapped(pf);
 	graph_unlock();
 out_irq:
-	raw_local_irq_restore(flags);
+	local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
-- 
2.18.1

