Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1622A9517
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgKFLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:15:55 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB6FC0613CF;
        Fri,  6 Nov 2020 03:15:55 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p7so1061235ioo.6;
        Fri, 06 Nov 2020 03:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+MeC1RjPb3Mk2gII20C6IYolnVGBW/q2hIgPPdYmaM4=;
        b=ILa9QEuHn6VOxwc8dvrLyURks+VMTCLmAGuTXkgUAQaLSByzjCNuc0mW4wovWFC1kn
         HQbIb7Y9UKtRV/K0WUe/RZzq3ENqwVb9xNlEHx/Wt48UMgkajPcHEGJK5/pplIfbpBjj
         0gaL96segIkb1VzFAGC2v7zcfB0uVFqtQp55UIl1vt0K3L/888U4j6TcuujC65WFSHJg
         leuX/NCHEG8TyfpSBMsOdexJMWixOQ496HX+LzzygR7DN4mtlXJUjKS9vtWEbkE2SJcQ
         zwM6Ka51HG3hECnMPDIlx1nl6uXIa/b6iP5BgIXP4ECI+dJPHQLeQ/DuoLMO+mBUveyB
         z69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+MeC1RjPb3Mk2gII20C6IYolnVGBW/q2hIgPPdYmaM4=;
        b=c3EUUcVZswL/Yn82ksSMsQpfvgKMNdNuIvA2sUmOj0JhMUTOthfjl8F6ogd3qAOBIt
         706/Kxftwmk3xpY2KRkdV5a4bdBPAGNAprIt0MRWEcrLoGYA44SDFLZzO+f0O2Upo2cV
         gDhopy0GAPHpxlvldBIUZzUqHoe25ICI4B0GClWIkmnXpASbgIW0hroGV4+VpcTMwnEA
         LrwMwuA0fvvkIAlR3HtlrWu9pHXSPmkazaUCkDbjqH42QtJzJb8BVSeUmVK26/QFgw/o
         VT/pHV9ivXkO9CRzIhl7d/h2t1v3WWDNlhnmeH6deab9ncPHT8zF7AwI22882NIQ251x
         HILw==
X-Gm-Message-State: AOAM5307lM2xnYxAyNUcMt/e0kthG1VxkUGGiAVKQdwFsFfCLAtehQ1g
        +epVdGn6CZ8BV2TEp/eVHsY=
X-Google-Smtp-Source: ABdhPJwvJbUWYApaItTNY1XMK+uZ80vAMjNKA6QidEx+1tBKX4C+9aZzspwHdKOWqe9izwgDvSOFqQ==
X-Received: by 2002:a02:3b2c:: with SMTP id c44mr1091564jaa.134.1604661354509;
        Fri, 06 Nov 2020 03:15:54 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id x5sm854597ilc.15.2020.11.06.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:15:53 -0800 (PST)
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
Subject: [PATCH V3 2/5] arm64: dts: imx8mn: Enable Asynchronous Sample Rate Converter
Date:   Fri,  6 Nov 2020 05:15:40 -0600
Message-Id: <20201106111543.1806809-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver exists for the Enhanced Asynchronous Sample Rate Converter
(EASRC) Controller, but there isn't a device tree entry for it.

On the vendor kernel, they put this on a spba-bus for SDMA support.

Add the node for the spba-bus with the easrc node inside.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Change spba-bus@30000000 to spba: bus@30000000
V2:  Make the DT node more in-line with the dt binding and remove
     vendor customizations that are not applicable.

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a06d2a6268e6..61560c083300 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -253,6 +253,34 @@ aips1: bus@30000000 {
 			#size-cells = <1>;
 			ranges;
 
+			spba: bus@30000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x30000000 0x100000>;
+				ranges;
+
+				easrc: easrc@300c0000 {
+					compatible = "fsl,imx8mn-easrc";
+					reg = <0x300c0000 0x10000>;
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
+					firmware-name = "imx/easrc/easrc-imx8mn.bin";
+					fsl,asrc-rate  = <8000>;
+					fsl,asrc-format = <2>;
+					status = "disabled";
+				};
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mn-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.25.1

