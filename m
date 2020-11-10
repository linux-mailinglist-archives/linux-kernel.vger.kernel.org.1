Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5F2AD068
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgKJHY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:24:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A076DC0613CF;
        Mon,  9 Nov 2020 23:24:56 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so10610243pfp.5;
        Mon, 09 Nov 2020 23:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TZHKc1z9bIJKWtDQfb49ypGPDlhOLGgFEtACkXb6xgE=;
        b=jXikaazWh8k3Jko+AzyVVqiuBHEkyCbHmScyO8rQLt8kAEIOMhFa0N+0t9KWeUAi7C
         DqKtrngEn6IzjjEiKf7fAx7clxd5fLr5auhPaULagGi/fx8HtPpmWGnR2HEqErKVZFwE
         NS9xe2/Eq7YCc5BUAYHIpcS/owcqYqOZxCuhYEK+qIslA/vcd1GSGpLFcU2UfQwJ9T6O
         ooOxOhhGvCoKx5vzCWrInx1y4Sfk/3JBHe2I1vpOmRlTOMPsj6T05nRB5AHjrK9ktlqN
         tzk+J4drawWbzK9o/3gWQH7rjZGsoPKIPLayKxqH1r7EX7v2VwaLgClyK/QO2w5V8hsn
         WYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TZHKc1z9bIJKWtDQfb49ypGPDlhOLGgFEtACkXb6xgE=;
        b=L6PUOcgKsWEh9p+etmxim1iRRIF6VKq4yHQXBvnn4sF6+iDFYBQj2vMLMZNoLO1yGv
         EjSYPOF9p2VFASN2Vd7rfpmxeTJBTlzvSH2+k5oeu0MxlZlVBqfsTvEqVEIrEpm1c6rz
         xc0tFYp7P6mwdujAJKb8VczYKTA59nuHVvwaXf+IycXRZGis3qOMiSJRzrfF9THedpjP
         MJc0AyN0wregcohQ+p6zbZ9xKYUYHL2sk7R34RE19BgKdmenk0teGDi+5y7MbHuzwxA3
         AMz83JRbWpHpCSV109omCoF0JAsfL9I1oMNfMVTYgB1XvAEhSxg/nCMhbFfIN03tHt3f
         82Wg==
X-Gm-Message-State: AOAM530Ch4A0YY6nv3wL9StBwN/wl9lZ+B1Wh9FBjvQl3e1MMd0JpCBZ
        EhCNnKCet2KR9jshMGxPXCw=
X-Google-Smtp-Source: ABdhPJwPHA599Vvcf6uC4iq07QtldsKEsvvBbdNTvl2IToo7fE6mFk3ut/9h4qOcX6ir1VOqxGoITA==
X-Received: by 2002:a17:90a:f292:: with SMTP id fs18mr3541653pjb.222.1604993095923;
        Mon, 09 Nov 2020 23:24:55 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id y5sm13876542pfc.165.2020.11.09.23.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:24:55 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: minipack: Fixup I2C tree
Date:   Mon,  9 Nov 2020 23:24:46 -0800
Message-Id: <20201110072446.8218-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Create all the i2c switches in device tree and use aliases to assign
child channels with consistent bus numbers.

Besides, "i2c-mux-idle-disconnect" is set for all the i2c switches to
avoid potential conflicts when multiple devices (beind the switches) use
the same device address.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 888 ++++++++++++++++++
 1 file changed, 888 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index c34741dbd268..9eb23e874f19 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -70,6 +70,162 @@
 		i2c45 = &imux45;
 		i2c46 = &imux46;
 		i2c47 = &imux47;
