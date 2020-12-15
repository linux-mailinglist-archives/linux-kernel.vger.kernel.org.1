Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA72DAF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgLOOg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:36:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgLOOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:36:55 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608042964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=tp3xPzfLsRw1TQ61IWoGmb5RvOkYu8DEMRBoKqWjPR4=;
        b=Abz20FrGx+CbIgVVoNr2JB7MtfKBwr+wEwZZUq8OJ95MGyCAGGNJJL1czz7vSgSNzEvxIk
        oANEWFJvsEVGYw+CKlrl5oDhVfKXSxbxpeqRumvOMDUGEgs0N9VFZsViJVWB6XKssYXlQI
        H3L8S9L09bqbmP0rvmrp1BgDDf3VdDRTyL/9lnMf5YgWWd+rgYIIyEZT04HoLqJK+6bZQg
        DxRojG5vdhoBazfSL5IopuFTDVPvYFdk2Qi4cuZoAp3oMvLxSxJYY4Z2sUAgWoq8WD61oW
        IYnT9oLQ5DNV8lB56a8bU9Tr85gCnGUfcySXM+s3MqcYCxYswNrC6W3DlguraQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608042964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=tp3xPzfLsRw1TQ61IWoGmb5RvOkYu8DEMRBoKqWjPR4=;
        b=lUnYpHyyNUAc+AKE8uWpHXlIVXR0YgjXvFIpcjFvz59YSJMB+cXP/WwlsFwRF9XqqI85US
        UuGNKfTBvblAE3Cw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT pull V2] irq/core for v5.11-rc1
In-Reply-To: <87lfdzup6k.fsf@nanos.tec.linutronix.de>
Date:   Tue, 15 Dec 2020 15:36:03 +0100
Message-ID: <87pn3bt9v0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-12-15

up to:  3c41e57a1e16: Merge tag 'irqchip-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

This V2 has the broken changes removed and the irqchip pull request from Marc
remerged on top. Sorry for the inconveniance.

Generic interrupt and irqchips subsystem:

 Core:

     - Consolidation and robustness changes for irq time accounting

     - Cleanup and consolidation of irq stats

     - Remove the fasteoi IPI flow which has been proved useless

     - Provide an interface for converting legacy interrupt mechanism into
       irqdomains

 Drivers:

     The rare event of not having completely new chip driver code, just new
     DT bindings and extensions of existing drivers to accomodate new
     variants!

     - Preliminary support for managed interrupts on platform devices

     - Correctly identify allocation of MSIs proxyied by another device

     - Generalise the Ocelot support to new SoCs

     - Improve GICv4.1 vcpu entry, matching the corresponding KVM optimisation

     - Work around spurious interrupts on Qualcomm PDC

     - Random fixes and cleanups

Thanks,

	tglx


Thanks,

	tglx

------------------>
Andy Shevchenko (5):
      irqdomain: Remove unused of_device_id forward declaration
      irqdomain: Add forward declaration of fwnode_handle
      irqdomain: Replace open coded of_node_to_fwnode()
      irqdomain: Introduce irq_domain_create_legacy() API
      regmap: irq: Convert to use irq_domain_create_legacy()

Biwen Li (1):
      dt-bindings: interrupt-controller: update bindings for supporting more SoCs

Douglas Anderson (1):
      irqchip/qcom-pdc: Fix phantom irq when changing between rising/falling

Frederic Weisbecker (5):
      sched/cputime: Remove symbol exports from IRQ time accounting
      s390/vtime: Use the generic IRQ entry accounting
      sched/vtime: Consolidate IRQ time accounting
      irqtime: Move irqtime entry accounting after irq offset incrementation
      irq: Call tick_irq_enter() inside HARDIRQ_OFFSET

Geert Uytterhoeven (2):
      sh/irq: Add missing closing parentheses in arch_show_interrupts()
      irqchip/gic: Spelling s/REturn/Return/

Gregory CLEMENT (6):
      dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema
      dt-bindings: interrupt-controller: Add binding for few Microsemi interrupt controllers
      irqchip/ocelot: prepare to support more SoC
      irqchip/ocelot: Add support for Luton platforms
      irqchip/ocelot: Add support for Serval platforms
      irqchip/ocelot: Add support for Jaguar2 platforms

Hou Zhiqiang (1):
      irqchip/ls-extirq: Add LS1043A, LS1088A external interrupt support

Huacai Chen (1):
      irqchip/loongson-htpic: Fix build warnings

John Garry (4):
      genirq/affinity: Add irq_update_affinity_desc()
      resource: Add irqresource_disabled()
      ACPI: Drop acpi_dev_irqresource_disabled()
      driver core: platform: Add devm_platform_get_irqs_affinity()

Lokesh Vutla (2):
      irqchip/ti-sci-inta: Fix printing of inta id on probe success
      irqchip/ti-sci-intr: Fix freeing of irqs

Marc Zyngier (5):
      genirq/irqdomain: Don't try to free an interrupt that has no mapping
      irqchip/alpine-msi: Fix freeing of interrupts on allocation error path
      platform-msi: Track shared domain allocation
      irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy device
      irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI bridge

Mauro Carvalho Chehab (1):
      genirq: Fix kernel-doc markups

Shenming Lu (1):
      irqchip/gic-v4.1: Reduce the delay when polling GICR_VPENDBASER.Dirty

Thomas Gleixner (13):
      genirq: Remove GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
      genirq/irqdomain: Make irq_domain_disassociate() static
      parisc: Remove bogus __IRQ_STAT macro
      sh: Get rid of nmi_count()
      irqstat: Get rid of nmi_count() and __IRQ_STAT()
      um/irqstat: Get rid of the duplicated declarations
      ARM: irqstat: Get rid of duplicated declaration
      arm64: irqstat: Get rid of duplicated declaration
      asm-generic/irqstat: Add optional __nmi_count member
      sh: irqstat: Use the generic irq_cpustat_t
      irqstat: Move declaration into asm-generic/hardirq.h
      preempt: Cleanup the macro maze a bit
      softirq: Move related code into one section

Valentin Schneider (5):
      irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()
      irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
      irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
      irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
      Revert "genirq: Add fasteoi IPI flow"

