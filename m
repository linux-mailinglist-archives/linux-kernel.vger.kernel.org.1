Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5629A752
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895358AbgJ0JH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:07:58 -0400
Received: from ozlabs.ru ([107.174.27.60]:43022 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895351AbgJ0JH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:07:58 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id D4AB2AE80274;
        Tue, 27 Oct 2020 05:06:42 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [RFC PATCH kernel 2/2] powerpc/pci: Remove LSI mappings on device teardown
Date:   Tue, 27 Oct 2020 20:06:55 +1100
Message-Id: <20201027090655.14118-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027090655.14118-1-aik@ozlabs.ru>
References: <20201027090655.14118-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver O'Halloran <oohall@gmail.com>

When a passthrough IO adapter is removed from a pseries machine using hash
MMU and the XIVE interrupt mode, the POWER hypervisor expects the guest OS
to clear all page table entries related to the adapter. If some are still
present, the RTAS call which isolates the PCI slot returns error 9001
"valid outstanding translations" and the removal of the IO adapter fails.
This is because when the PHBs are scanned, Linux maps automatically the
INTx interrupts in the Linux interrupt number space but these are never
removed.

This problem can be fixed by adding the corresponding unmap operation when
the device is removed. There's no pcibios_* hook for the remove case, but
the same effect can be achieved using a bus notifier.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/pci-common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index be108616a721..95f4e173368a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -404,6 +404,27 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 	return 0;
 }
 
+static int ppc_pci_unmap_irq_line(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+
+	if (action == BUS_NOTIFY_DEL_DEVICE)
+		irq_dispose_mapping(pdev->irq);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_pci_unmap_irq_notifier = {
+	.notifier_call = ppc_pci_unmap_irq_line,
+};
+
+static int ppc_pci_register_irq_notifier(void)
+{
+	return bus_register_notifier(&pci_bus_type, &ppc_pci_unmap_irq_notifier);
+}
+arch_initcall(ppc_pci_register_irq_notifier);
+
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s.
  *  -- paulus.
-- 
2.17.1

