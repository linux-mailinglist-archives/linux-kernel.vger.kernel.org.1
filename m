Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F592A0440
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgJ3Lgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ3Lg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECCCC0613D4;
        Fri, 30 Oct 2020 04:36:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o21so1101795ejb.3;
        Fri, 30 Oct 2020 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zic+vERvgU++BI9aftPear5ZN+1DH6pYoHRvpDRcTjY=;
        b=IhJNVVkG1bw6Ac1UOyYeDkxqs8cDf5E18o3ZWA4gts59W29d6+r37DjDSw/TBECcuO
         GEPDbRkh1BRWVxRoRFZ1Ms8MB40Siv2PwPS6hGEwA1kPAm6h3DObaXnmTETQx8cW8Ofp
         YrD3+LpDF0ilkBxbXF54NDegzUuP306fXasOFDSzdDA21U0oEVnPQIAXBMKXzbzq6uT0
         N3p1s96vWVZCX8wn+S4bzjP+O0EbFdb8voOFMLMfvtLLsgU1l+3ZPwfn1tle48HUZKBM
         HM5qkLEPLMtCJi+ieupSawW32kh/B+vZRas5HpQk9IiyDNXeFoy8AhTpD8PVe9m+NpZG
         wIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zic+vERvgU++BI9aftPear5ZN+1DH6pYoHRvpDRcTjY=;
        b=bBHiODbPYewwbK11m4iixrhdjuIvmOwF06/Jr8oUK20rCAtq8y6UNcoG1EtL2//jv0
         WqnVaJPl7NY3WrtV00Nwicrf0FGniW+Yvf6hlTbp8C6X0jteGWerqLVMbemDcat0OPXx
         V7Bw5bvgF948w5/sR+a2Gx3XrYx7hkSmxuNvAy4UTbsIo4UgFbnxcSwNuy/2cEjsANbi
         xlF4W1zQoD6oOeRBymgNie2O0iUVijGh3e0dWo1xPn9qG8HQ17mDKHNKHEe2cEGzcccB
         qxbz89odufEVXMQoK8bATL1LsiWEDEBgg1uQkL5JMQVzqy8aIgWGaBVtn8uTKGE1jx1T
         IAQA==
X-Gm-Message-State: AOAM533Zctc9zF6O+joORhfEpLbbpSP3Y7kt86NPMF4yWIiglnMdLtEM
        Y4Qe9/9FrS9Gbt/14hvG29gfU+8AOMXdDMWO
X-Google-Smtp-Source: ABdhPJwd+exYhsnhHENzto5577MNyRTDiLoOfRAtoYpxsSjm57AsASj35mnThc+JMwAKx2m2kk/RrA==
X-Received: by 2002:a17:906:9483:: with SMTP id t3mr2090293ejx.390.1604057785018;
        Fri, 30 Oct 2020 04:36:25 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:24 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 07/11] arm64: dts: ls2088ardb: add PHY nodes for the CS4340 PHYs
Date:   Fri, 30 Oct 2020 13:35:51 +0200
Message-Id: <20201030113555.726487-8-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Annotate the EMDIO1 node and describe the 4 10GBASER PHYs found on the
LS2088ARDB board. Also, add phy-handles for DPMACs 1-4 to their
associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - none
Changes in v4:
 - move the phy-connection-type attribute to the ethernet node
Changes in v5:
 - renamed all PHY nodes to ethernet-phy@X and their unit address to be
   the reg value


 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index f6b4d75a258b..a4b0dcab6e8e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -22,3 +22,47 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 };
+
+&dpmac1 {
+	phy-handle = <&mdio1_phy1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac2 {
+	phy-handle = <&mdio1_phy2>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac3 {
+	phy-handle = <&mdio1_phy3>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac4 {
+	phy-handle = <&mdio1_phy4>;
+	phy-connection-type = "10gbase-r";
+};
+
+&emdio1 {
+	status = "okay";
+
+	mdio1_phy1: ethernet-phy@10 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x10>;
+	};
+
+	mdio1_phy2: ethernet-phy@11 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x11>;
+	};
+
+	mdio1_phy3: ethernet-phy@12 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x12>;
+	};
+
+	mdio1_phy4: ethernet-phy@13 {
+		compatible = "ethernet-phy-id13e5.1002";
+		reg = <0x13>;
+	};
+};
-- 
2.28.0