+
+		/*
+		 * I2C Switch 24-0071 (channel #0 of 8-0070): 8 channels for
+		 * connecting to left PDB (Power Distribution Board).
+		 */
+		i2c48 = &imux48;
+		i2c49 = &imux49;
+		i2c50 = &imux50;
+		i2c51 = &imux51;
+		i2c52 = &imux52;
+		i2c53 = &imux53;
+		i2c54 = &imux54;
+		i2c55 = &imux55;
+
+		/*
+		 * I2C Switch 25-0072 (channel #1 of 8-0070): 8 channels for
+		 * connecting to right PDB (Power Distribution Board).
+		 */
+		i2c56 = &imux56;
+		i2c57 = &imux57;
+		i2c58 = &imux58;
+		i2c59 = &imux59;
+		i2c60 = &imux60;
+		i2c61 = &imux61;
+		i2c62 = &imux62;
+		i2c63 = &imux63;
+
+		/*
+		 * I2C Switch 26-0076 (channel #2 of 8-0070): 8 channels for
+		 * connecting to top FCM (Fan Control Module).
+		 */
+		i2c64 = &imux64;
+		i2c65 = &imux65;
+		i2c66 = &imux66;
+		i2c67 = &imux67;
+		i2c68 = &imux68;
+		i2c69 = &imux69;
+		i2c70 = &imux70;
+		i2c71 = &imux71;
+
+		/*
+		 * I2C Switch 27-0076 (channel #3 of 8-0070): 8 channels for
+		 * connecting to bottom FCM (Fan Control Module).
+		 */
+		i2c72 = &imux72;
+		i2c73 = &imux73;
+		i2c74 = &imux74;
+		i2c75 = &imux75;
+		i2c76 = &imux76;
+		i2c77 = &imux77;
+		i2c78 = &imux78;
+		i2c79 = &imux79;
+
+		/*
+		 * I2C Switch 40-0073 (channel #0 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #1 (1-based).
+		 */
+		i2c80 = &imux80;
+		i2c81 = &imux81;
+		i2c82 = &imux82;
+		i2c83 = &imux83;
+		i2c84 = &imux84;
+		i2c85 = &imux85;
+		i2c86 = &imux86;
+		i2c87 = &imux87;
+
+		/*
+		 * I2C Switch 41-0073 (channel #1 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #2 (1-based).
+		 */
+		i2c88 = &imux88;
+		i2c89 = &imux89;
+		i2c90 = &imux90;
+		i2c91 = &imux91;
+		i2c92 = &imux92;
+		i2c93 = &imux93;
+		i2c94 = &imux94;
+		i2c95 = &imux95;
+
+		/*
+		 * I2C Switch 42-0073 (channel #2 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #3 (1-based).
+		 */
+		i2c96 = &imux96;
+		i2c97 = &imux97;
+		i2c98 = &imux98;
+		i2c99 = &imux99;
+		i2c100 = &imux100;
+		i2c101 = &imux101;
+		i2c102 = &imux102;
+		i2c103 = &imux103;
+
+		/*
+		 * I2C Switch 43-0073 (channel #3 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #4 (1-based).
+		 */
+		i2c104 = &imux104;
+		i2c105 = &imux105;
+		i2c106 = &imux106;
+		i2c107 = &imux107;
+		i2c108 = &imux108;
+		i2c109 = &imux109;
+		i2c110 = &imux110;
+		i2c111 = &imux111;
+
+		/*
+		 * I2C Switch 44-0073 (channel #4 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #5 (1-based).
+		 */
+		i2c112 = &imux112;
+		i2c113 = &imux113;
+		i2c114 = &imux114;
+		i2c115 = &imux115;
+		i2c116 = &imux116;
+		i2c117 = &imux117;
+		i2c118 = &imux118;
+		i2c119 = &imux119;
+
+		/*
+		 * I2C Switch 45-0073 (channel #5 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #6 (1-based).
+		 */
+		i2c120 = &imux120;
+		i2c121 = &imux121;
+		i2c122 = &imux122;
+		i2c123 = &imux123;
+		i2c124 = &imux124;
+		i2c125 = &imux125;
+		i2c126 = &imux126;
+		i2c127 = &imux127;
+
+		/*
+		 * I2C Switch 46-0073 (channel #6 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #7 (1-based).
+		 */
+		i2c128 = &imux128;
+		i2c129 = &imux129;
+		i2c130 = &imux130;
+		i2c131 = &imux131;
+		i2c132 = &imux132;
+		i2c133 = &imux133;
+		i2c134 = &imux134;
+		i2c135 = &imux135;
+
+		/*
+		 * I2C Switch 47-0073 (channel #7 of 11-0070): connecting
+		 * to PIM (Port Interface Module) #8 (1-based).
+		 */
+		i2c136 = &imux136;
+		i2c137 = &imux137;
+		i2c138 = &imux138;
+		i2c139 = &imux139;
+		i2c140 = &imux140;
+		i2c141 = &imux141;
+		i2c142 = &imux142;
+		i2c143 = &imux143;
 	};
 
 	chosen {
@@ -184,11 +340,16 @@
 &i2c2 {
 	status = "okay";
 
+	/*
+	 * I2C Switch 2-0070 is connecting to SCM (System Controller
+	 * Module).
+	 */
 	i2c-switch@70 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
 		imux16: i2c@0 {
 			#address-cells = <1>;
@@ -269,29 +430,270 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
+		/*
+		 * I2C Switch 8-0070 channel #0: connecting to left PDB
+		 * (Power Distribution Board).
+		 */
 		imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			i2c-switch@71 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x71>;
+				i2c-mux-idle-disconnect;
+
+				imux48: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux49: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux50: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux51: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux52: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux53: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux54: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux55: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 8-0070 channel #1: connecting to right PDB
+		 * (Power Distribution Board).
+		 */
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			i2c-switch@72 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x72>;
+				i2c-mux-idle-disconnect;
+
+				imux56: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux57: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux58: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux59: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux60: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux61: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux62: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux63: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 8-0070 channel #2: connecting to top FCM
+		 * (Fan Control Module).
+		 */
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			i2c-switch@76 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x76>;
+				i2c-mux-idle-disconnect;
+
+				imux64: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux65: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux66: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux67: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux68: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux69: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux70: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux71: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 8-0070 channel #3: connecting to bottom
+		 * FCM (Fan Control Module).
+		 */
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			i2c-switch@76 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x76>;
+				i2c-mux-idle-disconnect;
+
+				imux72: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux73: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux74: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux75: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux76: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux77: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux78: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux79: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
 		imux28: i2c@4 {
@@ -323,11 +725,16 @@
 &i2c9 {
 	status = "okay";
 
+	/*
+	 * I2C Switch 9-0070 is connecting to MAC/PHY EEPROMs on SMB
+	 * (Switch Main Board).
+	 */
 	i2c-switch@70 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
 		imux32: i2c@0 {
 			#address-cells = <1>;
@@ -391,53 +798,534 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		i2c-mux-idle-disconnect;
 
+		/*
+		 * I2C Switch 11-0070 channel #0: connecting to PIM
+		 * (Port Interface Module) #1 (1-based).
+		 */
 		imux40: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux80: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux81: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux82: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux83: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux84: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux85: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux86: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux87: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #1: connecting to PIM
+		 * (Port Interface Module) #2 (1-based).
+		 */
 		imux41: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux88: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux89: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux90: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux91: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux92: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux93: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux94: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux95: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #2: connecting to PIM
+		 * (Port Interface Module) #3 (1-based).
+		 */
 		imux42: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux96: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux97: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux98: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux99: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux100: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux101: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux102: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux103: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #3: connecting to PIM
+		 * (Port Interface Module) #4 (1-based).
+		 */
 		imux43: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux104: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux105: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux106: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux107: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux108: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux109: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux110: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux111: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #4: connecting to PIM
+		 * (Port Interface Module) #5 (1-based).
+		 */
 		imux44: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux112: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux113: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux114: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux115: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux116: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux117: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux118: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux119: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #5: connecting to PIM
+		 * (Port Interface Module) #6 (1-based).
+		 */
 		imux45: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux120: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux121: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux122: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux123: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux124: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux125: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux126: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux127: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #6: connecting to PIM
+		 * (Port Interface Module) #7 (1-based).
+		 */
 		imux46: i2c@6 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <6>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux128: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux129: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux130: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux131: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux132: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux133: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux134: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux135: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 
+		/*
+		 * I2C Switch 11-0070 channel #7: connecting to PIM
+		 * (Port Interface Module) #8 (1-based).
+		 */
 		imux47: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
+
+			i2c-switch@73 {
+				compatible = "nxp,pca9548";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x73>;
+				i2c-mux-idle-disconnect;
+
+				imux136: i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				imux137: i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				imux138: i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				imux139: i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				imux140: i2c@4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				imux141: i2c@5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				imux142: i2c@6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				imux143: i2c@7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
 		};
 	};
 };
-- 
2.17.1

