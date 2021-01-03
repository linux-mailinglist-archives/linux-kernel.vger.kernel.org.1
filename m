Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8661E2E8BAB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbhACKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:13 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59483 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbhACKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3BFF45803BB;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=xZrwF91W8lKr7yTr9S7ucMDrtY
        mVv8csp2XZa2xyKsg=; b=M6/Zafz8Y9dCepJfVlqx7Bca4h+2lC3fQQjwxUgwHr
        qHGq5BoldAvKHBW1iZs7fVw052X+6Mr/BcjBUzZx8IoewphOA2WHsuuMkU53n4+B
        kHjyB4cnRTzxO0et2OmSjZrdBdn9K5BhX3EAmXFC2pmFJ02LWR8eept491y7fe1I
        uMooCNRylHcqxqs/EUBU5XAjkfl1uMie4G8d43lU/I2NEKbPG/akhs+/Mwouy9Wg
        3cxFtOrY1KvLGhzP6NZhdcqH/JBcrZQhXRbx78O9X62K/3OHRjrLOS22fA5lFEn8
        lpkRXucs0Ot33vTBYr+4Pgs4QPzN1j1K+3EAb/i0szHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xZrwF91W8lKr7yTr9
        S7ucMDrtYmVv8csp2XZa2xyKsg=; b=aOrfc1vS+MjVfMHHMOt6wfOyTUlV1mWuG
        nk3CYLz04kaXHAfio34IOeM5katfwdVoSwLLs9C/oxiMCIUxAK4ZJhVWEeknCQ/E
        gbZ7HXlqmZDb1hXeQBrakSPuFmG5DBaOXeT9gi+DSlmt5mlenxBPNgp+vdZgevCF
        uve1INSRo6zb3rYiuXEdSsQwbYMgT79tI/tJ0MutkE8/hEq91xVqQ9yAyz/qFDom
        76rj7LSZ8H2HHgT/tM3SpE5ygPyNTpdfXcVw89/tWWhLO81egPdqFNR8A+8iF1U0
        XOAIlnN07r3ijOp+ZjbpDaIN8WQGVJRpQU2aaOYJ7Bma5tj5cR9DA==
X-ME-Sender: <xms:5pzxX3J2dSe14royr5VjJj8MR6pzMtJdVRxol3VzE80cv4T8I26xGA>
    <xme:5pzxX7L2e6r0L8pWgBDlFZF3XDRsK7EGwFXhSScWJmZJRflZ12BMua396wBbD_WIB
    UBm2Ze4QshMf-MXsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:5pzxX_tN5LXRsw3EL7MpGyfr-mlgJU6vw1SqKcLNGxfHGBaADa1wLA>
    <xmx:5pzxXwYijGIyU9wvuV7Q9sIItUACLhTny7csAdqlZ4nbX4W9CgJwTg>
    <xmx:5pzxX-akB6r6PmbVnv4Vio_FGiUt5sgGy1bnQN2SJ1ige76xVPcKcg>
    <xmx:6JzxX6Sovx6p7WIR5q5qV8xLg66cwD6Bpm2xOwIwj0GmIDZK6XDghw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D391F108005F;
        Sun,  3 Jan 2021 05:31:01 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 00/10] sunxi: Support IRQ wakeup from deep sleep
Date:   Sun,  3 Jan 2021 04:30:51 -0600
Message-Id: <20210103103101.33603-1-samuel@sholland.org>
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
suspend based on the selected wakeup IRQs.

As future work, it may be useful to do the chained->stacked conversion
on the sunxi-nmi driver as well.

Patches 1-2 add the new bindings.
Patch 3 adds the new driver.
Patch 4 adds wakeup capability.
The other patches update the device trees to use R_INTC where beneficial.

With appropriate firmware and configuration, this series allows waking
from (and it has been tested with) the RTC, NMI/PMIC (power button, A/C
plug, etc.), all GPIO ports (button, lid switch, modem, etc.), LRADC,
and UARTs. I have tested this patch set on the H3, A64, H5, and H6 SoCs.

---

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

 .../allwinner,sun6i-a31-r-intc.yaml           |  65 ++++
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
 arch/arm/mach-sunxi/Kconfig                   |   1 +
 arch/arm64/Kconfig.platforms                  |   1 +
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
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   5 +-
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sun6i-r.c                 | 353 ++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c               |  26 +-
 45 files changed, 511 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

-- 
2.26.2

