Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40B2F401E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbhALXQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbhALXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:16:44 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AECC061795;
        Tue, 12 Jan 2021 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SlTp6snUwgt9T9iYILfU25FJTOenOYbmfd0naHgcAoQ=; b=IM7XXlG7FMNXwVxkXNBszy6eCY
        Br2rm5EYUJ1SfcvQ7nN541bQnBOKWLr8fflCXWz45jwgoSONjvcjDcAw4ynHbcfeZvdPEfOBc88dw
        jXR8u8J69pM1zAEOt81JS14wAc7GKeG9/g5l5Hsp9fkIZSirm0Rwzs6xGsfgCQiChtok=;
Received: from p200300ccff1586001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff15:8600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStN-0005Si-BV; Wed, 13 Jan 2021 00:16:01 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kzStN-0007o6-35; Wed, 13 Jan 2021 00:16:01 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/4] ARM: dts: imx6sl-tolino-shine2hd: add second uart
Date:   Wed, 13 Jan 2021 00:15:46 +0100
Message-Id: <20210112231549.29957-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112231549.29957-1-andreas@kemnade.info>
References: <20210112231549.29957-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another uart next to the console uart used by vendor uboot and
kernel, enable it and document its location.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index e17c75c360f2..6ea5f918d059 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -340,7 +340,6 @@
 			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
 			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
 			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
-			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
 		>;
 	};
 
@@ -400,6 +399,13 @@
 		>;
 	};
 
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6SL_PAD_KEY_ROW6__UART4_TX_DATA 0x1b0b1
+			MX6SL_PAD_KEY_COL6__UART4_RX_DATA 0x1b0b1
+		>;
+	};
+
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
@@ -549,6 +555,13 @@
 	status = "okay";
 };
 
+&uart4 {
+	/* TP198, next to J4, SMD pads */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-- 
2.20.1

