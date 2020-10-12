Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDEA28B566
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgJLNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:00:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgJLNAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:00:24 -0400
Date:   Mon, 12 Oct 2020 12:59:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602507612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ctWaBAJrI83iBZxv0Wr5NPI0h8lhoclD9e3HfhquOOk=;
        b=iZy7a/Cu2PeObirftrLwjXbxdO47PLsvDOijrxEfCid4h91Vnju9oj42EcleLRav5aHU2z
        h+qmEGo5wFlSDPTdgWaI3lmPN7ufnedCN5M97wd4sw8xLWl3P+nYuOt/td3SIQjMZ+ioqm
        lk74PRsgdiF2ZpiTXmwmCpzBvqZo+PEkIo0D8XpbBXytBHPnd6K1BQfUWQ/vpOzS1+bsb7
        g8/jhJ/wXmv+0KFqmfZ5pyGg7fuY0MV8ikCYN7f5Lva800IWwy2KAGVD2+e15I3HJApfme
        BJbrMtQCqjya2DazLxm3vWRp07Q68DiLDdBa56/wQpRx64ZZcxJ/Ow829WV+6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602507612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ctWaBAJrI83iBZxv0Wr5NPI0h8lhoclD9e3HfhquOOk=;
        b=DNg42I9quNYqcivoLyrd9dV7vwFhySfpYtOqbn0b7+BmoXea4cTe3xBH4SYka2NLj6Lkmr
        PddQH6p7DjBySBBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for 5.10-rc1
References: <160250758161.26264.880601562259119308.tglx@nanos>
Message-ID: <160250758525.26264.5041088866604906303.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/irq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2020-10-12

up to:  981aa1d366bf: PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACKS

Surgery of the MSI interrupt handling to prepare the support of upcoming
devices which require non-PCI based MSI handling.

  - Cleanup historical leftovers all over the place

  - Rework the code to utilize more core functionality

  - Wrap XEN PCI/MSI interrupts into an irqdomain to make irqdomain
    assignment to PCI devices possible.

  - Assign irqdomains to PCI devices at initialization time which allows
    to utilize the full functionality of hierarchical irqdomains.

  - Remove arch_.*_msi_irq() functions from X86 and utilize the irqdomain
    which is assigned to the device for interrupt management.

  - Make the arch_.*_msi_irq() support conditional on a config switch and
    let the last few users select it.

Thanks,

	tglx

------------------>
Thomas Gleixner (40):
      iommu/amd: Prevent NULL pointer dereference
      x86/init: Remove unused init ops
      PCI: vmd: Dont abuse vector irqomain as parent
      genirq/chip: Use the first chip in irq_chip_compose_msi_msg()
      x86/msi: Move compose message callback where it belongs
      x86/msi: Remove pointless vcpu_affinity callback
      x86_irq_Rename_X86_IRQ_ALLOC_TYPE_MSI_to_reflect_PCI_dependency
      x86/irq: Add allocation type for parent domain retrieval
      iommu/vt-d: Consolidate irq domain getter
      iommu/amd: Consolidate irq domain getter
      iommu/irq_remapping: Consolidate irq domain lookup
      x86/irq: Prepare consolidation of irq_alloc_info
      x86/msi: Consolidate HPET allocation
      x86_ioapic_Consolidate_IOAPIC_allocation
      x86/irq: Consolidate DMAR irq allocation
      x86/irq: Consolidate UV domain allocation
      PCI/MSI: Rework pci_msi_domain_calc_hwirq()
      x86/msi: Consolidate MSI allocation
      x86/msi: Use generic MSI domain ops
      x86/irq: Move apic_post_init() invocation to one place
      x86/pci: Reducde #ifdeffery in PCI init code
      x86/irq: Initialize PCI/MSI domain at PCI init time
      irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
      PCI_vmd_Mark_VMD_irqdomain_with_DOMAIN_BUS_VMD_MSI
      PCI/MSI: Provide pci_dev_has_special_msi_domain() helper
      x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()
      x86/xen: Rework MSI teardown
      x86/xen: Consolidate XEN-MSI init
      irqdomain/msi: Allow to override msi_domain_alloc/free_irqs()
      x86/xen: Wrap XEN MSI management into irqdomain
      iommm/vt-d: Store irq domain in struct device
      iommm/amd: Store irq domain in struct device
      x86/pci: Set default irq domain in pcibios_add_device()
      PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable
      x86/irq: Cleanup the arch_*_msi_irqs() leftovers
      x86/irq: Make most MSI ops XEN private
      iommu/vt-d: Remove domain search for PCI/MSI[X]
      iommu/amd: Remove domain search for PCI/MSI
      x86/apic/msi: Unbreak DMAR and HPET MSI
      PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACKS


 arch/ia64/Kconfig                    |   1 +
 arch/mips/Kconfig                    |   1 +
 arch/powerpc/Kconfig                 |   1 +
 arch/s390/Kconfig                    |   1 +
 arch/sparc/Kconfig                   |   1 +
 arch/x86/include/asm/apic.h          |   8 ++
 arch/x86/include/asm/hw_irq.h        |  89 +++++++++++------------
 arch/x86/include/asm/irq_remapping.h |   8 --
 arch/x86/include/asm/irqdomain.h     |   8 +-
 arch/x86/include/asm/mpspec.h        |  10 ---
 arch/x86/include/asm/msi.h           |   2 -
 arch/x86/include/asm/pci.h           |  11 ---
 arch/x86/include/asm/pci_x86.h       |  11 +++
 arch/x86/include/asm/x86_init.h      |  16 +---
 arch/x86/kernel/apic/apic.c          |   3 +
 arch/x86/kernel/apic/io_apic.c       |  74 +++++++++----------
 arch/x86/kernel/apic/msi.c           | 118 +++++++++---------------------
 arch/x86/kernel/apic/probe_32.c      |   3 -
 arch/x86/kernel/apic/probe_64.c      |   3 -
 arch/x86/kernel/apic/vector.c        |   3 +-
 arch/x86/kernel/devicetree.c         |   4 +-
 arch/x86/kernel/mpparse.c            |  26 +------
 arch/x86/kernel/x86_init.c           |  26 +------
 arch/x86/pci/common.c                |  18 ++++-
 arch/x86/pci/init.c                  |  13 ++--
 arch/x86/pci/xen.c                   | 137 +++++++++++++++++++++++++++++------
 arch/x86/platform/uv/uv_irq.c        |  16 ++--
 drivers/iommu/amd/iommu.c            | 119 +++++++++++++++---------------
 drivers/iommu/hyperv-iommu.c         |   8 +-
 drivers/iommu/intel/dmar.c           |   3 +
 drivers/iommu/intel/irq_remapping.c  | 119 ++++++++++++++----------------
 drivers/iommu/irq_remapping.c        |  23 +-----
 drivers/iommu/irq_remapping.h        |   5 +-
 drivers/pci/Kconfig                  |   3 +
 drivers/pci/controller/Kconfig       |   3 +
 drivers/pci/controller/pci-hyperv.c  |   8 --
 drivers/pci/controller/vmd.c         |   9 ++-
 drivers/pci/msi.c                    |  38 +++++++---
 include/linux/intel-iommu.h          |   7 ++
 include/linux/irqdomain.h            |   1 +
 include/linux/msi.h                  |  61 ++++++++++++++--
 kernel/irq/chip.c                    |   9 +--
 kernel/irq/internals.h               |   9 +++
 kernel/irq/msi.c                     |  83 +++++++++++++--------
 44 files changed, 597 insertions(+), 523 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 5b4ec80bf586..9d0f1e13c918 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -56,6 +56,7 @@ config IA64
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select NUMA if !FLATMEM
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c95fa3a2484c..ea2212934136 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -86,6 +86,7 @@ config MIPS
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65bed1fdeaad..1f953c90cfc7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
+	select PCI_MSI_ARCH_FALLBACKS		if PCI_MSI
 	select PCI_SYSCALL			if PCI
 	select PPC_DAWR				if PPC64
 	select RTC_LIB
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b29fcc66ec39..0a3899386a51 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,6 +185,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
+	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index efeff2c896a5..91ed1104b7f4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC
 	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select PCI_SYSCALL if PCI
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 2cc44e957c31..1c129abb7f09 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -519,6 +519,14 @@ static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
 static inline void apic_smt_update(void) { }
 #endif
 
+struct msi_msg;
+
+#ifdef CONFIG_PCI_MSI
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
+#else
+# define x86_vector_msi_compose_msg NULL
+#endif
+
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 74c12437401e..a4aeeaace040 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -36,61 +36,56 @@ struct msi_desc;
 enum irq_alloc_type {
 	X86_IRQ_ALLOC_TYPE_IOAPIC = 1,
 	X86_IRQ_ALLOC_TYPE_HPET,
-	X86_IRQ_ALLOC_TYPE_MSI,
-	X86_IRQ_ALLOC_TYPE_MSIX,
+	X86_IRQ_ALLOC_TYPE_PCI_MSI,
+	X86_IRQ_ALLOC_TYPE_PCI_MSIX,
 	X86_IRQ_ALLOC_TYPE_DMAR,
 	X86_IRQ_ALLOC_TYPE_UV,
+	X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT,
+	X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT,
 };
 
