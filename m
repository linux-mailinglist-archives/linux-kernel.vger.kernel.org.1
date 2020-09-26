Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1921279AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgIZQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730079AbgIZQ3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:06 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5888721D95;
        Sat, 26 Sep 2020 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137745;
        bh=7DIGZxK4ZsoBsUw/WgY5IExGk/CfOFEQoIL6JCUTqUI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ty+WCjFD6YSHffp6lVzLu3fEGBpU0An0mWs+eQmlEEnrLKrIYfmbkOyWJUme/J71N
         N2HZwpcpv2CXT1JrGrCZJfzNY0svEagx8/2QNstknHoX/s9Bl4/F9mRqT9fu4aVlwQ
         0oN/DxSwU9gFi6QRAOkHCRyxDTBWPaQFU+WjpYVw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC 11/14] ARM: dts: imx6dl-pico: fix board compatibles
Date:   Sat, 26 Sep 2020 18:28:08 +0200
Message-Id: <20200926162811.5335-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four flavors of TechNexion PICO-IMX6 boards.  They have their
own DTSes, even though in Dwarf, Nymph and Pi are exactly the same.
They also have their own bindings so adjust the compatibles to match the
bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6dl-pico-dwarf.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-pico-hobbit.dts | 2 +-
 arch/arm/boot/dts/imx6dl-pico-nymph.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-pico-pi.dts     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
index 659a8e8714ea..d85b15a8c127 100644
--- a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
+++ b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Dwarf baseboard";
-	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
+	compatible = "technexion,imx6dl-pico-dwarf", "fsl,imx6dl";
 };
diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
index d7403c5c4337..08fedcbcc91b 100644
--- a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Hobbit baseboard";
-	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
+	compatible = "technexion,imx6dl-pico-hobbit", "fsl,imx6dl";
 };
diff --git a/arch/arm/boot/dts/imx6dl-pico-nymph.dts b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
index b282dbf953aa..32ccfc5d41ce 100644
--- a/arch/arm/boot/dts/imx6dl-pico-nymph.dts
+++ b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Nymph baseboard";
-	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
+	compatible = "technexion,imx6dl-pico-nymph", "fsl,imx6dl";
 };
diff --git a/arch/arm/boot/dts/imx6dl-pico-pi.dts b/arch/arm/boot/dts/imx6dl-pico-pi.dts
index b7b1c07f96f3..4590e8ad9a91 100644
--- a/arch/arm/boot/dts/imx6dl-pico-pi.dts
+++ b/arch/arm/boot/dts/imx6dl-pico-pi.dts
@@ -13,5 +13,5 @@
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and PI baseboard";
-	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
+	compatible = "technexion,imx6dl-pico-pi", "fsl,imx6dl";
 };
-- 
2.17.1

