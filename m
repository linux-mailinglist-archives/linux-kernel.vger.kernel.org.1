Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB32A0445
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJ3Lgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgJ3Lgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE6C0613D2;
        Fri, 30 Oct 2020 04:36:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id p93so6259943edd.7;
        Fri, 30 Oct 2020 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxQE3as5qmdywGCryWlJxFvuu0GYbuByAf+xTUWNAXQ=;
        b=ZBPfc8KueINthUvsgeH+gUXzjzVe4NvMEM9x8mlWF3G5v8nNNA4h09KDyzPsGLJpkt
         J5AiFyqhCW8Sowo3ErZyOE5SfM0nvaRVtkB7OvwNunhz3I3cdywX3lXQ6NP2Uyl0vI5g
         QhZnPc2N3k4+TKQTTLSFX9OgDCj1ZS6d1r2wRKeosD6ptsV7Xr32QrA9h7o5CBrN2kQ3
         uA/B715QaNyGqbIjRIq/J03P3XKg5OiOesl4nLP5TvUXH3BzD9QUx0VnqgI2Z2uoltJL
         W4YAXaHCyYscmS1i4hz3wzDZ/w+/qPGNxNhgsVbxgJDeCVBCWh1sGo/tklgiPc8qUQSU
         e7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxQE3as5qmdywGCryWlJxFvuu0GYbuByAf+xTUWNAXQ=;
        b=gM8J1YD02j+7eXENhyoVrRJGSvMdckJ9MtYE45I9QKjTKgDjjgm55EEMBgJXboJ8z5
         gOoq/Oh5M7Bc8seJAtXFDACbPJuGJvuDgtRuw8abGLAyRbwI602HHEHYhC+aI93AX7J1
         etLavc+/yArgKWV4Q5HIcJDlXItB7E6BVMKLVkClPasOPz/nlJNue8rn9bHqzMJqioGO
         zezdetJ/GUGp+8Erbk1DXDreWUCZtGAUABcK3q1v9lSdcSqSNvHpOnCZHxV10T8FVhKJ
         2z6GzfoXLPjOzpK4Z6mUFPS4+ImjygcIQkEJSLWgr/5PGas/Zqm0QEN48z5ECU8Axdk7
         +MjQ==
X-Gm-Message-State: AOAM533LEG/INMVKlndXDOh7+C8i1IdpeG80e13fjorvq8v0C+cD7cQE
        WOPY0WZ7SW/uAnH+jMAz764=
X-Google-Smtp-Source: ABdhPJxFEUmnJbF7ddeya1V030+teKQyup2L2MRyuq0Sjnda7xD8Ms9KucAcworSdN15PM2k0RiaWQ==
X-Received: by 2002:a05:6402:395:: with SMTP id o21mr1807804edv.2.1604057790490;
        Fri, 30 Oct 2020 04:36:30 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:29 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 11/11] arm64: dts: lx2160ardb: add nodes for the AQR107 PHYs
Date:   Fri, 30 Oct 2020 13:35:55 +0200
Message-Id: <20201030113555.726487-12-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Annotate the EMDIO1 node and describe the 2 AQR107 PHYs found on the
LX2160ARDB board. Also, add the necessary phy-handles for DPMACs 3 and 4
to their associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 54fe8cd3a711..7723ad5efd37 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -35,6 +35,18 @@ &crypto {
 	status = "okay";
 };
 
+&dpmac3 {
+	phy-handle = <&aquantia_phy1>;
+	phy-connection-type = "usxgmii";
+	managed = "in-band-status";
+};
+
+&dpmac4 {
+	phy-handle = <&aquantia_phy2>;
+	phy-connection-type = "usxgmii";
+	managed = "in-band-status";
+};
+
 &dpmac17 {
 	phy-handle = <&rgmii_phy1>;
 	phy-connection-type = "rgmii-id";
@@ -61,6 +73,18 @@ rgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
 		eee-broken-1000t;
 	};
+
+	aquantia_phy1: ethernet-phy@4 {
+		/* AQR107 PHY */
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0x4>;
+	};
+
+	aquantia_phy2: ethernet-phy@5 {
+		/* AQR107 PHY */
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <0x5>;
+	};
 };
 
 &esdhc0 {
@@ -156,6 +180,14 @@ rtc@51 {
 	};
 };
 
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
2.28.0