+struct ioapic_alloc_info {
+	int				pin;
+	int				node;
+	u32				trigger : 1;
+	u32				polarity : 1;
+	u32				valid : 1;
+	struct IO_APIC_route_entry	*entry;
+};
+
+struct uv_alloc_info {
+	int		limit;
+	int		blade;
+	unsigned long	offset;
+	char		*name;
+
+};
+
+/**
+ * irq_alloc_info - X86 specific interrupt allocation info
+ * @type:	X86 specific allocation type
+ * @flags:	Flags for allocation tweaks
+ * @devid:	Device ID for allocations
+ * @hwirq:	Associated hw interrupt number in the domain
+ * @mask:	CPU mask for vector allocation
+ * @desc:	Pointer to msi descriptor
+ * @data:	Allocation specific data
+ *
+ * @ioapic:	IOAPIC specific allocation data
+ * @uv:		UV specific allocation data
+*/
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
 	u32			flags;
-	const struct cpumask	*mask;	/* CPU mask for vector allocation */
+	u32			devid;
+	irq_hw_number_t		hwirq;
+	const struct cpumask	*mask;
+	struct msi_desc		*desc;
+	void			*data;
+
 	union {
-		int		unused;
-#ifdef	CONFIG_HPET_TIMER
-		struct {
-			int		hpet_id;
-			int		hpet_index;
-			void		*hpet_data;
-		};
-#endif
-#ifdef	CONFIG_PCI_MSI
-		struct {
-			struct pci_dev	*msi_dev;
-			irq_hw_number_t	msi_hwirq;
-		};
-#endif
-#ifdef	CONFIG_X86_IO_APIC
-		struct {
-			int		ioapic_id;
-			int		ioapic_pin;
-			int		ioapic_node;
-			u32		ioapic_trigger : 1;
-			u32		ioapic_polarity : 1;
-			u32		ioapic_valid : 1;
-			struct IO_APIC_route_entry *ioapic_entry;
-		};
-#endif
-#ifdef	CONFIG_DMAR_TABLE
-		struct {
-			int		dmar_id;
-			void		*dmar_data;
-		};
-#endif
-#ifdef	CONFIG_X86_UV
-		struct {
-			int		uv_limit;
-			int		uv_blade;
-			unsigned long	uv_offset;
-			char		*uv_name;
-		};
-#endif
-#if IS_ENABLED(CONFIG_VMD)
-		struct {
-			struct msi_desc *desc;
-		};
-#endif
+		struct ioapic_alloc_info	ioapic;
+		struct uv_alloc_info		uv;
 	};
 };
 
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 4bc985f1e2e4..af4a151d70b3 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -44,8 +44,6 @@ extern int irq_remapping_reenable(int);
 extern int irq_remap_enable_fault_handling(void);
 extern void panic_if_irq_remap(const char *msg);
 
-extern struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info);
 extern struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info);
 
@@ -73,12 +71,6 @@ static inline void panic_if_irq_remap(const char *msg)
 {
 }
 
-static inline struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	return NULL;
-}
-
 static inline struct irq_domain *
 irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index c066ffae222b..cd684d45cb5f 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -51,9 +51,13 @@ extern int mp_irqdomain_ioapic_idx(struct irq_domain *domain);
 #endif /* CONFIG_X86_IO_APIC */
 
 #ifdef CONFIG_PCI_MSI
-extern void arch_init_msi_domain(struct irq_domain *domain);
+void x86_create_pci_msi_domain(void);
+struct irq_domain *native_create_pci_msi_domain(void);
+extern struct irq_domain *x86_pci_msi_default_domain;
 #else
-static inline void arch_init_msi_domain(struct irq_domain *domain) { }
+static inline void x86_create_pci_msi_domain(void) { }
+#define native_create_pci_msi_domain	NULL
+#define x86_pci_msi_default_domain	NULL
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 606cbaebd336..e90ac7e9ae2c 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -67,21 +67,11 @@ static inline void find_smp_config(void)
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern int default_mpc_apic_id(struct mpc_cpu *m);
-extern void default_smp_read_mpc_oem(struct mpc_table *mpc);
-# ifdef CONFIG_X86_IO_APIC
-extern void default_mpc_oem_bus_info(struct mpc_bus *m, char *str);
-# else
-#  define default_mpc_oem_bus_info NULL
-# endif
 extern void default_find_smp_config(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable 0
-#define default_mpc_apic_id NULL
-#define default_smp_read_mpc_oem NULL
-#define default_mpc_oem_bus_info NULL
 #define default_find_smp_config x86_init_noop
 #define default_get_smp_config x86_init_uint_noop
 #endif
diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 25ddd0916bb2..cd30013d15d3 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -9,6 +9,4 @@ typedef struct irq_alloc_info msi_alloc_info_t;
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
-
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 7ccb338507e3..d2c76c8d8cfd 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -105,17 +105,6 @@ static inline void early_quirks(void) { }
 
 extern void pci_iommu_alloc(void);
 
-#ifdef CONFIG_PCI_MSI
-/* implemented in arch/x86/kernel/apic/io_apic. */
-struct msi_desc;
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void native_teardown_msi_irq(unsigned int irq);
-void native_restore_msi_irqs(struct pci_dev *dev);
-#else
-#define native_setup_msi_irqs		NULL
-#define native_teardown_msi_irq		NULL
-#endif
-
 /* generic pci stuff */
 #include <asm-generic/pci.h>
 
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 73bb404f4d2a..490411dba438 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -114,9 +114,20 @@ extern const struct pci_raw_ops pci_direct_conf1;
 extern bool port_cf9_safe;
 
 /* arch_initcall level */
+#ifdef CONFIG_PCI_DIRECT
 extern int pci_direct_probe(void);
 extern void pci_direct_init(int type);
+#else
+static inline int pci_direct_probe(void) { return -1; }
+static inline  void pci_direct_init(int type) { }
+#endif
+
+#ifdef CONFIG_PCI_BIOS
 extern void pci_pcbios_init(void);
+#else
+static inline void pci_pcbios_init(void) { }
+#endif
+
 extern void __init dmi_check_pciprobe(void);
 extern void __init dmi_check_skip_isa_align(void);
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6807153c0410..397196fae24d 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -8,25 +8,16 @@ struct mpc_bus;
 struct mpc_cpu;
 struct mpc_table;
 struct cpuinfo_x86;
+struct irq_domain;
 
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
- * @mpc_record:			platform specific mpc record accounting
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @mpc_apic_id:		platform specific mpc apic id assignment
- * @smp_read_mpc_oem:		platform specific oem mpc table setup
- * @mpc_oem_pci_bus:		platform specific pci bus setup (default NULL)
- * @mpc_oem_bus_info:		platform specific mpc bus info
  * @find_smp_config:		find the smp configuration
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
-	void (*mpc_record)(unsigned int mode);
 	void (*setup_ioapic_ids)(void);
-	int (*mpc_apic_id)(struct mpc_cpu *m);
-	void (*smp_read_mpc_oem)(struct mpc_table *mpc);
-	void (*mpc_oem_pci_bus)(struct mpc_bus *m);
-	void (*mpc_oem_bus_info)(struct mpc_bus *m, char *name);
 	void (*find_smp_config)(void);
 	void (*get_smp_config)(unsigned int early);
 };