Vineet Gupta (1):
      drivers/irqchip: Remove EZChip NPS interrupt controller


 Documentation/core-api/irq/irq-domain.rst          |   6 +
 .../interrupt-controller/fsl,ls-extirq.txt         |   8 +-
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  21 ---
 .../mscc,ocelot-icpu-intr.yaml                     |  64 ++++++++
 arch/Kconfig                                       |   7 +-
 arch/arm/include/asm/hardirq.h                     |  11 +-
 arch/arm/include/asm/irq.h                         |   2 +
 arch/arm64/include/asm/hardirq.h                   |   7 +-
 arch/ia64/kernel/time.c                            |  20 ++-
 arch/parisc/include/asm/hardirq.h                  |   1 -
 arch/powerpc/kernel/time.c                         |  56 +++++--
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/vtime.h                      |   1 -
 arch/s390/kernel/vtime.c                           |  51 ++++---
 arch/sh/include/asm/hardirq.h                      |  14 +-
 arch/sh/kernel/irq.c                               |   2 +-
 arch/sh/kernel/traps.c                             |   2 +-
 arch/um/include/asm/hardirq.h                      |  17 +--
 drivers/acpi/resource.c                            |  17 +--
 drivers/base/platform-msi.c                        |   7 +
 drivers/base/platform.c                            | 121 +++++++++++++++
 drivers/base/regmap/regmap-irq.c                   |  11 +-
 drivers/irqchip/Kconfig                            |   7 -
 drivers/irqchip/Makefile                           |   1 -
 drivers/irqchip/irq-alpine-msi.c                   |   3 +-
 drivers/irqchip/irq-armada-370-xp.c                |   2 +-
 drivers/irqchip/irq-bcm2836.c                      |   2 +-
 drivers/irqchip/irq-eznps.c                        | 165 ---------------------
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |  11 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   5 +-
 drivers/irqchip/irq-gic-v3.c                       |   6 -
 drivers/irqchip/irq-gic.c                          |  10 +-
 drivers/irqchip/irq-hip04.c                        |   6 +-
 drivers/irqchip/irq-loongson-htpic.c               |   7 +-
 drivers/irqchip/irq-ls-extirq.c                    |  16 +-
 drivers/irqchip/irq-mscc-ocelot.c                  | 146 +++++++++++++++---
 drivers/irqchip/irq-ti-sci-inta.c                  |   2 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |  14 +-
 drivers/irqchip/qcom-pdc.c                         |  21 ++-
 include/asm-generic/hardirq.h                      |   6 +-
 include/asm-generic/msi.h                          |   4 +
 include/linux/hardirq.h                            |   4 +-
 include/linux/interrupt.h                          |   8 +
 include/linux/ioport.h                             |   7 +
 include/linux/irq.h                                |  16 --
 include/linux/irq_cpustat.h                        |  28 ----
 include/linux/irqdomain.h                          |  10 +-
 include/linux/platform_device.h                    |   6 +
 include/linux/preempt.h                            |  30 ++--
 include/linux/vtime.h                              |  42 ++++--
 kernel/irq/Kconfig                                 |   5 -
 kernel/irq/chip.c                                  |  29 +---
 kernel/irq/generic-chip.c                          |   2 +-
 kernel/irq/irqdesc.c                               |  51 -------
 kernel/irq/irqdomain.c                             |  32 +++-
 kernel/irq/manage.c                                |  70 +++++++++
 kernel/sched/cputime.c                             |  36 +++--
 kernel/softirq.c                                   | 127 ++++++++--------
 58 files changed, 758 insertions(+), 626 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
 delete mode 100644 drivers/irqchip/irq-eznps.c
 delete mode 100644 include/linux/irq_cpustat.h

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 096db12f32d5..a77c24c27f7b 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -147,6 +147,7 @@ Legacy
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
 	irq_domain_add_legacy_isa()
+	irq_domain_create_legacy()
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
@@ -185,6 +186,11 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
+irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
+equivalent, except for the first argument is different - the former
+accepts an Open Firmware specific 'struct device_node', while the latter
+accepts a more general abstraction 'struct fwnode_handle'.
+
 Hierarchy IRQ domain
 --------------------
 
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
index f0ad7801e8cf..4d47df1a5c91 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -1,6 +1,7 @@
 * Freescale Layerscape external IRQs
 
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
+LS1088A, LS208xA, LX216xA) support inverting
 the polarity of certain external interrupt lines.
 
 The device node must be a child of the node representing the
@@ -8,12 +9,15 @@ Supplemental Configuration Unit (SCFG).
 
 Required properties:
 - compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
+  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
 - #interrupt-cells: Must be 2. The first element is the index of the
   external interrupt line. The second element is the trigger type.
 - #address-cells: Must be 0.
 - interrupt-controller: Identifies the node as an interrupt controller
 - reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
-  the SCFG.
+  the SCFG or the External Interrupt Control Register (IRQCR) in
+  the ISC.
 - interrupt-map: Specifies the mapping from external interrupts to GIC
   interrupts.
 - interrupt-map-mask: Must be <0xffffffff 0>.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
deleted file mode 100644
index f5baeccb689f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Microsemi Ocelot SoC ICPU Interrupt Controller
-
-Required properties:
-
-- compatible : should be "mscc,ocelot-icpu-intr"
-- reg : Specifies base physical address and size of the registers.
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 1.
-- interrupts : Specifies the CPU interrupt the controller is connected to.
-
-Example:
-
-		intc: interrupt-controller@70000070 {
-			compatible = "mscc,ocelot-icpu-intr";
-			reg = <0x70000070 0x70>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			interrupt-parent = <&cpuintc>;
-			interrupts = <2>;
-		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
new file mode 100644
index 000000000000..27b798bfe29b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/mscc,ocelot-icpu-intr.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microsemi Ocelot SoC ICPU Interrupt Controller
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  the Microsemi Ocelot interrupt controller that is part of the
+  ICPU. It is connected directly to the MIPS core interrupt
+  controller.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mscc,jaguar2-icpu-intr
+          - mscc,luton-icpu-intr
+          - mscc,ocelot-icpu-intr
+          - mscc,serval-icpu-intr
+
+
+  '#interrupt-cells':
+    const: 1
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@70000070 {
+        compatible = "mscc,ocelot-icpu-intr";
+        reg = <0x70000070 0x70>;
+        #interrupt-cells = <1>;
+        #address-cells = <0>;
+        interrupt-controller;
+        interrupt-parent = <&cpuintc>;
+        interrupts = <2>;
+    };
+...
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..0f151b49c7b7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -627,6 +627,12 @@ config HAVE_TIF_NOHZ
 config HAVE_VIRT_CPU_ACCOUNTING
 	bool
 
+config HAVE_VIRT_CPU_ACCOUNTING_IDLE
+	bool
+	help
+	  Architecture has its own way to account idle CPU time and therefore
+	  doesn't implement vtime_account_idle().
+
 config ARCH_HAS_SCALED_CPUTIME
 	bool
 
@@ -641,7 +647,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_GEN
 	  some 32-bit arches may require multiple accesses, so proper
 	  locking is needed to protect against concurrent accesses.
 
-
 config HAVE_IRQ_TIME_ACCOUNTING
 	bool
 	help
diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index b95848ed2bc7..706efafbf972 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -2,16 +2,11 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
 #include <asm/irq.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
+#define ack_bad_irq ack_bad_irq
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 46d41140df27..1cbcc462b07e 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,6 +31,8 @@ void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
+#include <linux/cpumask.h>
+
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 5ffa4bacdad3..cbfa7b6f2e09 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,11 +13,8 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define ack_bad_irq ack_bad_irq
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf..733e0e3324b8 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -138,12 +138,8 @@ void vtime_account_kernel(struct task_struct *tsk)
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count())
+	if (tsk->flags & PF_VCPU)
 		ti->gtime += stime;
-	else if (hardirq_count())
-		ti->hardirq_time += stime;
-	else if (in_serving_softirq())
-		ti->softirq_time += stime;
 	else
 		ti->stime += stime;
 }
@@ -156,6 +152,20 @@ void vtime_account_idle(struct task_struct *tsk)
 	ti->idle_time += vtime_delta(tsk);
 }
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->softirq_time += vtime_delta(tsk);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->hardirq_time += vtime_delta(tsk);
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 static irqreturn_t
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 7f7039516e53..fad29aa6f45f 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -32,7 +32,6 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-#define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 74efe46f5532..cf3f8db7e0e3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -311,12 +311,11 @@ static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 	return stime_scaled;
 }
 
