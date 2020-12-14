Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF32DA182
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503309AbgLNU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503243AbgLNU0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C19C0617B0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:35 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HYf0cwjS1cYusOUIQJGYz7ztAAj+1gycCkEhJB2ByIY=;
        b=PSGXTHVVHMlxs+jKPwVYy9RIdi8ra8/AF0dbAkf/8KcgyRqqVz1qpoBDdpY03aU7w0ilEP
        jf4rhoZ6448nAin0OuEZiBYTWR+TOxWp2WtE43o2YZuNaQnbl91QmzXBae1hSkVObaETKA
        ijROPvtJ1e9NJ9FwdffbA5MRqHagdwIMvFzdTMOvQRPnGtbsp2JPD/TdAfJijA7XroTKf6
        jBrhyQHgIY0ncL6ySA5gOFF/MBsh1Amejg+kRrHUtK6jtptvN4syXy44btu8phpvrh5Ezi
        6hN6ZO3BHt/ICXmBmEfRJ/39ELJJO+Htc88tx03X7pxM/yt/gNszWQ7MfRcMPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=HYf0cwjS1cYusOUIQJGYz7ztAAj+1gycCkEhJB2ByIY=;
        b=CXsecJD2uaprFnDYf2dwmMJOjUWqUFD+a7sXbQo2N/otjRad7KmerlCrbEMCS2PA2VdBfH
        OfF59NO0b2bQ0nAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797734033.10793.4023884058552218676.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2020-12-14

up to:  058df195c234: x86/ioapic: Cleanup the timer_works() irqflags mess


Yet another large set of x86 interrupt management updates:

   - Simplification and distangling of the MSI related functionality

   - Let IO/APIC construct the RTE entries from an MSI message instead of
     having IO/APIC specific code in the interrupt remapping drivers

   - Make the retrieval of the parent interrupt domain (vector or remap
     unit) less hardcoded and use the relevant irqdomain callbacks for
     selection.

   - Allow the handling of more than 255 CPUs without a virtualized IOMMU
     when the hypervisor supports it. This has made been possible by the
     above modifications and also simplifies the existing workaround in the
     HyperV specific virtual IOMMU.

   - Cleanup of the historical timer_works() irq flags related
     inconsistencies.

Thanks,

	tglx

------------------>
David Woodhouse (22):
      x86/apic: Fix x2apic enablement without interrupt remapping
      x86/msi: Only use high bits of MSI address for DMAR unit
      x86/apic: Always provide irq_compose_msi_msg() method for vector domain
      x86/hpet: Move MSI support into hpet.c
      x86/ioapic: Generate RTE directly from parent irqchip's MSI message
      genirq/irqdomain: Implement get_name() method on irqchip fwnodes
      x86/apic: Add select() method on vector irqdomain
      iommu/amd: Implement select() method on remapping irqdomain
      iommu/vt-d: Implement select() method on remapping irqdomain
      iommu/hyper-v: Implement select() method on remapping irqdomain
      x86/hpet: Use irq_find_matching_fwspec() to find remapping irqdomain
      x86/ioapic: Use irq_find_matching_fwspec() to find remapping irqdomain
      x86: Kill all traces of irq_remapping_get_irq_domain()
      iommu/vt-d: Simplify intel_irq_remapping_select()
      x86/ioapic: Handle Extended Destination ID field in RTE
      x86/apic: Support 15 bits of APIC ID in MSI where available
      iommu/hyper-v: Disable IRQ pseudo-remapping if 15 bit APIC IDs are available
      x86/kvm: Enable 15-bit extension when KVM_FEATURE_MSI_EXT_DEST_ID detected
      x86/ioapic: Use I/O-APIC ID for finding irqdomain, not index
      iommu/amd: Fix union of bitfields in intcapxt support
      iommu/amd: Don't register interrupt remapping irqdomain when IR is disabled
      iommu/amd: Fix IOMMU interrupt generation in X2APIC mode

Dexuan Cui (2):
      x86/hyperv: Enable 15-bit APIC ID if the hypervisor supports it
      iommu/hyper-v: Remove I/O-APIC ID check from hyperv_irq_remapping_select()

Thomas Gleixner (18):
      x86/apic/uv: Fix inconsistent destination mode
      x86/devicetree: Fix the ioapic interrupt type table
      x86/apic: Cleanup delivery mode defines
      x86/apic: Replace pointless apic:: Dest_logical usage
      x86/apic: Get rid of apic:: Dest_logical
      x86/apic: Cleanup destination mode
      genirq/msi: Allow shadow declarations of msi_msg:: $member
      x86/msi: Provide msi message shadow structs
      iommu/intel: Use msi_msg shadow structs
      iommu/amd: Use msi_msg shadow structs
      PCI: vmd: Use msi_msg shadow structs
      x86/kvm: Use msi_msg shadow structs
      x86/pci/xen: Use msi_msg shadow structs
      x86/msi: Remove msidef.h
      x86/io_apic: Cleanup trigger/polarity helpers
      x86/ioapic: Cleanup IO/APIC route entry structs
      x86/ioapic: Correct the PCI/ISA trigger type selection
      x86/ioapic: Cleanup the timer_works() irqflags mess


 arch/x86/include/asm/apic.h           |  16 +-
 arch/x86/include/asm/apicdef.h        |  16 +-
 arch/x86/include/asm/hpet.h           |  11 -
 arch/x86/include/asm/hw_irq.h         |  14 +-
 arch/x86/include/asm/hyperv-tlfs.h    |   7 +
 arch/x86/include/asm/io_apic.h        |  79 ++---
 arch/x86/include/asm/irq_remapping.h  |   9 -
 arch/x86/include/asm/irqdomain.h      |   3 +
 arch/x86/include/asm/msi.h            |  50 ++++
 arch/x86/include/asm/msidef.h         |  57 ----
 arch/x86/include/asm/x86_init.h       |   2 +
 arch/x86/kernel/apic/apic.c           |  73 ++++-
 arch/x86/kernel/apic/apic_flat_64.c   |  18 +-
 arch/x86/kernel/apic/apic_noop.c      |  10 +-
 arch/x86/kernel/apic/apic_numachip.c  |  16 +-
 arch/x86/kernel/apic/bigsmp_32.c      |   9 +-
 arch/x86/kernel/apic/io_apic.c        | 525 +++++++++++++++++-----------------
 arch/x86/kernel/apic/ipi.c            |   6 +-
 arch/x86/kernel/apic/msi.c            | 153 +---------
 arch/x86/kernel/apic/probe_32.c       |   9 +-
 arch/x86/kernel/apic/vector.c         |  49 ++++
 arch/x86/kernel/apic/x2apic_cluster.c |  10 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  17 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  12 +-
 arch/x86/kernel/cpu/mshyperv.c        |  29 ++
 arch/x86/kernel/devicetree.c          |  30 +-
 arch/x86/kernel/hpet.c                | 122 +++++++-
 arch/x86/kernel/kvm.c                 |   6 +
 arch/x86/kernel/smpboot.c             |   8 +-
 arch/x86/kernel/x86_init.c            |   1 +
 arch/x86/kvm/irq_comm.c               |  31 +-
 arch/x86/pci/intel_mid_pci.c          |   8 +-
 arch/x86/pci/xen.c                    |  26 +-
 arch/x86/platform/uv/uv_irq.c         |   4 +-
 arch/x86/xen/apic.c                   |   7 +-
 drivers/iommu/amd/amd_iommu_types.h   |   2 +-
 drivers/iommu/amd/init.c              | 225 ++++++++++-----
 drivers/iommu/amd/iommu.c             |  93 +++---
 drivers/iommu/hyperv-iommu.c          |  44 +--
 drivers/iommu/intel/irq_remapping.c   | 102 +++----
 drivers/iommu/irq_remapping.c         |  14 -
 drivers/iommu/irq_remapping.h         |   3 -
 drivers/pci/controller/pci-hyperv.c   |   6 +-
 drivers/pci/controller/vmd.c          |   9 +-
 include/asm-generic/msi.h             |   4 +
 include/linux/msi.h                   |  46 ++-
 kernel/irq/irqdomain.c                |  11 +-
 47 files changed, 1056 insertions(+), 946 deletions(-)
 delete mode 100644 arch/x86/include/asm/msidef.h

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 4e3099d9ae62..34cb3c159481 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -259,6 +259,7 @@ static inline u64 native_x2apic_icr_read(void)
 
 extern int x2apic_mode;
 extern int x2apic_phys;
+extern void __init x2apic_set_max_apicid(u32 apicid);
 extern void __init check_x2apic(void);
 extern void x2apic_setup(void);
 static inline int x2apic_enabled(void)
@@ -305,11 +306,10 @@ struct apic {
 	void	(*send_IPI_all)(int vector);
 	void	(*send_IPI_self)(int vector);
 
-	/* dest_logical is used by the IPI functions */
-	u32	dest_logical;
 	u32	disable_esr;
-	u32	irq_delivery_mode;
-	u32	irq_dest_mode;
+
+	enum apic_delivery_modes delivery_mode;
+	bool	dest_mode_logical;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
@@ -520,12 +520,10 @@ static inline void apic_smt_update(void) { }
 #endif
 
 struct msi_msg;
+struct irq_cfg;
 
-#ifdef CONFIG_PCI_MSI
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
-#else
-# define x86_vector_msi_compose_msg NULL
-#endif
+extern void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+				  bool dmar);
 
 extern void ioapic_zap_locks(void);
 