@@ -52,12 +43,14 @@ struct x86_init_resources {
  * @intr_init:			interrupt init code
  * @intr_mode_select:		interrupt delivery mode selection
  * @intr_mode_init:		interrupt delivery mode setup
+ * @create_pci_msi_domain:	Create the PCI/MSI interrupt domain
  */
 struct x86_init_irqs {
 	void (*pre_vector_init)(void);
 	void (*intr_init)(void);
 	void (*intr_mode_select)(void);
 	void (*intr_mode_init)(void);
+	struct irq_domain *(*create_pci_msi_domain)(void);
 };
 
 /**
@@ -283,9 +276,6 @@ struct x86_platform_ops {
 struct pci_dev;
 
 struct x86_msi_ops {
-	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
-	void (*teardown_msi_irq)(unsigned int irq);
-	void (*teardown_msi_irqs)(struct pci_dev *dev);
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5f943b938167..b3eef1d5c903 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1429,6 +1429,9 @@ void __init apic_intr_mode_init(void)
 		break;
 	}
 
+	if (x86_platform.apic_post_init)
+		x86_platform.apic_post_init();
+
 	apic_bsp_setup(upmode);
 }
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 779a89e31c4c..a33380059db6 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -860,10 +860,10 @@ void ioapic_set_alloc_attr(struct irq_alloc_info *info, int node,
 {
 	init_irq_alloc_info(info, NULL);
 	info->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
-	info->ioapic_node = node;
-	info->ioapic_trigger = trigger;
-	info->ioapic_polarity = polarity;
-	info->ioapic_valid = 1;
+	info->ioapic.node = node;
+	info->ioapic.trigger = trigger;
+	info->ioapic.polarity = polarity;
+	info->ioapic.valid = 1;
 }
 
 #ifndef CONFIG_ACPI
@@ -878,32 +878,32 @@ static void ioapic_copy_alloc_attr(struct irq_alloc_info *dst,
 
 	copy_irq_alloc_info(dst, src);
 	dst->type = X86_IRQ_ALLOC_TYPE_IOAPIC;
-	dst->ioapic_id = mpc_ioapic_id(ioapic_idx);
-	dst->ioapic_pin = pin;
-	dst->ioapic_valid = 1;
-	if (src && src->ioapic_valid) {
-		dst->ioapic_node = src->ioapic_node;
-		dst->ioapic_trigger = src->ioapic_trigger;
-		dst->ioapic_polarity = src->ioapic_polarity;
+	dst->devid = mpc_ioapic_id(ioapic_idx);
+	dst->ioapic.pin = pin;
+	dst->ioapic.valid = 1;
+	if (src && src->ioapic.valid) {
+		dst->ioapic.node = src->ioapic.node;
+		dst->ioapic.trigger = src->ioapic.trigger;
+		dst->ioapic.polarity = src->ioapic.polarity;
 	} else {
-		dst->ioapic_node = NUMA_NO_NODE;
+		dst->ioapic.node = NUMA_NO_NODE;
 		if (acpi_get_override_irq(gsi, &trigger, &polarity) >= 0) {
-			dst->ioapic_trigger = trigger;
-			dst->ioapic_polarity = polarity;
+			dst->ioapic.trigger = trigger;
+			dst->ioapic.polarity = polarity;
 		} else {
 			/*
 			 * PCI interrupts are always active low level
 			 * triggered.
 			 */
-			dst->ioapic_trigger = IOAPIC_LEVEL;
-			dst->ioapic_polarity = IOAPIC_POL_LOW;
+			dst->ioapic.trigger = IOAPIC_LEVEL;
+			dst->ioapic.polarity = IOAPIC_POL_LOW;
 		}
 	}
 }
 
 static int ioapic_alloc_attr_node(struct irq_alloc_info *info)
 {
-	return (info && info->ioapic_valid) ? info->ioapic_node : NUMA_NO_NODE;
+	return (info && info->ioapic.valid) ? info->ioapic.node : NUMA_NO_NODE;
 }
 
 static void mp_register_handler(unsigned int irq, unsigned long trigger)
@@ -933,14 +933,14 @@ static bool mp_check_pin_attr(int irq, struct irq_alloc_info *info)
 	 * pin with real trigger and polarity attributes.
 	 */
 	if (irq < nr_legacy_irqs() && data->count == 1) {
-		if (info->ioapic_trigger != data->trigger)
-			mp_register_handler(irq, info->ioapic_trigger);
-		data->entry.trigger = data->trigger = info->ioapic_trigger;
-		data->entry.polarity = data->polarity = info->ioapic_polarity;
+		if (info->ioapic.trigger != data->trigger)
+			mp_register_handler(irq, info->ioapic.trigger);
+		data->entry.trigger = data->trigger = info->ioapic.trigger;
+		data->entry.polarity = data->polarity = info->ioapic.polarity;
 	}
 
-	return data->trigger == info->ioapic_trigger &&
-	       data->polarity == info->ioapic_polarity;
+	return data->trigger == info->ioapic.trigger &&
+	       data->polarity == info->ioapic.polarity;
 }
 
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
@@ -1002,7 +1002,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
 		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic_pin))
+					  info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -2092,8 +2092,8 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
 		struct irq_alloc_info info;
 
 		ioapic_set_alloc_attr(&info, NUMA_NO_NODE, 0, 0);
-		info.ioapic_id = mpc_ioapic_id(ioapic);
-		info.ioapic_pin = pin;
+		info.devid = mpc_ioapic_id(ioapic);
+		info.ioapic.pin = pin;
 		mutex_lock(&ioapic_mutex);
 		irq = alloc_isa_irq_from_domain(domain, 0, ioapic, pin, &info);
 		mutex_unlock(&ioapic_mutex);
@@ -2296,9 +2296,9 @@ static int mp_irqdomain_create(int ioapic)
 		return 0;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC;
-	info.ioapic_id = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
+	info.devid = mpc_ioapic_id(ioapic);
+	parent = irq_remapping_get_irq_domain(&info);
 	if (!parent)
 		parent = x86_vector_domain;
 	else
@@ -2932,9 +2932,9 @@ int mp_ioapic_registered(u32 gsi_base)
 static void mp_irqdomain_get_attr(u32 gsi, struct mp_chip_data *data,
 				  struct irq_alloc_info *info)
 {
-	if (info && info->ioapic_valid) {
-		data->trigger = info->ioapic_trigger;
-		data->polarity = info->ioapic_polarity;
+	if (info && info->ioapic.valid) {
+		data->trigger = info->ioapic.trigger;
+		data->polarity = info->ioapic.polarity;
 	} else if (acpi_get_override_irq(gsi, &data->trigger,
 					 &data->polarity) < 0) {
 		/* PCI interrupts are always active low level triggered. */
@@ -2980,7 +2980,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -EINVAL;
 
 	ioapic = mp_irqdomain_ioapic_idx(domain);
-	pin = info->ioapic_pin;
+	pin = info->ioapic.pin;
 	if (irq_find_mapping(domain, (irq_hw_number_t)pin) > 0)
 		return -EEXIST;
 
@@ -2988,7 +2988,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (!data)
 		return -ENOMEM;
 
-	info->ioapic_entry = &data->entry;
+	info->ioapic.entry = &data->entry;
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
 	if (ret < 0) {
 		kfree(data);
@@ -2996,7 +2996,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	}
 
 	INIT_LIST_HEAD(&data->irq_2_pin);
-	irq_data->hwirq = info->ioapic_pin;
+	irq_data->hwirq = info->ioapic.pin;
 	irq_data->chip = (domain->parent == x86_vector_domain) ?
 			  &ioapic_chip : &ioapic_ir_chip;
 	irq_data->chip_data = data;
@@ -3006,8 +3006,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
 
 	local_irq_save(flags);
-	if (info->ioapic_entry)
-		mp_setup_entry(cfg, data, info->ioapic_entry);
+	if (info->ioapic.entry)
+		mp_setup_entry(cfg, data, info->ioapic.entry);
 	mp_register_handler(virq, data->trigger);
 	if (virq < nr_legacy_irqs())
 		legacy_pic->mask(virq);
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index c2b2911feeef..6313f0a05db7 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *msi_default_domain;
+struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
@@ -45,7 +45,7 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	__irq_msi_compose_msg(irqd_cfg(data), msg);
 }
@@ -177,40 +177,10 @@ static struct irq_chip pci_msi_controller = {
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_set_affinity	= msi_set_affinity,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	struct irq_domain *domain;
-	struct irq_alloc_info info;
-
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_MSI;
-	info.msi_dev = dev;
-
-	domain = irq_remapping_get_irq_domain(&info);
-	if (domain == NULL)
-		domain = msi_default_domain;
-	if (domain == NULL)
-		return -ENOSYS;
-
-	return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
-}
-
-void native_teardown_msi_irq(unsigned int irq)
-{
-	irq_domain_free_irqs(irq, 1);
-}
-
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
-					 msi_alloc_info_t *arg)
-{
-	return arg->msi_hwirq;
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
@@ -218,11 +188,10 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 	struct msi_desc *desc = first_pci_msi_entry(pdev);
 
 	init_irq_alloc_info(arg, NULL);
-	arg->msi_dev = pdev;
 	if (desc->msi_attrib.is_msix) {
-		arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
 	} else {
-		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
+		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
 		arg->flags |= X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 	}
 
@@ -230,16 +199,8 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 }
 EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
-{
-	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
-}
-EXPORT_SYMBOL_GPL(pci_msi_set_desc);
-
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.get_hwirq	= pci_msi_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
@@ -251,25 +212,32 @@ static struct msi_domain_info pci_msi_domain_info = {
 	.handler_name	= "edge",
 };
 
-void __init arch_init_msi_domain(struct irq_domain *parent)
+struct irq_domain * __init native_create_pci_msi_domain(void)
 {
 	struct fwnode_handle *fn;
+	struct irq_domain *d;
 
 	if (disable_apic)
-		return;
+		return NULL;
 
 	fn = irq_domain_alloc_named_fwnode("PCI-MSI");
-	if (fn) {
-		msi_default_domain =
-			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
-						  parent);
-	}
-	if (!msi_default_domain) {
+	if (!fn)
+		return NULL;
+
+	d = pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
+				      x86_vector_domain);
+	if (!d) {
 		irq_domain_free_fwnode(fn);
-		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
+		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
 	} else {
-		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
+		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
+	return d;
+}
+
+void __init x86_create_pci_msi_domain(void)
+{
+	x86_pci_msi_default_domain = x86_init.irqs.create_pci_msi_domain();
 }
 
 #ifdef CONFIG_IRQ_REMAP
@@ -279,7 +247,6 @@ static struct irq_chip pci_msi_ir_controller = {
 	.irq_mask		= pci_msi_mask_irq,
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -321,35 +288,28 @@ static struct irq_chip dmar_msi_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_set_affinity	= msi_domain_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg	= irq_msi_compose_msg,
 	.irq_write_msi_msg	= dmar_msi_write_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
-					  msi_alloc_info_t *arg)
-{
-	return arg->dmar_id;
-}
-
 static int dmar_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
-	irq_domain_set_info(domain, virq, arg->dmar_id, info->chip, NULL,
-			    handle_edge_irq, arg->dmar_data, "edge");
+	irq_domain_set_info(domain, virq, arg->devid, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
 
 static struct msi_domain_ops dmar_msi_domain_ops = {
-	.get_hwirq	= dmar_msi_get_hwirq,
 	.msi_init	= dmar_msi_init,
 };
 
 static struct msi_domain_info dmar_msi_domain_info = {
 	.ops		= &dmar_msi_domain_ops,
 	.chip		= &dmar_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 static struct irq_domain *dmar_get_irq_domain(void)
@@ -384,8 +344,9 @@ int dmar_alloc_hwirq(int id, int node, void *arg)
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
-	info.dmar_id = id;
-	info.dmar_data = arg;
+	info.devid = id;
+	info.hwirq = id;
+	info.data = arg;
 
 	return irq_domain_alloc_irqs(domain, 1, node, &info);
 }
@@ -419,24 +380,17 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.irq_ack = irq_chip_ack_parent,
 	.irq_set_affinity = msi_domain_set_affinity,
 	.irq_retrigger = irq_chip_retrigger_hierarchy,
-	.irq_compose_msi_msg = irq_msi_compose_msg,
 	.irq_write_msi_msg = hpet_msi_write_msg,
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
 
-static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
-					  msi_alloc_info_t *arg)
-{
-	return arg->hpet_index;
-}
-
 static int hpet_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
 	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
-	irq_domain_set_info(domain, virq, arg->hpet_index, info->chip, NULL,
-			    handle_edge_irq, arg->hpet_data, "edge");
+	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
+			    handle_edge_irq, arg->data, "edge");
 
 	return 0;
 }
