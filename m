Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACE2D223D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgLHErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgLHErp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:47:45 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4DC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:47:05 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so14765609oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da6PKTWsCyZHw4eyw0pntgWjnDdHSWAPm8s0stvFDrc=;
        b=zpioTPZoMCTaJaZo9r8XdicxPVP9Ax6XoHa/ab4tiwSh/tGNnWIxi5V2QzGk+lIN+W
         tCrYSz0h8GHsb3H98iKhudKLU9HlmlJ5tung6HEasNHC+JJfuLL1qb+387bVu2G215J8
         lZWz7EhC1m18Lm84BitA35AR4gRqMuhVHyutbuUV/ZOfXzcSemkT2CwAMOeB1VrU/0kI
         XoilliRHB2sq+Bu5fFWrE+qsnoizyC37uyPPsaJFN43A2YAzBBNEPyI5zRtrMsmtqJ34
         jwLP4BcVLGRBTGfYTivTpXptWUX0+eRnvtspNhfs4F0CY8lINuqMo2m/Y8h5h24mgmEs
         bFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da6PKTWsCyZHw4eyw0pntgWjnDdHSWAPm8s0stvFDrc=;
        b=FgAsr6LSwApoFtKimWL4HWUq4tBIIIEIi+xSvqEEJ5MuSB3sSvosVMhQeohjXwwPiw
         +hWVSEP+VHCbT7YkUd35Coq9UTZuDxly35QMiS9nxeCohPqGs3Awj2fhJNaziGsX4lpJ
         XY+q6UMWgv2fveRiokLb6rKHfFErBU6YK2+7uqLH+fGLmzBonPNjto9taswLB2tdO7LC
         qlZE9C4GRK43KW4QdhLDUOQoFZ1SQPujSQJlT9ODPKJ9Ytphj2gl26dNkVKw1zoCGYbl
         VvBaWEcDzDVwXXQuugRYZKkWBGLhm+vNo4LuioD7jatmnty/kkPJ9VY1oDSY43h6vJ9e
         52IQ==
X-Gm-Message-State: AOAM532vK1vBOgRrIaYz/15da/4+8AbXOaeP76rRlb68+Rwwrq8YANGB
        tZrVurpAhOSSjncr2FXo11tl9Q==
X-Google-Smtp-Source: ABdhPJygPDX8spy29K585WQ++C/zIl2uSDbkg9k+lngebC/ETdHvooZMPcPFBqaE4ubiHmUBfAmeGg==
X-Received: by 2002:a9d:634b:: with SMTP id y11mr8792599otk.70.1607402824715;
        Mon, 07 Dec 2020 20:47:04 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j204sm1151843oih.15.2020.12.07.20.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:47:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: c630: Add backlight controller
Date:   Mon,  7 Dec 2020 22:47:03 -0600
Message-Id: <20201208044703.973382-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga C630 uses the PWM controller in the TI SN65DSI86 bridge
chip to provide a signal for the backlight control and has TLMM GPIO 11
attached to some regulator that drives the backlight.

Unfortunately the regulator attached to this gpio is also powering the
camera, so turning off backlight result in the detachment of the camera
as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This depends on the implementation of the pwm_chip in the TI SN65DSI86 bridge
driver [1], but posting this for reference and testing of said patch. The patch
can further be improved by the inclusion of something like [2] and by adding
"backlight = <&backlight>; to the panel node, which will result in DPMS
operations turning the panel on and off.

[1] https://lore.kernel.org/linux-arm-msm/20201208044022.972872-1-bjorn.andersson@linaro.org/
[2] https://lore.kernel.org/lkml/20201208044446.973238-1-bjorn.andersson@linaro.org/

 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index bdd5d92ee6c3..851e5833cab5 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -64,6 +64,12 @@ sn65dsi86_refclk: sn65dsi86-refclk {
 
 		clock-frequency = <19200000>;
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&sn65dsi86 1000000>;
+		enable-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &adsp_pas {
@@ -385,6 +391,8 @@ sn65dsi86: bridge@2c {
 		clocks = <&sn65dsi86_refclk>;
 		clock-names = "refclk";
 
+		#pwm-cells = <1>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.29.2

