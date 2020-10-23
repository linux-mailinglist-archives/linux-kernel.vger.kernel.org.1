Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD5297951
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757164AbgJWWb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757156AbgJWWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t14so2474526pgg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPbs8Y/n3m/VwniqcY2iPAT7JQvEu76twH8IGeVBvcM=;
        b=cbIRvjg/odssMgyAJw4/IW2aeCbS6stQYolgDh4oZdg4OZUDIUH9ypH3fQ5GuKSmMP
         rkAffXN3gCHJB6LSmSfRWR5hy9SB+QoCg+s2JZr8pmFJph8PRgUKGgtpmM9URW/xzOK/
         tRscV6wno3hyzSaC7nlwiNzkq6kXYQw6j37T1T8h6bwMdOvmzwTkPEk4theYJGjtWynQ
         VpakKRerKOFixCkHWO3dIrOHUbdJh7qekFPqhcL2vBIgSqAnfXG7FELnVbGK+e4ZmFqa
         dt982E8oA3pktnzjt3wEnqfNfcHx5cxAdleDzLH2k3S/8nMnIl+Qtxjw19RBQNhX7r4Q
         QWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPbs8Y/n3m/VwniqcY2iPAT7JQvEu76twH8IGeVBvcM=;
        b=VewlR19d3CeH/S4Bs9COgiAasAFSkpZYMdVVbfTquyjqZ8u7cxXhcHJgOfI2Es64/M
         ZYfmyYnG5juHGYCI6VgODwd2bljxhChDx8mojPC4OxkBSWWRcOmPQqZRh2B9etw6pimr
         Jmh9SeKGGy6gauBGSLPrVz83CLwXXEqsXdCvqxuyGt5wGDQNBvwcQHSSvrzFSal8Z+iy
         BDS3o5Qzrc0NNVO723dVyhkI8CWXt7+o5HlOS977R+7iOWpbAH8e1Q9etgCs0MPLftRq
         4gsdn55YxfzUxlQisjuIyPn1LwdDT17pzdxn5ow/1nQGofo0fLHIBuNnYyObBjxx0tqX
         4h/A==
X-Gm-Message-State: AOAM532rZFwV1QFUnvpR+nE06do9GUxVSYpLqgSm7MU7M4quiOFSKvJA
        5uoH3GqcH3Uv6HMHZAs/Hnk4uw==
X-Google-Smtp-Source: ABdhPJxXI1o+//VHNRP3cGNnT6oWxoV6SHdGxVultCbWazhPoR92xmkfBCsWW87OQzMA6JAWnwJE1w==
X-Received: by 2002:a17:90a:d98c:: with SMTP id d12mr5338607pjv.191.1603492314915;
        Fri, 23 Oct 2020 15:31:54 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:52 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/5] ARM: Devicetree updates
Date:   Fri, 23 Oct 2020 15:31:21 -0700
Message-Id: <20201023223122.19189-5-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023223122.19189-1-olof@lixom.net>
References: <20201023223122.19189-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, most of the changes are to devicetrees. Besides smaller fixes,
some refactorings and cleanups, some of the new platforms and chips
(or significant features) supported are below:

Broadcom boards:
- Cisco Meraki MR32 (BCM53016-based)
- BCM2711 (RPi4) display pipeline support

Actions Semi boards:
- Caninos Loucos Labrador SBC (S500-based)
- RoseapplePi SBC (S500-based)

Allwinner SoCs/boards:
- A100 SoC with Perf1 board
- Mali, DMA, Cetrus and IR support for R40 SoC

Amlogic boards:
- Libretch S905x CC V2 board
- Hardkernel ODROID-N2+ board

Aspeed boards/platforms:
- Wistron Mowgli (AST2500-based, Power9 OpenPower server)
- Facebook Wedge400 (AST2500-based, ToR switch)

Hisilicon SoC:
- SD5203 SoC

Nvidia boards:
- Tegra234 VDK, for pre-silicon Orin SoC

NXP i.MX boards:
- Librem 5 phone
- i.MX8MM DDR4 EVK
- Variscite VAR-SOM-MX8MN SoM
- Symphony board
- Tolino Shine 2 HD
- TQMa6 SoM
- Y Soft IOTA Orion

Rockchip boards:
- NanoPi R2S board
- A95X-Z2 board
- more Rock-Pi4 variants

STM32 boards:
- Odyssey SOM board (STM32MP157CAC-based)
- DH DRC02 board

Toshiba SoCs/boards:
- Visconti SoC and TPMV7708 board


Conflicts: None

----------------------------------------------------------------

The following changes since commit f9de8df76d9c61414d1fc8a13173ca59ef17d129:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to 098bfcec1bfc9c1f063b3702b1c209e15c603c76:

  Merge tag 'visconti-initial-for-5.10-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti into arm/dt

----------------------------------------------------------------

Adam Ford (1):
      ARM: dts: omap3: Add cpu trips and cooling map for omap34/36 families

Adrian Schmutzler (9):
      ARM: dts: rockchip: replace status value "ok" by "okay"
      arm64: dts: rockchip: replace status value "ok" by "okay"
      arm64: dts: broadcom: replace status value "ok" by "okay"
      ARM: dts: omap: replace status value "ok" by "okay"
      ARM: dts: dra7xx: replace status value "ok" by "okay"
      ARM: dts: am43xx: replace status value "ok" by "okay"
      ARM: dts: NSP: replace status value "ok" by "okay"
      arm64: dts: qcom: replace status value "ok" by "okay"
      arm64: dts: hisilicon: replace status value "ok" by "okay"

Ahmad Fatoum (1):
      ARM: dts: stm32: lxa-mc1: enable DDR50 mode on eMMC

Alex Ryabchenko (1):
      arm: dts: mt7623: add lima related regulator

Alexander Kochetkov (1):
      arm64: dts: allwinner: replace numerical constant with CCU_CLKX

Alexandre Belloni (5):
      ARM: dts: at91: fix cpu node
      ARM: dts: at91: fix sram nodes
      ARM: dts: at91: move mmc pinctrl-names property to board dts
      ARM: dts: at91: add unit-address to memory node
      ARM: dts: at91: sama5d2: add missing flexcom spi node properties

Alexandre Torgue (1):
      ARM: dts: stm32: add arm-pmu node on stm32mp15

Amit Kucheria (1):
      arm64: dts: qcom: sm8250: Add thermal zones and throttling support

Amit Pundir (1):
      arm64: dts: qcom: Add support for Xiaomi Poco F1 (Beryllium)

Amit Singh Tomar (2):
      arm64: dts: actions: limit address range for pinctrl node
      arm64: dts: actions: Add DMA Controller for S700

Andre Przywara (14):
      arm64: dts: broadcom: Fix SP805 clock-names
      arm64: dts: freescale: Fix SP805 clock-names
      ARM: dts: arm: Fix SP804 users
      ARM: dts: arm: Fix SP805 clocks
      arm64: dts: arm: Fix SP805 clock-names
      ARM: dts: Cygnus: Fix SP805 clocks
      ARM: dts: NSP: Fix SP805 clock-names
      ARM: dts: broadcom: Fix SP804 node
      arm64: dts: hisilicon: Fix SP805 clocks
      ARM: dts: hisilicon: Fix SP804 users
      ARM: dts: hisilicon: Fix SP805 clocks
      arm64: dts: lg: Fix SP805 clocks
      arm64: dts: lg: Fix SP804 users
      ARM: dts: nspire: Fix SP804 users

Andreas Kemnade (2):
      dt-bindings: arm: fsl: add compatible string for Tolino Shine 2 HD
      ARM: dts: imx: add devicetree for Tolino Shine 2 HD

Andrew Jeffery (1):
      ARM: dts: rainier: Disable internal pull-downs on eMMC pins

Angus Ainslie (Purism) (1):
      arm64: dts: Add a device tree for the Librem 5 phone

Anson Huang (3):
      ARM: dts: imx27: Change nand node name to nand-controller
      ARM: dts: imx: Change gpmi nand node name to nand-controller
      arm64: dts: imx8mp: Update pinfunc header file

Artem Lapkin (2):
      arm64: dts: rockchip: add spiflash node to rk3399-khadas-edge
      arm64: dts: rockchip: add ir-receiver node to rk3399-khadas-edge

Ben Pai (1):
      ARM: dts: aspeed: Add Mowgli BMC platform

Biju Das (2):
      ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
      arm64: dts: renesas: r8a774e1-hihope-rzg2h: Enable HS400 mode

Bjorn Andersson (1):
      arm64: dts: qcom: sm8250: Add cpufreq hw node

Chris Healy (2):
      ARM: dts: ZII: Disable HW Ethernet switch reset GPIOs
      dt-bindings: nvmem: Add syscon to Vybrid OCOTP driver

Christian Hewitt (3):
      arm64: dts: meson: convert ODROID-N2 to dtsi
      dt-bindings: arm: amlogic: add support for the ODROID-N2+
      arm64: dts: meson: add support for the ODROID-N2+

Christian Lamparter (5):
      dt-bindings: ARM: add bindings for the Meraki MR32
      ARM: dts: BCM5301X: Specify PWM in the DT
      ARM: dts: BCM5301X: Specify uart2 in the DT
      ARM: dts: BCM5301X: Specify pcie2 in the DT
      ARM: BCM5301X: Add DT for Meraki MR32

Christophe Kerello (1):
      ARM: dts: stm32: add FMC2 EBI support for stm32mp157c

Corentin Labbe (1):
      dt-bindings: crypto: Specify that allwinner, sun8i-a33-crypto needs reset

Cristian Ciocaltea (4):
      ARM: dts: owl-s500: Fix incorrect PPI interrupt specifiers
      ARM: dts: owl-s500: Add RoseapplePi
      dt-bindings: Add vendor prefix for RoseapplePi.org
      dt-bindings: arm: actions: Document RoseapplePi

Crystal Guo (1):
      arm64: dts: mt8183: update watchdog device node

Dafna Hirschfeld (1):
      arm64: dts: mt8173-elm: fix supported values for regulator-allowed-modes of da9211

Dan Murphy (2):
      ARM: dts: imx6dl-yapp4: Add reg property to the lp5562 channel node
      ARM: dts: ste-href: Add reg property to the LP5521 channel nodes

Daniel Palmer (4):
      ARM: mstar: Add interrupt controller to base dtsi
      ARM: mstar: Add interrupt to pm_uart
      ARM: mstar: Add mstar prefix to all of the dtsi/dts files
      ARM: mstar: Fix up the fallout from moving the dts/dtsi files

David Bauer (2):
      dt-bindings: Add doc for FriendlyARM NanoPi R2S
      arm64: dts: rockchip: Add support for FriendlyARM NanoPi R2S

David Heidelberg (3):
      dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
      ARM: tegra: nexus7: Add SMB347 battery charger
      dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx

Dinh Nguyen (1):
      arm64: dts: stratix10/agilex: add the ptp_ref clock