-static unsigned long vtime_delta(struct task_struct *tsk,
+static unsigned long vtime_delta(struct cpu_accounting_data *acct,
 				 unsigned long *stime_scaled,
 				 unsigned long *steal_time)
 {
 	unsigned long now, stime;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
 
 	WARN_ON_ONCE(!irqs_disabled());
 
@@ -331,29 +330,30 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
+static void vtime_delta_kernel(struct cpu_accounting_data *acct,
+			       unsigned long *stime, unsigned long *stime_scaled)
+{
+	unsigned long steal_time;
+
+	*stime = vtime_delta(acct, stime_scaled, &steal_time);
+	*stime -= min(*stime, steal_time);
+	acct->steal_time += steal_time;
+}
+
 void vtime_account_kernel(struct task_struct *tsk)
 {
-	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long stime, stime_scaled;
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
-
-	stime -= min(stime, steal_time);
-	acct->steal_time += steal_time;
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count()) {
+	if (tsk->flags & PF_VCPU) {
 		acct->gtime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
 #endif
 	} else {
-		if (hardirq_count())
-			acct->hardirq_time += stime;
-		else if (in_serving_softirq())
-			acct->softirq_time += stime;
-		else
-			acct->stime += stime;
-
+		acct->stime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
 #endif
@@ -366,10 +366,34 @@ void vtime_account_idle(struct task_struct *tsk)
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	stime = vtime_delta(acct, &stime_scaled, &steal_time);
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_account_irq_field(struct cpu_accounting_data *acct,
+				    unsigned long *field)
+{
+	unsigned long stime, stime_scaled;
+
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
+	*field += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->stime_scaled += stime_scaled;
+#endif
+}
+
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->softirq_time);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->hardirq_time);
+}
+
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4a2a12be04c9..6f1fdcd3b5db 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -181,6 +181,7 @@ config S390
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
 	select MODULES_USE_ELF_RELA
diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index 3622d4ebc73a..fac6a67988eb 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,7 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_ACCOUNT
 #define __ARCH_HAS_VTIME_TASK_SWITCH
 
 #endif /* _S390_VTIME_H */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3c8f6c..5aaa2ca6a928 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -222,35 +222,50 @@ void vtime_flush(struct task_struct *tsk)
 	S390_lowcore.avg_steal_timer = avg_steal;
 }
 
+static u64 vtime_delta(void)
+{
+	u64 timer = S390_lowcore.last_update_timer;
+
+	S390_lowcore.last_update_timer = get_vtimer();
+
+	return timer - S390_lowcore.last_update_timer;
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
-	u64 timer;
-
-	timer = S390_lowcore.last_update_timer;
-	S390_lowcore.last_update_timer = get_vtimer();
-	timer -= S390_lowcore.last_update_timer;
+	u64 delta = vtime_delta();
 
-	if ((tsk->flags & PF_VCPU) && (irq_count() == 0))
-		S390_lowcore.guest_timer += timer;
-	else if (hardirq_count())
-		S390_lowcore.hardirq_timer += timer;
-	else if (in_serving_softirq())
-		S390_lowcore.softirq_timer += timer;
+	if (tsk->flags & PF_VCPU)
+		S390_lowcore.guest_timer += delta;
 	else
-		S390_lowcore.system_timer += timer;
+		S390_lowcore.system_timer += delta;
 
-	virt_timer_forward(timer);
+	virt_timer_forward(delta);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-
-void vtime_account_kernel(struct task_struct *tsk)
-__attribute__((alias("vtime_account_irq_enter")));
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.softirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.hardirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/arch/sh/include/asm/hardirq.h b/arch/sh/include/asm/hardirq.h
index edaea3559a23..9fe4495a8e90 100644
--- a/arch/sh/include/asm/hardirq.h
+++ b/arch/sh/include/asm/hardirq.h
@@ -2,16 +2,10 @@
 #ifndef __ASM_SH_HARDIRQ_H
 #define __ASM_SH_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/irq.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-	unsigned int __nmi_count;		/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 extern void ack_bad_irq(unsigned int irq);
+#define ack_bad_irq ack_bad_irq
+#define ARCH_WANTS_NMI_IRQSTAT
+
+#include <asm-generic/hardirq.h>
 
 #endif /* __ASM_SH_HARDIRQ_H */
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 5717c7cbdd97..ab5f790b0cd2 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 9c3d32b80038..f5beecdac693 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
 	arch_ftrace_nmi_enter();
 
 	nmi_enter();
-	nmi_count(cpu)++;
+	this_cpu_inc(irq_stat.__nmi_count);
 
 	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
 	case NOTIFY_OK:
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index b426796d26fd..52e2c36267a9 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,22 +2,7 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <linux/cache.h>
-#include <linux/threads.h>
-
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-#include <linux/irq.h>
-
-#ifndef ack_bad_irq
-static inline void ack_bad_irq(unsigned int irq)
-{
-	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
-}
-#endif
+#include <asm-generic/hardirq.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824ca3ba..58203193417e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,13 +380,6 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
-{
-	res->start = gsi;
-	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
-}
-
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
@@ -394,7 +387,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	int irq, p, t;
 
 	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 		return;
 	}
 
@@ -426,7 +419,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 	}
 }
 
@@ -463,7 +456,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		 */
 		irq = &ares->data.irq;
 		if (index >= irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
@@ -473,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
 		if (index >= ext_irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		if (is_gsi(ext_irq))
@@ -481,7 +474,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->shareable, false);
 		else
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index c4a17e5edf8b..2c1e2e0c1a59 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -59,9 +59,15 @@ static int platform_msi_init(struct irq_domain *domain,
 	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 					     info->chip, info->chip_data);
 }
+
+static void platform_msi_set_proxy_dev(msi_alloc_info_t *arg)
+{
+	arg->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+}
 #else
 #define platform_msi_set_desc		NULL
 #define platform_msi_init		NULL
+#define platform_msi_set_proxy_dev(x)	do {} while(0)
 #endif
 
 static void platform_msi_update_dom_ops(struct msi_domain_info *info)
