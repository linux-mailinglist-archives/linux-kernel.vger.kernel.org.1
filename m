Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D464B2A951C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKFLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbgKFLP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:15:59 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D7C0613CF;
        Fri,  6 Nov 2020 03:15:59 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s10so1080294ioe.1;
        Fri, 06 Nov 2020 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41N4iyrnh8OuPHFXWNvNlbvAqc/lcoCIqss0sAtNtRk=;
        b=btxg5UCBvPd4SGfvaJaBc5xU7ZIjue7YeXUkBXWOLe36VsruFkDQ4zQW8bBegsIrTm
         JbGwiWDImfpV7Qo0gTFXPk5EB2mfVuNk+qltmtVjVbWIawHJVlklo5QzxfP5WFrfkwYq
         VM00vpRM17KUAY49zyeNCQ4wiIsGMhvGUhEjVvF0gvQloOIxqFi3Nug9ezg/tIVN9UvM
         sR4izsMufNNVrUIlXqoSvKVDY8OtiLwREZ9n0m/7153GfThN2LT2kmjm6JdfgUL983j5
         pLcodCvQ5JjjJ9GN3ta5j+a6p1P9BTdPrVESGE5KnKubkqcQGGpYxDNMhPW0Yoz1743+
         +kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41N4iyrnh8OuPHFXWNvNlbvAqc/lcoCIqss0sAtNtRk=;
        b=V2A6lw+Nq7UjBnP1KGZ5Qc1xSg7c3gviIVqVK9OJtd18ul/0N5Bppfy2h/Ha/hgzVC
         yljm0zlO8IC3P3QbVEa27A3Ab4+XJZz0W8bAUWsge85qSqIvjLNTOJouRQJicqHqDgkk
         B03QmuJq1wkC+qdzBDsAJfBLMosE7L4uoWRV2oVHuCTOdO51/TogpBdEMumiR9GOMeR3
         BfPqerWLp5SY0sj7I3CJiJc8RRU67Xn2eXveupB3fUHFJgQwJvR6OLRLEbyD1IdMO/nC
         NFUpLl3E361ncsBg3/5j9QT72NHuuzCFqTfcjZmBWk2q4i/t4lG4f3YJJnIppRin7++k
         J/mg==
X-Gm-Message-State: AOAM5314T6jfWN8zplcJFvj/9CXZR6SgIDgMKfxH1sZojXo8vq+0z/gw
        XZ8tQbcHbIrLxLp2AmPpsN0=
X-Google-Smtp-Source: ABdhPJw0gMdKrPpOubLw6EbmCv/7DUzUStPwjlCJ4YJHsfZFpZJTTri5lYLSQsgWcH5RqifCcianrg==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr1033351ios.113.1604661359089;
        Fri, 06 Nov 2020 03:15:59 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id x5sm854597ilc.15.2020.11.06.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:15:58 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] arm64: dts: imx8mn: Add node for SPDIF
Date:   Fri,  6 Nov 2020 05:15:43 -0600
Message-Id: <20201106111543.1806809-5-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Nano can support SPDIF which is compatible to the
IP used on the i.MX35.

Add the node.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change
V2:  No Change

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index aa3f1eb391bd..ee1790230490 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -337,6 +337,30 @@ micfil: audio-controller@30080000 {
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
 					compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
 					reg = <0x300b0000 0x10000>;
-- 
2.25.1

