Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396802CBF08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbgLBOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgLBOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1DDC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a16so4491953ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUUyNhLqJTW8Mklp6WXq5oHjE6EeQcOooLOVP8B0jRI=;
        b=JWOaKrZAaq9NPwZ02Snsu6Jgr33SrHEqvH97VriFEU0vpDJbt/UoR7GrQwOqIe7C8v
         lvM4AKccKP5i5IqCG7WpZaVmxkyE7vtG7Osn8yFcF8bo+Omc1ZNlZw4P7pqJEJFtsbUi
         SJFLH5H3JTPuRd4JPNFdOQhvE7T7TJeCqu9CWqssPjO4uzZ8fTRtT8xM8Fq378OIirYK
         eRRnoFY2Ud+sAeKickLOX4cTg8z+JeYI5J9Q/pS+e8IT72iUwY8wRYHVU4GQlcS1eOzL
         vx2Cx5/xfuNum0sKX7bvvA02dCJ1PZuskWwbM1w22vh5bdFfeqUQPCs3fw/pAAdt8TOW
         I6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yUUyNhLqJTW8Mklp6WXq5oHjE6EeQcOooLOVP8B0jRI=;
        b=eEo4GZa8/hctw1JudMNEHvVFSJYkANS7pU13a8p0PqUCc+GNPkQlCyycmAkAXiSDYk
         S/xJf2msv3jhb5MlKOsRf6AXtV0lGV40UuIPirp4+0ZY6U4V+3ggDZKM1hKuJtcVDtnf
         K3odvqOmcBbebCqdC70ZFL++n+qEG0rKDT4/7r4ZgeZQgdjGIlBiNoc7IkHq7+gUp51E
         HHS+eYo2+cKiXpzsgqOtzbCKUCsjrg8U6P6lVtyhwM6Sw7mtZrEt1qeOx9c5ngq3nTKQ
         9qaRTQEqb0rLONqlCI7jH0BiICDgcKWArnPyrHgeDQ9FXH8PGs8NRv3T672ePtpLCzIX
         CK9Q==
X-Gm-Message-State: AOAM532ozupl0iOjBrl2Gh1qi9aqVAzPw+GrmQr3Uc1opr/0ymjSDjhP
        a2sKJmNpZG9CRI5vNwTuCIDleIGFLI8QRWDc
X-Google-Smtp-Source: ABdhPJzQkorR17XrgemWT28k0CenWfUU9I4FH0o7LTncdXq9SyFPxh17/ovr45AiPuZE8beE1G6ZNg==
X-Received: by 2002:a17:906:3e02:: with SMTP id k2mr2539737eji.92.1606917983227;
        Wed, 02 Dec 2020 06:06:23 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i13sm1284622ejc.57.2020.12.02.06.06.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:22 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/12] arm64: dts: zynqmp: Enable and wire reset controller
Date:   Wed,  2 Dec 2020 15:06:03 +0100
Message-Id: <c0a99c5b0438e34073429624d99a2c3f16532016.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable reset controller for several IPs.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 68923fbd0e89..4fa820f78d76 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -187,6 +187,11 @@ zynqmp_pcap: pcap {
 			xlnx_aes: zynqmp-aes {
 				compatible = "xlnx,zynqmp-aes";
 			};
+
+			zynqmp_reset: reset-controller {
+				compatible = "xlnx,zynqmp-reset";
+				#reset-cells = <1>;
+			};
 		};
 	};
 
@@ -466,6 +471,8 @@ gem0: ethernet@ff0b0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
+			reset-names = "gem0_rst";
 		};
 
 		gem1: ethernet@ff0c0000 {
@@ -478,6 +485,8 @@ gem1: ethernet@ff0c0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
+			reset-names = "gem1_rst";
 		};
 
 		gem2: ethernet@ff0d0000 {
@@ -490,6 +499,8 @@ gem2: ethernet@ff0d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
+			reset-names = "gem2_rst";
 		};
 
 		gem3: ethernet@ff0e0000 {
@@ -502,6 +513,8 @@ gem3: ethernet@ff0e0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
+			reset-names = "gem3_rst";
 		};
 
 		gpio: gpio@ff0a0000 {
@@ -515,6 +528,8 @@ gpio: gpio@ff0a0000 {
 			#interrupt-cells = <2>;
 			reg = <0x0 0xff0a0000 0x0 0x1000>;
 			power-domains = <&zynqmp_firmware PD_GPIO>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_GPIO>;
+			reset-names = "gpio_rst";
 		};
 
 		i2c0: i2c@ff020000 {
@@ -526,6 +541,8 @@ i2c0: i2c@ff020000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_I2C0>;
+			reset-names = "i2c0_rst";
 		};
 
 		i2c1: i2c@ff030000 {
@@ -537,6 +554,8 @@ i2c1: i2c@ff030000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_I2C1>;
+			reset-names = "i2c1_rst";
 		};
 
 		pcie: pcie@fd0e0000 {
@@ -602,6 +621,8 @@ sata: ahci@fd0c0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
+			reset-names = "sata_rst";
 		};
 
 		sdhci0: mmc@ff160000 {
@@ -733,6 +754,10 @@ usb0: usb@fe200000 {
 			reg = <0x0 0xfe200000 0x0 0x40000>;
 			clock-names = "clk_xin", "clk_ahb";
 			power-domains = <&zynqmp_firmware PD_USB_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
+			reset-names = "usb0_crst", "usb0_hibrst", "usb0_apbrst";
 		};
 
 		usb1: usb@fe300000 {
@@ -743,6 +768,10 @@ usb1: usb@fe300000 {
 			reg = <0x0 0xfe300000 0x0 0x40000>;
 			clock-names = "clk_xin", "clk_ahb";
 			power-domains = <&zynqmp_firmware PD_USB_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
+			reset-names = "usb1_crst", "usb1_hibrst", "usb1_apbrst";
 		};
 
 		watchdog0: watchdog@fd4d0000 {
-- 
2.29.2