@@ -343,6 +349,7 @@ __platform_msi_create_device_domain(struct device *dev,
 	if (!domain)
 		goto free_priv;
 
+	platform_msi_set_proxy_dev(&data->arg);
 	err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
 	if (err)
 		goto free_domain;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93eb4dd..ea8add164b89 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -15,6 +15,8 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/dma-mapping.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
@@ -289,6 +291,125 @@ int platform_irq_count(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(platform_irq_count);
 
+struct irq_affinity_devres {
+	unsigned int count;
+	unsigned int irq[];
+};
+
+static void platform_disable_acpi_irq(struct platform_device *pdev, int index)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, index);
+	if (r)
+		irqresource_disabled(r, 0);
+}
+
+static void devm_platform_get_irqs_affinity_release(struct device *dev,
+						    void *res)
+{
+	struct irq_affinity_devres *ptr = res;
+	int i;
+
+	for (i = 0; i < ptr->count; i++) {
+		irq_dispose_mapping(ptr->irq[i]);
+
+		if (has_acpi_companion(dev))
+			platform_disable_acpi_irq(to_platform_device(dev), i);
+	}
+}
+
+/**
+ * devm_platform_get_irqs_affinity - devm method to get a set of IRQs for a
+ *				device using an interrupt affinity descriptor
+ * @dev: platform device pointer
+ * @affd: affinity descriptor
+ * @minvec: minimum count of interrupt vectors
+ * @maxvec: maximum count of interrupt vectors
+ * @irqs: pointer holder for IRQ numbers
+ *
+ * Gets a set of IRQs for a platform device, and updates IRQ afffinty according
+ * to the passed affinity descriptor
+ *
+ * Return: Number of vectors on success, negative error number on failure.
+ */
+int devm_platform_get_irqs_affinity(struct platform_device *dev,
+				    struct irq_affinity *affd,
+				    unsigned int minvec,
+				    unsigned int maxvec,
+				    int **irqs)
+{
+	struct irq_affinity_devres *ptr;
+	struct irq_affinity_desc *desc;
+	size_t size;
+	int i, ret, nvec;
+
+	if (!affd)
+		return -EPERM;
+
+	if (maxvec < minvec)
+		return -ERANGE;
+
+	nvec = platform_irq_count(dev);
+
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
+	if (nvec < minvec)
+		return -ENOSPC;
+
+	if (nvec > maxvec)
+		nvec = maxvec;
+
+	size = sizeof(*ptr) + sizeof(unsigned int) * nvec;
+	ptr = devres_alloc(devm_platform_get_irqs_affinity_release, size,
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ptr->count = nvec;
+
+	for (i = 0; i < nvec; i++) {
+		int irq = platform_get_irq(dev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto err_free_devres;
+		}
+		ptr->irq[i] = irq;
+	}
+
+	desc = irq_create_affinity_masks(nvec, affd);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_free_devres;
+	}
+
+	for (i = 0; i < nvec; i++) {
+		ret = irq_update_affinity_desc(ptr->irq[i], &desc[i]);
+		if (ret) {
+			dev_err(&dev->dev, "failed to update irq%d affinity descriptor (%d)\n",
+				ptr->irq[i], ret);
+			goto err_free_desc;
+		}
+	}
+
+	devres_add(&dev->dev, ptr);
+
+	kfree(desc);
+
+	*irqs = ptr->irq;
+
+	return nvec;
+
+err_free_desc:
+	kfree(desc);
+err_free_devres:
+	devres_free(ptr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_platform_get_irqs_affinity);
+
 /**
  * platform_get_resource_byname - get a resource for a device by name
  * @dev: platform device
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index ad5c2de395d1..19db764ffa4a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -803,13 +803,12 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	}
 
 	if (irq_base)
-		d->domain = irq_domain_add_legacy(to_of_node(fwnode),
-						  chip->num_irqs, irq_base,
-						  0, &regmap_domain_ops, d);
+		d->domain = irq_domain_create_legacy(fwnode, chip->num_irqs,
+						     irq_base, 0,
+						     &regmap_domain_ops, d);
 	else
-		d->domain = irq_domain_add_linear(to_of_node(fwnode),
-						  chip->num_irqs,
-						  &regmap_domain_ops, d);
+		d->domain = irq_domain_create_linear(fwnode, chip->num_irqs,
+						     &regmap_domain_ops, d);
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2aa79c32ee22..94920a51c628 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -387,13 +387,6 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
 
-config EZNPS_GIC
-	bool "NPS400 Global Interrupt Manager (GIM)"
-	depends on ARC || (COMPILE_TEST && !64BIT)
-	select IRQ_DOMAIN
-	help
-	  Support the EZchip NPS400 global interrupt controller
-
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 94c2885882ee..0ac93bfaec61 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -86,7 +86,6 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
-obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 23a3b877f7f1..ede02dc2bcd0 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,8 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	while (--i >= 0)
-		irq_domain_free_irqs_parent(domain, virq, i);
+	irq_domain_free_irqs_parent(domain, virq, i - 1);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d7eb2e93db8f..32938dfc0e46 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -382,7 +382,7 @@ static int armada_370_xp_ipi_alloc(struct irq_domain *d,
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
 				    d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
+				    handle_percpu_devid_irq,
 				    NULL, NULL);
 	}
 
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index cbc7c740e4dc..5f5eb8877c41 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -209,7 +209,7 @@ static int bcm2836_arm_irqchip_ipi_alloc(struct irq_domain *d,
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &bcm2836_arm_irqchip_ipi,
 				    d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
+				    handle_percpu_devid_irq,
 				    NULL, NULL);
 	}
 
diff --git a/drivers/irqchip/irq-eznps.c b/drivers/irqchip/irq-eznps.c
deleted file mode 100644
index 2a7a38830a8d..000000000000
--- a/drivers/irqchip/irq-eznps.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/irqchip.h>
-#include <soc/nps/common.h>
-
-#define NPS_NR_CPU_IRQS 8  /* number of interrupt lines of NPS400 CPU */
-#define NPS_TIMER0_IRQ  3
-
-/*
- * NPS400 core includes an Interrupt Controller (IC) support.
- * All cores can deactivate level irqs at first level control
- * at cores mesh layer called MTM.
- * For devices out side chip e.g. uart, network there is another
- * level called Global Interrupt Manager (GIM).
- * This second level can control level and edge interrupt.
- *
- * NOTE: AUX_IENABLE and CTOP_AUX_IACK are auxiliary registers
- * with private HW copy per CPU.
- */
-
-static void nps400_irq_mask(struct irq_data *irqd)
-{
-	unsigned int ienb;
-	unsigned int irq = irqd_to_hwirq(irqd);
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb &= ~(1 << irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static void nps400_irq_unmask(struct irq_data *irqd)
-{
-	unsigned int ienb;
-	unsigned int irq = irqd_to_hwirq(irqd);
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb |= (1 << irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static void nps400_irq_eoi_global(struct irq_data *irqd)
-{
-	unsigned int __maybe_unused irq = irqd_to_hwirq(irqd);
-
-	write_aux_reg(CTOP_AUX_IACK, 1 << irq);
-
-	/* Don't ack GIC before all device access attempts are done */
-	mb();
-
-	nps_ack_gic();
-}
-
-static void nps400_irq_ack(struct irq_data *irqd)
-{
-	unsigned int __maybe_unused irq = irqd_to_hwirq(irqd);
-
-	write_aux_reg(CTOP_AUX_IACK, 1 << irq);
-}
-
-static struct irq_chip nps400_irq_chip_fasteoi = {
-	.name		= "NPS400 IC Global",
-	.irq_mask	= nps400_irq_mask,
-	.irq_unmask	= nps400_irq_unmask,
-	.irq_eoi	= nps400_irq_eoi_global,
-};
-
-static struct irq_chip nps400_irq_chip_percpu = {
-	.name		= "NPS400 IC",
-	.irq_mask	= nps400_irq_mask,
-	.irq_unmask	= nps400_irq_unmask,
-	.irq_ack	= nps400_irq_ack,
-};
-
-static int nps400_irq_map(struct irq_domain *d, unsigned int virq,
-			  irq_hw_number_t hw)
-{
-	switch (hw) {
-	case NPS_TIMER0_IRQ:
-#ifdef CONFIG_SMP
-	case NPS_IPI_IRQ:
-#endif
-		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &nps400_irq_chip_percpu,
-					 handle_percpu_devid_irq);
-		break;
-	default:
-		irq_set_chip_and_handler(virq, &nps400_irq_chip_fasteoi,
-					 handle_fasteoi_irq);
-		break;
-	}
-
-	return 0;
-}
-
-static const struct irq_domain_ops nps400_irq_ops = {
-	.xlate = irq_domain_xlate_onecell,
-	.map = nps400_irq_map,
-};
-
-static int __init nps400_of_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	struct irq_domain *nps400_root_domain;
-
-	if (parent) {
-		pr_err("DeviceTree incore ic not a root irq controller\n");
-		return -EINVAL;
-	}
-
-	nps400_root_domain = irq_domain_add_linear(node, NPS_NR_CPU_IRQS,
-						   &nps400_irq_ops, NULL);
-
-	if (!nps400_root_domain) {
-		pr_err("nps400 root irq domain not avail\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * Needed for primary domain lookup to succeed
-	 * This is a primary irqchip, and can never have a parent
-	 */
-	irq_set_default_host(nps400_root_domain);
-
-#ifdef CONFIG_SMP
-	irq_create_mapping(nps400_root_domain, NPS_IPI_IRQ);
-#endif
-
-	return 0;
-}
-IRQCHIP_DECLARE(ezchip_nps400_ic, "ezchip,nps400-ic", nps400_of_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 87711e0f8014..ad2810c017ed 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -67,11 +67,16 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	/*
 	 * If pdev is downstream of any aliasing bridges, take an upper
 	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
 	 */
 	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev != pdev && alias_dev->subordinate)
-		pci_walk_bus(alias_dev->subordinate, its_pci_msi_vec_count,
-			     &alias_count);
+	if (alias_dev != pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
 
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4069c215328b..c951ad24d377 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3487,6 +3487,9 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		goto out;
 	}
 
+	if (info->flags & MSI_ALLOC_FLAGS_PROXY_DEVICE)
+		its_dev->shared = true;
+
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	mutex_unlock(&its->dev_alloc_lock);
@@ -3808,7 +3811,7 @@ static void its_wait_vpt_parse_complete(void)
 	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
 						       val,
 						       !(val & GICR_VPENDBASER_Dirty),
-						       10, 500));
+						       1, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0febe8..3fc65375cbe0 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1302,12 +1302,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	switch (__get_intid_range(hw)) {
 	case SGI_RANGE:
-		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
-				    NULL, NULL);
-		break;
-
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6053245a4754..b1d9c22caf2e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -973,7 +973,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
 /*
  * gic_get_sgir_physaddr - get the physical address for the SGI register
  *
- * REturn the physical address of the SGI register to be used
+ * Return the physical address of the SGI register to be used
  * by some early assembly code when the kernel is not yet available.
  */
 static unsigned long gic_dist_physaddr;
@@ -1005,13 +1005,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	switch (hw) {
-	case 0 ... 15:
-		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
-				    NULL, NULL);
-		break;
-	case 16 ... 31:
+	case 0 ... 31:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 9b73dcfaf48d..a6ed877d9dd3 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -296,11 +296,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 16) {
-		irq_set_percpu_devid(irq);
-		irq_set_chip_and_handler(irq, &hip04_irq_chip,
-					 handle_percpu_devid_fasteoi_ipi);
-	} else if (hw < 32) {
+	if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
diff --git a/drivers/irqchip/irq-loongson-htpic.c b/drivers/irqchip/irq-loongson-htpic.c
index 63f72803c8c4..1b801c4fb026 100644
--- a/drivers/irqchip/irq-loongson-htpic.c
+++ b/drivers/irqchip/irq-loongson-htpic.c
@@ -59,11 +59,10 @@ static void htpic_reg_init(void)
 	int i;
 
 	for (i = 0; i < HTINT_NUM_VECTORS; i++) {
-		uint32_t val;
-
 		/* Disable all HT Vectors */
 		writel(0x0, htpic->base + HTINT_EN_OFF + i * 0x4);
-		val = readl(htpic->base + i * 0x4);
+		/* Read back to force write */
+		(void) readl(htpic->base + i * 0x4);
 		/* Ack all possible pending IRQs */
 		writel(GENMASK(31, 0), htpic->base + i * 0x4);
 	}
@@ -81,7 +80,7 @@ struct syscore_ops htpic_syscore_ops = {
 	.resume		= htpic_resume,
 };
 
-int __init htpic_of_init(struct device_node *node, struct device_node *parent)
+static int __init htpic_of_init(struct device_node *node, struct device_node *parent)
 {
 	unsigned int parent_irq[4];
 	int i, err;
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179fed77c..f94f974a8764 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -18,7 +18,7 @@
 struct ls_extirq_data {
 	struct regmap		*syscon;
 	u32			intpcr;
-	bool			bit_reverse;
+	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
@@ -30,7 +30,7 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	irq_hw_number_t hwirq = data->hwirq;
 	u32 value, mask;
 
-	if (priv->bit_reverse)
+	if (priv->is_ls1021a_or_ls1043a)
 		mask = 1U << (31 - hwirq);
 	else
 		mask = 1U << hwirq;
@@ -174,14 +174,8 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	if (ret)
 		goto out;
 
-	if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
-		u32 revcr;
-
-		ret = regmap_read(priv->syscon, LS1021A_SCFGREVCR, &revcr);
-		if (ret)
-			goto out;
-		priv->bit_reverse = (revcr != 0);
-	}
+	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
+				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
@@ -195,3 +189,5 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 88143c0b700c..8235d98650c1 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -12,30 +12,85 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
 
-#define ICPU_CFG_INTR_INTR_STICKY	0x10
-#define ICPU_CFG_INTR_INTR_ENA		0x18
-#define ICPU_CFG_INTR_INTR_ENA_CLR	0x1c
-#define ICPU_CFG_INTR_INTR_ENA_SET	0x20
-#define ICPU_CFG_INTR_DST_INTR_IDENT(x)	(0x38 + 0x4 * (x))
-#define ICPU_CFG_INTR_INTR_TRIGGER(x)	(0x5c + 0x4 * (x))
-
-#define OCELOT_NR_IRQ 24
+#define ICPU_CFG_INTR_DST_INTR_IDENT(_p, x) ((_p)->reg_off_ident + 0x4 * (x))
+#define ICPU_CFG_INTR_INTR_TRIGGER(_p, x)   ((_p)->reg_off_trigger + 0x4 * (x))
+
+#define FLAGS_HAS_TRIGGER	BIT(0)
+#define FLAGS_NEED_INIT_ENABLE	BIT(1)
+
+struct chip_props {
+	u8 flags;
+	u8 reg_off_sticky;
+	u8 reg_off_ena;
+	u8 reg_off_ena_clr;
+	u8 reg_off_ena_set;
+	u8 reg_off_ident;
+	u8 reg_off_trigger;
+	u8 reg_off_ena_irq0;
+	u8 n_irq;
+};
+
+static struct chip_props ocelot_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.n_irq			= 24,
+};
+
+static struct chip_props serval_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0xc,
+	.reg_off_ena		= 0x14,
+	.reg_off_ena_clr	= 0x18,
+	.reg_off_ena_set	= 0x1c,
+	.reg_off_ident		= 0x20,
+	.reg_off_trigger	= 0x4,
+	.n_irq			= 24,
+};
+
+static struct chip_props luton_props = {
+	.flags			= FLAGS_NEED_INIT_ENABLE,
+	.reg_off_sticky		= 0,
+	.reg_off_ena		= 0x4,
+	.reg_off_ena_clr	= 0x8,
+	.reg_off_ena_set	= 0xc,
+	.reg_off_ident		= 0x18,
+	.reg_off_ena_irq0	= 0x14,
+	.n_irq			= 28,
+};
+
+static struct chip_props jaguar2_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.n_irq			= 29,
+};
 
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_domain *d = data->domain;
+	struct chip_props *p = d->host_data;
 	struct irq_chip_type *ct = irq_data_get_chip_type(data);
 	unsigned int mask = data->mask;
 	u32 val;
 
 	irq_gc_lock(gc);
-	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
-	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
+	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 0)) |
+		irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 1));
 	if (!(val & mask))
