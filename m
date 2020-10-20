Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBB290FAA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436786AbgJQFyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436778AbgJQFyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:54:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA5C05BD24
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m11so4465228otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5h+bbZ9M5fVwhu8jO4jzrcPr8WfAxCzDHuzDwBdlOrk=;
        b=rNHXsdBXLEHyHI2RbtLF4V+RV3DtpvRb55vdaj+0vbcqNM3iyJrndgp4TiL+sSOfr3
         e0AsYtelaC5wjEzt3FP+QWDpBfk/IvCsu1QMR0dv59joHCX27jyqDodIs2L+Ckt2iwQh
         qWLIpwZTrZLpYr1AHQ7yp3zDLplJzgbWJreLhb7rZoRCc1jCPqZj/5xnwNCKjSHIjrrV
         b4Ga8ECvvDh71PkhkS0unaGFnITr5MaQUms98vloSxXVwu85ZDSMFW3jB3gmdWR6W1q9
         c7mCK5R8pvCK6yklNFi3KTy6sBzqws49gVUJ1bj6ZlYLJue4pB5ca9tewh9hEtYo+ikp
         yMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5h+bbZ9M5fVwhu8jO4jzrcPr8WfAxCzDHuzDwBdlOrk=;
        b=t7+tLexxzc2MnfucuBqrATp2/Rg68SnDftWbRcm/OMZeGbY5ARrYsaAhhQzLqwZoKv
         /76rPFHdD3ai4F1gcguPk0lQP5bljm4MOvYSZ3fMH9aXyXGoIRmLv7ITmCbg9uwFxJeE
         U4drL7rRofxriRN1dshvnXjTN1AZ6QxmvLv0ZSxKTNLpKKs93z7rnd1VcPmnAmChQ+o4
         UYxcip85AjAhJB7fswvWm8iJbkGpoAnS0FJE2e+wyI0ANRvzG1++35iz9OdA+a+ZVbY3
         GnFuZ25tM+xg9UXV1ZVv4Mr4OTygwvIyG6QY30ta+xk4pCpXtY3uIXb0YdcuXorhwXJk
         jmsg==
X-Gm-Message-State: AOAM533mSi2i1RJ7a2bByv1aKfXkOLnAsg+XHTW7YT+snMRiAKD+kk7v
        CJhKbBz9MVPia4IXxUp9Q+SCUf5k4sbD1A==
X-Google-Smtp-Source: ABdhPJwpoWNiZybfRwwfJoWBdmsgXLsv0purd3mFs/NFe58vM0/ReOn+i8TlD+wvf2c+ue4teZCHtQ==
X-Received: by 2002:a9d:3ee5:: with SMTP id b92mr5112404otc.156.1602909507748;
        Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
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
Subject: [PATCH v4 1/3] iommu/arm-smmu: Allow implementation specific write_s2cr
Date:   Fri, 16 Oct 2020 21:39:05 -0700
Message-Id: <20201017043907.2656013-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware found in some Qualcomm platforms intercepts writes to the
S2CR register in order to replace the BYPASS type with FAULT. Further
more it treats faults at this level as catastrophic and restarts the
device.

Add support for providing implementation specific versions of the S2CR
write function, to allow the Qualcomm driver to work around this
behavior.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- New patch

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 22 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dad7fa86fbd4..ed3f0428c110 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -929,14 +929,20 @@ static void arm_smmu_write_smr(struct arm_smmu_device *smmu, int idx)
 static void arm_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 {
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
-	u32 reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
-		  FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
-		  FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
-
-	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
-	    smmu->smrs[idx].valid)
-		reg |= ARM_SMMU_S2CR_EXIDVALID;
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
+	u32 reg;
+
+	if (smmu->impl && smmu->impl->write_s2cr) {
+		smmu->impl->write_s2cr(smmu, idx);
+	} else {
+		reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, s2cr->type) |
+		      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, s2cr->cbndx) |
+		      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
+
+		if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
+		    smmu->smrs[idx].valid)
+			reg |= ARM_SMMU_S2CR_EXIDVALID;
+		arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
+	}
 }
 
 static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 1a746476927c..b71647eaa319 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -436,6 +436,7 @@ struct arm_smmu_impl {
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);
+	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.28.0