Dmitry Baryshkov (4):
      arm64: dts: qcom: sm8250: add bi_tcxo_ao to gcc clocks
      arm64: dts: qcom: sm8250-mtp: add i2c device tree nodes
      arch64: dts: qcom: sm8250: add uart nodes
      arm64: dts: sm8250: Add OPP table for all qup devices

Dmitry Osipenko (8):
      ARM: tegra: nexus7: Add aliases for MMC
      ARM: tegra: acer-a500: Add aliases for MMC
      ARM: tegra: acer-a500: Remove atmel,cfg_name property
      ARM: tegra: acer-a500: Correct PINCTRL configuration
      ARM: tegra: acer-a500: Set WiFi MMC clock rate to 50 MHz
      ARM: tegra: acer-a500: Use PLLC for WiFi MMC clock parent
      ARM: tegra: nexus7: Use PLLC for WiFi MMC clock parent
      ARM: tegra: nexus7: Add touchscreen

Douglas Anderson (1):
      arm64: dts: qcom: Add sc7180-lazor sku2

Drew Fustini (1):
      ARM: dts: am33xx: add ocp label

Eddie Huang (1):
      arm64: dts: mt8183: add scp node

Eddie James (3):
      ARM: dts: aspeed: rainier: Enable XDMA engine
      ARM: dts: aspeed: tacoma: Add IBM Operation Panel I2C device
      ARM: dts: aspeed: rainier: Add IBM Operation Panel I2C device

Fabio Estevam (10):
      arm64: dts: imx8m: Add the ENET PPS interrupt
      ARM: dts: imx: Fix the SPI chipselect polarity
      arm64: dts: imx8m: Fix the SPI chipselect polarity
      arm64: dts: imx8mm-evk: Add flexspi support
      ARM: dts: imx6qdl-gw553x: Remove unneeded #address-cells/#size-cells
      dt-bindings: arm: fsl: Add an entry for the i.MX6 LogicPD board
      ARM: dts: imx6q-logicpd: Add a specific board compatible string
      ARM: dts: imx: Add an entry for imx6q-logicpd.dtb
      ARM: dts: imx6q-logicpd: Use GPIO chipselect
      arm64: dts: imx8mq-evk: Add MIPI DSI support

Fabrizio Castro (1):
      arm64: dts: renesas: r8a77990: Add DRIF support

Faiz Abbas (2):
      arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
      arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and SD card

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-next-2020-09-08' into devicetree/next

Frank Wunderlich (2):
      arm: dts: mt7623: move display nodes to separate mt7623n.dtsi
      arm: dts: mt7623: add missing pause for switchport

Geert Uytterhoeven (6):
      Merge tag 'renesas-r8a779a0-dt-binding-defs-tag' into renesas-arm-dt-for-v5.10
      ARM: dts: renesas: Fix pin controller node names
      arm64: dts: renesas: Fix pin controller node names
      arm64: dts: renesas: Drop superfluous pin configuration containers
      arm64: dts: renesas: r8a77990: Fix MSIOF1 DMA channels
      arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA channels

Georgi Djakov (2):
      arm64: dts: qcom: sdm845: Increase the number of interconnect cells
      arm64: dts: qcom: sdm845: Add interconnects property for display

Gokul Sriram Palanisamy (1):
      dt-bindings: qcom: Add ipq8074 bindings

Grygorii Strashko (12):
      ARM: dts: am5729: beagleboneai: switch to new cpsw switch drv
      ARM: dts: am57xx-idk: switch to new cpsw switch drv
      ARM: dts: beagle-x15: switch to new cpsw switch drv
      ARM: dts: dra7x-evm: switch to new cpsw switch drv
      ARM: dts: am57xx-cl-som-am57x: switch to new cpsw switch drv
      ARM: dts: dra7: drop legacy cpsw dt node
      arm64: dts: ti: k3-j7200-main: add main navss cpts node
      arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
      arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux and phy defs
      ARM: dts: am437x-l4: add dt node for new cpsw switchdev driver
      ARM: dts: am437x: switch to new cpsw switch drv
      ARM: dts: am437x-l4: drop legacy cpsw dt node

Guido Günther (2):
      arm64: dts: imx8mq: Add NWL MIPI DSI controller
      arm64: dts: imx8mq-librem5-devkit: Enable the LCD panel

Guillaume Tucker (1):
      ARM: dts: exynos: add prefetch properties for L2C-310 cache

Holger Assmann (1):
      ARM: dts: stm32: lxa-mc1: Fix kernel warning about PHY delays

Horia Geantă (3):
      ARM: dts: imx6sl: fix rng node
      ARM: dts: imx6sll: add rng
      ARM: dts: imx6ull: add rng

Hsin-Yi Wang (1):
      arm64: dts: mt8173: elm: Fix nor_flash node property

Icenowy Zheng (7):
      ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
      ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for UART2 RX/TX
      ARM: dts: sun8i: V3/V3s/S3/S3L: add CSI1 device node
      ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for 8-bit parallel CSI
      ARM: dts: sun8i: V3/V3s/S3/S3L: add pinctrl for I2C1 at PE bank
      dt-bindings: arm: sunxi: add Pine64 PineCube binding
      ARM: dts: sun8i: s3l: add support for Pine64 PineCube IP camera

Jacky Bai (3):
      arm64: dts: imx8mm: Split the imx8mm evk board dts to a common dtsi
      arm64: dts: imx8mm: Add imx8mm ddr4 evk board support
      dt-bindings: arm: fsl: Add imx8mm ddr4 evk board

Jagan Teki (5):
      arm64: dts: rockchip: Fix power routing to support POE on rk3399-roc-pc
      dt-bindings: arm: rockchip: Update ROCKPi 4 binding
      arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts
      arm64: dts: rockchip: Add Radxa ROCK Pi 4B support
      arm64: dts: rockchip: Add Radxa ROCK Pi 4C support

Jernej Skrabec (10):
      dt-bindings: gpu: mali-utgard: Add Allwinner R40 compatible
      ARM: dts: sun8i: r40: Add Mali node
      dt-bindings: dma: allwinner,sun50i-a64-dma: Add R40 compatible
      ARM: dts: sun8i: r40: Add DMA node
      dt-bindings: media: allwinner, sun4i-a10-ir: Add R40 compatible
      ARM: dts: sun8i: r40: Add IR nodes
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable IR
      dt-bindings: sram: allwinner, sun4i-a10-system-control: Add R40 compatibles
      ARM: dts: sun8i: r40: Add node for system controller
      ARM: dts: sun8i: r40: Add video engine node

Jerome Brunet (5):
      arm64: dts: meson: vim3: correct led polarity
      arm64: dts: meson: vim3: make sound card common to all variants
      arm64: dts: meson: vim3l: remove sound card definition
      dt-bindings: arm: amlogic: add support for libretch s905x cc v2
      arm64: dts: meson: initial support for aml-s905x-cc v2

Joel Stanley (1):
      ARM: aspeed: g5: Do not set sirq polarity

Johan Jonker (8):
      arm64: dts: rockchip: change spdif fallback compatible on rk3308
      dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.
      dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
      arm64: dts: rockchip: add rk3318 A95X Z2 board
      arm64: dts: rockchip: fix cpu-supply for rk3328-evb
      ARM: dts: rockchip: update cpu supplies on rk3288
      ARM: dts: rockchip: rk3066a: add label to cpu@1
      ARM: dts: rockchip: update cpu supplies on rk3066a

Johnson CH Chen (陳昭勳) (1):
      ARM: dts: am335x: add common dtsi for MOXA UC-8100 series

Jon Hunter (2):
      arm64: tegra: Add label properties for EEPROMs
      arm64: tegra: Populate EEPROMs for Jetson Xavier NX

Jonathan Bakker (1):
      ARM: dts: s5pv210: Enable audio on Aries boards

Jonathan Marek (6):
      arm64: dts: qcom: sm8150: fix up primary USB nodes
      arm64: dts: qcom: use sm8150 gpucc dt-bindings
      arm64: dts: qcom: use sm8250 gpucc dt-bindings
      arm64: dts: qcom: sm8250: use the right clock-freqency for sleep-clk
      arm64: dts: qcom: sm8150: add interconnect nodes
      arm64: dts: qcom: sm8250: add interconnect nodes

Kathiravan T (4):
      arm64: dts: ipq8074: enable watchdog support
      dt-bindings: mailbox: add compatible for the IPQ6018 SoC
      arm64: dts: ipq6018: enable DVFS support
      arm64: dts: ipq8074: Use the A53 PMU compatible

Keerthy (2):
      arm64: dts: ti: k3-am6: Add crypto accelarator node
      arm64: dts: ti: k3-j721e-main: Add crypto accelerator node

Kefeng Wang (1):
      ARM: dts: hisilicon: add SD5203 dts

Kishon Vijay Abraham I (3):
      arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
      arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances
      arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane function

Krishna Manikandan (2):
      arm64: dts: qcom: sc7180: add interconnect bindings for display
      arm64: dts: sc7180: add bus clock to mdp node for sc7180 target

