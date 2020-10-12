Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7C28B567
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgJLNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:00:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgJLNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:00:29 -0400
Date:   Mon, 12 Oct 2020 12:59:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602507610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qhv2JK3JoCcgU+vg3k7QJEFwwIOIbOCMRX2pkx3p87Q=;
        b=swNvd5Bdg0CAUCgt0mGDFpPhjNl6F6QG8ZKeU3YNisfWc93iyfseCS3+ttxMLIwHacqbxC
        7z5ekbjXF10wmdHs0gfuMkhn+IrZ5/sTp/3Zdk8MNJ0/UkFUN10aJH7CNHtTDyyA8t+jo8
        Kbrwxm3yaofdUYA4Tps2PC6drVo4wRZORQStGCaYlR8fs/1AqQm9NR9SxHncTkXdE+svUk
        FFfpNK1LXodjo3QYqZSZbrDOqAGaZkk7UhfNN4Zc16fKXa07Qzb6DPbFJwaD0ijeKQevYC
        tixSgJz3hK49L/r1olaPy+WXCOkSPT+SvXxAajyml2/6AoAsa3WuOjf0/5xbjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602507610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qhv2JK3JoCcgU+vg3k7QJEFwwIOIbOCMRX2pkx3p87Q=;
        b=3Wzk+ee8EZ1hLSg30E2doNu0Bt6E2JLt/g0kvpKR95OR15ZsgpjPwWzvYjStFQBTvSXrHl
        FnIKz3nyul1WgiDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 5.10-rc1
References: <160250758161.26264.880601562259119308.tglx@nanos>
Message-ID: <160250758282.26264.8240369892923988747.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-10-12

up to:  863bae1fbcfa: Merge tag 'irqchip-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Updates for the interrupt subsystem:

 Core:
    - Allow trimming of interrupt hierarchy to support odd hardware setups
      where only a subset of the interrupts requires the full hierarchy.

    - Allow the retrigger mechanism to follow a hierarchy to simplify
      driver code.

    - Provide a mechanism to force enable wakeup interrrupts on suspend.

    - More infrastructure to handle IPIs in the core code

 Architectures:

    - Convert ARM/ARM64 IPI handling to utilize the interrupt core code.

 Drivers:

    - The usual pile of new interrupt chips (MStar, Actions Owl, TI PRUSS,
      Designware ICTL)

    - ARM(64) IPI related conversions

    - Wakeup support for Qualcom PDC

    - Prevent hierarchy corruption in the NVIDIA Tegra driver

    - The usual small fixes, improvements and cleanups all over the place.

Thanks,

	tglx

------------------>
Alexandru Elisei (2):
      irqchip/gic-v3: Spell out when pseudo-NMIs are enabled
      irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0

Anson Huang (2):
      irqchip/imx-intmux: Use dev_err_probe() to simplify error handling
      irqchip/imx-irqsteer: Use dev_err_probe() to simplify error handling

Cristian Ciocaltea (3):
      dt-bindings: interrupt-controller: Add Actions SIRQ controller binding
      irqchip: Add Actions Semi Owl SIRQ controller
      MAINTAINERS: Add entries for Actions Semi Owl SIRQ controller

David Lechner (1):
      irqchip/irq-pruss-intc: Implement irq_{get, set}_irqchip_state ops

Grzegorz Jaszczyk (1):
      irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS interrupts

Huacai Chen (1):
      irqchip/loongson-htvec: Fix initial interrupt clearing

Jiafei Pan (1):
      softirq: Add debug check to __raise_softirq_irqoff()

Krzysztof Kozlowski (1):
      irqchip/ti-sci: Simplify with dev_err_probe()

Lad Prabhakar (1):
      irqchip: Kconfig: Update description for RENESAS_IRQC config

Marc Zyngier (26):
      genirq: Walk the irq_data hierarchy when resending an interrupt
      irqchip/git-v3-its: Implement irq_retrigger callback for device-triggered LPIs
      genirq: Add fasteoi IPI flow
      genirq: Allow interrupts to be excluded from /proc/interrupts
      arm64: Allow IPIs to be handled as normal interrupts
      ARM: Allow IPIs to be handled as normal interrupts
      irqchip/gic-v3: Describe the SGI range
      irqchip/gic-v3: Configure SGIs as standard interrupts
      irqchip/gic: Refactor SMP configuration
      irqchip/gic: Configure SGIs as standard interrupts
      irqchip/gic-common: Don't enable SGIs by default
      irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
      irqchip/hip04: Configure IPIs as standard interrupts
      irqchip/armada-370-xp: Configure IPIs as standard interrupts
      arm64: Kill __smp_cross_call and co
      arm64: Remove custom IRQ stat accounting
      ARM: Kill __smp_cross_call and co
      ARM: Remove custom IRQ stat accounting
      irqchip/bcm2836: Provide mask/unmask dummy methods for IPIs
      irqchip/gic: Cleanup Franken-GIC handling
      arm: Move ipi_teardown() to a CONFIG_HOTPLUG_CPU section
      ARM: Handle no IPI being registered in show_ipi_list()
      genirq/irqdomain: Allow partial trimming of irq_data hierarchy
      gpio: tegra186: Allow optional irq parent callbacks
      soc/tegra: pmc: Allow optional irq parent callbacks
      soc/tegra: pmc: Don't create fake interrupt hierarchy levels

Mark-PK Tsai (2):
      irqchip/irq-mst: Add MStar interrupt controller support
      dt-bindings: interrupt-controller: Add MStar interrupt controller

Maulik Shah (6):
      pinctrl: qcom: Set IRQCHIP_SET_TYPE_MASKED and IRQCHIP_MASK_ON_SUSPEND flags
      pinctrl: qcom: Use return value from irq_set_wake() call
      genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
      pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
      irqchip/qcom-pdc: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
      irqchip/qcom-pdc: Reset PDC interrupts during init

Suman Anna (3):
      dt-bindings: irqchip: Add PRU-ICSS interrupt controller bindings
      irqchip/irq-pruss-intc: Add logic for handling reserved interrupts
      irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs

Valentin Schneider (2):
      irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
      irqchip/gic-v2, v3: Prevent SW resends entirely

YueHaibing (3):
      irqchip/ti-sci-inta: Fix unsigned comparison to zero
      irqchip/ti-sci-intr: Fix unsigned comparison to zero
      arm64: Fix -Wunused-function warning when !CONFIG_HOTPLUG_CPU

Zhen Lei (4):
      genirq: Add stub for set_handle_irq() when !GENERIC_IRQ_MULTI_HANDLER
      irqchip/dw-apb-ictl: Refactor priot to introducing hierarchical irq domains
      irqchip/dw-apb-ictl: Add primary interrupt controller support
      dt-bindings: dw-apb-ictl: Update binding to describe use as primary interrupt controller


 .../interrupt-controller/actions,owl-sirq.yaml     |  65 ++
 .../interrupt-controller/mstar,mst-intc.yaml       |  64 ++
 .../interrupt-controller/snps,dw-apb-ictl.txt      |  14 +-
 .../interrupt-controller/ti,pruss-intc.yaml        | 158 +++++
 MAINTAINERS                                        |   9 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/include/asm/hardirq.h                     |  17 -
 arch/arm/include/asm/smp.h                         |   5 +-
 arch/arm/kernel/irq.c                              |   1 -
 arch/arm/kernel/smp.c                              | 140 +++--
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/arch_gicv3.h                |   8 +-
 arch/arm64/include/asm/hardirq.h                   |   9 -
 arch/arm64/include/asm/irq_work.h                  |   4 +-
 arch/arm64/include/asm/ptrace.h                    |  14 +-
 arch/arm64/include/asm/smp.h                       |  16 +-
 arch/arm64/kernel/image-vars.h                     |   2 +
 arch/arm64/kernel/irq.c                            |  11 +-
 arch/arm64/kernel/smp.c                            | 129 ++--
 drivers/gpio/gpio-tegra186.c                       |  15 +-
 drivers/irqchip/Kconfig                            |  24 +-
 drivers/irqchip/Makefile                           |   3 +
 drivers/irqchip/irq-armada-370-xp.c                | 262 +++++---
 drivers/irqchip/irq-bcm2836.c                      | 153 ++++-
 drivers/irqchip/irq-dw-apb-ictl.c                  |  81 ++-
 drivers/irqchip/irq-gic-common.c                   |   3 -
 drivers/irqchip/irq-gic-v3-its.c                   |   6 +
 drivers/irqchip/irq-gic-v3.c                       | 184 ++++--
 drivers/irqchip/irq-gic.c                          | 247 ++++----
 drivers/irqchip/irq-hip04.c                        |  89 ++-
 drivers/irqchip/irq-imx-intmux.c                   |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |   9 +-
 drivers/irqchip/irq-loongson-htvec.c               |   4 +-
 drivers/irqchip/irq-mst-intc.c                     | 199 ++++++
 drivers/irqchip/irq-owl-sirq.c                     | 359 +++++++++++
 drivers/irqchip/irq-pruss-intc.c                   | 664 +++++++++++++++++++++
 drivers/irqchip/irq-ti-sci-inta.c                  |  14 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |  14 +-
 drivers/irqchip/qcom-pdc.c                         |  14 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  11 +-
 drivers/soc/tegra/pmc.c                            |  91 ++-
 include/linux/irq.h                                |  60 +-
 include/linux/irqdomain.h                          |   3 +
 kernel/irq/chip.c                                  |  27 +
 kernel/irq/debugfs.c                               |   4 +
 kernel/irq/irqdomain.c                             |  99 ++-
 kernel/irq/pm.c                                    |  34 +-
 kernel/irq/proc.c                                  |   2 +-
 kernel/irq/resend.c                                |  15 +-
 kernel/irq/settings.h                              |   7 +
 kernel/softirq.c                                   |   1 +
 51 files changed, 2762 insertions(+), 613 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
 create mode 100644 drivers/irqchip/irq-mst-intc.c
 create mode 100644 drivers/irqchip/irq-owl-sirq.c
 create mode 100644 drivers/irqchip/irq-pruss-intc.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
new file mode 100644
index 000000000000..5da333c644c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/actions,owl-sirq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl SoCs SIRQ interrupt controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+
+description: |
+  This interrupt controller is found in the Actions Semi Owl SoCs (S500, S700
+  and S900) and provides support for handling up to 3 external interrupt lines.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sirq
+      - actions,s700-sirq
+      - actions,s900-sirq
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the input IRQ number, between 0 and 2, while the second
+      cell is the trigger type as defined in interrupt.txt in this directory.
+
+  'interrupts':
+    description: |
+      Contains the GIC SPI IRQs mapped to the external interrupt lines.
+      They shall be specified sequentially from output 0 to 2.
+    minItems: 3
+    maxItems: 3
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - 'interrupts'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sirq: interrupt-controller@b01b0200 {
+      compatible = "actions,s500-sirq";
+      reg = <0xb01b0200 0x4>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ0 */
+                   <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>, /* SIRQ1 */
+                   <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>; /* SIRQ2 */
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
new file mode 100644
index 000000000000..bbf0f26cd008
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/mstar,mst-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar Interrupt Controller
+
+maintainers:
+  - Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+
+description: |+
+  MStar, SigmaStar and Mediatek TV SoCs contain multiple legacy
+  interrupt controllers that routes interrupts to the GIC.
+
+  The HW block exposes a number of interrupt controllers, each
+  can support up to 64 interrupts.
+
+properties:
+  compatible:
+    const: mstar,mst-intc
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      Use the same format as specified by GIC in arm,gic.yaml.
+
+  reg:
+    maxItems: 1
+
+  mstar,irqs-map-range:
+    description: |
+      The range <start, end> of parent interrupt controller's interrupt
+      lines that are hardwired to mstar interrupt controller.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      minItems: 2
+      maxItems: 2
+
+  mstar,intc-no-eoi:
+    description:
+      Mark this controller has no End Of Interrupt(EOI) implementation.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - mstar,irqs-map-range
+
+additionalProperties: false
+
+examples:
+  - |
+    mst_intc0: interrupt-controller@1f2032d0 {
+      compatible = "mstar,mst-intc";
+      interrupt-controller;
+      #interrupt-cells = <3>;
+      interrupt-parent = <&gic>;
+      reg = <0x1f2032d0 0x30>;
+      mstar,irqs-map-range = <0 63>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
index 086ff08322db..2db59df9408f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
@@ -2,7 +2,8 @@ Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
 
 Synopsys DesignWare provides interrupt controller IP for APB known as
 dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
-APB bus, e.g. Marvell Armada 1500.
+APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
+controller in some SoCs, e.g. Hisilicon SD5203.
 
 Required properties:
 - compatible: shall be "snps,dw-apb-ictl"
@@ -10,6 +11,8 @@ Required properties:
   region starting with ENABLE_LOW register
 - interrupt-controller: identifies the node as an interrupt controller
 - #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
+
+Additional required property when it's used as secondary interrupt controller:
 - interrupts: interrupt reference to primary interrupt controller
 
 The interrupt sources map to the corresponding bits in the interrupt
@@ -21,6 +24,7 @@ registers, i.e.
 - (optional) fast interrupts start at 64.
 
 Example:
+	/* dw_apb_ictl is used as secondary interrupt controller */
 	aic: interrupt-controller@3000 {
 		compatible = "snps,dw-apb-ictl";
 		reg = <0x3000 0xc00>;
@@ -29,3 +33,11 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	/* dw_apb_ictl is used as primary interrupt controller */
+	vic: interrupt-controller@10130000 {
+		compatible = "snps,dw-apb-ictl";
+		reg = <0x10130000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
new file mode 100644
index 000000000000..bbf79d125675
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/ti,pruss-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI PRU-ICSS Local Interrupt Controller
+
+maintainers:
+  - Suman Anna <s-anna@ti.com>
+
+description: |
+  Each PRU-ICSS has a single interrupt controller instance that is common
+  to all the PRU cores. Most interrupt controllers can route 64 input events
+  which are then mapped to 10 possible output interrupts through two levels
+  of mapping. The input events can be triggered by either the PRUs and/or
+  various other PRUSS internal and external peripherals. The first 2 output
+  interrupts (0, 1) are fed exclusively to the internal PRU cores, with the
+  remaining 8 (2 through 9) connected to external interrupt controllers
+  including the MPU and/or other PRUSS instances, DSPs or devices.
+
+  The property "ti,irqs-reserved" is used for denoting the connection
+  differences on the output interrupts 2 through 9. If this property is not
+  defined, it implies that all the PRUSS INTC output interrupts 2 through 9
+  (host_intr0 through host_intr7) are connected exclusively to the Arm interrupt
+  controller.
+
+  The K3 family of SoCs can handle 160 input events that can be mapped to 20
+  different possible output interrupts. The additional output interrupts (10
+  through 19) are connected to new sub-modules within the ICSSG instances.
+
+  This interrupt-controller node should be defined as a child node of the
+  corresponding PRUSS node. The node should be named "interrupt-controller".
+
+properties:
+  compatible:
+    enum:
+      - ti,pruss-intc
+      - ti,icssg-intc
+    description: |
+      Use "ti,pruss-intc" for OMAP-L13x/AM18x/DA850 SoCs,
+                              AM335x family of SoCs,
+                              AM437x family of SoCs,
+                              AM57xx family of SoCs
+                              66AK2G family of SoCs
+      Use "ti,icssg-intc" for K3 AM65x & J721E family of SoCs
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: |
+      All the interrupts generated towards the main host processor in the SoC.
+      A shared interrupt can be skipped if the desired destination and usage is
+      by a different processor/device.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 8
+    items:
+      pattern: host_intr[0-7]
+    description: |
+      Should use one of the above names for each valid host event interrupt
+      connected to Arm interrupt controller, the name should match the
+      corresponding host event interrupt number.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      Client users shall use the PRU System event number (the interrupt source
+      that the client is interested in) [cell 1], PRU channel [cell 2] and PRU
+      host_event (target) [cell 3] as the value of the interrupts property in
+      their node.  The system events can be mapped to some output host
+      interrupts through 2 levels of many-to-one mapping i.e. events to channel
+      mapping and channels to host interrupts so through this property entire
+      mapping is provided.
+
+  ti,irqs-reserved:
+    $ref: /schemas/types.yaml#definitions/uint8
+    description: |
+      Bitmask of host interrupts between 0 and 7 (corresponding to PRUSS INTC
+      output interrupts 2 through 9) that are not connected to the Arm interrupt
+      controller or are shared and used by other devices or processors in the
+      SoC. Define this property when any of 8 interrupts should not be handled
+      by Arm interrupt controller.
+        Eg: - AM437x and 66AK2G SoCs do not have "host_intr5" interrupt
+              connected to MPU
+            - AM65x and J721E SoCs have "host_intr5", "host_intr6" and
+              "host_intr7" interrupts connected to MPU, and other ICSSG
+              instances.
+
+required:
+ - compatible
+ - reg
+ - interrupts
+ - interrupt-names
+ - interrupt-controller
+ - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    /* AM33xx PRU-ICSS */
+    pruss: pruss@0 {
+        compatible = "ti,am3356-pruss";
+        reg = <0x0 0x80000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        pruss_intc: interrupt-controller@20000 {
+            compatible = "ti,pruss-intc";
+            reg = <0x20000 0x2000>;
+            interrupts = <20 21 22 23 24 25 26 27>;
+            interrupt-names = "host_intr0", "host_intr1",
+                              "host_intr2", "host_intr3",
+                              "host_intr4", "host_intr5",
+                              "host_intr6", "host_intr7";
+            interrupt-controller;
+            #interrupt-cells = <3>;
+        };
+    };
+
+  - |
+
+    /* AM4376 PRU-ICSS */
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pruss@0 {
+        compatible = "ti,am4376-pruss";
+        reg = <0x0 0x40000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        interrupt-controller@20000 {
+            compatible = "ti,pruss-intc";
+            reg = <0x20000 0x2000>;
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "host_intr0", "host_intr1",
+                              "host_intr2", "host_intr3",
+                              "host_intr4",
+                              "host_intr6", "host_intr7";
+            ti,irqs-reserved = /bits/ 8 <0x20>; /* BIT(5) */
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..28a83c9956a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -1536,6 +1537,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/irqchip/irq-owl-sirq.c
 F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
@@ -11779,6 +11781,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/msi2500/
 
+MSTAR INTERRUPT CONTROLLER DRIVER
+M:	Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+M:	Daniel Palmer <daniel@thingy.jp>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
+F:	drivers/irqchip/irq-mst-intc.c
+
 MSYSTEMS DISKONCHIP G3 MTD DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-mtd@lists.infradead.org
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b16658..e67ef15c800f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,6 +49,7 @@ config ARM
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_IRQ_IPI if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 7a88f160b1fb..b95848ed2bc7 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,29 +6,12 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-#ifdef CONFIG_SMP
-	unsigned int ipi_irqs[NR_IPI];
-#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-#ifdef CONFIG_SMP
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#else
-#define smp_irq_stat_cpu(cpu)	0
-#endif
-
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index a91f21e3c5b5..0ca55a607d0a 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -39,11 +39,10 @@ void handle_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-
 /*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
+ * Register IPI interrupts with the arch SMP code
  */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
 
 /*
  * Called from platform specific assembly code, this is the
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ee514034c0a1..698b6f636156 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -18,7 +18,6 @@
  *  IRQ's are in fact implemented a bit like signal handlers for the kernel.
  *  Naturally it's not a 1:1 relation, but there are similarities.
  */
-#include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5d9da61eff62..48099c6e1e4a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/kernel_stat.h>
 
 #include <linux/atomic.h>
 #include <asm/bugs.h>
@@ -65,18 +66,26 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	NR_IPI,
 	/*
 	 * CPU_BACKTRACE is special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
 	 */
-	IPI_CPU_BACKTRACE,
+	IPI_CPU_BACKTRACE = NR_IPI,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
 	 * not be usable by the kernel. Please keep the above limited
 	 * to at most 8 entries.
 	 */
+	MAX_IPI
 };
 
+static int ipi_irq_base __read_mostly;
+static int nr_ipi __read_mostly = NR_IPI;
+static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
+
+static void ipi_setup(int cpu);
+
 static DECLARE_COMPLETION(cpu_running);
 
 static struct smp_operations smp_ops __ro_after_init;
@@ -226,6 +235,17 @@ int platform_can_hotplug_cpu(unsigned int cpu)
 	return cpu != 0;
 }
 
+static void ipi_teardown(int cpu)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!ipi_irq_base))
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_irq_base + i);
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -247,6 +267,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -422,6 +443,8 @@ asmlinkage void secondary_start_kernel(void)
 
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	calibrate_delay();
 
 	smp_store_cpu_info(cpu);
@@ -500,14 +523,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	if (!__smp_cross_call)
-		__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_WAKEUP, "CPU wakeup interrupts"),
@@ -519,38 +534,28 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_COMPLETION, "completion interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq;
+
+		if (!ipi_desc[i])
+			continue;
+
+		irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
 }
 
