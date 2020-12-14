Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC112D91F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438194AbgLNDAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 22:00:47 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54544 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbgLNDAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 22:00:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 4BC2020139DE;
        Mon, 14 Dec 2020 11:00:00 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MJZhUOtKpwbY; Mon, 14 Dec 2020 11:00:00 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 329DE20139A0;
        Mon, 14 Dec 2020 11:00:00 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 3718AC01FAD;
        Mon, 14 Dec 2020 11:00:00 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 2B1BC2000CF; Mon, 14 Dec 2020 11:00:00 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v1 1/4] devicetree: phy: rockchip-emmc optional add vendor prefix
Date:   Mon, 14 Dec 2020 10:59:42 +0800
Message-Id: <20201214025946.25753-2-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk>
References: <20201214025946.25753-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation and add the vendor prefix to the optional
properties referred in vendor-prefixes.yaml.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 .../bindings/phy/rockchip-emmc-phy.txt        | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index 00aa2d349e55..3a55d8086868 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -13,14 +13,15 @@ Optional properties:
 		access to it), it is strongly suggested.
 		See ../clock/clock-bindings.txt for details.
  - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
- - drive-impedance-ohm: Specifies the drive impedance in Ohm.
-                        Possible values are 33, 40, 50, 66 and 100.
-                        If not set, the default value of 50 will be applied.
- - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
-                           If not set, pull-down is not used.
- - output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
-                           If not set, the register defaults to 0x4.
-                           Maximum value 0xf.
+ - rockchip,drive-impedance-ohm: Specifies the drive impedance in Ohm.
+                                 Possible values are 33, 40, 50, 66 and 100.
+                                 If not set, the default value of 50 will be
+                                 applied.
+ - rockchip,enable-strobe-pulldown: Enable internal pull-down for the strobe
+                                    line.  If not set, pull-down is not used.
+ - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec register.
+                                    If not set, the register defaults to 0x4.
+                                    Maximum value 0xf.
 
 Example:
 
@@ -37,7 +38,7 @@ grf: syscon@ff770000 {
 		reg = <0xf780 0x20>;
 		clocks = <&sdhci>;
 		clock-names = "emmcclk";
-		drive-impedance-ohm = <50>;
+		rockchip,drive-impedance-ohm = <50>;
 		#phy-cells = <0>;
 	};
 };
-- 
2.20.1

