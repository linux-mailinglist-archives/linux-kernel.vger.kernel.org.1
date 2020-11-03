Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F082A3B29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgKCD4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:56:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41816 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKCD4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:56:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A33u26w033851;
        Mon, 2 Nov 2020 21:56:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604375762;
        bh=X3d7fEj6GQlhPkXOPyENDA1wb/DKkYnB8xBavf5etRQ=;
        h=From:To:CC:Subject:Date;
        b=siXxkzUj0gemuBgKm8YxjfY6TCgMYvAMs+23w+SWLjuopKivHlOS5dCDyqOjpthTB
         3zuTkgNiBaFXIPmixxQfjeqqOLHTDtCcOEPJ/6324wsC/0GNq1u/4wFLl8I9NYmwrx
         Qd9rnV7aGq6O4PlyaxGCreFhIC4Ib2tP3qassKuw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A33u2Gk090147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 21:56:02 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 21:56:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 21:56:00 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A33tuqL101157;
        Mon, 2 Nov 2020 21:55:57 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/9] PHY: Enhance Sierra SERDES
Date:   Tue, 3 Nov 2020 09:25:47 +0530
Message-ID: <20201103035556.21260-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

This series enhances Sierra SERDES for two things
1) Skip configuring SERDES if it's already configured by bootloader
2) Model PLLs within SERDES as DT in order to use any of the external
   clocks connected to the two external reference clock pins.

The DT binding in this series depends on
http://lore.kernel.org/r/1603898561-5142-1-git-send-email-sjakhade@cadence.com

Faiz Abbas (2):
  phy: ti: j721e-wiz: Don't configure wiz if its already configured
  phy: cadence: sierra: Don't configure if any plls are already locked

Kishon Vijay Abraham I (7):
  dt-bindings: phy: cadence-sierra: Add bindings for the PLLs within
    SERDES
  phy: ti: j721e-wiz: Get PHY properties only for "phy" subnode
  phy: cadence: cadence-sierra: Create PHY only for "phy" sub-nodes
  phy: cadence: Sierra: Fix PHY power_on sequence
  phy: cadence: sierra: Model reference receiver as clocks (gate clocks)
  phy: cadence: sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux
    clocks)
  phy: cadence: sierra: Enable pll_cmnlc and pll_cmnlc1 clocks

 .../bindings/phy/phy-cadence-sierra.yaml      |  89 +++-
 drivers/phy/cadence/phy-cadence-sierra.c      | 499 ++++++++++++++++--
 drivers/phy/ti/phy-j721e-wiz.c                |  39 +-
 3 files changed, 565 insertions(+), 62 deletions(-)

-- 
2.17.1