-		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
+		irq_reg_writel(gc, mask, p->reg_off_sticky);
 
 	*ct->mask_cache &= ~mask;
-	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
+	irq_reg_writel(gc, mask, p->reg_off_ena_set);
 	irq_gc_unlock(gc);
 }
 
@@ -43,8 +98,9 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct chip_props *p = d->host_data;
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
-	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(0));
+	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(p, 0));
 
 	chained_irq_enter(chip, desc);
 
@@ -58,8 +114,9 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init ocelot_irq_init(struct device_node *node,
-				  struct device_node *parent)
+static int __init vcoreiii_irq_init(struct device_node *node,
+				    struct device_node *parent,
+				    struct chip_props *p)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
@@ -69,14 +126,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 	if (!parent_irq)
 		return -EINVAL;
 
-	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
+	domain = irq_domain_add_linear(node, p->n_irq,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%pOFn: unable to add irq domain\n", node);
 		return -ENOMEM;
 	}
 
-	ret = irq_alloc_domain_generic_chips(domain, OCELOT_NR_IRQ, 1,
+	ret = irq_alloc_domain_generic_chips(domain, p->n_irq, 1,
 					     "icpu", handle_level_irq,
 					     0, 0, 0);
 	if (ret) {
@@ -92,16 +149,28 @@ static int __init ocelot_irq_init(struct device_node *node,
 		goto err_gc_free;
 	}
 
-	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
-	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
-	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
-	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+	gc->chip_types[0].regs.ack = p->reg_off_sticky;
+	if (p->flags & FLAGS_HAS_TRIGGER) {
+		gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
+		gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+	} else {
+		gc->chip_types[0].regs.enable = p->reg_off_ena_set;
+		gc->chip_types[0].regs.disable = p->reg_off_ena_clr;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+	}
 
 	/* Mask and ack all interrupts */
-	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA);
-	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY);
+	irq_reg_writel(gc, 0, p->reg_off_ena);
+	irq_reg_writel(gc, 0xffffffff, p->reg_off_sticky);
+
+	/* Overall init */
+	if (p->flags & FLAGS_NEED_INIT_ENABLE)
+		irq_reg_writel(gc, BIT(0), p->reg_off_ena_irq0);
 
