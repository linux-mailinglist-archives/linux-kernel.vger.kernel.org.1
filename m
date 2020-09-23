Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA1274DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIWA5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:57:54 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:53300 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:57:54 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 20:57:53 EDT
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id ADACF20E9F;
        Wed, 23 Sep 2020 00:57:52 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 64AEC2008F;
        Wed, 23 Sep 2020 00:57:50 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 169913F1CC;
        Wed, 23 Sep 2020 02:57:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id E9D262A911;
        Wed, 23 Sep 2020 02:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600822668;
        bh=3cauKbaaIYpNe2YRY1yCCu6bIEqLoIVrJ8tlDq7Lf2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQZystxj8DnnsiRHZu5qmCVAMsy6IM+5MRWckADCEu9dLiekieV8ZZOkELuu/Rz3j
         A5aYp4FxVEd7hTvJkXQmX/y/qGuuPkKMpQYAVZZ6btkDZW2CwGJuRlZkK9kc2su3Jg
         n3c3Va3auzO/GBDhPvYdmGo1Qbr2HdROdBmCMN5Y=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tbO11bGT3mXG; Wed, 23 Sep 2020 02:57:46 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 02:57:46 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 65E4B41024;
        Wed, 23 Sep 2020 00:57:46 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="hqFOZ+9+";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 526A041024;
        Wed, 23 Sep 2020 00:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822662; bh=3cauKbaaIYpNe2YRY1yCCu6bIEqLoIVrJ8tlDq7Lf2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqFOZ+9+EKCv5k2Cvex4LdrbYtM8cAF560bZL9RgFy9jC/NEFJEuqMtugMHn2lZTM
         wX2fpeqEdLanHrPUkCIkVC2Rje5KtNMVRUMe5XEvf2JhYZwsx6+E2adqBQBlDVRnbM
         kCr6k/L/qZuiFaUT7FnYdr771cgzWZYN81+Fq4c4=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/7] ARM: dts: sun8i: V3/V3s/S3/S3L: add Ethernet support
Date:   Wed, 23 Sep 2020 08:57:03 +0800
Message-Id: <20200923005709.147966-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923005709.147966-1-icenowy@aosc.io>
References: <20200923005709.147966-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65E4B41024
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.1:email,0.0.0.2:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3/V3s/S3L/SoChip S3 Ethernet MAC and internal PHY is quite
similar to the ones on Allwinner H3, except for V3s the external MII is
not wired out.

Add ethernet support to V3/V3s/S3/S3L.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3.dtsi  | 13 ++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi | 52 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index 6ae8645ade50..ca4672ed2e02 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -9,6 +9,19 @@ &ccu {
 	compatible = "allwinner,sun8i-v3-ccu";
 };
 
+&emac {
+	/delete-property/ phy-handle;
+	/delete-property/ phy-mode;
+};
+
+&mdio_mux {
+	external_mdio: mdio@2 {
+		reg = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
+
 &pio {
 	compatible = "allwinner,sun8i-v3-pinctrl";
 };
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 6eb9c39aa93f..7d40897dab09 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -138,6 +138,15 @@ mixer0_out_tcon0: endpoint {
 			};
 		};
 
+		syscon: system-control@1c00000 {
+			compatible = "allwinner,sun8i-v3s-system-control",
+				     "allwinner,sun8i-h3-system-control";
+			reg = <0x01c00000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
@@ -415,6 +424,49 @@ i2c1: i2c@1c2b000 {
 			#size-cells = <0>;
 		};
 
+		emac: ethernet@1c30000 {
+			compatible = "allwinner,sun8i-v3s-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			phy-handle = <&int_mii_phy>;
+			phy-mode = "mii";
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+
+			mdio_mux: mdio-mux {
+				compatible = "allwinner,sun8i-h3-mdio-mux";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio-parent-bus = <&mdio>;
+				/* Only one MDIO is usable at the time */
+				internal_mdio: mdio@1 {
+					compatible = "allwinner,sun8i-h3-mdio-internal";
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					int_mii_phy: ethernet-phy@1 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <1>;
+						clocks = <&ccu CLK_BUS_EPHY>;
+						resets = <&ccu RST_BUS_EPHY>;
+					};
+				};
+			};
+		};
+
 		spi0: spi@1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.27.0
