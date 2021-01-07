Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A332ED2B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbhAGOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbhAGOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:32:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A03C0612F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 06:31:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n7so5068924pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsDTMrWv7jSxdT5ji0Wdtt9x9xjaZ1j3PSJSmTMWzAg=;
        b=LFmqRtkapVLHAIwS9SwEiH0wOugFQUWyHlXt409uUhmVadFEvWL+UTSux0ywaxjTIL
         qPGwDIR8l3xvvhPvKZqcH81QyML6nYN2gQ9PlLPbicKSgn3g6y4FyFG21l83GjqbxFe/
         Y1SvEhPYdyHVTiS8T8D9nyKiD9/MCS7bvruMES2BHC5yfq3VUobOa8bSsSPj9OBNHphi
         0pT0vA85FIZSzzv6NdOBukjatPxyL1xaGfO6w3hP56XSg5w6L2x4efpfRXfiX+eFPCz3
         S+g1ZPdGLmmGNpUQZsA7ZWNeagdfXw8PVAHujJ6k33M6Huy4auqTVqMquaILFD8WTImK
         sRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsDTMrWv7jSxdT5ji0Wdtt9x9xjaZ1j3PSJSmTMWzAg=;
        b=st9exXxBfmIlAXd21lT/8DergQzkuYHkMe09nqxZyZiwNxjA++t0NVw5cF/pIteSh0
         St7KSVuNAeb/2n8LmSbFZ1uZ6KJVoZuB3vSZFcAH5DTNEptBfJkin8SHsS/buH/IENB2
         IY3yzeMjG0GOfJ8PMrpTbbZE8qc03zCMAPaQYGtmKKNowjYQ/RFcjw807gSbHFH77+zD
         4vOCRs87BDGniL/H3LGNddJSuY8xkcmQ7zHcxYSTdJU0DxUBRCwVvq3r23P8Tg00/7l4
         YIJmASk5wsRInI+WbYOQBlUKRrUa+ZXPo0knzFNgQn1MS7nYz5Q7keIOZbs/ceYJ3CaT
         zJVA==
X-Gm-Message-State: AOAM53142zyjPK+GUlR3wHV2sdvDYzV3Kdnj4i5bLC4j7RuBOILw6VUK
        D1PVoprNuqTRHbeeY3WmfrEEgP5CgFmD
X-Google-Smtp-Source: ABdhPJzSG7+An9o4M0cfAK/FdgBFCAQmBgulcSq3UwEZdeNDf3A/qo5+aNub8hfE5ryNYIOPDwVeNg==
X-Received: by 2002:a62:7fc1:0:b029:19f:1dab:5029 with SMTP id a184-20020a627fc10000b029019f1dab5029mr8813824pfd.13.1610029901346;
        Thu, 07 Jan 2021 06:31:41 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.128])
        by smtp.gmail.com with ESMTPSA id 19sm6096465pfu.85.2021.01.07.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 06:31:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Date:   Thu,  7 Jan 2021 20:01:18 +0530
Message-Id: <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Qualcomm SDX55 SMMU.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
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

