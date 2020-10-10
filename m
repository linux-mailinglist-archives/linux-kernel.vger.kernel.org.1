Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8035728A306
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgJJW7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732262AbgJJTyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012AA2076C;
        Sat, 10 Oct 2020 12:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602333067;
        bh=lZ/vwg//HPLDReKiam1rjfyw35GSoEviWw4JNQJZow4=;
        h=From:To:Cc:Subject:Date:From;
        b=uktZk8sUczuBh20siZr7gDLrYpVU8omHkyuC2+mp67cj9ZgSYRDJvzimN9alqjinO
         sXNrBC5jviKZgyLih8iPKNdM0vO4YthMbJsTsuvtA+y3YrRejV6OWFEIG8Rt2268YI
         ToO1NE7aqHsNLYsW200Vge/94s2gDBXuO4HdZIx0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kRE1g-001Hf0-Vb; Sat, 10 Oct 2020 13:31:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Daniel Palmer <daniel@thingy.jp>,
        David Lechner <david@lechnology.com>,
        Douglas Anderson <dianders@chromium.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Huacai Chen <chenhc@lemote.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Parthiban Nallathambi <pn@denx.de>,
        Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, Suman Anna <s-anna@ti.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 5.10
Date:   Sat, 10 Oct 2020 13:30:39 +0100
Message-Id: <20201010123040.1406783-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandru.elisei@arm.com, Anson.Huang@nxp.com, bjorn.andersson@linaro.org, catalin.marinas@arm.com, Chris.Paterson2@renesas.com, cristian.ciocaltea@gmail.com, daniel@thingy.jp, david@lechnology.com, dianders@chromium.org, grzegorz.jaszczyk@linaro.org, guillaume.tucker@collabora.com, lvhaoyu@huawei.com, chenhc@lemote.com, krzk@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, lee.jones@linaro.org, linus.walleij@linaro.org, lokeshvutla@ti.com, m.szyprowski@samsung.com, mark-pk.tsai@mediatek.com, mkshah@codeaurora.org, pn@denx.de, robh@kernel.org, rogerq@ti.com, sravanhome@gmail.com, swboyd@chromium.org, s-anna@ti.com, valentin.schneider@arm.com, yuehaibing@huawei.com, thunder.leizhen@huawei.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jason@lakedaemon.net, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the rather large set of irqchip updates for 5.10.

This time around, we have three new drivers (MStar, Owl SIRQ and
PRUSS), some cross-architecture updates (the arm/arm64 switch to
standard IRQs for IPIs and the corresponding changes to their primary
irqchip drivers), a number of fixes as the fallout from these updates
(the Tegra bug is tasty), some driver updates (QC PDC, WD APB ICTL,
GIC...), and a couple of mundane bug fixes.

Please pull,

	M.

The following changes since commit f4d51dffc6c01a9e94650d95ce0104964f8ae822:

  Linux 5.9-rc4 (2020-09-06 17:11:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.10

for you to fetch changes up to 63ea38a402213d8c9c16e58ee4901ff51bc8fe3c:

  Merge branch 'irq/mstar' into irq/irqchip-next (2020-10-10 12:46:54 +0100)

----------------------------------------------------------------
irqchip updates for Linux 5.10

Core changes:
- Allow irq retriggering to follow a hierarchy
- Allow interrupt hierarchies to be trimmed at allocation time
- Allow interrupts to be hidden from /proc/interrupts (IPIs)
- Introduce stub for set_handle_irq() when !GENERIC_IRQ_MULTI_HANDLER
- New per-cpu IPI handling flow

Architecture changes:
- Move arm/arm64 IPI handling to the core interrupt code, removing
  the home brewed accounting

Driver updates:
- New driver for the MStar (and more recently Mediatek) platforms
- New driver for the Actions Owl SIRQ controller
- New driver for the TI PRUSS infrastructure
- Wake-up support for the Qualcomm PDC controller
- Primary interrupt controller support for the Designware APB ICTL
- Convert the IPI code for GIC, GICv3, hip04, armada-270-xp and bcm2836
  to using standard interrupts
- Improve GICv3 pseudo-NMI support to deal with both non-secure and secure
  priorities on arm64
- Convert the GIC/GICv3 drivers to using HW-based irq retrigger
- A sprinkling of dev_err_probe() conversion
- A set of NVIDIA Tegra fixes for interrupt hierarchy corruption
- A reset fix for the Loongson HTVEC driver
- A couple of error handling fixes in the TI SCI drivers

----------------------------------------------------------------
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

Krzysztof Kozlowski (1):
      irqchip/ti-sci: Simplify with dev_err_probe()

Lad Prabhakar (1):
      irqchip: Kconfig: Update description for RENESAS_IRQC config

Marc Zyngier (36):
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
      Merge remote-tracking branch 'origin/irq/misc-5.10' into irq/irqchip-next
      Merge remote-tracking branch 'origin/irq/dev_err_probe' into irq/irqchip-next
      Merge remote-tracking branch 'origin/irq/gic-v3-nmi-ns' into irq/irqchip-next
      Merge remote-tracking branch 'origin/irq/ipi-as-irq' into irq/irqchip-next
      Merge remote-tracking branch 'origin/irq/gic-retrigger' into irq/irqchip-next
      arm: Move ipi_teardown() to a CONFIG_HOTPLUG_CPU section
      ARM: Handle no IPI being registered in show_ipi_list()
      Merge branch 'irq/ipi-as-irq', remote-tracking branches 'origin/irq/dw' and 'origin/irq/owl' into irq/irqchip-next
      Merge branch 'irq/qcom-pdc-wakeup' into irq/irqchip-next
      genirq/irqdomain: Allow partial trimming of irq_data hierarchy
      gpio: tegra186: Allow optional irq parent callbacks
      soc/tegra: pmc: Allow optional irq parent callbacks
      soc/tegra: pmc: Don't create fake interrupt hierarchy levels
      Merge branch 'irq/tegra-pmc' into irq/irqchip-next
      Merge branch 'irq/irqchip-fixes' into irq/irqchip-next
      Merge branch 'irq/mstar' into irq/irqchip-next

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
 50 files changed, 2761 insertions(+), 613 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
 create mode 100644 drivers/irqchip/irq-mst-intc.c
 create mode 100644 drivers/irqchip/irq-owl-sirq.c
 create mode 100644 drivers/irqchip/irq-pruss-intc.c
