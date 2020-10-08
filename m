Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21974287BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgJHSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgJHSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:33:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C6C061755;
        Thu,  8 Oct 2020 11:33:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q9so7359637iow.6;
        Thu, 08 Oct 2020 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vV4Mb98vlQIwwZ0z4qtbWCxs9fA4GO948r8Iey6zXY=;
        b=IyefXmudAS05tO7aFl4A85mBPzjTiyMd73wrzuWmi+XHbF3v25yu+m5vxpB2A2FpV8
         nUzUL4JdairnVbPM0YS3nx4QJ0ZTaknynWl9oGU6IDmFXpgkRR/sjAK/Eqg9jaDYuuHY
         bp216KyM8Q2JdHT3FRpVgsVZMyOtz7B8pZ+Q41Kj5A0vCCGTf5zaAKJUAWghhZ/ME2bz
         /3gVjqpwMJX4BZGx7mTCm5WabN611FEuTXHjDoW3zI8wJ9Yi3PeljSr0IA6b+uj62ghT
         gxlelyMF0NO11HyYazv0qbvTRu046GU2IdbRkBqOmdp9EnMS5cHkTica6lvtem6IBRg5
         EmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vV4Mb98vlQIwwZ0z4qtbWCxs9fA4GO948r8Iey6zXY=;
        b=L6yrPOEx4eLtbidNqm0l3AG+Jq3zfTi7IMh4PWCxivq/brhsR4rJT5p9DIhVyreTWL
         /ADBefsgGLD4qRcz7/J8QHjMD5RFS5QqZBd7BFJ5XVrlosfyPphrlImFHf8dWMf22pbr
         xAC7xethI0iTtvJr3zZKKMj5wGWj/CWB0wRjnucdhuFZXdQU2KLOqFfMHioT775oMFOS
         i+1as0JFAs2kRBm+eYEb7Tr9UPfBN/0ttcz8J9VKi2xcykKRLFa5Injuww+oMJ1+tf7+
         y9C4Rw/uYNjLL6UG8/gXbGNPrWDj7oAlDligrRAqghZNKktETbQkmfGCMNMfB20yByqy
         AVQA==
X-Gm-Message-State: AOAM531ssM9WLT+FMOvTi1GBTM4f9Ih5xBVP80w0vO0lLEF4lJuGXtH8
        VtLfc5OPmrKv6jQllCiOXgy+eOL/i88uEw==
X-Google-Smtp-Source: ABdhPJy/JhePvsbaaNGnqX+bcq4B236D1/woZ8hSpzdfQRDXaw0drHDhyPtsp9jyGcfLnTUXBRFzUA==
X-Received: by 2002:a02:cc8d:: with SMTP id s13mr8019937jap.4.1602181988120;
        Thu, 08 Oct 2020 11:33:08 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id r2sm2446268ile.1.2020.10.08.11.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 11:33:07 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, krzk@kernel.org,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts imx8mn: Remove non-existent USB OTG2
Date:   Thu,  8 Oct 2020 13:33:00 -0500
Message-Id: <20201008183300.726756-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the i.MX8MN TRM, there is only one OTG port.  The
address for OTG2 is reserved on Nano.

This patch removes the non-existent OTG2, usbphynop2, and the usbmisc2
nodes.

Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Remove usbmisc2 and usbphynop2 in addition to the otg2 node.

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 746faf1cf2fb..16c7202885d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -790,28 +790,6 @@ usbmisc1: usbmisc@32e40200 {
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
-
-			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
-				reg = <0x32e50000 0x200>;
-				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
-				assigned-clocks = <&clk IMX8MN_CLK_USB_BUS>,
-						  <&clk IMX8MN_CLK_USB_CORE_REF>;
-				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>,
-							 <&clk IMX8MN_SYS_PLL1_100M>;
-				fsl,usbphy = <&usbphynop2>;
-				fsl,usbmisc = <&usbmisc2 0>;
-				status = "disabled";
-			};
-
-			usbmisc2: usbmisc@32e50200 {
-				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
-				#index-cells = <1>;
-				reg = <0x32e50200 0x200>;
-			};
-
 		};
 
 		dma_apbh: dma-controller@33000000 {
@@ -876,12 +854,4 @@ usbphynop1: usbphynop1 {
 		assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_100M>;
 		clock-names = "main_clk";
 	};
-
-	usbphynop2: usbphynop2 {
-		compatible = "usb-nop-xceiv";
-		clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
-		assigned-clocks = <&clk IMX8MN_CLK_USB_PHY_REF>;
-		assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_100M>;
-		clock-names = "main_clk";
-	};
 };
-- 
2.25.1