diff --git a/arch/x86/include/asm/apicdef.h b/arch/x86/include/asm/apicdef.h
index 05e694ed8386..5716f22f81ac 100644
--- a/arch/x86/include/asm/apicdef.h
+++ b/arch/x86/include/asm/apicdef.h
@@ -432,15 +432,13 @@ struct local_apic {
  #define BAD_APICID 0xFFFFu
 #endif
 
-enum ioapic_irq_destination_types {
-	dest_Fixed		= 0,
-	dest_LowestPrio		= 1,
-	dest_SMI		= 2,
-	dest__reserved_1	= 3,
-	dest_NMI		= 4,
-	dest_INIT		= 5,
-	dest__reserved_2	= 6,
-	dest_ExtINT		= 7
+enum apic_delivery_modes {
+	APIC_DELIVERY_MODE_FIXED	= 0,
+	APIC_DELIVERY_MODE_LOWESTPRIO   = 1,
+	APIC_DELIVERY_MODE_SMI		= 2,
+	APIC_DELIVERY_MODE_NMI		= 4,
+	APIC_DELIVERY_MODE_INIT		= 5,
+	APIC_DELIVERY_MODE_EXTINT	= 7,
 };
 
 #endif /* _ASM_X86_APICDEF_H */
diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6352dee37cda..ab9f3dd87c80 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -74,17 +74,6 @@ extern void hpet_disable(void);
 extern unsigned int hpet_readl(unsigned int a);
 extern void force_hpet_resume(void);
 
-struct irq_data;
-struct hpet_channel;
-struct irq_domain;
-
-extern void hpet_msi_unmask(struct irq_data *data);
-extern void hpet_msi_mask(struct irq_data *data);
-extern void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg);
-extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
-extern int hpet_assign_irq(struct irq_domain *domain,
-			   struct hpet_channel *hc, int dev_num);
-
 #ifdef CONFIG_HPET_EMULATE_RTC
 
 #include <linux/interrupt.h>
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index a4aeeaace040..d465ece58151 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -39,18 +39,16 @@ enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_PCI_MSI,
 	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
+	X86_IRQ_ALLOC_TYPE_AMDVI,
 	X86_IRQ_ALLOC_TYPE_UV,
-	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
-	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
 struct ioapic_alloc_info {
-	int				pin;
-	int				node;
-	u32				trigger : 1;
-	u32				polarity : 1;
-	u32				valid : 1;
-	struct IO_APIC_route_entry	*entry;
+	int		pin;
+	int		node;
+	u32		is_level	: 1;
+	u32		active_low	: 1;
+	u32		valid		: 1;
 };
 
 struct uv_alloc_info {
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0ed20e8bba9e..6bf42aed387e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -23,6 +23,13 @@
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
 #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
 
+#define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
+#define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
+
+#define HYPERV_CPUID_VIRT_STACK_PROPERTIES	0x40000082
+/* Support for the extended IOAPIC RTE format */
+#define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	BIT(2)
+
 #define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
 #define HYPERV_CPUID_MIN			0x40000005
 #define HYPERV_CPUID_MAX			0x4000ffff
diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index a1a26f6d3aa4..437aa8d00e53 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -13,15 +13,6 @@
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
 
-/* I/O Unit Redirection Table */
-#define IO_APIC_REDIR_VECTOR_MASK	0x000FF
-#define IO_APIC_REDIR_DEST_LOGICAL	0x00800
-#define IO_APIC_REDIR_DEST_PHYSICAL	0x00000
-#define IO_APIC_REDIR_SEND_PENDING	(1 << 12)
-#define IO_APIC_REDIR_REMOTE_IRR	(1 << 14)
-#define IO_APIC_REDIR_LEVEL_TRIGGER	(1 << 15)
-#define IO_APIC_REDIR_MASKED		(1 << 16)
-
 /*
  * The structure of the IO-APIC:
  */
@@ -65,52 +56,40 @@ union IO_APIC_reg_03 {
 };
 
 struct IO_APIC_route_entry {
-	__u32	vector		:  8,
-		delivery_mode	:  3,	/* 000: FIXED
-					 * 001: lowest prio
-					 * 111: ExtINT
-					 */
-		dest_mode	:  1,	/* 0: physical, 1: logical */
-		delivery_status	:  1,
-		polarity	:  1,
-		irr		:  1,
-		trigger		:  1,	/* 0: edge, 1: level */
-		mask		:  1,	/* 0: enabled, 1: disabled */
-		__reserved_2	: 15;
-
-	__u32	__reserved_3	: 24,
-		dest		:  8;
-} __attribute__ ((packed));
-
-struct IR_IO_APIC_route_entry {
-	__u64	vector		: 8,
-		zero		: 3,
-		index2		: 1,
-		delivery_status : 1,
-		polarity	: 1,
-		irr		: 1,
-		trigger		: 1,
-		mask		: 1,
-		reserved	: 31,
-		format		: 1,
-		index		: 15;
+	union {
+		struct {
+			u64	vector			:  8,
+				delivery_mode		:  3,
+				dest_mode_logical	:  1,
+				delivery_status		:  1,
+				active_low		:  1,
+				irr			:  1,
+				is_level		:  1,
+				masked			:  1,
+				reserved_0		: 15,
+				reserved_1		: 17,
+				virt_destid_8_14	:  7,
+				destid_0_7		:  8;
+		};
+		struct {
+			u64	ir_shared_0		:  8,
+				ir_zero			:  3,
+				ir_index_15		:  1,
+				ir_shared_1		:  5,
+				ir_reserved_0		: 31,
+				ir_format		:  1,
+				ir_index_0_14		: 15;
+		};
+		struct {
+			u64	w1			: 32,
+				w2			: 32;
+		};
+	};
 } __attribute__ ((packed));
 
 struct irq_alloc_info;
 struct ioapic_domain_cfg;
 
-#define IOAPIC_EDGE			0
-#define IOAPIC_LEVEL			1
-
-#define IOAPIC_MASKED			1
-#define IOAPIC_UNMASKED			0
-
-#define IOAPIC_POL_HIGH			0
-#define IOAPIC_POL_LOW			1
-
-#define IOAPIC_DEST_MODE_PHYSICAL	0
-#define IOAPIC_DEST_MODE_LOGICAL	1
-
 #define	IOAPIC_MAP_ALLOC		0x1
 #define	IOAPIC_MAP_CHECK		0x2
 
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index af4a151d70b3..7cc49432187f 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,9 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
-extern struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info);
-
 /* Create PCI MSI/MSIx irqdomain, use @parent as the parent irqdomain. */
 extern struct irq_domain *
 arch_create_remap_msi_irq_domain(struct irq_domain *par, const char *n, int id);
@@ -71,11 +68,5 @@ static inline void panic_if_irq_remap(const char *msg)
 {
 }
 
-static inline struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
 #endif /* CONFIG_IRQ_REMAP */
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index cd684d45cb5f..125c23b7bad3 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -12,6 +12,9 @@ enum {
 	X86_IRQ_ALLOC_LEGACY				= 0x2,
 };
 
+extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
+extern int x86_fwspec_is_hpet(struct irq_fwspec *fwspec);
+
 extern struct irq_domain *x86_vector_domain;
 
 extern void init_irq_alloc_info(struct irq_alloc_info *info,
diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index cd30013d15d3..b85147d75626 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -9,4 +9,54 @@ typedef struct irq_alloc_info msi_alloc_info_t;
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
+/* Structs and defines for the X86 specific MSI message format */
+
+typedef struct x86_msi_data {
+	u32	vector			:  8,
+		delivery_mode		:  3,
+		dest_mode_logical	:  1,
+		reserved		:  2,
+		active_low		:  1,
+		is_level		:  1;
+
+	u32	dmar_subhandle;
+} __attribute__ ((packed)) arch_msi_msg_data_t;
+#define arch_msi_msg_data	x86_msi_data
+
+typedef struct x86_msi_addr_lo {
+	union {
+		struct {
+			u32	reserved_0		:  2,
+				dest_mode_logical	:  1,
+				redirect_hint		:  1,
+				reserved_1		:  1,
+				virt_destid_8_14	:  7,
+				destid_0_7		:  8,
+				base_address		: 12;
+		};
+		struct {
+			u32	dmar_reserved_0		:  2,
+				dmar_index_15		:  1,
+				dmar_subhandle_valid	:  1,
+				dmar_format		:  1,
+				dmar_index_0_14		: 15,
+				dmar_base_address	: 12;
+		};
+	};
+} __attribute__ ((packed)) arch_msi_msg_addr_lo_t;
+#define arch_msi_msg_addr_lo	x86_msi_addr_lo
+
+#define X86_MSI_BASE_ADDRESS_LOW	(0xfee00000 >> 20)
+
+typedef struct x86_msi_addr_hi {
+	u32	reserved		:  8,
+		destid_8_31		: 24;
+} __attribute__ ((packed)) arch_msi_msg_addr_hi_t;
+#define arch_msi_msg_addr_hi	x86_msi_addr_hi
+
+#define X86_MSI_BASE_ADDRESS_HIGH	(0)
+
+struct msi_msg;
+u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/include/asm/msidef.h b/arch/x86/include/asm/msidef.h
deleted file mode 100644
index ee2f8ccc32d0..000000000000
--- a/arch/x86/include/asm/msidef.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MSIDEF_H
-#define _ASM_X86_MSIDEF_H
-
-/*
- * Constants for Intel APIC based MSI messages.
- */
-
-/*
- * Shifts for MSI data
- */
-
-#define MSI_DATA_VECTOR_SHIFT		0
-#define  MSI_DATA_VECTOR_MASK		0x000000ff
-#define	 MSI_DATA_VECTOR(v)		(((v) << MSI_DATA_VECTOR_SHIFT) & \
-					 MSI_DATA_VECTOR_MASK)
-
-#define MSI_DATA_DELIVERY_MODE_SHIFT	8
-#define  MSI_DATA_DELIVERY_FIXED	(0 << MSI_DATA_DELIVERY_MODE_SHIFT)
-#define  MSI_DATA_DELIVERY_LOWPRI	(1 << MSI_DATA_DELIVERY_MODE_SHIFT)
-
-#define MSI_DATA_LEVEL_SHIFT		14
-#define	 MSI_DATA_LEVEL_DEASSERT	(0 << MSI_DATA_LEVEL_SHIFT)
-#define	 MSI_DATA_LEVEL_ASSERT		(1 << MSI_DATA_LEVEL_SHIFT)
-
-#define MSI_DATA_TRIGGER_SHIFT		15
-#define  MSI_DATA_TRIGGER_EDGE		(0 << MSI_DATA_TRIGGER_SHIFT)
-#define  MSI_DATA_TRIGGER_LEVEL		(1 << MSI_DATA_TRIGGER_SHIFT)
-
-/*
- * Shift/mask fields for msi address
- */
-
-#define MSI_ADDR_BASE_HI		0
-#define MSI_ADDR_BASE_LO		0xfee00000
-
-#define MSI_ADDR_DEST_MODE_SHIFT	2
-#define  MSI_ADDR_DEST_MODE_PHYSICAL	(0 << MSI_ADDR_DEST_MODE_SHIFT)
-#define	 MSI_ADDR_DEST_MODE_LOGICAL	(1 << MSI_ADDR_DEST_MODE_SHIFT)
-
-#define MSI_ADDR_REDIRECTION_SHIFT	3
-#define  MSI_ADDR_REDIRECTION_CPU	(0 << MSI_ADDR_REDIRECTION_SHIFT)
-					/* dedicated cpu */
-#define  MSI_ADDR_REDIRECTION_LOWPRI	(1 << MSI_ADDR_REDIRECTION_SHIFT)
-					/* lowest priority */
-
-#define MSI_ADDR_DEST_ID_SHIFT		12
-#define	 MSI_ADDR_DEST_ID_MASK		0x00ffff0
-#define  MSI_ADDR_DEST_ID(dest)		(((dest) << MSI_ADDR_DEST_ID_SHIFT) & \
-					 MSI_ADDR_DEST_ID_MASK)
-#define MSI_ADDR_EXT_DEST_ID(dest)	((dest) & 0xffffff00)
-
-#define MSI_ADDR_IR_EXT_INT		(1 << 4)
-#define MSI_ADDR_IR_SHV			(1 << 3)
-#define MSI_ADDR_IR_INDEX1(index)	((index & 0x8000) >> 13)
-#define MSI_ADDR_IR_INDEX2(index)	((index & 0x7fff) << 5)
-#endif /* _ASM_X86_MSIDEF_H */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index dde5b3f1e7cd..5c69f7eb5d47 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -116,6 +116,7 @@ struct x86_init_pci {
  * @init_platform:		platform setup
  * @guest_late_init:		guest late init
  * @x2apic_available:		X2APIC detection
+ * @msi_ext_dest_id:		MSI supports 15-bit APIC IDs
  * @init_mem_mapping:		setup early mappings during init_mem_mapping()
  * @init_after_bootmem:		guest init after boot allocator is finished
  */
@@ -123,6 +124,7 @@ struct x86_hyper_init {
 	void (*init_platform)(void);
 	void (*guest_late_init)(void);
 	bool (*x2apic_available)(void);
+	bool (*msi_ext_dest_id)(void);
 	void (*init_mem_mapping)(void);
 	void (*init_after_bootmem)(void);
 };
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b3eef1d5c903..6bd20c0de8bc 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -93,6 +93,11 @@ static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
  */
 static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
 
+/*
+ * Hypervisor supports 15 bits of APIC ID in MSI Extended Destination ID
+ */
+static bool virt_ext_dest_id __ro_after_init;
+
 /*
  * Map cpu index to physical APIC ID
  */
@@ -1591,7 +1596,7 @@ static void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	if (apic->dest_logical) {
+	if (apic->dest_mode_logical) {
 		int logical_apicid, ldr_apicid;
 
 		/*
@@ -1841,20 +1846,34 @@ static __init void try_to_enable_x2apic(int remap_mode)
 		return;
 
 	if (remap_mode != IRQ_REMAP_X2APIC_MODE) {
-		/* IR is required if there is APIC ID > 255 even when running
-		 * under KVM
+		u32 apic_limit = 255;
+
+		/*
+		 * Using X2APIC without IR is not architecturally supported
+		 * on bare metal but may be supported in guests.
 		 */
-		if (max_physical_apicid > 255 ||
-		    !x86_init.hyper.x2apic_available()) {
+		if (!x86_init.hyper.x2apic_available()) {
 			pr_info("x2apic: IRQ remapping doesn't support X2APIC mode\n");
 			x2apic_disable();
 			return;
 		}
 
 		/*
-		 * without IR all CPUs can be addressed by IOAPIC/MSI
-		 * only in physical mode
+		 * If the hypervisor supports extended destination ID in
+		 * MSI, that increases the maximum APIC ID that can be
+		 * used for non-remapped IRQ domains.
 		 */
+		if (x86_init.hyper.msi_ext_dest_id()) {
+			virt_ext_dest_id = 1;
+			apic_limit = 32767;
+		}
+
+		/*
+		 * Without IR, all CPUs can be addressed by IOAPIC/MSI only
+		 * in physical mode, and CPUs with an APIC ID that cannnot
+		 * be addressed must not be brought online.
+		 */
+		x2apic_set_max_apicid(apic_limit);
 		x2apic_phys = 1;
 	}
 	x2apic_enable();
@@ -2478,6 +2497,46 @@ int hard_smp_processor_id(void)
 	return read_apic_id();
 }
 
+void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+			   bool dmar)
+{
+	memset(msg, 0, sizeof(*msg));
+
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
+	msg->arch_addr_lo.destid_0_7 = cfg->dest_apicid & 0xFF;
+
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	msg->arch_data.vector = cfg->vector;
+
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	/*
+	 * Only the IOMMU itself can use the trick of putting destination
+	 * APIC ID into the high bits of the address. Anything else would
+	 * just be writing to memory if it tried that, and needs IR to
+	 * address APICs which can't be addressed in the normal 32-bit
+	 * address range at 0xFFExxxxx. That is typically just 8 bits, but
+	 * some hypervisors allow the extended destination ID field in bits
+	 * 5-11 to be used, giving support for 15 bits of APIC IDs in total.
+	 */
+	if (dmar)
+		msg->arch_addr_hi.destid_8_31 = cfg->dest_apicid >> 8;
+	else if (virt_ext_dest_id && cfg->dest_apicid < 0x8000)
+		msg->arch_addr_lo.virt_destid_8_14 = cfg->dest_apicid >> 8;
+	else
+		WARN_ON_ONCE(cfg->dest_apicid > 0xFF);
+}
+
+u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
+{
+	u32 dest = msg->arch_addr_lo.destid_0_7;
+
+	if (extid)
+		dest |= msg->arch_addr_hi.destid_8_31 << 8;
+	return dest;
+}
+EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 7862b152a052..8f72b4351c9f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -53,7 +53,7 @@ static void _flat_send_IPI_mask(unsigned long mask, int vector)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
@@ -113,15 +113,13 @@ static struct apic apic_flat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 1, /* logical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -206,15 +204,13 @@ static struct apic apic_physflat __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 0, /* physical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= physflat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 780c702969b7..fe78319e0f7a 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -95,19 +95,15 @@ struct apic apic_noop __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= noop_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	/* logical delivery broadcast to all CPUs: */
-	.irq_dest_mode			= 1,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= default_check_apicid_used,
 
+	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= noop_init_apic_ldr,
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= NULL,
-
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 35edd57f064a..a54d817eb4b6 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -246,15 +246,13 @@ static const struct apic apic_numachip1 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 0, /* physical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
@@ -295,15 +293,13 @@ static const struct apic apic_numachip2 __refconst = {
 	.apic_id_valid			= numachip_apic_id_valid,
 	.apic_id_registered		= numachip_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 0, /* physical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= flat_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 98d015a4405a..77555f66c14d 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -127,16 +127,13 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= bigsmp_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	/* phys delivery to target CPU: */
-	.irq_dest_mode			= 0,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 1,
-	.dest_logical			= 0,
-	.check_apicid_used		= bigsmp_check_apicid_used,
 
+	.check_apicid_used		= bigsmp_check_apicid_used,
 	.init_apic_ldr			= bigsmp_init_apic_ldr,
-
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
 	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7b3c7e0d4a09..e4ab4804b20d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -48,6 +48,7 @@
 #include <linux/jiffies.h>	/* time_after() */
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/msi.h>
 
 #include <asm/irqdomain.h>
 #include <asm/io.h>
@@ -63,7 +64,6 @@
 #include <asm/setup.h>
 #include <asm/irq_remapping.h>
 #include <asm/hw_irq.h>
-
 #include <asm/apic.h>
 
 #define	for_each_ioapic(idx)		\
