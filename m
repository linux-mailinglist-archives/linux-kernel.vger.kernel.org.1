Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB52CBF06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgLBOHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgLBOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:43 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F6C061A47
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f23so4477731ejt.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZqCiWie0X6dYLWiXiDsF92YNK3DRTjdp8U9Zg3LS4I=;
        b=c5uAiOA1bGp3aew2ryi5VqAuYQxpY1qkVYLEpfmNGTTMDFcMBf7EqKjpG8uo+D5co8
         gOwW9s9iM9bPTEqbhp4ZmElr/sAlyLVfvaITT3un30TP6fZSslaGL4slHnduLRUtVZsN
         UZtuw6ljxPCtGRWR3GtJOuBPGpQAbTvY7hl+thMNHRf7dsp9rarnWe4EiUHau56jV4AH
         NmFqfQM3sxDdV3jNxghB6it1YAO/C54g5v0NasRQmavI6mC7VD73X1+49IkGYQYyt+NE
         UoWpFtqTxJFYf/MbQvHE4ZQDN4XA+y2qgFzrWFQY0mUGxuIi74OhYWrvFf1FGV7TCZzE
         0qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1ZqCiWie0X6dYLWiXiDsF92YNK3DRTjdp8U9Zg3LS4I=;
        b=jQj3zTEjaQDjEvbvl0l9SP6E58j1wm96Jd744XKAvnApf+W1zYGKtZfU0qAQIKcGpX
         a7u1guW8cJYGi42oKP9XMBmRDF02YVwKsDsAI2S8wIQBRhkJwPJX6LvNvd7mYSWS3yUJ
         pmoj/Z0PJ/9gil3ta3b7jyIP1zYu+cm7sPr5OyVBaPa7QZ1mYJQBcnMvqyW54Ij88J2N
         bNqFRN2sxmj56ayTRb05hQTNb3UrfandeWb1zmoi30rKIC86uC085WudCRNZRTDeqjKJ
         POF6WOmLh36CcEdC/2W7d2gMcuq+AwsvUWCFtlj45w9Xdb9pcSSggYfOPrJjAVVvYVxJ
         LBvQ==
X-Gm-Message-State: AOAM5338XTos/WINSfDrdwOb7ZtiIhOEU8K4Vg439RDdWhqbRtAnXO4y
        gLr4fQQRktoNwEEdDN5J0gMcY9exC42eAf2t
X-Google-Smtp-Source: ABdhPJxZtV1AZTwUlSPGhalqThuLlka/V0nj9X2YtpRCkiU76k1gucd90YWEpDqVokzOC9EzfQ1lVA==
X-Received: by 2002:a17:906:1752:: with SMTP id d18mr2492675eje.529.1606917979213;
        Wed, 02 Dec 2020 06:06:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id l25sm1300638ejz.84.2020.12.02.06.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:18 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106
Date:   Wed,  2 Dec 2020 15:06:01 +0100
Message-Id: <2113c593f38bf347468f1416ef197595e18be3fa.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Origin DT binding just specify driver but wasn't aligned with DT binding
which came later. Extend description for zcu102 and zcu106 to cover latest
binding.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 17 ++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index f1255f635dfd..5ff7ab665374 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -132,6 +132,12 @@ ina226-u75 {
 		compatible = "iio-hwmon";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
+
+	refhdmi: refhdmi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <114285000>;
+	};
 };
 
 &can1 {
@@ -526,6 +532,17 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
 				 * interrupt-parent = <&>;
 				 * interrupts = <>;
 				 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&refhdmi>;
+				clock-names = "xtal";
+				clock-output-names = "si5328";
+
+				si5328_clk: clk0@0 {
+					reg = <0>;
+					clock-frequency = <27000000>;
+				};
 			};
 		};
 		/* 5 - 7 unconnected */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 6e9efe233838..7910ac125101 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -132,6 +132,12 @@ ina226-u75 {
 		compatible = "iio-hwmon";
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
+
+	refhdmi: refhdmi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <114285000>;
+	};
 };
 
 &can1 {
@@ -520,6 +526,22 @@ i2c@4 {
 			reg = <4>;
 			si5328: clock-generator@69 {/* SI5328 - u20 */
 				reg = <0x69>;
+				/*
+				 * Chip has interrupt present connected to PL
+				 * interrupt-parent = <&>;
+				 * interrupts = <>;
+				 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#clock-cells = <1>;
+				clocks = <&refhdmi>;
+				clock-names = "xtal";
+				clock-output-names = "si5328";
+
+				si5328_clk: clk0@0 {
+					reg = <0>;
+					clock-frequency = <27000000>;
+				};
 			};
 		};
 		i2c@5 {
-- 
2.29.2

