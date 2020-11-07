Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5072AA5A0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgKGOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgKGOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:00:37 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C09C0613D2;
        Sat,  7 Nov 2020 06:00:36 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id l12so1244900ilo.1;
        Sat, 07 Nov 2020 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WAVnoMsBB9YRuYSr4SnXW/7hpiCwE0r98+QVKAkmBc=;
        b=cU7XyrnXFaHjm9ODpQ4wtYren6CgmKVT6316mnrdcEfJ/C3dxifQXroKXfb6IESSXa
         6TDJj1xN7VUClNC+jyX/cOjThrCOqqkWMyU8c9x0v4XLxAlFJ+HEeaUwWsTb16YteHVH
         eJ8H8lg7zBbM5kXkH9bhikVMwlyRgFf4cxdtbSmgm3HaYC4uU+ertdaN72JP4r4eIWzn
         HYhjPfTQirdrnPENXN19G+F3yUvw6kbW4C3bHXXqV60wxjHhaDbufjOoNfDDOJDLojl3
         YJ+xvShugsCGvXiuVxr7bGbIikbxOHNNEcAtMZKxyFlUYwTylu1Wf+lCTUCD11QHbw4z
         7iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WAVnoMsBB9YRuYSr4SnXW/7hpiCwE0r98+QVKAkmBc=;
        b=q75AEvd/QvMMPEL9VQP1kXQk66VXgmrkZNClRpv13dplmsugwV2T+gVwNt7MZ+7gSm
         y8tWizNCVQB3eUih+2NMEUEvkFMT9R6C6UwfdoYpZYHr5IIbKzk5USGe8bjuxFbmUXR1
         hfpKK/Lof9ggGeM96/sKyzJH23XZiu9c5P5/sa6kegCUSuWQRZ1jUoGeJP4GbaCdUeTc
         jRWhAih26cj/2I2aR+Ekjnhk8APMmbvCX+5vbe2oMhf8LH4qhvem+hcGtXQFPKxYx0S0
         Ad0cgTWav7X15XveewLntozE+UTK4fU2hiByB5EqTLKQ090oX7r7HDMcKbmhbKIkJkoZ
         x1tg==
X-Gm-Message-State: AOAM532UIcDLjGyfyYgOqregy3ZDtm60exn/gET3xsy4SODT3o2V6VPj
        foXhvkGas+8xzeQIDCVj0eA=
X-Google-Smtp-Source: ABdhPJz8TR79wmz4s+2uO7EVgsblEs4390ase1CflJvE+j8mkypawnHGRNHDyeAPKgclhXc/IhR2Uw==
X-Received: by 2002:a92:85c5:: with SMTP id f188mr4797570ilh.173.1604757636173;
        Sat, 07 Nov 2020 06:00:36 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5d9e:32b:1062:f8cd])
        by smtp.gmail.com with ESMTPSA id g5sm3030257ilq.33.2020.11.07.06.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 06:00:35 -0800 (PST)
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
Subject: [PATCH V2 3/5] arm64: dts: imx8mn: add GPC node and power domains
Date:   Sat,  7 Nov 2020 08:00:23 -0600
Message-Id: <20201107140026.1974312-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201107140026.1974312-1-aford173@gmail.com>
References: <20201107140026.1974312-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT nodes to describe the power domains available on the
i.MX8MN. There are more power domains, but the displaymix and mipi
power domains need a separate clock block controller which not yet
available, so this limits it to the HSIO, OTG and GPU domains.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Fix missing includes
     Remove interrupt controller flag
     Remove domains which interact with blk-ctl

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ee1790230490..c37dee13057a 100644
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
@@ -598,6 +600,40 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mn-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MN_CLK_USB_BUS>;
+					};
+
+					pgc_otg1: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_gpumix: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_GPUMIX>;
+						clocks = <&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_SHADER_DIV>,
+							 <&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MN_CLK_GPU_AHB>;
+						resets = <&src IMX8MQ_RESET_GPU_RESET>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.25.1

