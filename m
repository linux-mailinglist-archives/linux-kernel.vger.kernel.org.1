Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1E2B3500
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgKONBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:01:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgKONBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:01:39 -0500
Date:   Sun, 15 Nov 2020 13:00:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605445297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0NM9HxVcwvPIUXFtFXNagxgz3Qp8ez8aVxVbQcJSzvk=;
        b=w4t5cT2xsdxeIi9jaTxbGeJlX+Q/6QU/5gh52DFTMIZNTYBd8o2jTFSQPBEYbIF9l9qxY4
        /6lk0EE3gyutkQ17I3Bym1OvLHJNhacpdMGb9DF0bFx5oaloACBTAjLRZvyT4r9VGGsJRc
        3uPdlr1elr2pVQyBBvqC9ykCaPE59kFRh6dottJBrAsYrA+ODtZd1Tg2aoCwETt228dYMu
        HaHlTTPCd+yIBv/9Q7w+LUQUDngIsCDWNz+y6kOUyDIKg0VX7v4hUDsnxjRIn4EGeEP+U7
        Jcd7VVz/5/bujt016CcVX8Tw8urNg1GEXu883oblRpR8UHKDKi9gc/MOeNwB5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605445297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0NM9HxVcwvPIUXFtFXNagxgz3Qp8ez8aVxVbQcJSzvk=;
        b=Mz2TLKFBJ6w+Er3D+E6y9ZUlqqSsBWr3pN+A89vdNIsGEJ0Vbbvd5IE3utJr6D/DgFQpkY
        HHD4UZQ3eewyYeBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.10-rc4
References: <160544524024.25051.12292089189937197323.tglx@nanos>
Message-ID: <160544524386.25051.9326481900625497800.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-15

up to:  ff828729be44: iommu/vt-d: Cure VF irqdomain hickup


A small set of fixes for x86:

 - Cure the fallout from the MSI irqdomain overhaul which missed that the
   Intel IOMMU does not register virtual function devices and therefore
   never reaches the point where the MSI interrupt domain is assigned. This
   makes the VF devices use the non-remapped MSI domain which is trapped by
   the IOMMU/remap unit.

 - Remove an extra space in the SGI_UV architecture type procfs output for
   UV5.

 - Remove a unused function which was missed when removing the UV BAU TLB
   shootdown handler.

Thanks,

	tglx

------------------>
Jiri Slaby (1):
      x86/platform/uv: Drop last traces of uv_flush_tlb_others

Mike Travis (1):
      x86/platform/uv: Fix copied UV5 output archtype

Thomas Gleixner (1):
      iommu/vt-d: Cure VF irqdomain hickup


 arch/x86/include/asm/uv/uv.h       | 10 ----------
 arch/x86/kernel/apic/x2apic_uv_x.c |  6 +++---
 drivers/iommu/intel/dmar.c         | 19 ++++++++++++++++++-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 172d3e4a9e4b..648eb23fe7f0 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -2,14 +2,8 @@
 #ifndef _ASM_X86_UV_UV_H
 #define _ASM_X86_UV_UV_H
 
-#include <asm/tlbflush.h>
-
 enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
 
-struct cpumask;
-struct mm_struct;
-struct flush_tlb_info;
-
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
@@ -44,10 +38,6 @@ static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
-static inline const struct cpumask *
-uv_flush_tlb_others(const struct cpumask *cpumask,
-		    const struct flush_tlb_info *info)
-{ return cpumask; }
 
 #endif	/* X86_UV */
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3115caa7d7d0..1b98f8c12b96 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -33,7 +33,7 @@ static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
 /* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
-static u8 uv_archtype[UV_AT_SIZE];
+static u8 uv_archtype[UV_AT_SIZE + 1];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -320,7 +320,7 @@ static int __init decode_arch_type(unsigned long ptr)
 
 	if (n > 0 && n < sizeof(uv_ate->archtype)) {
 		pr_info("UV: UVarchtype received from BIOS\n");
-		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, uv_ate->archtype);
 		return 1;
 	}
 	return 0;
@@ -378,7 +378,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
 	if (!early_get_arch_type())
 
 		/* If not use OEM ID for UVarchtype */
-		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+		uv_stringify(sizeof(uv_archtype), uv_archtype, oem_id);
 
 	/* Check if not hubbed */
 	if (strncmp(uv_archtype, "SGI", 3) != 0) {
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 404b40af31cb..b2e804473209 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct dmar_pci_notify_info *info)
 	dmar_iommu_notify_scope_dev(info);
 }
 
+static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
+{
+	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+}
+
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 	/* Only care about add/remove events for physical functions.
 	 * For VFs we actually do the lookup based on the corresponding
 	 * PF in device_to_iommu() anyway. */
-	if (pdev->is_virtfn)
+	if (pdev->is_virtfn) {
+		/*
+		 * Ensure that the VF device inherits the irq domain of the
+		 * PF device. Ideally the device would inherit the domain
+		 * from the bus, but DMAR can have multiple units per bus
+		 * which makes this impossible. The VF 'bus' could inherit
+		 * from the PF device, but that's yet another x86'sism to
+		 * inflict on everybody else.
+		 */
+		if (action == BUS_NOTIFY_ADD_DEVICE)
+			vf_inherit_msi_domain(pdev);
 		return NOTIFY_DONE;
+	}
+
 	if (action != BUS_NOTIFY_ADD_DEVICE &&
 	    action != BUS_NOTIFY_REMOVED_DEVICE)
 		return NOTIFY_DONE;

