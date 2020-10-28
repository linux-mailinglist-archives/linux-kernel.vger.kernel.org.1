Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783F229D811
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgJ1W3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387547AbgJ1W3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UE3dvpTXYD1TxjvaPfVy+gsIUVv7GO6zARCwT2Egia8=;
        b=QoYJthvwTM+H8U5F84maiSz4O0uUx5pLHD+O8UwCd/Je7VcWYcOv8dRmbECmBGpNDi0Brc
        uq0DKNtmvA1voIeT8m7XjXGBdp0QDnOmFNlQPYRvZL5UcJw0Y56dMXRayJc5oro7pONn3Q
        n6lK8+BmjKZn+XbyVAIs7bqYcBxoLdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-lnOqo2DdOK-TTluihTk1Og-1; Wed, 28 Oct 2020 14:26:42 -0400
X-MC-Unique: lnOqo2DdOK-TTluihTk1Og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A88805F1E;
        Wed, 28 Oct 2020 18:26:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-92.rdu2.redhat.com [10.10.66.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF4985C1D7;
        Wed, 28 Oct 2020 18:26:36 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@redhat.com>
Subject: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Date:   Wed, 28 Oct 2020 14:26:14 -0400
Message-Id: <20201028182614.13655-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to rcu_cpu_starting() in secondary_start_kernel() is not early
enough in the CPU-hotplug onlining process, which results in lockdep
splats as follows:

 WARNING: suspicious RCU usage
 -----------------------------
 kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 RCU used illegally from offline CPU!
 rcu_scheduler_active = 1, debug_locks = 1
 no locks held by swapper/1/0.

 Call trace:
  dump_backtrace+0x0/0x3c8
  show_stack+0x14/0x60
  dump_stack+0x14c/0x1c4
  lockdep_rcu_suspicious+0x134/0x14c
  __lock_acquire+0x1c30/0x2600
  lock_acquire+0x274/0xc48
  _raw_spin_lock+0xc8/0x140
  vprintk_emit+0x90/0x3d0
  vprintk_default+0x34/0x40
  vprintk_func+0x378/0x590
  printk+0xa8/0xd4
  __cpuinfo_store_cpu+0x71c/0x868
  cpuinfo_store_cpu+0x2c/0xc8
  secondary_start_kernel+0x244/0x318

This is avoided by moving the call to rcu_cpu_starting up near the
beginning of the secondary_start_kernel() function.

Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
Signed-off-by: Qian Cai <cai@redhat.com>
---
 arch/arm64/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc2c903..09c96f57818c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -222,6 +222,7 @@ asmlinkage notrace void secondary_start_kernel(void)
 	if (system_uses_irq_prio_masking())
 		init_gic_priority_masking();
 
+	rcu_cpu_starting(cpu);
 	preempt_disable();
 	trace_hardirqs_off();
 
-- 
2.28.0