Krzysztof Kozlowski (166):
      dt-bindings: arm: samsung: Do not require clkout on Exynos5260 and Exynos7
      ARM: dts: imx6q-kontron-samx6i: Remove old fsl,spi-num-chipselects
      dt-bindings: arm: fsl: Add Beacon i.MX8M Mini Development Kit binding
      arm64: dts: imx8mm-evk: remove orphaned pinctrl-names property
      arm64: dts: imx8mn-evk: remove orphaned pinctrl-names property
      arm64: dts: imx8mp-evk: remove orphaned pinctrl-names property
      arm64: dts: imx8mm-evk: Replace deprecated phy reset properties
      arm64: dts: imx8mq-evk: Replace deprecated phy reset properties
      arm64: dts: imx8mq-phanbell: Replace deprecated phy reset properties
      arm64: dts: imx8mq-sr-som: Replace deprecated phy reset properties
      arm64: dts: imx8mq-thor96: Replace deprecated phy reset properties
      arm64: dts: imx8mm-beacon-som: Align regulator names with schema
      arm64: dts: imx8mm-beacon-som: Fix atmel,24c64 EEPROM compatible
      arm64: dts: imx8mm-evk: Align regulator names with schema
      arm64: dts: qcom: msm8992: Fix UART interrupt property
      arm64: dts: imx8mm-beacon-baseboard: Correct LED default state
      dt-bindings: arm: fsl: Fix Toradex Colibri i.MX 8 binding
      dt-bindings: arm: fsl: Add ZII Ultra boards binding
      arm64: dts: imx8mq-evk: Add hog suffix to wl-reg-on
      arm64: dts: imx8mq-zii-ultra: Add hog suffixes to GPIO hogs
      dt-bindings: arm: fsl: Add binding for Variscite VAR-SOM-MX8MM module
      dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MM
      arm64: dts: imx8mm-var-som: Add Variscite VAR-SOM-MX8MM System on Module
      arm64: dts: imx8mm-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MM
      arm64: dts: imx8mq-librem5-devkit: Add missing clock-cells to PMIC
      arm64: dts: exynos: Replace deprecated "gpios" i2c-gpio property in Exynos5433
      arm64: dts: exynos: Add compatibles to sysreg nodes
      ARM: dts: exynos: Move fixed clocks under root node in Exynos3250
      ARM: dts: exynos: Remove snps, dwc2 compatible in Exynos3250
      ARM: dts: exynos: Silence i2c-gpio dtschema warning in Galaxy I9100
      ARM: dts: exynos: Correct GPU regulator properties in Galaxy I9100
      ARM: dts: exynos: Correct S3C RTC bindings and enable it in Galaxy I9100
      ARM: dts: exynos: Correct S3C RTC bindings and enable it in Origen
      ARM: dts: exynos: Correct S3C RTC bindings and enable it in Trats
      ARM: dts: exynos: Correct S3C RTC bindings and enable it in Universal C210
      ARM: dts: exynos: Correct S3C RTC bindings in SMDKv310
      ARM: dts: exynos: Add and enable 32 kHz modem clock in Galaxy I9100
      ARM: dts: exynos: Add and enable 32 kHz modem clock in Trats
      ARM: dts: exynos: Align SPI GPIO node name with dtschema in Universal C210
      ARM: dts: exynos: Replace deprecated GPIO spi-gpio properties in Universal C210
      ARM: dts: exynos: Align SPI GPIO node name with dtschema in Galaxy I9100
      ARM: dts: exynos: Override thermal by label in Exynos4210
      ARM: dts: exynos: Override thermal by label in Galaxy I9000
      ARM: dts: exynos: Override thermal by label in Trats
      ARM: dts: exynos: Add CPU cooling in Exynos4210 Origen
      ARM: dts: exynos: Add CPU cooling in SMDKv310
      ARM: dts: exynos: Add CPU cooling in Universal C210
      ARM: dts: exynos: Align MHL GPIO pin configuration with dtschema on Galaxy I9100
      ARM: dts: exynos: Correct compatible of fixed clocks in Midas boards
      ARM: dts: exynos: Add S5M8767 clocks for RTC in Exynos4412 Origen
      ARM: dts: exynos: Override thermal by label in Midas
      ARM: dts: exynos: Override thermal by label in Exynos4412 Odroids
      ARM: dts: exynos: Add CPU cooling in Exynos4412 Origen
      ARM: dts: exynos: Add CPU cooling in SMDK4412
      ARM: dts: exynos: Add CPU cooling in Tiny4412
      ARM: dts: exynos: Correct S3C RTC bindings in SMDK4412
      ARM: dts: exynos: Correct S3C RTC bindings in Tiny4412
      ARM: dts: exynos: Correct whitespace and indentation issues
      ARM: dts: exynos: Correct compatible for Exynos5 GIC
      ARM: dts: exynos: Correct compatible for Exynos5260 GIC
      ARM: dts: exynos: Remove unneeded address/size cells in Exynos5260 GIC
      ARM: dts: exynos: Correct S3C RTC bindings in SMDK5410
      ARM: dts: exynos: Silence i2c-gpio dtschema warning in Exynos5250 Arndale
      ARM: dts: exynos: Correct whitespace and indentation issues in Exynos5
      ARM: dts: exynos: Override thermal by label in Exynos5250
      ARM: dts: exynos: Add max77686 clocks for S3C RTC in SMDK5250
      ARM: dts: exynos: Use S5M8767 clock in S3C RTC in Exynos5250 Spring
      ARM: dts: exynos: Silence DP HPD pinctrl dtschema warning in Exynos5250 Spring
      ARM: dts: exynos: Use S2MPS11 clock in S3C RTC in SMDK5420
      arm64: dts: imx8mm-beacon: Align pin configuration group names with schema
      arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC
      arm64: dts: imx8mm-evk: Align pin configuration group names with schema
      arm64: dts: imx8mm-ddr4-evk: Align pin configuration group names with schema
      arm64: dts: imx8mn-ddr4-evk: Align regulator names with schema
      arm64: dts: imx8mn-evk: Align pin configuration group names with schema
      arm64: dts: imx8mq-evk: Align pin configuration group names with schema
      arm64: dts: imx8mq-librem5-devkit: Align pin configuration group names with schema
      arm64: dts: imx8mq-phanbell: Align pin configuration group names with schema
      arm64: dts: imx8mq-pico-pi: Align pin configuration group names with schema
      arm64: dts: imx8mq-sr-som: Align pin configuration group names with schema
      arm64: dts: imx8mq-hummingboard-pulse: Align pin configuration group names with schema
      arm64: dts: imx8qxp-colibri: Align pin configuration group names with schema
      arm64: dts: imx8mm-var-som: Add 32.768 kHz clock to PMIC
      ARM: dts: vf: Fix PCA95xx GPIO expander properties on ZII CFU1
      ARM: dts: imx28-m28: Align GPMI NAND node name with schema
      ARM: dts: exynos: Remove I2C9 samsung, i2c-slave-addr from Exynos5250 boards
      ARM: dts: exynos: Silence SATA PHY warning in Exynos5250
      dt-bindings: samsung: pmu: document S5Pv210
      ARM: dts: s5pv210: fix pinctrl property of "vibrator-en" regulator in Aries
      ARM: dts: s5pv210: remove DMA controller bus node name to fix dtschema warnings
      ARM: dts: s5pv210: move fixed clocks under root node
      ARM: dts: s5pv210: move PMU node out of clock controller
      ARM: dts: s5pv210: remove dedicated 'audio-subsystem' node
      ARM: dts: s5pv210: add RTC 32 KHz clock in Aquilla
      ARM: dts: s5pv210: add RTC 32 KHz clock in Aries family
      ARM: dts: s5pv210: add RTC 32 KHz clock in Goni
      ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKC110
      ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKV210
      ARM: dts: s5pv210: add RTC 32 KHz clock in Torbreck
      ARM: dts: s5pv210: use defines for GPIO flags in Aquila
      ARM: dts: s5pv210: use defines for GPIO flags in Goni
      ARM: dts: s5pv210: use defines for IRQ flags in SMDKV210
      ARM: dts: s5pv210: use defines for IRQ flags in Goni
      ARM: dts: s5pv210: align SPI GPIO node name with dtschema in Aries
      ARM: dts: s5pv210: correct ethernet unit address in SMDKV210
      ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
      ARM: dts: s3c6410: move fixed clocks under root node in SMDK6410
      ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410
      ARM: dts: s3c6410: align node SROM bus node name with dtschema in SMDK6410
      ARM: dts: s3c6410: remove additional CPU compatible
      ARM: dts: s3c24xx: fix number of PWM cells
      ARM: dts: s3c24xx: override nodes by label
      ARM: dts: s3c24xx: align PWM/timer node name with dtschema
      ARM: dts: s3c24xx: add address to CPU node
      ARM: dts: s3c24xx: move fixed clocks under root node in SMDK2416
      arm64: dts: exynos: Remove undocumented i2s properties in Exynos5433
      ARM: dts: exynos: add input clock to CMU in Exynos3250
      ARM: dts: exynos: add input clock to CMU in Exynos4412 Odroid
      ARM: dts: exynos: move assigned-clock* properties to i2s0 node in Odroid XU4
      arm64: dts: alpine: Align GIC nodename with dtschema
      arm64: dts: alpine: Fix GIC unit address
      ARM: dts: prima: Align L2 cache-controller nodename with dtschema
      ARM: dts: qcom: Align L2 cache-controller nodename with dtschema
      ARM: dts: spear: Align L2 cache-controller nodename with dtschema
      ARM: dts: tango: Align L2 cache-controller nodename with dtschema
      ARM: dts: zx: Align L2 cache-controller nodename with dtschema
      ARM: dts: alpine: Align GIC nodename with dtschema
      arm64: dts: imx8mm-var-som-symphony: Use newer interrupts property
      arm64: dts: imx8mp-evk: Align pin configuration group names with schema
      arm64: dts: imx8mq: Add missing interrupts to GPC
      arm64: dts: imx8mq-librem5: Align regulator names with schema
      arm64: dts: imx8mq-librem5: Drop interrupt-names in PMIC
      arm64: dts: imx8mq-librem5: Add interrupt-names to ti,tps6598x
      arm64: dts: imx8mm-var-som-symphony: Drop unused gpioledgrp
      ARM: dts: exynos: Align OPP table name with dt-schema
      arm64: dts: exynos: Align OPP table name with dt-schema
      ARM: dts: s5pv210: move fixed regulators under root node in Aquila
      ARM: dts: s5pv210: move fixed regulators under root node in Goni
      ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in Aquila
      ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in Goni
      arm64: dts: zynqmp-zcu100-revC: correct interrupt flags
      arm64: dts: mediatek: fix tca6416 reset GPIOs in pumpkin
      dt-bindings: arm: fsl: Fix matching Purism Librem5 phones
      arm64: dts: imx8mm-var-som-symphony: Remove unneeded i2c3 properties
      arm64: dts: imx8mm-var-som-symphony: Adjust ethernet pin configuration
      arm64: dts: imx8mn-ddr4-evk: Remove unneeded PMIC pin configuration
      ARM: dts: imx6q: align GPIO hog names with dtschema
      ARM: dts: imx6qdl-gw5xxx: correct interrupt flags
      dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MN
      arm64: dts: imx8mn-var-som: Add Variscite VAR-SOM-MX8MN System on Module
      arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN
      arm64: dts: imx8mm-var-som-symphony: fix ptn5150 interrupts
      arm64: dts: imx8mm: correct interrupt flags
      arm64: dts: imx8mn: correct interrupt flags
      arm64: dts: imx8mq: correct interrupt flags
      arm64: dts: imx8mm-var-som-symphony: Drop wake-up source from RTC
      arm64: dts: imx8mq-librem5: correct GPIO hog property
      ARM: dts: am335x: lxm: fix PCA9539 GPIO expander properties
      ARM: dts: am335x: t335: align GPIO hog names with dtschema
      ARM: dts: am3874: iceboard: fix GPIO expander reset GPIOs
      arm64: dts: ti: k3-j721e-common-proc-board: align GPIO hog names with dtschema
      ARM: dts: picoxcell: build DTBs with make dtbs
      ARM: dts: picoxcell: drop unused reg-io-width from DW APB GPIO controller
      arm64: dts: apm: drop unused reg-io-width from DW APB GPIO controller
      arm64: dts: apm: add required gpio-cells to DW APB GPIO controller port
      arm64: dts: xilinx: align GPIO hog names with dtschema

Kuninori Morimoto (7):
      arm64: dts: renesas: r8a77961: Enable Sound / Audio-DMAC
      arm64: dts: renesas: r8a77961: Add FCP device nodes
      arm64: dts: renesas: r8a77961: Add VSP device nodes
      arm64: dts: renesas: r8a77961: Add DU device nodes
      arm64: dts: renesas: r8a77961: Add HDMI device nodes
      arm64: dts: renesas: r8a77961: salvator-xs: Add HDMI Display support
      arm64: dts: renesas: r8a77961: salvator-xs: Add HDMI Sound support

