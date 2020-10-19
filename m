Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29EE292BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgJSQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgJSQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:50:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E72C0613CE;
        Mon, 19 Oct 2020 09:50:51 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so836230ilj.9;
        Mon, 19 Oct 2020 09:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjlK8WvBSntPqVvpNX/SGBi23DkBpqAui+Tqkdmh+KE=;
        b=Ns+H8U0ntimEqy8YRIa4ZGHqX59Kroq2QIuGPG59W7bacAP+pk9Zi+GyG+OK2fjpg0
         1gg/MOeO2Uu0hFxzV0vhrdwY5WKpXx62TnW2SqvHFn4wH6+wrEkWAdVGBWikdJT0NAXN
         JNczgzhQqhES4fN/54IRImztR4aMI7JslVujh7wNKvmyIkMufxIb280jOq5BxxYgS3F6
         Xa9n7oLTDBny5Xb2m3gKs/ZiHC+YI72HHeYu0MN9Q26zQ0bgX3Te9n+4pBD56NIeeiq2
         W/EAvZRwzvYM7CYDxR+1haExrLqbRuXnqxMz4ZJdYusI1RR0S7vxvfMxwFWRUHJYvNus
         tnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qjlK8WvBSntPqVvpNX/SGBi23DkBpqAui+Tqkdmh+KE=;
        b=lymZKoLAclmbYFBIVa0hK8FIW/JVMa0+LJtcff/NP/+Fx0FfkASKS+wUogOHK1GW4i
         c6naq67+/0b0oA4/p6dZ+Bo7ViQ6A5bpx6eIL8DTcCIC1BuNX/WxIY2PRYx+pneqq4Vq
         sX59pTTWgdafWJ3MIo8PHEAEc4vsyC59pIQ2IR11dTbalOIqsdB842xTw9u6clU4oDMB
         qF0XcqZhGvGuRjvCDAW9F+c8mNEdY8/FS/2Xn9SpeEZjisn74uxwaIGGe6DBx7fxsvjp
         aJIVRTMvXOBojSLGpUo+XMk4EWQs6mPOv8svUJdx7BxzCHmbBtMYYMOzj5Qht/4FK4oo
         h04Q==
X-Gm-Message-State: AOAM531lKS9IQP3hnFOAcfKXXHigHO5z68lzSv5atsBlSjw60JfIsdc9
        6lrPVaAfDjIgrHLdHtJjHis=
X-Google-Smtp-Source: ABdhPJwfuN/7qf73JC2uq2A46lJw+/CG65J0opBApeLv1flNYWCfZ0HCkKriNKrIBflQmEfK9v1YKw==
X-Received: by 2002:a92:c142:: with SMTP id b2mr722379ilh.207.1603126250105;
        Mon, 19 Oct 2020 09:50:50 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id p17sm212839ilh.34.2020.10.19.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:50:49 -0700 (PDT)
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
Subject: [PATCH V2 1/3] arm64: dts: imx8mm: Add support for micfil
Date:   Mon, 19 Oct 2020 11:50:36 -0500
Message-Id: <20201019165038.274164-1-aford173@gmail.com>
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
---
V2:  No change

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

