Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE02E2679
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgLXLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:44:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39634 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:44:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBh1Ln083251;
        Thu, 24 Dec 2020 05:43:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608810181;
        bh=rr0cE6DzyCJbOPZIqV/X2xnqfFA6IzKfeSOb7Pm7xXU=;
        h=From:To:CC:Subject:Date;
        b=T4HIZJv6X+CKyBt7Mxkxm5OElrnXrnviEtOxSV8iDQrdhxjidXbkYV3mev4EE6BAJ
         zvbLbkQRq1eCyYn+hEA9vZgQCtkueurDC+WKsgxkhD4kSHYEsouhjOiYlhQDk5U0JZ
         as71RzX3J5dSIERJdxpjauBMnrpewQReaztYCD30=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBh150126212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:43:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:43:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:43:00 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBgtwT026267;
        Thu, 24 Dec 2020 05:42:56 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Peter Rosin <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/7] AM64: Add SERDES bindings and driver support
Date:   Thu, 24 Dec 2020 17:12:43 +0530
Message-ID: <20201224114250.1083-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 uses the same SERDES as in J7200, however AM642 EVM doesn't
have a clock generator (unlike J7200 base board). Here the clock from
the SERDES has to be routed to the PCIE connector. This series adds
support to drive reference clock output from SERDES and also adds
SERDES (torrent) and SERDES wrapper (WIZ) bindings.

Kishon Vijay Abraham I (7):
  dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES
    Wrapper
  dt-bindings: phy: ti,phy-j721e-wiz: Add binding for phy_en_refclk
  dt-bindings: phy: cadence-torrent: Add binding for refclk driver
  dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
  phy: ti: j721e-wiz: Configure full rate divider for AM64
  phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
  phy: cadence-torrent: Add support to drive refclk out

 .../bindings/phy/phy-cadence-torrent.yaml     |  17 ++
 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  23 ++-
 drivers/phy/cadence/phy-cadence-torrent.c     | 158 ++++++++++++++++++
 drivers/phy/ti/phy-j721e-wiz.c                | 158 +++++++++++++++++-
 include/dt-bindings/mux/ti-serdes.h           |   4 +
 5 files changed, 354 insertions(+), 6 deletions(-)

-- 
2.17.1

