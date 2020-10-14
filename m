Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0161628E39A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgJNPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:53:11 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36097 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgJNPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:53:11 -0400
Received: by mail-ot1-f48.google.com with SMTP id 32so92527otm.3;
        Wed, 14 Oct 2020 08:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pAEm76+dVpqeDQyu0lneoj5oVxAo81VjhG6y+EP75SE=;
        b=be1C6mO0izK8IEEJC226iil6q3xEqLI8LbJIACP1k6VGwkVFx/o4ZunBEsdeUA2tvH
         ShIZ4Q48coJbnNKj7ixWAtjEMdXK/LWv57WStpWxlqveaLm7fqpQbFCT/cBJKRlihT6H
         i8HWeUYNoy7GZ7/M2bc7Y9CJPcuzVz64gmowiX6uArP1T1wEvpjRrBhFNFLYYjbdUf0u
         Mlrx5hvoWXoHoexuSCQBplgZc4tsUUVJAd7vmGdKZpcxDkHebtjAkEtUUGRPvkRoNZDt
         TlkCb/7r+DTlnBiUBSJTUK/pWmLACeyoMcG1aKcQhtlKxUiIlSIS6ToRaARSrdi3N2Mw
         6zXA==
X-Gm-Message-State: AOAM5329k2f084OgC+qQMAWtTMwldJw888//TB2JTt7yeliSjoFBkk0z
        VEKeRf7D4QiKf7+2+TmQ0Q==
X-Google-Smtp-Source: ABdhPJzjUb5CRBfFkWy3BhacEkVjmHi+n5jDMpOHbi7IgFQ7By3mLrBJaCvqG9o0FaL3/Ygl/LJSbg==
X-Received: by 2002:a9d:1ca6:: with SMTP id l38mr4282571ota.30.1602690786500;
        Wed, 14 Oct 2020 08:53:06 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x13sm1638930oot.24.2020.10.14.08.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:53:05 -0700 (PDT)
Received: (nullmailer pid 1780748 invoked by uid 1000);
        Wed, 14 Oct 2020 15:53:04 -0000
Date:   Wed, 14 Oct 2020 10:53:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.10
Message-ID: <20201014155304.GA1778149@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v5.10. There's one trivial conflict with
Documentation/x86/index.rst in your tree.

Rob


