Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2562EAE0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbhAEPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:16:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40006 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAEPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:16:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 105FETW6012746;
        Tue, 5 Jan 2021 09:14:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609859669;
        bh=nuX80bf/fKM0rAVHKejrKdp4IPPhNW6wiM5mhLEB56I=;
        h=From:To:CC:Subject:Date;
        b=ny8HljZ6dA8lPRvfSgcOTWDKGNlIUs9e2XMl54A74WcSb/zUrnQnB/ZI/FQQ7CptC
         MLZLr2lFINqYi1EySUUGMFY82ZKNK3ogg5X/bU5iO0oH2joHJjPD/VwHva1ji0w1ua
         0wisH9hvlNpEFB3eU2xciBqk3h0flJij9raVzTF8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 105FETFA098336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 09:14:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 09:14:29 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 09:14:29 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 105FEPOC005961;
        Tue, 5 Jan 2021 09:14:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] PCI: J7200/J721E PCIe bindings
Date:   Tue, 5 Jan 2021 20:44:15 +0530
Message-ID: <20210105151421.23237-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds DT nodes in order to get PCIe working in J7200.
Also includes couple of fixes for J721e.

v1 of the patch series can be found @ [1]
v2 of the patch series can be found @ [2]
v3 of the patch series can be found @ [3]

Changes from v3:
1) Removed Fixes tag as the patches doesn't have to be backported

Changes from v2:
1) Moved serdes_refclk node out of interconnect node and also replaced
   "_" with "-"

Changes from v1:
1) Include only the device tree patches here (the binding patch is sent
separately)
2) Include couple of patches that fixes J721E DTS.

[1] -> http://lore.kernel.org/r/20201102101154.13598-1-kishon@ti.com
[2] -> http://lore.kernel.org/r/20201210130747.25436-1-kishon@ti.com
[3] -> http://lore.kernel.org/r/20210104122232.24071-1-kishon@ti.com

Kishon Vijay Abraham I (6):
  arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
  arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
    pcieX_ctrl
  arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
  arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
  arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe

 .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 111 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  52 ++------
 3 files changed, 157 insertions(+), 44 deletions(-)

-- 
2.17.1

