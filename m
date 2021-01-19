Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D519E2FC5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbhATAWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbhASNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:43:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E6C061575;
        Tue, 19 Jan 2021 05:43:10 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q2so37934177iow.13;
        Tue, 19 Jan 2021 05:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHwfLm8TdnlPFCLjJ2Zkj+deJcFpN0CRDlVMvLD+EEM=;
        b=usIZ9/gE0dUW2y85w6sfpEQ8lQEjnrrtjNcovJTGysIKxbfXSOC1qQuqUPzdvhD358
         PDjl2z5W4H18mbjR80oDR6VU3Ad+Qy6qDtkWBlTRr0PgcNPh8C31HE6ns6HjiyPQEulr
         MApuLrlPMtJdgkPrl83hgbABjQ5/UPG4sR0f91Dfm6xzN6i41r0mNsw8znhtG3V7YpPW
         WVI+FCNMVF1ymG6x/TldRBDtrul9Pp+NN/wDf935uVzXHn3EVk83cJ4FPGuo6fkDjvnA
         T9tF5HHDgPN/uHNyll0kbpJsPEdbJZCE5I7E5wFGNpdTK6W9EZDc0UBkL/B9IQW62Ga0
         a0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHwfLm8TdnlPFCLjJ2Zkj+deJcFpN0CRDlVMvLD+EEM=;
        b=ZLhe3I94ECSHlrWRw55mklZ/Yv5GORy53PaLa0jZ8CaC9MdEiwr01BcvFsRpdgKTgq
         KCXanRTx6s5xGxElDbVQv4i1Dkl2aPHFjfMc4x0qbppva3LQzsJSx4w4/iZqDqDkDwIc
         c5oO0YuY753zTjn6IdHIWZ7IyQoaNjSqNFzUU5pyrGTbksD0CEw2XFTO74026xPT6Nyk
         vs472Q8dlmw9k14Tgb/FdAsbfBqWa7qkySDNnqw/CNT8CI8fd64UT99v5APk/pBEtsiF
         e0jXxzHgrFkadqTGaYf7mIuzjuKKxfbmgtwNqleFa6YlGAbnTbmJlhWu9p7b4SBqsAar
         528Q==
X-Gm-Message-State: AOAM532L0PK0c2X2ohsOybW0dz8RxVg85iLLzaFTx3OJWSGFswozzh5v
        Gy6/nFTOAHV+ygNhl6oe8xU=
X-Google-Smtp-Source: ABdhPJxNWHe3Qp/9hFDnbvYNkNESCl+1R3RhdmjhgWwKjeEV7ygVjSnzTw24grRAckbQUnjoG5lBgQ==
X-Received: by 2002:a05:6e02:128e:: with SMTP id y14mr3327571ilq.106.1611063789602;
        Tue, 19 Jan 2021 05:43:09 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2386:3a11:421c:65a9])
        by smtp.gmail.com with ESMTPSA id h14sm1795829ilh.63.2021.01.19.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 05:43:08 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: imx8mn-beacon-som: Enable QSPI on SOM
Date:   Tue, 19 Jan 2021 07:42:58 -0600
Message-Id: <20210119134258.774480-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119134258.774480-1-aford173@gmail.com>
References: <20210119134258.774480-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a QSPI chip connected to the FlexSPI bus.  Enable it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
index 2120e6485393..9f575184d899 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi
@@ -7,6 +7,7 @@ / {
 	aliases {
 		rtc0 = &rtc;
 		rtc1 = &snvs_rtc;
+		spi0 = &flexspi;
 	};
 
 	usdhc1_pwrseq: usdhc1_pwrseq {
@@ -89,6 +90,22 @@ ethphy0: ethernet-phy@0 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+
+	flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -318,6 +335,18 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
+			MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
+			MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
+			MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
+			MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
+			MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
+		>;
+	};
+
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x141
-- 
2.25.1

