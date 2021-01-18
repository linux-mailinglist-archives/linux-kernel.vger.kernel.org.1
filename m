Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3462F9988
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbhARFwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:52:38 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34819 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730383AbhARFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:51:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 262F71632;
        Mon, 18 Jan 2021 00:50:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=5XdEQzoMuk7hnpocbHN+P9qSj4
        w9zaam6BF5QqohfSQ=; b=NLfaMbtzojxxF9nNPSRMcpfSFf1GstzmX3h7eM1L/b
        tPKD+coLZctccjnP2eJ+ua0L1a9l4wUbTN5nCYB+dshL5UxULq+zBEEZtMS2m4Gt
        rN83/r2BJoOXNVr7DylGjEKzBih0FNdl44vEXNKV6Qr4LQxAv7+Oo+blJFvS12R6
        699K2NL6fj1RAUj1ULH4q1Yt7+jW/mgiV1gQjjysvqW41yRjun7+4Oqr7n9egUuO
        dYCDf23JP0b9qUma4r6sYX+tjyxouEui10K+yMxWDNsXrWz5qQDj/acSHZMUqm/q
        d8VmB3t/h/b2JZZE+lRQ1+ZVW3yJdBU6bQn4ZLPPX7sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5XdEQzoMuk7hnpocb
        HN+P9qSj4w9zaam6BF5QqohfSQ=; b=my5Li+QNBGkR1k60f35/RlAXP/pXgSKtX
        70WGHMVrbhj4C6XC92S9L2RtStHrGDut3POAFy/YzKG0XoP6JFL7Q5pT73Qgk15Z
        yf8X8W60Aox1t9jJpZ8M10SD18xLujAy6g3Dh4MQWJthdi/isBsLppQVcq7Eq2Hu
        KayP0bEzorLBFunhJ1cwTzQQP2H72HRTPQT6O1Oi8BQMERplZWh8eSXReCroGJLI
        L01rA3kWAzJPKkzR2IJPFlFUTX0UF7TwLWoLqX8+TqS+qgGn7eC/f1AjuCw58yS2
        apfeeeG29ZiFfbiSIuKo8nYZaUn3JK4Cu3ppflspSRN6WvsOprnmQ==
X-ME-Sender: <xms:sSEFYJTEYhELtS4nehOj9N-n-Ya3dJ3dcLfHTcn6I7GCUQhLf0l1OQ>
    <xme:sSEFYCzHEPx0oKrmJuVfAApRR-ia3m1QttN9JHChrFtNHqgXhnr5nUdi_aUPk8HZV
    RgdWP83DnxpkDn7nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:sSEFYO2tBiIeMXqpBvYJnsbPAZKc6c7zepVYlSL8YungsDtdDt7Tpg>
    <xmx:sSEFYBBoep7RfOafdiq71ERKRaWaE9vjj6SoEWhCTdCUrznmjUGBEA>
    <xmx:sSEFYChzoH5ACIopye-I_HtXrB6Mk8Vy2RGco524TmNrdaA0CeEnsg>
    <xmx:siEFYLXrIJiVF2bOsPy-R6_4pLWRC_XUs_CM_9oXipqplYwMBWHAWSE9AEE>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 294AA24005B;
        Mon, 18 Jan 2021 00:50:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Date:   Sun, 17 Jan 2021 23:50:30 -0600
Message-Id: <20210118055040.21910-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
the external NMI pin, and provides 32+ IRQs to the ARISC. The first 16
of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
The last 13-16 multiplex the first (up to) 128 GIC SPIs.

This series replaces the existing chained irqchip driver that could only
control the NMI, with a stacked irqchip driver that also provides wakeup
capability for those multiplexed SPI IRQs. The idea is to preconfigure
the ARISC's IRQ controller, and then the ARISC firmware knows to wake up
as soon as it receives an IRQ. It can also decide how deep it can
suspend based on the enabled wakeup IRQs.

As future work, it may be useful to do the chained->stacked conversion
on the sunxi-nmi driver as well.

Patches 1-2 add the new bindings.
Patch 3 adds the new driver.
Patch 4 adds wakeup capability.
Remaining patches update the device trees to use R_INTC where beneficial.

With appropriate firmware and configuration, this series allows waking
from (and it has been tested with) the RTC, NMI/PMIC (power button, A/C
plug, etc.), all GPIO ports (button, lid switch, modem, etc.), LRADC,
and UARTs. I have tested this patch set on the H3, A64, H5, and H6 SoCs.

---
Changes from v4:
 - Add Acked-by/Reviewed-by tags.
 - Switch back to writel_relaxed(). My previous explanation for using
   writel() made no sense, because both the GIC and this write are to
   device memory, so they cannot be reordered. I was able to reproduce
   the extra IRQs even with writel(), so I know the issue is elsewhere.
 - Use NULL instead of 0 when clearing data->chip_data.

