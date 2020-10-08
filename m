Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C150E287DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgJHV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgJHV1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:27:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A08C0613D2;
        Thu,  8 Oct 2020 14:27:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d20so7965236iop.10;
        Thu, 08 Oct 2020 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUwlSr28IICIPzmhkTTd4goR+XOu/pSZVwbvatvP54o=;
        b=lpxUukZHbJqdLgf5ohQdAWHoKmY/ZXmdKcgHvIsH1LNMjao5p+A6CIb10YHmUm0cE7
         TZPG2biRm8Hiva+ZTDbhlljPwXwk0PVjQnvDB4j6Hgsf3EcyiHIWMzzyVYdc/tRaJ2q7
         kXnC5NT9dJBjuC632oO53Ba51E2Cd7emvupQO2c85ltakyOibUAzTGV/8hQQaJaczQch
         cx2pUMa7rYf8Q/ALxMZncdCn0pbE5XD6vsAPQpRNMXGIkSom3efMESZELu+WG0EU1Gqv
         CwJtm78AZY9wPXBSUdjD9MNWhXd3eJnP2N1+hDAGuUNXirH3rvBiFmV8uTVkbqERY7O3
         cTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUwlSr28IICIPzmhkTTd4goR+XOu/pSZVwbvatvP54o=;
        b=two5KInXJI5MaTn90vSx5/GLUEZAvsbmM6hEoXglaNkyUvYhA6bAniRf8uuMJ8kMtf
         4NFi7tGSEMQi8HLO/nOaQvo6EHCTbi1cF+JLwsCRfOKkh7+9u03fr8Wu0XeZIm8qytOH
         NdmpYa/4L9OFsSoB9v1Gw6D3WzWRdlMgdVvsJvv4OUMRWffFTnVQleIRpiEjazucsz0W
         oespBXofKC4d4FaF4R1kJb/Gdnrk/QU13EahiLp20CFbVpapraAeoIoeezNlvZZJkJ/d
         fdaemGqRoLaBxIO0DgdzRH7A8J7Z1WpWaY98w822XgVLxwDNTCDzDMIGwAL308KBA5OO
         6cQw==
X-Gm-Message-State: AOAM532w+lDE1aPsvusZQbfiWCpaTA3wxQwLwwCcPutYdaqJ1QunP7mC
        PPfK+RhaUzvlLRzCy4GaKuk=
X-Google-Smtp-Source: ABdhPJxF/WcUgOK6RQRHznO47V2RGmNflJEjbUzrArXMyhwE0a9K8sq5NhmI3y5Z8I19p9I1E7jnJA==
X-Received: by 2002:a6b:760c:: with SMTP id g12mr7376891iom.150.1602192455903;
        Thu, 08 Oct 2020 14:27:35 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:7c62:dd9d:b755:cfbd])
        by smtp.gmail.com with ESMTPSA id o72sm3067090ilb.6.2020.10.08.14.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:27:35 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: imx8mm: Add support for micfil
Date:   Thu,  8 Oct 2020 16:27:04 -0500
Message-Id: <20201008212706.870115-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has supports the MICFIL digital interface.
It's a 16-bit audio signal from a PDM microphone bitstream.
The driver is already in the kernel, but the node is missing.

This patch adds the micfil node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index b83f400def8b..fad1f9cdb241 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -339,6 +339,25 @@ sai6: sai@30060000 {
 				status = "disabled";
 			};
 
+			micfil: audio-controller@30080000 {
+				compatible = "fsl,imx8mm-micfil";
+				reg = <0x30080000 0x10000>;
+				interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+					 <&clk IMX8MM_CLK_PDM_ROOT>,
+					 <&clk IMX8MM_AUDIO_PLL1_OUT>,
+					 <&clk IMX8MM_AUDIO_PLL2_OUT>,
+					 <&clk IMX8MM_CLK_EXT3>;
+				clock-names = "ipg_clk", "ipg_clk_app",
+					      "pll8k", "pll11k", "clkext3";
+				dmas = <&sdma2 24 25 0x80000000>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

