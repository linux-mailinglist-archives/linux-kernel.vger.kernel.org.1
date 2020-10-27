Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48E929ACF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbgJ0NPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:15:55 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45911 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900599AbgJ0NPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:15:55 -0400
Received: by mail-oi1-f174.google.com with SMTP id j7so1199983oie.12;
        Tue, 27 Oct 2020 06:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=DhOxPerUXGp7wH7dTSBqcOhiwYiHrfDhbrgLrVfJ6BY=;
        b=tmHrn0qpovFZPwjSD4CqayTTxnHVUYN8MLAHiBmjqA7Srx3gSjBWdNMIcaCOxLPoxU
         xYpOIJZPsYQUHy6SVRq8KNQawP0ygNNPoom6FJKY5VmfUnpVMeMd2bEpokFS6VvjArLV
         ePxMBrw94Tw8BT4OpKTtwpVNQEYulQ0IUI4wj/yP/CaK7UlJO/pt6WdV8PDhRCFyFonu
         bt+ngcXRJ4+8ofcS9QlgdPGXyzuVSrkvo4mffhTUpUx8DyUj9NlJ47ZbRRbYrEchsiDZ
         3FVPj6jAU58iWfK3OJLcq/q9ZT06ngUQ4pXbd/guj7yEQnq5ALI7huBtYwa/3d4JHblw
         G8AQ==
X-Gm-Message-State: AOAM532nHtpEmyDZ4CCVWppcv/htoAXoll/SIGez9nPluQCX4OoLc/4Z
        vcjPxCkh3jqL2XNrJgUc6JeCRpkpsw==
X-Google-Smtp-Source: ABdhPJwsOH25Fr17BSqL4eF3S/Pl3k46Q2oxLXGtR/2z7ukyp30wIjMknidUxttOLeCOXC4Wc35SAw==
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr1355915oic.31.1603804553266;
        Tue, 27 Oct 2020 06:15:53 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i18sm939415oik.7.2020.10.27.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:15:52 -0700 (PDT)
Received: (nullmailer pid 1970142 invoked by uid 1000);
        Tue, 27 Oct 2020 13:15:51 -0000
Date:   Tue, 27 Oct 2020 08:15:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.10
Message-ID: <20201027131551.GA1959093@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.10.

Rob


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-1

