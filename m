Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC43E255F08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgH1QtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgH1QtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0096E20E65;
        Fri, 28 Aug 2020 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633352;
        bh=A+5+6JhdVbUJ9D0QMqSPAjM/5xlJh4wUHfgnQQlFXz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJbkCisAerDHvGAjlTy9lH6oKd6EbR+069Z9dDBNVcFNAHolzieGMclvIE9Z0ks0B
         HYaYfc++NhBDB5QfzngxQ2Napm6OhvGhNMw/6lrkytQgR+aJy3K6rYqcLPyAIGV15L
         AjRcxsShdQIXMT/nBioo5ZR7ZpjN242uNihKYULk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 03/19] arm64: dts: imx8mm-beacon-kit: Add missing build through Makefile
Date:   Fri, 28 Aug 2020 18:47:34 +0200
Message-Id: <20200828164750.10377-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing imx8mm-beacon-kit.dts object in Makefile so it will be build
when building dtbs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a39f0a1723e0..903c0eb61290 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
-- 
2.17.1

