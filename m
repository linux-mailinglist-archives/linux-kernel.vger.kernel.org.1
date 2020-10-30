Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C10F2A043F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgJ3Lga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgJ3LgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:22 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DCC0613D2;
        Fri, 30 Oct 2020 04:36:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so6223364edb.12;
        Fri, 30 Oct 2020 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5fc9CtyHSfM/gOgfL12XY4x3FY6xOYb3mBqJV1UFD8=;
        b=LJgZLPVfZ/CGN3BAz8TBVIiOii3UR1VVzAi/vZbXWzsx8ekteK5pyoWBVjPVoF+aqh
         VqkmQL+aLQaTSNkeV3LltIqnyCmXApG/YFXHwFiTJQMZv9RH2PyHtFpAqbypaRzXs0LK
         W82a4TR2QIjj6cWmLyK6/lE7qMpsTrPGp6o36A48g5NEFNbScIP2MjLrQlB7uMzWGKSd
         x0e+lc2pA4v2Yla1z48ihXb2T8Bn9TUU0Gz7/CMfPXxmEZQPQU2o2/90+UEoHTNqTaN1
         mnW2YIBovvcg3dp5z6NPmOvA0SD/I4P12BgIDMX/3lMcvmJmD2eho7+u9dYqNxUA8NUq
         6t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5fc9CtyHSfM/gOgfL12XY4x3FY6xOYb3mBqJV1UFD8=;
        b=pJinypTqY1iEagc5xHyDMv1QeaotpA3Jte5/mcErEJYw8UJ8KyTzZSgKHnysTcOMGs
         vfwdXDyhxsqxidNItZm4qmmumqQZFnBixSYCU1QY/zowATcFeN1G35GGFJmU1Fslb9/h
         PmIufLLmarGWe8T+4DZ+QsAtV7gtaCZMdTGteeRL4YfrOZGTiCiaOwKWln3b/wG1NtVG
         EL2g2hwFvVtGbvEDczklnuiMOU7YexnDufQ/REJQAWleBWOIeXTP47sorNYfT3rzvSXn
         GjTM3Uvlr5pHitVoqhYjUAkWGxVr4ZvclYcNTy5mBieFJDkj6O+igjLkqqPbN0X2NYwT
         wm6A==
X-Gm-Message-State: AOAM530llao2+phmWmV52RkeFkWWw4tOogyG0yoKej43ZJQuHix21MVm
        OT/NGpA18aQb4R+7C/J8blk=
X-Google-Smtp-Source: ABdhPJzwsNrESRDrlth/Bs04ag9oyxJLeJ7SSMCFhzHOvr5TWlsfGUUDVKnKa6KeLXO9E7NbZSQSDw==
X-Received: by 2002:a05:6402:1d2c:: with SMTP id dh12mr1759083edb.256.1604057780849;
        Fri, 30 Oct 2020 04:36:20 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:20 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 04/11] arm64: dts: ls1088ardb: add QSGMII PHY nodes
Date:   Fri, 30 Oct 2020 13:35:48 +0200
Message-Id: <20201030113555.726487-5-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Annotate the external MDIO1 node and describe the 8 QSGMII PHYs found on
the LS1088ARDB board and add phy-handles for DPMACs 3-10 to its
associated PHY.  Also, add the internal PCS MDIO nodes for the internal
MDIO buses found on the LS1088A SoC along with their internal PCS PHY
and link the corresponding DPMAC to the PCS through the pcs-handle.
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
 - renamed all PHY nodes to ethernet-phy@X where the unit address is the
   reg value

 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 100 ++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  70 ++++++++++--
 2 files changed, 160 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index 5633e59febc3..e28443ba2633 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -17,6 +17,98 @@ / {
 	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
 };
 
