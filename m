Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D122BAC98
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgKTPEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:04:10 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31995 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgKTPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605884648; x=1637420648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L8lvamYBd6xzlrZb/jg6PSYAZHm5PPafgOPWlCwN4sc=;
  b=E+4/W/1CgzRLGHcZXIYiUBkdPnBaXCgizeg3OmjGUO1Hp6EwRnatNbEJ
   7nGILYdZ5L0kHQU0OzOq8iKESb3bHCnUQmq9O8b+nVGAAGDDTox/iks4J
   VnWpei1IKhD2OWsKIfnC4cw3aB3d11qzagJUtQRG+4qlQ/m6OgPpavzXh
   11iAB0c5TExt/Tru/i5iWuksUrA8XBSTOKtsXxCTCQB7mTAYZHexY1P1q
   f6XLZXU+rQYmI5T9OH7A8clAP4nlVZPKyQO5gvB/KeXxiL6D7Po89w3BN
   ADErHUD2ukQXL2SXP0xSFbCzvGKyAHOXw/SNRMFQ6nlfKfnWICLtuVzNZ
   g==;
IronPort-SDR: Zjam353h7ta+sTO45B5wcjCqy3Tg/aMfL/NYXOLisBvH8zkPxfsCwR/MFsEW4N3xsdU9WslSlL
 f6dpeMcp6wE2aBx/e+tpK3KZW07/yAwXLB+kTu3fBJEzjI+2xpxBrOUDe8fZ3D44YskktAouJO
 WOn/hwRDL9AcXbJPxDJCJpCJLM1IAwFVeMOr+FCu9oGK4uPh1CSNExoioLW8/Q1Ve7Dtty+9tP
 tNnVz4wY2d/AP1cBLVbkL0CQEb7xQ3h6dnqKLKHeJwD+TDSCfRXhlPYbAxK+HvBEoEZPNa3ePk
 5vs=
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="104441496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Nov 2020 08:04:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 08:04:06 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 20 Nov 2020 08:04:05 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/4] Adding the Sparx5 Serdes driver
Date:   Fri, 20 Nov 2020 16:03:55 +0100
Message-ID: <20201120150359.2041940-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the Sparx5 Serdes driver

This series of patches provides the serdes driver for the Microchip Sparx5
ethernet switch.

The serdes driver supports the 10G and 25G serdes instances available in the
Sparx5.

The Sparx5 serdes support several interface modes with several speeds and also
allows the client to change the mode and the speed according to changing in the
environment such as changing cables from DAC to fiber.

The serdes driver is to be used by the Sparx5 switchdev driver that
will follow in subsequent series.

History:
--------
v3 -> v4:
    - Add a reg-names item to the binding description
    - Add a clocks item to the binding description
    - Removed the clock parameter from the configuration interface
    - Use the clock dt node to get the coreclock, and using that when 
      doing the actual serdes configuration
    - Added a clocks entry with a system clock reference to the serdes node in
      the device tree

v2 -> v3:
    - Sorted the Kconfig sourced folders
    - Sorted the Makefile included folders
    - Changed the configuration interface documentation to use kernel style

v1 -> v2: Fixed kernel test robot warnings
    - Made these structures static:
      - media_presets_25g
      - mode_presets_25g
      - media_presets_10g
      - mode_presets_10g
    - Removed these duplicate initializations:
      - sparx5_sd25g28_params.cfg_rx_reserve_15_8
      - sparx5_sd25g28_params.cfg_pi_en
      - sparx5_sd25g28_params.cfg_cdrck_en
      - sparx5_sd10g28_params.cfg_cdrck_en

Lars Povlsen (2):
  dt-bindings: phy: Add sparx5-serdes bindings
  arm64: dts: sparx5: Add Sparx5 serdes driver node

Steen Hegelund (2):
  phy: Add ethernet serdes configuration option
  phy: Add Sparx5 ethernet serdes PHY driver

 .../bindings/phy/microchip,sparx5-serdes.yaml |  296 ++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  196 ++
 drivers/phy/Kconfig                           |    3 +-
 drivers/phy/Makefile                          |    1 +
 drivers/phy/microchip/Kconfig                 |   12 +
 drivers/phy/microchip/Makefile                |    6 +
 drivers/phy/microchip/sparx5_serdes.c         | 2479 +++++++++++++++
 drivers/phy/microchip/sparx5_serdes_regs.h    | 2773 +++++++++++++++++
 include/linux/phy/phy-ethernet-serdes.h       |   30 +
 include/linux/phy/phy.h                       |    4 +
 10 files changed, 5799 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
 create mode 100644 drivers/phy/microchip/Kconfig
 create mode 100644 drivers/phy/microchip/Makefile
 create mode 100644 drivers/phy/microchip/sparx5_serdes.c
 create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h


base-commit: 3cea11cd5e3b00d91caf0b4730194039b45c5891
prerequisite-patch-id: b155844f6a5e402ba62a39b1a2b276c8378eeb49
prerequisite-patch-id: 1605ab05e4212d0bba88a858c6dd16df64194282
prerequisite-patch-id: 8d9741ec8a716b179e39d640b3aab8f934c2573d
-- 
2.29.2