Lad Prabhakar (36):
      arm64: dts: renesas: r8a774e1: Add PCIe device nodes
      arm64: dts: renesas: r8a774e1: Add SATA controller node
      arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host (EHCI/OHCI) device nodes
      arm64: dts: renesas: r8a774e1: Add USB3.0 device nodes
      arm64: dts: renesas: r8a774e1: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774e1: Add audio support
      arm64: dts: renesas: r8a774e1: Add VIN and CSI-2 nodes
      ARM: dts: r8a7742-iwg21d-q7: Enable HSUSB, USB2.0 and xHCI
      ARM: dts: r8a7742-iwg21d-q7: Enable cmt0
      ARM: dts: r8a7742: Add PWM SoC support
      ARM: dts: r8a7742: Add TPU support
      ARM: dts: r8a7742: Add DU support
      ARM: dts: r8a7742: Add LVDS support
      arm64: dts: renesas: r8a774b1-hihope-rzg2n-ex: Enable sata
      ARM: dts: r8a7742: Add PCIe Controller device node
      arm64: dts: renesas: r8a774e1-hihope-rzg2h: Setup DU clocks
      ARM: dts: r8a7742: Add QSPI support
      arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
      arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
      arm64: dts: renesas: r8a774c0: Add PCIe EP node
      ARM: dts: r8a7742: Add CAN support
      ARM: dts: r8a7742-iwg21m: Sort the nodes alphabetically
      ARM: dts: r8a7742-iwg21m: Add RTC support
      ARM: dts: r8a7742-iwg21m: Add SPI NOR support
      ARM: dts: r8a7742: Add IPMMU DT nodes
      ARM: dts: r8a7742-iwg21d-q7: Enable PCIe Controller
      arm64: dts: renesas: r8a774e1: Add cpuidle support for CA5x cores
      arm64: dts: renesas: Add HiHope RZ/G2H board with idk-1110wr display
      arm64: dts: renesas: r8a774e1: Add PCIe EP nodes
      arm64: dts: renesas: r8a774e1-hihope-rzg2h-ex: Enable sata
      ARM: dts: r8a7742: Add VIN DT nodes
      ARM: dts: r8a7742-iwg21d-q7: Add SPI NOR support
      ARM: dts: r8a7742-iwg21d-q7: Add can1 support to carrier board
      ARM: dts: r8a7742-iwg21d-q7: Enable SD2 LED indication
      ARM: dts: r8a7742: Add VSP support
      ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add can0 support to camera DB

Lars Povlsen (6):
      arm64: dts: sparx5: Add Sparx5 eMMC support
      arm64: dts: sparx5: Add hwmon temperature sensor
      MAINTAINERS: Add git tree for Sparx5
      arm64: dts: sparx5: Add SPI controller and associated mmio-mux
      arm64: dts: sparx5: Add spi-nor support
      arm64: dts: sparx5: Add spi-nand devices

Linus Walleij (2):
      ARM: dts: ux500-golden: Add S6E63M0 DSI display
      ARM: dts: ux500-skomer: Add KTD253 backlight

Lokesh Vutla (5):
      arm64: dts: ti: Makefile: Use ARCH_K3 for building dtbs
      dt-bindings: arm: ti: Convert K3 board/soc bindings to DT schema
      dt-bindings: arm: ti: Add bindings for J7200 SoC
      arm64: dts: ti: Add support for J7200 SoC
      arm64: dts: ti: Add support for J7200 Common Processor Board

Manivannan Sadhasivam (6):
      dt-bindings: arm: qcom: Document SM8250 SoC and boards
      arm64: dts: qcom: sm8250: Rename UART2 node to UART12
      arm64: dts: qcom: Add basic devicetree support for QRB5165 RB5
      arm64: dts: qcom: qrb5165-rb5: Add onboard LED support
      arm64: dts: qcom: qrb5165-rb5: Add gpio-line-names for TLMM block
      arm64: dts: qcom: qrb5165-rb5: Add gpio-line-names for PM8150(B&L)

Marcin Sloniewski (3):
      dt-bindings: vendor-prefixes: add Seeed Studio
      dt-bindings: arm: stm32: document Odyssey compatible
      ARM: dts: stm32: add initial support for stm32mp157-odyssey board

Marco Felsch (2):
      ARM: dts: imx6qdl: move iomuxc compatible assignment out of root node
      ARM: dts: imx6qdl: add enet_out clk support

Marek Vasut (10):
      ARM: dts: stm32: Move ethernet PHY into DH SoM DT
      ARM: dts: stm32: Add DHSOM based DRC02 board
      ARM: dts: stm32: Fix sdmmc2 pins on AV96
      ARM: dts: stm32: Add USB OTG support to DH PDK2
      ARM: dts: stm32: Add STM32MP1 UART8 RTS/CTS pinmux
      ARM: dts: stm32: Drop QSPI CS2 pinmux on DHCOM
      ARM: dts: stm32: Enable RTS/CTS for DH PDK2 UART8
      ARM: dts: stm32: Swap PHY reset GPIO and TSC2004 IRQ on DHCOM SOM
      ARM: dts: stm32: Enable RTS/CTS for DH AV96 UART7
      ARM: dts: stm32: Fix DH PDK2 display PWM channel

Marian-Cristian Rotariu (7):
      arm64: dts: renesas: r8a774e1: Add FCPF and FCPV instances
      arm64: dts: renesas: r8a774e1: Add VSP instances
      arm64: dts: renesas: r8a774e1: Populate DU device node
      arm64: dts: renesas: r8a774e1: Populate HDMI encoder node
      arm64: dts: renesas: r8a774e1: Add LVDS device node
      arm64: dts: renesas: r8a774e1: Add PWM device nodes
      arm64: dts: renesas: r8a774e1: Add FDP1 device nodes

Markus Niebel (1):
      ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM

Martin Blumenstingl (2):
      ARM: dts: meson: move the L2 cache-controller inside the SoC node
      ARM: dts: meson8: remove two invalid interrupt lines from the GPU node

Martin Cerveny (3):
      dt-bindings: crypto: Add compatible for V3s
      ARM: dts: sun8i: v3s: Enable crypto engine
      ARM: dts: sun8i: v3s: Add simple-framebuffer

Martin Kepplinger (1):
      dt-bindings: arm: fsl: Add the librem 5 phone

Matheus Castello (3):
      ARM: dts: Add Caninos Loucos Labrador v2
      dt-bindings: Add vendor prefix for Caninos Loucos
      dt-bindings: arm: actions: Document Caninos Loucos Labrador

Matthias Kaehlcke (1):
      arm64: dts: qcom: sc7180: Add 'sustainable_power' for CPU thermal zones

Matthias Schiffer (4):
      ARM: dts: imx7: add QSPI
      ARM: dts: imx6qdl-tqma6: fix indentation
      ARM: dts: imx6qdl-tqma6: remove obsolete fsl,spi-num-chipselects
      ARM: dts: imx6qdl-tqma6: fix LM75 compatible string

Maxime Ripard (1):
      ARM: dts: bcm2711: Enable the display pipeline

Michael Walle (4):
      arm64: dts: freescale: sl28: enable sl28cpld
      arm64: dts: freescale: sl28: map GPIOs to input events
      arm64: dts: freescale: sl28: enable LED support
      arm64: dts: freescale: sl28: enable fan support

Michal Simek (4):
      arm64: dts: zynqmp: Rename buses to be align with simple-bus yaml
      arm64: dts: zynqmp: Remove additional compatible string for i2c IPs
      arm64: dts: zynqmp: Remove undocumented u-boot properties
      arm64: dts: zynqmp: Fix leds subnode name for zcu100/ultra96 v1

Michal Vokáč (4):
      ARM: dts: imx6dl-yapp4: Add ethernet aliases
      dt-bindings: arm: fsl: Add Y Soft IOTA Orion board
      ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Orion board
      ARM: dts: imx6dl-yapp4: Add support for OLED based on different controller

Nishanth Menon (9):
      arm64: dts: ti: k3-j721e: Use lower case hexadecimal
      arm64: dts: ti: k3-am65-main: Use lower case hexadecimal
      arm64: dts: ti: k3-am65*: Use generic gpio for node names
      arm64: dts: ti: k3-am65*: Use generic clock for syscon clock names
      arm64: dts: ti: k3-*: Use generic pinctrl for node names
      arm64: dts: ti: k3-am65-base-board Use generic camera for node name instead of ov5640
      arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for node name
      arm64: dts: ti: k3-*: Fix up node_name_chars_strict warnings
      Merge tag 'ti-k3-dt-fixes-for-v5.9' into ti-k3-dts-next

Nobuhiro Iwamatsu (6):
      dt-bindings: arm: toshiba: add Toshiba Visconti ARM SoCs
      dt-bindings: arm: toshiba: Add the TMPV7708 RM main board
      arm64: visconti: Add initial support for Toshiba Visconti platform
      arm64: dts: visconti: Add device tree for TMPV7708 RM main board
      MAINTAINERS: Add information for Toshiba Visconti ARM SoCs
      arm64: defconfig: Enable configs for Toshiba Visconti

Olof Johansson (46):
      Merge tag 'omap-for-v5.10/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.10-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'samsung-dt-5.10' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.10' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'juno-updates-5.10' of git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'aspeed-5.10-devicetree' of git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'dt64-schema-5.10' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'dt-schema-5.10' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'arm-soc/for-5.10/devicetree' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'arm-soc/for-5.10/devicetree-arm64' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.10' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'hisi-arm32-dt-for-5.10' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'sparx5-dt-5.10' of https://github.com/microchip-ung/linux-upstream into arm/dt
      Merge tag 'ux500-dts-for-v5.10' of git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'socfpga_dts_update_for_v5.10' of git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'at91-dt-5.10' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.10-tag2' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.10-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'tegra-for-5.10-dt-bindings' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.10-arm64-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'samsung-dt-5.10-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'samsung-dt64-5.10-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'ti-k3-dt-for-v5.10' of git://git.kernel.org/.../nmenon/linux into arm/dt
      Merge tag 'imx-bindings-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'v5.10-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'qcom-arm64-for-5.10' of https://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'stm32-dt-for-v5.10-1' of git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'v5.9-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'v5.9-next-dts32' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'tegra-for-5.10-arm-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'ti-k3-dt-for-v5.10-part2' of git://git.kernel.org/.../nmenon/linux into arm/dt
      Merge tag 'amlogic-dt-2' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'sunxi-dt-for-5.10-1' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'actions-bindings-for-v5.10' of git://git.kernel.org/.../mani/linux-actions into arm/dt
      Merge tag 'actions-arm-dt-for-v5.10' of git://git.kernel.org/.../mani/linux-actions into arm/dt
      Merge tag 'actions-arm64-dt-for-v5.10' of git://git.kernel.org/.../mani/linux-actions into arm/dt
      Merge tag 'v5.10-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'sunxi-dt-for-5.10-2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'zynqmp-dt-for-v5.10' of https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'omap-for-v5.10/dt-part2-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'hisi-arm32-dt-for-5.10-tag2' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'visconti-initial-for-5.10-tag2' of git://git.kernel.org/.../iwamatsu/linux-visconti into arm/dt

