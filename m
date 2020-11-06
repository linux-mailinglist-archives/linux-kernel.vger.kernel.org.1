Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3572A9518
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKFLQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgKFLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:15:56 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7AC0613CF;
        Fri,  6 Nov 2020 03:15:56 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k1so732946ilc.10;
        Fri, 06 Nov 2020 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhrU9RKUgX24BW2mqkqfdwagyZmf21XwzpvIKVgHKYU=;
        b=oABVe0ZMvnRz8dUd+sf3UpsEaLrUur8LrOO5Jpnb4UkEWrXugVCTz0moMTqp94cBED
         URjspvBCYnbRaUVIO3E25T9eJ6N+7xrEQRuQG9Yr2TcDeUnrwRWx94ed+Mfy3OWOF/+s
         7CGivj+0vSW12LsXm7Vv/JUvEOo1wrTN2BOKcBuhffkc9GlBxQ6kkJX3cyU/f5EhRjOS
         hzrJ3G1lSsPJy59eo+inYASRMCCcLSXQKztc9/qEl1cwpeunacF4x7yAhb7BxAul9HjI
         WQCYrcf+ZmE49/k0rYrz6kz0X++5MuzFPB9AVPrfhd3HvqnEBX8sEC2viZt+eDXN/pEE
         i9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhrU9RKUgX24BW2mqkqfdwagyZmf21XwzpvIKVgHKYU=;
        b=OaSUQBWFAffA8MDccp+0ziupQAkKtLce464/xU5h20LDIPtKQbGbLwA3QyExpi8Gw6
         REltmUs5gam6isQY/sbaJBUCvdzD8ufdexbD4eAQdQqw+DsFmXjRlLv64brCcQysttJ4
         tfq4gq2UKV/hp916QB4ngZqkxwQZ57gSFtbyJL25sf1qr9k7NGjXnJXpYHSkCt35n1Ev
         7Tj1Rssqu7x8cFl1RAJrN3FLdqtC+JIQYOPc+qBG+/8IpvO/kT3neb3SViY/nqzbQDMB
         fQW4IQkyHuSOaKdJ57VWcx36R6uR7vLwFCEVjjFBhEaFNTWMyxi5bG4prbVL5FPcbGG1
         kQFg==
X-Gm-Message-State: AOAM533up3Bbo+WMI8DwDf+aXW/ctZ+73EYL94WoIzW+BI8nFRX6RMzz
        wOj20UB3zzduJllnRkpESJY=
X-Google-Smtp-Source: ABdhPJxQZm/PFxbV94DyQz1OlLP2Fg+fT+MQxiujWGV2H1J5/bIAdIeNm/rKr2Bg7wl4O5dGQx5mig==
X-Received: by 2002:a92:a80f:: with SMTP id o15mr914043ilh.127.1604661356046;
        Fri, 06 Nov 2020 03:15:56 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id x5sm854597ilc.15.2020.11.06.03.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:15:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] arm64: dts: imx8mn: Add SAI nodes
Date:   Fri,  6 Nov 2020 05:15:41 -0600
Message-Id: <20201106111543.1806809-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has several SAI nodes available to it.
Enable them.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 61560c083300..6ea0d43a78a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -260,6 +260,78 @@ spba: bus@30000000 {
 				reg = <0x30000000 0x100000>;
 				ranges;
 
+				sai2: sai@30020000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30020000 0x10000>;
+					interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI2_IPG>,
+						<&clk IMX8MN_CLK_DUMMY>,
+						<&clk IMX8MN_CLK_SAI2_ROOT>,
+						<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai3: sai@30030000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30030000 0x10000>;
+					interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI3_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI3_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai5: sai@30050000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30050000 0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI5_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI5_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+					dma-names = "rx", "tx";
+					fsl,shared-interrupt;
+					fsl,dataline = <0 0xf 0xf>;
+					status = "disabled";
+				};
+
+				sai6: sai@30060000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x30060000  0x10000>;
+					interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI6_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI6_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
+				sai7: sai@300b0000 {
+					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+					reg = <0x300b0000 0x10000>;
+					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_SAI7_IPG>,
+						 <&clk IMX8MN_CLK_DUMMY>,
+						 <&clk IMX8MN_CLK_SAI7_ROOT>,
+						 <&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>;
+					clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+					dmas = <&sdma2 12 2 0>, <&sdma2 13 2 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
 				easrc: easrc@300c0000 {
 					compatible = "fsl,imx8mn-easrc";
 					reg = <0x300c0000 0x10000>;
-- 
2.25.1

