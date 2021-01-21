Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6452FDFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbhAUCA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbhAUBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:44:31 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A68C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:43:32 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id j8so127760oon.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSX1n2LmGUnSPUCHanCJBTkB2czCRGcfIPAiinWQJgE=;
        b=tREtoCdx9NsYJuGx9+Z2lyj3kNpCg8ZrHWx1tOf6kPnCKXzlf+H+QhejDbPr1SZ/KG
         ZIRg5qHVvtL7S3uY2FhF4tl7Wfg5TfihzUxqSuvKZQ77cb9zo3C3EiUVn6aFcsuvmkdW
         p4f9K8UPlEDG990TSW+Vcro1sbOWj9jzdz+dMJoxQIJ/s+Jbciwfi9WcOprmvVlDA0aQ
         bJpBB9RhJoSy3BVcyMHK3p69KBd9/cuFtxLz6VRpa/qLDzL5856vv5ZQyQRTS4X45UTP
         WLnEQN51mxohQSOpU7TWKi0Ny6aK7bIDZaPgW/RWElC6yNXP7aQLmqMqdd165d3YQlMy
         VFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSX1n2LmGUnSPUCHanCJBTkB2czCRGcfIPAiinWQJgE=;
        b=lW23STgMTCQY9mhckRXed4uSvwn42SX8Ge2tkeoJR0PplkxOTJflq0aduyMgOSZ28J
         SvzdLCFGH8x77WJvapE8eBJNASB31L+XvmfZxz3VHbmMgQ2+kEO906wt5wJfxLpLW19d
         kGCZVjD24vZkE66j3iIPde6pmPWFg+USkCEoeXMkoFeZLaRc7i6QEJSbgBl0/A+A9NXn
         ZT92DSHRCAXVCJdyYwXF0SdEDTM1hRYhS+Vz2Z2pQ4isLm9cvXUDSNGeHw9TTSGuZbmk
         kZcXFGiQUP9n7tGxiKH3gPmjWTcy2emwStjBXvjy/XrC7vqtZnuhQ/8i9ND9Fu+LCSzr
         mGzQ==
X-Gm-Message-State: AOAM530eHolwW5jvd3P1Kko//iC5hOC8LPsLjvbpZ67nInKx9sekNU2K
        8cyegkJuJzu0sj6iVRlsQ1FZKQ==
X-Google-Smtp-Source: ABdhPJw2jQUNQiDxA/8xjcg+n41uv7J4DO06g+40CIAeN+QvRB64nFQlAxDzb1veFs1Kol9wtULawQ==
X-Received: by 2002:a4a:e81d:: with SMTP id b29mr8110782oob.22.1611193411431;
        Wed, 20 Jan 2021 17:43:31 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s69sm779032oih.38.2021.01.20.17.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:43:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Add SC8180X USB phy
Date:   Wed, 20 Jan 2021 17:43:38 -0800
Message-Id: <20210121014339.1612525-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for the Qualcomm QMP PHY binding for the SuperSpeed USB
phys found in the SC8180x platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index e272a1077150..bce85f37a32a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -26,6 +26,7 @@ properties:
       - qcom,msm8998-qmp-ufs-phy
       - qcom,msm8998-qmp-usb3-phy
       - qcom,sc8180x-qmp-ufs-phy
+      - qcom,sc8180x-qmp-usb3-phy
       - qcom,sdm845-qhp-pcie-phy
       - qcom,sdm845-qmp-pcie-phy
       - qcom,sdm845-qmp-ufs-phy
-- 
2.29.2

