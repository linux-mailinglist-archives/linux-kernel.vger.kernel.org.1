Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE352FDF91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbhAUCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392239AbhAUBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:40:39 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E1C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:39:59 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e70so147790ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 17:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzybDX/Xt3GwRPQyEqB7XUFKbLslFfqKE8yCIx/zRK0=;
        b=Ic4hbBuNyAhH77UympHAdRhVtmjkRRK7AuwrbOo083hrfT222pag7ZdAcjU+coGOBG
         SegTBROdZyDXrIHKHPpD7OKNSP+S2Bp8aEu3r2C5bIpaSoi3+BbvZqAgaTsA/nHcFFxD
         hGqfU772nEHnlswa5nwbY1oEB7toAR0dr3ZS9LQDqFVqehrYakJD18wdgS7RmbiBmo6n
         3VmR8dzHxAkcx5IqcyKmmutDJnRDm8A3fV4luzraAFmRJGNrE4B5OhpfhEbsw/7atDVd
         O5evtHnFyC8CjcgSrcdi7mEtyHgvThZxqzHvTpSx1VAAjl/9QRQ1Xcgd+gg0T/JjUX8F
         A+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzybDX/Xt3GwRPQyEqB7XUFKbLslFfqKE8yCIx/zRK0=;
        b=sIykc84BGVvnChn3/gtukBJwzO6YXLPNHkhRkXSxsHd6MBmdAvOd6ovJqWfRfY5gZB
         OcnfRNRwf/V6mJEpfnrMDDZnlHpv3AyAPYkY0JC2087gPcQXAZB01QsRx3AWd68qUdTb
         iYEDWHibUf7mv3ZF1pZNK8EQ81Mn81Waq5neWdTAs0VQslI39p9srnYwHI89lj3jFEzK
         WpXW1Majxmo+n0OyY0iFzKINbZUQ0u2YywfS0PZhZ7jg+peu3EkXSTN/2c/T28lUamUA
         7QjzDcbPnYbxYLCkRLXxUkyJEMOU9HyyCP+rDkXdmONAMQblYEvw97YkkAoKi2/OsYh6
         9GdA==
X-Gm-Message-State: AOAM530P1LmXzc6SUa2gTr17cYL4ip5R0DcqApgTluqg0awqErM+GMwH
        H1tiIdfv+xrgCwOAn40LNIh2uQ==
X-Google-Smtp-Source: ABdhPJzSuzuFRbQfleUmMZxwP8jChSlAgkL5r/QPnevAdK69YCOfcV2uckVZyBhzjOw5Qnz8X5Yqfw==
X-Received: by 2002:a9d:84d:: with SMTP id 71mr8916828oty.338.1611193199082;
        Wed, 20 Jan 2021 17:39:59 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s2sm729597oov.35.2021.01.20.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:39:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add Qualcomm SC8180X impl
Date:   Wed, 20 Jan 2021 17:40:05 -0800
Message-Id: <20210121014005.1612382-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
References: <20210121014005.1612382-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary SMMU found in Qualcomm SC8180X platform needs to use the
Qualcomm implementation, so add a specific compatible for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index bcda17012aee..82c7edc6e025 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -166,6 +166,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
+	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
 	{ }
@@ -327,6 +328,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,msm8998-smmu-v2" },
 	{ .compatible = "qcom,sc7180-smmu-500" },
+	{ .compatible = "qcom,sc8180x-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm8150-smmu-500" },
-- 
2.29.2

