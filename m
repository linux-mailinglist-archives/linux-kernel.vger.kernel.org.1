Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6224ECFF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHWLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 07:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgHWLP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:15:29 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A045B20774;
        Sun, 23 Aug 2020 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598181328;
        bh=h08QRaaw1ypKOkPJ9otVWYimg697b3mMn5IOwkzYYuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgjZjO9YkNVgWWYlmIXPx5uzxwYtj0efm2RFwdrGI6lfPjt3Glf+msQO4PAV+S5Zs
         L9c7GRN1kITZlpvZQE800G4J7U4IMNgGtbCR+vsrUKyBfNcbRx37heUL0wxQuVjA+V
         i0AzmkQJHMDGm/vqNycrGcTxf5pYdJaRZzyzYcY0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/5] arm64: dts: imx8mq-thor96: Replace deprecated phy reset properties
Date:   Sun, 23 Aug 2020 13:15:08 +0200
Message-Id: <20200823111508.1165-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823111508.1165-1-krzk@kernel.org>
References: <20200823111508.1165-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred properties of phy node instead of deprecated
phy-reset-gpios (and others).  This avoids copying deprecated code into
future DTSes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
index b4795a032fa2..5d5aa6537225 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
@@ -122,7 +122,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 	phy-handle = <&ethphy>;
 	fsl,magic-packet;
 	status = "okay";
@@ -134,6 +133,7 @@
 		ethphy: ethernet-phy@3 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <3>;
+			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.17.1

