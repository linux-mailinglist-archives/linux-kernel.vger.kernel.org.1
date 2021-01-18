Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F19F2F98FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbhARFLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbhARFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:10:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEECC061575
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y205so3681719pfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHI9PJDZ4lLZo/sEvf3uvSbpMTTpR+8Xw+81k1KJyJc=;
        b=dOaorn99d5yRq4LT1/LjnW5aWCZoABYq0NtrkrXHVlaQYAPZnqIg+iI/kJZn6oENHg
         2wrSf+2dqr2V9zzCrSuqPUfagKYvz9aoQHD1ILOhTfPXOGbpvAko1w31exGPaDPm0ocX
         YEjRhWiBZch+TIUFYKWmPQx4Be/lT7XkbckqImWyKo/a5VsOMRf46JpIigZg9h+WE64d
         h86bddUuPWWs8DCM3uRZNnZE/vsOtN3qcHnmdDfsj+GLRfVdrGeCS7Jcil1urCyN3H7w
         s9JzIYk2dUroYZ8aJJeCDfnSFJRESNMFi6rQ+cPS1Anj7S+s2sLE9aOVpHSYyo4Pvi0Y
         uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHI9PJDZ4lLZo/sEvf3uvSbpMTTpR+8Xw+81k1KJyJc=;
        b=V1yX+mWJpT6k1Pgruerk2KXsLdlaGNpc5hbrM3IdT+AzDkiXjktK5+oohwrdSsuB9i
         TnOg+xtdarTwaPFaF1xGrO4ONh4x+drjAj7LSEl6X+AXcjxTR1eS+RzNpXYZMddC3bNr
         ea5RG/w6DLnznuIO8D3GVeC/O7md6hRMI0LLh+EbRkgbEB0hDH/xojMhrHrk4W7lQHje
         G4uUpJcUzzHs7W5HWKnTfhaFKqDOhWL8OL6yFDhwMAGiufc60LVL9/9geDhN26aK/Gvc
         Z6ORMlR6FxGyvGZvrTFPu32VDQLij+agonA+Yk89SPpvMa52eL5ihVxYF68YyBYuQche
         BDXQ==
X-Gm-Message-State: AOAM5320S5FsjANmAdVPPYalY9lk76fYDVJNGXM9ZxJ+rtz3iRuGSMU0
        MQw30ohC0nvIPsJEvqftGhAX
X-Google-Smtp-Source: ABdhPJx0B9pAlQO/jE37qJCOimQMmUmIgC7xP6onVLVa04ASVNfk7vin/9IeStWNo8BOxFYoMpg83A==
X-Received: by 2002:aa7:82c6:0:b029:1ae:8580:9b55 with SMTP id f6-20020aa782c60000b02901ae85809b55mr24830988pfn.72.1610946616127;
        Sun, 17 Jan 2021 21:10:16 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.182])
        by smtp.gmail.com with ESMTPSA id j3sm14703571pjs.50.2021.01.17.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:10:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: usb: qcom,dwc3: Add binding for SDX55
Date:   Mon, 18 Jan 2021 10:39:59 +0530
Message-Id: <20210118051005.55958-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
References: <20210118051005.55958-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for SDX55 USB controller based on Qcom designware
IP.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 2cf525d21e05..fd93b941f07a 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -17,6 +17,7 @@ properties:
           - qcom,msm8998-dwc3
           - qcom,sc7180-dwc3
           - qcom,sdm845-dwc3
+          - qcom,sdx55-dwc3
       - const: qcom,dwc3
 
   reg:
-- 
2.25.1

