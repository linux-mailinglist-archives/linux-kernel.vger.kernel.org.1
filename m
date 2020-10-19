Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2C292D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgJSRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgJSRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:45:44 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404BC0613D0;
        Mon, 19 Oct 2020 10:45:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q25so666554ioh.4;
        Mon, 19 Oct 2020 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ne5Wbe/Wv6RezTzGvLCUYSaLkqqUma+8gMhHmnQkq4=;
        b=b8hwvShsesualaW80EBT7PLqjjvEokHnLHpFvWiVQ5rku3RooxyEthshBzvkzI/JjU
         TN/5g5VBCLflp+0YgfzY3rBs2Ti7PX8Tb1vDx5MHuithbF63RKJ81RjN7CCjAwlcX3xt
         1rOT2Vb8m4TXp+DRf2R+AnVGaIBYVsEWSeM1QK1Bpxvx10IzReD1OtBk+ZqqDZnufNrp
         efhRDhywr5rzUMqH8V2OfOkPKGZg6lalDu23N5y33NNCZhZbXQcpfrAQzxn7jdVPjtAa
         NTyO4GcaEZFgl0Wf0xOMi2UCdmtYiBrjkFcWalhow9w8MSXIWrhLfHE4/7kbwiuepCWm
         FaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ne5Wbe/Wv6RezTzGvLCUYSaLkqqUma+8gMhHmnQkq4=;
        b=YdyagZZ6mvTDgfag/KuAMdaqeuedBP24ICg14DvVRwP3rhN+JSI8lQogzzBz2HWz6z
         10fH4spb+ilQkQW32RJEFzXSEt7r6q03xLxMC3x6l2KLpHpw2wx80lrU/p+T0lozUUoz
         oc6+eFWVPXVODyickIqaZtulttsA+iOWpOOFBViRw+KYmCFp82Mf9r+VmPGl15QiNRop
         OUbJpt0Ba9FmYe6oKtSR5i+a+zs5foc9QGoUGt4EhXWKMda3hBDo7PhUl7aQG1WQSUnG
         NwO7BvQLR3+huOL8VmPkZIvlGWotVqdSJVaDpDOXxQRx/UboHIfdihfb2Yqk9gYK/8IY
         CEkA==
X-Gm-Message-State: AOAM530Oh8LnjexluZbzLJ1Vni4bJalM3qRUFTCScrVufXeYY2jNZqSw
        k5cpr7zyd6Jfl4vhe/P5L7A=
X-Google-Smtp-Source: ABdhPJzLgLISVItWgE7W/RCRGJmBU+BTJ1NRbXev9Vz5RSP6xpYE+JW64IrHk5aTnawd/RhHmGlqRA==
X-Received: by 2002:a02:380c:: with SMTP id b12mr970416jaa.9.1603129543146;
        Mon, 19 Oct 2020 10:45:43 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id 128sm406261iow.50.2020.10.19.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:45:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8mn: Add node for SPDIF
Date:   Mon, 19 Oct 2020 12:45:28 -0500
Message-Id: <20201019174529.289499-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019174529.289499-1-aford173@gmail.com>
References: <20201019174529.289499-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano can support SPDIF which is compatible to the
IP used on the i.MX35.

Add the node.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 3ab9486736ca..4b32c5aa355d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -334,6 +334,30 @@ micfil: micfil@30080000 {
 					status = "disabled";
 				};
 
+				spdif1: spdif@30090000 {
+					compatible = "fsl,imx35-spdif";
+					reg = <0x30090000 0x10000>;
+					interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_AUDIO_AHB>, /* core */
+						 <&clk IMX8MN_CLK_24M>, /* rxtx0 */
+						 <&clk IMX8MN_CLK_SPDIF1>, /* rxtx1 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx2 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx3 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx4 */
+						 <&clk IMX8MN_CLK_AUDIO_AHB>, /* rxtx5 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx6 */
+						 <&clk IMX8MN_CLK_DUMMY>, /* rxtx7 */
+						 <&clk IMX8MN_CLK_DUMMY>; /* spba */
+					clock-names = "core", "rxtx0",
+						      "rxtx1", "rxtx2",
+						      "rxtx3", "rxtx4",
+						      "rxtx5", "rxtx6",
+						      "rxtx7", "spba";
+					dmas = <&sdma2 28 18 0>, <&sdma2 29 18 0>;
+					dma-names = "rx", "tx";
+					status = "disabled";
+				};
+
 				sai7: sai@300b0000 {
 					compatible = "fsl,imx8mq-sai",
 						     "fsl,imx6sx-sai";
-- 
2.25.1

