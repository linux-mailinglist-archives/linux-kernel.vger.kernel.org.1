Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6912A0469
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgJ3Lh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgJ3Lg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:29 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B749C0613D4;
        Fri, 30 Oct 2020 04:36:29 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k9so6293047edo.5;
        Fri, 30 Oct 2020 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htP1Snv7NkPVsjMLWMR+sUOLT5JkPpjPoyR9+y5vN8U=;
        b=p5vZsgB/K7eKZtKVile6kvpN9plOyuy+mtGUMdNa7Vzw2DMSstVQO5bKFehtOhech+
         Wv99kQXFhbPDwhrXFzALINWmV0jkYs4JkqjYBFz7UpSL1bDc8Ov/ID+tSMx10T76Y1So
         8rGmZatLWR7qP7Aem/gANGZrsigDyzsQCg2n8wgzG3YqHvHYou5zhuGHMhFMtoa10r/0
         G8HHM6v1YSDUDv3k0ewJD39Q+zOtKnB7opMpSy8bou0CXIz++J3KRMjo6ltlVSzEk1El
         AfueJcdeLTB6MqUxO7lmU6MIKAkXsW5WZZGsP9LfeKVspphXfQ9OYoX+6Ht3iIcUC+hZ
         MMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htP1Snv7NkPVsjMLWMR+sUOLT5JkPpjPoyR9+y5vN8U=;
        b=AbVU3syf/0VvJYI10/+zEamDiqV7JqXGXNWFLC1L0P8gZFIS7kIWcbxB73Uxh4y86q
         z3yefWpvxp45OcKZ27PG7yCaOm6T5zapQsXZEe6kWIeBzB+5LqhmfCP2kbEJ9vIRBKNM
         kHntbXK5bPrdN+o0c2P6Yy4gxDDZa3jOjy0+IIcWYq+VXkAH9rLyfsdChMAia1Vj/jYp
         Fe5XMVrORUsRKZL9DAlvsb3D5Ytcmlfv0Vwtm2gmddfFLQTzLt5cz5hzDvmDHGHBcUXj
         CnZxrWcCwbJyEMXYiobEYV9ZljtQIzvvUMzQbA/JsgVz91znNqJRYfUXWCDMapuaNKal
         wYdQ==
X-Gm-Message-State: AOAM532LtfnLLO6KU+Ocf4Ia7bDk6Wf8fFWxl1SmeZ+ah9NN2Gt0T/TQ
        6YsJpW1Ym6B7R7LGM4/8RB0=
X-Google-Smtp-Source: ABdhPJwGyn7gx16w4mr29Qs2c9yhBLPwlPoL84yH6GFDS+om/IWWkGGjiRPwvjsendDZWSiBG3396g==
X-Received: by 2002:a05:6402:1779:: with SMTP id da25mr1780653edb.60.1604057787755;
        Fri, 30 Oct 2020 04:36:27 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:27 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 09/11] arm64: dts: ls208xa: add PCS MDIO and PCS PHY nodes
Date:   Fri, 30 Oct 2020 13:35:53 +0200
Message-Id: <20201030113555.726487-10-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add PCS MDIO nodes for the internal MDIO buses on the LS208x SoCs, along
with their internal PCS PHYs which will be used when the DPMAC object is
in TYPE_PHY mode.
Also, rename the dpmac@x nodes to ethernet@x in order to be compliant
with the naming convention used by ethernet controllers.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - renamed dpmac@x into ethernet@x
Changes in v4:
 - none
Changes in v5:
 - renamed all PHY nodes to ethernet-phy


 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    |  32 +++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 256 ++++++++++++++++--
 2 files changed, 272 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index 854f604049ca..60563917be44 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -110,3 +110,35 @@ mdio2_phy4: ethernet-phy@3 {
 		reg = <0x3>;
 	};
 };
