Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469AA2A2C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKBOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:18:14 -0500
Received: from mail2.sp2max.com.br ([138.185.4.9]:45238 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKBOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:16:54 -0500
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPSA id 500047B04AC;
        Mon,  2 Nov 2020 11:16:47 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Mon,  2 Nov 2020 11:16:40 -0300
Message-Id: <1604326600-39544-1-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 500047B04AC.A170F
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ethernet PHY on the Bananapi M1 has the RX and TX delays enabled on
the PHY, using pull-ups on the RXDLY and TXDLY pins.

Fix the phy-mode description to correct reflect this so that the
implementation doesn't reconfigure the delays incorrectly. This
happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
rx/tx delay config").

Fixes: 8a5b272fbf44 ("ARM: dts: sun7i: Add Banana Pi board")
Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index bb3987e101c2..0b3d9ae75650 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -132,7 +132,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-supply = <&reg_gmac_3v3>;
 	status = "okay";
 };
-- 
2.18.4

