Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043392CBD81
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbgLBMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:54:16 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49762 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgLBMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606913655; x=1638449655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GpfJdoYQMDWGTf2b/WVM97g2DEIhXslGxEnYGVO9X24=;
  b=ev7yLRqEoDYJbSOucmJIySjDWT2kxeLIRciZU1WCMs28jM0jHhYRhNpK
   JjA+VsJxJRbZgT/CkxVO191xsD8EyDNj+5Wg8dpdGooXjUScTuCdGEt+E
   t6eB6rEO2KPLDYQtKXsC0FssDUHF5k75soFSfgO1tJsKi3nPMs8/JFCvr
   NB1/DH4aZ8rhb5EMNODc7yi6IrLi3FMJCmKofwslwXPyhfksUwOWHKFRf
   pJ2DMq9pMWFWbjE+V1ESO7lPSX832OupkO40T2ZUhoB2VKL3pGt/whhQs
   rcRhP2FbJpOCvW0bJqRipRz+alGrTzLmxDptiyfbBnX4hCow2qKzCmv3b
   Q==;
IronPort-SDR: Yh+dUQX6NLUgtycJnhNNP4a9I++b4q+8LktLUpSUHtW9PtJSILR1RAXmoh1EIf8jkSaaU1PXE4
 pZyr/YittwyZL1rg6e45g4zRoVD0RMx0UxsrjrV4M3eaaRvUj5pGohZyq5Fyc+oadJlYUjmKi4
 G+sv30V1tAj8w7HEgmN+Meg/VhZOFcufvLaxFedjzs9NmZMjUAxOk1Z494dbSugaFEb4d7hKoY
 YkVpsJqn+fpjA0I8apr/Im1mDo6IjKT6ztxMGALa2nCpDOgYjV2NBONqVJgSt15fP2v3Drm1SE
 adk=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101123438"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 05:53:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 05:53:09 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 05:53:07 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] Adding the Sparx5 Serdes driver
Date:   Wed, 2 Dec 2020 13:52:50 +0100
Message-ID: <20201202125254.3329835-1-steen.hegelund@microchip.com>
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
v5 -> v6:
    This series changes the way the IO targets are provided to the driver.
    Now only one IO range is available in the DT, and the driver has a table
    to map its targets (as their order is still not sequential), thus reducing
    the DT needed information and binding requirements.
    The register access macros have been converted to functions.

    - Bindings:
      - reg prop: minItems set to 1
      - reg-names prop: removed
    - Driver
      - Use one IO range and map targets via this.
      - Change register access macros to use functions.
      - Provided a new header files with reg access functions.
    - Device tree
      - Provide only one IO range

v4 -> v5:
    - Bindings:
      - Removed .yaml from compatible string
      - reg prop: removed description and added minItems
      - reg-names prop: removed description and added const name list and minItems
      - #phy-cells prop: removed description and added maxItems
    - Configuration interface
      - Removed include of linux/phy.h
      - Added include of linux/types.h
    - Driver
       - Added include of linux/phy.h

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

 .../bindings/phy/microchip,sparx5-serdes.yaml |  387 +++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  196 ++
 drivers/phy/Kconfig                           |    3 +-
 drivers/phy/Makefile                          |    1 +
 drivers/phy/microchip/Kconfig                 |   12 +
 drivers/phy/microchip/Makefile                |    6 +
 drivers/phy/microchip/sparx5_serdes.c         | 2480 +++++++++++++++
 drivers/phy/microchip/sparx5_serdes_regs.h    | 2773 +++++++++++++++++
 include/linux/phy/phy-ethernet-serdes.h       |   30 +
 include/linux/phy/phy.h                       |    4 +
 10 files changed, 5891 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
 create mode 100644 drivers/phy/microchip/Kconfig
 create mode 100644 drivers/phy/microchip/Makefile
 create mode 100644 drivers/phy/microchip/sparx5_serdes.c
 create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

-- 
2.29.2

