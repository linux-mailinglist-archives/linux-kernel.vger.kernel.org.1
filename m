Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9622FC5BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbhATAWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbhASNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:43:51 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B7C061574;
        Tue, 19 Jan 2021 05:43:08 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x21so21368721iog.10;
        Tue, 19 Jan 2021 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhxARzPFutdg81T930cbyQKfkMbVSUeQ1+BndRwFnQ=;
        b=aEkdXNXA7u+6R0tmTB5TEzHGH/YPncnqWAADUYnAzEkOgAiRFQ5dsYKdY31pRYPeZG
         5Q2KYd9W2nH+k1TEW2PbbBUO25RqFzfqE2ti3pm5DKdDwL0xwb7f/7jsK4ueGn8LR7MQ
         Z/9umkcqB+nNGpZ4BMKKRi2nHMVhCd+vTE2Yye0+iMTT4wlyWW/ePXueDZRGxWs2CYbI
         p6cm3ExSAF4X7Cw0I2nxlWThv0UkhN1dd2G2uU/cKFw/k2kJ5qspOsuaULL34nBYNcp0
         yOj/34tYw1ym0Fk+NVdv6DgLoKhU/XB5RERhUfzTdr2VongHOfv21axuMSaV9eVbLgEf
         2Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhxARzPFutdg81T930cbyQKfkMbVSUeQ1+BndRwFnQ=;
        b=SuQq/2Ew9Mrr56MxHBJhfzV8c+FA14J+ruBQxJDOA/Nl1fwiabyNvmPg58Vzg9WFyA
         gstzShkckoK7m8epjGGtiUOqJdme7do9IQ/xc7nhHW7kWU5dPaQUJyDZ7r1yaQ8oRDFb
         BdCzjED7puk8rq6YoCjGXsWjq4pmN3Hfq3CjyBqkssP9E4rs2FcrlQpJh1PYqte+x3+g
         Ptede7tQ1GxTH6qvQaVM3ugcM1fCiJY7KzrRVZuCIllwMcld7hxxrUrvCFz6aAoeqo0S
         qawZNTGSJiRZi0fsfY54S1yuOTgY5XVNiEwU4Z4GmGEH4h6cpU6rHnqg0HwcraAowaS/
         wzoA==
X-Gm-Message-State: AOAM531HXEn80pfRCWNEfb2qfHWfRA1ElYccknBDPVfj/XOf+PvsXhyW
        QMtV9py3BTDf0KSa2hoU58k=
X-Google-Smtp-Source: ABdhPJy4pjcts2A1oVS2TaVpQShOhvaywh1DfDHODNyq18hD1bAkwk0YEK4Wuh4EFbRGeEY6teQBrg==
X-Received: by 2002:a02:969a:: with SMTP id w26mr3480063jai.96.1611063787372;
        Tue, 19 Jan 2021 05:43:07 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2386:3a11:421c:65a9])
        by smtp.gmail.com with ESMTPSA id h14sm1795829ilh.63.2021.01.19.05.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 05:43:06 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: imx8mn: Add fspi node
Date:   Tue, 19 Jan 2021 07:42:57 -0600
Message-Id: <20210119134258.774480-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano has the same Flexspi controller used in the i.MX8M
Mini.  Add the node and disable it by default.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 3fac73779fdd..16ea50089567 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -889,6 +889,19 @@ usdhc3: mmc@30b60000 {
 				status = "disabled";
 			};
 
+			flexspi: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_QSPI_ROOT>,
+					 <&clk IMX8MN_CLK_QSPI_ROOT>;
+				clock-names = "fspi", "fspi_en";
+				status = "disabled";
+			};
+
 			sdma1: dma-controller@30bd0000 {
 				compatible = "fsl,imx8mn-sdma", "fsl,imx8mq-sdma";
 				reg = <0x30bd0000 0x10000>;
-- 
2.25.1

