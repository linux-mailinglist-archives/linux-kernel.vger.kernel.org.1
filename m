Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC7296172
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901143AbgJVPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901132AbgJVPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:08:28 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE45C0613CE;
        Thu, 22 Oct 2020 08:08:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w17so2021137ilg.8;
        Thu, 22 Oct 2020 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxlEwAahnVBhhMMWNurKy3KGXLHHqb4LEusXaDEf5LM=;
        b=T8Rt6lFUCjT+51YZNzhHUSjE2N15yHY5I0m+dEvUk2gS2nmAPwSUNg6R4/jZZxFHR3
         IhTJE2f/5jNHYqj+BqU0x2tpNGobnKpPya1vDRMlL4qu8IeSZbuYehIvPPj9egcKaDCE
         hS+YB/ZRbId+vwWVBoUv/IJg/uo8oKzxHSAAfWASPgnBcGWTIpfIePrpu39LxnpwCovH
         JLaXxKHRuWFzoq9/yhnYAYHh/8Y5WKuQQfdwwAF3/uRB/LFAd8gHSDKBE454zQtBhngG
         z9nT4gvhMtZYTkiwVx5T+8LViXUA41JaniDfyts+VktQiiy3KTkBHTzf6mpcFllGIUZ3
         pKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxlEwAahnVBhhMMWNurKy3KGXLHHqb4LEusXaDEf5LM=;
        b=Dqs5PFykONXLkAQOjvXdZpY4uLuBt+hNLs60ogG4+slOJTE+iLiIH0xn46JbyzkIPI
         z156LnHMSN38BD0Dxi1blgpN+gyTNkxIk5bAGCbyXK2KAF7SkdFtn8eWsQQowAKvCe3h
         Y+d2uvikQDq/yvQmRUbB7PwMLZljF/1K+IIVCZkt1Y6f/ezAt8/uM9l0M6jQqgwnbdvb
         MkoDxbrNDib8p8onLcMqbaeZiSQ5Cv2HHhD1m4iDqMfzNc60fO8B4CncNqU37Rbd08zt
         nJCeXrHm08RYc2kqsSwR732z/qCJoiy7UKUSZzY+wkGLScJ5sxmWk0TM1FbGwZNKLDx1
         NRWA==
X-Gm-Message-State: AOAM5318pQ7ywhKQQVYuEww1zj1d/zU9VgHuw7JzEaQ0viEgGf06gkMH
        J6Fnmdf1rCSdfECt3QIFD1o=
X-Google-Smtp-Source: ABdhPJz65yKRsDZ9TxUL0bD7Kocj8duPvc6PB9hjZuZTPyOEQOHMI/7ARM79isDKe6/fUdHRwl5KzQ==
X-Received: by 2002:a92:1943:: with SMTP id e3mr2193093ilm.140.1603379306830;
        Thu, 22 Oct 2020 08:08:26 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id y6sm1233816ilj.59.2020.10.22.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 08:08:26 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, l.stach@pengutronix.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: imx8mn: add GPC node and power domains
Date:   Thu, 22 Oct 2020 10:08:06 -0500
Message-Id: <20201022150808.763082-4-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022150808.763082-1-aford173@gmail.com>
References: <20201022150808.763082-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT nodes to describe the power domains available on the
i.MX8MN. There are four power domains, but the displaymix and mipi
power domains need a separate clock block controller which is also
pending for 8MP and 8MM. Once the path for those is clear, Nano will
need something similar, but the registers for Nano differ.  For now,
the dispmix and mipi are placeholders.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 9b4baf7bdfb1..27733fbe87e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -596,6 +596,55 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mn-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
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
+
+					dispmix_pd: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_DISPMIX>;
+						clocks = <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+							 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+							 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+					};
+
+					mipi_pd: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MN_POWER_DOMAIN_MIPI>;
+						power-domains = <&dispmix_pd>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.25.1