Peter Chen (2):
      arm64: dts: imx8mm-evk: add two parameters for samsung picophy tuning
      arm64: dts: imx8mn-evk: add two parameters for samsung picophy tuning

Peter Ujfalusi (1):
      arm64: dts: ti: k3-j7200: add DMA support

Pradeep P V K (1):
      arm64: dts: qcom: sc7180: Add bandwidth votes for eMMC and SDcard

Rajendra Nayak (2):
      arm64: dts: qcom: sdm845: Add OPP tables and power-domains for venus
      arm64: dts: qcom: sc7180: Add OPP tables and power-domains for venus

Reto Schneider (2):
      dt-bindings: arm: at91: Add GARDENA smart Gateway (Art. 19000) board
      ARM: at91: Add GARDENA smart Gateway (Art. 19000) support

Richard Gong (1):
      arm64: dts: agilex: increase shared memory size to 32Mb

Richard Zhu (1):
      ARM: dts: imx6qp-sabreauto: enable pcie

Rob Clark (1):
      arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt

Robert Foss (1):
      arm64: dts: qcom: msm8996: Add VFE1_GDSC power domain to camss node

Roger Quadros (5):
      dt-bindings: ti-serdes-mux: Add defines for J7200 SoC
      arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
      arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
      arm64: dts: ti: k3-j7200-main: Add USB controller
      arm64: dts: ti: k3-j7200-common-proc-board: Add USB support

Ryder Lee (1):
      arm: dts: mt7623: add display subsystem related device nodes

Sai Prakash Ranjan (1):
      arm64: dts: qcom: sc7180: Fix the LLCC base register size

Sakari Ailus (1):
      ARM: dts: n9, n950: Remove nokia,nvm-size property

Sameer Pujar (2):
      arm64: tegra: Enable ACONNECT, ADMA and AGIC on Jetson Nano
      arm64: tegra: Add DT binding for AHUB components

Samuel Holland (4):
      arm64: dts: allwinner: Mark timer as stopped in suspend
      ARM: dts: sun8i: a33: Update codec widget names
      arm64: dts: allwinner: a64: Update codec widget names
      arm64: dts: allwinner: a64: Update the audio codec compatible

Sebastian Reichel (4):
      ARM: dts: omap: add channel to DSI panels
      ARM: dts: omap4-droid4: add panel compatible
      ARM: dts: omap4-droid4: add panel orientation
      ARM: dts: imx6q-bx50v3: Add IRQ support for internal switch

Sekhar Nori (1):
      arm64: dts: ti: k3-am65: restrict PCIe to Gen2 speed

Shengjiu Wang (5):
      ARM: dts: imx7d-sdb: Add nodes for audio sound card
      ARM: dts: imx6qdl-sabresd: Support headphone and microphone detection
      ARM: dts: imx6sx-sdb: Add headphone detection for sound card
      ARM: dts: imx6sl-evk: Add headphone detection for sound card
      ARM: dts: imx6sll-evk: Add audio sound card node

Sibi Sankar (3):
      arm64: dts: qcom: sc7180: Increase the number of interconnect cells
      arm64: dts: qcom: sm8150: Add OSM L3 interconnect provider
      arm64: dts: qcom: sm8250: Add EPSS L3 interconnect provider

Simon Shields (1):
      ARM: dts: exynos: Add sound support to Midas

Stefan Monnier (1):
      ARM: dts: sun4i: Enable HDMI support on the Mele A1000

Stefan Riedmueller (2):
      dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL devicetree bindings
      dt-bindings: arm: fsl: Add PHYTEC i.MX6 devicetree bindings

Stephan Gerhold (24):
      arm64: dts: qcom: apq8016-sbc: Remove properties that are already default
      arm64: dts: qcom: msm8916: Declare sound node in msm8916.dtsi
      arm64: dts: qcom: apq8016-sbc: Define leds outside of soc node
      arm64: dts: qcom: msm8916: Add more labels
      arm64: dts: qcom: msm8916: Use labels in board device trees
      arm64: dts: qcom: pm8916: Add resin node
      arm64: dts: qcom: msm8916: Move PM8916-specific parts to msm8916-pm8916.dtsi
      arm64: dts: qcom: msm8916: Move more supplies to msm8916-pm8916.dtsi
      arm64: dts: qcom: msm8916: Set default pinctrl for blsp1_uart1/2
      arm64: dts: qcom: msm8916: Move common USB properties to msm8916.dtsi
      arm64: dts: qcom: msm8916: Configure DSI port with labels
      arm64: dts: qcom: msm8916: Remove one more thermal trip point unit name
      arm64: dts: qcom: pm8916: Remove invalid reg size from wcd_codec
      arm64: dts: qcom: msm8916: Fix MDP/DSI interrupts
      arm64: dts: qcom: msm8916: Use IRQ defines, add IRQ types
      arm64: dts: qcom: msm8916: Drop qcom,tcsr-mutex syscon
      arm64: dts: qcom: msm8916: Minor style fixes
      arm64: dts: qcom: msm8916: Add MSM8916-specific compatibles to SCM/MSS
      arm64: dts: qcom: msm8916: Use more generic node names
      arm64: dts: qcom: msm8916: Rename "x-smp2p" to "smp2p-x"
      arm64: dts: qcom: msm8916: Pad addresses
      arm64: dts: qcom: msm8916: Sort nodes
      arm64: dts: qcom: pm8916: Sort nodes
      arm64: dts: qcom: Makefile: Sort lines

Stephen Boyd (2):
      arm64: dts: qcom: sc7180: Drop flags on mdss irqs
      arm64: dts: qcom: trogdor: Add labels for type-c ports

Suman Anna (10):
      arm64: dts: ti: k3-am65: Fix interconnect node names
      arm64: dts: ti: k3-j721e: Fix interconnect node names
      arm64: dts: ti: k3-j721e-som-p0: Move mailbox nodes from board dts file
      arm64: dts: ti: k3-j721e-main: Add C66x DSP nodes
      arm64: dts: ti: k3-j721e-som-p0: Add mailboxes to C66x DSPs
      arm64: dts: ti: k3-j721e-som-p0: Add DDR carveout memory nodes for C66 DSPs
      arm64: dts: ti: k3-j721e-main: Add C71x DSP node
      arm64: dts: ti: k3-j721e-som-p0: Add mailboxes to C71x DSP
      arm64: dts: ti: k3-j721e-som-p0: Add DDR carveout memory nodes for C71x DSP
      arm64: dts: ti: k3-j721e-som-p0: Reserve memory for IPC between RTOS cores

Sylwester Nawrocki (1):
      ARM: dts: samsung: odroid-xu3: Move assigned-clock* properties to i2s0 node

Taniya Das (1):
      arm64: dts: qcom: sc7180: Add LPASS clock controller nodes

Tanmay Shah (1):
      arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node

Tao Ren (7):
      ARM: dts: aspeed: Remove flash layout from Facebook AST2500 Common dtsi
      ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
      ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
      ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
      ARM: dts: aspeed: Add Facebook Wedge400 BMC
      ARM: dts: aspeed: wedge40: Update FMC flash0 label
      ARM: dts: aspeed: wedge40: Update UART4 pin settings

Thierry Reding (21):
      arm64: tegra: Add ID EEPROMs on Jetson AGX Xavier
      arm64: tegra: Wire up pinctrl states for all DPAUX controllers
      arm64: tegra: Add VBUS supply for micro USB port on Jetson Nano
      arm64: tegra: Disable SD card write-protection on Jetson Nano
      arm64: tegra: Describe display controller outputs for Tegra210
      arm64: tegra: Use valid PWM period for VDD_GPU on Tegra210
      arm64: tegra: Properly size register regions for GPU on Tegra194
      dt-bindings: misc: tegra-apbmisc: Add missing compatible strings
      dt-bindings: misc: tegra186-misc: Add missing compatible string
      dt-bindings: misc: tegra186-misc: Add Tegra234 support
      dt-bindings: tegra: Add Tegra234 VDK compatible
      dt-bindings: fuse: tegra: Add Tegra234 support
      dt-bindings: tegra: pmc: Add Tegra234 support
      Merge branch 'for-5.10/dt-bindings' into for-5.10/arm/dt
      dt-bindings: misc: tegra-apbmisc: Add missing compatible strings
      dt-bindings: misc: tegra186-misc: Add missing compatible string
      dt-bindings: misc: tegra186-misc: Add Tegra234 support
      dt-bindings: tegra: Add Tegra234 VDK compatible
      dt-bindings: fuse: tegra: Add Tegra234 support
      dt-bindings: tegra: pmc: Add Tegra234 support
      arm64: tegra: Initial Tegra234 VDK support

Tobias Schramm (3):
      ARM: dts: stm32: add display controller node to stm32h743
      ARM: dts: stm32: add resets property to spi device nodes on stm32h743
      ARM: dts: stm32: use stm32h7 usart compatible string for stm32h743

Tony Lindgren (3):
      ARM: dts: omap4: Fix sgx clock rate for 4430
      Merge branch 'omap-for-v5.10/dt-moxa' into omap-for-v5.10/dt
      Merge branch 'fixes' into omap-for-v5.10/dt

Uwe Kleine-König (2):
      ARM: dts: imx25-pinfunc: add missing and fix wrong SPI related defintions
      ARM: dts: imx25-pinfunc: Fix GPT function names

Vabhav Sharma (1):
      arm64: dts: ls1028a: qds: enable lpuart1

Venkata Lakshmi Narayana Gubba (1):
      arm64: dts: qcom: sc7180: Remove clock for bluetooth on SC7180 IDP board

Vignesh Raghavendra (4):
      arm64: dts: ti: k3-j7200: Add I2C nodes
      arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
      arm64: dts: ti: k3-j7200-mcu-wakeup: Add HyperBus node
      arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node

Vinod Koul (1):
      arm64: dts: qcom: sdm845-db845c: Fix hdmi nodes

Wasim Khan (1):
      arm64: dts: layerscape: Add label to pcie nodes

Xia Jiang (1):
      arm: dts: mt2701: Add jpeg enc device tree node

Yangtao Li (5):
      dt-bindings: irq: sun7i-nmi: fix dt-binding for a80 nmi
      dt-bindings: irq: sun7i-nmi: Add binding for A100's NMI controller
      arm64: allwinner: A100: add the basical Allwinner A100 DTSI file
      dt-bindings: arm: sunxi: Add Allwinner A100 Perf1 Board bindings
      arm64: allwinner: A100: add support for Allwinner Perf1 board