+
+&pcs_mdio1 {
+	status = "okay";
+};
+
+&pcs_mdio2 {
+	status = "okay";
+};
+
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
+&pcs_mdio5 {
+	status = "okay";
+};
+
+&pcs_mdio6 {
+	status = "okay";
+};
+
+&pcs_mdio7 {
+	status = "okay";
+};
+
+&pcs_mdio8 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 4f59937793ef..9c0e43173cbf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -476,6 +476,214 @@ emdio2: mdio@8b97000 {
 			status = "disabled";
 		};
 
+		pcs_mdio1: mdio@8c07000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c07000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs1: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio2: mdio@8c0b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs2: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio3: mdio@8c0f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs3: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio4: mdio@8c13000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c13000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs4: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio5: mdio@8c17000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c17000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs5: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio6: mdio@8c1b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c1b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs6: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio7: mdio@8c1f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c1f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs7: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio8: mdio@8c23000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c23000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs8: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio9: mdio@8c27000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c27000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs9: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio10: mdio@8c2b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c2b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs10: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio11: mdio@8c2f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c2f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs11: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio12: mdio@8c33000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c33000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs12: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio13: mdio@8c37000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c37000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs13: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio14: mdio@8c3b000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c3b000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs14: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio15: mdio@8c3f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c3f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs15: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
+		pcs_mdio16: mdio@8c43000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c43000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs16: ethernet-phy@0 {
+				reg = <0>;
+			};
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
@@ -500,84 +708,100 @@ dpmacs {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				dpmac1: dpmac@1 {
+				dpmac1: ethernet@1 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x1>;
+					pcs-handle = <&pcs1>;
 				};
 
-				dpmac2: dpmac@2 {
+				dpmac2: ethernet@2 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x2>;
+					pcs-handle = <&pcs2>;
 				};
 
-				dpmac3: dpmac@3 {
+				dpmac3: ethernet@3 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x3>;
+					pcs-handle = <&pcs3>;
 				};
 
-				dpmac4: dpmac@4 {
+				dpmac4: ethernet@4 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x4>;
+					pcs-handle = <&pcs4>;
 				};
 
-				dpmac5: dpmac@5 {
+				dpmac5: ethernet@5 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x5>;
+					pcs-handle = <&pcs5>;
 				};
 
-				dpmac6: dpmac@6 {
+				dpmac6: ethernet@6 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x6>;
+					pcs-handle = <&pcs6>;
 				};
 
-				dpmac7: dpmac@7 {
+				dpmac7: ethernet@7 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x7>;
+					pcs-handle = <&pcs7>;
 				};
 
-				dpmac8: dpmac@8 {
+				dpmac8: ethernet@8 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x8>;
+					pcs-handle = <&pcs8>;
 				};
 
-				dpmac9: dpmac@9 {
+				dpmac9: ethernet@9 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x9>;
+					pcs-handle = <&pcs9>;
 				};
 
-				dpmac10: dpmac@a {
+				dpmac10: ethernet@a {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xa>;
+					pcs-handle = <&pcs10>;
 				};
 
-				dpmac11: dpmac@b {
+				dpmac11: ethernet@b {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xb>;
+					pcs-handle = <&pcs11>;
 				};
 
-				dpmac12: dpmac@c {
+				dpmac12: ethernet@c {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xc>;
+					pcs-handle = <&pcs12>;
 				};
 
-				dpmac13: dpmac@d {
+				dpmac13: ethernet@d {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xd>;
+					pcs-handle = <&pcs13>;
 				};
 
-				dpmac14: dpmac@e {
+				dpmac14: ethernet@e {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xe>;
+					pcs-handle = <&pcs14>;
 				};
 
-				dpmac15: dpmac@f {
+				dpmac15: ethernet@f {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xf>;
+					pcs-handle = <&pcs15>;
 				};
 
-				dpmac16: dpmac@10 {
+				dpmac16: ethernet@10 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0x10>;
+					pcs-handle = <&pcs16>;
 				};
 			};
 		};
-- 
2.28.0

