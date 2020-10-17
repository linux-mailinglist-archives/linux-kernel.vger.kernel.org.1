Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE21290F24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411645AbgJQF3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411621AbgJQF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3633C051105
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:20:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h62so754846oth.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 22:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2qSucd31//Bn6PoGsGONNCcXz8Qt6ALmPzdRCPRn4c=;
        b=nxrCglaDP0clgIznNSAsvdpdmfide2Y0JX6QsZtr5dicNl/WppOcSXRAtH7RSm6PtM
         ZOcg5dFhMlpv4o2x9aaJW8Msfluqll2FGyfE7eK2Zq2jI49in/PL+CFUYWjdkQlbsM/q
         H7kL3QoMasXVYz4gzCboTyZpb/XKdC+0+85yrPs59kXgj9Njzunqe1lkcxs9HqsdQEHe
         naP0mZjyuKlQVJgap8Y1SFlktN9a+mJSTpeOq8HmZuCaesdu65vc8X0nFvBoNcGT2XdQ
         oJoVci5s/VqakDovEdUeVN88kqzxb64kTG6dqgCxe8aRJKifXV5JG+Vc1pRJa4zZu/+q
         acgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2qSucd31//Bn6PoGsGONNCcXz8Qt6ALmPzdRCPRn4c=;
        b=CaICYqiQahX/bS86Ouy4TrFtRmYKKIXLqJ8jRELICfjKkdZeuGUJfnV6mv0iiqpe+I
         f+CO5f2JmZI9EygaMHCRLOWlfubI4jQtazYfEzhkz2nZ099c8UETlJ2+MQe21+69fbUN
         WFmUtqybTN9vt9bFtjBUuPqg0KRMoZ5vAkEcPz4TVfy1WWV/j0l8SrdQPmoJEGkKi2XL
         Ivc8PC2LU/GSP0yEiOcWc0BjaJ5QqSj0K6etUsF9LiA2qXVvENFsPt/FA0HRaVoBjn0+
         q//aaH+tek6m0sATuxq3Fe2zF3N/RBgW5xZsHAtg+cMjRX8AV387M+aK5n9JNJrcV7Lw
         GjcQ==
X-Gm-Message-State: AOAM5331hOGhhJqC/sPRyTzz185lt36GVBo5M/9DM1e8spMtVrUZ2bmi
        mQPowwiCPrdzAo+PDWkb8ar9Hw==
X-Google-Smtp-Source: ABdhPJwnxFgcXB6YhtoDRpfk67xGvKxdhmZJ31vwsN3/+X7D98Jo+U6LVR3NLLjfT1m/8MK2VBy/Nw==
X-Received: by 2002:a9d:67cc:: with SMTP id c12mr4879502otn.359.1602912020274;
        Fri, 16 Oct 2020 22:20:20 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f2sm1572769ots.64.2020.10.16.22.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 22:20:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v5 3/4] arm64: dts: qcom: pm(i)8994: Add mpp and lpg blocks
Date:   Fri, 16 Oct 2020 22:20:56 -0700
Message-Id: <20201017052057.2698588-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm8994 contains a 6 LPG channels and the pmi8994 contains 4 MPP
channels and a 4 channel LPG, with TRILED and LUT blocks.

Add nodes for these blocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Replaced msm8996 with pm(i)8994 in subject

 arch/arm64/boot/dts/qcom/pm8994.dtsi  |  9 +++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 7e4f777746cb..b5bef687aa3c 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -86,6 +86,15 @@ pmic@1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8994_lpg: lpg {
+			compatible = "qcom,pm8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pm8994_spmi_regulators: regulators {
 			compatible = "qcom,pm8994-regulators";
 		};
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index e5ed28ab9b2d..23f41328d191 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -19,6 +19,17 @@ pmi8994_gpios: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8994_mpps: mpps@a000 {
+			compatible = "qcom,pm8994-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
+				     <0 0xa1 0 IRQ_TYPE_NONE>,
+				     <0 0xa2 0 IRQ_TYPE_NONE>,
+				     <0 0xa3 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	pmic@3 {
@@ -27,6 +38,15 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmi8994_lpg: lpg@b100 {
+			compatible = "qcom,pmi8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pmi8994_spmi_regulators: regulators {
 			compatible = "qcom,pmi8994-regulators";
 			#address-cells = <1>;
-- 
2.28.0

