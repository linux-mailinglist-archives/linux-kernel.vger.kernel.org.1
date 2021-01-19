Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2758D2FBBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbhASP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391198AbhASPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:53:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872CEC061757;
        Tue, 19 Jan 2021 07:52:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so29755523lff.9;
        Tue, 19 Jan 2021 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ttJy1sbqgGN8LlqZHeVaLyiNVqgMKw+PzRs47gIEZM=;
        b=jwt+XJ2m2JVvGLpNNzqCpOQtY+LD7flaonocDr/9T9K1hJIAsp9o64rEPe3dQz53gn
         IgQfNMeIMtQ8MH1bHbv2e+wMtxYRsoQix+/zm9vDMZcSRtaBH/b756/Xz27+djcH+Y13
         YpOCLS+FdAhOmUg9lD7zSJWFz1xXvaUYWcK9y0PFyaS3SkwQfnmWGx6PkKMWTEfUZziR
         SWCbYryxhbYngqcywTug9qsEQQp+dxJIBpN1Hu3JwL4HKSf2GZ9EvM8tIVOsaGMJchIO
         C5KPTXBTeDG7OqH3LVxYTblhQY43PrmYnVYh4dnWW8YK/VAG9g2LWfg8eHzWyriOO0Oi
         ZWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ttJy1sbqgGN8LlqZHeVaLyiNVqgMKw+PzRs47gIEZM=;
        b=EU5q4k4JXYnkS6znJa4gJwz0memNCyrwKEmFute57IEYTTpHe1iygXk+/fGTKdzIFy
         30qqF6VnQdfpJ3DV16swPC3x7HSrqeOUk9oeG12EJd251Vl8Rpe3LokFgnS5bPtzHVZ0
         Xx+hrdstFdF7mWwO2jkwYjAZG8Kbrqu904tWXnMpb71zGJOs96yV4/O00X+Qvac8Q9Ue
         VdOAQXupkIQFQCr0TZPfIzRIhDvcuclAtgqOgczKjoyrKKaO2e7XtQYyy1Pp82VA01M/
         VJk1tEkIVfX4o8GzPIasHYRpNzZ9KbKWnKGnKnUDBwn/ifMB8dcYA8QsanGLaniK1xtt
         LHIA==
X-Gm-Message-State: AOAM533epUdIWfZl5SS0R4poPkgGixMWG+UD7i8aJ/VOp43JexomZDmY
        jpjseliU0xwMXWPcN5NZHEEX5GWAISDc4g==
X-Google-Smtp-Source: ABdhPJyBPJJ70QrkQnJMC/3VXdTqzGRprlpWOXXRLJcsX0AsXieN2y63cQM7BoI75q7ca2FCWdOUyQ==
X-Received: by 2002:a05:6512:94f:: with SMTP id u15mr1971415lft.389.1611071546013;
        Tue, 19 Jan 2021 07:52:26 -0800 (PST)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id t196sm2309286lff.195.2021.01.19.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:52:24 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: fsl-ls1012a-rdb: add i2c devices
Date:   Tue, 19 Jan 2021 16:51:05 +0100
Message-Id: <20210119155106.1833610-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1012A-RDB equipped in some i2c devices:
  - 3x GPIO Expander: PCAL9555A (NXP)
  - Gyro: FXAS21002 (NXP)
  - Accelerometer: FXOS8700 (NXP)
  - Current & Power Monitor: INA220 (TI)

This patch add listed devices to dts.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
Changes in v2:
- resend only

 .../boot/dts/freescale/fsl-ls1012a-rdb.dts    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
index d45c17620b98..12117a973eb6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "fsl-ls1012a.dtsi"
 
 / {
@@ -33,6 +34,50 @@ &esdhc1 {
 
 &i2c0 {
 	status = "okay";
+
+	accelerometer@1e {
+		compatible = "nxp,fxos8700";
+		reg = <0x1e>;
+		interrupt-parent = <&gpio26>;
+		interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "INT1";
+	};
+
+	gyroscope@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pcal9555a";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@25 {
+		compatible = "nxp,pcal9555a";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio26: gpio@26 {
+		compatible = "nxp,pcal9555a";
+		reg = <0x26>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	current-sensor@40 {
+		compatible = "ti,ina220";
+		reg = <0x40>;
+		shunt-resistor = <2000>;
+	};
 };
 
 &qspi {
-- 
2.25.1