The following changes since commit efe84d408bf41975db8506d3a1cc02e794e2309c:

  scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting (2020-09-29 15:48:08 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.10

for you to fetch changes up to bd36e51d10e7c2b7d39ffa7d075aed98a8e7473c:

  dt-bindings: misc: explicitly add #address-cells for slave mode (2020-10-14 08:42:25 -0500)

----------------------------------------------------------------
Devicetree updates for v5.10:

- Update dtc to upstream version v1.6.0-31-gcbca977ea121

- dtx_diff help text reformatting

- Speed-up validation time for binding and dtb checks using json for
  intermediate files

- Add support for running yamllint on DT schema files

- Remove old booting-without-of.rst

- Extend the example schema to address common issues

- Cleanup handling of additionalProperties/unevaluatedProperties

- Ensure all DSI controller schemas reference dsi-controller.yaml

- Vendor prefixes for Zealz, Wandbord/Technexion, Embest RIoT, Rex, DFI,
  and Cisco Meraki

- Convert at25, SPMI bus, TI hwlock, HiSilicon Hi3660 USB3 PHY, Arm
  SP805 watchdog, Arm SP804, and Samsung 11-pin USB connector to DT
  schema

- Convert HiSilicon SoC and syscon bindings to DT schema

- Convert SiFive Risc-V L2 cache, PLIC, PRCI, and PWM to DT schema

- Convert i.MX bindings for w1, crypto, rng, SIM, PM, DDR,
   SATA, vf610 GPIO, and UART to DT schema

- Add i.MX 8M compatible strings

- Add LM81 and DS1780 as trivial devices

- Various missing properties added to fix dtb validation warnings

----------------------------------------------------------------
Andre Przywara (2):
      dt-bindings: timers: sp-804: Convert to json-schema
      dt-bindings: watchdog: sp-805: Convert to Json-schema

Andrei Ziureaev (1):
      dt-bindings: Use json for processed-schema*

Anson Huang (16):
      dt-bindings: w1: Convert i.MX to json-schema
      dt-bindings: crypto: Convert MXS DCP to json-schema
      dt-bindings: crypto: Convert i.MX SCC to json-schema
      dt-bindings: crypto: Convert i.MX sahara to json-schema
      dt-bindings: fsl: Convert i.MX7ULP PM to json-schema
      dt-bindings: fsl: Convert i.MX7ULP SIM to json-schema
      dt-bindings: rng: Convert i.MX to json-schema
      dt-bindings: perf: Convert i.MX DDR to json-schema
      dt-bindings: nvmem: Convert snvs lpgpr to json-schema
      dt-bindings: ata: Convert i.MX sata to json-schema
      dt-bindings: gpio: Convert vf610 to json-schema
      dt-bindings: clock: Update i.MX28 example
      dt-bindings: clock: Update i.MX23 example
      dt-bindings: serial: Convert i.MX uart to json-schema
      dt-bindings: serial: Convert MXS auart to json-schema
      dt-bindings: serial: Convert NXP lpuart to json-schema

Biju Das (1):
      dt-bindings: update usb-c-connector example

Chris Packham (1):
      dt-bindings: Add LM81 and DS1780 as trivial devices

Christian Eggers (1):
      dt-bindings: at25: convert the binding document to yaml

Christian Lamparter (1):
      dt-bindings: vendor-prefixes: Add Cisco Meraki vendor prefix

Geert Uytterhoeven (2):
      scripts/dtc: dtx_diff - make help text formatting consistent
      dt-bindings: example: Grammar improvements

Heinrich Schuchardt (1):
      of: properties of reserved-memory nodes

Krzysztof Kozlowski (39):
      dt-bindings: connector: Convert Samsung 11-pin USB bindings to dtschema
      dt-bindings: display: samsung,amoled-mipi-dsi: Do not require enable-gpios on samsung,s6e63j0x03
      dt-bindings: crypto: slimsss: Correct a typo in compatible
      dt-bindings: arm: samsung: pmu: Add missing properties
      dt-bindings: timer: exynos4210-mct: Add missing clocks
      dt-bindings: mfd: google,cros-ec: Add missing properties
      dt-bindings: gpu: arm,mali-midgard: Add missing properties
      dt-bindings: gpu: arm,mali-utgard: Add missing properties
      dt-bindings: gpu: arm,mali-utgard: Correct Maxime's email
      dt-bindings: mailbox: fsl,mu: Fix i.MX 8QXP compatible matching
      dt-bindings: power: fsl,imx-gpcv2: Document interrupt controller properties
      dt-bindings: display: bridge: nwl-dsi: Add common properties
      dt-bindings: gpu: vivante,gc: Add common properties
      dt-bindings: gpu: vivante,gc: Remove trailing whitespace
      dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M compatibles
      dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
      dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
      dt-bindings: serial: fsl-lpuart: Fix compatible matching
      dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
      dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
      dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
      dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
      dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties requirements
      dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible matching
      dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
      dt-bindings: clock: imx8m: Integrate duplicated i.MX 8M schemas
      dt-bindings: power: Correct interrupt flags in examples
      dt-bindings: example: Extend based on practice
      dt-bindings: gpio: gpio-vf610: fix iMX 7ULP compatible matching
      dt-bindings: gpu: samsung-rotator: Add missing properties
      dt-bindings: vendor-prefixes: add DFI
      dt-bindings: vendor-prefixes: add iMX6 Rex Project
      dt-bindings: vendor-prefixes: add Embest RIoT
      dt-bindings: vendor-prefixes: add Wandbord/Technexion
      dt-bindings: vendor-prefixes: add Zealz
      dt-bindings: mailbox: fsl,mu: Add missing power-domains
      dt-bindings: serial: fsl-imx-uart: fix i.MX 53 and 6 compatible matching
      dt-bindings: vendor-prefixes: favor "gateworks" over "gw"
      dt-bindings: pwm: imx: document i.MX compatibles

Marlon Rac Cambasis (1):
      Docs: Fixing spelling errors in Documentation/devicetree/bindings/

Mauro Carvalho Chehab (2):
      dt-bindings: convert spmi.txt to spmi.yaml
      dt-bindings: phy: convert phy-hi3660-usb3.txt to yaml

Naoki Hayama (2):
      dt-bindings: pinctrl: qcom: Fix typo abitrary
      dt-bindings: pinctrl: sirf: Fix typo abitrary

Rob Herring (17):
      dt-bindings: Bump minimum version of dtschema to 2020.8.1
      dt-bindings: Validate DT binding schema in a single call
      dt-bindings: sound: Remove unused 'linux,hdmi-audio'
      dt-bindings: phy: Remove phy-stih41x-usb binding
      dt-bindings: interrupt-controller: Remove obsolete 'img,meta-intc'
      dt-bindings: arm: Add missing root node constraint for board/SoC bindings
      dt-bindings: display: Add dsi-controller.yaml in DSI controller schemas
      dt-bindings: mfd: ti,j721e-system-controller: Fix incorrect pattern property
      Merge branch 'dt/linus' into dt/next
      dt-bindings: Another round of adding missing 'additionalProperties'
      dt-bindings: Add missing 'unevaluatedProperties'
      dt-bindings: Use 'additionalProperties' instead of 'unevaluatedProperties'
      dt-bindings: Explicitly allow additional properties in common schemas
      dt-bindings: powerpc: Add a schema for the 'sleep' property
      dt-bindings: Add running yamllint to dt_binding_check
      scripts/dtc: Update to upstream version v1.6.0-31-gcbca977ea121
      dt: Remove booting-without-of.rst

Sagar Kadam (4):
      dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
      dt-bindings: fu540: prci: convert PRCI bindings to json-schema
      dt-bindings: riscv: convert plic bindings to json-schema
      dt-bindings: riscv: convert pwm bindings to json-schema

Suman Anna (2):
      dt-bindings: hwlock: omap: Convert binding to YAML
      dt-bindings: hwlock: omap: Fix warnings with k3.yaml

Thierry Reding (1):
      of: platform: Destroy child devices symmetrically

Zhen Lei (18):
      dt-bindings: sp804: add support for Hisilicon sp804 timer
      dt-bindings: mfd: syscon: add some compatible strings for Hisilicon
      dt-bindings: arm: hisilicon: delete the descriptions of HiP05/HiP06 controllers
      dt-bindings: arm: hisilicon: split the dt-bindings of each controller into a separate file
      dt-bindings: arm: hisilicon: convert Hisilicon board/soc bindings to json-schema
      dt-bindings: arm: hisilicon: add binding for SD5203 SoC
      dt-bindings: arm: hisilicon: convert system controller bindings to json-schema
      dt-bindings: arm: hisilicon: convert hisilicon,cpuctrl bindings to json-schema
      dt-bindings: arm: hisilicon: convert hisilicon,pctrl bindings to json-schema
      dt-bindings: arm: hisilicon: convert hisilicon,hip04-fabric bindings to json-schema
      dt-bindings: arm: hisilicon: convert hisilicon,hip04-bootwrapper bindings to json-schema
      dt-bindings: arm: hisilicon: convert hisilicon,hi3798cv200-perictrl bindings to json-schema
      dt-bindings: arm: hisilicon: convert LPC controller bindings to json-schema
      dt-bindings: arm: hisilicon: convert Hi6220 domain controller bindings to json-schema
      dt-bindings: arm: hisilicon: add missing properties into sysctrl.yaml
      dt-bindings: arm: hisilicon: add missing properties into cpuctrl.yaml
      spi: dt-bindings: spi-controller: explicitly require #address-cells=<0> for slave mode
      dt-bindings: misc: explicitly add #address-cells for slave mode

 Documentation/devicetree/bindings/.gitignore       |    1 +
 Documentation/devicetree/bindings/.yamllint        |   39 +
 Documentation/devicetree/bindings/Makefile         |   52 +-
 Documentation/devicetree/bindings/arm/actions.yaml |    2 +
 Documentation/devicetree/bindings/arm/altera.yaml  |    2 +
 Documentation/devicetree/bindings/arm/axxia.yaml   |    2 +
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |    2 +
 Documentation/devicetree/bindings/arm/bitmain.yaml |    2 +
 .../devicetree/bindings/arm/coresight-cti.yaml     |    2 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
 .../devicetree/bindings/arm/digicolor.yaml         |    2 +
 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      |   23 -
 .../bindings/arm/freescale/fsl,imx7ulp-pm.yaml     |   42 +
 .../bindings/arm/freescale/fsl,imx7ulp-sim.txt     |   16 -
 .../bindings/arm/freescale/fsl,imx7ulp-sim.yaml    |   38 +
 .../bindings/arm/hisilicon/controller/cpuctrl.yaml |   54 +
 .../hisilicon/controller/hi3798cv200-perictrl.yaml |   64 +
 .../hisilicon/controller/hi6220-domain-ctrl.yaml   |   68 +
 .../hisilicon/controller/hip04-bootwrapper.yaml    |   34 +
 .../arm/hisilicon/controller/hip04-fabric.yaml     |   27 +
 .../bindings/arm/hisilicon/controller/pctrl.yaml   |   34 +
 .../bindings/arm/hisilicon/controller/sysctrl.yaml |  132 ++
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |   14 -
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |   33 -
 .../bindings/arm/hisilicon/hisilicon.txt           |  319 ----
 .../bindings/arm/hisilicon/hisilicon.yaml          |   67 +
 .../bindings/arm/hisilicon/low-pin-count.yaml      |   61 +
 .../devicetree/bindings/arm/intel-ixp4xx.yaml      |    2 +
 .../bindings/arm/mediatek/mediatek,pericfg.yaml    |    2 +
 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |    2 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |    2 +
 .../devicetree/bindings/arm/primecell.yaml         |    3 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
 Documentation/devicetree/bindings/arm/rda.yaml     |    2 +
 .../devicetree/bindings/arm/samsung/pmu.yaml       |    3 +
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |    2 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |    2 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |    2 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |    2 +
 .../devicetree/bindings/ata/faraday,ftide010.yaml  |    2 +
 Documentation/devicetree/bindings/ata/imx-sata.txt |   37 -
 .../devicetree/bindings/ata/imx-sata.yaml          |   83 +
 .../devicetree/bindings/ata/pata-common.yaml       |    2 +
 .../devicetree/bindings/ata/sata-common.yaml       |    2 +
 .../devicetree/bindings/bus/mti,mips-cdmm.yaml     |    2 +
 .../devicetree/bindings/bus/renesas,bsc.yaml       |    2 +
 .../devicetree/bindings/bus/simple-pm-bus.yaml     |    2 +
 .../bus/socionext,uniphier-system-bus.yaml         |    7 +
 .../bindings/chrome/google,cros-ec-typec.yaml      |    2 +
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |    2 +
 .../bindings/clock/baikal,bt1-ccu-div.yaml         |    6 +-
 .../bindings/clock/baikal,bt1-ccu-pll.yaml         |    2 +-
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   20 +-
 .../devicetree/bindings/clock/imx23-clock.yaml     |    4 +-
 .../devicetree/bindings/clock/imx28-clock.yaml     |    6 +-
 .../devicetree/bindings/clock/imx6q-clock.yaml     |    2 +
 .../devicetree/bindings/clock/imx6sl-clock.yaml    |    2 +
 .../devicetree/bindings/clock/imx6sll-clock.yaml   |    2 +
 .../devicetree/bindings/clock/imx6sx-clock.yaml    |    2 +
 .../devicetree/bindings/clock/imx6ul-clock.yaml    |    2 +
 .../devicetree/bindings/clock/imx8m-clock.yaml     |  125 ++
 .../devicetree/bindings/clock/imx8mm-clock.yaml    |   68 -
 .../devicetree/bindings/clock/imx8mn-clock.yaml    |   70 -
 .../devicetree/bindings/clock/imx8mp-clock.yaml    |   70 -
 .../devicetree/bindings/clock/imx8mq-clock.yaml    |   72 -
 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |    2 +
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    2 +
 .../bindings/clock/sifive/fu540-prci.txt           |   46 -
 .../bindings/clock/sifive/fu540-prci.yaml          |   60 +
 .../bindings/clock/sprd,sc9863a-clk.yaml           |    2 +
 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml      |    2 +
 .../connector/samsung,usb-connector-11pin.txt      |   49 -
 .../bindings/connector/usb-connector.yaml          |   76 +-
 .../devicetree/bindings/crypto/fsl-dcp.txt         |   18 -
 .../devicetree/bindings/crypto/fsl-dcp.yaml        |   51 +
 .../devicetree/bindings/crypto/fsl-imx-sahara.txt  |   15 -
 .../devicetree/bindings/crypto/fsl-imx-sahara.yaml |   37 +
 .../devicetree/bindings/crypto/fsl-imx-scc.txt     |   21 -
 .../devicetree/bindings/crypto/fsl-imx-scc.yaml    |   54 +
 .../bindings/crypto/samsung-slimsss.yaml           |    2 +-
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |   11 +-
 .../bindings/display/brcm,bcm2835-dsi0.yaml        |    3 +
 .../bindings/display/bridge/ite,it6505.yaml        |    5 +
 .../bindings/display/bridge/lvds-codec.yaml        |    3 +
 .../bindings/display/bridge/nwl-dsi.yaml           |   15 +-
 .../bindings/display/bridge/snps,dw-mipi-dsi.yaml  |    2 +
 .../bindings/display/dsi-controller.yaml           |    2 +
 .../devicetree/bindings/display/msm/gmu.yaml       |    2 +
 .../devicetree/bindings/display/panel/lvds.yaml    |    2 +
 .../bindings/display/panel/panel-common.yaml       |    2 +
 .../display/panel/samsung,amoled-mipi-dsi.yaml     |   12 +-
 .../bindings/display/panel/tpo,tpg110.yaml         |    2 +
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |   23 +-
 .../devicetree/bindings/dma/dma-common.yaml        |    2 +
 .../devicetree/bindings/dma/dma-controller.yaml    |    2 +
 .../devicetree/bindings/dma/dma-router.yaml        |    2 +
 .../devicetree/bindings/dma/ingenic,dma.yaml       |    2 +
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |    2 +
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |    2 +
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     |    2 +
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |    2 +
 .../devicetree/bindings/edac/dmc-520.yaml          |    2 +
 Documentation/devicetree/bindings/eeprom/at25.txt  |   45 -
 Documentation/devicetree/bindings/eeprom/at25.yaml |  129 ++
 .../devicetree/bindings/example-schema.yaml        |   33 +-
 .../devicetree/bindings/extcon/wlf,arizona.yaml    |    2 +
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml       |    2 +
 .../devicetree/bindings/gpio/gpio-vf610.txt        |   63 -
 .../devicetree/bindings/gpio/gpio-vf610.yaml       |   83 +
 .../bindings/gpio/socionext,uniphier-gpio.yaml     |    2 +
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |    1 +
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |    4 +-
 .../devicetree/bindings/gpu/samsung-rotator.yaml   |    6 +
 .../devicetree/bindings/gpu/vivante,gc.yaml        |    9 +-
 .../devicetree/bindings/hwlock/omap-hwspinlock.txt |   41 -
 .../bindings/hwlock/ti,omap-hwspinlock.yaml        |   76 +
 .../bindings/hwmon/adi,axi-fan-control.yaml        |    2 +
 .../devicetree/bindings/hwmon/adt7475.yaml         |    2 +
 .../devicetree/bindings/hwmon/baikal,bt1-pvt.yaml  |    4 +-
 .../bindings/i2c/amlogic,meson6-i2c.yaml           |    2 +
 .../devicetree/bindings/i2c/cdns,i2c-r1p10.yaml    |    2 +
 .../devicetree/bindings/i2c/i2c-gpio.yaml          |    2 +
 .../devicetree/bindings/i2c/i2c-rk3x.yaml          |    2 +
 .../bindings/i2c/socionext,uniphier-fi2c.yaml      |    2 +
 .../bindings/i2c/socionext,uniphier-i2c.yaml       |    2 +
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |    2 +
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |    2 +
 .../bindings/iio/accel/adi,adis16240.yaml          |    4 +
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    4 +
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |    4 +
 .../bindings/iio/accel/kionix,kxsd9.yaml           |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |    4 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |    6 +
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |    4 +
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |    2 +
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    4 +
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml |    2 +
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    4 +
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |    5 +
 .../devicetree/bindings/iio/adc/ti,ads8688.yaml    |    4 +
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |    2 +
 Documentation/devicetree/bindings/iio/common.yaml  |    2 +
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |   10 +
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    4 +
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    4 +
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    2 +
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |    4 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |    6 +
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |    4 +
 .../bindings/iio/light/amstaos,tsl2563.yaml        |    2 +
 .../bindings/iio/light/dynaimage,al3010.yaml       |    2 +
 .../bindings/iio/light/dynaimage,al3320a.yaml      |    2 +
 .../bindings/iio/light/sharp,gp2ap002.yaml         |    2 +
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |    2 +
 .../bindings/iio/proximity/vishay,vcnl3020.yaml    |    2 +
 .../bindings/input/fsl,mpr121-touchkey.yaml        |    2 +
 Documentation/devicetree/bindings/input/input.yaml |    2 +
 .../devicetree/bindings/input/matrix-keymap.yaml   |    2 +
 .../bindings/input/touchscreen/touchscreen.yaml    |    2 +
 .../interrupt-controller/fsl,irqsteer.yaml         |    8 +-
 .../interrupt-controller/img,meta-intc.txt         |   82 -
 .../interrupt-controller/ingenic,intc.yaml         |    2 +
 .../interrupt-controller/loongson,htpic.yaml       |    2 +
 .../interrupt-controller/loongson,liointc.yaml     |    2 +
 .../interrupt-controller/loongson,pch-msi.yaml     |    2 +
 .../interrupt-controller/loongson,pch-pic.yaml     |    2 +
 .../bindings/interrupt-controller/mti,gic.yaml     |    2 +-
 .../interrupt-controller/sifive,plic-1.0.0.txt     |   58 -
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   97 ++
 .../devicetree/bindings/ipmi/ipmi-smic.yaml        |    2 +
 Documentation/devicetree/bindings/leds/common.yaml |    2 +
 .../bindings/leds/leds-class-multicolor.yaml       |    3 +
 .../devicetree/bindings/leds/leds-lp55xx.yaml      |    8 +
 .../devicetree/bindings/leds/trigger-source.yaml   |    2 +
 .../devicetree/bindings/mailbox/fsl,mu.yaml        |    6 +-
 .../bindings/media/i2c/chrontel,ch7322.yaml        |    2 +
 .../bindings/media/i2c/imi,rdacm2x-gmsl.yaml       |    2 +
 .../devicetree/bindings/media/nxp,imx8mq-vpu.yaml  |    2 +
 .../bindings/media/qcom,msm8916-venus.yaml         |    2 +
 .../bindings/media/qcom,msm8996-venus.yaml         |    2 +
 .../bindings/media/qcom,sc7180-venus.yaml          |    2 +
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |    2 +
 .../bindings/media/qcom,sdm845-venus.yaml          |    2 +
 Documentation/devicetree/bindings/media/rc.yaml    |    2 +
 .../bindings/memory-controllers/fsl/mmdc.yaml      |    2 +
 .../memory-controllers/renesas,rpc-if.yaml         |    2 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |    2 +
 .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  |   10 +-
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |    2 +
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |    8 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |    2 +-
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |    9 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    6 +-
 .../bindings/mfd/ti,j721e-system-controller.yaml   |    9 +-
 .../devicetree/bindings/mfd/xylon,logicvc.yaml     |   14 +-
 .../bindings/mips/ingenic/ingenic,cpu.yaml         |    6 +-
 .../bindings/mips/loongson/rs780e-acpi.yaml        |    2 +
 .../devicetree/bindings/misc/olpc,xo1.75-ec.yaml   |    6 +-
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml        |    2 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |    2 +
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |    2 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |    2 +
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   |    2 +
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml |    2 +
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |    2 +
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |    2 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |    2 +
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |    2 +
 .../bindings/mmc/socionext,uniphier-sd.yaml        |    2 +
 .../bindings/mmc/synopsys-dw-mshc-common.yaml      |    2 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |    2 +
 .../devicetree/bindings/mtd/denali,nand.yaml       |    2 +
 .../devicetree/bindings/mtd/gpmi-nand.yaml         |   18 +-
 .../devicetree/bindings/mtd/ingenic,nand.yaml      |    2 +
 .../devicetree/bindings/mtd/nand-controller.yaml   |    2 +
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |    2 +
 .../devicetree/bindings/net/adi,adin.yaml          |    2 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |    2 +
 .../bindings/net/aspeed,ast2600-mdio.yaml          |    2 +
 .../bindings/net/can/can-transceiver.yaml          |    2 +
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |    2 +
 .../bindings/net/ethernet-controller.yaml          |    2 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |    2 +
 .../devicetree/bindings/net/marvell,mvusb.yaml     |    2 +
 Documentation/devicetree/bindings/net/mdio.yaml    |    2 +
 .../bindings/net/mediatek,star-emac.yaml           |    2 +
 .../devicetree/bindings/net/nxp,tja11xx.yaml       |    2 +
 .../devicetree/bindings/net/qca,ar71xx.yaml        |    2 +
 .../devicetree/bindings/net/qca,ar803x.yaml        |    2 +
 .../devicetree/bindings/net/qcom,ipa.yaml          |    2 +
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml |    2 +
 .../devicetree/bindings/net/qcom,ipq8064-mdio.yaml |    2 +
 .../devicetree/bindings/net/realtek-bluetooth.yaml |    4 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    2 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |    2 +
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |    2 +
 .../devicetree/bindings/net/ti,dp83867.yaml        |    2 +
 .../devicetree/bindings/net/ti,dp83869.yaml        |    2 +
 .../bindings/net/wireless/microchip,wilc1000.yaml  |    4 +
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   40 +-
 .../devicetree/bindings/nvmem/nvmem-consumer.yaml  |    2 +
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |    2 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    2 +
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |    2 +
 .../devicetree/bindings/nvmem/rockchip-efuse.yaml  |    2 +
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |   21 -
 .../devicetree/bindings/nvmem/snvs-lpgpr.yaml      |   33 +
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |    2 +
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |    4 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |    2 +
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |    2 +
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |    2 +
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |    2 +
 .../devicetree/bindings/pci/cdns-pcie.yaml         |    2 +
 .../devicetree/bindings/pci/host-generic-pci.yaml  |    2 +
 .../devicetree/bindings/pci/loongson.yaml          |    2 +
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |    2 +
 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |    2 +
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |    2 +
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |    2 +
 .../devicetree/bindings/pci/versatile.yaml         |    2 +
 .../devicetree/bindings/perf/fsl-imx-ddr.txt       |   22 -
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   49 +
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml  |    2 +
 .../bindings/phy/hisilicon,hi3660-usb3.yaml        |   60 +
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |   26 -
 .../devicetree/bindings/phy/phy-stih41x-usb.txt    |   24 -
 .../bindings/phy/qcom,ipq806x-usb-phy-hs.yaml      |    2 +
 .../bindings/phy/qcom,ipq806x-usb-phy-ss.yaml      |    2 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    1 +
 .../bindings/phy/qcom-usb-ipq4019-phy.yaml         |    2 +
 .../bindings/pinctrl/cirrus,lochnagar.yaml         |    2 +
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml |    2 +
 .../devicetree/bindings/pinctrl/pincfg-node.yaml   |    2 +
 .../devicetree/bindings/pinctrl/pinctrl-atlas7.txt |    2 +-
 .../devicetree/bindings/pinctrl/pinmux-node.yaml   |    2 +
 .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt      |    2 +-
 .../bindings/pinctrl/samsung-pinctrl.txt           |    6 +-
 .../pinctrl/socionext,uniphier-pinctrl.yaml        |    2 +
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |    2 +
 .../bindings/power/domain-idle-state.yaml          |    2 +
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   |    4 +
 .../devicetree/bindings/power/mti,mips-cpc.yaml    |    2 +
 .../devicetree/bindings/power/pd-samsung.yaml      |    2 +
 .../devicetree/bindings/power/power-domain.yaml    |    2 +
 .../bindings/power/supply/act8945a-charger.txt     |    2 +-
 .../bindings/power/supply/cw2015_battery.yaml      |    2 +
 .../bindings/power/supply/power-supply.yaml        |    2 +
 .../bindings/power/supply/rohm,bd99954.yaml        |    8 +
 .../devicetree/bindings/powerpc/sleep.yaml         |   47 +
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |   25 +-
 .../devicetree/bindings/pwm/pwm-sifive.txt         |   33 -
 .../devicetree/bindings/pwm/pwm-sifive.yaml        |   69 +
 Documentation/devicetree/bindings/pwm/pwm.yaml     |    2 +
 .../bindings/regulator/fixed-regulator.yaml        |    2 +
 .../regulator/google,cros-ec-regulator.yaml        |    2 +
 .../bindings/regulator/gpio-regulator.yaml         |    2 +
 .../bindings/regulator/qcom-labibb-regulator.yaml  |    2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |    2 +
 .../bindings/regulator/silergy,sy8827n.yaml        |    2 +
 .../bindings/regulator/st,stm32-booster.yaml       |    2 +
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |    2 +
 .../regulator/vqmmc-ipq4019-regulator.yaml         |    2 +
 .../devicetree/bindings/regulator/wlf,arizona.yaml |    2 +
 .../bindings/remoteproc/qcom,pil-info.yaml         |    2 +
 .../bindings/reserved-memory/reserved-memory.txt   |    3 +
 .../devicetree/bindings/reset/fsl,imx7-src.yaml    |   19 +-
 .../bindings/reset/nuvoton,npcm-reset.txt          |    2 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |    2 +
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |   51 -
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |   98 ++
 Documentation/devicetree/bindings/rng/imx-rng.txt  |   23 -
 Documentation/devicetree/bindings/rng/imx-rng.yaml |   52 +
 .../devicetree/bindings/rtc/ingenic,rtc.yaml       |    2 +
 Documentation/devicetree/bindings/rtc/rtc.yaml     |    2 +
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml |    2 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   40 -
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |  100 ++
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   43 -
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   82 +
 .../devicetree/bindings/serial/fsl-mxs-auart.txt   |   53 -
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml  |   91 ++
 .../devicetree/bindings/serial/ingenic,uart.yaml   |    5 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |    2 +
 .../devicetree/bindings/serial/renesas,sci.yaml    |    2 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |    2 +
 .../devicetree/bindings/serial/renesas,scifa.yaml  |    2 +
 .../devicetree/bindings/serial/renesas,scifb.yaml  |    2 +
 .../devicetree/bindings/serial/rs485.yaml          |    3 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |    2 +
 .../devicetree/bindings/serial/serial.yaml         |    2 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |    2 +
 .../bindings/serial/socionext,uniphier-uart.yaml   |    2 +
 .../devicetree/bindings/serial/sprd-uart.yaml      |    2 +
 .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  |    2 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |    1 +
 .../devicetree/bindings/sound/amlogic,aiu.yaml     |    2 +
 .../bindings/sound/amlogic,g12a-toacodec.yaml      |    2 +
 .../bindings/sound/amlogic,gx-sound-card.yaml      |    2 +
 .../devicetree/bindings/sound/amlogic,t9015.yaml   |    2 +
 .../devicetree/bindings/sound/cirrus,cs42l51.yaml  |    2 +
 .../devicetree/bindings/sound/cirrus,madera.yaml   |    2 +
 .../devicetree/bindings/sound/fsl,easrc.yaml       |    2 +
 Documentation/devicetree/bindings/sound/hdmi.txt   |   16 -
 .../bindings/sound/intel,keembay-i2s.yaml          |    2 +
 .../bindings/sound/nvidia,tegra186-dspk.yaml       |    2 +
 .../bindings/sound/nvidia,tegra210-admaif.yaml     |    2 +
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |    3 +
 .../bindings/sound/nvidia,tegra210-dmic.yaml       |    2 +
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |    2 +
 .../bindings/sound/rockchip,rk3328-codec.yaml      |    2 +
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |    2 +
 .../devicetree/bindings/sound/wlf,arizona.yaml     |    2 +
 .../bindings/soundwire/soundwire-controller.yaml   |    2 +
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |    2 +
 .../bindings/spi/amlogic,meson6-spifc.yaml         |    2 +
 .../bindings/spi/mikrotik,rb4xx-spi.yaml           |    2 +
 .../devicetree/bindings/spi/qca,ar934x-spi.yaml    |    2 +
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |    2 +
 .../devicetree/bindings/spi/renesas,hspi.yaml      |    2 +
 .../devicetree/bindings/spi/renesas,rspi.yaml      |    2 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |    2 +
 .../bindings/spi/socionext,uniphier-spi.yaml       |    2 +
 .../devicetree/bindings/spi/spi-controller.yaml    |   22 +-
 .../devicetree/bindings/spi/spi-gpio.yaml          |    2 +
 Documentation/devicetree/bindings/spi/spi-mux.yaml |    2 +
 .../devicetree/bindings/spi/spi-pl022.yaml         |    2 +
 .../devicetree/bindings/spi/spi-rockchip.yaml      |    2 +
 .../devicetree/bindings/spi/spi-sifive.yaml        |    2 +
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |    2 +
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |    2 +
 .../bindings/spmi/qcom,spmi-pmic-arb.txt           |    4 +-
 Documentation/devicetree/bindings/spmi/spmi.txt    |   41 -
 Documentation/devicetree/bindings/spmi/spmi.yaml   |   77 +
 .../bindings/thermal/imx8mm-thermal.yaml           |   10 +-
 .../devicetree/bindings/thermal/rcar-thermal.yaml  |    5 +
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |    4 +
 .../bindings/thermal/thermal-cooling-devices.yaml  |    2 +
 .../devicetree/bindings/thermal/thermal-idle.yaml  |    2 +
 .../bindings/thermal/thermal-sensor.yaml           |    2 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |    2 +
 .../devicetree/bindings/timer/arm,sp804.txt        |   29 -
 .../devicetree/bindings/timer/arm,sp804.yaml       |   97 ++
 .../devicetree/bindings/timer/cdns,ttc.yaml        |    2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |   25 +
 .../bindings/timer/snps,dw-apb-timer.yaml          |    2 +-
 .../devicetree/bindings/trivial-devices.yaml       |    4 +
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |    2 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |    2 +
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   18 +
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |    2 +
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |    2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   14 +
 .../devicetree/bindings/w1/fsl-imx-owire.txt       |   18 -
 .../devicetree/bindings/w1/fsl-imx-owire.yaml      |   44 +
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |    2 +
 .../devicetree/bindings/watchdog/arm,sp805.txt     |   32 -
 .../devicetree/bindings/watchdog/arm,sp805.yaml    |   71 +
 .../devicetree/bindings/watchdog/arm-smc-wdt.yaml  |    2 +
 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |    2 +-
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  |   11 +-
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |    2 +
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |    2 +
 .../bindings/watchdog/st,stm32-iwdg.yaml           |    2 +
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |    2 +
 .../devicetree/bindings/watchdog/watchdog.yaml     |    2 +
 Documentation/devicetree/booting-without-of.rst    | 1585 --------------------
 Documentation/devicetree/index.rst                 |    1 -
 Documentation/mips/booting.rst                     |   28 +
 Documentation/mips/index.rst                       |    1 +
 Documentation/powerpc/booting.rst                  |  110 ++
 Documentation/powerpc/index.rst                    |    1 +
 Documentation/sh/booting.rst                       |   12 +
 Documentation/sh/index.rst                         |    1 +
 Documentation/x86/booting-dt.rst                   |   21 +
 Documentation/x86/index.rst                        |    1 +
 drivers/of/platform.c                              |    2 +-
 scripts/Makefile.lib                               |    2 +-
 scripts/dtc/checks.c                               |    4 +-
 scripts/dtc/dtc-parser.y                           |    4 +-
 scripts/dtc/dtx_diff                               |    3 +-
 scripts/dtc/libfdt/fdt.c                           |   31 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |    3 +-
 scripts/dtc/libfdt/fdt_ro.c                        |   20 +-
 scripts/dtc/libfdt/fdt_rw.c                        |    2 +-
 scripts/dtc/libfdt/fdt_strerror.c                  |    4 +-
 scripts/dtc/libfdt/fdt_sw.c                        |   27 +-
 scripts/dtc/libfdt/fdt_wip.c                       |    2 +-
 scripts/dtc/util.h                                 |    1 +
 scripts/dtc/version_gen.h                          |    2 +-
 432 files changed, 3774 insertions(+), 3417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.yamllint
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-fabric.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/pctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/imx-sata.txt
 create mode 100644 Documentation/devicetree/bindings/ata/imx-sata.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8m-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
 delete mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-dcp.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-dcp.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-scc.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-scc.yaml
 delete mode 100644 Documentation/devicetree/bindings/eeprom/at25.txt
 create mode 100644 Documentation/devicetree/bindings/eeprom/at25.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwlock/omap-hwspinlock.txt
 create mode 100644 Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/img,meta-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.yaml
 delete mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
 create mode 100644 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/sleep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/imx-rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/imx-rng.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/hdmi.txt
 delete mode 100644 Documentation/devicetree/bindings/spmi/spmi.txt
 create mode 100644 Documentation/devicetree/bindings/spmi/spmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.yaml
 delete mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
 create mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
 delete mode 100644 Documentation/devicetree/booting-without-of.rst
 create mode 100644 Documentation/mips/booting.rst
 create mode 100644 Documentation/powerpc/booting.rst
 create mode 100644 Documentation/sh/booting.rst
 create mode 100644 Documentation/x86/booting-dt.rst