+&dpmac3 {
+	phy-handle = <&mdio1_phy5>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_0>;
+};
+
+&dpmac4 {
+	phy-handle = <&mdio1_phy6>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_1>;
+};
+
+&dpmac5 {
+	phy-handle = <&mdio1_phy7>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_2>;
+};
+
+&dpmac6 {
+	phy-handle = <&mdio1_phy8>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs3_3>;
+};
+
+&dpmac7 {
+	phy-handle = <&mdio1_phy1>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_0>;
+};
+
+&dpmac8 {
+	phy-handle = <&mdio1_phy2>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_1>;
+};
+
+&dpmac9 {
+	phy-handle = <&mdio1_phy3>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_2>;
+};
+
+&dpmac10 {
+	phy-handle = <&mdio1_phy4>;
+	phy-connection-type = "qsgmii";
+	managed = "in-band-status";
+	pcs-handle = <&pcs7_3>;
+};
+
+&emdio1 {
+	status = "okay";
+
+	mdio1_phy5: ethernet-phy@c {
+		reg = <0xc>;
+	};
+
+	mdio1_phy6: ethernet-phy@d {
+		reg = <0xd>;
+	};
+
+	mdio1_phy7: ethernet-phy@e {
+		reg = <0xe>;
+	};
+
+	mdio1_phy8: ethernet-phy@f {
+		reg = <0xf>;
+	};
+
+	mdio1_phy1: ethernet-phy@1c {
+		reg = <0x1c>;
+	};
+
+	mdio1_phy2: ethernet-phy@1d {
+		reg = <0x1d>;
+	};
+
+	mdio1_phy3: ethernet-phy@1e {
+		reg = <0x1e>;
+	};
+
+	mdio1_phy4: ethernet-phy@1f {
+		reg = <0x1f>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -87,6 +179,14 @@ &esdhc {
 	status = "okay";
 };
 
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio7 {
+	status = "okay";
+};
+
 &qspi {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 58b6a5aa8df2..4bcd4772164d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -690,6 +690,56 @@ emdio2: mdio@8b97000 {
 			status = "disabled";
 		};
 
+		pcs_mdio3: mdio@8c0f000 {
+			compatible = "fsl,fman-memac-mdio";
+			reg = <0x0 0x8c0f000 0x0 0x1000>;
+			little-endian;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			pcs3_0: ethernet-phy@0 {
+				reg = <0>;
+			};
+
+			pcs3_1: ethernet-phy@1 {
+				reg = <1>;
+			};
+
+			pcs3_2: ethernet-phy@2 {
+				reg = <2>;
+			};
+
+			pcs3_3: ethernet-phy@3 {
+				reg = <3>;
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
+			pcs7_0: ethernet-phy@0 {
+				reg = <0>;
+			};
+
+			pcs7_1: ethernet-phy@1 {
+				reg = <1>;
+			};
+
+			pcs7_2: ethernet-phy@2 {
+				reg = <2>;
+			};
+
+			pcs7_3: ethernet-phy@3 {
+				reg = <3>;
+			};
+		};
+
 		cluster1_core0_watchdog: wdt@c000000 {
 			compatible = "arm,sp805-wdt", "arm,primecell";
 			reg = <0x0 0xc000000 0x0 0x1000>;
@@ -767,52 +817,52 @@ dpmacs {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				dpmac1: dpmac@1 {
+				dpmac1: ethernet@1 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <1>;
 				};
 
-				dpmac2: dpmac@2 {
+				dpmac2: ethernet@2 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <2>;
 				};
 
-				dpmac3: dpmac@3 {
+				dpmac3: ethernet@3 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <3>;
 				};
 
-				dpmac4: dpmac@4 {
+				dpmac4: ethernet@4 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <4>;
 				};
 
-				dpmac5: dpmac@5 {
+				dpmac5: ethernet@5 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <5>;
 				};
 
-				dpmac6: dpmac@6 {
+				dpmac6: ethernet@6 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <6>;
 				};
 
-				dpmac7: dpmac@7 {
+				dpmac7: ethernet@7 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <7>;
 				};
 
-				dpmac8: dpmac@8 {
+				dpmac8: ethernet@8 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <8>;
 				};
 
-				dpmac9: dpmac@9 {
+				dpmac9: ethernet@9 {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <9>;
 				};
 
-				dpmac10: dpmac@a {
+				dpmac10: ethernet@a {
 					compatible = "fsl,qoriq-mc-dpmac";
 					reg = <0xa>;
 				};
-- 
2.28.0

