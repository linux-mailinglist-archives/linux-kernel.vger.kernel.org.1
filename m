Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288F727897A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgIYNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:25:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59390 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYNZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:25:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14DCD1A08DB;
        Fri, 25 Sep 2020 15:25:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 08BC21A08C6;
        Fri, 25 Sep 2020 15:25:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BFDF32030E;
        Fri, 25 Sep 2020 15:25:06 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/9] arm64: dts: layerscape: update MAC nodes with PHY information
Date:   Fri, 25 Sep 2020 16:24:54 +0300
Message-Id: <20200925132503.30206-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set aims to add the necessary DTS nodes to complete the
MAC/PCS/PHY representation on DPAA2 devices. The external MDIO bus nodes
and the PHYs found on them are added, along with the PCS MDIO internal
buses and their PCS PHYs. Also, links to these PHYs are added from the
DPMAC node.

Ioana Ciornei (9):
  arm64: dts: ls1088a: add external MDIO device nodes
  arm64: dts: ls1088ardb: add QSGMII PHY nodes
  arm64: dts: ls1088ardb: add necessary DTS nodes for DPMAC2
  arm64: dts: ls208xa: add the external MDIO nodes
  arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
  arm64: dts: ls2088ardb: add PHY nodes for the AQR405 PHYs
  arm64: dts: ls208xa: add PCS MDIO and PCS PHY nodes
  arm64: dts: lx2160a: add PCS MDIO and PCS PHY nodes
  arm64: dts: lx2160ardb: add nodes for the AQR107 PHYs

 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 119 +++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  81 ++++++
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 118 ++++++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 242 +++++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  32 +++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 252 ++++++++++++++++++
 6 files changed, 844 insertions(+)

-- 
2.25.1