Changes from v3:
 - Removed A31 fallback from H6 compatible.
 - Switch to additionalProperties in binding.
 - Replace wall of text with ASCII art.
 - Added macros for NMI_SRC_TYPE constants.
 - Renamed NR_IRQS to NR_TOP_LEVEL_IRQS to hopefully be more clear.
 - Use non-relaxed writel in sun6i_r_intc_ack_nmi to fix spurious level
   interrupts (reordering with gic_unmask_irq).
 - Use a single irq_chip for edge and level NMI configurations.
   - For edge, ack ASAP using handle_fasteoi_ack_irq.
   - For level, ack in .irq_unmask if masked at EOI, else in .irq_eoi.
 - Enforce that the R_INTC->GIC trigger is IRQ_TYPE_LEVEL_HIGH.
 - Implement .irq_set_irqchip_state.
 - Move other IRQs to a new irq_chip that only intercepts .irq_set_wake.
 - Use radix instead of linear for the IRQ domain since only a handful
   of the 128 hwirqs will ever be used.

Changes from v2:
 - Fix edge IRQs on GICv2 with EOImode == 0, as found on A83T and older.
   - Replace .irq_ack callback with .irq_mask.
   - Drop IRQCHIP_EOI_THREADED.
   - This removes the dependency on IRQ_FASTEOI_HIERARCHY_HANDLERS.
 - Move IRQ_DOMAIN_HIERARCHY selection to ARCH_SUNXI to fix A83T build.
 - Add support for the second IRQ ENABLE/PENDING register on H6 and up.
 - Add support for multiplexed IRQs beyond the initial 16.
   - This requires a new binding, but keeps old binding compatibility.
   - This requires a separate mux mapping for H6 and up.
 - Rename parent_* => nmi_* because they only apply to the NMI.
 - Merge code common to probe and resume functions.
 - Also run suspend callback at syscore shutdown, for boards with no
   PMIC where firmware is also responsible for poweroff/poweron.
   - These two changes mean nothing is conditional on CONFIG_PM_SLEEP
     anymore, since all code is used even without it.
 - Since the binding changed, update all SoC DTs, A31 and up.
 - Drop r_ir from inclusion (it needs more than an IRQ to wake) and
   include pio (the main pin controller) and (r_)lradc.
 - As there are significant changes, I did not carry forward Maxime's
   Acked-by or Rob's Reviewed-by.

Changes from v1:
 - Use writel_relaxed() instead if writel().
 - Remove use of the MASK register, as it doesn't affect the NMI as seen
   by the GIC. It only affects the IRQs seen by the coprocessor.
 - Leave NMI_HWIRQ enabled at all times, since it can be masked at the
   GIC level (removed .irq_enable and .irq_disable).
 - Use .irq_ack vs .irq_eoi depending on the trigger type, to avoid
   missing interrupts or double interrupts.
   - Because of this change, the driver needs two "irq_chip"s, one
     with .irq_eoi set to our function and one without.
   - Also because of this, we need IRQ_FASTEOI_HIERARCHY_HANDLERS for
     handle_fasteoi_ack_irq(), so our .irq_ack function gets called
     while the GIC driver works as if handle_fasteoi_irq() was used.
 - Inline the SUNXI_SRC_TYPE_* enum into sun6i_r_intc_irq_set_type().
 - Add a comment explaining how the trigger type is used.
 - Don't call irqd_set_trigger_type().
 - Set IRQCHIP_SET_TYPE_MASKED to match the GIC (since flags from this
   driver mask flags from that one).
 - Set IRQCHIP_EOI_THREADED to avoid doubled level interrupts, since the
   latch will be set again as long as the trigger is met.
 - Replace sun6i_r_intc_domain_translate() with
   irq_domain_translate_twocell().
 - Use an enum for the device tree binding.
 - Update commit messages for accuracy and typos.

Samuel Holland (10):
  dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
  dt-bindings: irq: sun6i-r: Add a compatible for the H3
  irqchip/sun6i-r: Use a stacked irqchip driver
  irqchip/sun6i-r: Add wakeup support
  ARM: dts: sunxi: Rename nmi_intc to r_intc
  ARM: dts: sunxi: Use the new r_intc binding
  ARM: dts: sunxi: h3/h5: Add r_intc node
  ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
  arm64: dts: allwinner: Use the new r_intc binding
  arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc

 .../allwinner,sun6i-a31-r-intc.yaml           |  67 ++++
 .../allwinner,sun7i-a20-sc-nmi.yaml           |  10 -
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts   |   4 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts            |   4 +-
 .../boot/dts/sun6i-a31-mele-a1000g-quad.dts   |   4 +-
 arch/arm/boot/dts/sun6i-a31.dtsi              |   8 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts      |   4 +-
 .../arm/boot/dts/sun6i-a31s-sina31s-core.dtsi |   4 +-
 .../boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   4 +-
 .../sun6i-a31s-yones-toptech-bs1078-v2.dts    |   4 +-
 .../dts/sun6i-reference-design-tablet.dtsi    |   4 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   8 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     |   4 +-
 .../arm/boot/dts/sun8i-a33-sinlinx-sina33.dts |   4 +-
 .../dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   4 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |   4 +-
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |   4 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     |   4 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             |   5 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |   4 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts        |   4 +-
 .../dts/sun8i-reference-design-tablet.dtsi    |   4 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  12 +
 arch/arm/mach-sunxi/Kconfig                   |   2 +
 arch/arm64/Kconfig.platforms                  |   2 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |   2 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |   2 +-
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |   2 +-
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |   2 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |   2 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   2 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |   2 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |   2 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |   2 +-
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |   2 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |   2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   6 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   2 +-
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   2 +-
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |   2 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |   4 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   8 +-
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sun6i-r.c                 | 379 ++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c               |  26 +-
 45 files changed, 542 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

-- 
2.26.2

