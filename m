Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34242EB6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhAFAKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbhAFAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:10:20 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF28C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 16:09:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 11so1458317oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 16:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sebCEl9B+1vF2yNLdSc5aas6+RNJIDePFeyjVwhIkc=;
        b=FXIQ4wyktkC89NxE5TyQnE6QAiy/+IznOsvGMq2EEpJg3rz7T6syIUHsrR0qhPJ2WW
         fxlzyLUXK5h/Q3hOaVQa3Jx2Do/i+8k1ww0kXaMrzc/R70Ofl+q8VtYl60W4PG68rwYv
         +fiWbKYCBjO2E+RtOLxUU346aOdE6FmC7s/8Q15pJ/gpK6f3Vbx7Biuc9j4dxpYn1a/G
         km0Awe+tAxECPEqs9MmCP7IRb34TuCt8+HnOaOLA+8DQDc0i8A7jcDB08txdN+o2ZLP4
         JEUh/OF7iCxZhLiJCw4yQB+f1D5SyI+xp9+FYdzhq7kluPvQtSi8/iRHRBsjx3+XulAN
         EV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0sebCEl9B+1vF2yNLdSc5aas6+RNJIDePFeyjVwhIkc=;
        b=uYz9/Hd1d9EkahKwqxdchT6jnAKPs6Yya4Sdg5ZbMv6KadJJXtOIzxt2Bfk93OjKdy
         dRcnkErwZ+aDDEdDxclsWwvNJMzu++e+T5LaunMldUn91MtcDOAuMksths0Qok7wiNnQ
         Z1k5TW7h1R2CQeiZxHVBK4qiR8hm/ARNxSAqDaB1q4uUs2MuS0wN6A6ve2k05WJ9PbIR
         XIJCbUIPlEkhFcabYM9qLVyb/dEkaZT761Mwid+3xuGg7Vtu7rcScCLVCBRmXWdYHAL7
         fq0yLuAvLdWR9boHqms6HIT8x7KneGpPOCREkCpu2l+CuwkYuMRSRwAe58b8cUcADNZq
         zCNg==
X-Gm-Message-State: AOAM533DUAechX8/g9ZQ+ZcAbP7G91URyiOcIpTE3G52GafFCPEaG6mZ
        kyPcaoaNWCDUZNWlmfJXThSp3A==
X-Google-Smtp-Source: ABdhPJwRt4+uVYYhD+y4+bwbJdVCoOa5cM+flzBsWN+ECdW8I4kFJrQmHfGbW7dfMKlz012IVnn6Qw==
X-Received: by 2002:a9d:7ac1:: with SMTP id m1mr1514106otn.186.1609891779140;
        Tue, 05 Jan 2021 16:09:39 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b71sm246694oii.5.2021.01.05.16.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 16:09:38 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: [PATCH] arm64: dts: qcom: pm8150: Enable RTC
Date:   Tue,  5 Jan 2021 16:10:04 -0800
Message-Id: <20210106001004.4081508-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8150 comes with everything the RTC needs, so let's just leave it
enabled instead of having to explicitly enable it for all boards.
In effect this patch enables the RTC on the SM8150 MTP and the SM8250
HDK.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi     | 4 +---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts  | 4 ----
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index a53eccf2b695..027f55d53584 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -97,13 +97,11 @@ die-temp@6 {
 			};
 		};
 
-		pm8150_rtc: rtc@6000 {
+		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
-
-			status = "disabled";
 		};
 
 		pm8150_gpios: gpio@c000 {
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index d7799a6fb489..546b7fb9cf55 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -609,10 +609,6 @@ lt9611_rst_pin: lt9611-rst-pin {
 	};
 };
 
-&pm8150_rtc {
-	status = "okay";
-};
-
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 767a2e446248..c291422fa096 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -392,10 +392,6 @@ &i2c15 {
 	/* rtc6226 @ 64 */
 };
 
-&pm8150_rtc {
-	status = "okay";
-};
-
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.29.2

