Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8B2F9909
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbhARFL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbhARFLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:11:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF7DC061795
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b3so9523909pft.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/MckQVyedOPxim+CJoRXJE+6wRoe7vc3ngCjh1a4CY=;
        b=dn/OlTA/DrJq8mV6ehVt0kFcB/l3X0F2BLxYgjBJCvN91wQvk8sJ4cYK8FsPIKXVeZ
         EefW8fE2pTgeZxReqkmHkVs8RGuMvnUDxhTfd8m5sHyQw/INmrYIDtNi2q7v5jvNgoIP
         5a8TFk1gkqs7WwxFH2EXbqklwZv0yYXDKBb3tI66Qgx27fy8eriwb33gE0mAfrQT9Zm3
         Z5AQ47B3f4Ev6DL6uWrHrQ7YGML7I80zw8USEy0WuTAnE55I6daX5H4lP5yb+pfkNxBv
         TO2lAbe2GExsfi4GZP1cL9aC8xWXQen+lj8e8QR2MZKefliUKJH071iC1NDsH093Er1G
         u4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/MckQVyedOPxim+CJoRXJE+6wRoe7vc3ngCjh1a4CY=;
        b=tLtSIJcgEWAjl74T4YCZAIZvlMTwKl4+csB0flCH8leA5w3+DYPEYvszf2p52ovMUH
         9KyEkW/JeVMc9lMFK6ImzS0DzO8aFeJ5nhLB9tVp9f3LFnvhNfKTi8ebJ6RVWRbXXGAv
         thmt/thM4jngYWstqQOHorOpP6sfpDKyBzi3PLjGe+/JsgFu3ArZUYqHlNoiY9vZP50D
         /OzPh8sw4wANAyHFfKaLifUiI5V44ukSW9QZZkIdNjtNUTZz58KiyoIUE4VgEcfyTFWQ
         j6LqU8wU3WNK6WlKfXtvkFWonMPbgf2p0iKLzNqlBa4XRdqV4xV7FzMKCh4d92DMa+a9
         S1jQ==
X-Gm-Message-State: AOAM531gnBmfkHc8ahJRYOmvUdRV26LUktjP++OUEbhbs+eoHEUXvYWn
        3xyb9Xle/duy3m8bXng/6/jI
X-Google-Smtp-Source: ABdhPJyJ9Q8Rqr6xoocsiwSLSsTG9NXqttQMylr8KEZiHQMmCX9N3Ziipj6ygoAKnwy6OqWkuUL23w==
X-Received: by 2002:a05:6a00:8d4:b029:1b7:7ad9:4864 with SMTP id s20-20020a056a0008d4b02901b77ad94864mr3399128pfu.34.1610946626926;
        Sun, 17 Jan 2021 21:10:26 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id j3sm14703571pjs.50.2021.01.17.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:10:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: watchdog: Add binding for Qcom SDX55
Date:   Mon, 18 Jan 2021 10:40:02 +0530
Message-Id: <20210118051005.55958-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
References: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for watchdog present in Qcom SDX55 platform.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 8e3760a3822b..b8e4118945a0 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - qcom,apss-wdt-qcs404
       - qcom,apss-wdt-sc7180
       - qcom,apss-wdt-sdm845
+      - qcom,apss-wdt-sdx55
       - qcom,apss-wdt-sm8150
       - qcom,kpss-timer
       - qcom,kpss-wdt
-- 
2.25.1

