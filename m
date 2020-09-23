Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123FF276394
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWWJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:09:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33340 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgIWWJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:09:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9gtE113891;
        Wed, 23 Sep 2020 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600898982;
        bh=90gu8sDAtm7nhq30Nfc7+hlQG65C8KvARXzPAEUOfVk=;
        h=From:To:CC:Subject:Date;
        b=WKvOKXBgbGigoD/8Oj+L6m9ufNy+kf5Md+PBKKYu6blz3z7wVpnMd3HCRjXzPeVIs
         lJRVdTFQCW6emY/qmEijNNI1PfKt6KxZSyyN99ybntQnsFNat+Ln6cTVD5iY7MbVEy
         nYrev8O5zUTlTbYxgOeOKq+cwQ9B0bExxwaH3Bys=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NM9gLJ080232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 17:09:42 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 17:09:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 17:09:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NM9fA2094485;
        Wed, 23 Sep 2020 17:09:42 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 0/4] arm64: dts: ti: k3-j7200: add dma and mcu cpsw
Date:   Thu, 24 Sep 2020 01:09:34 +0300
Message-ID: <20200923220938.30788-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series adds DT nodes for TI J7200 SoC
- Ringacc and UDMA nodes for Main and MCU NAVSS, which are compatible
  with J721E Soc, to enable DMA support
- MCU CPSW2g DT nodes to enable networking and board data

Changes in v4:
 - fixed comments from Suman Anna <s-anna@ti.com>

Changes in v3:
 - rebase
 - updated dependencies
 - added tested-by

Changes in v2:
 - fixed DT build warnings (Nishanth Menon)

v3: https://lore.kernel.org/patchwork/cover/1308044/
v2: https://lore.kernel.org/patchwork/cover/1302290/
v1: https://lore.kernel.org/patchwork/cover/1301067/

Grygorii Strashko (3):
  arm64: dts: ti: k3-j7200-main: add main navss cpts node
  arm64: dts: ti: k3-j7200-mcu: add mcu cpsw nuss node
  arm64: dts: ti: k3-j7200-common-proc-board: add mcu cpsw nuss pinmux
    and phy defs

Peter Ujfalusi (1):
  arm64: dts: ti: k3-j7200: add DMA support

 .../dts/ti/k3-j7200-common-proc-board.dts     |  45 +++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  48 +++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 118 ++++++++++++++++++
 3 files changed, 211 insertions(+)

-- 
2.17.1

