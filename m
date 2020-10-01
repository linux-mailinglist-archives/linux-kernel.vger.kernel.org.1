Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272642804AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbgJARJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:09:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65B62145D;
        Thu,  1 Oct 2020 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572155;
        bh=1p0eEdF9FbJzTq31CiVLhJbs04Yprl+x1HFIrGZk5N0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NHto5pzmeLmr492eQBxeZ9yNrpocVyGxn/Kp6sOVDNqfzy8IAOrkcH4gVOEE/YA4P
         1OZnMbEM7Ay57n80MoEjLeMMNa7+Wql6Ptct7zPEW5PUi7KvkQYOtodgGZ0SsqTt/Y
         IXQkOEH5afbBsYItiETh9g6ET/9+d4W24le8oRX0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/12] ARM: dts: imx6sl-warp: correct vendor in compatible to Revotics
Date:   Thu,  1 Oct 2020 19:07:58 +0200
Message-Id: <20201001170759.9592-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WaRP board (Wearable Development Platform) was apparently made by
Revolution Robotics, Inc (brand: Revotics), not by "Warp".  Correct the
vendor in compatible to reflect this.  The compatibles were not
documented in the bindings before.

Link: https://revotics.com/warp
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 408da704c459..9d7c8884892a 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -51,8 +51,8 @@
 #include "imx6sl.dtsi"
 
 / {
-	model = "WaRP Board";
-	compatible = "warp,imx6sl-warp", "fsl,imx6sl";
+	model = "Revotics WaRP Board";
+	compatible = "revotics,imx6sl-warp", "fsl,imx6sl";
 
 	memory@80000000 {
 		device_type = "memory";
-- 
2.17.1