-u64 smp_irq_stat_cpu(unsigned int cpu)
-{
-	u64 sum = 0;
-	int i;
-
-	for (i = 0; i < NR_IPI; i++)
-		sum += __get_irq_stat(cpu, ipi_irqs[i]);
-
-	return sum;
-}
-
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
@@ -627,15 +632,12 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 	handle_IPI(ipinr, regs);
 }
 
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
@@ -643,9 +645,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
@@ -654,36 +654,26 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		ipi_cpu_stop(cpu);
-		irq_exit();
 		break;
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
 	case IPI_COMPLETION:
-		irq_enter();
 		ipi_complete(cpu);
-		irq_exit();
 		break;
 
 	case IPI_CPU_BACKTRACE:
 		printk_nmi_enter();
-		irq_enter();
-		nmi_cpu_backtrace(regs);
-		irq_exit();
+		nmi_cpu_backtrace(get_irq_regs());
 		printk_nmi_exit();
 		break;
 
@@ -695,9 +685,67 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+}
+
+/* Legacy version, should go away once all irqchips have been converted */
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	do_handle_IPI(ipinr);
+	irq_exit();
+
 	set_irq_regs(old_regs);
 }
 
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	do_handle_IPI(irq - ipi_irq_base);
+	return IRQ_HANDLED;
+}
+
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
+}
+
+static void ipi_setup(int cpu)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!ipi_irq_base))
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_irq_base + i, 0);
+}
+
+void __init set_smp_ipi_range(int ipi_base, int n)
+{
+	int i;
+
+	WARN_ON(n < MAX_IPI);
+	nr_ipi = min(n, MAX_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &irq_stat);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+	}
+
+	ipi_irq_base = ipi_base;
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
@@ -805,7 +853,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..d0fdbe5fb32f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -106,6 +106,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 6647ae4f0231..880b9054d75c 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -153,7 +153,7 @@ static inline bool gic_prio_masking_enabled(void)
 
 static inline void gic_pmr_mask_irqs(void)
 {
-	BUILD_BUG_ON(GICD_INT_DEF_PRI < (GIC_PRIO_IRQOFF |
+	BUILD_BUG_ON(GICD_INT_DEF_PRI < (__GIC_PRIO_IRQOFF |
 					 GIC_PRIO_PSR_I_SET));
 	BUILD_BUG_ON(GICD_INT_DEF_PRI >= GIC_PRIO_IRQON);
 	/*
@@ -162,6 +162,12 @@ static inline void gic_pmr_mask_irqs(void)
 	 * are applied to IRQ priorities
 	 */
 	BUILD_BUG_ON((0x80 | (GICD_INT_DEF_PRI >> 1)) >= GIC_PRIO_IRQON);
+	/*
+	 * Same situation as above, but now we make sure that we can mask
+	 * regular interrupts.
+	 */
+	BUILD_BUG_ON((0x80 | (GICD_INT_DEF_PRI >> 1)) < (__GIC_PRIO_IRQOFF_NS |
+							 GIC_PRIO_PSR_I_SET));
 	gic_write_pmr(GIC_PRIO_IRQOFF);
 }
 
diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 985493af704b..5ffa4bacdad3 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,21 +13,12 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int ipi_irqs[NR_IPI];
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 struct nmi_ctx {
diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index 8a1ef1907760..a1020285ea75 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,11 +2,9 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-#include <asm/smp.h>
-
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return !!__smp_cross_call;
+	return true;
 }
 
 #endif /* __ASM_IRQ_WORK_H */
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 966ed30ed5f7..997cf8c8cd52 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -31,9 +31,21 @@
  * interrupt disabling temporarily does not rely on IRQ priorities.
  */
 #define GIC_PRIO_IRQON			0xe0
-#define GIC_PRIO_IRQOFF			(GIC_PRIO_IRQON & ~0x80)
+#define __GIC_PRIO_IRQOFF		(GIC_PRIO_IRQON & ~0x80)
+#define __GIC_PRIO_IRQOFF_NS		0xa0
 #define GIC_PRIO_PSR_I_SET		(1 << 4)
 
+#define GIC_PRIO_IRQOFF							\
+	({								\
+		extern struct static_key_false gic_nonsecure_priorities;\
+		u8 __prio = __GIC_PRIO_IRQOFF;				\
+									\
+		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
+			__prio = __GIC_PRIO_IRQOFF_NS;			\
+									\
+		__prio;							\
+	})
+
 /* Additional SPSR bits not exposed in the UABI */
 #define PSR_MODE_THREAD_BIT	(1 << 0)
 #define PSR_IL_BIT		(1 << 20)
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 0eadbf933e35..2e7f529ec5a6 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -55,16 +55,6 @@ static inline void set_cpu_logical_map(int cpu, u64 hwid)
 
 struct seq_file;
 
-/*
- * generate IPI list text
- */
-extern void show_ipi_list(struct seq_file *p, int prec);
-
-/*
- * Called from C code, this handles an IPI.
- */
-extern void handle_IPI(int ipinr, struct pt_regs *regs);
-
 /*
  * Discover the set of possible CPUs and determine their
  * SMP operations.
@@ -72,11 +62,9 @@ extern void handle_IPI(int ipinr, struct pt_regs *regs);
 extern void smp_init_cpus(void);
 
 /*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
+ * Register IPI interrupts with the arch SMP code
  */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
-extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
 
 /*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8982b68289b7..98a5215c1598 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -101,6 +101,8 @@ KVM_NVHE_ALIAS(vgic_v3_cpuif_trap);
 /* Static key checked in pmr_sync(). */
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 KVM_NVHE_ALIAS(gic_pmr_sync);
+/* Static key checked in GIC_PRIO_IRQOFF. */
+KVM_NVHE_ALIAS(gic_nonsecure_priorities);
 #endif
 
 /* EL2 exception handling */
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 04a327ccf84d..9cf2fb87584a 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -10,10 +10,10 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/memory.h>
 #include <linux/smp.h>
+#include <linux/hardirq.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/kprobes.h>
@@ -22,20 +22,11 @@
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
 
-unsigned long irq_err_count;
-
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-int arch_show_interrupts(struct seq_file *p, int prec)
-{
-	show_ipi_list(p, prec);
-	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
-	return 0;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 355ee9eed4dd..82e75fc2c903 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -30,6 +30,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
 
@@ -72,10 +73,18 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	NR_IPI
 };
 
+static int ipi_irq_base __read_mostly;
+static int nr_ipi __read_mostly = NR_IPI;
+static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+
+static void ipi_setup(int cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
+static void ipi_teardown(int cpu);
 static int op_cpu_kill(unsigned int cpu);
 #else
 static inline int op_cpu_kill(unsigned int cpu)
@@ -237,6 +246,8 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
@@ -302,6 +313,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -772,13 +784,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
@@ -790,35 +795,25 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
-void show_ipi_list(struct seq_file *p, int prec)
+unsigned long irq_err_count;
+
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
-}
-
-u64 smp_irq_stat_cpu(unsigned int cpu)
-{
-	u64 sum = 0;
-	int i;
 
-	for (i = 0; i < NR_IPI; i++)
-		sum += __get_irq_stat(cpu, ipi_irqs[i]);
-
-	return sum;
+	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
+	return 0;
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -841,8 +836,7 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
-	if (__smp_cross_call)
-		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
 
@@ -890,15 +884,12 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 /*
  * Main handler for inter-processor interrupts
  */
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -906,21 +897,16 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		local_cpu_stop();
-		irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
-			irq_enter();
-			ipi_cpu_crash_stop(cpu, regs);
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
 
 			unreachable();
 		}
@@ -928,17 +914,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
@@ -957,7 +939,66 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
-	set_irq_regs(old_regs);
+}
+
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	do_handle_IPI(irq - ipi_irq_base);
+	return IRQ_HANDLED;
+}
+
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
+}
+
+static void ipi_setup(int cpu)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!ipi_irq_base))
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_irq_base + i, 0);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void ipi_teardown(int cpu)
+{
+	int i;
+
+	if (WARN_ON_ONCE(!ipi_irq_base))
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_irq_base + i);
+}
+#endif
+
+void __init set_smp_ipi_range(int ipi_base, int n)
+{
+	int i;
+
+	WARN_ON(n < NR_IPI);
+	nr_ipi = min(n, NR_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &cpu_number);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+	}
+
+	ipi_irq_base = ipi_base;
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
 }
 
 void smp_send_reschedule(int cpu)
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 178e9128ded0..9500074b1f1b 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -430,7 +430,18 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_edge_irq);
 
-	return irq_chip_set_type_parent(data, type);
+	if (data->parent_data)
+		return irq_chip_set_type_parent(data, type);
+
+	return 0;
+}
+
+static int tegra186_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	if (data->parent_data)
+		return irq_chip_set_wake_parent(data, on);
+
+	return 0;
 }
 
 static void tegra186_gpio_irq(struct irq_desc *desc)
@@ -678,7 +689,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->intc.irq_mask = tegra186_irq_mask;
 	gpio->intc.irq_unmask = tegra186_irq_unmask;
 	gpio->intc.irq_set_type = tegra186_irq_set_type;
-	gpio->intc.irq_set_wake = irq_chip_set_wake_parent;
+	gpio->intc.irq_set_wake = tegra186_irq_set_wake;
 
 	irq = &gpio->gpio.irq;
 	irq->chip = &gpio->intc;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..570a7706875c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -148,7 +148,7 @@ config DAVINCI_CP_INTC
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 
 config FARADAY_FTINTC010
 	bool
@@ -232,12 +232,12 @@ config RENESAS_INTC_IRQPIN
 	  interrupt pins, as found on SH/R-Mobile and R-Car Gen1 SoCs.
 
 config RENESAS_IRQC
-	bool "Renesas R-Mobile APE6 and R-Car IRQC support" if COMPILE_TEST
+	bool "Renesas R-Mobile APE6, R-Car Gen{2,3} and RZ/G{1,2} IRQC support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
 	  Enable support for the Renesas Interrupt Controller for external
-	  devices, as found on R-Mobile APE6, R-Car Gen2, and R-Car Gen3 SoCs.
+	  devices, as found on R-Mobile APE6, R-Car Gen{2,3} and RZ/G{1,2} SoCs.
 
 config RENESAS_RZA1_IRQC
 	bool "Renesas RZ/A1 IRQC support" if COMPILE_TEST
@@ -493,6 +493,16 @@ config TI_SCI_INTA_IRQCHIP
 	  If you wish to use interrupt aggregator irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