@@ -89,12 +89,12 @@ struct irq_pin_list {
 };
 
 struct mp_chip_data {
-	struct list_head irq_2_pin;
-	struct IO_APIC_route_entry entry;
-	int trigger;
-	int polarity;
+	struct list_head		irq_2_pin;
+	struct IO_APIC_route_entry	entry;
+	bool				is_level;
+	bool				active_low;
+	bool				isa_irq;
 	u32 count;
-	bool isa_irq;
 };
 
 struct mp_ioapic_gsi {
@@ -286,31 +286,26 @@ static void io_apic_write(unsigned int apic, unsigned int reg,
 	writel(value, &io_apic->data);
 }
 
-union entry_union {
-	struct { u32 w1, w2; };
-	struct IO_APIC_route_entry entry;
-};
-
 static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
 {
-	union entry_union eu;
+	struct IO_APIC_route_entry entry;
 
-	eu.w1 = io_apic_read(apic, 0x10 + 2 * pin);
-	eu.w2 = io_apic_read(apic, 0x11 + 2 * pin);
+	entry.w1 = io_apic_read(apic, 0x10 + 2 * pin);
+	entry.w2 = io_apic_read(apic, 0x11 + 2 * pin);
 
-	return eu.entry;
+	return entry;
 }
 
 static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
 {
-	union entry_union eu;
+	struct IO_APIC_route_entry entry;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	eu.entry = __ioapic_read_entry(apic, pin);
+	entry = __ioapic_read_entry(apic, pin);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	return eu.entry;
+	return entry;
 }
 
 /*
@@ -321,11 +316,8 @@ static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
  */
 static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
 {
-	union entry_union eu = {{0, 0}};
-
-	eu.entry = e;
-	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
-	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
+	io_apic_write(apic, 0x11 + 2*pin, e.w2);
+	io_apic_write(apic, 0x10 + 2*pin, e.w1);
 }
 
 static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
@@ -344,12 +336,12 @@ static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
  */
 static void ioapic_mask_entry(int apic, int pin)
 {
+	struct IO_APIC_route_entry e = { .masked = true };
 	unsigned long flags;
-	union entry_union eu = { .entry.mask = IOAPIC_MASKED };
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
-	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
+	io_apic_write(apic, 0x10 + 2*pin, e.w1);
+	io_apic_write(apic, 0x11 + 2*pin, e.w2);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -422,20 +414,15 @@ static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
 	add_pin_to_irq_node(data, node, newapic, newpin);
 }
 
-static void io_apic_modify_irq(struct mp_chip_data *data,
-			       int mask_and, int mask_or,
+static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 			       void (*final)(struct irq_pin_list *entry))
 {
-	union entry_union eu;
 	struct irq_pin_list *entry;
 
-	eu.entry = data->entry;
-	eu.w1 &= mask_and;
-	eu.w1 |= mask_or;
-	data->entry = eu.entry;
+	data->entry.masked = masked;
 
 	for_each_irq_pin(entry, data->irq_2_pin) {
-		io_apic_write(entry->apic, 0x10 + 2 * entry->pin, eu.w1);
+		io_apic_write(entry->apic, 0x10 + 2 * entry->pin, data->entry.w1);
 		if (final)
 			final(entry);
 	}
@@ -459,13 +446,13 @@ static void mask_ioapic_irq(struct irq_data *irq_data)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_modify_irq(data, ~0, IO_APIC_REDIR_MASKED, &io_apic_sync);
+	io_apic_modify_irq(data, true, &io_apic_sync);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
 static void __unmask_ioapic(struct mp_chip_data *data)
 {
-	io_apic_modify_irq(data, ~IO_APIC_REDIR_MASKED, 0, NULL);
+	io_apic_modify_irq(data, false, NULL);
 }
 
 static void unmask_ioapic_irq(struct irq_data *irq_data)
@@ -506,8 +493,8 @@ static void __eoi_ioapic_pin(int apic, int pin, int vector)
 		/*
 		 * Mask the entry and change the trigger mode to edge.
 		 */
-		entry1.mask = IOAPIC_MASKED;
-		entry1.trigger = IOAPIC_EDGE;
+		entry1.masked = true;
+		entry1.is_level = false;
 
 		__ioapic_write_entry(apic, pin, entry1);
 
@@ -535,15 +522,15 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 
 	/* Check delivery_mode to be sure we're not clearing an SMI pin */
 	entry = ioapic_read_entry(apic, pin);
-	if (entry.delivery_mode == dest_SMI)
+	if (entry.delivery_mode == APIC_DELIVERY_MODE_SMI)
 		return;
 
 	/*
 	 * Make sure the entry is masked and re-read the contents to check
 	 * if it is a level triggered pin and if the remote-IRR is set.
 	 */
-	if (entry.mask == IOAPIC_UNMASKED) {
-		entry.mask = IOAPIC_MASKED;
+	if (!entry.masked) {
+		entry.masked = true;
 		ioapic_write_entry(apic, pin, entry);
 		entry = ioapic_read_entry(apic, pin);
 	}
@@ -556,8 +543,8 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
 		 * doesn't clear the remote-IRR if the trigger mode is not
 		 * set to level.
 		 */
-		if (entry.trigger == IOAPIC_EDGE) {
-			entry.trigger = IOAPIC_LEVEL;
+		if (!entry.is_level) {
+			entry.is_level = true;
 			ioapic_write_entry(apic, pin, entry);
 		}
 		raw_spin_lock_irqsave(&ioapic_lock, flags);
@@ -659,8 +646,8 @@ void mask_ioapic_entries(void)
 			struct IO_APIC_route_entry entry;
 
 			entry = ioapics[apic].saved_registers[pin];
-			if (entry.mask == IOAPIC_UNMASKED) {
-				entry.mask = IOAPIC_MASKED;
+			if (!entry.masked) {
+				entry.masked = true;
 				ioapic_write_entry(apic, pin, entry);
 			}
 		}
@@ -745,44 +732,7 @@ static int __init find_isa_irq_apic(int irq, int type)
 	return -1;
 }
 
-#ifdef CONFIG_EISA
-/*
- * EISA Edge/Level control register, ELCR
- */
-static int EISA_ELCR(unsigned int irq)
-{
-	if (irq < nr_legacy_irqs()) {
-		unsigned int port = 0x4d0 + (irq >> 3);
-		return (inb(port) >> (irq & 7)) & 1;
-	}
-	apic_printk(APIC_VERBOSE, KERN_INFO
-			"Broken MPtable reports ISA irq %d\n", irq);
-	return 0;
-}
-
-#endif
-
-/* ISA interrupts are always active high edge triggered,
- * when listed as conforming in the MP table. */
-
-#define default_ISA_trigger(idx)	(IOAPIC_EDGE)
-#define default_ISA_polarity(idx)	(IOAPIC_POL_HIGH)
-
-/* EISA interrupts are always polarity zero and can be edge or level
- * trigger depending on the ELCR value.  If an interrupt is listed as
- * EISA conforming in the MP table, that means its trigger type must
- * be read in from the ELCR */
-
-#define default_EISA_trigger(idx)	(EISA_ELCR(mp_irqs[idx].srcbusirq))
-#define default_EISA_polarity(idx)	default_ISA_polarity(idx)
-
-/* PCI interrupts are always active low level triggered,
- * when listed as conforming in the MP table. */
-
-#define default_PCI_trigger(idx)	(IOAPIC_LEVEL)
-#define default_PCI_polarity(idx)	(IOAPIC_POL_LOW)
-
-static int irq_polarity(int idx)
+static bool irq_active_low(int idx)
 {
 	int bus = mp_irqs[idx].srcbus;
 
@@ -791,90 +741,139 @@ static int irq_polarity(int idx)
 	 */
 	switch (mp_irqs[idx].irqflag & MP_IRQPOL_MASK) {
 	case MP_IRQPOL_DEFAULT:
-		/* conforms to spec, ie. bus-type dependent polarity */
-		if (test_bit(bus, mp_bus_not_pci))
-			return default_ISA_polarity(idx);
-		else
-			return default_PCI_polarity(idx);
+		/*
+		 * Conforms to spec, ie. bus-type dependent polarity.  PCI
+		 * defaults to low active. [E]ISA defaults to high active.
+		 */
+		return !test_bit(bus, mp_bus_not_pci);
 	case MP_IRQPOL_ACTIVE_HIGH:
-		return IOAPIC_POL_HIGH;
+		return false;
 	case MP_IRQPOL_RESERVED:
 		pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
 		fallthrough;
 	case MP_IRQPOL_ACTIVE_LOW:
 	default: /* Pointless default required due to do gcc stupidity */
-		return IOAPIC_POL_LOW;
+		return true;
 	}
 }
 
 #ifdef CONFIG_EISA
-static int eisa_irq_trigger(int idx, int bus, int trigger)
+/*
+ * EISA Edge/Level control register, ELCR
+ */
+static bool EISA_ELCR(unsigned int irq)
+{
+	if (irq < nr_legacy_irqs()) {
+		unsigned int port = 0x4d0 + (irq >> 3);
+		return (inb(port) >> (irq & 7)) & 1;
+	}
+	apic_printk(APIC_VERBOSE, KERN_INFO
+			"Broken MPtable reports ISA irq %d\n", irq);
+	return false;
+}
+
+/*
+ * EISA interrupts are always active high and can be edge or level
+ * triggered depending on the ELCR value.  If an interrupt is listed as
+ * EISA conforming in the MP table, that means its trigger type must be
+ * read in from the ELCR.
+ */
+static bool eisa_irq_is_level(int idx, int bus, bool level)
 {
 	switch (mp_bus_id_to_type[bus]) {
 	case MP_BUS_PCI:
 	case MP_BUS_ISA:
-		return trigger;
+		return level;
 	case MP_BUS_EISA:
-		return default_EISA_trigger(idx);
+		return EISA_ELCR(mp_irqs[idx].srcbusirq);
 	}
 	pr_warn("IOAPIC: Invalid srcbus: %d defaulting to level\n", bus);
-	return IOAPIC_LEVEL;
+	return true;
 }
 #else
-static inline int eisa_irq_trigger(int idx, int bus, int trigger)
+static inline int eisa_irq_is_level(int idx, int bus, bool level)
 {
-	return trigger;
+	return level;
 }
 #endif
 
-static int irq_trigger(int idx)
+static bool irq_is_level(int idx)
 {
 	int bus = mp_irqs[idx].srcbus;
-	int trigger;
+	bool level;
 
 	/*
 	 * Determine IRQ trigger mode (edge or level sensitive):
 	 */
 	switch (mp_irqs[idx].irqflag & MP_IRQTRIG_MASK) {
 	case MP_IRQTRIG_DEFAULT:
-		/* conforms to spec, ie. bus-type dependent trigger mode */
-		if (test_bit(bus, mp_bus_not_pci))
-			trigger = default_ISA_trigger(idx);
-		else
-			trigger = default_PCI_trigger(idx);
+		/*
+		 * Conforms to spec, ie. bus-type dependent trigger
+		 * mode. PCI defaults to level, ISA to edge.
+		 */
+		level = !test_bit(bus, mp_bus_not_pci);
 		/* Take EISA into account */
-		return eisa_irq_trigger(idx, bus, trigger);
+		return eisa_irq_is_level(idx, bus, level);
 	case MP_IRQTRIG_EDGE:
-		return IOAPIC_EDGE;
+		return false;
 	case MP_IRQTRIG_RESERVED:
 		pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
 		fallthrough;
 	case MP_IRQTRIG_LEVEL:
 	default: /* Pointless default required due to do gcc stupidity */
-		return IOAPIC_LEVEL;
+		return true;
 	}
 }
 
+static int __acpi_get_override_irq(u32 gsi, bool *trigger, bool *polarity)
+{
+	int ioapic, pin, idx;
+
+	if (skip_ioapic_setup)
+		return -1;
+
+	ioapic = mp_find_ioapic(gsi);
+	if (ioapic < 0)
+		return -1;
+
+	pin = mp_find_ioapic_pin(ioapic, gsi);
+	if (pin < 0)
+		return -1;
+
+	idx = find_irq_entry(ioapic, pin, mp_INT);
+	if (idx < 0)
+		return -1;
+
+	*trigger = irq_is_level(idx);
+	*polarity = irq_active_low(idx);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+int acpi_get_override_irq(u32 gsi, int *is_level, int *active_low)
+{
+	*is_level = *active_low = 0;
+	return __acpi_get_override_irq(gsi, (bool *)is_level,
+				       (bool *)active_low);
+}
+#endif
+
 void ioapic_set_alloc_attr(struct irq_alloc_info *info, int node,
 			   int trigger, int polarity)
 {
 	init_irq_alloc_info(info, NULL);
 	info->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
 	info->ioapic.node = node;
-	info->ioapic.trigger = trigger;
-	info->ioapic.polarity = polarity;
+	info->ioapic.is_level = trigger;
+	info->ioapic.active_low = polarity;
 	info->ioapic.valid = 1;
 }
 
-#ifndef CONFIG_ACPI
-int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
-#endif
-
 static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
 				   struct irq_alloc_info *src,
 				   u32 gsi, int ioapic_idx, int pin)
 {
-	int trigger, polarity;
+	bool level, pol_low;
 
 	copy_irq_alloc_info(dst, src);
 	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
@@ -883,20 +882,20 @@ static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
 	dst->ioapic.valid = 1;
 	if (src && src->ioapic.valid) {
 		dst->ioapic.node = src->ioapic.node;
-		dst->ioapic.trigger = src->ioapic.trigger;
-		dst->ioapic.polarity = src->ioapic.polarity;
+		dst->ioapic.is_level = src->ioapic.is_level;
+		dst->ioapic.active_low = src->ioapic.active_low;
 	} else {
 		dst->ioapic.node = NUMA_NO_NODE;
-		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
-			dst->ioapic.trigger = trigger;
-			dst->ioapic.polarity = polarity;
+		if (__acpi_get_override_irq(gsi, &level, &pol_low) >= 0) {
+			dst->ioapic.is_level = level;
+			dst->ioapic.active_low = pol_low;
 		} else {
 			/*
 			 * PCI interrupts are always active low level
 			 * triggered.
 			 */
-			dst->ioapic.trigger = IOAPIC_LEVEL;
-			dst->ioapic.polarity = IOAPIC_POL_LOW;
+			dst->ioapic.is_level = true;
+			dst->ioapic.active_low = true;
 		}
 	}
 }
@@ -906,12 +905,12 @@ static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
 	return (info && info->ioapic.valid) ? info->ioapic.node : NUMA_NO_NODE;
 }
 
-static void mp_register_handler(unsigned int irq, unsigned long trigger)
+static void mp_register_handler(unsigned int irq, bool level)
 {
 	irq_flow_handler_t hdl;
 	bool fasteoi;
 
-	if (trigger) {
+	if (level) {
 		irq_set_status_flags(irq, IRQ_LEVEL);
 		fasteoi = true;
 	} else {
@@ -933,14 +932,14 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 	 * pin with real trigger and polarity attributes.
 	 */
 	if (irq < nr_legacy_irqs() && data->count == 1) {
-		if (info->ioapic.trigger != data->trigger)
-			mp_register_handler(irq, info->ioapic.trigger);
-		data->entry.trigger = data->trigger = info->ioapic.trigger;
-		data->entry.polarity = data->polarity = info->ioapic.polarity;
+		if (info->ioapic.is_level != data->is_level)
+			mp_register_handler(irq, info->ioapic.is_level);
+		data->entry.is_level = data->is_level = info->ioapic.is_level;
+		data->entry.active_low = data->active_low = info->ioapic.active_low;
 	}
 
-	return data->trigger == info->ioapic.trigger &&
-	       data->polarity == info->ioapic.polarity;
+	return data->is_level == info->ioapic.is_level &&
+	       data->active_low == info->ioapic.active_low;
 }
 
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
@@ -1219,10 +1218,9 @@ void ioapic_zap_locks(void)
 
 static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 {
-	int i;
-	char buf[256];
 	struct IO_APIC_route_entry entry;
-	struct IR_IO_APIC_route_entry *ir_entry = (void *)&entry;
+	char buf[256];
+	int i;
 
 	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
 	for (i = 0; i <= nr_entries; i++) {
@@ -1230,20 +1228,21 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 		snprintf(buf, sizeof(buf),
 			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
 			 i,
-			 entry.mask == IOAPIC_MASKED ? "disabled" : "enabled ",
-			 entry.trigger == IOAPIC_LEVEL ? "level" : "edge ",
-			 entry.polarity == IOAPIC_POL_LOW ? "low " : "high",
+			 entry.masked ? "disabled" : "enabled ",
+			 entry.is_level ? "level" : "edge ",
+			 entry.active_low ? "low " : "high",
 			 entry.vector, entry.irr, entry.delivery_status);
-		if (ir_entry->format)
+		if (entry.ir_format) {
 			printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-			       buf, (ir_entry->index2 << 15) | ir_entry->index,
-			       ir_entry->zero);
-		else
-			printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n",
 			       buf,
-			       entry.dest_mode == IOAPIC_DEST_MODE_LOGICAL ?
-			       "logical " : "physical",
-			       entry.dest, entry.delivery_mode);
+			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
+				entry.ir_zero);
+		} else {
+			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
+			       entry.dest_mode_logical ? "logical " : "physical",
+			       entry.virt_destid_8_14, entry.destid_0_7,
+			       entry.delivery_mode);
+		}
 	}
 }
 
