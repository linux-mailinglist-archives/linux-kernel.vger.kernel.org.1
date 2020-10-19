Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB04292D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgJSRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgJSRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:45:38 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D0C0613CE;
        Mon, 19 Oct 2020 10:45:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p9so1102992ilr.1;
        Mon, 19 Oct 2020 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YLSeb9LIhegRPaLNoV9Ze3m1VztSMd0a6bBC3I1IcQ=;
        b=Eg913XPs0tpOr3ySmlbzgpXgn6rKzd1rpv+CH9IdyLe/wXPr/hsxUt7AGOE9Yoruo+
         MweQAgCye1MS6wjVMmkOFlyEi62Ky61l1/mE5pIEK0kE/sY/zsZf9xIRHiQjI2QHmTqo
         mWYyQRcOqqweP9f4DhM+uoDFyT549ggOY/umVBCt2U//ZavEGt+erXoY/lkQ4ICiQP/G
         IFjw6U6s+A18U0Y9iM4vYJpkRcjdqnI/VcBe3aoon5X/JmBJoJy4nuRFVTgZRmFkH5dH
         rXE7k4y7+TmvJPoeHB6ujCAz/t2bayZweKvWFBJvSyAdnunaT/sXFjMJihmHUEwVDheo
         tvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YLSeb9LIhegRPaLNoV9Ze3m1VztSMd0a6bBC3I1IcQ=;
        b=axC8djLWcNwZ+0KeZBRW6+0LtV/E7gxMFwrthvY7Z8KMNRbHaNna/8/L2isF/n7K6c
         LHM76Ulpgg5IJbzIZTAKP5fHspZF/VuWVmPhaofHedG5SpV71AHW64JYogGg5LHwYEzM
         Cbj2X25tknq+i8qpDxBaO8857irVcP4tDq0PWQcHasPyEoI2gDeYwiHc9fYurFoe3buk
         g8t+QkYLYZFAhpJp04j8UElUoUzCnFyDYUwn1l6Y/5gENThXKDNTyIvM/df04MlcY2oB
         63GkUPyBmlLs6mbkVIx+RYKmD+jbKzoETbwGMyIk3gBbk5OtQpOGw1AmsWFRbHX3JpP2
         SGpA==
X-Gm-Message-State: AOAM530qQA/o+MikrR+Xh5co//q6/zgdaCR/9le6o8YgwOxGs6sspfBR
        JbmtdbP64R7Ojvp4C6ODFCw=
X-Google-Smtp-Source: ABdhPJzg+/LI1dDRTFCvPm7q/35ln29PKS2MSxMdkrA6Wt+d2vT21WbpJXsbOhx7mbS1QxgyS41ayw==
X-Received: by 2002:a92:aad5:: with SMTP id p82mr966020ill.150.1603129537042;
        Mon, 19 Oct 2020 10:45:37 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:75c9:416d:1d67:486f])
        by smtp.gmail.com with ESMTPSA id 128sm406261iow.50.2020.10.19.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:45:36 -0700 (PDT)
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
Subject: [PATCH 1/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
Date:   Mon, 19 Oct 2020 12:45:24 -0500
Message-Id: <20201019174529.289499-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exists for the Enhanced Asynchronous Sample Rate Converter
(EASRC) Controller, but there isn't a device tree entry for it.

On the vendor kernel, they put this on a spba-bus for SDMA support.

Add the the node for the spba-bus with the easrc node inside.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 746faf1cf2fb..7d34281332e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -246,6 +246,34 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
+			spba-bus@30000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30000000 0x100000>;
+				ranges;
+
+				easrc: easrc@300C0000 {
+					compatible = "fsl,imx8mn-easrc";
+					reg = <0x300C0000 0x10000>;
+					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
+					clock-names = "mem";
+					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+					dma-names = "ctx0_rx", "ctx0_tx",
+						    "ctx1_rx", "ctx1_tx",
+						    "ctx2_rx", "ctx2_tx",
+						    "ctx3_rx", "ctx3_tx";
+					fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
+					fsl,asrc-rate  = <8000>;
+					fsl,asrc-width = <16>;
+					status = "disabled";
+				};
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