+config TI_PRUSS_INTC
+	tristate "TI PRU-ICSS Interrupt Controller"
+	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
+	select IRQ_DOMAIN
+	help
+	  This enables support for the PRU-ICSS Local Interrupt Controller
+	  present within a PRU-ICSS subsystem present on various TI SoCs.
+	  The PRUSS INTC enables various interrupts to be routed to multiple
+	  different processors within the SoC.
+
 config RISCV_INTC
 	bool "RISC-V Local Interrupt Controller"
 	depends on RISCV
@@ -571,4 +581,12 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config MST_IRQ
+	bool "MStar Interrupt Controller"
+	default ARCH_MEDIATEK
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support MStar Interrupt Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c45744a..f1525149b7a2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
@@ -106,8 +107,10 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
+obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c9bdc5221b82..d7eb2e93db8f 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -310,7 +310,134 @@ static inline int armada_370_xp_msi_init(struct device_node *node,
 }
 #endif
 
+static void armada_xp_mpic_perf_init(void)
+{
+	unsigned long cpuid = cpu_logical_map(smp_processor_id());
+
+	/* Enable Performance Counter Overflow interrupts */
+	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+}
+
 #ifdef CONFIG_SMP
+static struct irq_domain *ipi_domain;
+
+static void armada_370_xp_ipi_mask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg &= ~BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_unmask(struct irq_data *d)
+{
+	u32 reg;
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg |= BIT(d->hwirq);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+}
+
+static void armada_370_xp_ipi_send_mask(struct irq_data *d,
+					const struct cpumask *mask)
+{
+	unsigned long map = 0;
+	int cpu;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* submit softirq */
+	writel((map << 8) | d->hwirq, main_int_base +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+}
+
+static void armada_370_xp_ipi_eoi(struct irq_data *d)
+{
+	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+}
+
+static struct irq_chip ipi_irqchip = {
+	.name		= "IPI",
+	.irq_mask	= armada_370_xp_ipi_mask,
+	.irq_unmask	= armada_370_xp_ipi_unmask,
+	.irq_eoi	= armada_370_xp_ipi_eoi,
+	.ipi_send_mask	= armada_370_xp_ipi_send_mask,
+};
+
+static int armada_370_xp_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void armada_370_xp_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= armada_370_xp_ipi_alloc,
+	.free	= armada_370_xp_ipi_free,
+};
+
+static void ipi_resume(void)
+{
+	int i;
+
+	for (i = 0; i < IPI_DOORBELL_END; i++) {
+		int irq;
+
+		irq = irq_find_mapping(ipi_domain, i);
+		if (irq <= 0)
+			continue;
+		if (irq_percpu_is_enabled(irq)) {
+			struct irq_data *d;
+			d = irq_domain_get_irq_data(ipi_domain, irq);
+			armada_370_xp_ipi_unmask(d);
+		}
+	}
+}
+
+static __init void armada_xp_ipi_init(struct device_node *node)
+{
+	int base_ipi;
+
+	ipi_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+					      IPI_DOORBELL_END,
+					      &ipi_domain_ops, NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, IPI_DOORBELL_END,
+					   NUMA_NO_NODE, NULL, false, NULL);
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+}
+
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 static int armada_xp_set_affinity(struct irq_data *d,
@@ -334,43 +461,6 @@ static int armada_xp_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
-#endif
-
-static struct irq_chip armada_370_xp_irq_chip = {
-	.name		= "MPIC",
-	.irq_mask       = armada_370_xp_irq_mask,
-	.irq_mask_ack   = armada_370_xp_irq_mask,
-	.irq_unmask     = armada_370_xp_irq_unmask,
-#ifdef CONFIG_SMP
-	.irq_set_affinity = armada_xp_set_affinity,
-#endif
-	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
-};
-
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
-{
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (!is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
-	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
-	irq_set_status_flags(virq, IRQ_LEVEL);
-
-	if (is_percpu_irq(hw)) {
-		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_percpu_devid_irq);
-	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_level_irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
-	}
-	irq_set_probe(virq);
-
-	return 0;
-}
 
 static void armada_xp_mpic_smp_cpu_init(void)
 {
@@ -383,48 +473,16 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (i = 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
 
+	/* Disable all IPIs */
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
-	/* Enable first 8 IPIs */
-	writel(IPI_DOORBELL_MASK, per_cpu_int_base +
-		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
 	/* Unmask IPI interrupt */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
-static void armada_xp_mpic_perf_init(void)
-{
-	unsigned long cpuid = cpu_logical_map(smp_processor_id());
-
-	/* Enable Performance Counter Overflow interrupts */
-	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
-}
-
-#ifdef CONFIG_SMP
-static void armada_mpic_send_doorbell(const struct cpumask *mask,
-				      unsigned int irq)
-{
-	int cpu;
-	unsigned long map = 0;
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= 1 << cpu_logical_map(cpu);
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
-	 */
-	dsb();
-
-	/* submit softirq */
-	writel((map << 8) | irq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
-}
-
 static void armada_xp_mpic_reenable_percpu(void)
 {
 	unsigned int irq;
@@ -445,6 +503,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 
 		armada_370_xp_irq_unmask(data);
 	}
+
+	ipi_resume();
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
@@ -462,7 +522,46 @@ static int mpic_cascaded_starting_cpu(unsigned int cpu)
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
 	return 0;
 }
+#else
+static void armada_xp_mpic_smp_cpu_init(void) {}
+static void ipi_resume(void) {}
+#endif
+
+static struct irq_chip armada_370_xp_irq_chip = {
+	.name		= "MPIC",
+	.irq_mask       = armada_370_xp_irq_mask,
+	.irq_mask_ack   = armada_370_xp_irq_mask,
+	.irq_unmask     = armada_370_xp_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = armada_xp_set_affinity,
 #endif
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
+				      unsigned int virq, irq_hw_number_t hw)
+{
+	armada_370_xp_irq_mask(irq_get_irq_data(virq));
+	if (!is_percpu_irq(hw))
+		writel(hw, per_cpu_int_base +
+			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	else
+		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+	irq_set_status_flags(virq, IRQ_LEVEL);
+
+	if (is_percpu_irq(hw)) {
+		irq_set_percpu_devid(virq);
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_percpu_devid_irq);
+	} else {
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
+					handle_level_irq);
+		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
+	}
+	irq_set_probe(virq);
+
+	return 0;
+}
 
 static const struct irq_domain_ops armada_370_xp_mpic_irq_ops = {
 	.map = armada_370_xp_mpic_irq_map,
@@ -562,22 +661,15 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 		/* IPI Handling */
 		if (irqnr == 0) {
-			u32 ipimask, ipinr;
+			unsigned long ipimask;
+			int ipi;
 
 			ipimask = readl_relaxed(per_cpu_int_base +
 						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
 				& IPI_DOORBELL_MASK;
 
-			writel(~ipimask, per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
-
-			/* Handle all pending doorbells */
-			for (ipinr = IPI_DOORBELL_START;
-			     ipinr < IPI_DOORBELL_END; ipinr++) {
-				if (ipimask & (0x1 << ipinr))
-					handle_IPI(ipinr, regs);
-			}
-			continue;
+			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
+				handle_domain_irq(ipi_domain, ipi, regs);
 		}
 #endif
 
@@ -636,6 +728,8 @@ static void armada_370_xp_mpic_resume(void)
 		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 	if (doorbell_mask_reg & PCI_MSI_DOORBELL_MASK)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+
+	ipi_resume();
 }
 
 static struct syscore_ops armada_370_xp_mpic_syscore_ops = {
@@ -691,7 +785,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		irq_set_default_host(armada_370_xp_mpic_domain);
 		set_handle_irq(armada_370_xp_handle_irq);
 #ifdef CONFIG_SMP
-		set_smp_cross_call(armada_mpic_send_doorbell);
+		armada_xp_ipi_init(node);
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
 					  armada_xp_mpic_starting_cpu, NULL);
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 2038693f074c..97838eb705f9 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -10,6 +10,7 @@
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-bcm2836.h>
 
 #include <asm/exception.h>
@@ -89,12 +90,24 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
 };
 
+static void bcm2836_arm_irqchip_dummy_op(struct irq_data *d)
+{
+}
+
+static struct irq_chip bcm2836_arm_irqchip_dummy = {
+	.name		= "bcm2836-dummy",
+	.irq_eoi	= bcm2836_arm_irqchip_dummy_op,
+};
+
 static int bcm2836_map(struct irq_domain *d, unsigned int irq,
 		       irq_hw_number_t hw)
 {
 	struct irq_chip *chip;
 
 	switch (hw) {
+	case LOCAL_IRQ_MAILBOX0:
+		chip = &bcm2836_arm_irqchip_dummy;
+		break;
 	case LOCAL_IRQ_CNTPSIRQ:
 	case LOCAL_IRQ_CNTPNSIRQ:
 	case LOCAL_IRQ_CNTHPIRQ:
@@ -127,17 +140,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 	u32 stat;
 
 	stat = readl_relaxed(intc.base + LOCAL_IRQ_PENDING0 + 4 * cpu);
-	if (stat & BIT(LOCAL_IRQ_MAILBOX0)) {
-#ifdef CONFIG_SMP
-		void __iomem *mailbox0 = (intc.base +
-					  LOCAL_MAILBOX0_CLR0 + 16 * cpu);
-		u32 mbox_val = readl(mailbox0);
-		u32 ipi = ffs(mbox_val) - 1;
-
-		writel(1 << ipi, mailbox0);
-		handle_IPI(ipi, regs);
-#endif
-	} else if (stat) {
+	if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
 		handle_domain_irq(intc.domain, hwirq, regs);
@@ -145,8 +148,35 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
-					 unsigned int ipi)
+static struct irq_domain *ipi_domain;
+
+static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int cpu = smp_processor_id();
+	u32 mbox_val;
+
+	chained_irq_enter(chip, desc);
+
+	mbox_val = readl_relaxed(intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+	if (mbox_val) {
+		int hwirq = ffs(mbox_val) - 1;
+		generic_handle_irq(irq_find_mapping(ipi_domain, hwirq));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
+{
+	int cpu = smp_processor_id();
+
+	writel_relaxed(BIT(d->hwirq),
+		       intc.base + LOCAL_MAILBOX0_CLR0 + 16 * cpu);
+}
+
+static void bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
+					      const struct cpumask *mask)
 {
 	int cpu;
 	void __iomem *mailbox0_base = intc.base + LOCAL_MAILBOX0_SET0;
@@ -157,11 +187,47 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
 	 */
 	smp_wmb();
 
-	for_each_cpu(cpu, mask)	{
-		writel(1 << ipi, mailbox0_base + 16 * cpu);
+	for_each_cpu(cpu, mask)
+		writel_relaxed(BIT(d->hwirq), mailbox0_base + 16 * cpu);
+}
+
+static struct irq_chip bcm2836_arm_irqchip_ipi = {
+	.name		= "IPI",
+	.irq_mask	= bcm2836_arm_irqchip_dummy_op,
+	.irq_unmask	= bcm2836_arm_irqchip_dummy_op,
+	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
+	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
+};
+
+static int bcm2836_arm_irqchip_ipi_alloc(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *args)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_percpu_devid(virq + i);
+		irq_domain_set_info(d, virq + i, i, &bcm2836_arm_irqchip_ipi,
+				    d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
 	}
+
+	return 0;
 }
 
+static void bcm2836_arm_irqchip_ipi_free(struct irq_domain *d,
+					 unsigned int virq,
+					 unsigned int nr_irqs)
+{
+	/* Not freeing IPIs */
+}
+
+static const struct irq_domain_ops ipi_domain_ops = {
+	.alloc	= bcm2836_arm_irqchip_ipi_alloc,
+	.free	= bcm2836_arm_irqchip_ipi_free,
+};
+
 static int bcm2836_cpu_starting(unsigned int cpu)
 {
 	bcm2836_arm_irqchip_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0,
@@ -175,25 +241,58 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 					     cpu);
 	return 0;
 }
-#endif
 
-static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
-	.xlate = irq_domain_xlate_onetwocell,
-	.map = bcm2836_map,
-};
+#define BITS_PER_MBOX	32
 
-static void
-bcm2836_arm_irqchip_smp_init(void)
+static void bcm2836_arm_irqchip_smp_init(void)
 {
-#ifdef CONFIG_SMP
+	struct irq_fwspec ipi_fwspec = {
+		.fwnode		= intc.domain->fwnode,
+		.param_count	= 1,
+		.param		= {
+			[0]	= LOCAL_IRQ_MAILBOX0,
+		},
+	};
+	int base_ipi, mux_irq;
+
+	mux_irq = irq_create_fwspec_mapping(&ipi_fwspec);
+	if (WARN_ON(mux_irq <= 0))
+		return;
+
+	ipi_domain = irq_domain_create_linear(intc.domain->fwnode,
+					      BITS_PER_MBOX, &ipi_domain_ops,
+					      NULL);
+	if (WARN_ON(!ipi_domain))
+		return;
+
+	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
+	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
+
+	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, BITS_PER_MBOX,
+					   NUMA_NO_NODE, NULL,
+					   false, NULL);
+
+	if (WARN_ON(!base_ipi))
+		return;
+
+	set_smp_ipi_range(base_ipi, BITS_PER_MBOX);
+
+	irq_set_chained_handler_and_data(mux_irq,
+					 bcm2836_arm_irqchip_handle_ipi, NULL);
+
 	/* Unmask IPIs to the boot CPU. */
 	cpuhp_setup_state(CPUHP_AP_IRQ_BCM2836_STARTING,
 			  "irqchip/bcm2836:starting", bcm2836_cpu_starting,
 			  bcm2836_cpu_dying);
-
-	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
-#endif
 }
+#else
+#define bcm2836_arm_irqchip_smp_init()	do { } while(0)
+#endif
+
+static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
+	.xlate = irq_domain_xlate_onetwocell,
+	.map = bcm2836_map,
+};
 
 /*
  * The LOCAL_IRQ_CNT* timer firings are based off of the external
@@ -232,6 +331,8 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
+	irq_domain_update_bus_token(intc.domain, DOMAIN_BUS_WIRED);
+
 	bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index e4550e9c810b..54b09d6c407c 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/interrupt.h>
 
 #define APB_INT_ENABLE_L	0x00
 #define APB_INT_ENABLE_H	0x04
@@ -26,7 +27,28 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
-static void dw_apb_ictl_handler(struct irq_desc *desc)
+/* irq domain of the primary interrupt controller. */
+static struct irq_domain *dw_apb_ictl_irq_domain;
+
+static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
+{
+	struct irq_domain *d = dw_apb_ictl_irq_domain;
+	int n;
+
+	for (n = 0; n < d->revmap_size; n += 32) {
+		struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, n);
+		u32 stat = readl_relaxed(gc->reg_base + APB_INT_FINALSTATUS_L);
+
+		while (stat) {
+			u32 hwirq = ffs(stat) - 1;
+
+			handle_domain_irq(d, hwirq, regs);
+			stat &= ~BIT(hwirq);
+		}
+	}
+}
+
+static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -43,13 +65,37 @@ static void dw_apb_ictl_handler(struct irq_desc *desc)
 			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
 
 			generic_handle_irq(virq);
-			stat &= ~(1 << hwirq);
+			stat &= ~BIT(hwirq);
 		}
 	}
 
 	chained_irq_exit(chip, desc);
 }
 
