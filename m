Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1272B94B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgKSOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:35:35 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:58692 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796534; x=1637332534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rdPD2tobjbKM87vuWHy5hhAuH/xzJsy0d0QgdbOGAiE=;
  b=nuUBbJ2+oKxbESJughjOJvOaJ6+N5UtT9+x0KRqNi177wzqEp4xY0CsU
   VHNzpE3EZORAwcfbStmFyU0Qqg/d1yETI751ThCdSbNGpWwx420PbuZM0
   5Z5xHU0ChiTFbPVtnXBV5ThjEztAhcBt7sjEXw0NnqUtF5I1p5u5pKaGA
   1pYMm2aSMmNZWH6X6aqQufHpLaJ6FHqR9CotQtQO1KEshByfRJ+lMuOkV
   k+tAtH4ZeIg7YQNv3pCJTDIQLuM3Fh6WbyimafcXcXt9lBBvicN0ugoqr
   gW4anwsy0RhXLzQg7nlU/ZCZJqNYkjtI/WfgudEmIfELZjSnr0P5OdnzY
   A==;
IronPort-SDR: Szn9cUG0csNZRSwfKWBQcEJxrSeZCA9YRtGs3L6vthhFkFvUMnJ2hQlyigsuTNGFhFFwutR45l
 0btv81E5Rk/GuOQBibuCFCXVEzLon+CoWHdCx4Pl0WPG+9Urb9QZfYbmBZj32OArKbPVt42Gjh
 bvbj9VIcXeDbDqxPtk9DzvK9cAp2tgJC/0ALS1FjTXNqiXHNfoZyOytJtB+4YFrsWac4nL4LO5
 GhXs1XIVYjCY4jKDtphgJaS99owpgjFeAwTNeDUdv7blLfMi/+ze7kJCNa7/+itTqKLP/C/9Wh
 BeI=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="104250935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:35:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:35:33 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 19 Nov 2020 07:35:32 -0700
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
Subject: [PATCH v3 0/4] Adding the Sparx5 Serdes driver
Date:   Thu, 19 Nov 2020 15:35:23 +0100
Message-ID: <20201119143527.1881404-1-steen.hegelund@microchip.com>
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

 .../bindings/phy/microchip,sparx5-serdes.yaml |  283 ++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  195 ++
 drivers/phy/Kconfig                           |    3 +-
 drivers/phy/Makefile                          |    1 +
 drivers/phy/microchip/Kconfig                 |   12 +
 drivers/phy/microchip/Makefile                |    6 +
 drivers/phy/microchip/sparx5_serdes.c         | 2464 +++++++++++++++
 drivers/phy/microchip/sparx5_serdes_regs.h    | 2773 +++++++++++++++++
 include/linux/phy/phy-ethernet-serdes.h       |   33 +
 include/linux/phy/phy.h                       |    4 +
 10 files changed, 5773 insertions(+), 1 deletion(-)
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

