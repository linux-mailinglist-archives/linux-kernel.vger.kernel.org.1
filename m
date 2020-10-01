Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7975C2804B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgJARJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:09:21 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C3721D24;
        Thu,  1 Oct 2020 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572160;
        bh=EHDSFDUu1XrCiwgQ9v7UroEYnBC6MstIZ2/WKeeNUVg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=soradmhiTA/UXgXQgkpYtdN4zOaP3PygSj0L1UpiHC+6Z+kZMd5Exg/zcBkGVJu92
         wOzNEaxaK6bLojbdifoCOFCKc1x/Ph4/3zFYtfJZ13EdnrqRpEj85OdiRFVdSq2rJz
         COWeY1/XZBkMj+N6mPdfVbdOqh8gmgHger6zydHk=
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
Subject: [PATCH 12/12] ARM: dts: imx7s-warp: correct vendor in compatible to Element14
Date:   Thu,  1 Oct 2020 19:07:59 +0200
Message-Id: <20201001170759.9592-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WaRP7 board (Wearable Development Platform) was apparently made by
Element14, not by "Warp".  Correct the  vendor in compatible to reflect
this.  The compatibles were not documented in the bindings before.

Link: https://www.element14.com/community/docs/DOC-79058
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index d6b4888fa686..569bbd84e371 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -10,8 +10,8 @@
 #include "imx7s.dtsi"
 
 / {
-	model = "Warp i.MX7 Board";
-	compatible = "warp,imx7s-warp", "fsl,imx7s";
+	model = "Element14 Warp i.MX7 Board";
+	compatible = "element14,imx7s-warp", "fsl,imx7s";
 
 	memory@80000000 {
 		device_type = "memory";
-- 
2.17.1