+static int dw_apb_ictl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops dw_apb_ictl_irq_domain_ops = {
+	.translate = irq_domain_translate_onecell,
+	.alloc = dw_apb_ictl_irq_domain_alloc,
+	.free = irq_domain_free_irqs_top,
+};
+
 #ifdef CONFIG_PM
 static void dw_apb_ictl_resume(struct irq_data *d)
 {
@@ -68,19 +114,27 @@ static void dw_apb_ictl_resume(struct irq_data *d)
 static int __init dw_apb_ictl_init(struct device_node *np,
 				   struct device_node *parent)
 {
+	const struct irq_domain_ops *domain_ops;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct resource r;
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
 	void __iomem *iobase;
-	int ret, nrirqs, irq, i;
+	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
-	/* Map the parent interrupt for the chained handler */
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
-		pr_err("%pOF: unable to parse irq\n", np);
-		return -EINVAL;
+	if (!parent) {
+		/* Used as the primary interrupt controller */
+		parent_irq = 0;
+		domain_ops = &dw_apb_ictl_irq_domain_ops;
+	} else {
+		/* Map the parent interrupt for the chained handler */
+		parent_irq = irq_of_parse_and_map(np, 0);
+		if (parent_irq <= 0) {
+			pr_err("%pOF: unable to parse irq\n", np);
+			return -EINVAL;
+		}
+		domain_ops = &irq_generic_chip_ops;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -120,8 +174,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	else
 		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
 
-	domain = irq_domain_add_linear(np, nrirqs,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_add_linear(np, nrirqs, domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: unable to add irq domain\n", np);
 		ret = -ENOMEM;
@@ -146,7 +199,13 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
 	}
 
-	irq_set_chained_handler_and_data(irq, dw_apb_ictl_handler, domain);
+	if (parent_irq) {
+		irq_set_chained_handler_and_data(parent_irq,
+				dw_apb_ictl_handle_irq_cascaded, domain);
+	} else {
+		dw_apb_ictl_irq_domain = domain;
+		set_handle_irq(dw_apb_ictl_handle_irq);
+	}
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 82520006195d..f47b41dfd023 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -152,9 +152,6 @@ void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
 
-	/* Ensure all SGI interrupts are now enabled */
-	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
-
 	if (sync_access)
 		sync_access();
 }
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 548de7538632..0418071a3724 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1720,6 +1720,11 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_irq_retrigger(struct irq_data *d)
+{
+	return !its_irq_set_irqchip_state(d, IRQCHIP_STATE_PENDING, true);
+}
+
 /*
  * Two favourable cases:
  *
@@ -1971,6 +1976,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
+	.irq_retrigger		= its_irq_retrigger,
 	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 850842f27bee..16fecc0febe8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -36,6 +36,8 @@
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
 
+#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -75,16 +77,14 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  *
  * If SCR_EL3.FIQ == 1, the values writen to/read from PMR and RPR at non-secure
  * EL1 are subject to a similar operation thus matching the priorities presented
- * from the (re)distributor when security is enabled.
+ * from the (re)distributor when security is enabled. When SCR_EL3.FIQ == 0,
+ * these values are unchanched by the GIC.
  *
  * see GICv3/GICv4 Architecture Specification (IHI0069D):
  * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
  *   priorities.
  * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
  *   interrupt.
- *
- * For now, we only support pseudo-NMIs if we have non-secure view of
- * priorities.
  */
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
@@ -97,6 +97,9 @@ static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 DEFINE_STATIC_KEY_FALSE(gic_pmr_sync);
 EXPORT_SYMBOL(gic_pmr_sync);
 
+DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
+EXPORT_SYMBOL(gic_nonsecure_priorities);
+
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
 
@@ -112,6 +115,7 @@ static DEFINE_PER_CPU(bool, has_rss);
 #define DEFAULT_PMR_VALUE	0xf0
 
 enum gic_intid_range {
+	SGI_RANGE,
 	PPI_RANGE,
 	SPI_RANGE,
 	EPPI_RANGE,
@@ -123,6 +127,8 @@ enum gic_intid_range {
 static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
 {
 	switch (hwirq) {
+	case 0 ... 15:
+		return SGI_RANGE;
 	case 16 ... 31:
 		return PPI_RANGE;
 	case 32 ... 1019:
@@ -148,15 +154,22 @@ static inline unsigned int gic_irq(struct irq_data *d)
 	return d->hwirq;
 }
 
-static inline int gic_irq_in_rdist(struct irq_data *d)
+static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
-	enum gic_intid_range range = get_intid_range(d);
-	return range == PPI_RANGE || range == EPPI_RANGE;
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		/* SGI+PPI -> SGI_base for this CPU */
@@ -253,6 +266,7 @@ static void gic_enable_redist(bool enable)
 static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case SPI_RANGE:
 		*index = d->hwirq;
@@ -372,7 +386,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 {
 	u32 reg;
 
-	if (d->hwirq >= 8192) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* SGI/PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -539,12 +553,12 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	u32 offset, index;
 	int ret;
 
-	/* Interrupt configuration for SGIs can't be changed */
-	if (irq < 16)
-		return -EINVAL;
-
 	range = get_intid_range(d);
 
+	/* Interrupt configuration for SGIs can't be changed */
+	if (range == SGI_RANGE)
+		return type != IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
+
 	/* SPIs have restrictions on the supported types */
 	if ((range == SPI_RANGE || range == ESPI_RANGE) &&
 	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
@@ -572,6 +586,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
+	if (get_intid_range(d) == SGI_RANGE)
+		return -EINVAL;
+
 	if (vcpu)
 		irqd_set_forwarded_to_vcpu(d);
 	else
@@ -646,38 +663,14 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	if ((irqnr >= 1020 && irqnr <= 1023))
 		return;
 
-	/* Treat anything but SGIs in a uniform way */
-	if (likely(irqnr > 15)) {
-		int err;
-
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_eoir(irqnr);
-		else
-			isb();
-
-		err = handle_domain_irq(gic_data.domain, irqnr, regs);
-		if (err) {
-			WARN_ONCE(true, "Unexpected interrupt received!\n");
-			gic_deactivate_unhandled(irqnr);
-		}
-		return;
-	}
-	if (irqnr < 16) {
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
-		if (static_branch_likely(&supports_deactivate_key))
-			gic_write_dir(irqnr);
-#ifdef CONFIG_SMP
-		/*
-		 * Unlike GICv2, we don't need an smp_rmb() here.
-		 * The control dependency from gic_read_iar to
-		 * the ISB in gic_write_eoir is enough to ensure
-		 * that any shared data read by handle_IPI will
-		 * be read after the ACK.
-		 */
-		handle_IPI(irqnr, regs);
-#else
-		WARN_ONCE(true, "Unexpected SGI received!\n");
-#endif
+	else
+		isb();
+
+	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
+		WARN_ONCE(true, "Unexpected interrupt received!\n");
+		gic_deactivate_unhandled(irqnr);
 	}
 }
 
@@ -932,14 +925,20 @@ static void gic_cpu_sys_reg_init(void)
 	/* Set priority mask register */
 	if (!gic_prio_masking_enabled()) {
 		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
-	} else {
+	} else if (gic_supports_nmi()) {
 		/*
 		 * Mismatch configuration with boot CPU, the system is likely
 		 * to die as interrupt masking will not work properly on all
 		 * CPUs
+		 *
+		 * The boot CPU calls this function before enabling NMI support,
+		 * and as a result we'll never see this warning in the boot path
+		 * for that CPU.
 		 */
-		WARN_ON(gic_supports_nmi() && group0 &&
-			!gic_dist_security_disabled());
+		if (static_branch_unlikely(&gic_nonsecure_priorities))
+			WARN_ON(!group0 || gic_dist_security_disabled());
+		else
+			WARN_ON(group0 && !gic_dist_security_disabled());
 	}
 
 	/*
@@ -1125,11 +1124,11 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
 	gic_write_sgi1r(val);
 }
 
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 
-	if (WARN_ON(irq >= 16))
+	if (WARN_ON(d->hwirq >= 16))
 		return;
 
 	/*
@@ -1143,7 +1142,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
-		gic_send_sgi(cluster_id, tlist, irq);
+		gic_send_sgi(cluster_id, tlist, d->hwirq);
 	}
 
 	/* Force the above writes to ICC_SGI1R_EL1 to be executed */
@@ -1152,10 +1151,24 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 static void __init gic_smp_init(void)
 {
-	set_smp_cross_call(gic_raise_softirq);
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data.fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
+
+	/* Register all 8 non-secure SGIs */
+	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
 }
 
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
@@ -1204,9 +1217,15 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #else
 #define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 #ifdef CONFIG_CPU_PM
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
@@ -1242,10 +1261,12 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1258,11 +1279,13 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
 	.irq_nmi_teardown	= gic_irq_nmi_teardown,
+	.ipi_send_mask		= gic_ipi_send_mask,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
 				  IRQCHIP_MASK_ON_SUSPEND,
@@ -1272,11 +1295,19 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &gic_chip;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
 
 	switch (__get_intid_range(hw)) {
+	case SGI_RANGE:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
@@ -1289,7 +1320,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 		break;
 
 	case LPI_RANGE:
@@ -1303,16 +1334,22 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	}
 
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
+	if (fwspec->param_count == 1 && fwspec->param[0] < 16) {
+		*hwirq = fwspec->param[0];
+		*type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
+
 	if (is_of_node(fwspec->fwnode)) {
 		if (fwspec->param_count < 3)
 			return -EINVAL;
@@ -1544,11 +1581,6 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
-	if (gic_has_group0() && !gic_dist_security_disabled()) {
-		pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
-		return;
-	}
-
 	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
@@ -1564,8 +1596,38 @@ static void gic_enable_nmi_support(void)
 	if (gic_read_ctlr() & ICC_CTLR_EL1_PMHE_MASK)
 		static_branch_enable(&gic_pmr_sync);
 
-	pr_info("%s ICC_PMR_EL1 synchronisation\n",
-		static_branch_unlikely(&gic_pmr_sync) ? "Forcing" : "Relaxing");
+	pr_info("Pseudo-NMIs enabled using %s ICC_PMR_EL1 synchronisation\n",
+		static_branch_unlikely(&gic_pmr_sync) ? "forced" : "relaxed");
+
+	/*
+	 * How priority values are used by the GIC depends on two things:
+	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
+	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
+	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
+	 * the ICC_PMR_EL1 register and the priority that software assigns to
+	 * interrupts:
+	 *
+	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Group 1 priority
+	 * -----------------------------------------------------------
+	 *      1       |      -      |  unchanged  |    unchanged
+	 * -----------------------------------------------------------
+	 *      0       |      1      |  non-secure |    non-secure
+	 * -----------------------------------------------------------
+	 *      0       |      0      |  unchanged  |    non-secure
+	 *
+	 * where non-secure means that the value is right-shifted by one and the
+	 * MSB bit set, to make it fit in the non-secure priority range.
+	 *
+	 * In the first two cases, where ICC_PMR_EL1 and the interrupt priority
+	 * are both either modified or unchanged, we can use the same set of
+	 * priorities.
+	 *
+	 * In the last case, where only the interrupt priorities are modified to
+	 * be in the non-secure range, we use a different PMR value to mask IRQs
+	 * and the rest of the values that we use remain unchanged.
+	 */
+	if (gic_has_group0() && !gic_dist_security_disabled())
+		static_branch_enable(&gic_nonsecure_priorities);
 
 	static_branch_enable(&supports_pseudo_nmis);
 
@@ -1644,9 +1706,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_rdist_properties();
 
-	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
+	gic_smp_init();
 	gic_cpu_pm_init();
 
 	if (gic_dist_supports_lpis()) {
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a27ba2cc1dce..6053245a4754 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -83,9 +83,6 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
 };
 
 #ifdef CONFIG_BL_SWITCHER
@@ -124,36 +121,30 @@ static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
 
 static struct gic_kvm_info gic_v2_kvm_info;
 
+static DEFINE_PER_CPU(u32, sgi_intid);
+
 #ifdef CONFIG_GIC_NON_BANKED
-static void __iomem *gic_get_percpu_base(union gic_base *base)
-{
-	return raw_cpu_read(*base->percpu_base);
-}
+static DEFINE_STATIC_KEY_FALSE(frankengic_key);
 
-static void __iomem *gic_get_common_base(union gic_base *base)
+static void enable_frankengic(void)
 {
-	return base->common_base;
+	static_branch_enable(&frankengic_key);
 }
 
-static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
+static inline void __iomem *__get_base(union gic_base *base)
 {
-	return data->get_base(&data->dist_base);
-}
+	if (static_branch_unlikely(&frankengic_key))
+		return raw_cpu_read(*base->percpu_base);
 
-static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
-{
-	return data->get_base(&data->cpu_base);
+	return base->common_base;
 }
 
-static inline void gic_set_base_accessor(struct gic_chip_data *data,
-					 void __iomem *(*f)(union gic_base *))
-{
-	data->get_base = f;
-}
+#define gic_data_dist_base(d)	__get_base(&(d)->dist_base)
+#define gic_data_cpu_base(d)	__get_base(&(d)->cpu_base)
 #else
 #define gic_data_dist_base(d)	((d)->dist_base.common_base)
 #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
-#define gic_set_base_accessor(d, f)
+#define enable_frankengic()	do { } while(0)
 #endif
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
@@ -226,16 +217,26 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	u32 hwirq = gic_irq(d);
+
+	if (hwirq < 16)
+		hwirq = this_cpu_read(sgi_intid);
+
+	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
+	u32 hwirq = gic_irq(d);
+
 	/* Do not deactivate an IRQ forwarded to a vcpu. */
 	if (irqd_is_forwarded_to_vcpu(d))
 		return;
 
-	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
+	if (hwirq < 16)
+		hwirq = this_cpu_read(sgi_intid);
+
+	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
 }
 
 static int gic_irq_set_irqchip_state(struct irq_data *d,
@@ -295,7 +296,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
-		return -EINVAL;
+		return type != IRQ_TYPE_EDGE_RISING ? -EINVAL : 0;
 
 	/* SPIs have restrictions on the supported types */
 	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
@@ -315,7 +316,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
 	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
-	if (cascading_gic_irq(d))
+	if (cascading_gic_irq(d) || gic_irq(d) < 16)
 		return -EINVAL;
 
 	if (vcpu)
@@ -325,27 +326,10 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
-			    bool force)
+static int gic_retrigger(struct irq_data *data)
 {
-	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
-	unsigned int cpu;
-
-	if (!force)
-		cpu = cpumask_any_and(mask_val, cpu_online_mask);
-	else
-		cpu = cpumask_first(mask_val);
-
-	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
-		return -EINVAL;
-
-	writeb_relaxed(gic_cpu_map[cpu], reg);
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
-
-	return IRQ_SET_MASK_OK_DONE;
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
 }
-#endif
 
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
@@ -357,31 +341,33 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr < 1020)) {
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			isb();
-			handle_domain_irq(gic->domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
+		if (unlikely(irqnr >= 1020))
+			break;
+
+		if (static_branch_likely(&supports_deactivate_key))
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			if (static_branch_likely(&supports_deactivate_key))
-				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
-#ifdef CONFIG_SMP
+		isb();
+
+		/*
+		 * Ensure any shared data written by the CPU sending the IPI
+		 * is read after we've read the ACK register on the GIC.
+		 *
+		 * Pairs with the write barrier in gic_ipi_send_mask
+		 */
+		if (irqnr <= 15) {
+			smp_rmb();
+
 			/*
-			 * Ensure any shared data written by the CPU sending
-			 * the IPI is read after we've read the ACK register
-			 * on the GIC.
-			 *
-			 * Pairs with the write barrier in gic_raise_softirq
+			 * The GIC encodes the source CPU in GICC_IAR,
+			 * leading to the deactivation to fail if not
+			 * written back as is to GICC_EOI.  Stash the INTID
+			 * away for gic_eoi_irq() to write back.  This only
+			 * works because we don't nest SGIs...
 			 */
-			smp_rmb();
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
+			this_cpu_write(sgi_intid, irqstat);
 		}
-		break;
+
+		handle_domain_irq(gic->domain, irqnr, regs);
 	} while (1);
 }
 
@@ -417,6 +403,7 @@ static const struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
@@ -728,11 +715,6 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 	int i;
 
 	for (i = 0; i < CONFIG_ARM_GIC_MAX_NR; i++) {
-#ifdef CONFIG_GIC_NON_BANKED
-		/* Skip over unused GICs */
-		if (!gic_data[i].get_base)
-			continue;
-#endif
 		switch (cmd) {
 		case CPU_PM_ENTER:
 			gic_cpu_save(&gic_data[i]);
@@ -795,14 +777,34 @@ static int gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
-static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+			    bool force)
+{
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	writeb_relaxed(gic_cpu_map[cpu], reg);
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 {
 	int cpu;
 	unsigned long flags, map = 0;
 
 	if (unlikely(nr_cpu_ids == 1)) {
 		/* Only one CPU? let's do a self-IPI... */
-		writel_relaxed(2 << 24 | irq,
+		writel_relaxed(2 << 24 | d->hwirq,
 			       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 		return;
 	}
@@ -820,10 +822,41 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	dmb(ishst);
 
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | d->hwirq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
 	gic_unlock_irqrestore(flags);
 }
+
+static int gic_starting_cpu(unsigned int cpu)
+{
+	gic_cpu_init(&gic_data[0]);
+	return 0;
+}
+
+static __init void gic_smp_init(void)
+{
+	struct irq_fwspec sgi_fwspec = {
+		.fwnode		= gic_data[0].domain->fwnode,
+		.param_count	= 1,
+	};
+	int base_sgi;
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
+				  "irqchip/arm/gic:starting",
+				  gic_starting_cpu, NULL);
+
+	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
+					   NUMA_NO_NODE, &sgi_fwspec,
+					   false, NULL);
+	if (WARN_ON(base_sgi <= 0))
+		return;
+
+	set_smp_ipi_range(base_sgi, 8);
+}
+#else
+#define gic_smp_init()		do { } while(0)
+#define gic_set_affinity	NULL
+#define gic_ipi_send_mask	NULL
 #endif
 
 #ifdef CONFIG_BL_SWITCHER
@@ -969,17 +1002,30 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
 	struct gic_chip_data *gic = d->host_data;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
-	if (hw < 32) {
+	switch (hw) {
+	case 0 ... 15:
+		irq_set_percpu_devid(irq);
+		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+				    handle_percpu_devid_fasteoi_ipi,
+				    NULL, NULL);
+		break;
+	case 16 ... 31:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-	} else {
+		break;
+	default:
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
+		break;
 	}
+
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
@@ -992,19 +1038,26 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 				    unsigned long *hwirq,
 				    unsigned int *type)
 {
+	if (fwspec->param_count == 1 && fwspec->param[0] < 16) {
+		*hwirq = fwspec->param[0];
+		*type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
+
 	if (is_of_node(fwspec->fwnode)) {
 		if (fwspec->param_count < 3)
 			return -EINVAL;
 
-		/* Get the interrupt number and add 16 to skip over SGIs */
-		*hwirq = fwspec->param[1] + 16;
-
-		/*
-		 * For SPIs, we need to add 16 more to get the GIC irq
-		 * ID number
-		 */
-		if (!fwspec->param[0])
-			*hwirq += 16;
+		switch (fwspec->param[0]) {
+		case 0:			/* SPI */
+			*hwirq = fwspec->param[1] + 32;
+			break;
+		case 1:			/* PPI */
+			*hwirq = fwspec->param[1] + 16;
+			break;
+		default:
+			return -EINVAL;
+		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
@@ -1027,12 +1080,6 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
 
-static int gic_starting_cpu(unsigned int cpu)
-{
-	gic_cpu_init(&gic_data[0]);
-	return 0;
-}
-
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
@@ -1079,10 +1126,10 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 		gic->chip.irq_set_vcpu_affinity = gic_irq_set_vcpu_affinity;
 	}
 
-#ifdef CONFIG_SMP
-	if (gic == &gic_data[0])
+	if (gic == &gic_data[0]) {
 		gic->chip.irq_set_affinity = gic_set_affinity;
-#endif
+		gic->chip.ipi_send_mask = gic_ipi_send_mask;
+	}
 }
 
 static int gic_init_bases(struct gic_chip_data *gic,
@@ -1112,7 +1159,7 @@ static int gic_init_bases(struct gic_chip_data *gic,
 				gic->raw_cpu_base + offset;
 		}
 
-		gic_set_base_accessor(gic, gic_get_percpu_base);
+		enable_frankengic();
 	} else {
 		/* Normal, sane GIC... */
 		WARN(gic->percpu_offset,
@@ -1120,7 +1167,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		     gic->percpu_offset);
 		gic->dist_base.common_base = gic->raw_dist_base;
 		gic->cpu_base.common_base = gic->raw_cpu_base;
-		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
 	/*
@@ -1199,12 +1245,7 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 		 */
 		for (i = 0; i < NR_GIC_CPU_IF; i++)
 			gic_cpu_map[i] = 0xff;
-#ifdef CONFIG_SMP
-		set_smp_cross_call(gic_raise_softirq);
-#endif
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
-					  "irqchip/arm/gic:starting",
-					  gic_starting_cpu, NULL);
+
 		set_handle_irq(gic_handle_irq);
 		if (static_branch_likely(&supports_deactivate_key))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
@@ -1221,6 +1262,8 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 	ret = gic_init_bases(gic, handle);
 	if (ret)
 		kfree(name);
+	else if (gic == &gic_data[0])
+		gic_smp_init();
 
 	return ret;
 }
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 130caa1c9d93..9b73dcfaf48d 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -171,6 +171,29 @@ static int hip04_irq_set_affinity(struct irq_data *d,
 
 	return IRQ_SET_MASK_OK;
 }
+
+static void hip04_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	int cpu;
+	unsigned long flags, map = 0;
+
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= hip04_cpu_map[cpu];
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before they observe us issuing the IPI.
+	 */
+	dmb(ishst);
+
+	/* this always happens on GIC0 */
+	writel_relaxed(map << 8 | d->hwirq, hip04_data.dist_base + GIC_DIST_SOFTINT);
+
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+}
 #endif
 
 static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
@@ -182,19 +205,9 @@ static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr <= HIP04_MAX_IRQS)) {
+		if (irqnr <= HIP04_MAX_IRQS)
 			handle_domain_irq(hip04_data.domain, irqnr, regs);
-			continue;
-		}
-		if (irqnr < 16) {
-			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-#ifdef CONFIG_SMP
-			handle_IPI(irqnr, regs);
-#endif
-			continue;
-		}
-		break;
-	} while (1);
+	} while (irqnr > HIP04_MAX_IRQS);
 }
 
 static struct irq_chip hip04_irq_chip = {
@@ -205,6 +218,7 @@ static struct irq_chip hip04_irq_chip = {
 	.irq_set_type		= hip04_irq_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= hip04_irq_set_affinity,
+	.ipi_send_mask		= hip04_ipi_send_mask,
 #endif
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
 				  IRQCHIP_SKIP_SET_WAKE |
@@ -279,39 +293,17 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 	writel_relaxed(1, base + GIC_CPU_CTRL);
 }
 
-#ifdef CONFIG_SMP
-static void hip04_raise_softirq(const struct cpumask *mask, unsigned int irq)
-{
-	int cpu;
-	unsigned long flags, map = 0;
-
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= hip04_cpu_map[cpu];
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before they observe us issuing the IPI.
-	 */
-	dmb(ishst);
-
-	/* this always happens on GIC0 */
-	writel_relaxed(map << 8 | irq, hip04_data.dist_base + GIC_DIST_SOFTINT);
-
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
-}
-#endif
-
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 32) {
+	if (hw < 16) {
+		irq_set_percpu_devid(irq);
+		irq_set_chip_and_handler(irq, &hip04_irq_chip,
+					 handle_percpu_devid_fasteoi_ipi);
+	} else if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
-		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_fasteoi_irq);
@@ -328,10 +320,13 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 				  unsigned long *out_hwirq,
 				  unsigned int *out_type)
 {
-	unsigned long ret = 0;
-
 	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
+	if (intsize == 1 && intspec[0] < 16) {
+		*out_hwirq = intspec[0];
+		*out_type = IRQ_TYPE_EDGE_RISING;
+		return 0;
+	}
 	if (intsize < 3)
 		return -EINVAL;
 
@@ -344,7 +339,7 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
 
-	return ret;
+	return 0;
 }
 
 static int hip04_irq_starting_cpu(unsigned int cpu)
@@ -361,7 +356,6 @@ static const struct irq_domain_ops hip04_irq_domain_ops = {
 static int __init
 hip04_of_init(struct device_node *node, struct device_node *parent)
 {
-	irq_hw_number_t hwirq_base = 16;
 	int nr_irqs, irq_base, i;
 
 	if (WARN_ON(!node))
@@ -390,24 +384,21 @@ hip04_of_init(struct device_node *node, struct device_node *parent)
 		nr_irqs = HIP04_MAX_IRQS;
 	hip04_data.nr_irqs = nr_irqs;
 
-	nr_irqs -= hwirq_base; /* calculate # of irqs to allocate */
-
-	irq_base = irq_alloc_descs(-1, hwirq_base, nr_irqs, numa_node_id());
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, numa_node_id());
 	if (irq_base < 0) {
 		pr_err("failed to allocate IRQ numbers\n");
 		return -EINVAL;
 	}
 
 	hip04_data.domain = irq_domain_add_legacy(node, nr_irqs, irq_base,
-						  hwirq_base,
+						  0,
 						  &hip04_irq_domain_ops,
 						  &hip04_data);
-
 	if (WARN_ON(!hip04_data.domain))
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	set_smp_cross_call(hip04_raise_softirq);
+	set_smp_ipi_range(irq_base, 16);
 #endif
 	set_handle_irq(hip04_handle_irq);
 
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e35b7b09c3ab..7709f9712cb3 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -226,12 +226,9 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(data->ipg_clk)) {
-		ret = PTR_ERR(data->ipg_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
+				     "failed to get ipg clk\n");
 
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 290531ec3d61..1edf7692a790 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -158,12 +158,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	}
 
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(data->ipg_clk)) {
-		ret = PTR_ERR(data->ipg_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
+				     "failed to get ipg clk\n");
 
 	raw_spin_lock_init(&data->lock);
 
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 13e6016fe464..6392aafb9a63 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -151,7 +151,7 @@ static void htvec_reset(struct htvec *priv)
 	/* Clear IRQ cause registers, mask all interrupts */
 	for (idx = 0; idx < priv->num_parents; idx++) {
 		writel_relaxed(0x0, priv->base + HTVEC_EN_OFF + 4 * idx);
-		writel_relaxed(0xFFFFFFFF, priv->base);
+		writel_relaxed(0xFFFFFFFF, priv->base + 4 * idx);
 	}
 }
 
