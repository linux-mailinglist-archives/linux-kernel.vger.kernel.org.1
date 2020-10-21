Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF54295358
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505169AbgJUUMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505147AbgJUULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:11:53 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:11:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h10so3453684oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3IjEKBycl4AdV4pHmY8x7WaZ0Ptwe7SpKSP+5fA0v0=;
        b=Bsil/4/VIe8KiAFM+fsJ3dsLu5fJ+LYGHFp8iH99zcx6Djp2uzo6FD2YjXSd82lkVg
         piz/Xirt+WifCSz0l7gLClPZiP14tb0WYUyQ1zMTlVmshXF5Pz67/vDfyp2wt9XTPsFA
         Fki4xWfLpSGf3CdTu/ToVli9ItQoWdBLKslbw39xMVutqkMO5lA39tyHb0vI3OtID41X
         G7EuxKdKKEWeAa1c1hB4lNV0Et9TDTU7mqWIovKwHX1KCyWvWgOWqKJpPaMRWW8ursu2
         CFBMyaLzPkkNQwauUzoy+G+anTLhUQY3fTNYAeSL6JKYR/OZo6RewIblcuW9ngtEzREg
         XCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3IjEKBycl4AdV4pHmY8x7WaZ0Ptwe7SpKSP+5fA0v0=;
        b=HWRNCoYIPRNJaSGPt7aaJmT6CDdnZz8KfKn4hEN7aF4+OkbRXTDrLXOWej/bJcu6cT
         g7eu1TpVWftDft4Fj0bT8lIXrYyZwN2SuBHOp1ulQCVy+1SBWcgGapeadQoj/B8J4SP/
         JPtzUYUi4qlZNBhVpdJ3fl2ih3PhyhxNXSxVG6R2E6bZ2P/xMaUuYb/RdiIED/NMHDW0
         h0oXndW+ytEwEULgWx+RTDxT/A2QUk96xGxrWr9Ujq043XfFeJoJfJUE0vbv3OsWllMF
         8aS1K4WBwehCrrP/AMxVVIn9rPXAjZmgBS1rMJl3+pJPDGJUglRsIhD53bVRhBcNYio/
         bqBg==
X-Gm-Message-State: AOAM531YMqBxWLWu6eKKv/sPd+U+DrE4ZfMAUVXvQF0pEbxEjnVKCr7c
        1UfW58sDdOI7qsGhMFr/rcHasA==
X-Google-Smtp-Source: ABdhPJwpXwGpMMY0lOzWhIQyAznwBP9uD5c44odQWyNTc7tB26G8V2bFUSw/A6eCXg3EraLWJUhDoQ==
X-Received: by 2002:aca:442:: with SMTP id 63mr3195841oie.111.1603311113085;
        Wed, 21 Oct 2020 13:11:53 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t5sm838166otl.22.2020.10.21.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:11:52 -0700 (PDT)
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
Subject: [PATCH v6 4/4] arm64: dts: qcom: Add user LEDs on db820c
Date:   Wed, 21 Oct 2020 13:12:24 -0700
Message-Id: <20201021201224.3430546-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The db820c has 4 "user LEDs", all connected to the PMI8994. The first
three are connected to the three current sinks provided by the TRILED
and the fourth is connected to MPP2.

By utilizing the DTEST bus the MPP is fed the control signal from the
fourth LPG block, providing a consistent interface to the user.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- None

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index defcbd15edf9..7e51677d256e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -8,6 +8,7 @@
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
@@ -682,6 +683,54 @@ pinconf {
 	};
 };
 
+&pmi8994_mpps {
+	pmi8994_mpp2_userled4: mpp2-userled4 {
+		pins = "mpp2";
+		function = "sink";
+
+		output-low;
+		qcom,dtest = <4>;
+	};
+};
+
+&pmi8994_lpg {
+	qcom,power-source = <1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmi8994_mpp2_userled4>;
+
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	led@1 {
+		reg = <1>;
+		label = "green:user1";
+
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+
+	led@2 {
+		reg = <2>;
+		label = "green:user0";
+		default-state = "on";
+	};
+
+	led@3 {
+		reg = <3>;
+		label = "green:user2";
+	};
+
+	led@4 {
+		reg = <4>;
+		label = "green:user3";
+
+		qcom,dtest = <4 1>;
+	};
+};
+
 &pmi8994_spmi_regulators {
 	vdd_gfx: s2@1700 {
 		reg = <0x1700 0x100>;
-- 
2.28.0