+	domain->host_data = p;
 	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
 					 domain);
 
@@ -115,4 +184,35 @@ static int __init ocelot_irq_init(struct device_node *node,
 
 	return ret;
 }
+
+static int __init ocelot_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &ocelot_props);
+}
+
 IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
+
+static int __init serval_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &serval_props);
+}
+
+IRQCHIP_DECLARE(serval_icpu, "mscc,serval-icpu-intr", serval_irq_init);
+
+static int __init luton_irq_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &luton_props);
+}
+
+IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
+
+static int __init jaguar2_irq_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &jaguar2_props);
+}
+
+IRQCHIP_DECLARE(jaguar2_icpu, "mscc,jaguar2-icpu-intr", jaguar2_irq_init);
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b2ab8db439d9..532d0ae172d9 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -726,7 +726,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
-	dev_info(dev, "Interrupt Aggregator domain %d created\n", pdev->id);
+	dev_info(dev, "Interrupt Aggregator domain %d created\n", inta->ti_sci_id);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index ac9d6d658e65..fe8fad22bcf9 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -129,7 +129,7 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
  * @virq:	Corresponding Linux virtual IRQ number
  * @hwirq:	Corresponding hwirq for the IRQ within this IRQ domain
  *
- * Returns parent irq if all went well else appropriate error pointer.
+ * Returns intr output irq if all went well else appropriate error pointer.
  */
 static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 					unsigned int virq, u32 hwirq)
@@ -173,7 +173,7 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	if (err)
 		goto err_msg;
 
-	return p_hwirq;
+	return out_irq;
 
 err_msg:
 	irq_domain_free_irqs_parent(domain, virq, 1);
@@ -198,19 +198,19 @@ static int ti_sci_intr_irq_domain_alloc(struct irq_domain *domain,
 	struct irq_fwspec *fwspec = data;
 	unsigned long hwirq;
 	unsigned int flags;
-	int err, p_hwirq;
+	int err, out_irq;
 
 	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &flags);
 	if (err)
 		return err;
 
-	p_hwirq = ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
-	if (p_hwirq < 0)
-		return p_hwirq;
+	out_irq = ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
+	if (out_irq < 0)
+		return out_irq;
 
 	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 				      &ti_sci_intr_irq_chip,
-				      (void *)(uintptr_t)p_hwirq);
+				      (void *)(uintptr_t)out_irq);
 
 	return 0;
 }
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index bd39e9de6ecf..5dc63c20b67e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -159,6 +159,8 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 {
 	int pin_out = d->hwirq;
 	enum pdc_irq_config_bits pdc_type;
+	enum pdc_irq_config_bits old_pdc_type;
+	int ret;
 
 	if (pin_out == GPIO_NO_WAKE_IRQ)
 		return 0;
@@ -187,9 +189,26 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
+	old_pdc_type = pdc_reg_read(IRQ_i_CFG, pin_out);
 	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
 
-	return irq_chip_set_type_parent(d, type);
+	ret = irq_chip_set_type_parent(d, type);
+	if (ret)
+		return ret;
+
+	/*
+	 * When we change types the PDC can give a phantom interrupt.
+	 * Clear it.  Specifically the phantom shows up when reconfiguring
+	 * polarity of interrupt without changing the state of the signal
+	 * but let's be consistent and clear it always.
+	 *
+	 * Doing this works because we have IRQCHIP_SET_TYPE_MASKED so the
+	 * interrupt will be cleared before the rest of the system sees it.
+	 */
+	if (old_pdc_type != pdc_type)
+		irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, false);
+
+	return 0;
 }
 
 static struct irq_chip qcom_pdc_gic_chip = {
diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
index d14214dfc10b..7317e8258b48 100644
--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -7,9 +7,13 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef ARCH_WANTS_NMI_IRQSTAT
+	unsigned int __nmi_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+
 #include <linux/irq.h>
 
 #ifndef ack_bad_irq
diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index e6795f088bdd..1010e74cb8e0 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -22,12 +22,16 @@ struct msi_desc;
 typedef struct msi_alloc_info {
 	struct msi_desc			*desc;
 	irq_hw_number_t			hwirq;
+	unsigned long			flags;
 	union {
 		unsigned long		ul;
 		void			*ptr;
 	} scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
 } msi_alloc_info_t;
 
+/* Device generating MSIs is proxying for another device */
+#define MSI_ALLOC_FLAGS_PROXY_DEVICE	(1UL << 0)
+
 #define GENERIC_MSI_DOMAIN_OPS		1
 
 #endif
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67ac4326..7c9d6a2d7e90 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -32,9 +32,9 @@ static __always_inline void rcu_irq_enter_check_tick(void)
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
 		lockdep_hardirq_enter();		\
+		account_hardirq_enter(current);		\
 	} while (0)
 
 /*
@@ -62,8 +62,8 @@ void irq_enter_rcu(void);
  */
 #define __irq_exit()					\
 	do {						\
+		account_hardirq_exit(current);		\
 		lockdep_hardirq_exit();			\
-		account_irq_exit_time(current);		\
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299eb1f52..870b3251e174 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -352,6 +352,8 @@ extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
 
 extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -387,6 +389,12 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 	return -EINVAL;
 }
 
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5135d4b86cd6..f9bf374f9633 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -307,6 +307,13 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
 
+static inline void irqresource_disabled(struct resource *res, u32 irq)
+{
+	res->start = irq;
+	res->end = irq;
+	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
+}
+
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c54365309e97..c332871d59da 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -647,7 +647,6 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
-extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
@@ -954,21 +953,6 @@ static inline void irq_free_desc(unsigned int irq)
 	irq_free_descs(irq, 1);
 }
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-unsigned int irq_alloc_hwirqs(int cnt, int node);
-static inline unsigned int irq_alloc_hwirq(int node)
-{
-	return irq_alloc_hwirqs(1, node);
-}
-void irq_free_hwirqs(unsigned int from, int cnt);
-static inline void irq_free_hwirq(unsigned int irq)
-{
-	return irq_free_hwirqs(irq, 1);
-}
-int arch_setup_hwirq(unsigned int irq, int node);
-void arch_teardown_hwirq(unsigned int irq);
-#endif
-
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
 void irq_init_desc(unsigned int irq);
 #endif
diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
deleted file mode 100644
index 6e8895cd4d92..000000000000
--- a/include/linux/irq_cpustat.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __irq_cpustat_h
-#define __irq_cpustat_h
-
-/*
- * Contains default mappings for irq_cpustat_t, used by almost every
- * architecture.  Some arch (like s390) have per cpu hardware pages and
- * they define their own mappings for irq_stat.
- *
- * Keith Owens <kaos@ocs.com.au> July 2000.
- */
-
-
-/*
- * Simple wrappers reducing source bloat.  Define all irq_stat fields
- * here, even ones that are arch dependent.  That way we get common
- * definitions instead of differing sets for each arch.
- */
-
-#ifndef __ARCH_IRQ_STAT
-DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
-#endif
-
-/* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
-
-#endif	/* __irq_cpustat_h */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e87109f..5701a8b01726 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -37,8 +37,8 @@
 #include <linux/radix-tree.h>
 
 struct device_node;
+struct fwnode_handle;
 struct irq_domain;
-struct of_device_id;
 struct irq_chip;
 struct irq_data;
 struct cpumask;
@@ -271,6 +271,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data);
 extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
@@ -381,8 +387,6 @@ extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
 extern void irq_domain_associate_many(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
-extern void irq_domain_disassociate(struct irq_domain *domain,
-				    unsigned int irq);
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aada106d..4d75633e6735 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -15,6 +15,7 @@
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-2)
 
+struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
@@ -70,6 +71,11 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
+extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
+					   struct irq_affinity *affd,
+					   unsigned int minvec,
+					   unsigned int maxvec,
+					   int **irqs);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0e149c..7547857516d5 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,31 +77,33 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+#define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
-				 | NMI_MASK))
+#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
- * Are we doing bottom half or hardware interrupt processing?
+ * Macros to retrieve the current execution context:
  *
- * in_irq()       - We're in (hard) IRQ context
+ * in_nmi()		- We're in NMI context
+ * in_hardirq()		- We're in hard IRQ context
+ * in_serving_softirq()	- We're in softirq context
+ * in_task()		- We're in task context
+ */
+#define in_nmi()		(nmi_count())
+#define in_hardirq()		(hardirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+
+/*
+ * The following macros are deprecated and should not be used in new code:
+ * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
- * in_serving_softirq() - We're in softirq context
- * in_nmi()       - We're in NMI context
- * in_task()	  - We're in task context
- *
- * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
- *       should not be used in new code.
  */
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_nmi()		(preempt_count() & NMI_MASK)
-#define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 
 /*
  * The preempt_count offset after preempt_disable();
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca062db3..041d6524d144 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,36 +83,46 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq_enter(struct task_struct *tsk);
-static inline void vtime_account_irq_exit(struct task_struct *tsk)
-{
-	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_kernel(tsk);
-}
+extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq_enter(struct task_struct *tsk) { }
-static inline void vtime_account_irq_exit(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
+static inline void vtime_account_softirq(struct task_struct *tsk) { }
+static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-extern void irqtime_account_irq(struct task_struct *tsk);
+extern void irqtime_account_irq(struct task_struct *tsk, unsigned int offset);
 #else
-static inline void irqtime_account_irq(struct task_struct *tsk) { }
+static inline void irqtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 #endif
 
-static inline void account_irq_enter_time(struct task_struct *tsk)
+static inline void account_softirq_enter(struct task_struct *tsk)
+{
+	vtime_account_irq(tsk, SOFTIRQ_OFFSET);
+	irqtime_account_irq(tsk, SOFTIRQ_OFFSET);
+}
+
+static inline void account_softirq_exit(struct task_struct *tsk)
+{
+	vtime_account_softirq(tsk);
+	irqtime_account_irq(tsk, 0);
+}
+
+static inline void account_hardirq_enter(struct task_struct *tsk)
 {
-	vtime_account_irq_enter(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_irq(tsk, HARDIRQ_OFFSET);
+	irqtime_account_irq(tsk, HARDIRQ_OFFSET);
 }
 
-static inline void account_irq_exit_time(struct task_struct *tsk)
+static inline void account_hardirq_exit(struct task_struct *tsk)
 {
-	vtime_account_irq_exit(tsk);
-	irqtime_account_irq(tsk);
+	vtime_account_hardirq(tsk);
+	irqtime_account_irq(tsk, 0);
 }
 
 #endif /* _LINUX_KERNEL_VTIME_H */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 164a031cfdb6..d79ef2493a28 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -26,11 +26,6 @@ config GENERIC_IRQ_SHOW_LEVEL
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
        bool
 
-# Facility to allocate a hardware interrupt. This is legacy support
-# and should not be used in new code. Use irq domains instead.
-config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-       bool
-
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b9b9618e1aca..6d89e33fe3aa 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -61,7 +61,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 EXPORT_SYMBOL(irq_set_chip);
 
 /**
- *	irq_set_type - set the irq trigger type for an irq
+ *	irq_set_irq_type - set the irq trigger type for an irq
  *	@irq:	irq number
  *	@type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
  */
