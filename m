Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949E24EC55
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgHWJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 05:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgHWJFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:05:24 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F3F20FC3;
        Sun, 23 Aug 2020 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598173523;
        bh=/hAdfkHYpIvG+bGuLetMOOvdC01F1x0vwIdd3TjtKP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGH5fPnbT6vyzzVlewpDAGMlR7cy/l54O9B/qRSgJG1lj/yU0DEsfYMJTr+5t0OgR
         0Ch78pQSJkWRBVlyI3px31bTm3WX3jtczTRsrohb3NdbiDKMYnvaRXeSLmpVWOXTvx
         aQrvQF23KGfv1g2woAwm1y8YZDegzTZiu9sMtA2E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] arm64: dts: imx8mn-evk: remove orphaned pinctrl-names property
Date:   Sun, 23 Aug 2020 11:05:04 +0200
Message-Id: <20200823090505.5579-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823090505.5579-1-krzk@kernel.org>
References: <20200823090505.5579-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "pinctrl-names" property in iomux node does not make sense on its
own (without "pinctrl-X").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 98f5324b1dbe..48892ed562b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -174,8 +174,6 @@
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x3
-- 
2.17.1

