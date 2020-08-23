Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B883624EC52
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgHWJFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 05:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgHWJFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:05:21 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6C32072D;
        Sun, 23 Aug 2020 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598173520;
        bh=EO6G5kF0VLrz8QAHobZGaL6LPKAV21OlmZuFNeANWig=;
        h=From:To:Cc:Subject:Date:From;
        b=klvOYVj04gO+2yS9OMaUrIFRnAGCYhbx28vAC8Z8P5gaCf8UPY+Gz86E9XbfjSbNV
         p8kRSlWByGyFSGWBRyyECJnNSFD+41vTruN2M9qu98IOpTDQsBq0Ana56hfs5sfcZY
         01rdrGxKA23J9Yo/bxsk615u1GX9F+Fn+zo2GiPI=
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
Subject: [PATCH 1/3] arm64: dts: imx8mm-evk: remove orphaned pinctrl-names property
Date:   Sun, 23 Aug 2020 11:05:03 +0200
Message-Id: <20200823090505.5579-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "pinctrl-names" property in iomux node does not make sense on its
own (without "pinctrl-X").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 0f1d7f8aeac4..19a22d0d0730 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -366,8 +366,6 @@
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-- 
2.17.1

