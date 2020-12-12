Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A22D8700
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 15:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438946AbgLLN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 08:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgLLN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 08:57:17 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E65222BB;
        Sat, 12 Dec 2020 13:56:36 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1ko5Ny-000iT2-Hg; Sat, 12 Dec 2020 13:56:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Biwen Li <biwen.li@nxp.com>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Shenming Lu <lushenming@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.11
Date:   Sat, 12 Dec 2020 13:56:26 +0000
Message-Id: <20201212135626.1479884-1-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandre.belloni@bootlin.com, atenart@kernel.org, biwen.li@nxp.com, dianders@chromium.org, geert+renesas@glider.be, gregory.clement@bootlin.com, Zhiqiang.Hou@nxp.com, chenhuacai@kernel.org, john.garry@huawei.com, lokeshvutla@ti.com, mkshah@codeaurora.org, rafael.j.wysocki@intel.com, robh@kernel.org, lushenming@huawei.com, swboyd@chromium.org, tsahee@annapurnalabs.com, valentin.schneider@arm.com, vgupta@synopsys.com, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here the delivery from the irqchip department for 5.11. No new driver
for once, but an assortment of support for new SoCs (Microsemi Ocelot
derivatives, NXP SoCs), small fixes (QC PDC, TI SCI, Loongson HTPIC)
and cleanups (EZChip dead platform). We also have some preliminary
support for managed interrupts on platform devices (which also drags
in some fixes in the platform-MSI code and GICv3-ITS), and the removal
of the fasteoi IPI handler, which Valentin has proved not to be
required. Overall, a pretty quiet drop. Something must be brewing
somewhere.

Please note that while I usually base irqchip/next on -rc3 or -rc4,
I've had to pull in -rc6 this time in order avoid potential conflicts
with the fixes branch. I hope this won't cause too much trouble. If it
does, let me know and I'll rebase it.

Please pull,

	M.

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.11

for you to fetch changes up to 2f5fbc4305d07725bfebaedb09e57271315691ef:

  irqchip/qcom-pdc: Fix phantom irq when changing between rising/falling (2020-12-12 10:46:02 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.11

- Preliminary support for managed interrupts on platform devices
- Correctly identify allocation of MSIs proxyied by another device
- Remove the fasteoi IPI flow which has been proved useless
- Generalise the Ocelot support to new SoCs
- Improve GICv4.1 vcpu entry, matching the corresponding KVM optimisation
- Work around spurious interrupts on Qualcomm PDC
- Random fixes and cleanups

----------------------------------------------------------------
Biwen Li (1):
      dt-bindings: interrupt-controller: update bindings for supporting more SoCs

Douglas Anderson (1):
      irqchip/qcom-pdc: Fix phantom irq when changing between rising/falling

Geert Uytterhoeven (1):
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

Marc Zyngier (4):
      irqchip/alpine-msi: Fix freeing of interrupts on allocation error path
      platform-msi: Track shared domain allocation
      irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy device
      irqchip/gic-v3-its: Flag device allocation as proxied if behind a PCI bridge

Shenming Lu (1):
      irqchip/gic-v4.1: Reduce the delay when polling GICR_VPENDBASER.Dirty

Valentin Schneider (5):
      irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()
      irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
      irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
      irqchip/hip04: Make IPIs use handle_percpu_devid_irq()
      Revert "genirq: Add fasteoi IPI flow"

Vineet Gupta (1):
      drivers/irqchip: Remove EZChip NPS interrupt controller

 .../interrupt-controller/fsl,ls-extirq.txt         |   8 +-
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  21 ---
 .../mscc,ocelot-icpu-intr.yaml                     |  64 ++++++++
 drivers/acpi/resource.c                            |  17 +--
 drivers/base/platform-msi.c                        |   7 +
 drivers/base/platform.c                            | 121 +++++++++++++++
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
 include/asm-generic/msi.h                          |   4 +
 include/linux/interrupt.h                          |   8 +
 include/linux/ioport.h                             |   7 +
 include/linux/irq.h                                |   1 -
 include/linux/platform_device.h                    |   6 +
 kernel/irq/chip.c                                  |  27 ----
 kernel/irq/manage.c                                |  70 +++++++++
 30 files changed, 476 insertions(+), 309 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
 delete mode 100644 drivers/irqchip/irq-eznps.c