@@ -944,33 +944,6 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
-/**
- * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
- *				     dev ids
- * @desc:	the interrupt description structure for this irq
- *
- * The biggest difference with the IRQ version is that the interrupt is
- * EOIed early, as the IPI could result in a context switch, and we need to
- * make sure the IPI can fire again. We also assume that the arch code has
- * registered an action. If not, we are positively doomed.
- */
-void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
-	unsigned int irq = irq_desc_get_irq(desc);
-	irqreturn_t res;
-
-	__kstat_incr_irqs_this_cpu(desc);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-
-	trace_irq_handler_entry(irq, action);
-	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-	trace_irq_handler_exit(irq, action, res);
-}
-
 /**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a070a99..a23ac2bbf433 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -269,7 +269,7 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 }
 
 /**
- * __irq_alloc_domain_generic_chip - Allocate generic chips for an irq domain
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
  * @d:			irq domain for which to allocate chips
  * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
  * @num_ct:		Number of irq_chip_type instances associated with this
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..e810eb9906ea 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -810,57 +810,6 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-/**
- * irq_alloc_hwirqs - Allocate an irq descriptor and initialize the hardware
- * @cnt:	number of interrupts to allocate
- * @node:	node on which to allocate
- *
- * Returns an interrupt number > 0 or 0, if the allocation fails.
- */
-unsigned int irq_alloc_hwirqs(int cnt, int node)
-{
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL);
-
-	if (irq < 0)
-		return 0;
-
-	for (i = irq; cnt > 0; i++, cnt--) {
-		if (arch_setup_hwirq(i, node))
-			goto err;
-		irq_clear_status_flags(i, _IRQ_NOREQUEST);
-	}
-	return irq;
-
-err:
-	for (i--; i >= irq; i--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(irq, cnt);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_alloc_hwirqs);
-
-/**
- * irq_free_hwirqs - Free irq descriptor and cleanup the hardware
- * @from:	Free from irq number
- * @cnt:	number of interrupts to free
- *
- */
-void irq_free_hwirqs(unsigned int from, int cnt)
-{
-	int i, j;
-
-	for (i = from, j = cnt; j > 0; i++, j--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(from, cnt);
-}
-EXPORT_SYMBOL_GPL(irq_free_hwirqs);
-#endif
-
 /**
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf8b374b892d..30a78872a5cf 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -350,17 +350,28 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
+{
+	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+					first_irq, first_hwirq, ops, host_data);
+}
+EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 unsigned int first_irq,
+					 irq_hw_number_t first_hwirq,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node_to_fwnode(of_node), first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 
 /**
  * irq_find_matching_fwspec() - Locates a domain for a given fwspec
@@ -485,7 +496,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
 	}
 }
 
-void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
+static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 {
 	struct irq_data *irq_data = irq_get_irq_data(irq);
 	irq_hw_number_t hwirq;
@@ -737,7 +748,7 @@ static void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = np ? &np->fwnode : NULL;
+	fwspec->fwnode = of_node_to_fwnode(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)
@@ -1370,8 +1381,15 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
 					   unsigned int nr_irqs)
 {
-	if (domain->ops->free)
-		domain->ops->free(domain, irq_base, nr_irqs);
+	unsigned int i;
+
+	if (!domain->ops->free)
+		return;
+
+	for (i = 0; i < nr_irqs; i++) {
+		if (irq_domain_get_irq_data(domain, irq_base + i))
+			domain->ops->free(domain, irq_base + i, 1);
+	}
 }
 
 int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006..c826ba4141fe 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -371,6 +371,76 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+/**
+ * irq_update_affinity_desc - Update affinity management for an interrupt
+ * @irq:	The interrupt number to update
+ * @affinity:	Pointer to the affinity descriptor
+ *
+ * This interface can be used to configure the affinity management of
+ * interrupts which have been allocated already.
+ *
+ * There are certain limitations on when it may be used - attempts to use it
+ * for when the kernel is configured for generic IRQ reservation mode (in
+ * config GENERIC_IRQ_RESERVATION_MODE) will fail, as it may conflict with
+ * managed/non-managed interrupt accounting. In addition, attempts to use it on
+ * an interrupt which is already started or which has already been configured
+ * as managed will also fail, as these mean invalid init state or double init.
+ */
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	bool activated;
+	int ret = 0;
+
+	/*
+	 * Supporting this with the reservation scheme used by x86 needs
+	 * some more thought. Fail it for now.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		return -EOPNOTSUPP;
+
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/* Requires the interrupt to be shut down */
+	if (irqd_is_started(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Interrupts which are already managed cannot be modified */
+	if (irqd_affinity_is_managed(&desc->irq_data)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/*
+	 * Deactivate the interrupt. That's required to undo
+	 * anything an earlier activation has established.
+	 */
+	activated = irqd_is_activated(&desc->irq_data);
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+	/* Restore the activation state */
+	if (activated)
+		irq_domain_activate_irq(&desc->irq_data, false);
+
+out_unlock:
+	irq_put_desc_busunlock(desc, flags);
+	return ret;
+}
+
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d2300452..5f611658eeab 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -44,12 +44,13 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 }
 
 /*
- * Called before incrementing preempt_count on {soft,}irq_enter
+ * Called after incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
  */
-void irqtime_account_irq(struct task_struct *curr)
+void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+	unsigned int pc;
 	s64 delta;
 	int cpu;
 
@@ -59,6 +60,7 @@ void irqtime_account_irq(struct task_struct *curr)
 	cpu = smp_processor_id();
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
+	pc = preempt_count() - offset;
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
@@ -66,12 +68,11 @@ void irqtime_account_irq(struct task_struct *curr)
 	 * in that case, so as not to confuse scheduler with a special task
 	 * that do not consume any time, but still wants to run.
 	 */
-	if (hardirq_count())
+	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
+	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
-EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
@@ -418,24 +419,21 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-/*
- * Archs that account the whole time spent in the idle task
- * (outside irq) as idle time can rely on this and just implement
- * vtime_account_kernel() and vtime_account_idle(). Archs that
- * have other meaning of the idle time (s390 only includes the
- * time spent by the CPU when it's in low power mode) must override
- * vtime_account().
- */
-#ifndef __ARCH_HAS_VTIME_ACCOUNT
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
 {
-	if (!in_interrupt() && is_idle_task(tsk))
+	unsigned int pc = preempt_count() - offset;
+
+	if (pc & HARDIRQ_OFFSET) {
+		vtime_account_hardirq(tsk);
+	} else if (pc & SOFTIRQ_OFFSET) {
+		vtime_account_softirq(tsk);
+	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+		   is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
-	else
+	} else {
 		vtime_account_kernel(tsk);
+	}
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-#endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 		    u64 *ut, u64 *st)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 09229ad82209..d5bfd5e661fc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,13 @@ static bool ksoftirqd_running(unsigned long pending)
 		!__kthread_should_park(tsk);
 }
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+DEFINE_PER_CPU(int, hardirqs_enabled);
+DEFINE_PER_CPU(int, hardirq_context);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
+#endif
+
 /*
  * preempt_count and SOFTIRQ_OFFSET usage:
  * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
@@ -102,17 +109,11 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
+#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
+ * This is for softirq.c-internal use, where hardirqs are disabled
+ * legitimately:
  */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-DEFINE_PER_CPU(int, hardirqs_enabled);
-DEFINE_PER_CPU(int, hardirq_context);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
-
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -203,6 +204,50 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void invoke_softirq(void)
+{
+	if (ksoftirqd_running(local_softirq_pending()))
+		return;
+
+	if (!force_irqthreads) {
+#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
+		/*
+		 * We can safely execute softirq on the current stack if
+		 * it is the irq stack, because it should be near empty
+		 * at this stage.
+		 */
+		__do_softirq();
+#else
+		/*
+		 * Otherwise, irq_exit() is called on the task stack that can
+		 * be potentially deep already. So call softirq in its own stack
+		 * to prevent from any overrun.
+		 */
+		do_softirq_own_stack();
+#endif
+	} else {
+		wakeup_softirqd();
+	}
+}
+
+asmlinkage __visible void do_softirq(void)
+{
+	__u32 pending;
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	pending = local_softirq_pending();
+
+	if (pending && !ksoftirqd_running(pending))
+		do_softirq_own_stack();
+
+	local_irq_restore(flags);
+}
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -270,10 +315,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current->flags &= ~PF_MEMALLOC;
 
 	pending = local_softirq_pending();
-	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
 	in_hardirq = lockdep_softirq_start();
+	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
@@ -320,46 +365,24 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		wakeup_softirqd();
 	}
 
+	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	account_irq_exit_time(current);
 	__local_bh_enable(SOFTIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
-asmlinkage __visible void do_softirq(void)
-{
-	__u32 pending;
-	unsigned long flags;
-
-	if (in_interrupt())
-		return;
-
-	local_irq_save(flags);
-
-	pending = local_softirq_pending();
-
-	if (pending && !ksoftirqd_running(pending))
-		do_softirq_own_stack();
-
-	local_irq_restore(flags);
-}
-
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
 void irq_enter_rcu(void)
 {
-	if (is_idle_task(current) && !in_interrupt()) {
-		/*
-		 * Prevent raise_softirq from needlessly waking up ksoftirqd
-		 * here, as softirq will be serviced on return from interrupt.
-		 */
-		local_bh_disable();
+	__irq_enter_raw();
+
+	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
 		tick_irq_enter();
-		_local_bh_enable();
-	}
-	__irq_enter();
+
+	account_hardirq_enter(current);
 }
 
 /**
@@ -371,32 +394,6 @@ void irq_enter(void)
 	irq_enter_rcu();
 }
 
-static inline void invoke_softirq(void)
-{
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
-	if (!force_irqthreads) {
-#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
-		/*
-		 * We can safely execute softirq on the current stack if
-		 * it is the irq stack, because it should be near empty
-		 * at this stage.
-		 */
-		__do_softirq();
-#else
-		/*
-		 * Otherwise, irq_exit() is called on the task stack that can
-		 * be potentially deep already. So call softirq in its own stack
-		 * to prevent from any overrun.
-		 */
-		do_softirq_own_stack();
-#endif
-	} else {
-		wakeup_softirqd();
-	}
-}
-
 static inline void tick_irq_exit(void)
 {
 #ifdef CONFIG_NO_HZ_COMMON
@@ -417,7 +414,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
