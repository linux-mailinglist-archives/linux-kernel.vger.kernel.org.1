Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3C21E9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGNHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 03:12:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45060 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNHML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:12:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBBB3200161;
        Tue, 14 Jul 2020 09:12:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45668200ED4;
        Tue, 14 Jul 2020 09:12:06 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9435D402BB;
        Tue, 14 Jul 2020 15:12:01 +0800 (SGT)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        meenakshi.aggarwal@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: [v2 PATCH] dts: arm64: lx2160a-rdb: fix shunt-resistor value
Date:   Tue, 14 Jul 2020 15:05:45 +0800
Message-Id: <20200714070545.2051-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Fix value of shunt-resistor property.
The LX2160A-RDB has 500 uOhm shunt for
the INA220, not 1000 uOhm. Unless
it will get wrong power consumption(1/2)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
v2:
	- update description

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 22d0308..54fe8cd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -121,7 +121,7 @@
 			power-monitor@40 {
 				compatible = "ti,ina220";
 				reg = <0x40>;
-				shunt-resistor = <1000>;
+				shunt-resistor = <500>;
 			};
 		};
 
-- 
2.7.4

