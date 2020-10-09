Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DA2883F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgJIHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:52:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40242 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgJIHwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:52:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38BDE1A0BC4;
        Fri,  9 Oct 2020 09:52:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F35DD1A0BD9;
        Fri,  9 Oct 2020 09:52:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C51F240310;
        Fri,  9 Oct 2020 09:52:11 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org,
        aford173@gmail.com, daniel.baluta@nxp.com, shengjiu.wang@nxp.com,
        peter.chen@nxp.com, alifer.wsdm@gmail.com, abel.vesa@nxp.com,
        yibin.gong@nxp.com, jun.li@nxp.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] arm64: dts: imx8mp-evk: Correct WDOG_B pin configuration
Date:   Fri,  9 Oct 2020 15:47:47 +0800
Message-Id: <1602229667-13165-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
References: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different revision of i.MX8MP EVK boards may have different external
pull up registor design, some are enabled while some are NOT, to make
sure the WDOG_B pin works properly, better to enable internal pull up
resistor. Since enabling internal pull up resistor is NOT harmful and
having benefit of flexibility on different board design, just enable
it for all i.MX8MP boards.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index ad66f12..908b92b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -262,7 +262,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xc6
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0x166
 		>;
 	};
 };
-- 
2.7.4

