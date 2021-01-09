Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD32D2F0330
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbhAITat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbhAITas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:30:48 -0500
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jan 2021 11:30:03 PST
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F58C061786;
        Sat,  9 Jan 2021 11:30:02 -0800 (PST)
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 3E49F2C48D;
        Sat,  9 Jan 2021 19:10:39 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id A41B25FC9E;
        Sat,  9 Jan 2021 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1610219389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XpgzSghv0Wxw9asdQngnpZPIOGMcIgZPVkLOdIlJRYI=;
        b=vvlHvtUklHiCwxZdUWM0dthY+wn4Bmk4BSTUcbVWYnbHPyXiNKSoxoCz5QPu+i/Fja/jj1
        EksCKjwXI5JDkMR+Bu3Fg+AdAjsuG2UD0O8Bwlc5TOVFJBELBG+sGF52V+Q2yDmHFJrBl9
        yNob0BBAx8Wk4Utycq9hfVUXm8jTm6w=
Received: from localhost.localdomain (fttx-pool-185.76.99.44.bambit.de [185.76.99.44])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 8C57940093;
        Sat,  9 Jan 2021 19:09:48 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Jimin Wang <jimin.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sin_wenjiehu <sin_wenjiehu@mediatek.com>, Wenbin.Mei@mediatek.com
Subject: [PATCH] dts64: mt7622: fix slow sd card access
Date:   Sat,  9 Jan 2021 20:09:37 +0100
Message-Id: <20210109190937.42409-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: cff539b1-4803-4f04-9e43-eb68cec062bb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

- change sdcard (mmc1) to uhs by change vqmmc-supply to 1V8 because driver
  maps pinctrl depending on this
- add reset-control for mmc1 like it's done for mmc0/emmc

Fixes: 2c002a3049f7 ("arm64: dts: mt7622: add mmc related device nodes")
Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 3 ++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                 | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 2f77dc40b9b8..916ca89ab8eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -232,10 +232,11 @@ &mmc1 {
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
+	mmc-hs200-1_8v;
 	r_smpl = <1>;
 	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
 	assigned-clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>;
 	assigned-clock-parents = <&topckgen CLK_TOP_UNIV48M>;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 5b9ec032ce8d..7c6d871538a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -698,6 +698,8 @@ mmc1: mmc@11240000 {
 		clocks = <&pericfg CLK_PERI_MSDC30_1_PD>,
 			 <&topckgen CLK_TOP_AXI_SEL>;
 		clock-names = "source", "hclk";
+		resets = <&pericfg MT7622_PERI_MSDC1_SW_RST>;
+		reset-names = "hrst";
 		status = "disabled";
 	};
 
-- 
2.25.1

