Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F772D41AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgLIMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgLIMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:04:09 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD191C06179C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:03:28 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id u19so1275795edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhTebHHB1yKIF7cssKlkVjUKOAUnXogHo6Up4bbqoQg=;
        b=0hyznWuWZqKpynL5fX4S7bsgyztK44TwnE8qPYF8Memni4zOyv2rFO2SNKtLh7V15T
         PcUw5jQKJ1/acoYMnFM8pwd9K6M0M7DjeoRp9beNN953P2wKibwzg/jPuljhmk+zUY4P
         RiP0w78x9veBsdW1Ppfz1Zg7hu3EDKZ83OYZvXBjVANwOVdcWpF5Uqwy/44qSx32wr1+
         2cXhJ2LnjHoRwq52o2FLe2TzbAkuhha+3EVhi1x8zg9S9i90k5oDoyc3BH3zlRiv67Bp
         wYy/kZfSRKYpGNbssaWSY1ch6WVVRhf7AcP5GvmcqhXtjZB4XVd2RP42roXYatZPdCr6
         +9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhTebHHB1yKIF7cssKlkVjUKOAUnXogHo6Up4bbqoQg=;
        b=qVAGyDQdQqBKVWxpaDTqij2e33lyr9D9WKiXesb/Kwc4LaONJtRuPyLpbZIBYHJrS4
         ky0XV1S3G6D5EU2BuZKaypH/AhAUwJGf4l8w0clZzTukRNCj49aSWFxBd5EUaIJtCYzM
         L5RgHcNpSVZrxT7mrBA7LFXddENbrK9atXi3ie2DabT4AHiUtApqhZ9BjucuxfRGqR45
         XSZkM/3ybzgv7USyM3kfqUpRdhzVrPBoD9UbeBbhiCg/p2pQQqFmTGWgqPlQCAGjm6f4
         i0lbw2anhybRGfrSzr0VhrFpZwyqNbGFwsXdDD++LS8FVB9j1nXbBG9yT8ogOVEXWrgg
         rELQ==
X-Gm-Message-State: AOAM530K774nEkO2jQd4SOZ6Buls+yTey3HqXW8lq26zslD/LKJ4QrSw
        nkkXQK7y4Njx5Or0HYNd/SwsWw==
X-Google-Smtp-Source: ABdhPJwRn7OBn73W+KHDERa+We/tGcp650qVwbLdX3kts9uoyWDBr0xqdxk8aNcWE436bWZmB40b0Q==
X-Received: by 2002:a50:9ee6:: with SMTP id a93mr1692284edf.174.1607515407524;
        Wed, 09 Dec 2020 04:03:27 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c23sm1426548eds.88.2020.12.09.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 04:03:26 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt8183-evb: add PWM support
Date:   Wed,  9 Dec 2020 13:03:21 +0100
Message-Id: <20201209120322.137610-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209120322.137610-1-fparent@baylibre.com>
References: <20201209120322.137610-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the pwm driver and set the pinctrl for PWM A line.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

V2:
	* rename pwm0 to pwm1 since disp-pwm has been merged in v5.11 as pwm0
	* rename the pio node and labels to match the coding standard of this dts

 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index cba2d8933e79..3249c959f76f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -344,6 +344,12 @@ pins_spi{
 			bias-disable;
 		};
 	};
+
+	pwm_pins_1: pwm1 {
+		pins_pwm {
+			pinmux = <PINMUX_GPIO90__FUNC_PWM_A>;
+		};
+	};
 };
 
 &spi0 {
@@ -392,3 +398,9 @@ &spi5 {
 &uart0 {
 	status = "okay";
 };
+
+&pwm1 {
+	status = "okay";
+	pinctrl-0 = <&pwm_pins_1>;
+	pinctrl-names = "default";
+};
-- 
2.29.2

