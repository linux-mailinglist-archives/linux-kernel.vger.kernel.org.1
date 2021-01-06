Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783D02EBDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhAFMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbhAFMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2CC061360
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq13so1502746pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMuTgmfW7boX1iQQTydlfmLnxOmK9dbluKSLAHWL4GA=;
        b=W30c9RmPScXo3q0goOcwJhd6NjCM6Q+lW11AkU8W8tUCT7CFl9KTIsrgJr6ChYnt1D
         ZtnUx8boLsW0bTpy0ftealN8CgS0g6M4cVEfbkPDav1Tomu6fwS1OD3YcjgwhtZ4NXH6
         3jgS5Cq9NRET7DPlBZVRRgnJ20STsF2EvnR0xgvkje6Ra8xc6P1L0xoHN8xJGfVpCLRh
         spazQzx0UGbAqOaxpyn3Dnl3V0sbstzi00q7Y45YTPSLmuXIboVlDUsMBGryrgmm4qXl
         tv6tbSRofYqtLtb6KFP2Q6kr/M0WsqE0WxPlluw7zB3iP8O+SscIbVL0bRE3ZMyjDNZ8
         a5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMuTgmfW7boX1iQQTydlfmLnxOmK9dbluKSLAHWL4GA=;
        b=tTSlbIOBfSRV4hgCx0w4TclpGjC0H61U9UC1bokGQfkCMd62FWeT/3Ut3fRWf/Ro1F
         Gjq/bc9KnRh3dOyLGFGLKZ82KdrQnrXTp6ZFajdo/El06cSSekpzDQjYZdzVvRINOoiy
         XkUd93kPDNErjk8WLl/6pg0h1G6P3AYfEhAtvnM/iBvBQYWpxTAtPFT8pFbzDX+7fdaG
         xa1ZxjvktPqj2Si8ofmxNlZVCZ8eBuLk/sIGJWqIQZa2M1VhirZ0eLzca8xteP/j2RyI
         We0Br4Pks0H6OF/6wrfIq5R9bnnoMdoPj2oNUjuorMRiN06VG+50OAsNXx3Nv+VQIxHi
         KLRg==
X-Gm-Message-State: AOAM531PID2TtqDLZoDgPFkGPF+nhWGd0SFFDp68V0W2uAMVZd/KHfsf
        oEWpfpOxZ7U2w2M8Gk6RcXFr
X-Google-Smtp-Source: ABdhPJxA2CzevUlx4wNHH1PbrquYizwRNpaG8kaHQlPr2k23vk1HJB8rObcUHJgzAo+I6UsKmDVPMw==
X-Received: by 2002:a17:90a:cb8b:: with SMTP id a11mr4149333pju.3.1609937640016;
        Wed, 06 Jan 2021 04:54:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:53:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 05/18] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Date:   Wed,  6 Jan 2021 18:23:09 +0530
Message-Id: <20210106125322.61840-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Qualcomm SDX55 SMMU.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b63f2ae24db..3a1cefce8bc4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
           - enum:
               - qcom,sc7180-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
-- 
2.25.1