@@ -1368,7 +1367,8 @@ void __init enable_IO_APIC(void)
 		/* If the interrupt line is enabled and in ExtInt mode
 		 * I have found the pin where the i8259 is connected.
 		 */
-		if ((entry.mask == 0) && (entry.delivery_mode == dest_ExtINT)) {
+		if (!entry.masked &&
+		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
 			goto found_i8259;
@@ -1410,14 +1410,16 @@ void native_restore_boot_irq_mode(void)
 	 */
 	if (ioapic_i8259.pin != -1) {
 		struct IO_APIC_route_entry entry;
+		u32 apic_id = read_apic_id();
 
 		memset(&entry, 0, sizeof(entry));
-		entry.mask		= IOAPIC_UNMASKED;
-		entry.trigger		= IOAPIC_EDGE;
-		entry.polarity		= IOAPIC_POL_HIGH;
-		entry.dest_mode		= IOAPIC_DEST_MODE_PHYSICAL;
-		entry.delivery_mode	= dest_ExtINT;
-		entry.dest		= read_apic_id();
+		entry.masked		= false;
+		entry.is_level		= false;
+		entry.active_low	= false;
+		entry.dest_mode_logical	= false;
+		entry.delivery_mode	= APIC_DELIVERY_MODE_EXTINT;
+		entry.destid_0_7	= apic_id & 0xFF;
+		entry.virt_destid_8_14	= apic_id >> 8;
 
 		/*
 		 * Add it to the IO-APIC irq-routing table:
@@ -1618,21 +1620,16 @@ static void __init delay_without_tsc(void)
 static int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
-	unsigned long flags;
 
 	if (no_timer_check)
 		return 1;
 
-	local_save_flags(flags);
 	local_irq_enable();
-
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		delay_with_tsc();
 	else
 		delay_without_tsc();
 
-	local_irq_restore(flags);
-
 	/*
 	 * Expect a few ticks at least, to be sure some possible
 	 * glue logic does not lock up after one or two first
@@ -1641,10 +1638,10 @@ static int __init timer_irq_works(void)
 	 * least one tick may be lost due to delays.
 	 */
 
-	/* jiffies wrap? */
-	if (time_after(jiffies, t1 + 4))
-		return 1;
-	return 0;
+	local_irq_disable();
+
+	/* Did jiffies advance? */
+	return time_after(jiffies, t1 + 4);
 }
 
 /*
@@ -1696,13 +1693,13 @@ static bool io_apic_level_ack_pending(struct mp_chip_data *data)
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	for_each_irq_pin(entry, data->irq_2_pin) {
-		unsigned int reg;
+		struct IO_APIC_route_entry e;
 		int pin;
 
 		pin = entry->pin;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
+		e.w1 = io_apic_read(entry->apic, 0x10 + pin*2);
 		/* Is the remote IRR bit set? */
-		if (reg & IO_APIC_REDIR_REMOTE_IRR) {
+		if (e.irr) {
 			raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 			return true;
 		}
@@ -1849,21 +1846,62 @@ static void ioapic_ir_ack_level(struct irq_data *irq_data)
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 
+/*
+ * The I/OAPIC is just a device for generating MSI messages from legacy
+ * interrupt pins. Various fields of the RTE translate into bits of the
+ * resulting MSI which had a historical meaning.
+ *
+ * With interrupt remapping, many of those bits have different meanings
+ * in the underlying MSI, but the way that the I/OAPIC transforms them
+ * from its RTE to the MSI message is the same. This function allows
+ * the parent IRQ domain to compose the MSI message, then takes the
+ * relevant bits to put them in the appropriate places in the RTE in
+ * order to generate that message when the IRQ happens.
+ *
+ * The setup here relies on a preconfigured route entry (is_level,
+ * active_low, masked) because the parent domain is merely composing the
+ * generic message routing information which is used for the MSI.
+ */
+static void ioapic_setup_msg_from_msi(struct irq_data *irq_data,
+				      struct IO_APIC_route_entry *entry)
+{
+	struct msi_msg msg;
+
+	/* Let the parent domain compose the MSI message */
+	irq_chip_compose_msi_msg(irq_data, &msg);
+
+	/*
+	 * - Real vector
+	 * - DMAR/IR: 8bit subhandle (ioapic.pin)
+	 * - AMD/IR:  8bit IRTE index
+	 */
+	entry->vector			= msg.arch_data.vector;
+	/* Delivery mode (for DMAR/IR all 0) */
+	entry->delivery_mode		= msg.arch_data.delivery_mode;
+	/* Destination mode or DMAR/IR index bit 15 */
+	entry->dest_mode_logical	= msg.arch_addr_lo.dest_mode_logical;
+	/* DMAR/IR: 1, 0 for all other modes */
+	entry->ir_format		= msg.arch_addr_lo.dmar_format;
+	/*
+	 * - DMAR/IR: index bit 0-14.
+	 *
+	 * - Virt: If the host supports x2apic without a virtualized IR
+	 *	   unit then bit 0-6 of dmar_index_0_14 are providing bit
+	 *	   8-14 of the destination id.
+	 *
+	 * All other modes have bit 0-6 of dmar_index_0_14 cleared and the
+	 * topmost 8 bits are destination id bit 0-7 (entry::destid_0_7).
+	 */
+	entry->ir_index_0_14		= msg.arch_addr_lo.dmar_index_0_14;
+}
+
 static void ioapic_configure_entry(struct irq_data *irqd)
 {
 	struct mp_chip_data *mpd = irqd->chip_data;
-	struct irq_cfg *cfg = irqd_cfg(irqd);
 	struct irq_pin_list *entry;
 
-	/*
-	 * Only update when the parent is the vector domain, don't touch it
-	 * if the parent is the remapping domain. Check the installed
-	 * ioapic chip to verify that.
-	 */
-	if (irqd->chip == &ioapic_chip) {
-		mpd->entry.dest = cfg->dest_apicid;
-		mpd->entry.vector = cfg->vector;
-	}
+	ioapic_setup_msg_from_msi(irqd, &mpd->entry);
+
 	for_each_irq_pin(entry, mpd->irq_2_pin)
 		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
 }
@@ -1919,7 +1957,7 @@ static int ioapic_irq_get_chip_state(struct irq_data *irqd,
 		 * irrelevant because the IO-APIC treats them as fire and
 		 * forget.
 		 */
-		if (rentry.irr && rentry.trigger) {
+		if (rentry.irr && rentry.is_level) {
 			*state = true;
 			break;
 		}
@@ -2027,6 +2065,7 @@ static inline void __init unlock_ExtINT_logic(void)
 	int apic, pin, i;
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	u32 apic_id;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
 	if (pin == -1) {
@@ -2042,14 +2081,16 @@ static inline void __init unlock_ExtINT_logic(void)
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
+	apic_id = hard_smp_processor_id();
 	memset(&entry1, 0, sizeof(entry1));
 
-	entry1.dest_mode = IOAPIC_DEST_MODE_PHYSICAL;
-	entry1.mask = IOAPIC_UNMASKED;
-	entry1.dest = hard_smp_processor_id();
-	entry1.delivery_mode = dest_ExtINT;
-	entry1.polarity = entry0.polarity;
-	entry1.trigger = IOAPIC_EDGE;
+	entry1.dest_mode_logical	= true;
+	entry1.masked			= false;
+	entry1.destid_0_7		= apic_id & 0xFF;
+	entry1.virt_destid_8_14		= apic_id >> 8;
+	entry1.delivery_mode		= APIC_DELIVERY_MODE_EXTINT;
+	entry1.active_low		= entry0.active_low;
+	entry1.is_level			= false;
 	entry1.vector = 0;
 
 	ioapic_write_entry(apic, pin, entry1);
@@ -2117,13 +2158,12 @@ static inline void __init check_timer(void)
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	int node = cpu_to_node(0);
 	int apic1, pin1, apic2, pin2;
-	unsigned long flags;
 	int no_pin1 = 0;
 
 	if (!global_clock_event)
 		return;
 
-	local_irq_save(flags);
+	local_irq_disable();
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -2178,9 +2218,9 @@ static inline void __init check_timer(void)
 			 * so only need to unmask if it is level-trigger
 			 * do we really have level trigger timer?
 			 */
-			int idx;
-			idx = find_irq_entry(apic1, pin1, mp_INT);
-			if (idx != -1 && irq_trigger(idx))
+			int idx = find_irq_entry(apic1, pin1, mp_INT);
+
+			if (idx != -1 && irq_is_level(idx))
 				unmask_ioapic_irq(irq_get_irq_data(0));
 		}
 		irq_domain_deactivate_irq(irq_data);
@@ -2191,7 +2231,6 @@ static inline void __init check_timer(void)
 			goto out;
 		}
 		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
-		local_irq_disable();
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
 			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
@@ -2215,7 +2254,6 @@ static inline void __init check_timer(void)
 		/*
 		 * Cleanup, just in case ...
 		 */
-		local_irq_disable();
 		legacy_pic->mask(0);
 		clear_IO_APIC_pin(apic2, pin2);
 		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
@@ -2232,7 +2270,6 @@ static inline void __init check_timer(void)
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	legacy_pic->mask(0);
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
@@ -2251,7 +2288,6 @@ static inline void __init check_timer(void)
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
 	if (apic_is_x2apic_enabled())
 		apic_printk(APIC_QUIET, KERN_INFO
@@ -2260,7 +2296,7 @@ static inline void __init check_timer(void)
 	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
 		"report.  Then try booting with the 'noapic' option.\n");
 out:
-	local_irq_restore(flags);
+	local_irq_enable();
 }
 
 /*
@@ -2284,36 +2320,37 @@ static inline void __init check_timer(void)
 
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_alloc_info info;
 	struct irq_domain *parent;
 	int hwirqs = mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip = &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg = &ip->irqdomain_cfg;
 	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
 	struct fwnode_handle *fn;
-	char *name = "IO-APIC";
+	struct irq_fwspec fwspec;
 
 	if (cfg->type == IOAPIC_DOMAIN_INVALID)
 		return 0;
 
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
-	info.devid = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_irq_domain(&info);
-	if (!parent)
-		parent = x86_vector_domain;
-	else
-		name = "IO-APIC-IR";
-
 	/* Handle device tree enumerated APICs proper */
 	if (cfg->dev) {
 		fn = of_node_to_fwnode(cfg->dev);
 	} else {
-		fn = irq_domain_alloc_named_id_fwnode(name, ioapic);
+		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", mpc_ioapic_id(ioapic));
 		if (!fn)
 			return -ENOMEM;
 	}
 
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = mpc_ioapic_id(ioapic);
+
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
+		return -ENODEV;
+	}
+
 	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
 						 (void *)(long)ioapic);
 
@@ -2587,30 +2624,6 @@ static int io_apic_get_version(int ioapic)
 	return reg_01.bits.version;
 }
 
