Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C22BAECA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgKTPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbgKTPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:21:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD04C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:39 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so10135581wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IvsaRxlkYaeGWO/XxLo0cfwTuBt8jqtHYtt1Lx83QU=;
        b=n/pMuteVeHKykxWI2lEN0TRBOQ6ovm1raNNcPAFBwcqTfjnSdvg+bchGqVWcVB5YbC
         kJ2swqbQTQ8WFJgWJ0b73gRr6mUkCXhvSMOPszqsytGEALQRuHwjvtdz2vYKL/oLiYMj
         Set3jDoAE5bs4+zxPan7AvweVcoFnc1cm9WC+lM+Yr2SNcezK7lG1MaECUiyIt1hwUjj
         aAoJrUx5e1A45jjK/EEjEdrWdQChXlrsc+PnYh47MD0gJGfAPnf8HpzcYtfzhddGKrkf
         0N3oGYxd4VQ83dn6Pe9XcEkXAzN3PwhTM4NzkkykSZsvMIYKAtlcIAkdsGBD+PNpsrLE
         6aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IvsaRxlkYaeGWO/XxLo0cfwTuBt8jqtHYtt1Lx83QU=;
        b=XmB/jEnwUU3uClYxnJ0MCSfE88gwJw1PxkUM/mAdoZiOXa9NXY1kqjk3n5dNOmPcu2
         dMy4spcuIXnxroi+qaJlxQx0MxXS4LYKFMbvGjsJhmTbMWMH2wzsutz2gtxAOgGK6EuN
         j6mWFkxZcRdaHqDBXgqna5dJRhm1pEQy96zcori4RX62752vOPFB68tZfy+4dhFgdijf
         ozK54CjWjVwofo8t46yLgc69Mt9Cre36lcxswdv6z+0r1H2PXbaycWMGoLoDCpCtzwtC
         tkiv2eJb/Kvrsb3vt3m1RiasCgcc7NrvJwHJYYQXrx+XNIm652MEfrsHPXgVoJ2iuPll
         igtw==
X-Gm-Message-State: AOAM530+pQrgbK5Suku7RtMnmtkn2ZTLm+dZW+Qy9UP1F2hxelXLM1H3
        bxI9CZn56ZfjbTRrIeThcFwh7g==
X-Google-Smtp-Source: ABdhPJzmbNpSp/WrsvW76hP3Zm8gdpqSmlrivsFnrRZ1fWnnF6WYbhJ+LXtWLcMxtrkwfrtJwnV2mA==
X-Received: by 2002:a1c:1b12:: with SMTP id b18mr10454975wmb.119.1605885697955;
        Fri, 20 Nov 2020 07:21:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id j71sm4773757wmj.10.2020.11.20.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:21:37 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-axg: add MIPI DSI PHY nodes
Date:   Fri, 20 Nov 2020 16:21:31 +0100
Message-Id: <20201120152131.3918814-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120152131.3918814-1-narmstrong@baylibre.com>
References: <20201120152131.3918814-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the nodes for :
- MIPI DSI+PCIe analog phy
- MIPI D-PHY

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 288667699ec0..d811708f8f67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1159,6 +1159,12 @@ pwrc: power-controller {
 							       <250000000>,
 							       <0>; /* Do Nothing */
 				};
+
+				mipi_pcie_analog_dphy: phy {
+					compatible = "amlogic,axg-mipi-pcie-analog-phy";
+					#phy-cells = <0>;
+					status = "disabled";
+				};
 			};
 		};
 
@@ -1171,6 +1177,19 @@ mailbox: mailbox@ff63c404 {
 			#mbox-cells = <1>;
 		};
 
+		mipi_dphy: phy@ff640000 {
+			compatible = "amlogic,axg-mipi-dphy";
+			reg = <0x0 0xff640000 0x0 0x100>;
+			clocks = <&clkc CLKID_MIPI_DSI_PHY>;
+			clock-names = "pclk";
+			resets = <&reset RESET_MIPI_PHY>;
+			reset-names = "phy";
+			phys = <&mipi_pcie_analog_dphy>;
+			phy-names = "analog";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		audio: bus@ff642000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff642000 0x0 0x2000>;
-- 
2.25.1

