Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E22E743E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgL2VTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgL2VS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A612C0617A1;
        Tue, 29 Dec 2020 13:17:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lt17so19708562ejb.3;
        Tue, 29 Dec 2020 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMxWkLKitF1ddzOqysA0FSsJ2oThPb7qmzfv1DV4+KQ=;
        b=bAWiV5Xg8M1ceYHtl47FlMV97SxbcSu9WXlND7MydTmBUsZXKJdwWu3MW5/T6pt/GI
         3qDGexqWCcTDYXnmzBEtj4gfBF8Ji0Hy8lAI0pb1/QqMAgQoj7t3Ued4pPJb65SG3giL
         vdUv/B6h3PSupyTWvU9KrHvWhgyNaYaR3fMTyuHAi0JFXdlaxY//RoOSXmX5UQZU9ZnW
         v9VxNefG2D3u971w3kHiRjlKOAA+NrErXYc3hPBdBOJyRB5J2402q5WtYUisSGpwgejC
         fy2u2GPWSVrbK9eMQdzge4qNLr9aq8kiYWD1mxPsnx1XmvKfiKggpVNrInRLYyp/9Ykn
         SGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMxWkLKitF1ddzOqysA0FSsJ2oThPb7qmzfv1DV4+KQ=;
        b=tCFkNKG+RdCPjoCmVkshltf8eQP3tkZkRz7bywkRZfpwQ/VnqKqiQ41jDZ9fJu44BB
         nZwviv+esr/E1gOO+TpfdCJnAkOBILBL9bDuWTIxBpkir7dzArEHxlJ84SaPFwtmB6sP
         +9zbSAd6+wq/SbqVcxL2KD8j6deQMfEUl8d9WiNb0vtdGDpTmzam6VqeT6YU4cVgIIWV
         wqrJpVgAA6bxCIEgmWFLU0auMa8Un5GGl+Rl/P+2u1BCROTebgb8qdrCjmLch20VdSFB
         pAOZkeiZz+2pTnG35peBc7Tt9PzS8DMsVtEsq9+nejtu3GEe/dXkxeHsP6Ht3dKfWiAH
         iTKg==
X-Gm-Message-State: AOAM531pXT1r7GhjTfTEG3n9+6doi/QBFQkY4yf52CZslzzzvkO+GZSd
        4Y3qa1kZoBNTN9SUjWTUWrNHbLNnC3reBw==
X-Google-Smtp-Source: ABdhPJzUvGzTXiqcWDnbl0qSUnmqmXSM64ohK1mSzL6lTfZpMAO2JnCh2IScZGII4qt1y6g/6RYJng==
X-Received: by 2002:a17:907:6e9:: with SMTP id yh9mr46837515ejb.131.1609276668849;
        Tue, 29 Dec 2020 13:17:48 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:48 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] arm: dts: owl-s500-roseapplepi: Add I2C pinctrl configuration
Date:   Tue, 29 Dec 2020 23:17:27 +0200
Message-Id: <99b1f6772064a6fafdc0fd857bc22ff9976241eb.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definitions for the I2C controllers used in RoseapplePi SBC.
For the moment enable only I2C0, which is used by the ATC2603C PMIC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index fe9ae3619422..ff91561ca99c 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -37,7 +37,51 @@ sd_vcc: sd-vcc {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c1 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
 &pinctrl {
+	i2c0_pins: i2c0-pins {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+
 	mmc0_pins: mmc0-pins {
 		pinmux {
 			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
-- 
2.30.0