-int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
-{
-	int ioapic, pin, idx;
-
-	if (skip_ioapic_setup)
-		return -1;
-
-	ioapic = mp_find_ioapic(gsi);
-	if (ioapic < 0)
-		return -1;
-
-	pin = mp_find_ioapic_pin(ioapic, gsi);
-	if (pin < 0)
-		return -1;
-
-	idx = find_irq_entry(ioapic, pin, mp_INT);
-	if (idx < 0)
-		return -1;
-
-	*trigger = irq_trigger(idx);
-	*polarity = irq_polarity(idx);
-	return 0;
-}
-
 /*
  * This function updates target affinity of IOAPIC interrupts to include
  * the CPUs which came online during SMP bringup.
@@ -2934,44 +2947,49 @@ static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 				  struct irq_alloc_info *info)
 {
 	if (info && info->ioapic.valid) {
-		data->trigger = info->ioapic.trigger;
-		data->polarity = info->ioapic.polarity;
-	} else if (acpi_get_override_irq(gsi, &data->trigger,
-					 &data->polarity) < 0) {
+		data->is_level = info->ioapic.is_level;
+		data->active_low = info->ioapic.active_low;
+	} else if (__acpi_get_override_irq(gsi, &data->is_level,
+					   &data->active_low) < 0) {
 		/* PCI interrupts are always active low level triggered. */
-		data->trigger = IOAPIC_LEVEL;
-		data->polarity = IOAPIC_POL_LOW;
+		data->is_level = true;
+		data->active_low = true;
 	}
 }
 
-static void mp_setup_entry(struct irq_cfg *cfg, struct mp_chip_data *data,
-			   struct IO_APIC_route_entry *entry)
+/*
+ * Configure the I/O-APIC specific fields in the routing entry.
+ *
+ * This is important to setup the I/O-APIC specific bits (is_level,
+ * active_low, masked) because the underlying parent domain will only
+ * provide the routing information and is oblivious of the I/O-APIC
+ * specific bits.
+ *
+ * The entry is just preconfigured at this point and not written into the
+ * RTE. This happens later during activation which will fill in the actual
+ * routing information.
+ */
+static void mp_preconfigure_entry(struct mp_chip_data *data)
 {
+	struct IO_APIC_route_entry *entry = &data->entry;
+
 	memset(entry, 0, sizeof(*entry));
-	entry->delivery_mode = apic->irq_delivery_mode;
-	entry->dest_mode     = apic->irq_dest_mode;
-	entry->dest	     = cfg->dest_apicid;
-	entry->vector	     = cfg->vector;
-	entry->trigger	     = data->trigger;
-	entry->polarity	     = data->polarity;
+	entry->is_level		 = data->is_level;
+	entry->active_low	 = data->active_low;
 	/*
 	 * Mask level triggered irqs. Edge triggered irqs are masked
 	 * by the irq core code in case they fire.
 	 */
-	if (data->trigger == IOAPIC_LEVEL)
-		entry->mask = IOAPIC_MASKED;
-	else
-		entry->mask = IOAPIC_UNMASKED;
+	entry->masked		= data->is_level;
 }
 
 int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		       unsigned int nr_irqs, void *arg)
 {
-	int ret, ioapic, pin;
-	struct irq_cfg *cfg;
-	struct irq_data *irq_data;
-	struct mp_chip_data *data;
 	struct irq_alloc_info *info = arg;
+	struct mp_chip_data *data;
+	struct irq_data *irq_data;
+	int ret, ioapic, pin;
 	unsigned long flags;
 
 	if (!info || nr_irqs > 1)
@@ -2989,7 +3007,6 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!data)
 		return -ENOMEM;
 
-	info->ioapic.entry = &data->entry;
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
 	if (ret < 0) {
 		kfree(data);
@@ -3003,22 +3020,20 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	cfg = irqd_cfg(irq_data);
 	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
 
+	mp_preconfigure_entry(data);
+	mp_register_handler(virq, data->is_level);
+
 	local_irq_save(flags);
-	if (info->ioapic.entry)
-		mp_setup_entry(cfg, data, info->ioapic.entry);
-	mp_register_handler(virq, data->trigger);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
 	local_irq_restore(flags);
 
 	apic_printk(APIC_VERBOSE, KERN_DEBUG
-		    "IOAPIC[%d]: Set routing entry (%d-%d -> 0x%x -> IRQ %d Mode:%i Active:%i Dest:%d)\n",
-		    ioapic, mpc_ioapic_id(ioapic), pin, cfg->vector,
-		    virq, data->trigger, data->polarity, cfg->dest_apicid);
-
+		    "IOAPIC[%d]: Preconfigured routing entry (%d-%d -> IRQ %d Level:%i ActiveLow:%i)\n",
+		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
+		    data->is_level, data->active_low);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 387154e39e08..d1fb874fbe64 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -260,7 +260,7 @@ void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 	for_each_cpu(query_cpu, mask)
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
@@ -279,7 +279,7 @@ void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
 			continue;
 		__default_send_IPI_dest_field(
 			early_per_cpu(x86_cpu_to_logical_apicid, query_cpu),
-			vector, apic->dest_logical);
+			vector, APIC_DEST_LOGICAL);
 		}
 	local_irq_restore(flags);
 }
@@ -297,7 +297,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 
 	local_irq_save(flags);
 	WARN_ON(mask & ~cpumask_bits(cpu_online_mask)[0]);
-	__default_send_IPI_dest_field(mask, vector, apic->dest_logical);
+	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6313f0a05db7..44ebe25e7703 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -15,7 +15,6 @@
 #include <linux/hpet.h>
 #include <linux/msi.h>
 #include <asm/irqdomain.h>
-#include <asm/msidef.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
@@ -23,38 +22,11 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
-static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
-{
-	msg->address_hi = MSI_ADDR_BASE_HI;
-
-	if (x2apic_enabled())
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		((apic->irq_dest_mode == 0) ?
-			MSI_ADDR_DEST_MODE_PHYSICAL :
-			MSI_ADDR_DEST_MODE_LOGICAL) |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(cfg->dest_apicid);
-
-	msg->data =
-		MSI_DATA_TRIGGER_EDGE |
-		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
-		MSI_DATA_VECTOR(cfg->vector);
-}
-
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	__irq_msi_compose_msg(irqd_cfg(data), msg);
-}
-
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
 	struct msi_msg msg[2] = { [1] = { }, };
 
-	__irq_msi_compose_msg(cfg, msg);
+	__irq_msi_compose_msg(cfg, msg, false);
 	irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
 }
 
@@ -276,6 +248,17 @@ struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
 #endif
 
 #ifdef CONFIG_DMAR_TABLE
+/*
+ * The Intel IOMMU (ab)uses the high bits of the MSI address to contain the
+ * high bits of the destination APIC ID. This can't be done in the general
+ * case for MSIs as it would be targeting real memory above 4GiB not the
+ * APIC.
+ */
+static void dmar_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	__irq_msi_compose_msg(irqd_cfg(data), msg, true);
+}
+
 static void dmar_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	dmar_msi_write(data->irq, msg);
@@ -288,6 +271,7 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_compose_msi_msg	= dmar_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
@@ -356,114 +340,3 @@ void dmar_free_hwirq(int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 #endif
-
-/*
- * MSI message composition
- */
-#ifdef CONFIG_HPET_TIMER
-static inline int hpet_dev_id(struct irq_domain *domain)
-{
-	struct msi_domain_info *info = msi_get_domain_info(domain);
-
-	return (int)(long)info->data;
-}
-
-static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
-}
-
-static struct irq_chip hpet_msi_controller __ro_after_init = {
-	.name = "HPET-MSI",
-	.irq_unmask = hpet_msi_unmask,
-	.irq_mask = hpet_msi_mask,
-	.irq_ack = irq_chip_ack_parent,
-	.irq_set_affinity = msi_domain_set_affinity,
-	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_write_msi_msg = hpet_msi_write_msg,
-	.flags = IRQCHIP_SKIP_SET_WAKE,
-};
-
-static int hpet_msi_init(struct irq_domain *domain,
-			 struct msi_domain_info *info, unsigned int virq,
-			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
-{
-	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
-			    handle_edge_irq, arg->data, "edge");
-
-	return 0;
-}
-
-static void hpet_msi_free(struct irq_domain *domain,
-			  struct msi_domain_info *info, unsigned int virq)
-{
-	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
-}
-
-static struct msi_domain_ops hpet_msi_domain_ops = {
-	.msi_init	= hpet_msi_init,
-	.msi_free	= hpet_msi_free,
-};
-
-static struct msi_domain_info hpet_msi_domain_info = {
-	.ops		= &hpet_msi_domain_ops,
-	.chip		= &hpet_msi_controller,
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
-};
-
-struct irq_domain *hpet_create_irq_domain(int hpet_id)
-{
-	struct msi_domain_info *domain_info;
-	struct irq_domain *parent, *d;
-	struct irq_alloc_info info;
-	struct fwnode_handle *fn;
-
-	if (x86_vector_domain == NULL)
-		return NULL;
-
-	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
-	if (!domain_info)
-		return NULL;
-
-	*domain_info = hpet_msi_domain_info;
-	domain_info->data = (void *)(long)hpet_id;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
-	info.devid = hpet_id;
-	parent = irq_remapping_get_irq_domain(&info);
-	if (parent == NULL)
-		parent = x86_vector_domain;
-	else
-		hpet_msi_controller.name = "IR-HPET-MSI";
-
-	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
-					      hpet_id);
-	if (!fn) {
-		kfree(domain_info);
-		return NULL;
-	}
-
-	d = msi_create_irq_domain(fn, domain_info, parent);
-	if (!d) {
-		irq_domain_free_fwnode(fn);
-		kfree(domain_info);
-	}
-	return d;
-}
-
-int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
-		    int dev_num)
-{
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.data = hc;
-	info.devid = hpet_dev_id(domain);
-	info.hwirq = dev_num;
-
-	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
-}
-#endif
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b6f7c049ec..a61f642b1b90 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -69,16 +69,13 @@ static struct apic apic_default __ro_after_init = {
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	/* logical delivery broadcast to all CPUs: */
-	.irq_dest_mode			= 1,
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= default_check_apicid_used,
 
+	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.setup_apic_routing		= setup_apic_flat_routing,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1eac53632786..b9b05caa28a4 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -636,7 +636,50 @@ static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 }
 #endif
 
+int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "IO-APIC-", 8) &&
+			simple_strtol(fwname+8, NULL, 10) == fwspec->param[0];
+	}
+	return to_of_node(fwspec->fwnode) &&
+		of_device_is_compatible(to_of_node(fwspec->fwnode),
+					"intel,ce4100-ioapic");
+}
+
+int x86_fwspec_is_hpet(struct irq_fwspec *fwspec)
+{
+	if (fwspec->param_count != 1)
+		return 0;
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		const char *fwname = fwnode_get_name(fwspec->fwnode);
+		return fwname && !strncmp(fwname, "HPET-MSI-", 9) &&
+			simple_strtol(fwname+9, NULL, 10) == fwspec->param[0];
+	}
+	return 0;
+}
+
+static int x86_vector_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			     enum irq_domain_bus_token bus_token)
+{
+	/*
+	 * HPET and I/OAPIC cannot be parented in the vector domain
+	 * if IRQ remapping is enabled. APIC IDs above 15 bits are
+	 * only permitted if IRQ remapping is enabled, so check that.
+	 */
+	if (apic->apic_id_valid(32768))
+		return 0;
+
+	return x86_fwspec_is_ioapic(fwspec) || x86_fwspec_is_hpet(fwspec);
+}
+
 static const struct irq_domain_ops x86_vector_domain_ops = {
+	.select		= x86_vector_select,
 	.alloc		= x86_vector_alloc_irqs,
 	.free		= x86_vector_free_irqs,
 	.activate	= x86_vector_activate,
@@ -818,6 +861,12 @@ void apic_ack_edge(struct irq_data *irqd)
 	apic_ack_irq(irqd);
 }
 
+static void x86_vector_msi_compose_msg(struct irq_data *data,
+				       struct msi_msg *msg)
+{
+       __irq_msi_compose_msg(irqd_cfg(data), msg, false);
+}
+
 static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b0889c48a2ac..df6adc5674c9 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -61,7 +61,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 		if (!dest)
 			continue;
 
-		__x2apic_send_IPI_dest(dest, vector, apic->dest_logical);
+		__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 		/* Remove cluster CPUs from tmpmask */
 		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
 	}
@@ -184,15 +184,13 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 1, /* logical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= true,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index bc9693841353..0e4e81971567 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -8,6 +8,12 @@
 int x2apic_phys;
 
 static struct apic apic_x2apic_phys;
+static u32 x2apic_max_apicid __ro_after_init;
+
+void __init x2apic_set_max_apicid(u32 apicid)
+{
+	x2apic_max_apicid = apicid;
+}
 
 static int __init set_x2apic_phys_mode(char *arg)
 {
@@ -98,6 +104,9 @@ static int x2apic_phys_probe(void)
 /* Common x2apic functions, also used by x2apic_cluster */
 int x2apic_apic_id_valid(u32 apicid)
 {
+	if (x2apic_max_apicid && apicid > x2apic_max_apicid)
+		return 0;
+
 	return 1;
 }
 
@@ -148,15 +157,13 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 0, /* physical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
-	.dest_logical			= 0,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 714233cee0b5..de94181f4d0c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -703,9 +703,9 @@ static void uv_send_IPI_one(int cpu, int vector)
 	unsigned long dmode, val;
 
 	if (vector == NMI_VECTOR)
-		dmode = dest_NMI;
+		dmode = APIC_DELIVERY_MODE_NMI;
 	else
-		dmode = dest_Fixed;
+		dmode = APIC_DELIVERY_MODE_FIXED;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 		(apicid << UVH_IPI_INT_APIC_ID_SHFT) |
@@ -807,15 +807,13 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.apic_id_valid			= uv_apic_id_valid,
 	.apic_id_registered		= uv_apic_id_registered,
 
-	.irq_delivery_mode		= dest_Fixed,
-	.irq_dest_mode			= 0, /* Physical */
+	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
+	.dest_mode_logical		= false,
 
 	.disable_esr			= 0,
