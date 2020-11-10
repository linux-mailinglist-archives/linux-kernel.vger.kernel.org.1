Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D270D2ADEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgKJSuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbgKJSur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:50:47 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF65C21527;
        Tue, 10 Nov 2020 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605034247;
        bh=2bjstnPSQdke89SS+jHM5tHRDzdsnAOj4f4jQOK893Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqwMllCseOiMvw61Hc8x/TEjb6PmY41ICklDA90WFCO46wBbEkPQiPohJfHhEm/HS
         dwI+rQhDjhpFgYd9Js3l0fxG3BiKz3lJX3yHbbacQxBkyWdBjpyOljEPgAU2+t/Wt8
         f6/jj1RPtXilDj5QuwaTQHD7OvEOA93wtDeErpGE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/2] ARM: dts: imx6q-pico: fix board compatibles
Date:   Tue, 10 Nov 2020 19:50:34 +0100
Message-Id: <20201110185034.37315-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110185034.37315-1-krzk@kernel.org>
References: <20201110185034.37315-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four flavors of TechNexion PICO-IMX6 boards.  They have their
own DTSes, even though in Dwarf, Nymph and Pi are exactly the same.
They also have their own bindings so adjust the compatibles to match the
bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
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
2.25.1

