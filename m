Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB65727B89A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgI2AEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgI2AEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:04:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A30C0613D3;
        Mon, 28 Sep 2020 17:04:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1649314pjd.4;
        Mon, 28 Sep 2020 17:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ak7Ng8aJusKwlu1ow/SGyHutH7FZzRbWyWxzcNaToBI=;
        b=vbseF/dDrAqieP+HHCdB/1SnSYVNo3zR6H+rhRZjZ/4Gx7/U4Y2+ufZJpr2BSv1Fat
         gUXB23PctE6Upb6vW/JvVAQ5+KNFIS3DYgf0U/Kpq7Gqe/RuLjZ5Vo4jXkWyhi0sBBf6
         W8h7SKzGfg8ucM42yXjkr0MHprAr/mTGCQ0G6pZtRSIpiL8T5n2ogFE89dhm0CuAWN3G
         cvbPtyBHgLQpXkR53MYF+ORl8csy28N3OGDUu7xjVRgjuGaFVxxPkbYlJCQJynK0CQ0L
         050Xz1YJH4w5cG/YTbNttIFyX+UhhbUNzGH+yBEJfJm7KuYFQAuu6lyYfAadHjyTJ5Cl
         mavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ak7Ng8aJusKwlu1ow/SGyHutH7FZzRbWyWxzcNaToBI=;
        b=RcnNLWGl2n+P4W2DW7m7U0I+oqNK2rHub3xjpE1UvzGv4k/psmWLsyiGA18DGrs8oY
         L3DKzec/JL/SuAYifQ8ox8U8MU5FwqvJjBG4ltlqWufGN9nj5Fu8sCHXzPP9OMtuECQJ
         rSP/9qa+ZmE4Hidp/L5GHpR0f30DVaZlijgmq/X8UG6iiNfe108Th1ov3m/5SCBBhhwW
         R54l2PQ9wqyZyuoIKT7sSRixedcFhMFWeOp+CN/Y3mj7lKoxwDzMpXVMfapzmaHn0YiE
         wOP+pFi3kuGveGmgT4ZqV2Lh8dWgMfP7IuVss4ePkfSrNG/YgGjsuLGeGjjjvMNw/f0m
         da6Q==
X-Gm-Message-State: AOAM530TqskXLa5xPQge5QrtLqXl9upuWWIYhRGJGAfX6aQ4VTDZikNQ
        YCOvg1COFPMieOQgSKLt+Bw=
X-Google-Smtp-Source: ABdhPJzfftLBnioepcruORsOFCylGetHbEudyK5hBpQ88TcFkWVYtcbyVEOPUO8lQZO4e54kAnFQLg==
X-Received: by 2002:a17:90a:ed88:: with SMTP id k8mr1391123pjy.232.1601337887889;
        Mon, 28 Sep 2020 17:04:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id fz23sm2392814pjb.36.2020.09.28.17.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:04:47 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iommu/tegra-smmu: Expend mutex protection range
Date:   Mon, 28 Sep 2020 16:59:01 -0700
Message-Id: <20200928235901.28337-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928235901.28337-1-nicoleotsuka@gmail.com>
References: <20200928235901.28337-1-nicoleotsuka@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to protect potential race condition at use_count.
since probes of client drivers, calling attach_dev(), may run
concurrently.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2:
 * N/A

 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ec4c9dafff95..acda5902e095 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -256,26 +256,19 @@ static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
 {
 	unsigned long id;
 
-	mutex_lock(&smmu->lock);
-
 	id = find_first_zero_bit(smmu->asids, smmu->soc->num_asids);
-	if (id >= smmu->soc->num_asids) {
-		mutex_unlock(&smmu->lock);
+	if (id >= smmu->soc->num_asids)
 		return -ENOSPC;
-	}
 
 	set_bit(id, smmu->asids);
 	*idp = id;
 
-	mutex_unlock(&smmu->lock);
 	return 0;
 }
 
 static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 {
-	mutex_lock(&smmu->lock);
 	clear_bit(id, smmu->asids);
-	mutex_unlock(&smmu->lock);
 }
 
 static bool tegra_smmu_capable(enum iommu_cap cap)
@@ -420,17 +413,21 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as)
 {
 	u32 value;
-	int err;
+	int err = 0;
+
+	mutex_lock(&smmu->lock);
 
 	if (as->use_count > 0) {
 		as->use_count++;
-		return 0;
+		goto err_unlock;
 	}
 
 	as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
 				  DMA_TO_DEVICE);
-	if (dma_mapping_error(smmu->dev, as->pd_dma))
-		return -ENOMEM;
+	if (dma_mapping_error(smmu->dev, as->pd_dma)) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
 
 	/* We can't handle 64-bit DMA addresses */
 	if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
@@ -453,24 +450,35 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	as->smmu = smmu;
 	as->use_count++;
 
+	mutex_unlock(&smmu->lock);
+
 	return 0;
 
 err_unmap:
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+err_unlock:
+	mutex_unlock(&smmu->lock);
+
 	return err;
 }
 
 static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 				    struct tegra_smmu_as *as)
 {
-	if (--as->use_count > 0)
+	mutex_lock(&smmu->lock);
+
+	if (--as->use_count > 0) {
+		mutex_unlock(&smmu->lock);
 		return;
+	}
 
 	tegra_smmu_free_asid(smmu, as->id);
 
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
 
 	as->smmu = NULL;
+
+	mutex_unlock(&smmu->lock);
 }
 
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
-- 
2.17.1

