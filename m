Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5D2AA5A4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgKGOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgKGOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:00:40 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9089C0613CF;
        Sat,  7 Nov 2020 06:00:40 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m9so4924641iox.10;
        Sat, 07 Nov 2020 06:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/jiUVfNK4+k6xToCb8OveXZPmGMjclbBVaHRBvHjcg=;
        b=PDbMs0EAVZqHVuTPP90Uaz4parZqBFKM2woZGXq8aHzgVlKxGL8Ld5gYiK95UqpxB3
         ZL9yGdULBYhGyRZceUFbT8CWqMvwMCK20/IV67XUL9BNGyPDVbTN9VO4pxWcCKVJjH7C
         /oXd/tpg2VcPUZjYMJDg0N21vaMHFX28h5VPpSO0RApJ9ycyNnVVe6xZqWuXoEq/hvSt
         Q96o6wJTo1C9YlTTWszp9LwpXJqbiOqhT7IZAiGMOc1kfbfXUMK1H5lJvsq7Hfz+T487
         MfVvXtfMOrGYxhCxnbG4AphU3HZPqxWk4PC6knHn6JedSBXVwNSkDUZWJZYndfy1sCtv
         Je8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/jiUVfNK4+k6xToCb8OveXZPmGMjclbBVaHRBvHjcg=;
        b=MMT+tNVFriWqqdMOBPBMVo3FGuXRqvDBX3KTUIspHiHKJeEz4gAYbPO9P8oGDRkMdw
         0HVJdBrhknRu9agCZFkeHC6DLLKaWj/lTEZjz09hoG7CqMVl2MW+W9oArRN+KZHb6I4F
         AejcjV1SAezQkPYuxPTC7hCq3W8tqIHI3tWleOgw14TADqHikkEmLXhcOXAAzOE+0IPh
         pMQgQ0v11sGv+g4LqoTq65SGrGwMso97+thhyORNg+8fAW1TC5HFw7GB+DcXZZE8AB5s
         H2ZL6G+JI8pb4g3mzBioZaRd8SoRb6uB2JslbymWmX+1ElvHw2DyCz9Wm8kDvxT2jHGz
         k7BA==
X-Gm-Message-State: AOAM532dHEJ0cn+31nSwzSSDxSbui0rI9lonMAWjjBxLtCkpcti2svrl
        lwV7sRg0urNMFnx020eSRck=
X-Google-Smtp-Source: ABdhPJwap6GbB3E0EZE/M4jpppEAyeA20+UTnDsiRvL5Po0hT7yMjsZUDX/5YNCQSBGS59A/YcjDtQ==
X-Received: by 2002:a02:ec3:: with SMTP id 186mr5285031jae.92.1604757639961;
        Sat, 07 Nov 2020 06:00:39 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id g5sm3030257ilq.33.2020.11.07.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:00:39 -0800 (PST)
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
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] arm64: dts: imx8mn: Add GPU node
Date:   Sat,  7 Nov 2020 08:00:25 -0600
Message-Id: <20201107140026.1974312-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107140026.1974312-1-aford173@gmail.com>
References: <20201107140026.1974312-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation from NXP, the i.MX8M Nano has a
Vivante GC7000 Ultra Lite as its GPU core.

With this patch, the Etnaviv driver presents the GPU as:
   etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

The stock operating voltage for the i.MX8M Nano is .85V which means
the GPU needs to run at 400MHz.  For boards where the operating
voltage is higher, this can be increased.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Move into this series
     Update clocking description

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 5e4b6934de40..6e650ea422a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1008,6 +1008,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER_DIV>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE_SRC>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_SRC>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE_DIV>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_DIV>;
+			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_SYS_PLL1_800M>,
+						  <&clk IMX8MN_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
+				<400000000>, <400000000>;
+			power-domains = <&pgc_gpumix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.25.1

