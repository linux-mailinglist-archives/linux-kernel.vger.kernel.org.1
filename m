Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5B2F9881
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbhARENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbhARENF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:13:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1BC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:12:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y12so8638468pji.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 20:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JA2bOmH7zXucsB0pL10PBkPjMC5JaJqOe1c7ajz47T4=;
        b=TlUnawC9tBIYQZlOxs++2xywj/BJI3N7LTSFv1Y0PWumDX2Gs6Tp+GyafoWhXdnmPf
         lReyfV+Ya9L6dL2P3thkKkipztY1N0sdNKGB72igmNb+8bISneowTE/KD/3w/6qF7Jd6
         ycGFoTEMSBSAVn+7HMzBbPTwdKTQFAh1yVYv/i5A7n1aZNkzSqEL9I+MC1FNiGOt8HLu
         PHc7BJ7jJ6RmEWmNv3VH99kcjkG34JezH6b/rOR7ilXLunOAGs+eRr/c/3QBy4PjjakS
         b0MPV2DXAuZfIoqmTZDfw1X27LpfG/dgzPuf2D59giD9Lm94H4ZSllR0ekbQ63i1f1ia
         gn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JA2bOmH7zXucsB0pL10PBkPjMC5JaJqOe1c7ajz47T4=;
        b=Yt3zpvICpzLZ3uHLINBWd0BZHt1kRkvqR+ze5IbIc9JIsQB/TNOHRjza6doRSkmyVm
         67VQ4hTFHEyeX/ZOLgXfwQkFVWJ115DwcHRBxUYBix6lJQ8NBeq+LmMyV4npRdZBVk0i
         tp3ZYKKFYgcWJoFJLx2LzhO6zrV11V29R5V7zJbbq1IprbhYcJ0bmHX6OjiyIifPeO24
         p/938uaxIA58cKAQBYXlnPQIRnwrtQ0A/LDjQrSFnp8Kztv5H7xt2CWFQhx1XUqNRjKi
         U3nYvyLJMIF8qvK8gTJYmKzBUtgI6SeyNEGx6BJ9UnsrJ1/zlSiSlcVdFuT2UMn7A9fz
         UUvQ==
X-Gm-Message-State: AOAM532UL8RAO8T/F25NFdzuAgXDbsFPNIbnFdLNtl9/w1zzB+SBz7C/
        HL8Fdpk8k/dqC+iDx9Hes1XC
X-Google-Smtp-Source: ABdhPJx5eT0mGnQxBoihp84O2W77mHeFvDWkxNpF7I7Caofs/5tx5QE2CNYF1b+B9k12/LpLSisLVQ==
X-Received: by 2002:a17:90a:4cc5:: with SMTP id k63mr23944580pjh.202.1610943144354;
        Sun, 17 Jan 2021 20:12:24 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id h15sm6727319pja.4.2021.01.17.20.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 20:12:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     viresh.kumar@linaro.org, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] dt-bindings: mailbox: Add binding for SDX55 APCS
Date:   Mon, 18 Jan 2021 09:41:52 +0530
Message-Id: <20210118041156.50016-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118041156.50016-1-manivannan.sadhasivam@linaro.org>
References: <20210118041156.50016-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree YAML binding for SDX55 APCS GCC block. The APCS block
acts as the mailbox controller and also provides a clock output and
takes 3 clock sources (pll, aux, ref) as input.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index ffd09b664ff5..144350f72f6a 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -33,9 +33,11 @@ properties:
 
   clocks:
     description: phandles to the parent clocks of the clock driver
+    minItems: 2
     items:
       - description: primary pll parent of the clock driver
       - description: auxiliary parent
+      - description: reference clock
 
   '#mbox-cells':
     const: 1
@@ -44,9 +46,11 @@ properties:
     const: 0
 
   clock-names:
+    minItems: 2
     items:
       - const: pll
       - const: aux
+      - const: ref
 
 required:
   - compatible
@@ -55,6 +59,35 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+            - qcom,msm8916-apcs-kpss-global
+            - qcom,msm8994-apcs-kpss-global
+            - qcom,msm8996-apcs-hmss-global
+            - qcom,msm8998-apcs-hmss-global
+            - qcom,qcs404-apcs-apps-global
+            - qcom,sc7180-apss-shared
+            - qcom,sdm660-apcs-hmss-global
+            - qcom,sdm845-apss-shared
+            - qcom,sm8150-apss-shared
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sdx55-apcs-gcc
+    then:
+      properties:
+        clocks:
+          maxItems: 3
 examples:
 
   # Example apcs with msm8996
-- 
2.25.1

