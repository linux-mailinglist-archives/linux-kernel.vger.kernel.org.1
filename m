Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB92E204D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgLWSME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:12:04 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:35901 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgLWSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:12:04 -0500
Received: by mail-oo1-f44.google.com with SMTP id j8so3881413oon.3;
        Wed, 23 Dec 2020 10:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5ZfXZOdUpEKwmzrcYiPsjjQixKxbTqciJh9FiMnUGTw=;
        b=kDmZknlUJpILWYFuKcB2hcpaL/oAA9hhj89/INZ/AQ1PpUdDIuBZmj4pIVknd3B0qC
         ZqpTMLxna5K22PKnu8FaKGL7QIuCS/LjyEQtoxkJPPhP+V5bsxEoMmzL9UGygEMUpwEU
         rIPfqCo5K1jPJ5La9CrjZtlZZsOoF5tSTYxMSk6kuXDdu02UAGg1mbRhfTqF5NPOtKQC
         GpLt3dvpSvaMTGKu0JPnYdfKSly3b1Q/LT9upzbicEMVTWyXgCJAL0i5hlVZPDKGqRAK
         B+xvDKLXx477ice+SeFv+Ownu5LGJ47/5UETlaSo6aC8pACczWvYvruhyIvINfJrCx6P
         a1gQ==
X-Gm-Message-State: AOAM532VE7yUYNpGfcNnC4PwOqWklBnthLwr3jhEL68iTkVWR0htu1/T
        W7588hbAl3ZBEHL8cZV/4A==
X-Google-Smtp-Source: ABdhPJznC55Mrah2vt1L6mUaWGw30sZ9lupEpdUgaLd3WaTrQpbEzqCYxC0CikZ56I7QsodgyjqChQ==
X-Received: by 2002:a4a:e606:: with SMTP id f6mr11033474oot.4.1608747082420;
        Wed, 23 Dec 2020 10:11:22 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t2sm2696466otj.47.2020.12.23.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 10:11:21 -0800 (PST)
Received: (nullmailer pid 797894 invoked by uid 1000);
        Wed, 23 Dec 2020 18:11:20 -0000
Date:   Wed, 23 Dec 2020 11:11:20 -0700
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.11, take 1
Message-ID: <20201223181120.GA797630@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.11.

Rob

The following changes since commit d64c6f96ba86bd8b97ed8d6762a8c8cc1770d214:

  Merge tag 'net-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-12-17 13:45:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-1

for you to fetch changes up to 2b8f061a4f505aad11fd36adb24c3138ad09b96b:

  dt-bindings: Drop redundant maxItems/items (2020-12-22 18:58:24 -0700)

----------------------------------------------------------------
Devicetree fixes for v5.11, take 1:

- Correct the JSON pointer syntax in binding schemas

- Drop unnecessary *-supply schema constraints

- Drop redundant maxItems/items on array schemas

- Fix various yamllint warnings

- Fix various missing 'additionalProperties' properties

----------------------------------------------------------------
Michael Tretter (1):
      dt-bindings: xlnx,vcu-settings: fix dt_binding_check warnings

Paul Cercueil (1):
      dt-bindings/display: abt,y030xx067a: Fix binding

Rob Herring (5):
      dt-bindings: Fix JSON pointers
      media: dt-bindings: coda: Add missing 'additionalProperties'
      dt-bindings: Drop unnecessary *-supply schemas properties
      dt-bindings: net: qcom,ipa: Drop unnecessary type ref on 'memory-region'
      dt-bindings: Drop redundant maxItems/items

