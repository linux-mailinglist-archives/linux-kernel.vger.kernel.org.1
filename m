Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2643E2FDDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbhAUAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbhATXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:19:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9663C06179E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:37:33 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 15so47478oix.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QlobmqniGcNLDZStrX8yR0AATJKukz2SeJVeBU/abQ=;
        b=ZCB38np/civ6i0PE8ZZ8KFrurMep/cxsH2jm1K1Rz3GrtdyW+AdclDO2UIZShEzp+6
         LqSnUXDCz/gl8bBVV/gsvSXBSfAsQPha9RKkrabOHOezOPUhkQxrRE1EMkz14X5tqKl4
         TU4+nWWZJRwOr4L9qQR7mwoLliUSgy+7M86j7NhV0h6ZDeCJQQqELazp/VnMKDtzSpI3
         m5+AVw0foHB04i0dBrppp6AsXXoQjrzC4iJMYQeXAu6jc4jofo8sSOFRTBwsRlLQQpc9
         A0RQokIr6fgFpWSful0hAq+eqRjpMMKByRUCm0Ha/9e/9mbLEcmSTQw/9eYtnzITt6jC
         BsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QlobmqniGcNLDZStrX8yR0AATJKukz2SeJVeBU/abQ=;
        b=jUxuDxeBlpNk+rrYAuJpsj0smpyKYQygWBHPRQLukFYsRRP0xHgE0rPuGk+VxwseXO
         7ByRp7TBGCmsmgtK5svuMMWbH8pNu7lryb1tInALYNyzPuWDoIF7Gkc2RYPFfkx2Y4NH
         BlNz/qWCHbQJhxW6/0KJxE/WED5YMJd9D9lbsGubdeysA+4LVxN3x42Y8XpTv/TMfwIy
         ZTPgi1rGVOEWU/WrDFR1Z9gFX9pbJAE3sAzKAUuN9Z43nDepAo8SfR9qY1GZsPtqzm9W
         O6UNsQObOin9twedC55l0bXIr98oEfKER6OP9JiLK3NK+MAiepHT31OTzsFtT1b5eRv2
         yBag==
X-Gm-Message-State: AOAM531ofmq+q8YXZTST99SLvU37C+mOF8+LzgaRbB0wdczyJoPahlc0
        YyLg2V1RcikIegHu9iqvW+s7aQ==
X-Google-Smtp-Source: ABdhPJwCsecR2YD/TrzVI95JD6+pMNSPOtjOi/sbseb9A4bVw9/6/23amg9Sl8Zj2A+TZcBocWhCyw==
X-Received: by 2002:aca:180b:: with SMTP id h11mr4310484oih.18.1611182253422;
        Wed, 20 Jan 2021 14:37:33 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j9sm614894ooq.1.2021.01.20.14.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:37:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: qcom: rpmhcc: Add sc8180x rpmh clocks
Date:   Wed, 20 Jan 2021 14:37:40 -0800
Message-Id: <20210120223741.1610344-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Qualcomm SC8180x to the list of compatibles for the RPMHCC binding.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 12c9cbc0ebf9..167b018effcc 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-rpmh-clk
+      - qcom,sc8180x-rpmh-clk
       - qcom,sdm845-rpmh-clk
       - qcom,sdx55-rpmh-clk
       - qcom,sm8150-rpmh-clk
-- 
2.29.2

