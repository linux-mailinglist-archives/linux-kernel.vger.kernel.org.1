Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4232EA7E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbhAEJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbhAEJsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC7C0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id q22so18056807pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVgPs4UTz0m97kkGkS/Y+gkUiFLrmZrneiZz02HakNw=;
        b=DutPUSfG8OBa3zh4wMs3OtN5nFmdZp84ZWZtn2s/43mh03TekL7sIELi32Gfh/an4U
         a71ePpilxScpeFmCia8JYpyliB0SUhXY/pJ5shyv29d6L8cMUxyHL5mbSzboLSSbN92B
         srP/QXTLujFiSv06DhW9jFqoisN8ICnmfp1+J7vIQvj5Npl6tpIK+A9veQiNOzwy+JTl
         xX0AdcDN8e6RH26rkXjNsBGx3lIoQbmxpwuLK8yRsmV5fY4/5xstnmNSwRKJ4l6YX2i8
         a63r2Sec4pgNAFAJXs7z+vaj2KkmIe1cFOsewJ8SniwaBOrqR5oo++8cOhEUrqrzPFsF
         AYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVgPs4UTz0m97kkGkS/Y+gkUiFLrmZrneiZz02HakNw=;
        b=aSFPLDUyAMupcQ3s0ahqgrvFzVtGJ98u20SE2YQtHOS24VuaF4UUS+PzW8MGLlRuHP
         qpOGNNJdiAhD2bDRG0AwuBCeD9XZmRDzjV0M4F6ViWo+APMnzn/HWSHgOLTKJCsfFBkg
         j5rkVJjdK615bjZMBGtEE7ZsVuRnmHZMgm79FN7A/JjsUi6TwlMzr25SNN+Opc43lbC0
         8yKG6KqOD/PX7YcbmP4746poxkL9PgPa68lgcc/OHenSb+vAKL3XFLhd6rivKZ+M8Vzs
         971tmAb7h9LmSayOnOuhWsQsAgeIukLjvfbjgaIBo2/yXUDmaKQOvUNZvNbVOT7nlilV
         W8Qg==
X-Gm-Message-State: AOAM530INOXsdsf8sT+0R5y2SwWc2crFnORD/A1UdtpJP96PR9xGjQHh
        EwTqrRTed87PLUIi7h6y+dKC
X-Google-Smtp-Source: ABdhPJyTRo1OjTtA/7Ns0m0WHPZzpudFVa+4Q6SGnm8+dLFZcqWH083kUE4VHfUJqmxJUIdbZwSDOA==
X-Received: by 2002:a63:3086:: with SMTP id w128mr39020040pgw.227.1609840021316;
        Tue, 05 Jan 2021 01:47:01 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 05/18] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Date:   Tue,  5 Jan 2021 15:16:23 +0530
Message-Id: <20210105094636.10301-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Qualcomm SDX55 SMMU.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b63f2ae24db..cc48d90de5fe 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sdm845-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
+              - qcom,sdx55-smmu-500
           - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
-- 
2.25.1