-	.dest_logical			= APIC_DEST_LOGICAL,
-	.check_apicid_used		= NULL,
 
+	.check_apicid_used		= NULL,
 	.init_apic_ldr			= uv_init_apic_ldr,
-
 	.ioapic_phys_id_map		= NULL,
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 05ef1f4550cb..f628e3dc150f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -366,9 +366,38 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 }
 
+static bool __init ms_hyperv_x2apic_available(void)
+{
+	return x2apic_supported();
+}
+
+/*
+ * If ms_hyperv_msi_ext_dest_id() returns true, hyperv_prepare_irq_remapping()
+ * returns -ENODEV and the Hyper-V IOMMU driver is not used; instead, the
+ * generic support of the 15-bit APIC ID is used: see __irq_msi_compose_msg().
+ *
+ * Note: for a VM on Hyper-V, the I/O-APIC is the only device which
+ * (logically) generates MSIs directly to the system APIC irq domain.
+ * There is no HPET, and PCI MSI/MSI-X interrupts are remapped by the
+ * pci-hyperv host bridge.
+ */
+static bool __init ms_hyperv_msi_ext_dest_id(void)
+{
+	u32 eax;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
+	if (eax != HYPERV_VS_INTERFACE_EAX_SIGNATURE)
+		return false;
+
+	eax = cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
+	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
 	.type			= X86_HYPER_MS_HYPERV,
+	.init.x2apic_available	= ms_hyperv_x2apic_available,
+	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
 };
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index ddffd80f5c52..6a4cb71c2498 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -184,31 +184,31 @@ static unsigned int ioapic_id;
 
 struct of_ioapic_type {
 	u32 out_type;
-	u32 trigger;
-	u32 polarity;
+	u32 is_level;
+	u32 active_low;
 };
 
 static struct of_ioapic_type of_ioapic_type[] =
 {
 	{
-		.out_type	= IRQ_TYPE_EDGE_RISING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_EDGE_FALLING,
+		.is_level	= 0,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_LOW,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_LEVEL_HIGH,
+		.is_level	= 1,
+		.active_low	= 0,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_HIGH,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_LEVEL_LOW,
+		.is_level	= 1,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_EDGE_FALLING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_EDGE_RISING,
+		.is_level	= 0,
+		.active_low	= 0,
 	},
 };
 
@@ -228,7 +228,7 @@ static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -EINVAL;
 
 	it = &of_ioapic_type[type_index];
-	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
+	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->is_level, it->active_low);
 	tmp.devid = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
 	tmp.ioapic.pin = fwspec->param[0];
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7a50f0b62a70..08651a4e6aa0 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 
@@ -50,7 +51,7 @@ unsigned long				hpet_address;
 u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
 
-#ifdef CONFIG_PCI_MSI
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
@@ -467,9 +468,8 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 /*
  * HPET MSI Support
  */
-#ifdef CONFIG_PCI_MSI
-
-void hpet_msi_unmask(struct irq_data *data)
+#ifdef CONFIG_GENERIC_MSI_IRQ
+static void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -479,7 +479,7 @@ void hpet_msi_unmask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_mask(struct irq_data *data)
+static void hpet_msi_mask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
@@ -489,12 +489,122 @@ void hpet_msi_mask(struct irq_data *data)
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
+static void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 {
 	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
+static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
+}
+
+static struct irq_chip hpet_msi_controller __ro_after_init = {
+	.name = "HPET-MSI",
+	.irq_unmask = hpet_msi_unmask,
+	.irq_mask = hpet_msi_mask,
+	.irq_ack = irq_chip_ack_parent,
+	.irq_set_affinity = msi_domain_set_affinity,
+	.irq_retrigger = irq_chip_retrigger_hierarchy,
+	.irq_write_msi_msg = hpet_msi_write_msg,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int hpet_msi_init(struct irq_domain *domain,
+			 struct msi_domain_info *info, unsigned int virq,
+			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
+
+	return 0;
+}
+
+static void hpet_msi_free(struct irq_domain *domain,
+			  struct msi_domain_info *info, unsigned int virq)
+{
+	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
+}
+
+static struct msi_domain_ops hpet_msi_domain_ops = {
+	.msi_init	= hpet_msi_init,
+	.msi_free	= hpet_msi_free,
+};
+
+static struct msi_domain_info hpet_msi_domain_info = {
+	.ops		= &hpet_msi_domain_ops,
+	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
+};
+
+static struct irq_domain *hpet_create_irq_domain(int hpet_id)
+{
+	struct msi_domain_info *domain_info;
+	struct irq_domain *parent, *d;
+	struct fwnode_handle *fn;
+	struct irq_fwspec fwspec;
+
+	if (x86_vector_domain == NULL)
+		return NULL;
+
+	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
+	if (!domain_info)
+		return NULL;
+
+	*domain_info = hpet_msi_domain_info;
+	domain_info->data = (void *)(long)hpet_id;
+
+	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
+					      hpet_id);
+	if (!fn) {
+		kfree(domain_info);
+		return NULL;
+	}
+
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = hpet_id;
+
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+		return NULL;
+	}
+	if (parent != x86_vector_domain)
+		hpet_msi_controller.name = "IR-HPET-MSI";
+
+	d = msi_create_irq_domain(fn, domain_info, parent);
+	if (!d) {
+		irq_domain_free_fwnode(fn);
+		kfree(domain_info);
+	}
+	return d;
+}
+
+static inline int hpet_dev_id(struct irq_domain *domain)
+{
+	struct msi_domain_info *info = msi_get_domain_info(domain);
+
+	return (int)(long)info->data;
+}
+
+static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
+			   int dev_num)
+{
+	struct irq_alloc_info info;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
+
+	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+}
+
 static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
 	struct hpet_channel *hc = clockevent_to_channel(evt);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f57ede3cb8e..5e78e01ca3b4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -740,6 +740,11 @@ static void __init kvm_apic_init(void)
 #endif
 }
 
+static bool __init kvm_msi_ext_dest_id(void)
+{
+	return kvm_para_has_feature(KVM_FEATURE_MSI_EXT_DEST_ID);
+}
+
 static void __init kvm_init_platform(void)
 {
 	kvmclock_init();
@@ -769,6 +774,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.type				= X86_HYPER_KVM,
 	.init.guest_late_init		= kvm_guest_init,
 	.init.x2apic_available		= kvm_para_available,
+	.init.msi_ext_dest_id		= kvm_msi_ext_dest_id,
 	.init.init_platform		= kvm_init_platform,
 #if defined(CONFIG_AMD_MEM_ENCRYPT)
 	.runtime.sev_es_hcall_prepare	= kvm_sev_es_hcall_prepare,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..d133d6580f41 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -747,13 +747,14 @@ static void __init smp_quirk_init_udelay(void)
 int
 wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
 {
+	u32 dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
 	unsigned long send_status, accept_status = 0;
 	int maxlvt;
 
 	/* Target chip */
 	/* Boot on the stack */
 	/* Kick the second */
-	apic_icr_write(APIC_DM_NMI | apic->dest_logical, apicid);
+	apic_icr_write(APIC_DM_NMI | dm, apicid);
 
 	pr_debug("Waiting for send to finish...\n");
 	send_status = safe_apic_wait_icr_idle();
@@ -980,10 +981,7 @@ wakeup_cpu_via_init_nmi(int cpu, unsigned long start_ip, int apicid,
 	if (!boot_error) {
 		enable_start_cpu0 = 1;
 		*cpu0_nmi_registered = 1;
-		if (apic->dest_logical == APIC_DEST_LOGICAL)
-			id = cpu0_logical_apicid;
-		else
-			id = apicid;
+		id = apic->dest_mode_logical ? cpu0_logical_apicid : apicid;
 		boot_error = wakeup_secondary_cpu_via_nmi(id, start_ip);
 	}
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a3038d8deb6a..8b395821cb8d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -110,6 +110,7 @@ struct x86_init_ops x86_init __initdata = {
 		.init_platform		= x86_init_noop,
 		.guest_late_init	= x86_init_noop,
 		.x2apic_available	= bool_x86_init_noop,
+		.msi_ext_dest_id	= bool_x86_init_noop,
 		.init_mem_mapping	= x86_init_noop,
 		.init_after_bootmem	= x86_init_noop,
 	},
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 4aa1c2e00e2a..8a4de3f12820 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -16,8 +16,6 @@
 
 #include <trace/events/kvm.h>
 
-#include <asm/msidef.h>
-
 #include "irq.h"
 
 #include "ioapic.h"
@@ -104,22 +102,19 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 void kvm_set_msi_irq(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 		     struct kvm_lapic_irq *irq)
 {
-	trace_kvm_msi_set_irq(e->msi.address_lo | (kvm->arch.x2apic_format ?
-	                                     (u64)e->msi.address_hi << 32 : 0),
-	                      e->msi.data);
-
-	irq->dest_id = (e->msi.address_lo &
-			MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
-	if (kvm->arch.x2apic_format)
-		irq->dest_id |= MSI_ADDR_EXT_DEST_ID(e->msi.address_hi);
-	irq->vector = (e->msi.data &
-			MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
-	irq->dest_mode = kvm_lapic_irq_dest_mode(
-	    !!((1 << MSI_ADDR_DEST_MODE_SHIFT) & e->msi.address_lo));
-	irq->trig_mode = (1 << MSI_DATA_TRIGGER_SHIFT) & e->msi.data;
-	irq->delivery_mode = e->msi.data & 0x700;
-	irq->msi_redir_hint = ((e->msi.address_lo
-		& MSI_ADDR_REDIRECTION_LOWPRI) > 0);
+	struct msi_msg msg = { .address_lo = e->msi.address_lo,
+			       .address_hi = e->msi.address_hi,
+			       .data = e->msi.data };
+
+	trace_kvm_msi_set_irq(msg.address_lo | (kvm->arch.x2apic_format ?
+			      (u64)msg.address_hi << 32 : 0), msg.data);
+
+	irq->dest_id = x86_msi_msg_get_destid(&msg, kvm->arch.x2apic_format);
+	irq->vector = msg.arch_data.vector;
+	irq->dest_mode = kvm_lapic_irq_dest_mode(msg.arch_addr_lo.dest_mode_logical);
+	irq->trig_mode = msg.arch_data.is_level;
+	irq->delivery_mode = msg.arch_data.delivery_mode << 8;
+	irq->msi_redir_hint = msg.arch_addr_lo.redirect_hint;
 	irq->level = 1;
 	irq->shorthand = APIC_DEST_NOSHORT;
 }
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 24ca4ee2802f..95e2e6bd8d8c 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -215,7 +215,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
 	struct irq_alloc_info info;
-	int polarity;
+	bool polarity_low;
 	int ret;
 	u8 gsi;
 
@@ -230,7 +230,7 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 
 	switch (intel_mid_identify_cpu()) {
 	case INTEL_MID_CPU_CHIP_TANGIER:
-		polarity = IOAPIC_POL_HIGH;
+		polarity_low = false;
 
 		/* Special treatment for IRQ0 */
 		if (gsi == 0) {
@@ -252,11 +252,11 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		}
 		break;
 	default:
-		polarity = IOAPIC_POL_LOW;
+		polarity_low = true;
 		break;
 	}
 
-	ioapic_set_alloc_attr(&info, dev_to_node(&dev->dev), 1, polarity);
+	ioapic_set_alloc_attr(&info, dev_to_node(&dev->dev), 1, polarity_low);
 
 	/*
 	 * MRST only have IOAPIC, the PCI irq lines are 1:1 mapped to
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index c552cd2d0632..3d41a09c2c14 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -152,7 +152,6 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 
 #if defined(CONFIG_PCI_MSI)
 #include <linux/msi.h>
-#include <asm/msidef.h>
 
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
@@ -210,23 +209,20 @@ static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return ret;
 }
 
-#define XEN_PIRQ_MSI_DATA  (MSI_DATA_TRIGGER_EDGE | \
-		MSI_DATA_LEVEL_ASSERT | (3 << 8) | MSI_DATA_VECTOR(0))
-
 static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 		struct msi_msg *msg)
 {
-	/* We set vector == 0 to tell the hypervisor we don't care about it,
-	 * but we want a pirq setup instead.
-	 * We use the dest_id field to pass the pirq that we want. */
-	msg->address_hi = MSI_ADDR_BASE_HI | MSI_ADDR_EXT_DEST_ID(pirq);
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		MSI_ADDR_DEST_MODE_PHYSICAL |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(pirq);
-
-	msg->data = XEN_PIRQ_MSI_DATA;
+	/*
+	 * We set vector == 0 to tell the hypervisor we don't care about
+	 * it, but we want a pirq setup instead.  We use the dest_id fields
+	 * to pass the pirq that we want.
+	 */
+	memset(msg, 0, sizeof(*msg));
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_hi.destid_8_31 = pirq >> 8;
+	msg->arch_addr_lo.destid_0_7 = pirq & 0xFF;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
 }
 
 static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 18ca2261cc9a..1a536a187d74 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -35,8 +35,8 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 	mmr_value = 0;
 	entry = (struct uv_IO_APIC_route_entry *)&mmr_value;
 	entry->vector		= cfg->vector;
-	entry->delivery_mode	= apic->irq_delivery_mode;
-	entry->dest_mode	= apic->irq_dest_mode;
+	entry->delivery_mode	= apic->delivery_mode;
+	entry->dest_mode	= apic->dest_mode_logical;
 	entry->polarity		= 0;
 	entry->trigger		= 0;
 	entry->mask		= 0;
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index e82fd1910dae..0d46cc283cf5 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -148,15 +148,12 @@ static struct apic xen_pv_apic = {
 	.apic_id_valid 			= xen_id_always_valid,
 	.apic_id_registered 		= xen_id_always_registered,
 
-	/* .irq_delivery_mode - used in native_compose_msi_msg only */
-	/* .irq_dest_mode     - used in native_compose_msi_msg only */
+	/* .delivery_mode and .dest_mode_logical not used by XENPV */
 
 	.disable_esr			= 0,
-	/* .dest_logical      -  default_send_IPI_ use it but we use our own. */
-	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 
+	.check_apicid_used		= default_check_apicid_used, /* Used on 32-bit */
 	.init_apic_ldr			= xen_noop, /* setup_local_APIC calls it */
-
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map, /* Used on 32-bit */
 	.setup_apic_routing		= NULL,
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f696ac7c5f89..ba74a722a400 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -893,7 +893,7 @@ struct amd_ir_data {
 };
 
 struct amd_irte_ops {
-	void (*prepare)(void *, u32, u32, u8, u32, int);
+	void (*prepare)(void *, u32, bool, u8, u32, int);
 	void (*activate)(void *, u16, u16);
 	void (*deactivate)(void *, u16, u16);
 	void (*set_affinity)(void *, u16, u16, u8, u32);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 82e4af8f09bb..07d1f9913ce4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -16,6 +16,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
+#include <linux/irq.h>
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
@@ -23,7 +24,6 @@
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
-#include <asm/msidef.h>
 #include <asm/gart.h>
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
@@ -1558,14 +1558,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			break;
 		}
 
-		/*
-		 * Note: Since iommu_update_intcapxt() leverages
-		 * the IOMMU MMIO access to MSI capability block registers
-		 * for MSI address lo/hi/data, we need to check both
-		 * EFR[XtSup] and EFR[MsiCapMmioSup] for x2APIC support.
-		 */
-		if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
-		    (h->efr_reg & BIT(IOMMU_EFR_MSICAPMMIOSUP_SHIFT)))
+		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		break;
 	default:
@@ -1602,9 +1595,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (ret)
 		return ret;
 
-	ret = amd_iommu_create_irq_domain(iommu);
-	if (ret)
-		return ret;
+	if (amd_iommu_irq_remap) {
+		ret = amd_iommu_create_irq_domain(iommu);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
@@ -1966,98 +1961,190 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	return 0;
 }
 
-#define XT_INT_DEST_MODE(x)	(((x) & 0x1ULL) << 2)
-#define XT_INT_DEST_LO(x)	(((x) & 0xFFFFFFULL) << 8)
-#define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
-#define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
+union intcapxt {
+	u64	capxt;
+	struct {
+		u64	reserved_0		:  2,
+			dest_mode_logical	:  1,
+			reserved_1		:  5,
+			destid_0_23		: 24,
+			vector			:  8,
+			reserved_2		: 16,
+			destid_24_31		:  8;
+	};
+} __attribute__ ((packed));
 
 /*
- * Setup the IntCapXT registers with interrupt routing information
- * based on the PCI MSI capability block registers, accessed via
- * MMIO MSI address low/hi and MSI data registers.
+ * There isn't really any need to mask/unmask at the irqchip level because
+ * the 64-bit INTCAPXT registers can be updated atomically without tearing
+ * when the affinity is being updated.
  */
-static void iommu_update_intcapxt(struct amd_iommu *iommu)
+static void intcapxt_unmask_irq(struct irq_data *data)
 {
-	u64 val;
-	u32 addr_lo = readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
-	u32 addr_hi = readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
-	u32 data    = readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
-	bool dm     = (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
-	u32 dest    = ((addr_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xFF);
+}
+
+static void intcapxt_mask_irq(struct irq_data *data)
+{
+}
 
-	if (x2apic_enabled())
-		dest |= MSI_ADDR_EXT_DEST_ID(addr_hi);
+static struct irq_chip intcapxt_controller;
 
-	val = XT_INT_VEC(data & 0xFF) |
-	      XT_INT_DEST_MODE(dm) |
-	      XT_INT_DEST_LO(dest) |
-	      XT_INT_DEST_HI(dest);
+static int intcapxt_irqdomain_activate(struct irq_domain *domain,
+				       struct irq_data *irqd, bool reserve)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+	struct irq_cfg *cfg = irqd_cfg(irqd);
+	union intcapxt xt;
+
+	xt.capxt = 0ULL;
+	xt.dest_mode_logical = apic->dest_mode_logical;
+	xt.vector = cfg->vector;
+	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
+	xt.destid_24_31 = cfg->dest_apicid >> 24;
 
 	/**
 	 * Current IOMMU implemtation uses the same IRQ for all
 	 * 3 IOMMU interrupts.
 	 */
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	return 0;
 }
 
-static void _irq_notifier_notify(struct irq_affinity_notify *notify,
-				 const cpumask_t *mask)
+static void intcapxt_irqdomain_deactivate(struct irq_domain *domain,
+					  struct irq_data *irqd)
 {
-	struct amd_iommu *iommu;
+	intcapxt_mask_irq(irqd);
+}
 
-	for_each_iommu(iommu) {
-		if (iommu->dev->irq == notify->irq) {
-			iommu_update_intcapxt(iommu);
-			break;
-		}
+
+static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs, void *arg)
+{
+	struct irq_alloc_info *info = arg;
+	int i, ret;
+
+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_AMDVI)
+		return -EINVAL;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+	if (ret < 0)
+		return ret;
+
+	for (i = virq; i < virq + nr_irqs; i++) {
+		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
+
+		irqd->chip = &intcapxt_controller;
+		irqd->chip_data = info->data;
+		__irq_set_handler(i, handle_edge_irq, 0, "edge");
 	}
+
+	return ret;
 }
 
-static void _irq_notifier_release(struct kref *ref)
+static void intcapxt_irqdomain_free(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
 {
+	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
-static int iommu_init_intcapxt(struct amd_iommu *iommu)
+static int intcapxt_set_affinity(struct irq_data *irqd,
+				 const struct cpumask *mask, bool force)
 {
+	struct irq_data *parent = irqd->parent_data;
 	int ret;
-	struct irq_affinity_notify *notify = &iommu->intcapxt_notify;
 
-	/**
-	 * IntCapXT requires XTSup=1 and MsiCapMmioSup=1,
-	 * which can be inferred from amd_iommu_xt_mode.
-	 */
-	if (amd_iommu_xt_mode != IRQ_REMAP_X2APIC_MODE)
-		return 0;
+	ret = parent->chip->irq_set_affinity(parent, mask, force);
+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
+		return ret;
 
-	/**
-	 * Also, we need to setup notifier to update the IntCapXT registers
-	 * whenever the irq affinity is changed from user-space.
-	 */
-	notify->irq = iommu->dev->irq;
-	notify->notify = _irq_notifier_notify,
-	notify->release = _irq_notifier_release,
-	ret = irq_set_affinity_notifier(iommu->dev->irq, notify);
+	return intcapxt_irqdomain_activate(irqd->domain, irqd, false);
+}
+
+static struct irq_chip intcapxt_controller = {
+	.name			= "IOMMU-MSI",
+	.irq_unmask		= intcapxt_unmask_irq,
+	.irq_mask		= intcapxt_mask_irq,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity       = intcapxt_set_affinity,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static const struct irq_domain_ops intcapxt_domain_ops = {
+	.alloc			= intcapxt_irqdomain_alloc,
+	.free			= intcapxt_irqdomain_free,
+	.activate		= intcapxt_irqdomain_activate,
+	.deactivate		= intcapxt_irqdomain_deactivate,
+};
+
+
+static struct irq_domain *iommu_irqdomain;
+
+static struct irq_domain *iommu_get_irqdomain(void)
+{
+	struct fwnode_handle *fn;
+
+	/* No need for locking here (yet) as the init is single-threaded */
+	if (iommu_irqdomain)
+		return iommu_irqdomain;
+
+	fn = irq_domain_alloc_named_fwnode("AMD-Vi-MSI");
+	if (!fn)
+		return NULL;
+
+	iommu_irqdomain = irq_domain_create_hierarchy(x86_vector_domain, 0, 0,
+						      fn, &intcapxt_domain_ops,
+						      NULL);
+	if (!iommu_irqdomain)
+		irq_domain_free_fwnode(fn);
+
+	return iommu_irqdomain;
+}
+
+static int iommu_setup_intcapxt(struct amd_iommu *iommu)
+{
+	struct irq_domain *domain;
+	struct irq_alloc_info info;
+	int irq, ret;
+
+	domain = iommu_get_irqdomain();
+	if (!domain)
+		return -ENXIO;
+
+	init_irq_alloc_info(&info, NULL);
+	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
+	info.data = iommu;
+
+	irq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
+	if (irq < 0) {
+		irq_domain_remove(domain);
+		return irq;
+	}
+
+	ret = request_threaded_irq(irq, amd_iommu_int_handler,
+				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
 	if (ret) {
-		pr_err("Failed to register irq affinity notifier (devid=%#x, irq %d)\n",
-		       iommu->devid, iommu->dev->irq);
+		irq_domain_free_irqs(irq, 1);
+		irq_domain_remove(domain);
 		return ret;
 	}
 
-	iommu_update_intcapxt(iommu);
 	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
-	return ret;
+	return 0;
 }
 
-static int iommu_init_msi(struct amd_iommu *iommu)
+static int iommu_init_irq(struct amd_iommu *iommu)
 {
 	int ret;
 
 	if (iommu->int_enabled)
 		goto enable_faults;
 
-	if (iommu->dev->msi_cap)
+	if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+		ret = iommu_setup_intcapxt(iommu);
+	else if (iommu->dev->msi_cap)
 		ret = iommu_setup_msi(iommu);
 	else
 		ret = -ENODEV;
@@ -2066,10 +2153,6 @@ static int iommu_init_msi(struct amd_iommu *iommu)
 		return ret;
 
 enable_faults:
-	ret = iommu_init_intcapxt(iommu);
-	if (ret)
-		return ret;
-
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
 
 	if (iommu->ppr_log != NULL)
@@ -2692,7 +2775,7 @@ static int amd_iommu_enable_interrupts(void)
 	int ret = 0;
 
 	for_each_iommu(iommu) {
-		ret = iommu_init_msi(iommu);
+		ret = iommu_init_irq(iommu);
 		if (ret)
 			goto out;
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf59443843..463d322a4f3b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -35,7 +35,6 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/hw_irq.h>
-#include <asm/msidef.h>
 #include <asm/proto.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -3466,7 +3465,7 @@ static void free_irte(u16 devid, int index)
 }
 
 static void irte_prepare(void *entry,
-			 u32 delivery_mode, u32 dest_mode,
+			 u32 delivery_mode, bool dest_mode,
 			 u8 vector, u32 dest_apicid, int devid)
 {
 	union irte *irte = (union irte *) entry;
@@ -3480,7 +3479,7 @@ static void irte_prepare(void *entry,
 }
 
 static void irte_ga_prepare(void *entry,
-			    u32 delivery_mode, u32 dest_mode,
+			    u32 delivery_mode, bool dest_mode,
 			    u8 vector, u32 dest_apicid, int devid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
@@ -3602,10 +3601,8 @@ static int get_devid(struct irq_alloc_info *info)
 {
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
 		return get_ioapic_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
 		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
@@ -3616,54 +3613,28 @@ static int get_devid(struct irq_alloc_info *info)
 	}
 }
 
-static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
-						   int devid)
-{
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
-	if (!iommu)
-		return NULL;
-
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return iommu->ir_domain;
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-}
-
-static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
-{
-	int devid;
-
-	if (!info)
-		return NULL;
-
-	devid = get_devid(info);
-	if (devid < 0)
-		return NULL;
-	return get_irq_domain_for_devid(info, devid);
-}
-
 struct irq_remap_ops amd_iommu_irq_ops = {
 	.prepare		= amd_iommu_prepare,
 	.enable			= amd_iommu_enable,
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_irq_domain		= get_irq_domain,
 };
 
+static void fill_msi_msg(struct msi_msg *msg, u32 index)
+{
+	msg->data = index;
+	msg->address_lo = 0;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+}
+
 static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       struct irq_cfg *irq_cfg,
 				       struct irq_alloc_info *info,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct msi_msg *msg = &data->msi_entry;
-	struct IO_APIC_route_entry *entry;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	if (!iommu)
@@ -3671,31 +3642,16 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 
 	data->irq_2_irte.devid = devid;
 	data->irq_2_irte.index = index + sub_handle;
-	iommu->irte_ops->prepare(data->entry, apic->irq_delivery_mode,
-				 apic->irq_dest_mode, irq_cfg->vector,
+	iommu->irte_ops->prepare(data->entry, apic->delivery_mode,
+				 apic->dest_mode_logical, irq_cfg->vector,
 				 irq_cfg->dest_apicid, devid);
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		/* Setup IOAPIC entry */
-		entry = info->ioapic.entry;
-		info->ioapic.entry = NULL;
-		memset(entry, 0, sizeof(*entry));
-		entry->vector        = index;
-		entry->mask          = 0;
-		entry->trigger       = info->ioapic.trigger;
-		entry->polarity      = info->ioapic.polarity;
-		/* Mask level triggered irqs. */
-		if (info->ioapic.trigger)
-			entry->mask = 1;
-		break;
-
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		msg->address_hi = MSI_ADDR_BASE_HI;
-		msg->address_lo = MSI_ADDR_BASE_LO;
-		msg->data = irte_info->index;
+		fill_msi_msg(&data->msi_entry, irte_info->index);
 		break;
 
 	default:
@@ -3892,7 +3848,26 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 					    irte_info->index);
 }
 
+static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				enum irq_domain_bus_token bus_token)
+{
+	struct amd_iommu *iommu;
+	int devid = -1;
+
+	if (x86_fwspec_is_ioapic(fwspec))
+		devid = get_ioapic_devid(fwspec->param[0]);
+	else if (x86_fwspec_is_hpet(fwspec))
+		devid = get_hpet_devid(fwspec->param[0]);
+
+	if (devid < 0)
+		return 0;
+
+	iommu = amd_iommu_rlookup_table[devid];
+	return iommu && iommu->ir_domain == d;
+}
+
 static const struct irq_domain_ops amd_ir_domain_ops = {
+	.select = irq_remapping_select,
 	.alloc = irq_remapping_alloc,
 	.free = irq_remapping_free,
 	.activate = irq_remapping_activate,
@@ -3943,8 +3918,8 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	entry->hi.val = 0;
 
 	entry->lo.fields_remap.valid       = valid;
-	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
-	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
+	entry->lo.fields_remap.dm          = apic->dest_mode_logical;
+	entry->lo.fields_remap.int_type    = apic->delivery_mode;
 	entry->hi.fields.vector            = cfg->vector;
 	entry->lo.fields_remap.destination =
 				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e09e2d734c57..1d21a0b5f724 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -40,7 +40,6 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 {
 	struct irq_data *parent = data->parent_data;
 	struct irq_cfg *cfg = irqd_cfg(data);
-	struct IO_APIC_route_entry *entry;
 	int ret;
 
 	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
@@ -51,9 +50,6 @@ static int hyperv_ir_set_affinity(struct irq_data *data,
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	entry = data->chip_data;
-	entry->dest = cfg->dest_apicid;
-	entry->vector = cfg->vector;
 	send_cleanup_vector(cfg);
 
 	return 0;
@@ -89,20 +85,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 
 	irq_data->chip = &hyperv_ir_chip;
 
-	/*
-	 * If there is interrupt remapping function of IOMMU, setting irq
-	 * affinity only needs to change IRTE of IOMMU. But Hyper-V doesn't
-	 * support interrupt remapping function, setting irq affinity of IO-APIC
-	 * interrupts still needs to change IO-APIC registers. But ioapic_
-	 * configure_entry() will ignore value of cfg->vector and cfg->
-	 * dest_apicid when IO-APIC's parent irq domain is not the vector
-	 * domain.(See ioapic_configure_entry()) In order to setting vector
-	 * and dest_apicid to IO-APIC register, IO-APIC entry pointer is saved
-	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
-	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
-	 */
-	irq_data->chip_data = info->ioapic.entry;
-
 	/*
 	 * Hypver-V IO APIC irq affinity should be in the scope of
 	 * ioapic_max_cpumask because no irq remapping support.
@@ -119,22 +101,18 @@ static void hyperv_irq_remapping_free(struct irq_domain *domain,
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
 
-static int hyperv_irq_remapping_activate(struct irq_domain *domain,
-			  struct irq_data *irq_data, bool reserve)
+static int hyperv_irq_remapping_select(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
 {
-	struct irq_cfg *cfg = irqd_cfg(irq_data);
-	struct IO_APIC_route_entry *entry = irq_data->chip_data;
-
-	entry->dest = cfg->dest_apicid;
-	entry->vector = cfg->vector;
-
-	return 0;
+	/* Claim the only I/O APIC emulated by Hyper-V */
+	return x86_fwspec_is_ioapic(fwspec);
 }
 
 static const struct irq_domain_ops hyperv_ir_domain_ops = {
+	.select = hyperv_irq_remapping_select,
 	.alloc = hyperv_irq_remapping_alloc,
 	.free = hyperv_irq_remapping_free,
-	.activate = hyperv_irq_remapping_activate,
 };
 
 static int __init hyperv_prepare_irq_remapping(void)
@@ -143,6 +121,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 	int i;
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
+	    x86_init.hyper.msi_ext_dest_id() ||
 	    !x2apic_supported())
 		return -ENODEV;
 
@@ -182,18 +161,9 @@ static int __init hyperv_enable_irq_remapping(void)
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
-		return ioapic_ir_domain;
-	else
-		return NULL;
-}
-
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 0cfce1d3b7bb..aeffda92b10b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -20,7 +20,6 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
-#include <asm/msidef.h>
 
 #include "../irq_remapping.h"
 
@@ -204,13 +203,13 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	return rc;
 }
 
-static struct irq_domain *map_hpet_to_ir(u8 hpet_id)
+static struct intel_iommu *map_hpet_to_iommu(u8 hpet_id)
 {
 	int i;
 
 	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].id == hpet_id && ir_hpet[i].iommu)
-			return ir_hpet[i].iommu->ir_domain;
+			return ir_hpet[i].iommu;
 	}
 	return NULL;
 }
@@ -226,13 +225,6 @@ static struct intel_iommu *map_ioapic_to_iommu(int apic)
 	return NULL;
 }
 
-static struct irq_domain *map_ioapic_to_ir(int apic)
-{
-	struct intel_iommu *iommu = map_ioapic_to_iommu(apic);
-
-	return iommu ? iommu->ir_domain : NULL;
-}
-
 static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
 {
 	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
@@ -1113,7 +1105,7 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	memset(irte, 0, sizeof(*irte));
 
 	irte->present = 1;
-	irte->dst_mode = apic->irq_dest_mode;
+	irte->dst_mode = apic->dest_mode_logical;
 	/*
 	 * Trigger mode in the IRTE will always be edge, and for IO-APIC, the
 	 * actual level or edge trigger will be setup in the IO-APIC
@@ -1122,35 +1114,18 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->irq_delivery_mode;
+	irte->dlvry_mode = apic->delivery_mode;
 	irte->vector = vector;
 	irte->dest_id = IRTE_DEST(dest);
 	irte->redir_hint = 1;
 }
 
-static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (!info)
-		return NULL;
-
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
-		return map_ioapic_to_ir(info->devid);
-	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
-		return map_hpet_to_ir(info->devid);
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-}
-
 struct irq_remap_ops intel_irq_remap_ops = {
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_irq_domain		= intel_get_irq_domain,
 };
 
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
@@ -1260,16 +1235,30 @@ static struct irq_chip intel_ir_chip = {
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
 };
 
+static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
+{
+	memset(msg, 0, sizeof(*msg));
+
+	msg->arch_addr_lo.dmar_base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.dmar_subhandle_valid = true;
+	msg->arch_addr_lo.dmar_format = true;
+	msg->arch_addr_lo.dmar_index_0_14 = index & 0x7FFF;
+	msg->arch_addr_lo.dmar_index_15 = !!(index & 0x8000);
+
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+
+	msg->arch_data.dmar_subhandle = subhandle;
+}
+
 static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 					     struct irq_cfg *irq_cfg,
 					     struct irq_alloc_info *info,
 					     int index, int sub_handle)
 {
-	struct IR_IO_APIC_route_entry *entry;
 	struct irte *irte = &data->irte_entry;
-	struct msi_msg *msg = &data->msi_entry;
 
 	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
+
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
@@ -1280,46 +1269,20 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 			irte->trigger_mode, irte->dlvry_mode,
 			irte->avail, irte->vector, irte->dest_id,
 			irte->sid, irte->sq, irte->svt);
-
-		entry = (struct IR_IO_APIC_route_entry *)info->ioapic.entry;
-		info->ioapic.entry = NULL;
-		memset(entry, 0, sizeof(*entry));
-		entry->index2	= (index >> 15) & 0x1;
-		entry->zero	= 0;
-		entry->format	= 1;
-		entry->index	= (index & 0x7fff);
-		/*
-		 * IO-APIC RTE will be configured with virtual vector.
-		 * irq handler will do the explicit EOI to the io-apic.
-		 */
-		entry->vector	= info->ioapic.pin;
-		entry->mask	= 0;			/* enable IRQ */
-		entry->trigger	= info->ioapic.trigger;
-		entry->polarity	= info->ioapic.polarity;
-		if (info->ioapic.trigger)
-			entry->mask = 1; /* Mask level triggered irqs. */
+		sub_handle = info->ioapic.pin;
 		break;
-
 	case X86_IRQ_ALLOC_TYPE_HPET:
+		set_hpet_sid(irte, info->devid);
+		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->devid);
-		else
-			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
-
-		msg->address_hi = MSI_ADDR_BASE_HI;
-		msg->data = sub_handle;
-		msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_IR_EXT_INT |
-				  MSI_ADDR_IR_SHV |
-				  MSI_ADDR_IR_INDEX1(index) |
-				  MSI_ADDR_IR_INDEX2(index);
+		set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 		break;
-
 	default:
 		BUG_ON(1);
 		break;
 	}
+	fill_msi_msg(&data->msi_entry, index, sub_handle);
 }
 
 static void intel_free_irq_resources(struct irq_domain *domain,
@@ -1444,7 +1407,22 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	modify_irte(&data->irq_2_iommu, &entry);
 }
 
