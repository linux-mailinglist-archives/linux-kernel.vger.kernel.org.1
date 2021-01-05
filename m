Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3216C2EAAC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbhAEM21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbhAEM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:21 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1AC0617A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lj6so1589821pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVgPs4UTz0m97kkGkS/Y+gkUiFLrmZrneiZz02HakNw=;
        b=OQaxZLZrGACL8Q54aGsrKM3UtdQOc3d9oBz5rGsFK5MYTq3dzA2t1r6lgPaRte30RK
         7Zho0nQ0IwZWdj97ucxShx8X4W/CO36KVqPKs15ohWVWBugVWtZE0W83Zs5nQkBF6Z2b
         odoEi2OR3OBDiv2o6fmfwBcxjSOoYdyQhx35nfLv879JlufiBWEsePYyjP93elxNNhGQ
         eG2gVQm+fLEEoM5YMdXo/2s7wfbTIxuXnkRH+wvQOlWdiEXUjh13nlhhL5iwIG6h8drx
         WT5kq3QTGe/gJ1EDTCPbnDfwHSWmTLKagPbS6JIWN6XW87SjYzES9URdK2CQ3f/W6X1e
         uyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVgPs4UTz0m97kkGkS/Y+gkUiFLrmZrneiZz02HakNw=;
        b=trqWI7HPdVChHg+tLgcdK8GjYOOwwB2xvxU1bhmFximLMVZVsTA4ISUb7PSs+F19/3
         kIOLfqEr4dSkTXdKjPcYJ0TLvzVdhihR9aT285VZEVWYhwb3ZLHo6m3/VEn4O4+KtR6n
         FnbueK6U1JIn5JyLGa8xYGdQcVYvwDTlB+VKtgVueaJhEV8KRHkP7UQMEzci7uvFHAf2
         ygrOs4Z68l8+r+CZ02ANczvAmKYNi6t2v22GoqQTbaM3IwGQwUaFT1SaZU+5oJWhwl71
         AtmChkXHcfGEz7M9KBZ3gyzgoE8KlcqLTx551wxw8GhivJYxfeYSjm5W8fy5lmCCpwbN
         3Liw==
X-Gm-Message-State: AOAM530TvmPNfZ9g6G0Q/55CFFqzZyT5Ynf6PYK0C3mW5wSO+2/aSuAl
        +tg3Kv47Edt0eWpjwePfU7oh
X-Google-Smtp-Source: ABdhPJyxoMT1SpuSm2yhcMnDEwBBVoOFnTvmNvyODOP877OQwAFbVMVdWDJaKdU8QGhDSPTNjhArMg==
X-Received: by 2002:a17:90b:228b:: with SMTP id kx11mr3968531pjb.122.1609849633859;
        Tue, 05 Jan 2021 04:27:13 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 05/18] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Date:   Tue,  5 Jan 2021 17:56:36 +0530
Message-Id: <20210105122649.13581-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
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

