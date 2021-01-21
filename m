Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147F92FE7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbhAUKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbhAUK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:29:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3742BC0617A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so1812604edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03jDdVsHWABmgrMGYxTKqglWcTZOSBLi2r7Msa4qweQ=;
        b=T/YvtqUIJ3VyoZ7WhYeu6vpUvItqA1Yb4ORxmREBN+CU7//I522B+QqPB8vi95g36b
         w4E7jwfdcuVNE09+z4if7JX1kHI7tNy7PzLmoEh+o72ZanrgR/4rfYhIAEoM88094VaF
         bqxSmSBLYIqB9GoL+8Ip0euyNmN8e/iY0uYC85x9/wyxkCZA7JmPueOKpUPYXCrgo1Oa
         rceE9K+BOanw2Nl6w27pHQUwNIqoyMb9QcHqm1hpY/vFZe7mveumXVm8u4sc7tfRIwFS
         1UZJa0/QJR9lHxrN0vkPDsIv4XPL2z9xxtH+0ZDcluDULkbbckR9/cbIcE1lm0DF6+8j
         +BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=03jDdVsHWABmgrMGYxTKqglWcTZOSBLi2r7Msa4qweQ=;
        b=pgXSs+i4XR8INPMC3Zk0J1JWCmwKl0hcyHtK1Ko+EmDXCjkkUx+NUukxoOCVbRNJEE
         pIm9qMK+UxR0D+sKPdQJP1i55B6gQ3ZXcAa/x4k1BFMnvwUA9VteucvwPnzYQLZviNne
         a1abi320ZLK78dV7893EQBbEcesvGoBrt5yE8IhST1cygLA+uYJs7pphplv3PQqxTfHr
         yaPyWWrCWMdQArW6Kql+a32Znbn79DsiKPY8tG1yMYCuQoRWe0nHw+TkGkJxbrES+9lT
         nMRyeck3PaQvgMtCuI+aDxkwas5juaHj3W9M/x7iniM055UO/zY7zb+aMeGWgftzekSh
         F5PQ==
X-Gm-Message-State: AOAM532jY/kAvOKnPvblsprOaaNZDOVVxXQnBTaqq3LYTfxPSLvtFlTk
        Th9Z3l0E7eQfjzrawjAte0UtHPqM0CUZogVw
X-Google-Smtp-Source: ABdhPJx8PBmtDReaqzLSbecIS9e3NitrNGV2VYA7XqRpLcVAB+ZAhdOlA9FWgJtwpzTk+DlHbKG7pQ==
X-Received: by 2002:a05:6402:1701:: with SMTP id y1mr10362420edu.251.1611224842778;
        Thu, 21 Jan 2021 02:27:22 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j23sm2562857edv.45.2021.01.21.02.27.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:22 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/12] arm64: dts: zynqmp: Add missing lpd watchdog node
Date:   Thu, 21 Jan 2021 11:26:58 +0100
Message-Id: <0489a1d5528614f1d570ea153d38b813f0c1eb9f.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP SoC has FPD (Full Power Domain) and LPD (Low Power Domain)
watchdogs. There are cases where also LPD WDT should be used by Arm cores
that's why list it with disabled status.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 6a577e1383c1..3ca7e4ee51b5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -223,3 +223,7 @@ &usb1 {
 &watchdog0 {
 	clocks = <&zynqmp_clk WDT>;
 };
+
+&lpd_watchdog {
+	clocks = <&zynqmp_clk LPD_WDT>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 533c19b80283..467f92c2044b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -786,5 +786,14 @@ watchdog0: watchdog@fd4d0000 {
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		lpd_watchdog: watchdog@ff150000 {
+			compatible = "cdns,wdt-r1p2";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 52 1>;
+			reg = <0x0 0xff150000 0x0 0x1000>;
+			timeout-sec = <10>;
+		};
 	};
 };
-- 
2.30.0

