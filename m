Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C82A046D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJ3LiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgJ3LgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:23 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A0C0613D2;
        Fri, 30 Oct 2020 04:36:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g25so5448791edm.6;
        Fri, 30 Oct 2020 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5/Bupwr/CiJpfQKLZ6TlW8afvJ5bgR9UF/O9obXUqU=;
        b=hNdtbQYdWYFmtR1T/i6ZZiMZS3xnzIuWHdk9dwWOnCyDt2moI6cUREuw8FIoDXeaV7
         s15KldLkeeowjXtCRLZzk+Ku17aAiy2o4snPy7Uhq2j6J8Y9NEx11soPdMlcQpDbGnVl
         5cKuRq83zdHDUeMbl+LvLnFvzFtrLfN3N/t1U8zTF1irAJawD1QQf/4fbWy0W4maeDmh
         iZOY+hlAcQ1WrkdxqXZQ7al/tIwemqonda3C+R5pd2f70ZF5DvhuhndiC9qhdVVraCCo
         vEPW27R8A8k+iTS0qBLohnYbHiXjM6NBm57zVLVRxqpNpwfOy3hVGQ6WrweTiINx7BHG
         OEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5/Bupwr/CiJpfQKLZ6TlW8afvJ5bgR9UF/O9obXUqU=;
        b=DhtUrT049yjGAmkq8eo9AgEvhoBu9pekbtJIFNI7H4htG+8xd1HNQIYU2BeZQAsFji
         R++Bg6PPW4M3oLPnF0eGnc3G3wbkDB7sZAlBsitWRP7+8hdeqUJsZgS2vDsAvlE/8gZ4
         cmQMGt86OawRQ1/dO5CPRW2q4nVwKh183FOqDHq2MHxjKEULaUN9dYDRChEhblDDM9CT
         Xi3oQgUtuUWnbaPeN7wd3IgQ/KQfu0v2Z3Jo9e5dEgctHcRtUM2po4qKLUStd+EyCMUs
         sHEu2kO8/hto31t42UO/ofkjCFqXrQ6ITJ6oqfXlAaiAzhx9xfb7fCR2lXmu8ZUfCbzp
         Ng5A==
X-Gm-Message-State: AOAM530jovhpuTzyLFJS7nzl2TlQx6Hr2r5IRQPWpEcjg/4V5+cGbgMb
        LoTo+2KyTo4tOiycj3NK/Qk=
X-Google-Smtp-Source: ABdhPJwfBWXqLdWQfHhZlgrV56NrLNNsxE8rJIU2p5PqpfGVpMcPEg9Mgov1KeDa/zR2D4e2AMew/Q==
X-Received: by 2002:a50:e442:: with SMTP id e2mr1899232edm.186.1604057782299;
        Fri, 30 Oct 2020 04:36:22 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:21 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 05/11] arm64: dts: ls1088ardb: add necessary DTS nodes for DPMAC2
Date:   Fri, 30 Oct 2020 13:35:49 +0200
Message-Id: <20201030113555.726487-6-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Annotate the external MDIO2 node and describe the 10GBASER PHY found on
the LS1088ARDB board and add a phy-handle for DPMAC2 to link it.
Also, add the internal PCS MDIO node for the internal MDIO buses found
on the LS1088A SoC along with its internal PCS PHY and link the
corresponding DPMAC to the PCS through the pcs-handle.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - none
Changes in v4:
 - none
Changes in v5:
  - renamed all PHY nodes to ethernet-phy@X where the unit address is the
   reg value

 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 19 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index e28443ba2633..528ec72d0b83 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -17,6 +17,12 @@ / {
 	compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
 };
 
+&dpmac2 {
+	phy-handle = <&mdio2_aquantia_phy>;
+	phy-connection-type = "10gbase-r";
+	pcs-handle = <&pcs2>;
+};
+
 &dpmac3 {
 	phy-handle = <&mdio1_phy5>;
 	phy-connection-type = "qsgmii";
@@ -109,6 +115,15 @@ mdio1_phy4: ethernet-phy@1f {
 	};
 };
 
+&emdio2 {
+	status = "okay";
+
+	mdio2_aquantia_phy: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0x0>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -179,6 +194,10 @@ &esdhc {
 	status = "okay";
 };
 
+&pcs_mdio2 {
+	status = "okay";
+};
+
 &pcs_mdio3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 4bcd4772164d..b7d60ac42669 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -690,6 +690,19 @@ emdio2: mdio@8b97000 {
 			status = "disabled";
 		};
 
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
 		pcs_mdio3: mdio@8c0f000 {
 			compatible = "fsl,fman-memac-mdio";
 			reg = <0x0 0x8c0f000 0x0 0x1000>;
-- 
2.28.0

