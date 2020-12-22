Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB42E0662
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgLVHGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:06:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgLVHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:06:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75R2e064004;
        Tue, 22 Dec 2020 01:05:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608620727;
        bh=IlOg2YWoIM40jZe6vAZLiNt+o8w4cd/ybCfCQGDBDRY=;
        h=From:To:CC:Subject:Date;
        b=zB5PSQK2LcL2gJOLSMvcgQeyNMN5SekGbDCTa0gB99uEMpJCd+4figFoXYHMo2ScV
         8ttFf0iKxTRIefJedbyZzFmZrrBkCi1+lyYzLGYJKTB2wluyzYdGu/x1aCCzTv+gSw
         8UdhPXOGlvAPy9L2DxX7igle/ueMN5BAWH1yNQNM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BM75RLI014570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 01:05:27 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 01:05:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 01:05:26 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BM75N79050344;
        Tue, 22 Dec 2020 01:05:23 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nishanth Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 00/14] PHY: Add support in Sierra to use external clock
Date:   Tue, 22 Dec 2020 12:35:06 +0530
Message-ID: <20201222070520.28132-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of the patch series can be found @ [1]

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

Kishon Vijay Abraham I (14):
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
 drivers/phy/cadence/phy-cadence-sierra.c      | 543 ++++++++++++++++--
 drivers/phy/ti/phy-j721e-wiz.c                |  21 +-
 5 files changed, 808 insertions(+), 88 deletions(-)

-- 
2.17.1