for you to fetch changes up to f84e2c5c528d937564e4a9e3411418e4c914b1fb:

  dt-bindings: Another round of adding missing 'additionalProperties/unevalutatedProperties' (2020-10-26 16:13:56 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.10:

- More binding additionalProperties/unevaluatedProperties additions

- More yamllint fixes on additions in the merge window

- CrOS embedded controller schema updates to fix warnings

- LEDs schema update adding ID_RGB

- A reserved-memory fix for regions starting at address 0x0

----------------------------------------------------------------
Dan Murphy (1):
      dt-bindings: leds: Update devicetree documents for ID_RGB

Fabien Parent (1):
      dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value

Ricardo Cañuelo (3):
      dt-bindings: i2c: convert i2c-cros-ec-tunnel to json-schema
      dt-bindings: input: convert cros-ec-keyb to json-schema
      mfd: google,cros-ec: add missing properties

Rob Herring (3):
      dt-bindings: More whitespace clean-ups in schema files
      dt-bindings: Explicitly allow additional properties in board/SoC schemas
      dt-bindings: Another round of adding missing 'additionalProperties/unevalutatedProperties'

Vincent Whitchurch (1):
      of: Fix reserved-memory overlap detection

 Documentation/devicetree/bindings/arm/actions.yaml |   2 +
 Documentation/devicetree/bindings/arm/altera.yaml  |   3 +
 .../devicetree/bindings/arm/amazon,al.yaml         |   2 +
 Documentation/devicetree/bindings/arm/amlogic.yaml |   3 +
 .../devicetree/bindings/arm/arm,integrator.yaml    |   2 +
 .../devicetree/bindings/arm/arm,realview.yaml      |   2 +
 .../devicetree/bindings/arm/arm,versatile.yaml     |   2 +
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |   2 +
 .../devicetree/bindings/arm/atmel-at91.yaml        |   2 +
 Documentation/devicetree/bindings/arm/axxia.yaml   |   2 +
 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.yaml |   2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.yaml |   2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.yaml |   2 +
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   3 +
 .../devicetree/bindings/arm/bcm/brcm,cygnus.yaml   |   2 +
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml      |   2 +
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml      |   2 +
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml      |   2 +
 .../devicetree/bindings/arm/bcm/brcm,stingray.yaml |   2 +
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml          |   2 +
 Documentation/devicetree/bindings/arm/bitmain.yaml |   3 +
 Documentation/devicetree/bindings/arm/calxeda.yaml |   2 +
 .../devicetree/bindings/arm/digicolor.yaml         |   2 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |   2 +
 .../bindings/arm/hisilicon/hisilicon.yaml          |   3 +
 .../devicetree/bindings/arm/intel,keembay.yaml     |   3 +
 .../devicetree/bindings/arm/intel-ixp4xx.yaml      |   2 +
 .../bindings/arm/keystone/ti,k3-sci-common.yaml    |   2 +
 .../bindings/arm/marvell/armada-7k-8k.yaml         |   2 +
 .../devicetree/bindings/arm/mediatek.yaml          |   3 +
 .../devicetree/bindings/arm/microchip,sparx5.yaml  |   2 +
 Documentation/devicetree/bindings/arm/moxart.yaml  |   1 +
 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   3 +
 .../devicetree/bindings/arm/mstar/mstar.yaml       |   2 +
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |   2 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |   2 +
 Documentation/devicetree/bindings/arm/rda.yaml     |   2 +
 Documentation/devicetree/bindings/arm/realtek.yaml |   3 +
 Documentation/devicetree/bindings/arm/renesas.yaml |   2 +
 .../devicetree/bindings/arm/rockchip.yaml          |   3 +
 .../bindings/arm/samsung/samsung-boards.yaml       |   2 +
 Documentation/devicetree/bindings/arm/sirf.yaml    |   3 +
 .../bindings/arm/socionext/milbeaut.yaml           |   3 +
 .../bindings/arm/socionext/uniphier.yaml           |   2 +
 Documentation/devicetree/bindings/arm/spear.yaml   |   3 +
 .../devicetree/bindings/arm/sprd/sprd.yaml         |   2 +
 Documentation/devicetree/bindings/arm/sti.yaml     |   3 +
 .../devicetree/bindings/arm/stm32/stm32.yaml       |  11 ++-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   2 +
 Documentation/devicetree/bindings/arm/tegra.yaml   |   2 +
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   3 +
 .../devicetree/bindings/arm/ti/nspire.yaml         |   3 +
 .../devicetree/bindings/arm/ti/ti,davinci.yaml     |   3 +
 Documentation/devicetree/bindings/arm/toshiba.yaml |   3 +
 Documentation/devicetree/bindings/arm/ux500.yaml   |   2 +
 Documentation/devicetree/bindings/arm/vt8500.yaml  |   3 +
 Documentation/devicetree/bindings/arm/xilinx.yaml  |   2 +
 Documentation/devicetree/bindings/arm/zte.yaml     |   2 +
 .../bindings/display/bridge/toshiba,tc358775.yaml  |  38 ++++----
 .../bindings/display/panel/ilitek,ili9881c.yaml    |   5 +-
 .../bindings/edac/amazon,al-mc-edac.yaml           |   1 +
 Documentation/devicetree/bindings/eeprom/at25.yaml |   6 +-
 .../bindings/gpio/kontron,sl28cpld-gpio.yaml       |   4 +-
 .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |  66 +++++++++++++
 .../devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt |  39 --------
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |   8 +-
 .../devicetree/bindings/iio/adc/adi,ad7291.yaml    |   3 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |   3 +-
 .../bindings/iio/adc/cosmic,10001-adc.yaml         |   4 +-
 .../devicetree/bindings/iio/adc/holt,hi8435.yaml   |   2 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   2 +
 .../bindings/iio/humidity/ti,hdc2010.yaml          |   2 +
 .../devicetree/bindings/input/cros-ec-keyb.txt     |  72 ---------------
 .../bindings/input/google,cros-ec-keyb.yaml        |  92 +++++++++++++++++++
 .../interrupt-controller/ti,pruss-intc.yaml        |  12 +--
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   2 +
 .../bindings/interrupt-controller/ti,sci-intr.yaml |   2 +
 .../devicetree/bindings/leds/backlight/common.yaml |   2 +
 Documentation/devicetree/bindings/leds/common.yaml |   2 +-
 .../bindings/leds/leds-class-multicolor.yaml       |   9 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |   8 ++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |   2 +-
 .../devicetree/bindings/mfd/ene-kb3930.yaml        |   2 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  56 +++++++++++
 .../devicetree/bindings/mips/ingenic/devices.yaml  |   3 +
 .../devicetree/bindings/mips/loongson/devices.yaml |   3 +
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   8 +-
 .../bindings/mmc/microchip,dw-sparx5-sdhci.yaml    |   2 +
 .../devicetree/bindings/mmc/sdhci-am654.yaml       |  17 ++--
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   2 +
 .../devicetree/bindings/net/ti,dp83822.yaml        |   2 +
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  18 ++--
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   6 +-
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |  22 +++--
 .../bindings/pinctrl/actions,s500-pinctrl.yaml     | 102 ++++++++++-----------
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |   2 +-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |   6 +-
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml |  24 ++---
 .../bindings/power/reset/reboot-mode.yaml          |   8 +-
 .../bindings/power/supply/ingenic,battery.yaml     |   8 +-
 .../power/supply/summit,smb347-charger.yaml        |  16 ++--
 .../devicetree/bindings/regulator/mps,mp886x.yaml  |   2 +
 .../devicetree/bindings/regulator/pfuze100.yaml    |   2 +
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml |   4 +-
 .../devicetree/bindings/riscv/sifive.yaml          |   3 +
 Documentation/devicetree/bindings/rng/imx-rng.yaml |   6 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |  34 +++----
 .../bindings/sound/google,cros-ec-codec.yaml       |  26 ++++--
 .../devicetree/bindings/sound/mchp,spdifrx.yaml    |   4 +-
 .../devicetree/bindings/sound/mchp,spdiftx.yaml    |   4 +-
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  40 ++++----
 .../devicetree/bindings/sound/realtek,rt1015p.yaml |   2 +
 .../devicetree/bindings/timer/arm,sp804.yaml       |  12 +--
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   4 +-
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |   2 +-
 .../devicetree/bindings/w1/fsl-imx-owire.yaml      |   8 +-
 drivers/of/of_reserved_mem.c                       |  13 ++-
 118 files changed, 656 insertions(+), 348 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
 delete mode 100644 Documentation/devicetree/bindings/input/cros-ec-keyb.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
