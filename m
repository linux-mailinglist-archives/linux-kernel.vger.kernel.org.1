Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24129D822
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbgJ1W3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387593AbgJ1W33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603924168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wn0Z2b/sXqhg3H37/VXFagrRrbv7yUzOhfS3vczwgWY=;
        b=cZCIwdRlyrPWeqDIrj0cwOREmv8PtRwYT9+3tSLgRBmqNkgQyvIgY53geAMblVi0NDnQrk
        iZB7ygmwooRRpnsWHe5J2o7OuxgCgV6P4vvLafVI3PmzTKdjA8UN2b/QV4TJroKsefxRrM
        L7UjEYAKjFznyRHtuvDst/H8/X4so0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-GY6_39BMMkWttzhIjBAwzw-1; Wed, 28 Oct 2020 11:27:43 -0400
X-MC-Unique: GY6_39BMMkWttzhIjBAwzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5514FE9008;
        Wed, 28 Oct 2020 15:27:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-66-92.rdu2.redhat.com [10.10.66.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21F1810013C1;
        Wed, 28 Oct 2020 15:27:40 +0000 (UTC)
From:   Qian Cai <cai@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/eeh_cache: Fix a possible debugfs deadlock
Date:   Wed, 28 Oct 2020 11:27:17 -0400
Message-Id: <20201028152717.8967-1-cai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep complains that a possible deadlock below in
eeh_addr_cache_show() because it is acquiring a lock with IRQ enabled,
but eeh_addr_cache_insert_dev() needs to acquire the same lock with IRQ
disabled. Let's just make eeh_addr_cache_show() acquire the lock with
IRQ disabled as well.

        CPU0                    CPU1
        ----                    ----
   lock(&pci_io_addr_cache_root.piar_lock);
                                local_irq_disable();
                                lock(&tp->lock);
                                lock(&pci_io_addr_cache_root.piar_lock);
   <Interrupt>
     lock(&tp->lock);

  *** DEADLOCK ***

  lock_acquire+0x140/0x5f0
  _raw_spin_lock_irqsave+0x64/0xb0
  eeh_addr_cache_insert_dev+0x48/0x390
  eeh_probe_device+0xb8/0x1a0
  pnv_pcibios_bus_add_device+0x3c/0x80
  pcibios_bus_add_device+0x118/0x290
  pci_bus_add_device+0x28/0xe0
  pci_bus_add_devices+0x54/0xb0
  pcibios_init+0xc4/0x124
  do_one_initcall+0xac/0x528
  kernel_init_freeable+0x35c/0x3fc
  kernel_init+0x24/0x148
  ret_from_kernel_thread+0x5c/0x80

  lock_acquire+0x140/0x5f0
  _raw_spin_lock+0x4c/0x70
  eeh_addr_cache_show+0x38/0x110
  seq_read+0x1a0/0x660
  vfs_read+0xc8/0x1f0
  ksys_read+0x74/0x130
  system_call_exception+0xf8/0x1d0
  system_call_common+0xe8/0x218

Fixes: 5ca85ae6318d ("powerpc/eeh_cache: Add a way to dump the EEH address cache")
Signed-off-by: Qian Cai <cai@redhat.com>
---
 arch/powerpc/kernel/eeh_cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 6b50bf15d8c1..bf3270426d82 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -264,8 +264,9 @@ static int eeh_addr_cache_show(struct seq_file *s, void *v)
 {
 	struct pci_io_addr_range *piar;
 	struct rb_node *n;
+	unsigned long flags;
 
-	spin_lock(&pci_io_addr_cache_root.piar_lock);
+	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
 	for (n = rb_first(&pci_io_addr_cache_root.rb_root); n; n = rb_next(n)) {
 		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
 
@@ -273,7 +274,7 @@ static int eeh_addr_cache_show(struct seq_file *s, void *v)
 		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem",
 		       &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
 	}
-	spin_unlock(&pci_io_addr_cache_root.piar_lock);
+	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
 
 	return 0;
 }
-- 
2.28.0

