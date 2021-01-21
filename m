Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158192FF2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbhAUSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbhAUK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:28:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49DC061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id j13so1828211edp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XftOrF3pZsYjg7wIL3rdWbwK37uOKDGUWg/X4U2EjrY=;
        b=mX9O08H2hRdIKpnalbY1xKILUPly7ewHKlxmtthed1+gAaX8dU78Eh4VqpSANCk2ZB
         4feghOQ/vWhhi7l0klj2UBLiq50hdPs7sPGIoUdI3YuNdwJStjaSBK79DUcTJDvULNM4
         pfruVtOVg+qtJZEt1qRhCbDE2Km53mdUZTDYfhv7OVnpNr2sMcmG3u0NbDpX56gWx2Tx
         o83ZUGv5Hr+zONv4F9VZ44NEo17nBUdwu4NYCT8i1N024aHZb3Fyyhf9NDSfNuyx+7b0
         mJxEJQcTVU91iMdYJPWgKaD5jzR/3rYmyjkmB16VxmeLpTwn4fOziZwpwV/Ygne7JKZN
         b30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XftOrF3pZsYjg7wIL3rdWbwK37uOKDGUWg/X4U2EjrY=;
        b=mlWuHTTNlemt6i1rVjOKb0j5kkEuknIxzoBGvve4+p8RI2iyZEDkrRen+PfnqHodcf
         clev3uzFfKtSzHYA5Lxk4C9RUQZd0+GSQL6S7vJxV9ct75tAe//M/fgxHO99k0MHgZgj
         7olagSRDFuv+PAwTRe9Na251lnA2bTSxwYc/wUOC83WXfjOmMroUFAExFmJ9Y/4Nzmp+
         nDYvd28Qys8Hv5T9XiwxdUovBaFrRi+oaPEMZWFpzqKj64VHpkbMvKBPWCUlorbS5uoe
         +JCPw3l7504/Gw7H1Ptl3lAMjGhjfaWc4yvEq5SFzcI+SHBmMXvNCij9oHgpuG+OucJY
         EXWQ==
X-Gm-Message-State: AOAM533z4dWItgIAzYokLY2S1aVZyWurDvUSQmS2AJwj+Fi58iPMg+xp
        CYv+yyPaB0toRrLTxeDIobOikuG3EqxL8VYb
X-Google-Smtp-Source: ABdhPJwY5pg2RtH8aQ5Rnp6MIrsjUFDiGOUgrRGRGZBuP9GV7gwas3P3b9m84MSsrwMpwSLTTiuSJA==
X-Received: by 2002:aa7:c384:: with SMTP id k4mr10349733edq.23.1611224830847;
        Thu, 21 Jan 2021 02:27:10 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a22sm2518005edv.67.2021.01.21.02.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:10 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/12] arm64: dts: zynqmp: Enable si5341 driver for zcu102/106/111
Date:   Thu, 21 Jan 2021 11:26:51 +0100
Message-Id: <b93f13297684704a60e8d7274009a20aa98d14f7.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
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

Changes in v2: None

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
2.30.0

