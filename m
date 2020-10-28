Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361C329D775
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgJ1WYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732908AbgJ1WY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oZiyvKbthkSVXmetaH/Tg/ylLfcMHsx8WKqlppb05Vw=;
        b=dysoh9f5dGKTtEw2I0z+WFgnPROOLwiNKbP9UwQDR5aiJSlxEOsrM3PrOPVecKRjm0msLl
        0XWuaV2hugxpg4nePSEaJ5cbCVXUt26tdFmRUMEcP3U0rFu36NxhBr0MZXpQUtERRHiUkK
        PMTwB5+/2OVE6kES8DZy5XDdSuW1pIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-NQE2bf9XOEqbiPyFFQ9_dg-1; Wed, 28 Oct 2020 14:23:46 -0400
X-MC-Unique: NQE2bf9XOEqbiPyFFQ9_dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3836408F;
        Wed, 28 Oct 2020 18:23:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-92.rdu2.redhat.com [10.10.66.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402CF6EF53;
        Wed, 28 Oct 2020 18:23:40 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@redhat.com>
Subject: [PATCH] powerpc/smp: Move rcu_cpu_starting() earlier
Date:   Wed, 28 Oct 2020 14:23:34 -0400
Message-Id: <20201028182334.13466-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to rcu_cpu_starting() in start_secondary() is not early enough
in the CPU-hotplug onlining process, which results in lockdep splats as
follows:

 WARNING: suspicious RCU usage
 -----------------------------
 kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 RCU used illegally from offline CPU!
 rcu_scheduler_active = 1, debug_locks = 1
 no locks held by swapper/1/0.

 Call Trace:
 dump_stack+0xec/0x144 (unreliable)
 lockdep_rcu_suspicious+0x128/0x14c
 __lock_acquire+0x1060/0x1c60
 lock_acquire+0x140/0x5f0
 _raw_spin_lock_irqsave+0x64/0xb0
 clockevents_register_device+0x74/0x270
 register_decrementer_clockevent+0x94/0x110
 start_secondary+0x134/0x800
 start_secondary_prolog+0x10/0x14

This is avoided by moving the call to rcu_cpu_starting up near the
beginning of the start_secondary() function. Note that the
raw_smp_processor_id() is required in order to avoid calling into
lockdep before RCU has declared the CPU to be watched for readers.

Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
Signed-off-by: Qian Cai <cai@redhat.com>
---
 arch/powerpc/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3c6b9822f978..8c2857cbd960 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1393,13 +1393,14 @@ static void add_cpu_to_masks(int cpu)
 /* Activate a secondary processor. */
 void start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu = raw_smp_processor_id();
 
 	mmgrab(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
 	set_dec(tb_ticks_per_jiffy);
+	rcu_cpu_starting(cpu);
 	preempt_disable();
 	cpu_callin_map[cpu] = 1;
 
-- 
2.28.0

