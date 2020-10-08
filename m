Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9572D287DED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgJHV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgJHV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:27:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4473DC0613D2;
        Thu,  8 Oct 2020 14:27:38 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c5so7253021ilr.9;
        Thu, 08 Oct 2020 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Gd0TD0Zh9E4/4Vtm9YyHlb0NPvcC47sf/ndhX4ehe8=;
        b=po2HVF55v+iJBto5bS1ESXYgxMQ74GzLz8Xni7yD3Oz6fuv4GnaP56ySWYCHJXhEXD
         TFyuvreRi5gWTCUvTtgmN5sB/+LeP5HCVzeLe/7AlGXiIxZJKcoUTmjx8jUkCgAOzfGc
         vCNE/JyR7YQ1a1XoXJe0Dpx/sAhVtx+4BbeL/MWnguSayMVx765HylZ38m+aVIsU6eLr
         2x9vTY5AOMh+KVNW/IzLJ9zcKNZWOnIuZz4NMqtPEN9ZESyS8TdVcLqRQ01cR5DeDNoZ
         gH6IsAxX/AFOz3pm+I9wLGn0WhjeSWK46Y01w8Oe+LpyKfvktnq0dBD+meo/q+1Jb9fc
         KVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Gd0TD0Zh9E4/4Vtm9YyHlb0NPvcC47sf/ndhX4ehe8=;
        b=HkMH8fT1Ejkvdu25SHz//9PRFgc5seGH4cGdeL/JcFrqQlNOnCqkcLftKSfAIl1O4n
         LCVeEhxoVAf2tPHLZ6oaPWKSv3rOpmXiJJiqa9WNIaCH0stp5TtzZTTOT+CyXyCAtPSw
         MExwEv/nX+uzZg9ZDCVNuuenODjQaNqCG94MgTISD8E/Lw5yYfrEUzUbusGubSe/Er55
         /ZF0BFgiPOopbx9PqcQyHFu0dd5wroOC9OknTd/1fV/UWt3ZZZ4qPXJ0bhOi+z+zzUrg
         xza9sW27x7sZw/GCXif/elot8MzYkdxDEs/I7nTt/dT6FFeKFCW/RmmAfK4ZaImRvfqq
         rWOQ==
X-Gm-Message-State: AOAM530gLqQ9dIO1epxl/U0+1iaSBKIbEAZG2OE3xAJBChozVLrVs0EZ
        gKjqQ8r4u4slqB0qptXJgls=
X-Google-Smtp-Source: ABdhPJwGO65CU4jREynWJcUwCS5duofAaw3UYYu2qmj9hnMTKYkEVO3bJSXFzrh+7sMwAiGrArv1Dw==
X-Received: by 2002:a92:aa0e:: with SMTP id j14mr7244753ili.120.1602192457539;
        Thu, 08 Oct 2020 14:27:37 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id o72sm3067090ilb.6.2020.10.08.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:27:36 -0700 (PDT)
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
Subject: [PATCH 2/3] arm64: dts: imx8mm: Add node for SPDIF
Date:   Thu,  8 Oct 2020 16:27:05 -0500
Message-Id: <20201008212706.870115-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008212706.870115-1-aford173@gmail.com>
References: <20201008212706.870115-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini can support SPIDF which is very similar to the
IP used on the i.MX35.

This patch adds the SPIF node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index fad1f9cdb241..44a59f59f65a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -358,6 +358,30 @@ micfil: audio-controller@30080000 {
 				status = "disabled";
 			};
 
+			spdif1: spdif@30090000 {
+				compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";
+				reg = <0x30090000 0x10000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, /* core */
+					 <&clk IMX8MM_CLK_24M>, /* rxtx0 */
+					 <&clk IMX8MM_CLK_SPDIF1>, /* rxtx1 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx2 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx3 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx4 */
+					 <&clk IMX8MM_CLK_AUDIO_AHB>, /* rxtx5 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx6 */
+					 <&clk IMX8MM_CLK_DUMMY>, /* rxtx7 */
+					 <&clk IMX8MM_CLK_DUMMY>; /* spba */
+				clock-names = "core", "rxtx0",
+					      "rxtx1", "rxtx2",
+					      "rxtx3", "rxtx4",
+					      "rxtx5", "rxtx6",
+					      "rxtx7", "spba";
+				dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

