Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221A529D80E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgJ1W3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387546AbgJ1W3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M8JTjwx1xPoMOxFeqZV3xf69WjT+/RkxcH88TSNnb+w=;
        b=f6qzu5MFv7R4bxvNLcQwz3WLg7o0hpPyyD7C56RzugvLcehKKCeNNqcNeoIG+xZLP8GbNE
        RAKbELrvii3DgGng0x9mJdELr/nM0Mku77SZDdsMZn3/WemF66SeFa7GlVSCoNaIk07cK8
        6LOp2lZD60eR8QEdtuf27l8k2gxa+OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-_bHN6KzcPlGx5EyRSV5QAA-1; Wed, 28 Oct 2020 14:28:01 -0400
X-MC-Unique: _bHN6KzcPlGx5EyRSV5QAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6704A879526;
        Wed, 28 Oct 2020 18:28:00 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-92.rdu2.redhat.com [10.10.66.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABA9560C04;
        Wed, 28 Oct 2020 18:27:55 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@redhat.com>
Subject: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Date:   Wed, 28 Oct 2020 14:27:42 -0400
Message-Id: <20201028182742.13773-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to rcu_cpu_starting() in smp_init_secondary() is not early
enough in the CPU-hotplug onlining process, which results in lockdep
splats as follows:

 WARNING: suspicious RCU usage
 -----------------------------
 kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 RCU used illegally from offline CPU!
 rcu_scheduler_active = 1, debug_locks = 1
 no locks held by swapper/1/0.

 Call Trace:
 show_stack+0x158/0x1f0
 dump_stack+0x1f2/0x238
 __lock_acquire+0x2640/0x4dd0
 lock_acquire+0x3a8/0xd08
 _raw_spin_lock_irqsave+0xc0/0xf0
 clockevents_register_device+0xa8/0x528
 init_cpu_timer+0x33e/0x468
 smp_init_secondary+0x11a/0x328
 smp_start_secondary+0x82/0x88

This is avoided by moving the call to rcu_cpu_starting up near the
beginning of the smp_init_secondary() function. Note that the
raw_smp_processor_id() is required in order to avoid calling into
lockdep before RCU has declared the CPU to be watched for readers.

Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
Signed-off-by: Qian Cai <cai@redhat.com>
---
 arch/s390/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index ebfe86d097f0..390d97daa2b3 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -855,13 +855,14 @@ void __init smp_detect_cpus(void)
 
 static void smp_init_secondary(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = raw_smp_processor_id();
 
 	S390_lowcore.last_update_clock = get_tod_clock();
 	restore_access_regs(S390_lowcore.access_regs_save_area);
 	set_cpu_flag(CIF_ASCE_PRIMARY);
 	set_cpu_flag(CIF_ASCE_SECONDARY);
 	cpu_init();
+	rcu_cpu_starting(cpu);
 	preempt_disable();
 	init_cpu_timer();
 	vtime_init();
-- 
2.28.0