Zhen Lei (6):
      dt-bindings: serial: add the required property 'additionalProperties'
      dt-bindings: soc: add the required property 'additionalProperties'
      dt-bindings: devapc: add the required property 'additionalProperties'
      dt-bindings: media: nokia,smia: eliminate yamllint warnings
      dt-bindings: display: eliminate yamllint warnings
      dt-bindings: clock: imx8qxp-lpcg: eliminate yamllint warnings

 .../devicetree/bindings/arm/idle-states.yaml       |  2 +-
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |  2 +-
 .../devicetree/bindings/bus/baikal,bt1-axi.yaml    |  2 +-
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    | 20 +++++------
 .../bindings/connector/usb-connector.yaml          | 10 +++---
 .../bindings/display/bridge/analogix,anx7625.yaml  |  4 +--
 .../bindings/display/bridge/anx6345.yaml           |  2 --
 .../bindings/display/bridge/intel,keembay-dsi.yaml |  4 +--
 .../bindings/display/bridge/ite,it6505.yaml        |  2 --
 .../bindings/display/bridge/lvds-codec.yaml        |  3 +-
 .../devicetree/bindings/display/bridge/ps8640.yaml |  2 --
 .../bindings/display/bridge/simple-bridge.yaml     |  1 -
 .../display/bridge/thine,thc63lvd1024.yaml         |  1 -
 .../bindings/display/bridge/toshiba,tc358775.yaml  |  2 --
 .../bindings/display/intel,keembay-msscam.yaml     |  4 +--
 .../bindings/display/panel/abt,y030xx067a.yaml     |  2 +-
 .../bindings/display/panel/novatek,nt36672a.yaml   |  2 +-
 .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   |  1 -
 .../devicetree/bindings/dma/dma-common.yaml        |  4 +--
 .../devicetree/bindings/dma/dma-router.yaml        |  2 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |  2 +-
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |  1 -
 .../bindings/dma/snps,dma-spear1340.yaml           | 10 +++---
 Documentation/devicetree/bindings/eeprom/at24.yaml |  4 +--
 Documentation/devicetree/bindings/eeprom/at25.yaml |  4 +--
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |  2 +-
 .../devicetree/bindings/hwmon/sensirion,shtc1.yaml |  4 +--
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |  2 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |  3 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |  3 +-
 .../bindings/iio/light/upisemi,us5182.yaml         |  2 +-
 .../bindings/iio/proximity/semtech,sx9310.yaml     |  6 ++--
 .../bindings/input/fsl,mpr121-touchkey.yaml        |  3 +-
 .../devicetree/bindings/input/gpio-keys.yaml       | 12 +++----
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |  3 +-
 .../bindings/interrupt-controller/mti,gic.yaml     |  4 +--
 .../interrupt-controller/ti,pruss-intc.yaml        |  2 +-
 .../bindings/interrupt-controller/ti,sci-inta.yaml |  2 +-
 .../devicetree/bindings/leds/backlight/common.yaml |  4 +--
 Documentation/devicetree/bindings/leds/common.yaml | 16 ++++-----
 .../devicetree/bindings/leds/leds-lp55xx.yaml      | 10 +++---
 .../devicetree/bindings/mailbox/arm,mhu.yaml       |  1 -
 Documentation/devicetree/bindings/media/coda.yaml  | 42 +++++++++++-----------
 .../bindings/media/i2c/maxim,max9286.yaml          |  1 -
 .../devicetree/bindings/media/i2c/mipi-ccs.yaml    | 14 ++++----
 .../devicetree/bindings/media/i2c/sony,imx214.yaml |  3 --
 .../devicetree/bindings/media/i2c/sony,imx274.yaml |  3 --
 .../devicetree/bindings/mfd/st,stmfx.yaml          |  3 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  6 ++--
 .../bindings/net/amlogic,meson-dwmac.yaml          |  2 +-
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |  6 ++--
 .../bindings/net/ethernet-controller.yaml          | 24 ++++++-------
 .../devicetree/bindings/net/ethernet-phy.yaml      | 20 +++++------
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml           |  2 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |  2 +-
 .../bindings/net/mediatek,star-emac.yaml           |  2 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          |  3 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        | 38 ++++++++++----------
 .../bindings/net/socionext,uniphier-ave4.yaml      |  2 +-
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |  2 +-
 .../devicetree/bindings/net/ti,dp83867.yaml        | 12 +++----
 .../devicetree/bindings/net/ti,dp83869.yaml        |  8 ++---
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |  4 +--
 .../bindings/net/wireless/qcom,ath11k.yaml         |  2 +-
 .../devicetree/bindings/phy/ti,omap-usb2.yaml      |  4 +--
 .../bindings/power/mediatek,power-controller.yaml  | 12 +++----
 .../bindings/power/supply/cw2015_battery.yaml      |  2 +-
 .../devicetree/bindings/powerpc/sleep.yaml         |  2 +-
 .../bindings/regulator/anatop-regulator.yaml       |  1 -
 Documentation/devicetree/bindings/serial/8250.yaml |  6 ++--
 .../devicetree/bindings/serial/litex,liteuart.yaml |  2 ++
 .../bindings/soc/litex/litex,soc-controller.yaml   |  2 ++
 .../devicetree/bindings/soc/mediatek/devapc.yaml   |  2 ++
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |  2 +-
 .../bindings/soc/xilinx/xlnx,vcu-settings.yaml     | 15 ++++++--
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |  2 +-
 .../bindings/sound/nvidia,tegra30-hda.yaml         |  2 --
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |  4 +--
 .../devicetree/bindings/usb/renesas,usb-xhci.yaml  |  1 -
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |  3 --
 80 files changed, 207 insertions(+), 228 deletions(-)
