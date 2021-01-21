Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDDE2FEB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbhAUNTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbhAUK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:29:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7EC06179E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c6so1846919ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DDHtgVgCI3xoR+2tl7rSC8UaomaVNk4TcynImS9GqP0=;
        b=ew4E+0kbc9NbV8dzIIhFrWdPPYQfUke68fhFjgy5mYLF3hFUsZmOuGMO/0cHt2i6KL
         KQvAfS6eaFOr3hRpdQPhsg9D9umot9ObpJiXz3UiMlOpLTQDmXNp7xBsG39uPKurZjdi
         6FxEvqv+rP4hYQxtUYStYKn85KGLMU6wZo/54oMwE7RwICSELCUyw+W1cgEayR0T0vXa
         WUmkDstsP/hScUX59RQlP4tTDZUfE15IERhCKx/SFidpw3bjSYDHR6Fy1u6QjJCtdCGN
         E3jiN7CpuCXRD5diXgky2WL4CYqmajScw4nEAg0iGT2yZizl0I6O03nynB8jRoq1jhBr
         lpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DDHtgVgCI3xoR+2tl7rSC8UaomaVNk4TcynImS9GqP0=;
        b=OyxF1L47n+iYrO2dfxpQeh+EOwovz62/IC+drryqqqFVFZah0iP4cchycBxEbZwmUd
         u98M7NGQ01XGFfLbYXRl6zpq8NV38Hqrah5Aq+EbWgpFMNwqPDpiQ5289Lv0AjE+2rBl
         oVtXTBFv582FRVDvFhPg1imibMP0GENw3R6GJgwBuKNyK4XNeikssUFWf0YrWiMlJ3+l
         B1at2/q87Xk1l9I6e/kmUvdp8rkafJclqJhXCNbOWzBVy8cBmlmul0lMmPfIO0hfEGAz
         YRpFR+WKZAC7rnmz2pXvjWFvgZpWMxgw9Ps63nKZd0w8sfcH4aB3zAdFyA3KDGZI3tT1
         m+sA==
X-Gm-Message-State: AOAM5315s9qIm+wC8Ad89YJmZn7dJRJXM/5bPaXMWoSB81slNyxG6kdF
        51TI95elfBvimaFxC5vo0Pkdb9I4lgAqVheJ
X-Google-Smtp-Source: ABdhPJz4uD0K+vtOESSsSJK86HYEPo8ADdZBd22vXjc3E/Uw6nZmyagvbLHsSDq62fuPuI5QTUIfiA==
X-Received: by 2002:a05:6402:1809:: with SMTP id g9mr2324851edy.2.1611224839412;
        Thu, 21 Jan 2021 02:27:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q2sm2528621edn.91.2021.01.21.02.27.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:18 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/12] arm64: dts: zynqmp: Wire arasan nand controller
Date:   Thu, 21 Jan 2021 11:26:56 +0100
Message-Id: <05cc1ce7973ac5200aeca428c137b422c827c5e8.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing arasan controller with clocks. Disable it by default. Every
board can enable it with specifying others properties.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index c94c3bb67edc..7af57619436d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -116,6 +116,10 @@ &lpd_dma_chan8 {
 	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
 
+&nand0 {
+	clocks = <&zynqmp_clk NAND_REF>, <&zynqmp_clk LPD_LSBUS>;
+};
+
 &gem0 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
 		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 31c6943c6217..19b349f00ce7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -462,6 +462,18 @@ mc: memory-controller@fd070000 {
 			interrupts = <0 112 4>;
 		};
 
+		nand0: nand-controller@ff100000 {
+			compatible = "xlnx,zynqmp-nand-controller", "arasan,nfc-v3p10";
+			status = "disabled";
+			reg = <0x0 0xff100000 0x0 0x1000>;
+			clock-names = "controller", "bus";
+			interrupt-parent = <&gic>;
+			interrupts = <0 14 4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&zynqmp_firmware PD_NAND>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.30.0

