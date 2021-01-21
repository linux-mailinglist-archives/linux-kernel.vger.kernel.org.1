Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6152C2FEA36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbhAUMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbhAUMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:36:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF79C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a10so2342398ejg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTFXwXdhA76nlO7wgXmqDdaEsv1ovAQtRZb+8A/uvFc=;
        b=UgEuEx3c7+UKHNwa/u1l/T8bA0/okmbKRJWRNfPLbF+zXd0deLCXrU+2uChBcozEzR
         4VVrkVHWu86x/DSx3bGnF9FOIVWJYwZEo/c+rM0TSlTnNbiRCybFFFmIJfh7wv721Tki
         flLMvIhNTiGxmU0qQcFbivhPfyJQK9fxtlVCSYQCH3qeOHQAfpSevXVEi5bXrQ1Dspkc
         uPabyefAfcaZkHM+IZJ8KucYGczREA+5br8WKqzw7fiHlS4xZMbwblqjzhdGDiE/5HLu
         qe02o3EPjeV9Wa8Nnw7wOJ1iirrZVlSSjpYB5fjeqHsHBSENK7k8+Qzekmt4xwBPbifT
         Gd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YTFXwXdhA76nlO7wgXmqDdaEsv1ovAQtRZb+8A/uvFc=;
        b=XvuFde5wOGJSaql/V2sBefoMJ3qM+E27gWLlmGtuFnZq25XiViQzZ70htUegeUO7pT
         /SiQdU3NmgqcROYcCsNhl+VB2WCCJMq1RzZnoKXh8023bHHPj7P5HoRq5Hpsy0AYiSKY
         +IoPGV6mylIA7k9nPne3C+gGP2msPhzY3zeEDD5D0ie5OSyudVgS9foxO9Z/VnVLX6o3
         2DwWBuIL7N9oZuzV+8y96kMRrBPl4ImaEHLyCbzHASR7/hS6yi+w8tOXguwYRz8s4Sq5
         FTWeJ1jSyxkQDMP12EduCXHX+tRFlgkhBd5ITGfTyjB1x+uVDY0BEFb933CqPtTgHVMM
         ToPw==
X-Gm-Message-State: AOAM530h40hppUSrzZ1AxGInWNr0dOciZZAnpVlSBEWkQ2wEqiE6hFuA
        yyun8qaMk4DURdL6Z2r22oPQWWUbhH/b90/K
X-Google-Smtp-Source: ABdhPJzFiSdExPMCSf+KXkZzrlZ4imxwer+cNiCwygFGHnjU5txkAzkYAqarN/Ln18I26XOe5E8AMA==
X-Received: by 2002:a17:906:5585:: with SMTP id y5mr4729152ejp.486.1611232572459;
        Thu, 21 Jan 2021 04:36:12 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z1sm2754108edm.89.2021.01.21.04.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 04:36:11 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm64: dts: zynqmp: Add DisplayPort subsystem
Date:   Thu, 21 Jan 2021 13:36:06 +0100
Message-Id: <4d978aef852cacdfb35aa8e50d648a787e73b90c.1611232558.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611232558.git.michal.simek@xilinx.com>
References: <cover.1611232558.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for the DisplayPort subsystem, a hard IP present in the
Zynq Ultrascale+ MPSoC.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Change node position and label.
---
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  6 +++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 22 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index c676afc95f6d..cf5295224750 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -231,3 +231,9 @@ &lpd_watchdog {
 &zynqmp_dpdma {
 	clocks = <&zynqmp_clk DPDMA_REF>;
 };
+
+&zynqmp_dpsub {
+	clocks = <&zynqmp_clk TOPSW_LSBUS>,
+		 <&zynqmp_clk DP_AUDIO_REF>,
+		 <&zynqmp_clk DP_VIDEO_REF>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f12cd24adbee..a3b391d18787 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -12,6 +12,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
@@ -857,5 +858,26 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
 			clock-names = "axi_clk";
 			#dma-cells = <1>;
 		};
+
+		zynqmp_dpsub: display@fd4a0000 {
+			compatible = "xlnx,zynqmp-dpsub-1.7";
+			status = "disabled";
+			reg = <0x0 0xfd4a0000 0x0 0x1000>,
+			      <0x0 0xfd4aa000 0x0 0x1000>,
+			      <0x0 0xfd4ab000 0x0 0x1000>,
+			      <0x0 0xfd4ac000 0x0 0x1000>;
+			reg-names = "dp", "blend", "av_buf", "aud";
+			interrupts = <0 119 4>;
+			interrupt-parent = <&gic>;
+			clock-names = "dp_apb_clk", "dp_aud_clk",
+				      "dp_vtc_pixel_clk_in";
+			power-domains = <&zynqmp_firmware PD_DP>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_DP>;
+			dma-names = "vid0", "vid1", "vid2", "gfx0";
+			dmas = <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO0>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
+		};
 	};
 };
-- 
2.30.0

