Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13592E7FED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgLaMZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgLaMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:25:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C4C0617A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:24:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o17so43768016lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ae+eotDOGUM6TKajZH+vbsOlioJYe6VPg6q5P3xKHJA=;
        b=Bz1s8pRNAqjTEcnosb6WR0Qt4kZFkzotm+XUWaNNxpkZUMUaEZSUqFWK8Pglm1vlrn
         IO2cZLdPzluiUIibr/2+wudvQdGDplf+AzNbN6syubqQlgQO0DFjKYs1CgOO4TMBBDhi
         fPBfD7nXYcyYX/nuu6SiqZihSNSfxnpRq/jJJcLNasmEC8UFtdn2jCD7yty7UkJnShsV
         DVOPo2k1j8EG2maP19Z1ODZAu4Bgjnz9D4D4l5XJm1C8nzFTIf5oXlKxsdUhsTT+Kqev
         8u7MnExvxcJlidB01dRTbA6x+VBWGrfVTqclRRbnOsWSdSOst6wRWTJbPO1Z5dGS8FuC
         EZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ae+eotDOGUM6TKajZH+vbsOlioJYe6VPg6q5P3xKHJA=;
        b=HIqqY017AmUNXR6UNsIlwr45y2mdDHrpvQW8aEy78vFp4s1EFuDV7Tsnpt9wq9k7hm
         u1wguT+VMii60773whp0Dw9fHBTJ4OOg3Y+m2UFMco2faF8EY6sBmT+uXJc+X44rlBnJ
         86kugDH//MiKCQ/u2DuGj0OtiFixxVY0A+Z582hBOFe7L+dXcXk/iGBTBTZuXBhYApsv
         WVd4JJWkIs4T5a6kWizq9P4qIAIagLiHXdLbqekqZls2OmbCZonbcsHZRPYMIXwq5M60
         csK/mTk1BeHnwTSQko02bvlySXDRiN/2chavDbEFZXT6sqV2egV4JNN7yO5Dp8uCTxFe
         NTTQ==
X-Gm-Message-State: AOAM530+XxP7IoTT1zAIJHkxIIAedU3SXqBQ3xnuDzlvRlosR3zuBVwY
        JepsL6Z8d6v64a8OuucGa8Hu8w==
X-Google-Smtp-Source: ABdhPJx7Se/0vCxP9CeAwpFZ9PjPE48wfYldMnSGcYFD5AWua2+R3SlTLFwwkQkbgE3Et1WMURVf0Q==
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr27105451ljp.329.1609417447810;
        Thu, 31 Dec 2020 04:24:07 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.115])
        by smtp.gmail.com with ESMTPSA id n10sm428569lji.99.2020.12.31.04.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:24:07 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: qrb5165-rb5: fix pm8009 regulators
Date:   Thu, 31 Dec 2020 15:23:48 +0300
Message-Id: <20201231122348.637917-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231122348.637917-1-dmitry.baryshkov@linaro.org>
References: <20201231122348.637917-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pm8009 compatibility string to reference pm8009 revision specific to
sm8250 platform. Also add S2 regulator to be used for qca639x.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: b1d2674e6121 ("arm64: dts: qcom: Add basic devicetree support for QRB5165 RB5")
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cbced45d7f51..5c1cc836920f 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -140,7 +140,7 @@ qca639x: qca639x {
 
 &apps_rsc {
 	pm8009-rpmh-regulators {
-		compatible = "qcom,pm8009-rpmh-regulators";
+		compatible = "qcom,pm8009-1-rpmh-regulators";
 		qcom,pmic-id = "f";
 
 		vdd-s1-supply = <&vph_pwr>;
@@ -149,6 +149,13 @@ pm8009-rpmh-regulators {
 		vdd-l5-l6-supply = <&vreg_bob>;
 		vdd-l7-supply = <&vreg_s4a_1p8>;
 
+		vreg_s2f_0p95: smps2 {
+			regulator-name = "vreg_s2f_0p95";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <952000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
 		vreg_l1f_1p1: ldo1 {
 			regulator-name = "vreg_l1f_1p1";
 			regulator-min-microvolt = <1104000>;
-- 
2.29.2

