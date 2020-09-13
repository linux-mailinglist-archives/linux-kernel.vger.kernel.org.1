Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368272680B0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgIMSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 14:08:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1873C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:08:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so16624842lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=c9VCvH9vvfajUFwsZv7ecNplCqET1dhVkvlOemvLNrQ=;
        b=juLxRUxB2Lb7nxSOj3TKK6WKqkAkh6y3UH9Q6z6caoHMNABiZwJN8brbxqdoYW8FFz
         5dPVlWe3HW+Kzyz6pEY/jU45g/s+dcbdzBAdWXPI93+4nEpwLeh7VlQYF4UXlG7BXP4y
         fKZZcmMBivXUhn2IZgbM7yE0eSx/fySQqeqVUhyWAMaUB/WH2dKfR+C9xJAFttzT+B5L
         wsMCrqmXZy4w5Z1bDClP0EJVI+Gr/Q760IzYTJ12njVCoqZGYDdvr4uCw48U+/IACyge
         81uKBNvZs/IrfjvoJpDvnrolwxRo6j3bp6zU3Zk8yGEXW+0mvsttNOM1y40FXBOr2Eow
         0kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c9VCvH9vvfajUFwsZv7ecNplCqET1dhVkvlOemvLNrQ=;
        b=lIS75bCn8p+Hb1mjg6wRwdQNo0xrbtB0fcPo3QRtUJkKHj0riCVIYmXouIA/Q2eyL0
         9lhc9E4YeusTC4NPJo+4G54xajQFw7rWSpeE1oKMBQn96w62K6MdkRUam3PoV2ACnf5v
         26KF3vx7D9UJApf6sfKi7tccC7URUOoN9fUimyjVwmR8z/Cba+7I0+NCwd/ZwHUr1tLc
         Ik7qxP+UQzCPON21vaafpfwoxl9p1coSVIRXDB4BEYNMIXz5JQQT8KmndabNY2Tu5l0n
         kSfM396IluzA+nN2O2ncXbfm/hOfFEBg7VB/HsAnDgwW2GWgaO0uBMJH0CQUCjPcb6Vs
         aZyA==
X-Gm-Message-State: AOAM531zQYbZd8MJslfCz/MuV8htQD3dN7R5m7StIvC6+oSD2dD6lafu
        eppCkSZFMBy8gUVTtWwRjk+8+A==
X-Google-Smtp-Source: ABdhPJwFrcYFw5apyPxaQbPincz2cZOzZKJiOp4EpJ8CIY/4irzMUzwASD6upTnPwQAjzYhYpOd0pw==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr4129829ljm.149.1600020487216;
        Sun, 13 Sep 2020 11:08:07 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 25sm3225203ljn.120.2020.09.13.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 11:08:05 -0700 (PDT)
Date:   Sun, 13 Sep 2020 11:07:57 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20200913180757.GA29176@lx2k>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to a4da411e41892628f35aa180a78b7b0f8f1e3038:

  Merge tag 'arm-soc/for-5.9/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes (2020-09-13 08:57:38 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A collection of fixes I've been accruing over the last few weeks, none
of them have been severe enough to warrant flushing the queue but it's
been long enough now that it's a good idea to send them in.

A handful of them are fixups for QSPI DT/bindings/compatibles, some
smaller fixes for system DMA clock control and TMU interrupts on i.MX,
a handful of fixes for OMAP, including a fix for DSI (display) on omap5.

----------------------------------------------------------------
Adam Ford (4):
      ARM: dts: logicpd-torpedo-baseboard: Fix broken audio
      ARM: dts: logicpd-som-lv-baseboard: Fix broken audio
      ARM: dts: logicpd-som-lv-baseboard: Fix missing video
      ARM: dts: imx6q-logicpd: Fix broken PWM

Anson Huang (1):
      ARM: dts: imx7ulp: Correct gpio ranges

Chris Healy (2):
      ARM: dts: vfxxx: Add syscon compatible with OCOTP
      ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy

David Shah (1):
      ARM: dts: omap5: Fix DSI base address and clocks

Dinh Nguyen (1):
      ARM: dts: socfpga: fix register entry for timer3 on Arria10

Fabio Estevam (2):
      ARM: dts: imx6qdl-gw51xx: Remove unneeded #address-cells/#size-cells
      ARM: dts: imx6q-prtwd2: Remove unneeded i2c unit name

Florian Fainelli (5):
      dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
      ARM: dts: bcm: HR2: Fixed QSPI compatible string
      ARM: dts: NSP: Fixed QSPI compatible string
      ARM: dts: BCM5301X: Fixed QSPI compatible string
      arm64: dts: ns2: Fixed QSPI compatible string

Fugang Duan (1):
      ARM: dts: imx6sx: fix the pad QSPI1B_SCLK mux mode for uart3

Jing Xiangfeng (1):
      ARM: OMAP2+: Fix an IS_ERR() vs NULL check in _get_pwrdm()

Krzysztof Kozlowski (4):
      arm64: dts: xilinx: Align IOMMU nodename with dtschema
      arm64: defconfig: Enable USB gadget with configfs
      arm64: defconfig: Enable ptn5150 extcon driver
      arm64: dts: imx8mq: Fix TMU interrupt property

Laurent Pinchart (1):
      arm64: dts: zynqmp: Add GTR transceivers

Linus Walleij (1):
      ARM: configs: Update Integrator defconfig

Matthias Schiffer (1):
      ARM: dts: ls1021a: fix QuadSPI-memory reg range

Olof Johansson (6):
      Merge tag 'socfpga_fix_for_v5.9' of git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'zynqmp-dt-for-v5.9' of https://github.com/Xilinx/linux-xlnx into arm/fixes
      Merge tag 'imx-fixes-5.9' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.9/fixes-rc3' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'imx-fixes-5.9-2' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'arm-soc/for-5.9/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes

Rob Herring (1):
      arm64: dts: imx: Add missing imx8mm-beacon-kit.dtb to build

Robin Gong (1):
      arm64: dts: imx8mp: correct sdma1 clk setting

 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  | 16 ++++++------
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  2 +-
 arch/arm/boot/dts/imx6q-logicpd.dts                |  2 +-
 arch/arm/boot/dts/imx6q-prtwd2.dts                 |  2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  2 --
 arch/arm/boot/dts/imx6sx-pinfunc.h                 |  2 +-
 arch/arm/boot/dts/imx7d-zii-rmu2.dts               |  2 +-
 arch/arm/boot/dts/imx7ulp.dtsi                     |  8 +++---
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi    | 29 ++++++----------------
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |  2 ++
 arch/arm/boot/dts/ls1021a.dtsi                     |  2 +-
 arch/arm/boot/dts/omap5.dtsi                       | 20 ++++++++-------
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  2 +-
 arch/arm/configs/integrator_defconfig              | 16 ++++++------
 arch/arm/mach-omap2/omap-iommu.c                   |  2 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/Makefile             |  1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  2 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             | 12 ++++++++-
 arch/arm64/configs/defconfig                       | 12 +++++++++
 24 files changed, 78 insertions(+), 68 deletions(-)
