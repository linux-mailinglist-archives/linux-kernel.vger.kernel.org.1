Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C326C2E2633
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgLXLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:18:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35592 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgLXLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:18:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGcm2075986;
        Thu, 24 Dec 2020 05:16:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608808598;
        bh=qzVsPalaWPdGH8DnIx8rf2HnmAsNI6XCVFYlcb+Zryc=;
        h=From:To:CC:Subject:Date;
        b=OAcZQSGMg5rxRuJ+kn8IjeShKYydM1PHSFhqMiG9jMOkSqc1i6J3ODsNuTVV3SK92
         HXP7MgJuoUsH6a5VUJUdrSydVVVkKmt8MSe0pRYBJ8CYlVvtMRTbos/t9YjawRY/5J
         pbnU5k8DAjPo0BSJjJs3qA+XLw9aYzZR4qQexgbI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBGcE7093043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:16:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:16:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:16:37 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBGWG6116630;
        Thu, 24 Dec 2020 05:16:34 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 00/15] PHY: Add support in Sierra to use external clock
Date:   Thu, 24 Dec 2020 16:46:12 +0530
Message-ID: <20201224111627.32590-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds support in Sierra driver to use external clock.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [2]

Changes from v2:
1) Add depends on COMMON_CLK in Sierra
2) Add modelling PLL_CMNLC and PLL_CMNLC1 as clocks into a separate
patch
3) Disable clocks in Sierra driver remove

Changes from v1:
1) Remove the part that prevents configuration if the SERDES is already
   configured and focus only on using external clock and the associated
   cleanups
2) Change patch ordering
3) Use exclusive reset control APIs
4) Fix error handling code
5) Include DT patches in this series (I can send this separately to DT
MAINTAINER once the driver patches are merged)

[1] -> http://lore.kernel.org/r/20201103035556.21260-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201222070520.28132-1-kishon@ti.com

Kishon Vijay Abraham I (15):
  phy: cadence: Sierra: Fix PHY power_on sequence
  phy: ti: j721e-wiz: Invoke wiz_init() before
    of_platform_device_create()
  dt-bindings: phy: cadence-sierra: Add bindings for the PLLs within
    SERDES
  phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link"
    subnode
  phy: cadence: cadence-sierra: Create PHY only for "phy" or "link"
    sub-nodes
  phy: cadence: cadence-sierra: Move all clk_get_*() to a separate
    function
  phy: cadence: cadence-sierra: Move all reset_control_get*() to a
    separate function
  phy: cadence: cadence-sierra: Explicitly request exclusive reset
    control
  phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
  phy: cadence: sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux
    clocks)
  phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks
  arm64: dts: ti: k3-j721e-main: Add DT nodes for clocks within Sierra
    SERDES
  arm64: dts: ti: k3-j721e-main: Fix external refclk input to SERDES
  arm64: dts: ti: k3-j721e-common-proc-board: Use external clock for
    SERDES
  arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as
    "phy"

 .../bindings/phy/phy-cadence-sierra.yaml      |  89 ++-
 .../dts/ti/k3-j721e-common-proc-board.dts     |  57 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 186 ++++--
 drivers/phy/cadence/Kconfig                   |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c      | 544 ++++++++++++++++--
 drivers/phy/ti/phy-j721e-wiz.c                |  21 +-
 6 files changed, 810 insertions(+), 88 deletions(-)

-- 
2.17.1

