Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEE2A046A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgJ3LiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgJ3Lg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:36:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B8C0613D2;
        Fri, 30 Oct 2020 04:36:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so6308013eds.3;
        Fri, 30 Oct 2020 04:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IsCYl6UQdkKRmbP2GSIWYxCTpfXBp9DqgOTfgZL/UI=;
        b=D/KqvqtFBpQvSf8yqm4+Jzcu4wb8/sV168HE8HOSc6u6HolXrHASr3W10RpwaT9lJg
         zMYoO+ZtrIBH6XH2qJJe/LdU+mixvo4IyKUYiiSgmFTiJ5TpHwZI6wt+96xzE4+rNLnH
         LCfNF6K6gaNdRDDmx7UyfCpsfqphBBw+IwiK/bidCOgGD0BwgChBkLB6i6fRwPJsHfvN
         qrqEVqK8u9uLQfHoBJNK9lp8Cs37R1AT/MSjeqwZ3tTha6Q4KD054N2ni1kSmJfNTwmW
         mjQYNgqZ0YkgRIvD3oxIGOn1PaSp8hhSuKXaW+ryniRqPymIJY7WxIKsXHX85+uPFMB5
         eNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IsCYl6UQdkKRmbP2GSIWYxCTpfXBp9DqgOTfgZL/UI=;
        b=pI8hywijhSEV6NEDnFxDUtEbkyoJ/JEx7q8yVH4Zv6TfrqqQwyQXnM1Hg8nkV9xJb8
         QMBqrwVuYVIF+0SygnGcEkgqXBXGivXLTBD1gNZP7xOlC4G+nNIXIhrvmhqSx2J4IlBC
         VZzcvoK5pUoU4/VkHR0CCpjWFtvStnRCXfX4wIBxZvRp2CcdmHcoopd3mlXl6e1vducm
         iiD4CjAGM9JkA0/tdW0x6XAN+gjXfDFFnLjEZf0/znUEXCKzhzSd668wwah3u0d8DmlE
         IyibgyV7fOemHKxe9vO7OhFH/VOSxXPjX8jVH+bGUuZ7vQ42ZdBYMZrPCmMuD3RcTpli
         Iptw==
X-Gm-Message-State: AOAM5323AbHFo+vl35KEKIrBf1d3uHocRa9m9Nxql6AFPCzx4v185COm
        dQgQ7w3NJ7ojEDOa2MTHSgE=
X-Google-Smtp-Source: ABdhPJxLtXP/DZo696TWtmNGx3c0ih0pofXauNNF5+rKYvkQKPrQkMti5uV4cK8NzA/zPmtJxwaPvw==
X-Received: by 2002:a50:9f03:: with SMTP id b3mr1712075edf.268.1604057786334;
        Fri, 30 Oct 2020 04:36:26 -0700 (PDT)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id q19sm2850861ejx.118.2020.10.30.04.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:36:25 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 08/11] arm64: dts: ls2088ardb: add PHY nodes for the AQR405 PHYs
Date:   Fri, 30 Oct 2020 13:35:52 +0200
Message-Id: <20201030113555.726487-9-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030113555.726487-1-ciorneiioana@gmail.com>
References: <20201030113555.726487-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Annotate the EMDIO2 node and describe the other 4 10GBASER PHYs found on
the LS2088ARDB board. Also, add phy-handles for DPMACs 5-8 to their
associated PHY.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none
Changes in v3:
 - none
Changes in v4:
 - move the phy-connection-type attribute to the ethernet node
 - remove the interrupt description
Changes in v5:
 - renamed all PHY nodes to ethernet-phy

 .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
index a4b0dcab6e8e..854f604049ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
@@ -43,6 +43,26 @@ &dpmac4 {
 	phy-connection-type = "10gbase-r";
 };
 
+&dpmac5 {
+	phy-handle = <&mdio2_phy1>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac6 {
+	phy-handle = <&mdio2_phy2>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac7 {
+	phy-handle = <&mdio2_phy3>;
+	phy-connection-type = "10gbase-r";
+};
+
+&dpmac8 {
+	phy-handle = <&mdio2_phy4>;
+	phy-connection-type = "10gbase-r";
+};
+
 &emdio1 {
 	status = "okay";
 
@@ -66,3 +86,27 @@ mdio1_phy4: ethernet-phy@13 {
 		reg = <0x13>;
 	};
 };
+
+&emdio2 {
+	status = "okay";
+
+	mdio2_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x0>;
+	};
+
+	mdio2_phy2: ethernet-phy@1 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x1>;
+	};
+
+	mdio2_phy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x2>;
+	};
+
+	mdio2_phy4: ethernet-phy@3 {
+		compatible = "ethernet-phy-id03a1.b4b0", "ethernet-phy-ieee802.3-c45";
+		reg = <0x3>;
+	};
+};
-- 
2.28.0

