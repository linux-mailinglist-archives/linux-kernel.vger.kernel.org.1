Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2440D292D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgJSRpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgJSRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:45:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58491C0613CE;
        Mon, 19 Oct 2020 10:45:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b15so581388iod.13;
        Mon, 19 Oct 2020 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IRlyVf+aWbSbioBbgVNEBKooyCzye9rgkbUGqssf8o=;
        b=HKA0m16P7C9EgxrM+k158puDbDdIjS3jTNrVJ4MvuQUkhJjehNvhTFMrcHYFrXs+hU
         TaxbjgAxj8NVJavWSZ1irbXwLxn6ws6+yebcfGR1GM8ml0AB4I1lYU6LxaMr1MavmOMZ
         E1UCGShD5ASCRlIVgEZBaj0wiLBxVV+daChEaobt36V6rvy7Ltdi8n7ftQ4jl0Yv8dwh
         kHetuJzbV4Yy3l/g3cDnFrGHqKG0d5PaorpxIFx1DxOse4lIHSZN+9se38rzW7rSYZSo
         XKlmUtf/H0wzVF6G8liY4FdYZOx/H1UX8fXwA/AATnuV9fYtHEqUw2lkDMc3B5XR4vKe
         09rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IRlyVf+aWbSbioBbgVNEBKooyCzye9rgkbUGqssf8o=;
        b=nIpUj+n9bsFIp/jlSqzdBVftfRYQpzdnpmFGIAprFAI9HZBYqIZ9ei2YF/APQ+yAag
         4kqLybaaXcBCmHUOB5JuokL4aDOOqcLHxzsjhXdsGdEbRh07G7GbDHc49+0Y1HUytzLq
         kK2+gyZ+blyxsB4CMDC6dKf5Rb1SCg3jJ+x6wwA+VPD77edVbZ9j4vLRxCFqIo2bKK2x
         SsagjaeTQmhGndq3awu/GJiiggB9umIgP8gtPot/Irb2bHn84SSNne5eIPI9c25dscDc
         ueZVfzurbNJdbuXWWna5yOprNR2pBu/P3/YJRRI99WW6/FHO/UjbPOP4eVYBSsbQ2dr3
         iPbQ==
X-Gm-Message-State: AOAM5300n//AyTvlT+O+MPz7MpZF3EUm8hSiDuYSCGwh1+sopFlujWuP
        0kH0pbussOS4WJ6UilVx6NE=
X-Google-Smtp-Source: ABdhPJzL0fte6bB2T2/gqQwkKJdWzpY58+WDIYuaICmbo0QGRNBFiJm1wJngGeArW7xKJ8CPcH3yUw==
X-Received: by 2002:a02:1cc1:: with SMTP id c184mr943479jac.29.1603129541636;
        Mon, 19 Oct 2020 10:45:41 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id 128sm406261iow.50.2020.10.19.10.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:45:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: imx8mn: Add support for micfil
Date:   Mon, 19 Oct 2020 12:45:27 -0500
Message-Id: <20201019174529.289499-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019174529.289499-1-aford173@gmail.com>
References: <20201019174529.289499-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has supports the MICFIL digital interface.
It's a 16-bit audio signal from a PDM microphone bitstream.
The driver is already in the kernel, but the node is missing.

Add the micfil node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9e2c0b6a7e32..3ab9486736ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -315,6 +315,25 @@ sai6: sai@30060000 {
 					status = "disabled";
 				};
 
+				micfil: micfil@30080000 {
+					compatible = "fsl,imx8mm-micfil";
+					reg = <0x30080000 0x10000>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_PDM_IPG>,
+						 <&clk IMX8MN_CLK_PDM_ROOT>,
+						 <&clk IMX8MN_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MN_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MN_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 				sai7: sai@300b0000 {
 					compatible = "fsl,imx8mq-sai",
 						     "fsl,imx6sx-sai";
-- 
2.25.1

