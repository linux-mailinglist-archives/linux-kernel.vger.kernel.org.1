Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46322F7676
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbhAOKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbhAOKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:17:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B7C061757;
        Fri, 15 Jan 2021 02:16:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n8so989326ljg.3;
        Fri, 15 Jan 2021 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXuInPt5XugZp+FubZRX8WPAHVc2hVpGy3We37oEAS0=;
        b=Az69gZ4nMi/Dq/AsNp/woo1FI7lbYOAgmMI0VSoWdFu1OH1jEd5oYjv4MolhYoBLbv
         aIJT63ySekLiffbg56NZRMR4B5knuLF1BH9VUSdDgXKFRT3narxSIPNNruOVHFqtqiyv
         TDBmFkuaA55ZwvhE/q7UEBZBpDUFoTA5LZthnlGMtAVoHicMARad8IvotL7siLWeQJOV
         Uq/kxS++BvuDO4jSoz7dkWz4KnqpHMViNNcmffu8EcXnr0wAkN/+2fnmBBhdkMZlK7xo
         5BVFu+Jxlqz0/HJwDxk3bMcJQ6kshspTUGy17m90n0HS88p2d5KhnBvEe+gOPM14MBkK
         0xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXuInPt5XugZp+FubZRX8WPAHVc2hVpGy3We37oEAS0=;
        b=VbFpOVrCcddyI79jsIFvHoA4a2w5SJcWHlIobUycPBq/pZLvIIzNCbbwNcoLPGOK18
         Xr3qO5XET98tNGpi/S5tgKyTQNg3D60HI8ZhCFkOHvbjVwBATgFfzMX4Iymy01fiOOXi
         vcAjPwA0p9WSBgK8r7oUGzepUoS91J59wOGLJJbsfPHINOdIPDt6P0xoxy4LJoU6zTgL
         rb8+/rRJftPFNBLp1cOMpxBoyFirZAjmifPcSQRpO+YytLHhlXImNkIzkqYQXqD4oGUg
         Uv8uBCD8/iKPgI3XSJI9TDFu/zjb47mK15NlTVLjiZgAaexTSGsdPUEZiliIYh6jEuc3
         jPMQ==
X-Gm-Message-State: AOAM531l4bhNao3rbTf1UXY6lVItt/gnYeyG1QAm/NTmUns6AjjGpuG0
        7GrJG5lAVNzfWrqYdLkcjNsTf91bwxJ+xQ==
X-Google-Smtp-Source: ABdhPJxhuyosdrez0tbHJ9NG+xNNVIsAbFxuJ+0CnE2EHVHGw5LwuJKo16Qj9JGczgu4kzBiroxWyA==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr5067140ljh.349.1610705816148;
        Fri, 15 Jan 2021 02:16:56 -0800 (PST)
Received: from endpoint.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id g26sm758033ljn.90.2021.01.15.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 02:16:55 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: fsl-ls1012a-rdb: add i2c devices
Date:   Fri, 15 Jan 2021 11:16:12 +0100
Message-Id: <20210115101613.1490837-1-paweldembicki@gmail.com>
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

