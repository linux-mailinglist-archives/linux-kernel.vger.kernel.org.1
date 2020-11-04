Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9197B2A6169
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKDKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:21:33 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:34522 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgKDKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:21:31 -0500
X-Greylist: delayed 1861 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 05:21:30 EST
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kaFQw-0000rn-Se; Wed, 04 Nov 2020 10:50:26 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from roc (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 0A49oPc5008113
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 4 Nov 2020 10:50:25 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices on rk3399-roc-pc boards.
Date:   Wed,  4 Nov 2020 10:49:45 +0100
Message-Id: <20201104094950.2096-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichll@fivetechno.de;1604485291;64016ac6;
X-HE-SMSGID: 1kaFQw-0000rn-Se
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced async probe on mmc devices can shuffle block IDs.
Pin them to fixed values to ease booting in evironments where UUIDs
are not practical. Use newly introduced aliases for mmcblk devices from [1].

[1]
https://patchwork.kernel.org/patch/11747669/

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index e7a459fa4322..bc9482b59428 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -13,6 +13,11 @@ / {
 	model = "Firefly ROC-RK3399-PC Board";
 	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
 
+	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &sdhci;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
-- 
2.28.0

