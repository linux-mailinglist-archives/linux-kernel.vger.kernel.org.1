Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8E2CBF03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgLBOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgLBOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:03 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5DC0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so4415237ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fw0c1vN25O3p+wsWwRXMndS7i0G5WWG/KRE/RpibJE=;
        b=oNoI9O7sqt8AxEf9aQbniuMZTVMVkzdQm+4ld7zxACwP86n5QOf26HwsHZcHLvbuLo
         LpH/fGNUEPsS+G9TokdZAZpLjcF6JkoYnbouzZaOJimlj0kUzoFGq80FpvhRDmaMGAS6
         eHD9zMKJnPn5UD1kY1LcU2V0EX2ZR24norGXsQfmH3M2wIlFfdbMOEstVvxkywKjYcvy
         Ozdu4yMHq4M3NYKURK38HH43AUZaF89xREF+goKFw+V9jKquv0t49xhDoEf/C9gwCrLa
         UMAXHgW6/ARlbmoidLjFWG5ov1B+E8zZCJWMO/+LlwQ70eXweuYIDXm/Faw36ReFFsKG
         tphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9fw0c1vN25O3p+wsWwRXMndS7i0G5WWG/KRE/RpibJE=;
        b=irECCbLFG/paYUX2NJqEyVTjb3CPI3bybe6gKX7irZx0+wNbuJ9hL2XiILzsH5Tdl1
         TEa/WsrYZXXStzkXv0W+9zXkTiMJGOtyZbpQIfujFDVtWdoeTd+LW+jBRHCdVPQikg+m
         +gYseWPRa/GOlqaSoDj+OVWCLgh5I28/7ztGplRKi5K6co5cOPjOxtMcJ2HOu5xr7UuG
         ICTZpctq7ZSRtiNTSjB8SDYOXpktY3bi+M8NV20H4ekPW7sdlIPYR7BFHqPtDNx64a/J
         XOiV1+jRK5RaC/hTncfnjef0125nhaDMDy34PpAwNjxUafYI0+HNbuTQBtUPE0rw0a96
         xtLg==
X-Gm-Message-State: AOAM532ZAUUfTBetBnOOEy7LTE8PTsnLYg/5ZCJvFfzn4MXoz/VR7nRJ
        frLMMFiYvITs5VhaOEgl2Z0ZOrzcTe0KlYAV
X-Google-Smtp-Source: ABdhPJxLGUWNldyoyyGpA5ToxlYngiIh2OO2SeZyt9xreCYBTUSa60Dqz5S0QUfA7HKWxgSqgS1Jyw==
X-Received: by 2002:a17:906:ee2:: with SMTP id x2mr2542193eji.326.1606917981519;
        Wed, 02 Dec 2020 06:06:21 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x16sm313775ejo.104.2020.12.02.06.06.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:20 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/12] arm64: dts: zynqmp: Enable si5341 driver for zcu102/106/111
Date:   Wed,  2 Dec 2020 15:06:02 +0100
Message-Id: <679a09c15babcc6c209e5e6466a9fa76d1e2c271.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable si5341 driver is the main chip for providing preprogrammed clocks
for the whole platform.

 # cat /sys/kernel/debug/clk/clk_summary
...
 refhdmi                              1        1        0   114285000          0     0  50000
    xtal_0                            0        0        0   114285000          0     0  50000
       pll_0                          0        0        0 40731174000000          0     0  50000
          clk1_0                      0        0        0    27000000          0     0  50000
          clk0_0                      0        0        0    27000000          0     0  50000
 ref48M                               1        2        0    48000000          0     0  50000
    si5341                            0        4        0    14000000          0     0  50000
       clock-generator.N4             0        0        0           0          0     0  50000
       clock-generator.N3             0        1        0   733260000          0     0  50000
          clock-generator.9           0        1        0    33330000          0     0  50000
       clock-generator.N2             0        1        0   104000000          0     0  50000
          clock-generator.2           0        1        0    26000000          0     0  50000
       clock-generator.N1             0        2        0   594000000          0     0  50000
          clock-generator.7           0        1        0    74250000          0     0  50000
          clock-generator.0           0        1        0    27000000          0     0  50000
       clock-generator.N0             0        4        0  1000000000          0     0  50000
          clock-generator.8           0        0        0           0          0     0  50000
          clock-generator.6           0        1        0   125000000          0     0  50000
          clock-generator.5           0        1        0   100000000          0     0  50000
          clock-generator.4           0        1        0   100000000          0     0  50000
          clock-generator.3           0        1        0   125000000          0     0  50000
          clock-generator.1           0        0        0           0          0     0  50000
