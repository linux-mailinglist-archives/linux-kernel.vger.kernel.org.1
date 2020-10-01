Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861CF2804AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgJARJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJARJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:09:11 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E6F208B6;
        Thu,  1 Oct 2020 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601572151;
        bh=5RF+3QKzvNEeu0GoEEp5RFnf1hQ9kSVfrySSkPmb4/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=o0g2/DjoIsAj4tVCuickQpsAqAAq9hrX+TbQcqNcZoi3H9AC7pvAL1xCJN+coROaV
         +ZzrpTNR1ZWybmzRFlp4CZd0sQ5E754pVxr4lZmi2Z7LZUacbt9oJneLyS1BaIZ6T4
         trQel94qqdAns6vvscFnhMgplu47fwiWAxS6qm30=
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
Subject: [RFC 10/12] ARM: dts: imx6q-pico: fix board compatibles
Date:   Thu,  1 Oct 2020 19:07:57 +0200
Message-Id: <20201001170759.9592-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001170759.9592-1-krzk@kernel.org>
References: <20201001170759.9592-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four flavors of TechNexion PICO-IMX6 boards.  They have their
own DTSes, even though in Dwarf, Nymph and Pi are exactly the same.
They also have their own bindings so adjust the compatibles to match the
bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6q-pico-dwarf.dts  | 2 +-
 arch/arm/boot/dts/imx6q-pico-hobbit.dts | 2 +-
 arch/arm/boot/dts/imx6q-pico-nymph.dts  | 2 +-
 arch/arm/boot/dts/imx6q-pico-pi.dts     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-pico-dwarf.dts b/arch/arm/boot/dts/imx6q-pico-dwarf.dts
index 618d2743e1e9..479a63ed42af 100644
--- a/arch/arm/boot/dts/imx6q-pico-dwarf.dts
+++ b/arch/arm/boot/dts/imx6q-pico-dwarf.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and Dwarf baseboard";
-	compatible = "technexion,imx6q-pico", "fsl,imx6q";
+	compatible = "technexion,imx6q-pico-dwarf", "fsl,imx6q";
 };
diff --git a/arch/arm/boot/dts/imx6q-pico-hobbit.dts b/arch/arm/boot/dts/imx6q-pico-hobbit.dts
index 7a666507b456..b767131068f5 100644
--- a/arch/arm/boot/dts/imx6q-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6q-pico-hobbit.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and Hobbit baseboard";
-	compatible = "technexion,imx6q-pico", "fsl,imx6q";
+	compatible = "technexion,imx6q-pico-hobbit", "fsl,imx6q";
 };
diff --git a/arch/arm/boot/dts/imx6q-pico-nymph.dts b/arch/arm/boot/dts/imx6q-pico-nymph.dts
index fe5a7becc9e5..e8ad4c12b263 100644
--- a/arch/arm/boot/dts/imx6q-pico-nymph.dts
+++ b/arch/arm/boot/dts/imx6q-pico-nymph.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and Nymph baseboard";
-	compatible = "technexion,imx6q-pico", "fsl,imx6q";
+	compatible = "technexion,imx6q-pico-nymph", "fsl,imx6q";
 };
diff --git a/arch/arm/boot/dts/imx6q-pico-pi.dts b/arch/arm/boot/dts/imx6q-pico-pi.dts
index 9413f0a68f54..cc2394ddad6c 100644
--- a/arch/arm/boot/dts/imx6q-pico-pi.dts
+++ b/arch/arm/boot/dts/imx6q-pico-pi.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and PI baseboard";
-	compatible = "technexion,imx6q-pico", "fsl,imx6q";
+	compatible = "technexion,imx6q-pico-pi", "fsl,imx6q";
 };
-- 
2.17.1

