Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4D2CBDBA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgLBNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:05:50 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:37213 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgLBNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606914348; x=1638450348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zgaebY5dPE0zVjAwbkSMcNdgX8pT4RVftG0mAD8dYiw=;
  b=wV6s46CF2fh02sHLOhfSfzQzp1S0kifK5Vcmjh0TBrPw5qnYt8XWkfBL
   VSWksulmJYVBfC511i9Hqavw96FQvRRWcaZV6rzF2l6T4akcMDtdO3TAQ
   yX+aA21LOO3hSAMUvgMACcg6XyqB3pxxmLVvkAy36ABHZZZ7uHNoL5czY
   JO0d4JrD1gw2b9JD/lF2Lqx3FhR7+SRiq4j8K5o0tENIqt+hzCWbK5/6W
   8QnWeHPTYS06WlS4woANEofe6ELjPiImxGfl/1ZxB9XFHUQFV8edexEVu
   goTLpEhVk8asFc9gT++VWfIUjkFZODyjrw44rqIoixcoWhAs+GkAhHmB/
   w==;
IronPort-SDR: fB7RP4/DaK/cj8YJcSrxs6Q86LtoxfVnIunPY9KrUKRlBKTwxmG/xGTtTBB7rZ+HDQYmy4VfPr
 aV4RAeY/Qiz7jRiJqmsCAKjqb6fyHib7pnOU5BJM+ibw5hsu83kea8rsqVt4s977fz+M7enEjr
 1VE5CTqyRzROV6g6aYZehyDgo2dJo7duuZz/8aCf2JU0uJisOwr8hUkIORrjDSmMnbbIlAmoWC
 pkAiIwH8YdKNGb6GP82xOhTJ6S8hWxaK38JoL97CeXWomxO2/cEvFOtIbMiKjDB7Lx/gxfW9ZW
 uj8=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101125039"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 06:04:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 06:04:43 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 06:04:41 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/4] Adding the Sparx5 Serdes driver
Date:   Wed, 2 Dec 2020 14:04:34 +0100
Message-ID: <20201202130438.3330228-1-steen.hegelund@microchip.com>
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
v6 -> v7:
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

v5 -> v6:
     Series error: This had the same content as v5

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

 .../bindings/phy/microchip,sparx5-serdes.yaml |  100 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |    8 +
 drivers/phy/Kconfig                           |    3 +-
 drivers/phy/Makefile                          |    1 +
 drivers/phy/microchip/Kconfig                 |   12 +
 drivers/phy/microchip/Makefile                |    6 +
 drivers/phy/microchip/sparx5_serdes.c         | 2434 +++++++++++++++
 drivers/phy/microchip/sparx5_serdes.h         |  129 +
 drivers/phy/microchip/sparx5_serdes_regs.h    | 2695 +++++++++++++++++
 include/linux/phy/phy-ethernet-serdes.h       |   30 +
 include/linux/phy/phy.h                       |    4 +
 11 files changed, 5421 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
 create mode 100644 drivers/phy/microchip/Kconfig
 create mode 100644 drivers/phy/microchip/Makefile
 create mode 100644 drivers/phy/microchip/sparx5_serdes.c
 create mode 100644 drivers/phy/microchip/sparx5_serdes.h
 create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
 create mode 100644 include/linux/phy/phy-ethernet-serdes.h

-- 
2.29.2

