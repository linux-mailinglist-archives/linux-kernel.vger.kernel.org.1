Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429F2FDF73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393175AbhAUCW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392218AbhAUBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:40:39 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB0C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:39:58 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id i20so163212otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTIkLf8P7rQ1csosNj9MYUkt9q/vHpvdvB2piAeWYvg=;
        b=vhLT4V2HYiuaF9zhU4e6fcDxilz0aj429uzh1g2Z6NkymbGcO+tJxJ861jlAOraYgr
         DCBG0R+yHMznzEVyIEe5pJpX6Yf1qSAK4BMdj2ZE0FzGXeo+UVxwF7yxjyRpBb8V2BaD
         n1IuRU/tqoyintLDZsJJyqM4jXlSuScmngjD3uBy6lTfI/V+8gHCi+fI+BsM983KXLcx
         DT9Z/NIAjkD/GgVuLNFd91mwNaQFxD4B2fSqm+kPbwMrDvdspRZn4vvhyz3kCvALApYz
         Nv06cvwlyydo5TqGIAXlEWo/ENmJY/xfEfHhlPcInADzxx4OsHkxPsWqgpOxzQYCDj8y
         l+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTIkLf8P7rQ1csosNj9MYUkt9q/vHpvdvB2piAeWYvg=;
        b=H1HUne7q0xxiDqi2dpTLIzbsOrEikJT2HKbgcVFhJZ8MVjKlqIC1Mu/NfdmUgdWoSQ
         31k0pQGoV3/4j/TbfIMLIKgxNLCK7/CtjSfEA153bi9AxG9eOMyS6ugZlPxIMVpSwYUe
         GMexWyFTodTDFre6CM5TlaFm01Q83+k7uH1EnTppmCZP2RTn7Xo85RH/z+dCDM8sEJ+C
         b6zoapIuLarkQALkf47iU+SO8zPE6vc16UlPUFB3I3iq4npC9mvuAkXHJFm8lFU8XH8r
         StuocT3mCwL2ToNtWSqMsB4meqXBwdB4PQUJ9Yx2K7hmDOWaDa2wuJ/Hech2CBgqclko
         4nrQ==
X-Gm-Message-State: AOAM533OmyIcN8bI36YuRyFkAvWiloQixI20PsKUCLwq2IFAEjwwCElI
        xnyXJtKWNe2vRS2snhILEczzCA==
X-Google-Smtp-Source: ABdhPJyBR58mQmQLd8XYcUP0EsBRHHD8FexvMM+wKw949cEidpIIPaHyDJpA57juJjwwsTdOX2Ujvg==
X-Received: by 2002:a9d:688:: with SMTP id 8mr2431369otx.22.1611193198020;
        Wed, 20 Jan 2021 17:39:58 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s2sm729597oov.35.2021.01.20.17.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:39:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
Date:   Wed, 20 Jan 2021 17:40:04 -0800
Message-Id: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the ARM SMMU found in the Qualcomm SC8180x platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3b63f2ae24db..c50198e17d52 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -34,6 +34,7 @@ properties:
         items:
           - enum:
               - qcom,sc7180-smmu-500
+              - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
-- 
2.29.2