@@ -448,7 +402,6 @@ static void hpet_msi_free(struct irq_domain *domain,
 }
 
 static struct msi_domain_ops hpet_msi_domain_ops = {
-	.get_hwirq	= hpet_msi_get_hwirq,
 	.msi_init	= hpet_msi_init,
 	.msi_free	= hpet_msi_free,
 };
@@ -456,6 +409,7 @@ static struct msi_domain_ops hpet_msi_domain_ops = {
 static struct msi_domain_info hpet_msi_domain_info = {
 	.ops		= &hpet_msi_domain_ops,
 	.chip		= &hpet_msi_controller,
+	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
 };
 
 struct irq_domain *hpet_create_irq_domain(int hpet_id)
@@ -476,9 +430,9 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	domain_info->data = (void *)(long)hpet_id;
 
 	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_id = hpet_id;
-	parent = irq_remapping_get_ir_irq_domain(&info);
+	info.type = X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT;
+	info.devid = hpet_id;
+	parent = irq_remapping_get_irq_domain(&info);
 	if (parent == NULL)
 		parent = x86_vector_domain;
 	else
@@ -506,9 +460,9 @@ int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_data = hc;
-	info.hpet_id = hpet_dev_id(domain);
-	info.hpet_index = dev_num;
+	info.data = hc;
+	info.devid = hpet_dev_id(domain);
+	info.hwirq = dev_num;
 
 	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
 }
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 99ee61c9ba54..67b6f7c049ec 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -170,9 +170,6 @@ void __init default_setup_apic_routing(void)
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 void __init generic_apic_probe(void)
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index bd3835d6b535..c46720f185c0 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -32,9 +32,6 @@ void __init default_setup_apic_routing(void)
 			break;
 		}
 	}
-
-	if (x86_platform.apic_post_init)
-		x86_platform.apic_post_init();
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index f8a56b5dc29f..1eac53632786 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -714,8 +714,6 @@ int __init arch_early_irq_init(void)
 	BUG_ON(x86_vector_domain == NULL);
 	irq_set_default_host(x86_vector_domain);
 
-	arch_init_msi_domain(x86_vector_domain);
-
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
 	/*
@@ -824,6 +822,7 @@ static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
 	.irq_set_affinity	= apic_set_affinity,
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
 	.irq_retrigger		= apic_retrigger_irq,
 };
 
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index a0e8fc7d85f1..ddffd80f5c52 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -229,8 +229,8 @@ static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	it = &of_ioapic_type[type_index];
 	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
-	tmp.ioapic_id = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
-	tmp.ioapic_pin = fwspec->param[0];
+	tmp.devid = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
+	tmp.ioapic.pin = fwspec->param[0];
 
 	return mp_irqdomain_alloc(domain, virq, nr_irqs, &tmp);
 }
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index baa21090c9be..61d09bdada8a 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -46,11 +46,6 @@ static int __init mpf_checksum(unsigned char *mp, int len)
 	return sum & 0xFF;
 }
 
-int __init default_mpc_apic_id(struct mpc_cpu *m)
-{
-	return m->apicid;
-}
-
 static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	int apicid;
@@ -61,7 +56,7 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 		return;
 	}
 
-	apicid = x86_init.mpparse.mpc_apic_id(m);
+	apicid = m->apicid;
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR) {
 		bootup_cpu = " (Bootup-CPU)";
@@ -73,7 +68,7 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 }
 
 #ifdef CONFIG_X86_IO_APIC
-void __init default_mpc_oem_bus_info(struct mpc_bus *m, char *str)
+static void __init mpc_oem_bus_info(struct mpc_bus *m, char *str)
 {
 	memcpy(str, m->bustype, 6);
 	str[6] = 0;
@@ -84,7 +79,7 @@ static void __init MP_bus_info(struct mpc_bus *m)
 {
 	char str[7];
 
-	x86_init.mpparse.mpc_oem_bus_info(m, str);
+	mpc_oem_bus_info(m, str);
 
 #if MAX_MP_BUSSES < 256
 	if (m->busid >= MAX_MP_BUSSES) {
@@ -100,9 +95,6 @@ static void __init MP_bus_info(struct mpc_bus *m)
 		mp_bus_id_to_type[m->busid] = MP_BUS_ISA;
 #endif
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI) - 1) == 0) {
-		if (x86_init.mpparse.mpc_oem_pci_bus)
-			x86_init.mpparse.mpc_oem_pci_bus(m);
-
 		clear_bit(m->busid, mp_bus_not_pci);
 #ifdef CONFIG_EISA
 		mp_bus_id_to_type[m->busid] = MP_BUS_PCI;
@@ -198,8 +190,6 @@ static void __init smp_dump_mptable(struct mpc_table *mpc, unsigned char *mpt)
 			1, mpc, mpc->length, 1);
 }
 
-void __init default_smp_read_mpc_oem(struct mpc_table *mpc) { }
-
 static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 {
 	char str[16];
@@ -218,14 +208,7 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 	if (early)
 		return 1;
 
-	if (mpc->oemptr)
-		x86_init.mpparse.smp_read_mpc_oem(mpc);
-
-	/*
-	 *      Now process the configuration blocks.
-	 */
-	x86_init.mpparse.mpc_record(0);
-
+	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
 		switch (*mpt) {
 		case MP_PROCESSOR:
@@ -256,7 +239,6 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 			count = mpc->length;
 			break;
 		}
-		x86_init.mpparse.mpc_record(1);
 	}
 
 	if (!num_processors)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 123f1c1f1788..a3038d8deb6a 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -24,6 +24,7 @@
 #include <asm/tsc.h>
 #include <asm/iommu.h>
 #include <asm/mach_traps.h>
+#include <asm/irqdomain.h>
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
@@ -67,11 +68,7 @@ struct x86_init_ops x86_init __initdata = {
 	},
 
 	.mpparse = {
-		.mpc_record		= x86_init_uint_noop,
 		.setup_ioapic_ids	= x86_init_noop,
-		.mpc_apic_id		= default_mpc_apic_id,
-		.smp_read_mpc_oem	= default_smp_read_mpc_oem,
-		.mpc_oem_bus_info	= default_mpc_oem_bus_info,
 		.find_smp_config	= default_find_smp_config,
 		.get_smp_config		= default_get_smp_config,
 	},