+static int intel_irq_remapping_select(struct irq_domain *d,
+				      struct irq_fwspec *fwspec,
+				      enum irq_domain_bus_token bus_token)
+{
+	struct intel_iommu *iommu = NULL;
+
+	if (x86_fwspec_is_ioapic(fwspec))
+		iommu = map_ioapic_to_iommu(fwspec->param[0]);
+	else if (x86_fwspec_is_hpet(fwspec))
+		iommu = map_hpet_to_iommu(fwspec->param[0]);
+
+	return iommu && d == iommu->ir_domain;
+}
+
 static const struct irq_domain_ops intel_ir_domain_ops = {
+	.select = intel_irq_remapping_select,
 	.alloc = intel_irq_remapping_alloc,
 	.free = intel_irq_remapping_free,
 	.activate = intel_irq_remapping_activate,
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 2d84b1ed205e..83314b9d8f38 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -158,17 +158,3 @@ void panic_if_irq_remap(const char *msg)
 	if (irq_remapping_enabled)
 		panic(msg);
 }
-
-/**
- * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_irq_domain)
-		return NULL;
-
-	return remap_ops->get_irq_domain(info);
-}
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 1661b3d75920..8c89cb947cdb 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -42,9 +42,6 @@ struct irq_remap_ops {
 
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
-
-	/* Get the irqdomain associated to IOMMU device */
-	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 03ed5cb1c4b2..6db8d96a78eb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1226,7 +1226,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params->int_target.vector = cfg->vector;
 
 	/*
-	 * Honoring apic->irq_delivery_mode set to dest_Fixed by
+	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
 	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
 	 * spurious interrupt storm. Not doing so does not seem to have a
 	 * negative effect (yet?).
@@ -1324,7 +1324,7 @@ static u32 hv_compose_msi_req_v1(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
@@ -1345,7 +1345,7 @@ static u32 hv_compose_msi_req_v2(
 	int_pkt->wslot.slot = slot;
 	int_pkt->int_desc.vector = vector;
 	int_pkt->int_desc.vector_count = 1;
-	int_pkt->int_desc.delivery_mode = dest_Fixed;
+	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
 
 	/*
 	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f375c21ceeb1..6f8795454e5a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -18,7 +18,6 @@
 #include <asm/irqdomain.h>
 #include <asm/device.h>
 #include <asm/msi.h>
-#include <asm/msidef.h>
 
 #define VMD_CFGBAR	0
 #define VMD_MEMBAR1	2
@@ -131,10 +130,10 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct vmd_irq_list *irq = vmdirq->irq;
 	struct vmd_dev *vmd = irq_data_get_irq_handler_data(data);
 
-	msg->address_hi = MSI_ADDR_BASE_HI;
-	msg->address_lo = MSI_ADDR_BASE_LO |
-			  MSI_ADDR_DEST_ID(index_from_irqs(vmd, irq));
-	msg->data = 0;
+	memset(msg, 0, sizeof(*msg));
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.destid_0_7 = index_from_irqs(vmd, irq);
 }
 
 /*
diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index e6795f088bdd..25344de0e8f9 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+
 #ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
 # define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
 #endif
@@ -30,4 +32,6 @@ typedef struct msi_alloc_info {
 
 #define GENERIC_MSI_DOMAIN_OPS		1
 
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+
 #endif
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6b584cc4757c..360a0a7e7341 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -4,11 +4,50 @@
 
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <asm/msi.h>
+
+/* Dummy shadow structures if an architecture does not define them */
+#ifndef arch_msi_msg_addr_lo
+typedef struct arch_msi_msg_addr_lo {
+	u32	address_lo;
+} __attribute__ ((packed)) arch_msi_msg_addr_lo_t;
+#endif
+
+#ifndef arch_msi_msg_addr_hi
+typedef struct arch_msi_msg_addr_hi {
+	u32	address_hi;
+} __attribute__ ((packed)) arch_msi_msg_addr_hi_t;
+#endif
+
+#ifndef arch_msi_msg_data
+typedef struct arch_msi_msg_data {
+	u32	data;
+} __attribute__ ((packed)) arch_msi_msg_data_t;
+#endif
 
+/**
+ * msi_msg - Representation of a MSI message
+ * @address_lo:		Low 32 bits of msi message address
+ * @arch_addrlo:	Architecture specific shadow of @address_lo
+ * @address_hi:		High 32 bits of msi message address
+ *			(only used when device supports it)
+ * @arch_addrhi:	Architecture specific shadow of @address_hi
+ * @data:		MSI message data (usually 16 bits)
+ * @arch_data:		Architecture specific shadow of @data
+ */
 struct msi_msg {
-	u32	address_lo;	/* low 32 bits of msi message address */
-	u32	address_hi;	/* high 32 bits of msi message address */
-	u32	data;		/* 16 bits of msi message data */
+	union {
+		u32			address_lo;
+		arch_msi_msg_addr_lo_t	arch_addr_lo;
+	};
+	union {
+		u32			address_hi;
+		arch_msi_msg_addr_hi_t	arch_addr_hi;
+	};
+	union {
+		u32			data;
+		arch_msi_msg_data_t	arch_data;
+	};
 };
 
 extern int pci_msi_ignore_mask;
@@ -243,7 +282,6 @@ struct msi_controller {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 
 #include <linux/irqhandler.h>
-#include <asm/msi.h>
 
 struct irq_domain;
 struct irq_domain_ops;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..673fa64c1c44 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -42,7 +42,16 @@ static inline void debugfs_add_domain_dir(struct irq_domain *d) { }
 static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
 #endif
 
-const struct fwnode_operations irqchip_fwnode_ops;
+static const char *irqchip_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+
+	return fwid->name;
+}
+
+const struct fwnode_operations irqchip_fwnode_ops = {
+	.get_name = irqchip_fwnode_get_name,
+};
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
 /**

