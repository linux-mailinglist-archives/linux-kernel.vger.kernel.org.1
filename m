Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16C290FA7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411862AbgJQFyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411834AbgJQFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:54:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83077C05BD27
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f37so4478276otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOjoMftzfUgquuonXm8ecKALCf35LLgxoRywnILvYmM=;
        b=d49Vti2ocqeySl7P9/9hAzXFqHuY26zRhnG4D5kODBWt7wOSQnaVdBrmHcNsY8o4zC
         wribtUA0xR6AfDS7810YK0Ia/ckWr7kzwXIuvVSz3U3C7D8H1WmhIY/F/C07ki2GhpqA
         IIWSRC9r9uzgAnaIJbfT0BSyxSYjIfiT2F4VPqnFilmwMEAAqyf4BiJG4Bn4Gpsx+DXm
         NuQ89kFrTA3k9Mvxt0vPlefFqDjm8ex6yvLO5HCL3rCuvFQGX3yHTVEmbE/LHmCj7+0y
         ShtfrggLu5Rto8X6HJ2UEqXUBWE59sy/+Qp9uNdlaMgUNUUJlk4A6MwkDvX7QpN6/WYR
         hyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOjoMftzfUgquuonXm8ecKALCf35LLgxoRywnILvYmM=;
        b=msTeZNvqBN7tpLIi6J60jPyJttIhdhuLwmvOd9ZWIngZobEAL1xw0aP3UgMMpCDRz0
         Z/YU/U7GbcStlXQ3OgSOklUVlssvXP16osVPf3k+K9AB5b/cusedayDhqW9u4XBC3zZm
         epk4p0QavUWN8UvY1T44IecBSnBXE4a8GjYUexRXxmF1Qxd6YMrfMlvHej0Ckuap+R+W
         w0JolodpWW9iDKUFbcf5CAux3N4vQduLA/qd5sJ5nFkw7E5mISBLUooJ5+Rs5zj/mH+a
         qu1mOOZimU40xjJFEUpNMjUbYBVes7d522sLq1yjzCDEHhOP3R9ENx6/uLzKyvsxQhdI
         SGSA==
X-Gm-Message-State: AOAM533C9mLtGshqpUFhYcAHpon+WZ6JMg2DRLKSmaCGFFixq32ZrhGv
        oC1W2KyazhlI+fvJ8kf6RCWXpg==
X-Google-Smtp-Source: ABdhPJz3lO0k/8MmBGaECH28vrQgBXaTzrSnujfffItvlwzznAn3LCUQ2mYeix59JGLH13hqdqBk7Q==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr5086092otm.129.1602909508902;
        Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Thierry Reding <treding@nvidia.com>,
        Rob Clark <robdclark@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 2/3] iommu/arm-smmu-qcom: Read back stream mappings
Date:   Fri, 16 Oct 2020 21:39:06 -0700
Message-Id: <20201017043907.2656013-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm boot loader configures stream mapping for the peripherals
that it accesses and in particular it sets up the stream mapping for the
display controller to be allowed to scan out a splash screen or EFI
framebuffer.

Read back the stream mappings during initialization and make the
arm-smmu driver maintain the streams in bypass mode.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Extracted from different patch in v3.
- Now configures the stream as BYPASS, rather than translate, which should work
  for platforms with working S2CR handling as well.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index be4318044f96..0089048342dd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -23,6 +23,29 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	u32 smr;
+	int i;
+
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
+			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
+			smmu->smrs[i].valid = true;
+
+			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
+			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
+			smmu->s2crs[i].cbndx = 0xff;
+			smmu->s2crs[i].count++;
+		}
+	}
+
+	return 0;
+}
+
 static int qcom_smmu_def_domain_type(struct device *dev)
 {
 	const struct of_device_id *match =
@@ -61,6 +84,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 };
-- 
2.28.0