@@ -80,7 +77,8 @@ struct x86_init_ops x86_init __initdata = {
 		.pre_vector_init	= init_ISA_irqs,
 		.intr_init		= native_init_IRQ,
 		.intr_mode_select	= apic_intr_mode_select,
-		.intr_mode_init		= apic_intr_mode_init
+		.intr_mode_init		= apic_intr_mode_init,
+		.create_pci_msi_domain	= native_create_pci_msi_domain,
 	},
 
 	.oem = {
@@ -148,28 +146,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi __ro_after_init = {
-	.setup_msi_irqs		= native_setup_msi_irqs,
-	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
 	.restore_msi_irqs	= default_restore_msi_irqs,
 };
 
 /* MSI arch specific hooks */
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-
 void arch_restore_msi_irqs(struct pci_dev *dev)
 {
 	x86_msi.restore_msi_irqs(dev);
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index df1d95913d4e..3507f456fcd0 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
+#include <asm/irqdomain.h>
 
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
@@ -633,8 +634,9 @@ static void set_dev_domain_options(struct pci_dev *pdev)
 
 int pcibios_add_device(struct pci_dev *dev)
 {
-	struct setup_data *data;
 	struct pci_setup_rom *rom;
+	struct irq_domain *msidom;
+	struct setup_data *data;
 	u64 pa_data;
 
 	pa_data = boot_params.hdr.setup_data;
@@ -661,6 +663,20 @@ int pcibios_add_device(struct pci_dev *dev)
 		memunmap(data);
 	}
 	set_dev_domain_options(dev);
+
+	/*
+	 * Setup the initial MSI domain of the device. If the underlying
+	 * bus has a PCI/MSI irqdomain associated use the bus domain,
+	 * otherwise set the default domain. This ensures that special irq
+	 * domains e.g. VMD are preserved. The default ensures initial
+	 * operation if irq remapping is not active. If irq remapping is
+	 * active it will overwrite the domain pointer when the device is
+	 * associated to a remapping domain.
+	 */
+	msidom = dev_get_msi_domain(&dev->bus->dev);
+	if (!msidom)
+		msidom = x86_pci_msi_default_domain;
+	dev_set_msi_domain(&dev->dev, msidom);
 	return 0;
 }
 
diff --git a/arch/x86/pci/init.c b/arch/x86/pci/init.c
index 5fc617edf108..00bfa1ebad6c 100644
--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -3,16 +3,17 @@
 #include <linux/init.h>
 #include <asm/pci_x86.h>
 #include <asm/x86_init.h>
+#include <asm/irqdomain.h>
 
 /* arch_initcall has too random ordering, so call the initializers
    in the right sequence from here. */
 static __init int pci_arch_init(void)
 {
-#ifdef CONFIG_PCI_DIRECT
-	int type = 0;
+	int type;
+
+	x86_create_pci_msi_domain();
 
 	type = pci_direct_probe();
-#endif
 
 	if (!(pci_probe & PCI_PROBE_NOEARLY))
 		pci_mmcfg_early_init();
@@ -20,18 +21,16 @@ static __init int pci_arch_init(void)
 	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
 		return 0;
 
-#ifdef CONFIG_PCI_BIOS
 	pci_pcbios_init();
-#endif
+
 	/*
 	 * don't check for raw_pci_ops here because we want pcbios as last
 	 * fallback, yet it's needed to run first to set pcibios_last_bus
 	 * in case legacy PCI probing is used. otherwise detecting peer busses
 	 * fails.
 	 */
-#ifdef CONFIG_PCI_DIRECT
 	pci_direct_init(type);
-#endif
+
 	if (!raw_pci_ops && !raw_pci_ext_ops)
 		printk(KERN_ERR
 		"PCI: Fatal: No config space access function found\n");
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 89395a5049bb..c552cd2d0632 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,6 +157,13 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
+struct xen_msi_ops {
+	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
+	void (*teardown_msi_irqs)(struct pci_dev *dev);
+};
+
+static struct xen_msi_ops xen_msi_ops __ro_after_init;
+
 static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
@@ -372,28 +379,122 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 		WARN(ret && ret != -ENOSYS, "restore_msi -> %d\n", ret);
 	}
 }
-#endif
+#else /* CONFIG_XEN_DOM0 */
+#define xen_initdom_setup_msi_irqs	NULL
+#define xen_initdom_restore_msi_irqs	NULL
+#endif /* !CONFIG_XEN_DOM0 */
 
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
+	int i;
+
+	for_each_pci_msi_entry(msidesc, dev) {
+		if (msidesc->irq) {
+			for (i = 0; i < msidesc->nvec_used; i++)
+				xen_destroy_irq(msidesc->irq + i);
+		}
+	}
+}
+
+static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *msidesc = first_pci_msi_entry(dev);
 
-	msidesc = first_pci_msi_entry(dev);
 	if (msidesc->msi_attrib.is_msix)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
 
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
+	xen_teardown_msi_irqs(dev);
 }
 