@@ -172,7 +172,7 @@ static int htvec_of_init(struct device_node *node,
 		goto free_priv;
 	}
 
-	/* Interrupt may come from any of the 4 interrupt line */
+	/* Interrupt may come from any of the 8 interrupt lines */
 	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
 		parent_irq[i] = irq_of_parse_and_map(node, i);
 		if (parent_irq[i] <= 0)
diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
new file mode 100644
index 000000000000..4be077591898
--- /dev/null
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define INTC_MASK	0x0
+#define INTC_EOI	0x20
+
+struct mst_intc_chip_data {
+	raw_spinlock_t	lock;
+	unsigned int	irq_start, nr_irqs;
+	void __iomem	*base;
+	bool		no_eoi;
+};
+
+static void mst_set_irq(struct irq_data *d, u32 offset)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+	u16 val, mask;
+	unsigned long flags;
+
+	mask = 1 << (hwirq % 16);
+	offset += (hwirq / 16) * 4;
+
+	raw_spin_lock_irqsave(&cd->lock, flags);
+	val = readw_relaxed(cd->base + offset) | mask;
+	writew_relaxed(val, cd->base + offset);
+	raw_spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void mst_clear_irq(struct irq_data *d, u32 offset)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+	u16 val, mask;
+	unsigned long flags;
+
+	mask = 1 << (hwirq % 16);
+	offset += (hwirq / 16) * 4;
+
+	raw_spin_lock_irqsave(&cd->lock, flags);
+	val = readw_relaxed(cd->base + offset) & ~mask;
+	writew_relaxed(val, cd->base + offset);
+	raw_spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void mst_intc_mask_irq(struct irq_data *d)
+{
+	mst_set_irq(d, INTC_MASK);
+	irq_chip_mask_parent(d);
+}
+
+static void mst_intc_unmask_irq(struct irq_data *d)
+{
+	mst_clear_irq(d, INTC_MASK);
+	irq_chip_unmask_parent(d);
+}
+
+static void mst_intc_eoi_irq(struct irq_data *d)
+{
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+
+	if (!cd->no_eoi)
+		mst_set_irq(d, INTC_EOI);
+
+	irq_chip_eoi_parent(d);
+}
+
+static struct irq_chip mst_intc_chip = {
+	.name			= "mst-intc",
+	.irq_mask		= mst_intc_mask_irq,
+	.irq_unmask		= mst_intc_unmask_irq,
+	.irq_eoi		= mst_intc_eoi_irq,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int mst_intc_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct mst_intc_chip_data *cd = d->host_data;
+
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
+
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		if (fwspec->param[1] >= cd->nr_irqs)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	int i;
+	irq_hw_number_t hwirq;
+	struct irq_fwspec parent_fwspec, *fwspec = data;
+	struct mst_intc_chip_data *cd = domain->host_data;
+
+	/* Not GIC compliant */
+	if (fwspec->param_count != 3)
+		return -EINVAL;
+
+	/* No PPI should point to this domain */
+	if (fwspec->param[0])
+		return -EINVAL;
+
+	hwirq = fwspec->param[1];
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &mst_intc_chip,
+					      domain->host_data);
+
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param[1] = cd->irq_start + hwirq;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
+}
+
+static const struct irq_domain_ops mst_intc_domain_ops = {
+	.translate	= mst_intc_domain_translate,
+	.alloc		= mst_intc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+int __init
+mst_intc_of_init(struct device_node *dn, struct device_node *parent)
+{
+	struct irq_domain *domain, *domain_parent;
+	struct mst_intc_chip_data *cd;
+	u32 irq_start, irq_end;
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("mst-intc: interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(dn, "mstar,irqs-map-range", 0, &irq_start) ||
+	    of_property_read_u32_index(dn, "mstar,irqs-map-range", 1, &irq_end))
+		return -EINVAL;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->base = of_iomap(dn, 0);
+	if (!cd->base) {
+		kfree(cd);
+		return -ENOMEM;
+	}
+
+	cd->no_eoi = of_property_read_bool(dn, "mstar,intc-no-eoi");
+	raw_spin_lock_init(&cd->lock);
+	cd->irq_start = irq_start;
+	cd->nr_irqs = irq_end - irq_start + 1;
+	domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs, dn,
+					  &mst_intc_domain_ops, cd);
+	if (!domain) {
+		iounmap(cd->base);
+		kfree(cd);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
new file mode 100644
index 000000000000..6e4127465094
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi Owl SoCs SIRQ interrupt controller driver
+ *
+ * Copyright (C) 2014 Actions Semi Inc.
+ * David Liu <liuwei@actions-semi.com>
+ *
+ * Author: Parthiban Nallathambi <pn@denx.de>
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ * Author: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define NUM_SIRQ			3
+
+#define INTC_EXTCTL_PENDING		BIT(0)
+#define INTC_EXTCTL_CLK_SEL		BIT(4)
+#define INTC_EXTCTL_EN			BIT(5)
+#define INTC_EXTCTL_TYPE_MASK		GENMASK(7, 6)
+#define INTC_EXTCTL_TYPE_HIGH		0
+#define INTC_EXTCTL_TYPE_LOW		BIT(6)
+#define INTC_EXTCTL_TYPE_RISING		BIT(7)
+#define INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
+
+/* S500 & S700 SIRQ control register masks */
+#define INTC_EXTCTL_SIRQ0_MASK		GENMASK(23, 16)
+#define INTC_EXTCTL_SIRQ1_MASK		GENMASK(15, 8)
+#define INTC_EXTCTL_SIRQ2_MASK		GENMASK(7, 0)
+
+/* S900 SIRQ control register offsets, relative to controller base address */
+#define INTC_EXTCTL0			0x0000
+#define INTC_EXTCTL1			0x0328
+#define INTC_EXTCTL2			0x032c
+
+struct owl_sirq_params {
+	/* INTC_EXTCTL reg shared for all three SIRQ lines */
+	bool reg_shared;
+	/* INTC_EXTCTL reg offsets relative to controller base address */
+	u16 reg_offset[NUM_SIRQ];
+};
+
+struct owl_sirq_chip_data {
+	const struct owl_sirq_params	*params;
+	void __iomem			*base;
+	raw_spinlock_t			lock;
+	u32				ext_irqs[NUM_SIRQ];
+};
+
+/* S500 & S700 SoCs */
+static const struct owl_sirq_params owl_sirq_s500_params = {
+	.reg_shared = true,
+	.reg_offset = { 0, 0, 0 },
+};
+
+/* S900 SoC */
+static const struct owl_sirq_params owl_sirq_s900_params = {
+	.reg_shared = false,
+	.reg_offset = { INTC_EXTCTL0, INTC_EXTCTL1, INTC_EXTCTL2 },
+};
+
+static u32 owl_field_get(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_GET(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_GET(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_GET(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_field_prep(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32 index)
+{
+	u32 val;
+
+	val = readl_relaxed(data->base + data->params->reg_offset[index]);
+	if (data->params->reg_shared)
+		val = owl_field_get(val, index);
+
+	return val;
+}
+
+static void owl_sirq_write_extctl(struct owl_sirq_chip_data *data,
+				  u32 extctl, u32 index)
+{
+	u32 val;
+
+	if (data->params->reg_shared) {
+		val = readl_relaxed(data->base + data->params->reg_offset[index]);
+		val &= ~owl_field_prep(0xff, index);
+		extctl = owl_field_prep(extctl, index) | val;
+	}
+
+	writel_relaxed(extctl, data->base + data->params->reg_offset[index]);
+}
+
+static void owl_sirq_clear_set_extctl(struct owl_sirq_chip_data *d,
+				      u32 clear, u32 set, u32 index)
+{
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&d->lock, flags);
+	val = owl_sirq_read_extctl(d, index);
+	val &= ~clear;
+	val |= set;
+	owl_sirq_write_extctl(d, val, index);
+	raw_spin_unlock_irqrestore(&d->lock, flags);
+}
+
+static void owl_sirq_eoi(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	/*
+	 * Software must clear external interrupt pending, when interrupt type
+	 * is edge triggered, so we need per SIRQ based clearing.
+	 */
+	if (!irqd_is_level_type(data))
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_PENDING,
+					  data->hwirq);
+
+	irq_chip_eoi_parent(data);
+}
+
+static void owl_sirq_mask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_EN, 0, data->hwirq);
+	irq_chip_mask_parent(data);
+}
+
+static void owl_sirq_unmask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_EN, data->hwirq);
+	irq_chip_unmask_parent(data);
+}
+
+/*
+ * GIC does not handle falling edge or active low, hence SIRQ shall be
+ * programmed to convert falling edge to rising edge signal and active
+ * low to active high signal.
+ */
+static int owl_sirq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+	u32 sirq_type;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sirq_type = INTC_EXTCTL_TYPE_LOW;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sirq_type = INTC_EXTCTL_TYPE_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		sirq_type = INTC_EXTCTL_TYPE_FALLING;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		sirq_type = INTC_EXTCTL_TYPE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_TYPE_MASK, sirq_type,
+				  data->hwirq);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip owl_sirq_chip = {
+	.name		= "owl-sirq",
+	.irq_mask	= owl_sirq_mask,
+	.irq_unmask	= owl_sirq_unmask,
+	.irq_eoi	= owl_sirq_eoi,
+	.irq_set_type	= owl_sirq_set_type,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+#endif
+};
+
+static int owl_sirq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= NUM_SIRQ)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int owl_sirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct owl_sirq_chip_data *chip_data = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = owl_sirq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &owl_sirq_chip,
+				      chip_data);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = GIC_SPI;
+	parent_fwspec.param[1] = chip_data->ext_irqs[hwirq];
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static const struct irq_domain_ops owl_sirq_domain_ops = {
+	.translate	= owl_sirq_domain_translate,
+	.alloc		= owl_sirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init owl_sirq_init(const struct owl_sirq_params *params,
+				struct device_node *node,
+				struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct owl_sirq_chip_data *chip_data;
+	int ret, i;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: failed to find sirq parent domain\n", node);
+		return -ENXIO;
+	}
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&chip_data->lock);
+
+	chip_data->params = params;
+
+	chip_data->base = of_iomap(node, 0);
+	if (!chip_data->base) {
+		pr_err("%pOF: failed to map sirq registers\n", node);
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	for (i = 0; i < NUM_SIRQ; i++) {
+		struct of_phandle_args irq;
+
+		ret = of_irq_parse_one(node, i, &irq);
+		if (ret) {
+			pr_err("%pOF: failed to parse interrupt %d\n", node, i);
+			goto out_unmap;
+		}
+
+		if (WARN_ON(irq.args_count != 3)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+
+		chip_data->ext_irqs[i] = irq.args[1];
+
+		/* Set 24MHz external interrupt clock freq */
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_CLK_SEL, i);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_SIRQ, node,
+					  &owl_sirq_domain_ops, chip_data);
+	if (!domain) {
+		pr_err("%pOF: failed to add domain\n", node);
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(chip_data->base);
+out_free:
+	kfree(chip_data);
+
+	return ret;
+}
+
+static int __init owl_sirq_s500_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s500_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s500, "actions,s500-sirq", owl_sirq_s500_of_init);
+IRQCHIP_DECLARE(owl_sirq_s700, "actions,s700-sirq", owl_sirq_s500_of_init);
+
+static int __init owl_sirq_s900_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s900_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s900, "actions,s900-sirq", owl_sirq_s900_of_init);
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
new file mode 100644
index 000000000000..92fb5780dc10
--- /dev/null
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PRU-ICSS INTC IRQChip driver for various TI SoCs
+ *
+ * Copyright (C) 2016-2020 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Author(s):
+ *	Andrew F. Davis <afd@ti.com>
+ *	Suman Anna <s-anna@ti.com>
+ *	Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org> for Texas Instruments
+ *
+ * Copyright (C) 2019 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+/*
+ * Number of host interrupts reaching the main MPU sub-system. Note that this
+ * is not the same as the total number of host interrupts supported by the PRUSS
+ * INTC instance
+ */
+#define MAX_NUM_HOST_IRQS	8
+
+/* minimum starting host interrupt number for MPU */
+#define FIRST_PRU_HOST_INT	2
+
+/* PRU_ICSS_INTC registers */
+#define PRU_INTC_REVID		0x0000
+#define PRU_INTC_CR		0x0004
+#define PRU_INTC_GER		0x0010
+#define PRU_INTC_GNLR		0x001c
+#define PRU_INTC_SISR		0x0020
+#define PRU_INTC_SICR		0x0024
+#define PRU_INTC_EISR		0x0028
+#define PRU_INTC_EICR		0x002c
+#define PRU_INTC_HIEISR		0x0034
+#define PRU_INTC_HIDISR		0x0038
+#define PRU_INTC_GPIR		0x0080
+#define PRU_INTC_SRSR(x)	(0x0200 + (x) * 4)
+#define PRU_INTC_SECR(x)	(0x0280 + (x) * 4)
+#define PRU_INTC_ESR(x)		(0x0300 + (x) * 4)
+#define PRU_INTC_ECR(x)		(0x0380 + (x) * 4)
+#define PRU_INTC_CMR(x)		(0x0400 + (x) * 4)
+#define PRU_INTC_HMR(x)		(0x0800 + (x) * 4)
+#define PRU_INTC_HIPIR(x)	(0x0900 + (x) * 4)
+#define PRU_INTC_SIPR(x)	(0x0d00 + (x) * 4)
+#define PRU_INTC_SITR(x)	(0x0d80 + (x) * 4)
+#define PRU_INTC_HINLR(x)	(0x1100 + (x) * 4)
+#define PRU_INTC_HIER		0x1500
+
+/* CMR register bit-field macros */
+#define CMR_EVT_MAP_MASK	0xf
+#define CMR_EVT_MAP_BITS	8
+#define CMR_EVT_PER_REG		4
+
+/* HMR register bit-field macros */
+#define HMR_CH_MAP_MASK		0xf
+#define HMR_CH_MAP_BITS		8
+#define HMR_CH_PER_REG		4
+
+/* HIPIR register bit-fields */
+#define INTC_HIPIR_NONE_HINT	0x80000000
+
+#define MAX_PRU_SYS_EVENTS 160
+#define MAX_PRU_CHANNELS 20
+
+/**
+ * struct pruss_intc_map_record - keeps track of actual mapping state
+ * @value: The currently mapped value (channel or host)
+ * @ref_count: Keeps track of number of current users of this resource
+ */
+struct pruss_intc_map_record {
+	u8 value;
+	u8 ref_count;
+};
+
+/**
+ * struct pruss_intc_match_data - match data to handle SoC variations
+ * @num_system_events: number of input system events handled by the PRUSS INTC
+ * @num_host_events: number of host events (which is equal to number of
+ *		     channels) supported by the PRUSS INTC
+ */
+struct pruss_intc_match_data {
+	u8 num_system_events;
+	u8 num_host_events;
+};
+
+/**
+ * struct pruss_intc - PRUSS interrupt controller structure
+ * @event_channel: current state of system event to channel mappings
+ * @channel_host: current state of channel to host mappings
+ * @irqs: kernel irq numbers corresponding to PRUSS host interrupts
+ * @base: base virtual address of INTC register space
+ * @domain: irq domain for this interrupt controller
+ * @soc_config: cached PRUSS INTC IP configuration data
+ * @dev: PRUSS INTC device pointer
+ * @lock: mutex to serialize interrupts mapping
+ */
+struct pruss_intc {
+	struct pruss_intc_map_record event_channel[MAX_PRU_SYS_EVENTS];
+	struct pruss_intc_map_record channel_host[MAX_PRU_CHANNELS];
+	unsigned int irqs[MAX_NUM_HOST_IRQS];
+	void __iomem *base;
+	struct irq_domain *domain;
+	const struct pruss_intc_match_data *soc_config;
+	struct device *dev;
+	struct mutex lock; /* PRUSS INTC lock */
+};
+
+/**
+ * struct pruss_host_irq_data - PRUSS host irq data structure
+ * @intc: PRUSS interrupt controller pointer
+ * @host_irq: host irq number
+ */
+struct pruss_host_irq_data {
+	struct pruss_intc *intc;
+	u8 host_irq;
+};
+
+static inline u32 pruss_intc_read_reg(struct pruss_intc *intc, unsigned int reg)
+{
+	return readl_relaxed(intc->base + reg);
+}
+
+static inline void pruss_intc_write_reg(struct pruss_intc *intc,
+					unsigned int reg, u32 val)
+{
+	writel_relaxed(val, intc->base + reg);
+}
+
+static void pruss_intc_update_cmr(struct pruss_intc *intc, unsigned int evt,
+				  u8 ch)
+{
+	u32 idx, offset, val;
+
+	idx = evt / CMR_EVT_PER_REG;
+	offset = (evt % CMR_EVT_PER_REG) * CMR_EVT_MAP_BITS;
+
+	val = pruss_intc_read_reg(intc, PRU_INTC_CMR(idx));
+	val &= ~(CMR_EVT_MAP_MASK << offset);
+	val |= ch << offset;
+	pruss_intc_write_reg(intc, PRU_INTC_CMR(idx), val);
+
+	dev_dbg(intc->dev, "SYSEV%u -> CH%d (CMR%d 0x%08x)\n", evt, ch,
+		idx, pruss_intc_read_reg(intc, PRU_INTC_CMR(idx)));
+}
+
+static void pruss_intc_update_hmr(struct pruss_intc *intc, u8 ch, u8 host)
+{
+	u32 idx, offset, val;
+
+	idx = ch / HMR_CH_PER_REG;
+	offset = (ch % HMR_CH_PER_REG) * HMR_CH_MAP_BITS;
+
+	val = pruss_intc_read_reg(intc, PRU_INTC_HMR(idx));
+	val &= ~(HMR_CH_MAP_MASK << offset);
+	val |= host << offset;
+	pruss_intc_write_reg(intc, PRU_INTC_HMR(idx), val);
+
+	dev_dbg(intc->dev, "CH%d -> HOST%d (HMR%d 0x%08x)\n", ch, host, idx,
+		pruss_intc_read_reg(intc, PRU_INTC_HMR(idx)));
+}
+
+/**
+ * pruss_intc_map() - configure the PRUSS INTC
+ * @intc: PRUSS interrupt controller pointer
+ * @hwirq: the system event number
+ *
+ * Configures the PRUSS INTC with the provided configuration from the one parsed
+ * in the xlate function.
+ */
+static void pruss_intc_map(struct pruss_intc *intc, unsigned long hwirq)
+{
+	struct device *dev = intc->dev;
+	u8 ch, host, reg_idx;
+	u32 val;
+
+	mutex_lock(&intc->lock);
+
+	intc->event_channel[hwirq].ref_count++;
+
+	ch = intc->event_channel[hwirq].value;
+	host = intc->channel_host[ch].value;
+
+	pruss_intc_update_cmr(intc, hwirq, ch);
+
+	reg_idx = hwirq / 32;
+	val = BIT(hwirq  % 32);
+
+	/* clear and enable system event */
+	pruss_intc_write_reg(intc, PRU_INTC_ESR(reg_idx), val);
+	pruss_intc_write_reg(intc, PRU_INTC_SECR(reg_idx), val);
+
+	if (++intc->channel_host[ch].ref_count == 1) {
+		pruss_intc_update_hmr(intc, ch, host);
+
+		/* enable host interrupts */
+		pruss_intc_write_reg(intc, PRU_INTC_HIEISR, host);
+	}
+
+	dev_dbg(dev, "mapped system_event = %lu channel = %d host = %d",
+		hwirq, ch, host);
+
+	mutex_unlock(&intc->lock);
+}
+
+/**
+ * pruss_intc_unmap() - unconfigure the PRUSS INTC
+ * @intc: PRUSS interrupt controller pointer
+ * @hwirq: the system event number
+ *
+ * Undo whatever was done in pruss_intc_map() for a PRU core.
+ * Mappings are reference counted, so resources are only disabled when there
+ * are no longer any users.
+ */
+static void pruss_intc_unmap(struct pruss_intc *intc, unsigned long hwirq)
+{
+	u8 ch, host, reg_idx;
+	u32 val;
+
+	mutex_lock(&intc->lock);
+
+	ch = intc->event_channel[hwirq].value;
+	host = intc->channel_host[ch].value;
+
+	if (--intc->channel_host[ch].ref_count == 0) {
+		/* disable host interrupts */
+		pruss_intc_write_reg(intc, PRU_INTC_HIDISR, host);
+
+		/* clear the map using reset value 0 */
+		pruss_intc_update_hmr(intc, ch, 0);
+	}
+
+	intc->event_channel[hwirq].ref_count--;
+	reg_idx = hwirq / 32;
+	val = BIT(hwirq  % 32);
+
+	/* disable system events */
+	pruss_intc_write_reg(intc, PRU_INTC_ECR(reg_idx), val);
+	/* clear any pending status */
+	pruss_intc_write_reg(intc, PRU_INTC_SECR(reg_idx), val);
+
+	/* clear the map using reset value 0 */
+	pruss_intc_update_cmr(intc, hwirq, 0);
+
+	dev_dbg(intc->dev, "unmapped system_event = %lu channel = %d host = %d\n",
+		hwirq, ch, host);
+
+	mutex_unlock(&intc->lock);
+}
+
+static void pruss_intc_init(struct pruss_intc *intc)
+{
+	const struct pruss_intc_match_data *soc_config = intc->soc_config;
+	int num_chnl_map_regs, num_host_intr_regs, num_event_type_regs, i;
+
+	num_chnl_map_regs = DIV_ROUND_UP(soc_config->num_system_events,
+					 CMR_EVT_PER_REG);
+	num_host_intr_regs = DIV_ROUND_UP(soc_config->num_host_events,
+					  HMR_CH_PER_REG);
+	num_event_type_regs = DIV_ROUND_UP(soc_config->num_system_events, 32);
+
+	/*
+	 * configure polarity (SIPR register) to active high and
+	 * type (SITR register) to level interrupt for all system events
+	 */
+	for (i = 0; i < num_event_type_regs; i++) {
+		pruss_intc_write_reg(intc, PRU_INTC_SIPR(i), 0xffffffff);
+		pruss_intc_write_reg(intc, PRU_INTC_SITR(i), 0);
+	}
+
+	/* clear all interrupt channel map registers, 4 events per register */
+	for (i = 0; i < num_chnl_map_regs; i++)
+		pruss_intc_write_reg(intc, PRU_INTC_CMR(i), 0);
+
+	/* clear all host interrupt map registers, 4 channels per register */
+	for (i = 0; i < num_host_intr_regs; i++)
+		pruss_intc_write_reg(intc, PRU_INTC_HMR(i), 0);
+
+	/* global interrupt enable */
+	pruss_intc_write_reg(intc, PRU_INTC_GER, 1);
+}
+
+static void pruss_intc_irq_ack(struct irq_data *data)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	unsigned int hwirq = data->hwirq;
+
+	pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
+}
+
+static void pruss_intc_irq_mask(struct irq_data *data)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	unsigned int hwirq = data->hwirq;
+
+	pruss_intc_write_reg(intc, PRU_INTC_EICR, hwirq);
+}
+
+static void pruss_intc_irq_unmask(struct irq_data *data)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	unsigned int hwirq = data->hwirq;
+
+	pruss_intc_write_reg(intc, PRU_INTC_EISR, hwirq);
+}
+
+static int pruss_intc_irq_reqres(struct irq_data *data)
+{
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void pruss_intc_irq_relres(struct irq_data *data)
+{
+	module_put(THIS_MODULE);
+}
+
+static int pruss_intc_irq_get_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool *state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, mask, srsr;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	reg = PRU_INTC_SRSR(data->hwirq / 32);
+	mask = BIT(data->hwirq % 32);
+
+	srsr = pruss_intc_read_reg(intc, reg);
+
+	*state = !!(srsr & mask);
+
+	return 0;
+}
+
+static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state)
+		pruss_intc_write_reg(intc, PRU_INTC_SISR, data->hwirq);
+	else
+		pruss_intc_write_reg(intc, PRU_INTC_SICR, data->hwirq);
+
+	return 0;
+}
+
+static struct irq_chip pruss_irqchip = {
+	.name			= "pruss-intc",
+	.irq_ack		= pruss_intc_irq_ack,
+	.irq_mask		= pruss_intc_irq_mask,
+	.irq_unmask		= pruss_intc_irq_unmask,
+	.irq_request_resources	= pruss_intc_irq_reqres,
+	.irq_release_resources	= pruss_intc_irq_relres,
+	.irq_get_irqchip_state	= pruss_intc_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= pruss_intc_irq_set_irqchip_state,
+};
+
+static int pruss_intc_validate_mapping(struct pruss_intc *intc, int event,
+				       int channel, int host)
+{
+	struct device *dev = intc->dev;
+	int ret = 0;
+
+	mutex_lock(&intc->lock);
+
+	/* check if sysevent already assigned */
+	if (intc->event_channel[event].ref_count > 0 &&
+	    intc->event_channel[event].value != channel) {
+		dev_err(dev, "event %d (req. ch %d) already assigned to channel %d\n",
+			event, channel, intc->event_channel[event].value);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/* check if channel already assigned */
+	if (intc->channel_host[channel].ref_count > 0 &&
+	    intc->channel_host[channel].value != host) {
+		dev_err(dev, "channel %d (req. host %d) already assigned to host %d\n",
+			channel, host, intc->channel_host[channel].value);
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	intc->event_channel[event].value = channel;
+	intc->channel_host[channel].value = host;
+
+unlock:
+	mutex_unlock(&intc->lock);
+	return ret;
+}
+
+static int
+pruss_intc_irq_domain_xlate(struct irq_domain *d, struct device_node *node,
+			    const u32 *intspec, unsigned int intsize,
+			    unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct pruss_intc *intc = d->host_data;
+	struct device *dev = intc->dev;
+	int ret, sys_event, channel, host;
+
+	if (intsize < 3)
+		return -EINVAL;
+
+	sys_event = intspec[0];
+	if (sys_event < 0 || sys_event >= intc->soc_config->num_system_events) {
+		dev_err(dev, "%d is not valid event number\n", sys_event);
+		return -EINVAL;
+	}
+
+	channel = intspec[1];
+	if (channel < 0 || channel >= intc->soc_config->num_host_events) {
+		dev_err(dev, "%d is not valid channel number", channel);
+		return -EINVAL;
+	}
+
+	host = intspec[2];
+	if (host < 0 || host >= intc->soc_config->num_host_events) {
+		dev_err(dev, "%d is not valid host irq number\n", host);
+		return -EINVAL;
+	}
+
+	/* check if requested sys_event was already mapped, if so validate it */
+	ret = pruss_intc_validate_mapping(intc, sys_event, channel, host);
+	if (ret)
+		return ret;
+
+	*out_hwirq = sys_event;
+	*out_type = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
+static int pruss_intc_irq_domain_map(struct irq_domain *d, unsigned int virq,
+				     irq_hw_number_t hw)
+{
+	struct pruss_intc *intc = d->host_data;
+
+	pruss_intc_map(intc, hw);
+
+	irq_set_chip_data(virq, intc);
+	irq_set_chip_and_handler(virq, &pruss_irqchip, handle_level_irq);
+
+	return 0;
+}
+
+static void pruss_intc_irq_domain_unmap(struct irq_domain *d, unsigned int virq)
+{
+	struct pruss_intc *intc = d->host_data;
+	unsigned long hwirq = irqd_to_hwirq(irq_get_irq_data(virq));
+
+	irq_set_chip_and_handler(virq, NULL, NULL);
+	irq_set_chip_data(virq, NULL);
+	pruss_intc_unmap(intc, hwirq);
+}
+
+static const struct irq_domain_ops pruss_intc_irq_domain_ops = {
+	.xlate	= pruss_intc_irq_domain_xlate,
+	.map	= pruss_intc_irq_domain_map,
+	.unmap	= pruss_intc_irq_domain_unmap,
+};
+
+static void pruss_intc_irq_handler(struct irq_desc *desc)
+{
+	unsigned int irq = irq_desc_get_irq(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pruss_host_irq_data *host_irq_data = irq_get_handler_data(irq);
+	struct pruss_intc *intc = host_irq_data->intc;
+	u8 host_irq = host_irq_data->host_irq + FIRST_PRU_HOST_INT;
+
+	chained_irq_enter(chip, desc);
+
+	while (true) {
+		u32 hipir;
+		unsigned int virq;
+		int hwirq;
+
+		/* get highest priority pending PRUSS system event */
+		hipir = pruss_intc_read_reg(intc, PRU_INTC_HIPIR(host_irq));
+		if (hipir & INTC_HIPIR_NONE_HINT)
+			break;
+
+		hwirq = hipir & GENMASK(9, 0);
+		virq = irq_find_mapping(intc->domain, hwirq);
+
+		/*
+		 * NOTE: manually ACK any system events that do not have a
+		 * handler mapped yet
+		 */
+		if (WARN_ON_ONCE(!virq))
+			pruss_intc_write_reg(intc, PRU_INTC_SICR, hwirq);
+		else
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static const char * const irq_names[MAX_NUM_HOST_IRQS] = {
+	"host_intr0", "host_intr1", "host_intr2", "host_intr3",
+	"host_intr4", "host_intr5", "host_intr6", "host_intr7",
+};
+
+static int pruss_intc_probe(struct platform_device *pdev)
+{
+	const struct pruss_intc_match_data *data;
+	struct device *dev = &pdev->dev;
+	struct pruss_intc *intc;
+	struct pruss_host_irq_data *host_data;
+	int i, irq, ret;
+	u8 max_system_events, irqs_reserved = 0;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	max_system_events = data->num_system_events;
+
+	intc = devm_kzalloc(dev, sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
+
+	intc->soc_config = data;
+	intc->dev = dev;
+	platform_set_drvdata(pdev, intc);
+
+	intc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intc->base))
+		return PTR_ERR(intc->base);
+
+	ret = of_property_read_u8(dev->of_node, "ti,irqs-reserved",
+				  &irqs_reserved);
+
+	/*
+	 * The irqs-reserved is used only for some SoC's therefore not having
+	 * this property is still valid
+	 */
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
+	pruss_intc_init(intc);
+
+	mutex_init(&intc->lock);
+
+	intc->domain = irq_domain_add_linear(dev->of_node, max_system_events,
+					     &pruss_intc_irq_domain_ops, intc);
+	if (!intc->domain)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (irqs_reserved & BIT(i))
+			continue;
+
+		irq = platform_get_irq_byname(pdev, irq_names[i]);
+		if (irq <= 0) {
+			ret = (irq == 0) ? -EINVAL : irq;
+			goto fail_irq;
+		}
+
+		intc->irqs[i] = irq;
+
+		host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
+		if (!host_data) {
+			ret = -ENOMEM;
+			goto fail_irq;
+		}
+
+		host_data->intc = intc;
+		host_data->host_irq = i;
+
+		irq_set_handler_data(irq, host_data);
+		irq_set_chained_handler(irq, pruss_intc_irq_handler);
+	}
+
+	return 0;
+
+fail_irq:
+	while (--i >= 0) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
+
+	irq_domain_remove(intc->domain);
+
+	return ret;
+}
+
+static int pruss_intc_remove(struct platform_device *pdev)
+{
+	struct pruss_intc *intc = platform_get_drvdata(pdev);
+	u8 max_system_events = intc->soc_config->num_system_events;
+	unsigned int hwirq;
+	int i;
+
+	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
+
+	for (hwirq = 0; hwirq < max_system_events; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
+
+	irq_domain_remove(intc->domain);
+
+	return 0;
+}
+
+static const struct pruss_intc_match_data pruss_intc_data = {
+	.num_system_events = 64,
+	.num_host_events = 10,
+};
+
+static const struct pruss_intc_match_data icssg_intc_data = {
+	.num_system_events = 160,
+	.num_host_events = 20,
+};
+
+static const struct of_device_id pruss_intc_of_match[] = {
+	{
+		.compatible = "ti,pruss-intc",
+		.data = &pruss_intc_data,
+	},
+	{
+		.compatible = "ti,icssg-intc",
+		.data = &icssg_intc_data,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
+
+static struct platform_driver pruss_intc_driver = {
+	.driver = {
+		.name = "pruss-intc",
+		.of_match_table = pruss_intc_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe  = pruss_intc_probe,
+	.remove = pruss_intc_remove,
+};
+module_platform_driver(pruss_intc_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
+MODULE_AUTHOR("Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>");
+MODULE_DESCRIPTION("TI PRU-ICSS INTC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index d4e97605456b..e0cceb81c648 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -175,8 +175,8 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct irq_fwspec parent_fwspec;
 	struct device_node *parent_node;
 	unsigned int parent_virq;
-	u16 vint_id, p_hwirq;
-	int ret;
+	int p_hwirq, ret;
+	u16 vint_id;
 
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL)
@@ -600,13 +600,9 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 
 	inta->pdev = pdev;
 	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(inta->sci)) {
-		ret = PTR_ERR(inta->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		inta->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(inta->sci))
+		return dev_err_probe(dev, PTR_ERR(inta->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &inta->ti_sci_id);
 	if (ret) {
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index cbc1758228d9..ac9d6d658e65 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -137,8 +137,8 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
 	struct device_node *parent_node;
 	struct irq_fwspec fwspec;
-	u16 out_irq, p_hwirq;
-	int err = 0;
+	int p_hwirq, err = 0;
+	u16 out_irq;
 
 	out_irq = ti_sci_get_free_resource(intr->out_irqs);
 	if (out_irq == TI_SCI_RESOURCE_NULL)
@@ -254,13 +254,9 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
-	if (IS_ERR(intr->sci)) {
-		ret = PTR_ERR(intr->sci);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ti,sci read fail %d\n", ret);
-		intr->sci = NULL;
-		return ret;
-	}
+	if (IS_ERR(intr->sci))
+		return dev_err_probe(dev, PTR_ERR(intr->sci),
+				     "ti,sci read fail\n");
 
 	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dev-id",
 				   &intr->ti_sci_id);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f0819d..bd39e9de6ecf 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -205,7 +205,8 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
 				  IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE,
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
@@ -340,7 +341,8 @@ static const struct irq_domain_ops qcom_pdc_gpio_ops = {
 
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
-	int ret, n;
+	int ret, n, i;
+	u32 irq_index, reg_index, val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -369,6 +371,14 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 						 &pdc_region[n].cnt);
 		if (ret)
 			return ret;
+
+		for (i = 0; i < pdc_region[n].cnt; i++) {
+			reg_index = (i + pdc_region[n].pin_base) >> 5;
+			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
+			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
+			val &= ~BIT(irq_index);
+			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+		}
 	}
 
 	return 0;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2567e772cd5..c4bcda90aac4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1077,12 +1077,10 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	 * when TLMM is powered on. To allow that, enable the GPIO
 	 * summary line to be wakeup capable at GIC.
 	 */
-	if (d->parent_data)
-		irq_chip_set_wake_parent(d, on);
-
-	irq_set_irq_wake(pctrl->irq, on);
+	if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return irq_chip_set_wake_parent(d, on);
 
-	return 0;
+	return irq_set_irq_wake(pctrl->irq, on);
 }
 
 static int msm_gpio_irq_reqres(struct irq_data *d)
@@ -1243,6 +1241,9 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
 	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
+	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
+				IRQCHIP_SET_TYPE_MASKED |
+				IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
 
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d332e5d9abac..b0bba8ab75bb 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1990,44 +1990,17 @@ static int tegra_pmc_irq_alloc(struct irq_domain *domain, unsigned int virq,
 							    event->id,
 							    &pmc->irq, pmc);
 
-			/*
-			 * GPIOs don't have an equivalent interrupt in the
-			 * parent controller (GIC). However some code, such
-			 * as the one in irq_get_irqchip_state(), require a
-			 * valid IRQ chip to be set. Make sure that's the
-			 * case by passing NULL here, which will install a
-			 * dummy IRQ chip for the interrupt in the parent
-			 * domain.
-			 */
-			if (domain->parent)
-				irq_domain_set_hwirq_and_chip(domain->parent,
-							      virq, 0, NULL,
-							      NULL);
-
+			/* GPIO hierarchies stop at the PMC level */
+			if (!err && domain->parent)
+ 				err = irq_domain_disconnect_hierarchy(domain->parent,
+								      virq);
 			break;
 		}
 	}
 
-	/*
-	 * For interrupts that don't have associated wake events, assign a
-	 * dummy hardware IRQ number. This is used in the ->irq_set_type()
-	 * and ->irq_set_wake() callbacks to return early for these IRQs.
-	 */
-	if (i == soc->num_wake_events) {
-		err = irq_domain_set_hwirq_and_chip(domain, virq, ULONG_MAX,
-						    &pmc->irq, pmc);
-
-		/*
-		 * Interrupts without a wake event don't have a corresponding
-		 * interrupt in the parent controller (GIC). Pass NULL for the
-		 * chip here, which causes a dummy IRQ chip to be installed
-		 * for the interrupt in the parent domain, to make this
-		 * explicit.
-		 */
-		if (domain->parent)
-			irq_domain_set_hwirq_and_chip(domain->parent, virq, 0,
-						      NULL, NULL);
-	}
+	/* If there is no wake-up event, there is no PMC mapping */
+	if (i == soc->num_wake_events)
+		err = irq_domain_disconnect_hierarchy(domain, virq);
 
 	return err;
 }
@@ -2043,9 +2016,6 @@ static int tegra210_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	unsigned int offset, bit;
 	u32 value;
 
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2080,9 +2050,6 @@ static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned int offset, bit;
 	u32 value;
 
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2123,10 +2090,6 @@ static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	unsigned int offset, bit;
 	u32 value;
 
-	/* nothing to do if there's no associated wake event */
-	if (WARN_ON(data->hwirq == ULONG_MAX))
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2154,10 +2117,6 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
 	u32 value;
 
-	/* nothing to do if there's no associated wake event */
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
 
 	switch (type) {
@@ -2184,6 +2143,34 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void tegra_irq_mask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_mask_parent(data);
+}
+
+static void tegra_irq_unmask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_unmask_parent(data);
+}
+
+static void tegra_irq_eoi_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_eoi_parent(data);
+}
+
+static int tegra_irq_set_affinity_parent(struct irq_data *data,
+					 const struct cpumask *dest,
+					 bool force)
+{
+	if (data->parent_data)
+		return irq_chip_set_affinity_parent(data, dest, force);
+
+	return -EINVAL;
+}
+
 static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 {
 	struct irq_domain *parent = NULL;
@@ -2199,10 +2186,10 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 		return 0;
 
 	pmc->irq.name = dev_name(pmc->dev);
-	pmc->irq.irq_mask = irq_chip_mask_parent;
-	pmc->irq.irq_unmask = irq_chip_unmask_parent;
-	pmc->irq.irq_eoi = irq_chip_eoi_parent;
-	pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
+	pmc->irq.irq_mask = tegra_irq_mask_parent;
+	pmc->irq.irq_unmask = tegra_irq_unmask_parent;
+	pmc->irq.irq_eoi = tegra_irq_eoi_parent;
+	pmc->irq.irq_set_affinity = tegra_irq_set_affinity_parent;
 	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
 	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4dfee35b..c54365309e97 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -71,6 +71,7 @@ enum irqchip_irq_state;
  *				  it from the spurious interrupt detection
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
+ * IRQ_HIDDEN			- Don't show up in /proc/interrupts
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -97,13 +98,14 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
+	IRQ_HIDDEN		= (1 << 20),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
@@ -215,6 +217,8 @@ struct irq_data {
  *				  from actual interrupt context.
  * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
  *				  irq_chip::irq_set_affinity() when deactivated.
+ * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
+ *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -240,6 +244,7 @@ enum {
 	IRQD_MSI_NOMASK_QUIRK		= (1 << 27),
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -319,6 +324,11 @@ static inline bool irqd_is_handle_enforce_irqctx(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_HANDLE_ENFORCE_IRQCTX;
 }
 
+static inline bool irqd_is_enabled_on_suspend(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_IRQ_ENABLED_ON_SUSPEND;
+}
+
 static inline bool irqd_is_wakeup_set(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_WAKEUP_STATE;
@@ -545,27 +555,30 @@ struct irq_chip {
 /*
  * irq_chip specific flags
  *
- * IRQCHIP_SET_TYPE_MASKED:	Mask before calling chip.irq_set_type()
- * IRQCHIP_EOI_IF_HANDLED:	Only issue irq_eoi() when irq was handled
- * IRQCHIP_MASK_ON_SUSPEND:	Mask non wake irqs in the suspend path
- * IRQCHIP_ONOFFLINE_ENABLED:	Only call irq_on/off_line callbacks
- *				when irq enabled
- * IRQCHIP_SKIP_SET_WAKE:	Skip chip.irq_set_wake(), for this irq chip
- * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
- * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
- * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
- * IRQCHIP_SUPPORTS_NMI:	Chip can deliver NMIs, only for root irqchips
+ * IRQCHIP_SET_TYPE_MASKED:           Mask before calling chip.irq_set_type()
+ * IRQCHIP_EOI_IF_HANDLED:            Only issue irq_eoi() when irq was handled
+ * IRQCHIP_MASK_ON_SUSPEND:           Mask non wake irqs in the suspend path
+ * IRQCHIP_ONOFFLINE_ENABLED:         Only call irq_on/off_line callbacks
+ *                                    when irq enabled
+ * IRQCHIP_SKIP_SET_WAKE:             Skip chip.irq_set_wake(), for this irq chip
+ * IRQCHIP_ONESHOT_SAFE:              One shot does not require mask/unmask
+ * IRQCHIP_EOI_THREADED:              Chip requires eoi() on unmask in threaded mode
+ * IRQCHIP_SUPPORTS_LEVEL_MSI:        Chip can provide two doorbells for Level MSIs
+ * IRQCHIP_SUPPORTS_NMI:              Chip can deliver NMIs, only for root irqchips
+ * IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND:  Invokes __enable_irq()/__disable_irq() for wake irqs
+ *                                    in the suspend path if they are in disabled state
  */
 enum {
-	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
-	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
-	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
-	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
-	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
-	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
-	IRQCHIP_EOI_THREADED		= (1 <<  6),
-	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
-	IRQCHIP_SUPPORTS_NMI		= (1 <<  8),
+	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
+	IRQCHIP_EOI_IF_HANDLED			= (1 <<  1),
+	IRQCHIP_MASK_ON_SUSPEND			= (1 <<  2),
+	IRQCHIP_ONOFFLINE_ENABLED		= (1 <<  3),
+	IRQCHIP_SKIP_SET_WAKE			= (1 <<  4),
+	IRQCHIP_ONESHOT_SAFE			= (1 <<  5),
+	IRQCHIP_EOI_THREADED			= (1 <<  6),
+	IRQCHIP_SUPPORTS_LEVEL_MSI		= (1 <<  7),
+	IRQCHIP_SUPPORTS_NMI			= (1 <<  8),
+	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 };
 
 #include <linux/irqdesc.h>
@@ -634,6 +647,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
@@ -1252,6 +1266,12 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#else
+#define set_handle_irq(handle_irq)		\
+	do {					\
+		(void)handle_irq;		\
+		WARN_ON(1);			\
+	} while (0)
 #endif
 
 #endif /* _LINUX_IRQ_H */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b37350c4fe37..a52b095bd404 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -509,6 +509,9 @@ extern void irq_domain_free_irqs_parent(struct irq_domain *domain,
 					unsigned int irq_base,
 					unsigned int nr_irqs);
 
+extern int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+					   unsigned int virq);
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 857f5f4c8098..bed517d5aa4d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -944,6 +944,33 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * The biggest difference with the IRQ version is that the interrupt is
+ * EOIed early, as the IPI could result in a context switch, and we need to
+ * make sure the IPI can fire again. We also assume that the arch code has
+ * registered an action. If not, we are positively doomed.
+ */
+void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	__kstat_incr_irqs_this_cpu(desc);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+}
+
 /**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index b95ff5d5f4bd..e4cff358b437 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -57,6 +57,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
+	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
 };
 
 static void
@@ -125,6 +126,8 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_DEFAULT_TRIGGER_SET),
 
 	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
+
+	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
@@ -136,6 +139,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_PER_CPU_DEVID),
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
+	BIT_MASK_DESCR(_IRQ_HIDDEN),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 76cd7ebd1178..cf8b374b892d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1136,6 +1136,17 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
 	return irq_data;
 }
 
+static void __irq_domain_free_hierarchy(struct irq_data *irq_data)
+{
+	struct irq_data *tmp;
+
+	while (irq_data) {
+		tmp = irq_data;
+		irq_data = irq_data->parent_data;
+		kfree(tmp);
+	}
+}
+
 static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *irq_data, *tmp;
@@ -1147,12 +1158,83 @@ static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
 		irq_data->parent_data = NULL;
 		irq_data->domain = NULL;
 
-		while (tmp) {
-			irq_data = tmp;
-			tmp = tmp->parent_data;
-			kfree(irq_data);
+		__irq_domain_free_hierarchy(tmp);
+	}
+}
+
+/**
+ * irq_domain_disconnect_hierarchy - Mark the first unused level of a hierarchy
+ * @domain:	IRQ domain from which the hierarchy is to be disconnected
+ * @virq:	IRQ number where the hierarchy is to be trimmed
+ *
+ * Marks the @virq level belonging to @domain as disconnected.
+ * Returns -EINVAL if @virq doesn't have a valid irq_data pointing
+ * to @domain.
+ *
+ * Its only use is to be able to trim levels of hierarchy that do not
+ * have any real meaning for this interrupt, and that the driver marks
+ * as such from its .alloc() callback.
+ */
+int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+				    unsigned int virq)
+{
+	struct irq_data *irqd;
+
+	irqd = irq_domain_get_irq_data(domain, virq);
+	if (!irqd)
+		return -EINVAL;
+
+	irqd->chip = ERR_PTR(-ENOTCONN);
+	return 0;
+}
+
+static int irq_domain_trim_hierarchy(unsigned int virq)
+{
+	struct irq_data *tail, *irqd, *irq_data;
+
+	irq_data = irq_get_irq_data(virq);
+	tail = NULL;
+
+	/* The first entry must have a valid irqchip */
+	if (!irq_data->chip || IS_ERR(irq_data->chip))
+		return -EINVAL;
+
+	/*
+	 * Validate that the irq_data chain is sane in the presence of
+	 * a hierarchy trimming marker.
+	 */
+	for (irqd = irq_data->parent_data; irqd; irq_data = irqd, irqd = irqd->parent_data) {
+		/* Can't have a valid irqchip after a trim marker */
+		if (irqd->chip && tail)
+			return -EINVAL;
+
+		/* Can't have an empty irqchip before a trim marker */
+		if (!irqd->chip && !tail)
+			return -EINVAL;
+
+		if (IS_ERR(irqd->chip)) {
+			/* Only -ENOTCONN is a valid trim marker */
+			if (PTR_ERR(irqd->chip) != -ENOTCONN)
+				return -EINVAL;
+
+			tail = irq_data;
 		}
 	}
+
+	/* No trim marker, nothing to do */
+	if (!tail)
+		return 0;
+
+	pr_info("IRQ%d: trimming hierarchy from %s\n",
+		virq, tail->parent_data->domain->name);
+
+	/* Sever the inner part of the hierarchy...  */
+	irqd = tail;
+	tail = tail->parent_data;
+	irqd->parent_data = NULL;
+	__irq_domain_free_hierarchy(tail);
+
+	return 0;
 }
 
 static int irq_domain_alloc_irq_data(struct irq_domain *domain,
@@ -1362,6 +1444,15 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 		mutex_unlock(&irq_domain_mutex);
 		goto out_free_irq_data;
 	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = irq_domain_trim_hierarchy(virq + i);
+		if (ret) {
+			mutex_unlock(&irq_domain_mutex);
+			goto out_free_irq_data;
+		}
+	}
+	
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_insert_irq(virq + i);
 	mutex_unlock(&irq_domain_mutex);
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index c6c7e187ae74..ce0adb22ee96 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -69,12 +69,26 @@ void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action)
 
 static bool suspend_device_irq(struct irq_desc *desc)
 {
+	unsigned long chipflags = irq_desc_get_chip(desc)->flags;
+	struct irq_data *irqd = &desc->irq_data;
+
 	if (!desc->action || irq_desc_is_chained(desc) ||
 	    desc->no_suspend_depth)
 		return false;
 
-	if (irqd_is_wakeup_set(&desc->irq_data)) {
-		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	if (irqd_is_wakeup_set(irqd)) {
+		irqd_set(irqd, IRQD_WAKEUP_ARMED);
+
+		if ((chipflags & IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND) &&
+		     irqd_irq_disabled(irqd)) {
+			/*
+			 * Interrupt marked for wakeup is in disabled state.
+			 * Enable interrupt here to unmask/enable in irqchip
+			 * to be able to resume with such interrupts.
+			 */
+			__enable_irq(desc);
+			irqd_set(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND);
+		}
 		/*
 		 * We return true here to force the caller to issue
 		 * synchronize_irq(). We need to make sure that the
@@ -93,7 +107,7 @@ static bool suspend_device_irq(struct irq_desc *desc)
 	 * chip level. The chip implementation indicates that with
 	 * IRQCHIP_MASK_ON_SUSPEND.
 	 */
-	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
+	if (chipflags & IRQCHIP_MASK_ON_SUSPEND)
 		mask_irq(desc);
 	return true;
 }
@@ -137,7 +151,19 @@ EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
 static void resume_irq(struct irq_desc *desc)
 {
-	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	struct irq_data *irqd = &desc->irq_data;
+
+	irqd_clear(irqd, IRQD_WAKEUP_ARMED);
+
+	if (irqd_is_enabled_on_suspend(irqd)) {
+		/*
+		 * Interrupt marked for wakeup was enabled during suspend
+		 * entry. Disable such interrupts to restore them back to
+		 * original state.
+		 */
+		__disable_irq(desc);
+		irqd_clear(irqd, IRQD_IRQ_ENABLED_ON_SUSPEND);
+	}
 
 	if (desc->istate & IRQS_SUSPENDED)
 		goto resume;
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 32c071d7bc03..72513ed2a5fc 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc)
+	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs)
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index c48ce19a257f..8ccd32a0cc80 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -86,6 +86,18 @@ static int irq_sw_resend(struct irq_desc *desc)
 }
 #endif
 
+static int try_retrigger(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_retrigger)
+		return desc->irq_data.chip->irq_retrigger(&desc->irq_data);
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	return irq_chip_retrigger_hierarchy(&desc->irq_data);
+#else
+	return 0;
+#endif
+}
+
 /*
  * IRQ resend
  *
@@ -113,8 +125,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
 
 	desc->istate &= ~IRQS_PENDING;
 
-	if (!desc->irq_data.chip->irq_retrigger ||
-	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+	if (!try_retrigger(desc))
 		err = irq_sw_resend(desc);
 
 	/* If the retrigger was successfull, mark it with the REPLAY bit */
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index e43795cd2ccf..403378b9947b 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,6 +17,7 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
+	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -31,6 +32,7 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
+#define IRQ_HIDDEN		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -167,3 +169,8 @@ static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 {
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
 }
+
+static inline bool irq_settings_is_hidden(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_HIDDEN;
+}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f62433..09229ad82209 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,6 +481,7 @@ void raise_softirq(unsigned int nr)
 
 void __raise_softirq_irqoff(unsigned int nr)
 {
+	lockdep_assert_irqs_disabled();
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }

