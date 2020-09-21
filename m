Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F57272BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIUQWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbgIUQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600705359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mmjCuWnFwwB/CNiwOmkEmAptAC4rqWxfnx9Vx4WCQPk=;
        b=Ir1FnFo5ZpGlAoIvnkklPZCO5I9pvQ0lqbONlaveNyVmHQqw9JzbUUTZgeONna0fdOFAYb
        nbSIoORfa/RpZYi8BVS2Te8xibekoGJwlh2ul1pk9YGNZJWo9P55I+RCsQMJ4MDy35w9B0
        nfJM2obXyr+hxa8c6Uzl5AWqcKLNSgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-cMZ3reOCP1yAkSNyITuqtQ-1; Mon, 21 Sep 2020 12:22:37 -0400
X-MC-Unique: cMZ3reOCP1yAkSNyITuqtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 886FC1074647;
        Mon, 21 Sep 2020 16:22:35 +0000 (UTC)
Received: from x1.bristot.me.redhat.com (ovpn-113-39.rdu2.redhat.com [10.10.113.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3F145C1D0;
        Mon, 21 Sep 2020 16:22:25 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     x86@kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/irq: Use printk_deferred() on raw_spin_lock() protected sections
Date:   Mon, 21 Sep 2020 18:22:12 +0200
Message-Id: <e68888438cec9a1da53aaa1647720ade638d6ad4.1600705105.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing hotplug I got this BUG:

 =============================
 [ BUG: Invalid wait context ]
 5.9.0-rc5+ #3 Not tainted
 -----------------------------
 migration/2/20 is trying to lock:
 ffffffffb4315778 (&port->lock){-.-.}-{3:3}, at: serial8250_console_write+0x8e/0x380
 other info that might help us debug this:
 context-{5:5}
 4 locks held by migration/2/20:
  #0: ffff91622a3ff4c0 (&irq_desc_lock_class){-.-.}-{2:2}, at: irq_migrate_all_off_this_cpu+0x41/0x2f0
  #1: ffffffffb2c509b8 (vector_lock){-.-.}-{2:2}, at: irq_force_complete_move+0x2a/0x70
  #2: ffffffffb2c7cec0 (console_lock){+.+.}-{0:0}, at: printk+0x48/0x4a
  #3: ffffffffb2c7cbe0 (console_owner){....}-{0:0}, at: console_unlock+0x1af/0x650
 stack backtrace:
 CPU: 2 PID: 20 Comm: migration/2 Not tainted 5.9.0-rc5+ #3
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
 Call Trace:
  dump_stack+0x8b/0xb8
  __lock_acquire.cold+0x1ce/0x333
  ? stack_trace_save+0x3b/0x50
  ? save_trace+0x3f/0x360
  lock_acquire+0xbf/0x3e0
  ? serial8250_console_write+0x8e/0x380
  _raw_spin_lock_irqsave+0x48/0x60
  ? serial8250_console_write+0x8e/0x380
  serial8250_console_write+0x8e/0x380
  ? console_unlock+0x1e8/0x650
  console_unlock+0x3f3/0x650
  ? printk+0x48/0x4a
  vprintk_emit+0x1b1/0x440
  printk+0x48/0x4a
  irq_force_complete_move.cold+0xf/0x14
  irq_migrate_all_off_this_cpu+0xfa/0x2f0
  fixup_irqs+0x25/0xe8
  cpu_disable_common+0x2b8/0x2d0
  native_cpu_disable+0x18/0x30
  take_cpu_down+0x2f/0xa0
  multi_cpu_stop+0x6d/0x130
  ? stop_machine_yield+0x10/0x10
  cpu_stopper_thread+0x7b/0x110
  ? smpboot_thread_fn+0x26/0x1e0
  smpboot_thread_fn+0x10b/0x1e0
  ? smpboot_register_percpu_thread+0xf0/0xf0
  kthread+0x13a/0x150
  ? kthread_create_worker_on_cpu+0x40/0x40
  ret_from_fork+0x22/0x30
  smpboot: CPU 2 is now offline
 =============================

It was caused by printk() inside a code section protected by a
raw_spin_lock() that ended up calling a serial console that
uses a regular spin_lock().

Use the printk_deferred() to avoid calling the serial console
in a raw_spin_lock() protected section.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/apic/vector.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f8a56b5dc29f..1a0e5535b8ac 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -406,8 +406,9 @@ static int activate_reserved(struct irq_data *irqd)
 	 */
 	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
 			    irq_data_get_affinity_mask(irqd))) {
-		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
-			irqd->irq);
+		printk_deferred(KERN_WARNING
+				"irq %u: Affinity broken due to vector space exhaustion.\n",
+				irqd->irq);
 	}
 
 	return ret;
@@ -1012,8 +1013,9 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 * so we have the necessary information when a problem in that
 		 * area arises.
 		 */
-		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
-			irqd->irq, vector);
+		printk_deferred(KERN_WARNING
+				"IRQ fixup: irq %d move in progress, old vector %d\n",
+				irqd->irq, vector);
 	}
 	free_moved_vector(apicd);
 unlock:
@@ -1034,15 +1036,17 @@ int lapic_can_unplug_cpu(void)
 	tomove = irq_matrix_allocated(vector_matrix);
 	avl = irq_matrix_available(vector_matrix, true);
 	if (avl < tomove) {
-		pr_warn("CPU %u has %u vectors, %u available. Cannot disable CPU\n",
-			cpu, tomove, avl);
+		printk_deferred(KERN_WARNING
+				"CPU %u has %u vectors, %u available. Cannot disable CPU\n",
+				cpu, tomove, avl);
 		ret = -ENOSPC;
 		goto out;
 	}
 	rsvd = irq_matrix_reserved(vector_matrix);
 	if (avl < rsvd) {
-		pr_warn("Reserved vectors %u > available %u. IRQ request may fail\n",
-			rsvd, avl);
+		printk_deferred(KERN_WARNING
+				"Reserved vectors %u > available %u. IRQ request may fail\n",
+				rsvd, avl);
 	}
 out:
 	raw_spin_unlock(&vector_lock);
-- 
2.26.2