-static void xen_teardown_msi_irq(unsigned int irq)
+static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
+				     struct device *dev,  int nvec)
 {
-	xen_destroy_irq(irq);
+	int type;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return -EINVAL;
+
+	if (first_msi_entry(dev)->msi_attrib.is_msix)
+		type = PCI_CAP_ID_MSIX;
+	else
+		type = PCI_CAP_ID_MSI;
+
+	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
-#endif
+static void xen_msi_domain_free_irqs(struct irq_domain *domain,
+				     struct device *dev)
+{
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	xen_msi_ops.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+static struct msi_domain_ops xen_pci_msi_domain_ops = {
+	.domain_alloc_irqs	= xen_msi_domain_alloc_irqs,
+	.domain_free_irqs	= xen_msi_domain_free_irqs,
+};
+
+static struct msi_domain_info xen_pci_msi_domain_info = {
+	.ops			= &xen_pci_msi_domain_ops,
+};
+
+/*
+ * This irq domain is a blatant violation of the irq domain design, but
+ * distangling XEN into real irq domains is not a job for mere mortals with
+ * limited XENology. But it's the least dangerous way for a mere mortal to
+ * get rid of the arch_*_msi_irqs() hackery in order to store the irq
+ * domain pointer in struct device. This irq domain wrappery allows to do
+ * that without breaking XEN terminally.
+ */
+static __init struct irq_domain *xen_create_pci_msi_domain(void)
+{
+	struct irq_domain *d = NULL;
+	struct fwnode_handle *fn;
+
+	fn = irq_domain_alloc_named_fwnode("XEN-MSI");
+	if (fn)
+		d = msi_create_irq_domain(fn, &xen_pci_msi_domain_info, NULL);
+
+	/* FIXME: No idea how to survive if this fails */
+	BUG_ON(!d);
+
+	return d;
+}
+
+static __init void xen_setup_pci_msi(void)
+{
+	if (xen_pv_domain()) {
+		if (xen_initial_domain()) {
+			xen_msi_ops.setup_msi_irqs = xen_initdom_setup_msi_irqs;
+			x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+		} else {
+			xen_msi_ops.setup_msi_irqs = xen_setup_msi_irqs;
+		}
+		xen_msi_ops.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
+		pci_msi_ignore_mask = 1;
+	} else if (xen_hvm_domain()) {
+		xen_msi_ops.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+		xen_msi_ops.teardown_msi_irqs = xen_teardown_msi_irqs;
+	} else {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	/*
+	 * Override the PCI/MSI irq domain init function. No point
+	 * in allocating the native domain and never use it.
+	 */
+	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
+}
+
+#else /* CONFIG_PCI_MSI */
+static inline void xen_setup_pci_msi(void) { }
+#endif /* CONFIG_PCI_MSI */
 
 int __init pci_xen_init(void)
 {
@@ -410,17 +511,12 @@ int __init pci_xen_init(void)
 	/* Keep ACPI out of the picture */
 	acpi_noirq_set();
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	return 0;
 }
 
 #ifdef CONFIG_PCI_MSI
-void __init xen_msi_init(void)
+static void __init xen_hvm_msi_init(void)
 {
 	if (!disable_apic) {
 		/*
@@ -435,9 +531,7 @@ void __init xen_msi_init(void)
 		    ((eax & XEN_HVM_CPUID_APIC_ACCESS_VIRT) && boot_cpu_has(X86_FEATURE_APIC)))
 			return;
 	}
-
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_setup_pci_msi();
 }
 #endif
 
@@ -460,7 +554,7 @@ int __init pci_xen_hvm_init(void)
 	 * We need to wait until after x2apic is initialized
 	 * before we can set MSI IRQ ops.
 	 */
-	x86_platform.apic_post_init = xen_msi_init;
+	x86_platform.apic_post_init = xen_hvm_msi_init;
 #endif
 	return 0;
 }
@@ -470,12 +564,7 @@ int __init pci_xen_initial_domain(void)
 {
 	int irq;
 
-#ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
-	pci_msi_ignore_mask = 1;
-#endif
+	xen_setup_pci_msi();
 	__acpi_register_gsi = acpi_register_gsi_xen;
 	__acpi_unregister_gsi = NULL;
 	/*
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index abb6075397f0..18ca2261cc9a 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -90,15 +90,15 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret >= 0) {
-		if (info->uv_limit == UV_AFFINITY_CPU)
+		if (info->uv.limit == UV_AFFINITY_CPU)
 			irq_set_status_flags(virq, IRQ_NO_BALANCING);
 		else
 			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 
-		chip_data->pnode = uv_blade_to_pnode(info->uv_blade);
-		chip_data->offset = info->uv_offset;
+		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
+		chip_data->offset = info->uv.offset;
 		irq_domain_set_info(domain, virq, virq, &uv_irq_chip, chip_data,
-				    handle_percpu_irq, NULL, info->uv_name);
+				    handle_percpu_irq, NULL, info->uv.name);
 	} else {
 		kfree(chip_data);
 	}
@@ -193,10 +193,10 @@ int uv_setup_irq(char *irq_name, int cpu, int mmr_blade,
 
 	init_irq_alloc_info(&info, cpumask_of(cpu));
 	info.type = X86_IRQ_ALLOC_TYPE_UV;
-	info.uv_limit = limit;
-	info.uv_blade = mmr_blade;
-	info.uv_offset = mmr_offset;
-	info.uv_name = irq_name;
+	info.uv.limit = limit;
+	info.uv.blade = mmr_blade;
+	info.uv.offset = mmr_offset;
+	info.uv.name = irq_name;
 
 	return irq_domain_alloc_irqs(domain, 1,
 				     uv_blade_to_memory_nid(mmr_blade), &info);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07ae8b93887e..ef64e01f66d7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -729,7 +729,21 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 		}
 	}
 }
-#endif /* CONFIG_IRQ_REMAP */
+
+static void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
+{
+	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
+	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+		return;
+
+	dev_set_msi_domain(dev, iommu->msi_domain);
+}
+
+#else /* CONFIG_IRQ_REMAP */
+static inline void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
+#endif /* !CONFIG_IRQ_REMAP */
 
 #define AMD_IOMMU_INT_MASK	\
 	(MMIO_STATUS_EVT_INT_MASK | \
@@ -2157,6 +2171,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(dev);
 	} else {
+		amd_iommu_set_pci_msi_domain(dev, iommu);
 		iommu_dev = &iommu->iommu;
 	}
 
@@ -3519,69 +3534,51 @@ static void irte_ga_clear_allocated(struct irq_remap_table *table, int index)
 
 static int get_devid(struct irq_alloc_info *info)
 {
-	int devid = -1;
-
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		devid     = get_ioapic_devid(info->ioapic_id);
-		break;
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+		return get_ioapic_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_HPET:
-		devid     = get_hpet_devid(info->hpet_id);
-		break;
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		break;
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return get_hpet_devid(info->devid);
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		return get_device_id(msi_desc_to_dev(info->desc));
 	default:
-		BUG_ON(1);
-		break;
+		WARN_ON_ONCE(1);
+		return -1;
 	}
-
-	return devid;
 }
 
-static struct irq_domain *get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *get_irq_domain_for_devid(struct irq_alloc_info *info,
+						   int devid)
 {
-	struct amd_iommu *iommu;
-	int devid;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
-	if (!info)
+	if (!iommu)
 		return NULL;
 
-	devid = get_devid(info);
-	if (devid >= 0) {
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->ir_domain;
+	switch (info->type) {
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return iommu->ir_domain;
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
 	}
-
-	return NULL;
 }
 
 static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 {
-	struct amd_iommu *iommu;
 	int devid;
 
 	if (!info)
 		return NULL;
 
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
-		devid = get_device_id(&info->msi_dev->dev);
-		if (devid < 0)
-			return NULL;
-
-		iommu = amd_iommu_rlookup_table[devid];
-		if (iommu)
-			return iommu->msi_domain;
-		break;
-	default:
-		break;
-	}
-
-	return NULL;
+	devid = get_devid(info);
+	if (devid < 0)
+		return NULL;
+	return get_irq_domain_for_devid(info, devid);
 }
 
 struct irq_remap_ops amd_iommu_irq_ops = {
@@ -3590,7 +3587,6 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.disable		= amd_iommu_disable,
 	.reenable		= amd_iommu_reenable,
 	.enable_faulting	= amd_iommu_enable_faulting,
-	.get_ir_irq_domain	= get_ir_irq_domain,
 	.get_irq_domain		= get_irq_domain,
 };
 
@@ -3616,21 +3612,21 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Setup IOAPIC entry */
-		entry = info->ioapic_entry;
-		info->ioapic_entry = NULL;
+		entry = info->ioapic.entry;
+		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
 		entry->vector        = index;
 		entry->mask          = 0;
-		entry->trigger       = info->ioapic_trigger;
-		entry->polarity      = info->ioapic_polarity;
+		entry->trigger       = info->ioapic.trigger;
+		entry->polarity      = info->ioapic.polarity;
 		/* Mask level triggered irqs. */
-		if (info->ioapic_trigger)
+		if (info->ioapic.trigger)
 			entry->mask = 1;
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		msg->address_hi = MSI_ADDR_BASE_HI;
 		msg->address_lo = MSI_ADDR_BASE_LO;
 		msg->data = irte_info->index;
@@ -3674,15 +3670,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	if (!info)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
+	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
 	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
 	devid = get_devid(info);
@@ -3710,15 +3706,16 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 					iommu->irte_ops->set_allocated(table, i);
 			}
 			WARN_ON(table->min_index != 32);
-			index = info->ioapic_pin;
+			index = info->ioapic.pin;
 		} else {
 			index = -ENOMEM;
 		}
-	} else if (info->type == X86_IRQ_ALLOC_TYPE_MSI ||
-		   info->type == X86_IRQ_ALLOC_TYPE_MSIX) {
-		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
+	} else if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI ||
+		   info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX) {
+		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);
 
-		index = alloc_irq_index(devid, nr_irqs, align, info->msi_dev);
+		index = alloc_irq_index(devid, nr_irqs, align,
+					msi_desc_to_pci_dev(info->desc));
 	} else {
 		index = alloc_irq_index(devid, nr_irqs, false, NULL);
 	}
@@ -3731,8 +3728,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
-		cfg = irqd_cfg(irq_data);
-		if (!irq_data || !cfg) {
+		cfg = irq_data ? irqd_cfg(irq_data) : NULL;
+		if (!cfg) {
 			ret = -EINVAL;
 			goto out_free_data;
 		}
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8919c1c70b68..e09e2d734c57 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -101,7 +101,7 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 	 * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
 	 * affinity() set vector and dest_apicid directly into IO-APIC entry.
 	 */
-	irq_data->chip_data = info->ioapic_entry;
+	irq_data->chip_data = info->ioapic.entry;
 
 	/*
 	 * Hypver-V IO APIC irq affinity should be in the scope of
@@ -182,9 +182,9 @@ static int __init hyperv_enable_irq_remapping(void)
 	return IRQ_REMAP_X2APIC_MODE;
 }
 
-static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
+static struct irq_domain *hyperv_get_irq_domain(struct irq_alloc_info *info)
 {
-	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT)
 		return ioapic_ir_domain;
 	else
 		return NULL;
@@ -193,7 +193,7 @@ static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
 struct irq_remap_ops hyperv_irq_remap_ops = {
 	.prepare		= hyperv_prepare_irq_remapping,
 	.enable			= hyperv_enable_irq_remapping,
-	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
+	.get_irq_domain		= hyperv_get_irq_domain,
 };
 
 #endif
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345f3414..4dc09edef744 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -316,6 +316,9 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
 	if (ret < 0 && dmar_dev_scope_status == 0)
 		dmar_dev_scope_status = ret;
 
+	if (ret >= 0)
+		intel_irq_remap_add_device(info);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 8f4ce72570ce..0cfce1d3b7bb 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -204,35 +204,40 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	return rc;
 }
 
-static struct intel_iommu *map_hpet_to_ir(u8 hpet_id)
+static struct irq_domain *map_hpet_to_ir(u8 hpet_id)
 {
 	int i;
 
-	for (i = 0; i < MAX_HPET_TBS; i++)
+	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].id == hpet_id && ir_hpet[i].iommu)
-			return ir_hpet[i].iommu;
+			return ir_hpet[i].iommu->ir_domain;
+	}
 	return NULL;
 }
 
-static struct intel_iommu *map_ioapic_to_ir(int apic)
+static struct intel_iommu *map_ioapic_to_iommu(int apic)
 {
 	int i;
 
-	for (i = 0; i < MAX_IO_APICS; i++)
+	for (i = 0; i < MAX_IO_APICS; i++) {
 		if (ir_ioapic[i].id == apic && ir_ioapic[i].iommu)
 			return ir_ioapic[i].iommu;
+	}
 	return NULL;
 }
 
-static struct intel_iommu *map_dev_to_ir(struct pci_dev *dev)
+static struct irq_domain *map_ioapic_to_ir(int apic)
 {
-	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu = map_ioapic_to_iommu(apic);
 
-	drhd = dmar_find_matched_drhd_unit(dev);
-	if (!drhd)
-		return NULL;
+	return iommu ? iommu->ir_domain : NULL;
+}
+
+static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
+{
+	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
 
-	return drhd->iommu;
+	return drhd ? drhd->iommu->ir_msi_domain : NULL;
 }
 
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -1002,7 +1007,7 @@ static int __init parse_ioapics_under_ir(void)
 
 	for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
 		int ioapic_id = mpc_ioapic_id(ioapic_idx);
-		if (!map_ioapic_to_ir(ioapic_id)) {
+		if (!map_ioapic_to_iommu(ioapic_id)) {
 			pr_err(FW_BUG "ioapic %d has no mapping iommu, "
 			       "interrupt remapping will be disabled\n",
 			       ioapic_id);
@@ -1087,6 +1092,22 @@ static int reenable_irq_remapping(int eim)
 	return -1;
 }
 
+/*
+ * Store the MSI remapping domain pointer in the device if enabled.
+ *
+ * This is called from dmar_pci_bus_add_dev() so it works even when DMA
+ * remapping is disabled. Only update the pointer if the device is not
+ * already handled by a non default PCI/MSI interrupt domain. This protects
+ * e.g. VMD devices.
+ */
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
+{
+	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+		return;
+
+	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
+}
+
 static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 {
 	memset(irte, 0, sizeof(*irte));
@@ -1107,51 +1128,20 @@ static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 	irte->redir_hint = 1;
 }
 
-static struct irq_domain *intel_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	struct intel_iommu *iommu = NULL;
-
-	if (!info)
-		return NULL;
-
-	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_IOAPIC:
-		iommu = map_ioapic_to_ir(info->ioapic_id);
-		break;
-	case X86_IRQ_ALLOC_TYPE_HPET:
-		iommu = map_hpet_to_ir(info->hpet_id);
-		break;
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		break;
-	default:
-		BUG_ON(1);
-		break;
-	}
-
-	return iommu ? iommu->ir_domain : NULL;
-}
-
 static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 {
-	struct intel_iommu *iommu;
-
 	if (!info)
 		return NULL;
 
 	switch (info->type) {
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
-		iommu = map_dev_to_ir(info->msi_dev);
-		if (iommu)
-			return iommu->ir_msi_domain;
-		break;
+	case X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT:
+		return map_ioapic_to_ir(info->devid);
+	case X86_IRQ_ALLOC_TYPE_HPET_GET_PARENT:
+		return map_hpet_to_ir(info->devid);
 	default:
-		break;
+		WARN_ON_ONCE(1);
+		return NULL;
 	}
-
-	return NULL;
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
@@ -1160,7 +1150,6 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
-	.get_ir_irq_domain	= intel_get_ir_irq_domain,
 	.get_irq_domain		= intel_get_irq_domain,
 };
 
@@ -1284,16 +1273,16 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
-		set_ioapic_sid(irte, info->ioapic_id);
+		set_ioapic_sid(irte, info->devid);
 		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
-			info->ioapic_id, irte->present, irte->fpd,
+			info->devid, irte->present, irte->fpd,
 			irte->dst_mode, irte->redir_hint,
 			irte->trigger_mode, irte->dlvry_mode,
 			irte->avail, irte->vector, irte->dest_id,
 			irte->sid, irte->sq, irte->svt);
 
-		entry = (struct IR_IO_APIC_route_entry *)info->ioapic_entry;
-		info->ioapic_entry = NULL;
+		entry = (struct IR_IO_APIC_route_entry *)info->ioapic.entry;
+		info->ioapic.entry = NULL;
 		memset(entry, 0, sizeof(*entry));
 		entry->index2	= (index >> 15) & 0x1;
 		entry->zero	= 0;
@@ -1303,21 +1292,21 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		 * IO-APIC RTE will be configured with virtual vector.
 		 * irq handler will do the explicit EOI to the io-apic.
 		 */
-		entry->vector	= info->ioapic_pin;
+		entry->vector	= info->ioapic.pin;
 		entry->mask	= 0;			/* enable IRQ */
-		entry->trigger	= info->ioapic_trigger;
-		entry->polarity	= info->ioapic_polarity;
-		if (info->ioapic_trigger)
+		entry->trigger	= info->ioapic.trigger;
+		entry->polarity	= info->ioapic.polarity;
+		if (info->ioapic.trigger)
 			entry->mask = 1; /* Mask level triggered irqs. */
 		break;
 
 	case X86_IRQ_ALLOC_TYPE_HPET:
-	case X86_IRQ_ALLOC_TYPE_MSI:
-	case X86_IRQ_ALLOC_TYPE_MSIX:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
+	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
 		if (info->type == X86_IRQ_ALLOC_TYPE_HPET)
-			set_hpet_sid(irte, info->hpet_id);
+			set_hpet_sid(irte, info->devid);
 		else
-			set_msi_sid(irte, info->msi_dev);
+			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 
 		msg->address_hi = MSI_ADDR_BASE_HI;
 		msg->data = sub_handle;
@@ -1368,15 +1357,15 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 
 	if (!info || !iommu)
 		return -EINVAL;
-	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_MSI &&
-	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
+	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
+	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
 		return -EINVAL;
 
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
 	 */
-	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+	if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI)
 		info->flags &= ~X86_IRQ_ALLOC_CONTIGUOUS_VECTORS;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83f36f61416e..2d84b1ed205e 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -159,34 +159,13 @@ void panic_if_irq_remap(const char *msg)
 		panic(msg);
 }
 
-/**
- * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
- *				     device serving request @info
- * @info: interrupt allocation information, used to identify the IOMMU device
- *
- * It's used to get parent irqdomain for HPET and IOAPIC irqdomains.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *
-irq_remapping_get_ir_irq_domain(struct irq_alloc_info *info)
-{
-	if (!remap_ops || !remap_ops->get_ir_irq_domain)
-		return NULL;
-
-	return remap_ops->get_ir_irq_domain(info);
-}
-
 /**
  * irq_remapping_get_irq_domain - Get the irqdomain serving the request @info
  * @info: interrupt allocation information, used to identify the IOMMU device
  *
- * There will be one PCI MSI/MSIX irqdomain associated with each interrupt
- * remapping device, so this interface is used to retrieve the PCI MSI/MSIX
- * irqdomain serving request @info.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
-struct irq_domain *
-irq_remapping_get_irq_domain(struct irq_alloc_info *info)
+struct irq_domain *irq_remapping_get_irq_domain(struct irq_alloc_info *info)
 {
 	if (!remap_ops || !remap_ops->get_irq_domain)
 		return NULL;
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 6a190d504eb6..1661b3d75920 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -43,10 +43,7 @@ struct irq_remap_ops {
 	/* Enable fault handling */
 	int  (*enable_faulting)(void);
 
-	/* Get the irqdomain associated the IOMMU device */
-	struct irq_domain *(*get_ir_irq_domain)(struct irq_alloc_info *);
-
-	/* Get the MSI irqdomain associated with the IOMMU device */
+	/* Get the irqdomain associated to IOMMU device */
 	struct irq_domain *(*get_irq_domain)(struct irq_alloc_info *);
 };
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 4bef5c2bae9f..438a792d2cf7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -56,6 +56,9 @@ config PCI_MSI_IRQ_DOMAIN
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
+config PCI_MSI_ARCH_FALLBACKS
+	bool
+
 config PCI_QUIRKS
 	default y
 	bool "Enable PCI quirk workarounds" if EXPERT
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f18c3725ef80..4a7afbe189f8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -41,6 +41,7 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -67,6 +68,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
@@ -95,6 +97,7 @@ config PCI_HOST_GENERIC
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on OF || COMPILE_TEST
+	select PCI_MSI_ARCH_FALLBACKS
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fc4c3a15e570..25b4c9023bfa 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1531,16 +1531,8 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_unmask		= hv_irq_unmask,
 };
 
-static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
-						   msi_alloc_info_t *arg)
-{
-	return arg->msi_hwirq;
-}
-
 static struct msi_domain_ops hv_msi_ops = {
-	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 	.msi_free	= hv_msi_free,
 };
 
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c89f72..aa1b12bac9a1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -573,12 +573,19 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 
 	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
-						    x86_vector_domain);
+						    NULL);
+
 	if (!vmd->irq_domain) {
 		irq_domain_free_fwnode(fn);
 		return -ENODEV;
 	}
 
+	/*
+	 * Override the irq domain bus token so the domain can be distinguished
+	 * from a regular PCI/MSI domain.
+	 */
+	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30ae4ffda5c1..d52d118979a6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -58,8 +58,8 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 #define pci_msi_teardown_msi_irqs	arch_teardown_msi_irqs
 #endif
 
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /* Arch hooks */
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_controller *chip = dev->bus->msi;
@@ -132,6 +132,7 @@ void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 {
 	return default_teardown_msi_irqs(dev);
 }
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 {
@@ -1346,14 +1347,14 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
 
 /**
  * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @dev:	Pointer to the PCI device
  * @desc:	Pointer to the MSI descriptor
  *
  * The ID number is only used within the irqdomain.
  */
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc)
+static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
+
 	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
 		pci_dev_id(dev) << 11 |
 		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
@@ -1401,17 +1402,12 @@ static int pci_msi_domain_handle_error(struct irq_domain *domain,
 	return error;
 }
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
-					       desc);
+	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
-#else
-#define pci_msi_domain_set_desc		NULL
-#endif
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
 	.set_desc	= pci_msi_domain_set_desc,
