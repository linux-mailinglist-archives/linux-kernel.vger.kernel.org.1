Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2572963A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899100AbgJVRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899081AbgJVRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:17:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD7C0613CE;
        Thu, 22 Oct 2020 10:17:03 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j8so2433919ilk.0;
        Thu, 22 Oct 2020 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxH0WW4eyFGtlK7B0mhAHSxy5284D+Fh4ydA0CHiSrs=;
        b=SwKfMo+3aCiKGJpe/ik55uXuzdhMQsDmXUsqy8J+1mcFtiAWqdryRmeq1NW3lYPWFY
         odjDZxsxMdL8wKxh6fDgIgadnx5SYV6K+HlDl5Xer0lwcSaW/8TlljvfoBZjqz1/1Ima
         7ZtAwRiyazx6FwDnwa+M8KLlBIycLZ8DxBOSOfdGDyPdFCQkzD5r/EbI/wTlAaGJs1i7
         5cN/q4Vpof3y5/ZQYj+AaSMSwXrDBCkBDEDFlt/rjV3LDehfICorrhPsMpJdt8PeV0JJ
         zvwgmN5yBIA68kfKr5ckMshsZ/mwbJPJSIB1E6migDZ7b4PSqF9rw3bXvQJ9s5pqiyf2
         phzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxH0WW4eyFGtlK7B0mhAHSxy5284D+Fh4ydA0CHiSrs=;
        b=UD4BZ55nKclccjj0eIbl7pxBuUfI0yI+WIwl8CGq6hOy+treoHfyFJ6rkrIR92fmP/
         VrXp1r5kMkMn3N2R5vQxkffLjSZT8yV6m+nrn34sQWoqytLtwUekklnNQjI8AaEc9kKh
         wz1uxcdGWmU6qjz+uTWUd9K3BKmRm8yPYSjVj0Q04ngx0iStJxmhiG5r1fsWem7av95z
         7GKTQg5YpgIPr6O5JJsiTw/Bk+odz0h+rQsCSoeF5MIOq3WF/XOOOH7EHyB74tUHgwzl
         86NpbDbUjoivvLQ6TKODW5Xs5AnFIaHFUUjhnebMDVAZsKlBOihgfLIGSa4aLXN2l78U
         pcRw==
X-Gm-Message-State: AOAM532VC6hI3lCofzEdaj/LcmMqbvdAggiGvLiIVZWBRgAcD9N+9Eq/
        iqzIy0bFzCkdM4+aVhg641k=
X-Google-Smtp-Source: ABdhPJx21wl1klJ0oPPI02CyzLp67JbB4DNt5zAmZ4miMdBQYL+Jf5xVnwQkNAR4URG4bW1L+EohiQ==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr2812597ilq.39.1603387022310;
        Thu, 22 Oct 2020 10:17:02 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id v1sm1287636ioe.0.2020.10.22.10.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 10:17:01 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, aford@beaconembedded.com, l.stach@pengutronix.de,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm: Add GPU node
Date:   Thu, 22 Oct 2020 12:16:39 -0500
Message-Id: <20201022171639.773702-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation from NXP, the i.MX8M Nano has a
Vivante GC7000 Ultra Lite as its GPU core.

With this patch, the Etnaviv driver presents the GPU as:
   etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

It uses the GPCV2 controller to enable the power domain for the GPU.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
This patch depends on a series located:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=368903
and

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 605e6dbd2c6f..62c8cd3dea7c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/imx8mn-clock.h>
+#include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -1019,6 +1021,31 @@ gpmi: nand-controller@33002000 {
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

