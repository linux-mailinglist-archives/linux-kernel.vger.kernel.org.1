Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCE2B9EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKSX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgKSX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:41 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B176C0613CF;
        Thu, 19 Nov 2020 15:56:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id s25so10412503ejy.6;
        Thu, 19 Nov 2020 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hh8AuY6GhZ7MSjZ0/WZz9y9iLRpsV9pantizbIoCu6Y=;
        b=uHkioLl9wYAtGlhipxQLQ8JT9fqtQyhwqbBdnhxb1ivcwNzifbUU+kpFL34TkNHdP4
         XBD3Mz8P3QJwyDwLqSsZ038sHEKaQ8GoP8OhsQFxcTPT+LHb5WDszcl7efKYcczhT1Vb
         gpLLmtP5OZS2SF0I0tGX0zF1nPOb4iIXVfe/3sxF9dssfzaasbHmA0890XSTmbKlR8O6
         VzXOZvWHIfIqsXDfJ6f9pvWKURjvLL9687MqaoQZOzeXZHg0DJBSHtLoO1hubsmZ0XhP
         Y/Yef9jwtQ8LcHfJ+1XTvpOWQjXDNQSJgPEKeRcKkRSpS1ZcBnRkizccSwGonqlhFCFT
         1wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hh8AuY6GhZ7MSjZ0/WZz9y9iLRpsV9pantizbIoCu6Y=;
        b=YUurhrxzsyx5HjI6yug+Bo/4uWlVKbE+0GaZJ5KEUBaMbyUhCW3m0Ha/GxBmkYaz2k
         ndK56FAenqDBIj7wG1TrYOqDH3+2T++/VEZuiQbOrQypnn4urG2gIydLAzfaK5tLJAVi
         G7jSzrwkyk35wx0fBbQgTxkjWeF9DvLxACAP7dKsg6FC4N3F0kWoSLN5v9DxfY4N8wde
         FnH0g5lRs7dEHcRrfrcdmBues0rhFCCtcBl87e8/mhzXld+HfrhVHcMZ8AfH50+EX2nI
         krxks2b82ocg/a3t74mrQRwn6k5PP5I5jf214yHkDpNhled0Bz27rzib4TeYQBctDjVL
         KrTA==
X-Gm-Message-State: AOAM533PuhKvLwW12/5RADkyjlYPShLc1XN/Jt2RkcYTZ6eU6gBRZDDx
        M5xw2AULkACTVa47l+D2YPPyQdnlfvs9Ig==
X-Google-Smtp-Source: ABdhPJxneB7KHkh/W/lgrnmqVJwezs5c7cMBHixAsnUc+WJCXgfpM428xSJvtbgSg8VZoIxY2W+NaA==
X-Received: by 2002:a17:906:86c7:: with SMTP id j7mr30301124ejy.301.1605830198736;
        Thu, 19 Nov 2020 15:56:38 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:38 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/18] arm: dts: owl-s500-roseapplepi: Add I2C pinctrl configuration
Date:   Fri, 20 Nov 2020 01:56:11 +0200
Message-Id: <f41e33b12d77e75246fa94ed6acc57fffe84aaa4.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definitions for the I2C controllers used in RoseapplePi SBC.
For the moment enable only I2C0, which is used by the ATC2603C PMIC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.29.2