...

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 56 ++++++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 45 +++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 46 ++++++++++++++-
 3 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5ff7ab665374..68c2ad30d62d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -133,6 +133,13 @@ ina226-u75 {
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
 
+	/* 48MHz reference crystal */
+	ref48: ref48M {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
 	refhdmi: refhdmi {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -489,9 +496,56 @@ i2c@1 {
 			#size-cells = <0>;
 			reg = <1>;
 			si5341: clock-generator@36 { /* SI5341 - u69 */
+				compatible = "silabs,si5341";
 				reg = <0x36>;
-			};
+				#clock-cells = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&ref48>;
+				clock-names = "xtal";
+				clock-output-names = "si5341";
 
+				si5341_0: out@0 {
+					/* refclk0 for PS-GT, used for DP */
+					reg = <0>;
+					always-on;
+				};
+				si5341_2: out@2 {
+					/* refclk2 for PS-GT, used for USB3 */
+					reg = <2>;
+					always-on;
+				};
+				si5341_3: out@3 {
+					/* refclk3 for PS-GT, used for SATA */
+					reg = <3>;
+					always-on;
+				};
+				si5341_4: out@4 {
+					/* refclk4 for PS-GT, used for PCIE slot */
+					reg = <4>;
+					always-on;
+				};
+				si5341_5: out@5 {
+					/* refclk5 for PS-GT, used for PCIE */
+					reg = <5>;
+					always-on;
+				};
+				si5341_6: out@6 {
+					/* refclk6 PL CLK125 */
+					reg = <6>;
+					always-on;
+				};
+				si5341_7: out@7 {
+					/* refclk7 PL CLK74 */
+					reg = <7>;
+					always-on;
+				};
+				si5341_9: out@9 {
+					/* refclk9 used for PS_REF_CLK 33.3 MHz */
+					reg = <9>;
+					always-on;
+				};
+			};
 		};
 		i2c@2 {
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 7910ac125101..a29ff20090ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -133,6 +133,13 @@ ina226-u75 {
 		io-channels = <&u75 0>, <&u75 1>, <&u75 2>, <&u75 3>;
 	};
 
+	/* 48MHz reference crystal */
+	ref48: ref48M {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
 	refhdmi: refhdmi {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -488,7 +495,45 @@ i2c@1 {
 			#size-cells = <0>;
 			reg = <1>;
 			si5341: clock-generator@36 { /* SI5341 - u69 */
+				compatible = "silabs,si5341";
 				reg = <0x36>;
+				#clock-cells = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&ref48>;
+				clock-names = "xtal";
+				clock-output-names = "si5341";
+
+				si5341_0: out@0 {
+					/* refclk0 for PS-GT, used for DP */
+					reg = <0>;
+					always-on;
+				};
+				si5341_2: out@2 {
+					/* refclk2 for PS-GT, used for USB3 */
+					reg = <2>;
+					always-on;
+				};
+				si5341_3: out@3 {
+					/* refclk3 for PS-GT, used for SATA */
+					reg = <3>;
+					always-on;
+				};
+				si5341_6: out@6 {
+					/* refclk6 PL CLK125 */
+					reg = <6>;
+					always-on;
+				};
+				si5341_7: out@7 {
+					/* refclk7 PL CLK74 */
+					reg = <7>;
+					always-on;
+				};
+				si5341_9: out@9 {
+					/* refclk9 used for PS_REF_CLK 33.3 MHz */
+					reg = <9>;
+					always-on;
+				};
 			};
 
 		};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index d9a8fdbbcae8..92b3cee62d11 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -116,6 +116,13 @@ ina226-u79 {
 		compatible = "iio-hwmon";
 		io-channels = <&u79 0>, <&u79 1>, <&u79 2>, <&u79 3>;
 	};
+
+	/* 48MHz reference crystal */
+	ref48: ref48M {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
 };
 
 &dcc {
@@ -374,9 +381,46 @@ i2c@1 {
 			#size-cells = <0>;
 			reg = <1>;
 			si5341: clock-generator@36 { /* SI5341 - u46 */
+				compatible = "silabs,si5341";
 				reg = <0x36>;
+				#clock-cells = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&ref48>;
+				clock-names = "xtal";
+				clock-output-names = "si5341";
+
+				si5341_0: out@0 {
+					/* refclk0 for PS-GT, used for DP */
+					reg = <0>;
+					always-on;
+				};
+				si5341_2: out@2 {
+					/* refclk2 for PS-GT, used for USB3 */
+					reg = <2>;
+					always-on;
+				};
+				si5341_3: out@3 {
+					/* refclk3 for PS-GT, used for SATA */
+					reg = <3>;
+					always-on;
+				};
+				si5341_5: out@5 {
+					/* refclk5 PL CLK100 */
+					reg = <5>;
+					always-on;
+				};
+				si5341_6: out@6 {
+					/* refclk6 PL CLK125 */
+					reg = <6>;
+					always-on;
+				};
+				si5341_9: out@9 {
+					/* refclk9 used for PS_REF_CLK 33.3 MHz */
+					reg = <9>;
+					always-on;
+				};
 			};
-
 		};
 		i2c@2 {
 			#address-cells = <1>;
-- 
2.29.2