@@ -1558,4 +1554,26 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
+
+/**
+ * pci_dev_has_special_msi_domain - Check whether the device is handled by
+ *				    a non-standard PCI-MSI domain
+ * @pdev:	The PCI device to check.
+ *
+ * Returns: True if the device irqdomain or the bus irqdomain is
+ * non-standard PCI/MSI.
+ */
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
+
+	if (!dom)
+		dom = dev_get_msi_domain(&pdev->bus->dev);
+
+	if (!dom)
+		return true;
+
+	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
+}
+
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..46f5aaaa66ff 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -425,6 +425,8 @@ struct q_inval {
 	int             free_cnt;
 };
 
+struct dmar_pci_notify_info;
+
 #ifdef CONFIG_IRQ_REMAP
 /* 1MB - maximum possible interrupt remapping table size */
 #define INTR_REMAP_PAGE_ORDER	8
@@ -439,6 +441,11 @@ struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
 };
+
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info);
+#else
+static inline void
+intel_irq_remap_add_device(struct dmar_pci_notify_info *info) { }
 #endif
 
 struct iommu_flush {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b37350c4fe37..44445d9de881 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -84,6 +84,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_FSL_MC_MSI,
 	DOMAIN_BUS_TI_SCI_INTA_MSI,
 	DOMAIN_BUS_WAKEUP,
+	DOMAIN_BUS_VMD_MSI,
 };
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ad679e9d9c0..6b584cc4757c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -193,17 +193,38 @@ void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
 /*
- * The arch hooks to setup up msi irqs. Those functions are
- * implemented as weak symbols so that they /can/ be overriden by
- * architecture specific code if needed.
+ * The arch hooks to setup up msi irqs. Default functions are implemented
+ * as weak symbols so that they /can/ be overriden by architecture specific
+ * code if needed. These hooks must be enabled by the architecture or by
+ * drivers which depend on them via msi_controller based MSI handling.
+ *
+ * If CONFIG_PCI_MSI_ARCH_FALLBACKS is not selected they are replaced by
+ * stubs with warnings.
  */
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
-void arch_restore_msi_irqs(struct pci_dev *dev);
-
 void default_teardown_msi_irqs(struct pci_dev *dev);
+#else
+static inline int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	WARN_ON_ONCE(1);
+	return -ENODEV;
+}
+
+static inline void arch_teardown_msi_irqs(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
+/*
+ * The restore hooks are still available as they are useful even
+ * for fully irq domain based setups. Courtesy to XEN/X86.
+ */
+void arch_restore_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
 
 struct msi_controller {
@@ -241,6 +262,10 @@ struct msi_domain_info;
  * @msi_finish:		Optional callback to finalize the allocation
  * @set_desc:		Set the msi descriptor for an interrupt
  * @handle_error:	Optional error handler if the allocation fails
+ * @domain_alloc_irqs:	Optional function to override the default allocation
+ *			function.
+ * @domain_free_irqs:	Optional function to override the default free
+ *			function.
  *
  * @get_hwirq, @msi_init and @msi_free are callbacks used by
  * msi_create_irq_domain() and related interfaces
@@ -248,6 +273,22 @@ struct msi_domain_info;
  * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
  * are callbacks used by msi_domain_alloc_irqs() and related
  * interfaces which are based on msi_desc.
+ *
+ * @domain_alloc_irqs, @domain_free_irqs can be used to override the
+ * default allocation/free functions (__msi_domain_alloc/free_irqs). This
+ * is initially for a wrapper around XENs seperate MSI universe which can't
+ * be wrapped into the regular irq domains concepts by mere mortals.  This
+ * allows to universally use msi_domain_alloc/free_irqs without having to
+ * special case XEN all over the place.
+ *
+ * Contrary to other operations @domain_alloc_irqs and @domain_free_irqs
+ * are set to the default implementation if NULL and even when
+ * MSI_FLAG_USE_DEF_DOM_OPS is not set to avoid breaking existing users and
+ * because these callbacks are obviously mandatory.
+ *
+ * This is NOT meant to be abused, but it can be useful to build wrappers
+ * for specialized MSI irq domains which need extra work before and after
+ * calling __msi_domain_alloc_irqs()/__msi_domain_free_irqs().
  */
 struct msi_domain_ops {
 	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
@@ -270,6 +311,10 @@ struct msi_domain_ops {
 				    struct msi_desc *desc);
 	int		(*handle_error)(struct irq_domain *domain,
 					struct msi_desc *desc, int error);
+	int		(*domain_alloc_irqs)(struct irq_domain *domain,
+					     struct device *dev, int nvec);
+	void		(*domain_free_irqs)(struct irq_domain *domain,
+					    struct device *dev);
 };
 
 /**
@@ -327,8 +372,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
@@ -369,12 +417,11 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
-					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 857f5f4c8098..0ae308efa604 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1541,18 +1541,17 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
  */
 int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct irq_data *pos = NULL;
+	struct irq_data *pos;
 
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	for (; data; data = data->parent_data)
-#endif
+	for (pos = NULL; !pos && data; data = irqd_get_parent_data(data)) {
 		if (data->chip && data->chip->irq_compose_msi_msg)
 			pos = data;
+	}
+
 	if (!pos)
 		return -ENOSYS;
 
 	pos->chip->irq_compose_msi_msg(pos, msg);
-
 	return 0;
 }
 
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 7db284b10ac9..54363527feea 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -473,6 +473,15 @@ static inline void irq_domain_deactivate_irq(struct irq_data *data)
 }
 #endif
 
+static inline struct irq_data *irqd_get_parent_data(struct irq_data *irqd)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irqd->parent_data;
+#else
+	return NULL;
+#endif
+}
+
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
 #include <linux/debugfs.h>
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb95f6106a1e..2c0c4d6d0f83 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -187,7 +187,6 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.deactivate	= msi_domain_deactivate,
 };
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
 						msi_alloc_info_t *arg)
 {
@@ -206,11 +205,6 @@ static void msi_domain_ops_set_desc(msi_alloc_info_t *arg,
 {
 	arg->desc = desc;
 }
-#else
-#define msi_domain_ops_get_hwirq	NULL
-#define msi_domain_ops_prepare		NULL
-#define msi_domain_ops_set_desc		NULL
-#endif /* !GENERIC_MSI_DOMAIN_OPS */
 
 static int msi_domain_ops_init(struct irq_domain *domain,
 			       struct msi_domain_info *info,
@@ -235,11 +229,13 @@ static int msi_domain_ops_check(struct irq_domain *domain,
 }
 
 static struct msi_domain_ops msi_domain_ops_default = {
-	.get_hwirq	= msi_domain_ops_get_hwirq,
-	.msi_init	= msi_domain_ops_init,
-	.msi_check	= msi_domain_ops_check,
-	.msi_prepare	= msi_domain_ops_prepare,
-	.set_desc	= msi_domain_ops_set_desc,
+	.get_hwirq		= msi_domain_ops_get_hwirq,
+	.msi_init		= msi_domain_ops_init,
+	.msi_check		= msi_domain_ops_check,
+	.msi_prepare		= msi_domain_ops_prepare,
+	.set_desc		= msi_domain_ops_set_desc,
+	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
+	.domain_free_irqs	= __msi_domain_free_irqs,
 };
 
 static void msi_domain_update_dom_ops(struct msi_domain_info *info)
@@ -251,6 +247,14 @@ static void msi_domain_update_dom_ops(struct msi_domain_info *info)
 		return;
 	}
 
+	if (ops->domain_alloc_irqs == NULL)
+		ops->domain_alloc_irqs = msi_domain_ops_default.domain_alloc_irqs;
+	if (ops->domain_free_irqs == NULL)
+		ops->domain_free_irqs = msi_domain_ops_default.domain_free_irqs;
+
+	if (!(info->flags & MSI_FLAG_USE_DEF_DOM_OPS))
+		return;
+
 	if (ops->get_hwirq == NULL)
 		ops->get_hwirq = msi_domain_ops_default.get_hwirq;
 	if (ops->msi_init == NULL)
@@ -284,8 +288,7 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		msi_domain_update_dom_ops(info);
+	msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
@@ -370,8 +373,13 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 {
 	struct msi_desc *desc;
 
-	if (domain->bus_token != DOMAIN_BUS_PCI_MSI)
+	switch(domain->bus_token) {
+	case DOMAIN_BUS_PCI_MSI:
+	case DOMAIN_BUS_VMD_MSI:
+		break;
+	default:
 		return false;
+	}
 
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
@@ -387,17 +395,8 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
 }
 
-/**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Returns 0 on success or an error code.
- */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			    int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
@@ -491,12 +490,24 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 }
 
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
- * @domain:	The domain to managing the interrupts
+ * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Returns 0 on success or an error code.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+			  int nvec)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	return ops->domain_alloc_irqs(domain, dev, nvec);
+}
+
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_desc *desc;
 
@@ -513,6 +524,20 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 	}
 }
 
+/**
+ * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_domain_ops *ops = info->ops;
+
+	return ops->domain_free_irqs(domain, dev);
+}
+
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from