Yoshihiro Shimoda (7):
      arm64: dts: renesas: ulcb: add full-pwr-cycle-in-suspend into eMMC nodes
      dt-bindings: arm: renesas: Document R-Car V3U SoC DT bindings
      dt-bindings: power: renesas,rcar-sysc: Document r8a779a0 SYSC bindings
      dt-bindings: reset: renesas,rst: Document r8a779a0 reset module
      dt-bindings: arm: renesas: Document Renesas Falcon boards
      arm64: dts: renesas: Add Renesas R8A779A0 SoC support
      arm64: dts: renesas: Add Renesas Falcon boards support

Yuantian Tang (2):
      arm64: dts: ls1088a: add more thermal zone support
      arm64: dts: ls208xa: add more thermal zone support

Zhao Qiang (1):
      arm64: dts: layerscape: correct watchdog clocks for LS1088A

Zhen Lei (1):
      ARM: dts: hisilicon: fix the system controller compatible nodes

satya priya (3):
      arm64: dts: qcom: sc7180: Improve the uart3 pin config for sc7180-idp
      arm64: dts: qcom: sc7180: Add wakeup support for BT UART on sc7180-idp
      arm64: dts: qcom: sc7180-trogdor: Add wakeup support for BT UART

Łukasz Patron (1):
      arm64: dts: qcom: pm660: Fix missing pound sign in interrupt-cells


 .../devicetree/bindings/arm/actions.yaml        |   11 +
 .../devicetree/bindings/arm/amlogic.yaml        |    2 +
 .../devicetree/bindings/arm/atmel-at91.yaml     |    1 +
 .../bindings/arm/bcm/brcm,bcm4708.yaml          |    2 +
 Documentation/devicetree/bindings/arm/fsl.yaml  |   95 +
 Documentation/devicetree/bindings/arm/qcom.yaml |   11 +
 .../devicetree/bindings/arm/renesas.yaml        |   12 +
 .../devicetree/bindings/arm/rockchip.yaml       |   16 +-
 .../devicetree/bindings/arm/samsung/pmu.yaml    |   24 +-
 .../devicetree/bindings/arm/stm32/stm32.yaml    |    6 +
 .../devicetree/bindings/arm/sunxi.yaml          |   10 +
 .../devicetree/bindings/arm/tegra.yaml          |    4 +
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt  |    3 +-
 Documentation/devicetree/bindings/arm/ti/k3.txt |   26 -
 .../devicetree/bindings/arm/ti/k3.yaml          |   35 +
 .../devicetree/bindings/arm/toshiba.yaml        |   22 +
 .../crypto/allwinner,sun4i-a10-crypto.yaml      |    6 +-
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml  |    9 +-
 .../bindings/fuse/nvidia,tegra20-fuse.txt       |    1 +
 .../bindings/gpu/arm,mali-utgard.yaml           |    2 +
 .../allwinner,sun7i-a20-sc-nmi.yaml             |    5 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml |    1 +
 .../bindings/media/allwinner,sun4i-a10-ir.yaml  |    5 +-
 .../bindings/misc/nvidia,tegra186-misc.txt      |    8 +-
 .../bindings/misc/nvidia,tegra20-apbmisc.txt    |   13 +-
 .../devicetree/bindings/nvmem/vf610-ocotp.txt   |    4 +-
 .../bindings/power/renesas,rcar-sysc.yaml       |    1 +
 .../devicetree/bindings/reset/renesas,rst.yaml  |    1 +
 .../allwinner,sun4i-a10-system-control.yaml     |    6 +
 .../devicetree/bindings/vendor-prefixes.yaml    |    8 +
 MAINTAINERS                                     |   18 +-
 arch/arm/boot/dts/Makefile                      |   25 +-
 arch/arm/boot/dts/alpine.dtsi                   |    2 +-
 arch/arm/boot/dts/am335x-lxm.dts                |    4 +
 .../boot/dts/am335x-moxa-uc-8100-common.dtsi    |  427 +++
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |  404 +--
 arch/arm/boot/dts/am335x-sbc-t335.dts           |    4 +-
 arch/arm/boot/dts/am33xx.dtsi                   |    2 +-
 arch/arm/boot/dts/am3517-evm-ui.dtsi            |    4 +-
 arch/arm/boot/dts/am3517-evm.dts                |    2 +-
 arch/arm/boot/dts/am3874-iceboard.dts           |    8 +-
 arch/arm/boot/dts/am4372.dtsi                   |    4 +-
 arch/arm/boot/dts/am437x-cm-t43.dts             |   14 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |   15 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |   13 +-
 arch/arm/boot/dts/am437x-l4.dtsi                |   77 +-
 arch/arm/boot/dts/am437x-sbc-t43.dts            |    2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |   14 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |   15 +-
 arch/arm/boot/dts/am571x-idk.dts                |   27 -
 arch/arm/boot/dts/am5729-beagleboneai.dts       |   14 +-
 arch/arm/boot/dts/am572x-idk.dts                |    5 -
 arch/arm/boot/dts/am574x-idk.dts                |    5 -
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   19 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts       |   13 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   14 +-
 arch/arm/boot/dts/am57xx-sbc-am57x.dts          |    4 +-
 arch/arm/boot/dts/animeo_ip.dts                 |    3 +-
 arch/arm/boot/dts/arm-realview-eb.dtsi          |    2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts       |   20 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi         |    4 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |   17 +
 .../boot/dts/aspeed-bmc-facebook-minipack.dts   |   47 +-
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts    |    5 +-
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts   |  420 +++
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts  |   17 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts    |   23 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts     |  662 +++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts     |    7 +
 arch/arm/boot/dts/aspeed-g5.dtsi                |    1 -
 .../dts/ast2500-facebook-netbmc-common.dtsi     |   13 -
 arch/arm/boot/dts/at91-ariag25.dts              |    3 +-
 arch/arm/boot/dts/at91-ariettag25.dts           |    3 +-
 arch/arm/boot/dts/at91-cosino.dtsi              |    3 +-
 arch/arm/boot/dts/at91-cosino_mega2560.dts      |    1 +
 arch/arm/boot/dts/at91-foxg20.dts               |    3 +-
 arch/arm/boot/dts/at91-kizbox.dts               |    2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi      |    2 +-
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi   |    2 +-
 arch/arm/boot/dts/at91-linea.dtsi               |    2 +-
 arch/arm/boot/dts/at91-qil_a9260.dts            |    3 +-
 arch/arm/boot/dts/at91-sam9_l9260.dts           |    3 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |    2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi       |    2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts     |    2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |    2 +-
 arch/arm/boot/dts/at91-som60.dtsi               |    2 +-
 arch/arm/boot/dts/at91-vinco.dts                |    2 +-
 arch/arm/boot/dts/at91-wb45n.dtsi               |    3 +-
 arch/arm/boot/dts/at91-wb50n.dtsi               |    2 +-
 arch/arm/boot/dts/at91rm9200.dtsi               |   11 +-
 arch/arm/boot/dts/at91rm9200ek.dts              |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |   11 +-
 arch/arm/boot/dts/at91sam9260ek.dts             |    3 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |   10 +-
 arch/arm/boot/dts/at91sam9261ek.dts             |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |   15 +-
 arch/arm/boot/dts/at91sam9263ek.dts             |    3 +-
 arch/arm/boot/dts/at91sam9g20.dtsi              |    5 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi     |    3 +-
 .../dts/at91sam9g25-gardena-smart-gateway.dts   |  158 ++
 arch/arm/boot/dts/at91sam9g45.dtsi              |   12 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts          |    4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi              |   10 +-
 arch/arm/boot/dts/at91sam9n12ek.dts             |    2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |   10 +-
 arch/arm/boot/dts/at91sam9rlek.dts              |    2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |   12 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi             |    2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |    2 +
 arch/arm/boot/dts/at91sam9xe.dtsi               |    3 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               |    4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                  |    6 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts           |   48 +
 arch/arm/boot/dts/bcm2711.dtsi                  |  122 +-
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts      |  197 ++
 arch/arm/boot/dts/bcm5301x.dtsi                 |   25 +-
 arch/arm/boot/dts/bcm958525xmc.dts              |    2 +-
 arch/arm/boot/dts/bcm958625k.dts                |    2 +-
 arch/arm/boot/dts/dra7-evm.dts                  |   15 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  |   54 -
 arch/arm/boot/dts/dra7.dtsi                     |    4 +-
 arch/arm/boot/dts/dra71-evm.dts                 |   14 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   10 +-
 arch/arm/boot/dts/dra72-evm-revc.dts            |   14 +-
 arch/arm/boot/dts/dra72-evm.dts                 |   13 +-
 arch/arm/boot/dts/dra76-evm.dts                 |   18 +-
 arch/arm/boot/dts/emev2.dtsi                    |    2 +-
 arch/arm/boot/dts/ethernut5.dts                 |    2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi        |    4 +
 arch/arm/boot/dts/exynos3250-monk.dts           |    6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    6 +-
 arch/arm/boot/dts/exynos3250.dtsi               |   44 +-
 arch/arm/boot/dts/exynos4210-i9100.dts          |   56 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |   27 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   25 +
 arch/arm/boot/dts/exynos4210-trats.dts          |  186 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   36 +-
 arch/arm/boot/dts/exynos4210.dtsi               |   38 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi     |   42 +-
 arch/arm/boot/dts/exynos4412-i9300.dts          |    6 +-
 arch/arm/boot/dts/exynos4412-i9305.dts          |    2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi         |  116 +-
 arch/arm/boot/dts/exynos4412-n710x.dts          |   39 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   35 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |   46 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |   25 +
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |   27 +
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   24 +
 arch/arm/boot/dts/exynos4412-trats2.dts         |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi               |   18 +-
 arch/arm/boot/dts/exynos5.dtsi                  |   10 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |   20 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   16 +-
 arch/arm/boot/dts/exynos5250-spring.dts         |   41 +-
 arch/arm/boot/dts/exynos5250.dtsi               |   54 +-
 arch/arm/boot/dts/exynos5260.dtsi               |    4 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |    8 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |   12 +
 arch/arm/boot/dts/exynos5410.dtsi               |   12 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    3 +
 arch/arm/boot/dts/exynos5420.dtsi               |   16 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |    4 +-
 .../boot/dts/exynos5422-odroidxu3-audio.dtsi    |   60 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      |   60 +-
 arch/arm/boot/dts/hi3620.dtsi                   |   32 +-
 arch/arm/boot/dts/hip04.dtsi                    |    6 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi               |    5 +-
 arch/arm/boot/dts/imx23-evk.dts                 |    2 +-
 arch/arm/boot/dts/imx23.dtsi                    |    2 +-
 arch/arm/boot/dts/imx25-pinfunc.h               |   28 +-
 .../boot/dts/imx27-phytec-phycard-s-som.dtsi    |    4 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  |    2 +-
 arch/arm/boot/dts/imx27.dtsi                    |    2 +-
 arch/arm/boot/dts/imx28-apf28.dts               |    2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts          |    2 +-
 arch/arm/boot/dts/imx28-evk.dts                 |    2 +-
 arch/arm/boot/dts/imx28-m28.dtsi                |    2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts              |    2 +-
 arch/arm/boot/dts/imx28.dtsi                    |    2 +-
 arch/arm/boot/dts/imx50-evk.dts                 |    2 +-
 arch/arm/boot/dts/imx51-apf51dev.dts            |    4 +-
 arch/arm/boot/dts/imx53-m53menlo.dts            |    2 +-
 arch/arm/boot/dts/imx53-smd.dts                 |    2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi             |    8 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi     |    3 +-
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi   |    3 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts     |    2 +-
 arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts   |    4 +-
 arch/arm/boot/dts/imx6dl-prtrvt.dts             |    4 +-
 arch/arm/boot/dts/imx6dl-prtvt7.dts             |    2 +-
 arch/arm/boot/dts/imx6dl-tqma6a.dtsi            |   16 +
 arch/arm/boot/dts/imx6dl-tqma6b.dtsi            |   16 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi      |   38 +-
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts        |    6 +-
 arch/arm/boot/dts/imx6dl-yapp4-orion.dts        |   54 +
 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts         |    4 +
 arch/arm/boot/dts/imx6dl.dtsi                   |    8 +-
 arch/arm/boot/dts/imx6q-b450v3.dts              |   14 +-
 arch/arm/boot/dts/imx6q-b650v3.dts              |   12 +-
 arch/arm/boot/dts/imx6q-b850v3.dts              |    4 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi               |    2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |   31 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts              |    2 +-
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi          |    2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts         |    2 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts            |    2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts            |    2 +-
 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi     |    7 +-
 arch/arm/boot/dts/imx6q-logicpd.dts             |    2 +-
 arch/arm/boot/dts/imx6q-prti6q.dts              |    6 +-
 arch/arm/boot/dts/imx6q-tqma6a.dtsi             |   16 +
 arch/arm/boot/dts/imx6q-tqma6b.dtsi             |   15 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts  |    4 +-
 arch/arm/boot/dts/imx6q.dtsi                    |    8 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |    4 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi     |    2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi    |   10 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi    |    2 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi            |    4 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi           |    3 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi    |    2 +-
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi   |    8 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi    |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi   |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |    2 +-
 arch/arm/boot/dts/imx6qdl-pico.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |    8 +-
 arch/arm/boot/dts/imx6qdl-tqma6.dtsi            |  201 ++
 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi           |   28 +
 arch/arm/boot/dts/imx6qdl-tqma6b.dtsi           |   28 +
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi           |    4 +-
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi           |    8 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |    2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |    5 +-
 arch/arm/boot/dts/imx6qp-sabreauto.dts          |    3 +-
 arch/arm/boot/dts/imx6qp-tqma6b.dtsi            |   16 +
 arch/arm/boot/dts/imx6sl-evk.dts                |   11 +-
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts    |  588 ++++
 arch/arm/boot/dts/imx6sl.dtsi                   |    2 +
 arch/arm/boot/dts/imx6sll-evk.dts               |   73 +
 arch/arm/boot/dts/imx6sll.dtsi                  |    7 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi               |    9 +
 .../arm/boot/dts/imx6sx-softing-vining-2000.dts |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |    2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi   |    2 +-
 .../dts/imx6ul-kontron-n6x1x-som-common.dtsi    |    2 +-
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi      |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |    2 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi          |    2 +-
 arch/arm/boot/dts/imx6ull.dtsi                  |    7 +
 arch/arm/boot/dts/imx7-colibri.dtsi             |    2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                 |   83 +-
 arch/arm/boot/dts/imx7d-zii-rmu2.dts            |    2 +-
 arch/arm/boot/dts/imx7d-zii-rpu2.dts            |    2 +-
 arch/arm/boot/dts/imx7s.dtsi                    |   15 +-
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi |    2 +-
 .../arm/boot/dts/logicpd-torpedo-baseboard.dtsi |    2 +-
 arch/arm/boot/dts/meson.dtsi                    |   14 +-
 arch/arm/boot/dts/meson8.dtsi                   |    2 -
 arch/arm/boot/dts/motorola-mapphone-common.dtsi |    6 +-
 arch/arm/boot/dts/mpa1600.dts                   |    2 +-
 arch/arm/boot/dts/mps2.dtsi                     |   10 +-
 ...=> mstar-infinity-msc313-breadbee_crust.dts} |    2 +-
 ...ssc8336n.dtsi => mstar-infinity-msc313.dtsi} |    2 +-
 .../dts/{infinity.dtsi => mstar-infinity.dtsi}  |    0
 ...dts => mstar-infinity3-msc313e-breadbee.dts} |    2 +-
 ...msc313.dtsi => mstar-infinity3-msc313e.dtsi} |    2 +-
 .../{infinity3.dtsi => mstar-infinity3.dtsi}    |    2 +-
 ...s => mstar-mercury5-ssc8336n-midrived08.dts} |    2 +-
 ...sc313e.dtsi => mstar-mercury5-ssc8336n.dtsi} |    2 +-
 .../dts/{mercury5.dtsi => mstar-mercury5.dtsi}  |    0
 arch/arm/boot/dts/mstar-v7.dtsi                 |   20 +
 arch/arm/boot/dts/mt2701.dtsi                   |   13 +
 arch/arm/boot/dts/mt7623.dtsi                   |  123 -
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts   |   88 +-
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts          |   74 +-
 arch/arm/boot/dts/mt7623n.dtsi                  |  306 ++
 arch/arm/boot/dts/nspire.dtsi                   |   12 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |    4 +-
 arch/arm/boot/dts/omap3-beagle.dts              |    6 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts            |    2 +-
 arch/arm/boot/dts/omap3-cm-t3530.dts            |    2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts            |    2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |    4 +-
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi        |   21 +
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |    4 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |    8 +-
 arch/arm/boot/dts/omap3-ha-lcd.dts              |    2 +-
 arch/arm/boot/dts/omap3-igep0020-common.dtsi    |    2 +-
 arch/arm/boot/dts/omap3-n9.dts                  |    1 -
 arch/arm/boot/dts/omap3-n900.dts                |    6 +-
 arch/arm/boot/dts/omap3-n950.dts                |    8 +-
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi   |    2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |    2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |    2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |    4 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |    2 +-
 arch/arm/boot/dts/omap3-thunder.dts             |    2 +-
 arch/arm/boot/dts/omap3.dtsi                    |    3 +
 arch/arm/boot/dts/omap34xx.dtsi                 |    3 +-
 arch/arm/boot/dts/omap36xx.dtsi                 |    3 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts      |    4 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       |    6 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   14 +-
 arch/arm/boot/dts/omap4.dtsi                    |    8 +-
 arch/arm/boot/dts/omap443x.dtsi                 |   10 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |    4 +-
 arch/arm/boot/dts/omap5-cm-t54.dts              |    6 +-
 arch/arm/boot/dts/owl-s500-labrador-base-m.dts  |   35 +
 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi     |   22 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts      |   47 +
 arch/arm/boot/dts/owl-s500.dtsi                 |    6 +-
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi          |    1 -
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi          |    1 -
 arch/arm/boot/dts/pm9g45.dts                    |    3 +-
 arch/arm/boot/dts/prima2.dtsi                   |    2 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi             |    2 +-
 arch/arm/boot/dts/r7s72100.dtsi                 |    2 +-
 arch/arm/boot/dts/r7s9210.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts |   11 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts         |  120 +
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi           |   79 +-
 arch/arm/boot/dts/r8a7742.dtsi                  |  337 ++-
 arch/arm/boot/dts/r8a7743.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7744.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts     |  112 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a77470.dtsi                 |    2 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |    2 +-
 arch/arm/boot/dts/r9a06g032.dtsi                |    2 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |    6 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts         |    6 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts          |    6 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |    2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |    2 +-
 .../boot/dts/rk3288-firefly-reload-core.dtsi    |    2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           |    2 +-
 arch/arm/boot/dts/rk3288-miqi.dts               |   16 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           |   16 +-
 arch/arm/boot/dts/rk3288-r89.dts                |   16 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       |    2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi            |    2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts              |   14 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |   17 +-
 arch/arm/boot/dts/s3c2416.dtsi                  |  111 +-
 arch/arm/boot/dts/s3c24xx.dtsi                  |   24 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts          |   32 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts          |   32 +-
 arch/arm/boot/dts/s3c64xx.dtsi                  |    2 +-
 arch/arm/boot/dts/s5pv210-aquila.dts            |   73 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi            |   26 +-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts       |   98 +
 arch/arm/boot/dts/s5pv210-galaxys.dts           |   85 +
 arch/arm/boot/dts/s5pv210-goni.dts              |   97 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts          |    9 +
 arch/arm/boot/dts/s5pv210-smdkv210.dts          |   14 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts          |    9 +
 arch/arm/boot/dts/s5pv210.dtsi                  |  163 +-
 arch/arm/boot/dts/sam9x60.dtsi                  |   10 +-
 arch/arm/boot/dts/sama5d2.dtsi                  |   19 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |    8 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi               |    2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi           |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |    8 +-
 arch/arm/boot/dts/sd5203.dts                    |   96 +
 arch/arm/boot/dts/sh73a0.dtsi                   |    2 +-
 arch/arm/boot/dts/spear13xx.dtsi                |    2 +-
 arch/arm/boot/dts/ste-href.dtsi                 |   22 +-
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts  |   91 +
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts  |   15 +-
 arch/arm/boot/dts/stm32h743.dtsi                |   20 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi        |   26 +
 arch/arm/boot/dts/stm32mp151.dtsi               |   50 +-
 arch/arm/boot/dts/stm32mp153.dtsi               |    6 +
 arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dts   |   35 +
 arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts    |    4 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |   16 +-
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts       |    3 +-
 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi  |  276 ++
 arch/arm/boot/dts/stm32mp157c-odyssey.dts       |   80 +
 arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi  |  157 ++
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi   |   45 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi    |   42 +-
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi   |    7 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |   25 +
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts       |    4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                |    4 +-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts    |    4 +
 arch/arm/boot/dts/sun8i-r40.dtsi                |  104 +
 arch/arm/boot/dts/sun8i-s3-pinecube.dts         |  235 ++
 arch/arm/boot/dts/sun8i-v3.dtsi                 |   13 +
 arch/arm/boot/dts/sun8i-v3s.dtsi                |  118 +
 arch/arm/boot/dts/tango4-common.dtsi            |    2 +-
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts |   30 +-
 .../dts/tegra30-asus-nexus7-grouper-common.dtsi |   54 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi         |    2 +-
 arch/arm/boot/dts/tny_a9263.dts                 |    2 +-
 arch/arm/boot/dts/usb_a9260.dts                 |    2 +-
 arch/arm/boot/dts/usb_a9263.dts                 |    2 +-
 arch/arm/boot/dts/usb_a9g20_common.dtsi         |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |    2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi             |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts     |    4 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts      |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts          |    6 +-
 arch/arm/boot/dts/vf610-zii-cfu1.dts            |    3 +-
 arch/arm/boot/dts/vf610-zii-spb4.dts            |    2 -
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts        |    2 -
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts       |    2 -
 arch/arm/boot/dts/zx296702.dtsi                 |    2 +-
 arch/arm64/Kconfig.platforms                    |    7 +
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/actions/s700.dtsi           |   17 +-
 arch/arm64/boot/dts/allwinner/Makefile          |    1 +
 .../allwinner/sun50i-a100-allwinner-perf1.dts   |  180 ++
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi  |  364 +++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |    8 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts   |    8 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    |    8 +-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  |    8 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi     |    8 +-
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts   |    8 +-
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |    8 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |    8 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   20 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |    1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |    1 +
 .../boot/dts/altera/socfpga_stratix10.dtsi      |   12 +-
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi       |    2 +-
 arch/arm64/boot/dts/amlogic/Makefile            |    2 +
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi     |   88 -
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts   |   31 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts   |  618 +----
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi  |  625 +++++
 .../amlogic/meson-gxl-s905x-libretech-cc-v2.dts |  318 +++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi     |   94 +-
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts |   86 -
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi      |    2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi          |    2 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |    2 +-
 .../arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |    2 +-
 .../arm64/boot/dts/broadcom/northstar2/ns2.dtsi |    2 +-
 .../dts/broadcom/stingray/bcm958742-base.dtsi   |    2 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi    |    2 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |    4 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   12 +-
 arch/arm64/boot/dts/freescale/Makefile          |    5 +
 .../boot/dts/freescale/fsl-ls1012a-oxalis.dts   |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |    5 +-
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts       |   18 +
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts      |    9 +
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts  |  134 +
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |   10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |   10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |   16 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |  134 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |  157 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |   12 +-
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi  |   16 +-
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi   |   40 +-
 .../boot/dts/freescale/imx8mm-ddr4-evk.dts      |   57 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts    |  553 +---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi   |  474 ++++
 .../dts/freescale/imx8mm-var-som-symphony.dts   |  255 ++
 .../boot/dts/freescale/imx8mm-var-som.dtsi      |  561 ++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |    3 +-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts      |   32 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts    |    3 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi   |   20 +-
 .../dts/freescale/imx8mn-var-som-symphony.dts   |  240 ++
 .../boot/dts/freescale/imx8mn-var-som.dtsi      |  551 ++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi       |    3 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts    |   14 +-
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h  |  360 +--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi       |    3 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |   52 +-
 .../dts/freescale/imx8mq-hummingboard-pulse.dts |    8 +-
 .../dts/freescale/imx8mq-librem5-devkit.dts     |   52 +-
 .../boot/dts/freescale/imx8mq-librem5-r2.dts    |   29 +
 .../boot/dts/freescale/imx8mq-librem5-r3.dts    |   27 +
 .../boot/dts/freescale/imx8mq-librem5.dtsi      | 1106 ++++++++
 .../boot/dts/freescale/imx8mq-phanbell.dts      |   21 +-
 .../arm64/boot/dts/freescale/imx8mq-pico-pi.dts |   15 +-
 .../arm64/boot/dts/freescale/imx8mq-sr-som.dtsi |    8 +-
 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts |    2 +-
 .../dts/freescale/imx8mq-zii-ultra-rmb3.dts     |    2 +-
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi    |    8 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |   53 +-
 .../boot/dts/freescale/imx8qxp-colibri.dtsi     |    8 +-
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |    6 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |   10 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts      |    2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |   18 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |    7 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts     |    6 +-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts     |   18 +-
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts     |   20 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi   |   14 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi              |   10 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi              |   10 +-
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi    |    9 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts     |   11 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  |   30 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        |   15 +-
 .../arm64/boot/dts/mediatek/pumpkin-common.dtsi |    2 +-
 arch/arm64/boot/dts/microchip/sparx5.dtsi       |   81 +
 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi  |   31 +
 arch/arm64/boot/dts/microchip/sparx5_pcb125.dts |   53 +
 arch/arm64/boot/dts/microchip/sparx5_pcb134.dts |    1 +
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi |   32 +
 .../boot/dts/microchip/sparx5_pcb134_emmc.dts   |   23 +
 arch/arm64/boot/dts/microchip/sparx5_pcb135.dts |    1 +
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi |   32 +
 .../boot/dts/microchip/sparx5_pcb135_emmc.dts   |   23 +
 arch/arm64/boot/dts/nvidia/Makefile             |    1 +
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |    1 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |    1 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |  217 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |   16 +
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |   14 +
 .../nvidia/tegra194-p3509-0000+p3668-0000.dts   |   14 +
 .../boot/dts/nvidia/tegra194-p3668-0000.dtsi    |   16 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  247 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi  |    3 +-
 .../boot/dts/nvidia/tegra210-p2371-2180.dts     |    1 +
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |   29 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |  150 +-
 arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dts |   40 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi        |  189 ++
 arch/arm64/boot/dts/qcom/Makefile               |   16 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  900 +++---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts    |    6 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi           |   96 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts       |   34 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi           |   10 +-
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts   |  108 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi       |   14 +-
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi    |   79 +
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi  |  132 +-
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts   |   12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi           | 2608 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8992.dtsi           |    2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |    3 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi            |   92 +-
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts    |    2 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |   12 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts        |  686 +++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts         |   66 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts   |   24 +
 .../dts/qcom/sc7180-trogdor-lazor-r1-kb.dts     |   17 +
 .../dts/qcom/sc7180-trogdor-lazor-r1-lte.dts    |   18 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts   |   15 +
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi     |  192 ++
 .../boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi   |   15 +
 .../boot/dts/qcom/sc7180-trogdor-r1-lte.dts     |   14 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts  |  191 ++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi    | 1402 ++++++++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi            |  332 ++-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts      |   14 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts   |  380 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |   92 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi            |  111 +-
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts         |   32 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi            | 1059 ++++++-
 arch/arm64/boot/dts/renesas/Makefile            |    3 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |   40 +-
 .../dts/renesas/r8a774b1-hihope-rzg2n-ex.dts    |    5 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi       |   40 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |   26 +-
 .../r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts     |   15 +
 .../dts/renesas/r8a774e1-hihope-rzg2h-ex.dts    |    5 +
 .../boot/dts/renesas/r8a774e1-hihope-rzg2h.dts  |   15 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi       | 1334 ++++++++-
 arch/arm64/boot/dts/renesas/r8a77951.dtsi       |    2 +-
 arch/arm64/boot/dts/renesas/r8a77960.dtsi       |    2 +-
 .../boot/dts/renesas/r8a77961-salvator-xs.dts   |   57 +
 arch/arm64/boot/dts/renesas/r8a77961.dtsi       |  617 ++++-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |    2 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |    2 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |    2 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |    6 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |  127 +-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |    6 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |    2 +-
 .../boot/dts/renesas/r8a779a0-falcon-cpu.dtsi   |   46 +
 arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts |   22 +
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi       |  133 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |    1 +
 arch/arm64/boot/dts/rockchip/Makefile           |    6 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi        |    2 +-
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts |  374 +++
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     |   12 +
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts     |  368 +++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    |    2 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |    4 +-
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi   |   24 +
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts    |   18 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi |   12 +-
 ...3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} |   26 -
 .../boot/dts/rockchip/rk3399-rock-pi-4a.dts     |   13 +
 .../boot/dts/rockchip/rk3399-rock-pi-4b.dts     |   42 +
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts     |   51 +
 arch/arm64/boot/dts/ti/Makefile                 |    8 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |   52 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         |    4 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      |    6 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |    6 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   18 +-
 .../dts/ti/k3-am654-industrial-thermal.dtsi     |   12 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts  |  215 ++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       |  449 +++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  273 ++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi     |   65 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi            |  172 ++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  |  195 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  301 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |    4 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi     |  155 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |   11 +-
 arch/arm64/boot/dts/toshiba/Makefile            |    2 +
 .../arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts |   43 +
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi       |  390 +++
 arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi  |   93 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi  |    5 -
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts      |   10 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts      |    8 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |    9 +-
 arch/arm64/configs/defconfig                    |    1 +
 drivers/soc/tegra/Kconfig                       |   10 +
 include/dt-bindings/clock/tegra234-clock.h      |   14 +
 include/dt-bindings/mux/ti-serdes.h             |   22 +
 include/dt-bindings/reset/tegra234-reset.h      |   10 +
 660 files changed, 27924 insertions(+), 6530 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/toshiba.yaml
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g25-gardena-smart-gateway.dts
 create mode 100644 arch/arm/boot/dts/bcm53016-meraki-mr32.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tqma6a.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-tqma6b.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-orion.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tqma6a.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-tqma6b.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tqma6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-tqma6b.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
 rename arch/arm/boot/dts/{infinity-msc313-breadbee_crust.dts => mstar-infinity-msc313-breadbee_crust.dts} (90%)
 rename arch/arm/boot/dts/{mercury5-ssc8336n.dtsi => mstar-infinity-msc313.dtsi} (87%)
 rename arch/arm/boot/dts/{infinity.dtsi => mstar-infinity.dtsi} (100%)
 rename arch/arm/boot/dts/{infinity3-msc313e-breadbee.dts => mstar-infinity3-msc313e-breadbee.dts} (89%)
 rename arch/arm/boot/dts/{infinity-msc313.dtsi => mstar-infinity3-msc313e.dtsi} (87%)
 rename arch/arm/boot/dts/{infinity3.dtsi => mstar-infinity3.dtsi} (84%)
 rename arch/arm/boot/dts/{mercury5-ssc8336n-midrived08.dts => mstar-mercury5-ssc8336n-midrived08.dts} (89%)
 rename arch/arm/boot/dts/{infinity3-msc313e.dtsi => mstar-mercury5-ssc8336n.dtsi} (87%)
 rename arch/arm/boot/dts/{mercury5.dtsi => mstar-mercury5.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/mt7623n.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts
 create mode 100644 arch/arm/boot/dts/sd5203.dts
 create mode 100644 arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-odyssey.dts
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dhcom-drc02.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3-pinecube.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
 create mode 100644 arch/arm64/boot/dts/microchip/sparx5_nand.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra234-sim-vdk.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra234.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779a0.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
 rename arch/arm64/boot/dts/rockchip/{rk3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} (95%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi
 create mode 100644 arch/arm64/boot/dts/toshiba/Makefile
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dts
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
 create mode 100644 arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
 create mode 100644 include/dt-bindings/clock/tegra234-clock.h
 create mode 100644 include/dt-bindings/reset/tegra234-reset.h
