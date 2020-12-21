Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5074B2DFADC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgLUKKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgLUKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:10:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912FC061285
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:10:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b26so12775411lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTS5XP2jtgHu359mlLvqf93EvN6ykiTeG0K5/al16QI=;
        b=mjZsJ0+ovrZ4dWIMP+NT0ePEC9xYzfkmqWhZkKvz4yxZd9h384IRplLWesY5RPM1zk
         RamBZZLwz9j33w2WiW4erYjF0mRGfRzoMjrTA/mBAglwzpAmjJdFm7dxTFZCfCU5lkvP
         G0rKJPdkhske3+Wou3ZgxJg5itEdSf4SvEWG3N48vDyKtWuDU1sdF9O+AsEHtgvlHMe6
         pAF8gNNRNDzr3vznIdbut+C6OfwQM9rjVacBKWEhBK1Dp3PSrNIuZW0tc3r4GsKfxiD1
         wah7fH8BpywxddirD/AQVMTSui5/oL/wJl/KoMqMT6Y/zPo1VW8n/49xN0nJ0U84NzQT
         EeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gTS5XP2jtgHu359mlLvqf93EvN6ykiTeG0K5/al16QI=;
        b=T8u7g7hXNeDrZ9dBz4OMrg35kZyglw7Z5RZNBg+qv8sJ2Q8xV7iYWf5rgdoy/NotwJ
         +YlyPo2HW73FMq6coZh+LgvWbBMlmzaCmb4TGNreUEvjp7FTQ5IXqoY9l3alJVbJFZbT
         H24ug5hnQ2MQNbw3CnPi1WJDbRc4sZ10a5fx/nLdILSSUEUvwJPpmy1tdUMt6VusuYfE
         msXCTKq4H92Bmc6nFTzX6LgQqmvJCni1OwUANKzv8vr1uyN0E8AR8IlmBI1Tt6KCbE6h
         ozdlIQPw8Qwnqr5lctxu+r6RDNxARca3/MgyRwv1Dgk2RbU5acL7vGxuiGw6L3e+apWC
         VbDw==
X-Gm-Message-State: AOAM530o7JbLCMiQAqVwT4CLcgLQ+UhpAJesdSnoaB0jvyUo4r+q9afa
        h7DHX+QdwtcO4WsArzHNHEcKUQ==
X-Google-Smtp-Source: ABdhPJyhhhqWSrhwIpu9AoGAFII+/VTrWX273QHhmSjZOThd/9Efaca2cmV3e4dmcg7AQ2lK7fuF+w==
X-Received: by 2002:ac2:482c:: with SMTP id 12mr4754844lft.37.1608545398952;
        Mon, 21 Dec 2020 02:09:58 -0800 (PST)
Received: from localhost.localdomain (host-95-192-94-245.mobileonline.telia.com. [95.192.94.245])
        by smtp.gmail.com with ESMTPSA id t14sm1980971lfl.216.2020.12.21.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 02:09:58 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        robert.foss@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845-db845c: Fix reset-pin of ov8856 node
Date:   Mon, 21 Dec 2020 11:09:55 +0100
Message-Id: <20201221100955.148584-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch reset pin of ov8856 node from GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW,
this issue prevented the ov8856 from probing properly as it did not respon
to I2C messages.

Fixes: d4919a44564b ("arm64: dts: qcom: sdm845-db845c: Add ov8856 & ov7251
camera nodes")

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---

Changes since v1:
 - Bjorn: Use define instead of numeral

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 7cc236575ee2..f749672c5fdc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1112,11 +1112,11 @@ camera@10 {
 		reg = <0x10>;
 
 		// CAM0_RST_N
-		reset-gpios = <&tlmm 9 0>;
+		reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cam0_default>;
 		gpios = <&tlmm 13 0>,
-			<&tlmm 9 0>;
+			<&tlmm 9 GPIO_ACTIVE_LOW>;
 
 		clocks = <&clock_camcc CAM_CC_MCLK0_CLK>;
 		clock-names = "xvclk";
-- 
2.27.0

