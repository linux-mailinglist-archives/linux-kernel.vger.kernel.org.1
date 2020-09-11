Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54E265A59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKHTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:19:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD4FC061757;
        Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fa1so1285866pjb.0;
        Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cGYTBEv6g30jYHt4cdTq/c1g79ggDOFP0r3LMo62bBA=;
        b=gqFXSJCchjmN+3IhIFj8p5RjLbBWt/19Ys9tktWnFE1eEYnt5q5iGnWHNhTMks+iqK
         b0NCEBV+tmQh/qf0Vap62vKCEX4BiEdJqWk/0fNXjsQjtqoje3xQ8tD64tNaCXhJGZEN
         +PdbkA+U6zcv69VRmd5Y7nB1UikA1Yd7/vUljAwpV1R0Cav2OxkSBA368tZa0/2lPNBH
         cpdQxOFw5+M4+8hVmvzVLWDp45ldlx4Zinyz/n9mG+uxuZczKE7TAl2YH/nYwCxTUzH0
         TDMkdYhHqMfrLRfqNJDqx2Zs6T6lnF/3y3Lo5EB+kBffm4tefn7oUQtp/pO+/Poix78v
         CRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cGYTBEv6g30jYHt4cdTq/c1g79ggDOFP0r3LMo62bBA=;
        b=iDyqqMQhUvZ4IjClYSvHdC5kFOElrI+W2MWkY8JnbbNONDELiT6NtTKdXYah6AST2C
         ks5+bZ3M37jY0PbYBRZbSp1gTtUq/3ODLEWsqS6c8HQaS0KROX0swdwutHeZ85X1w6zB
         OcgdttXek5HBPHljxFoKwrnOhJhb/AbMttdiI6yUgRITEdGHYtu9pb9rs22EC1vPXxyr
         2SmFXEnj4vFETAabLJVEr/D68GM96MqBGq2YPCHWqLkPiGfk1FHRt0ekx6iaDmoKcIU1
         luS25g5BNJbB+utZzVIBB4kk12V4sm1G9DQodcdXCjl4Fsln6y4OVSBlWPH89kk3Nqja
         Ze7g==
X-Gm-Message-State: AOAM530KuA+4amMy02ZpCefPeHjXykPnMT6DIZvcwUpd3bMCjI48IdQ1
        aiN9RxVRqQNszkGwWARg2H8=
X-Google-Smtp-Source: ABdhPJysb3zMsd21LwFN+cGxUyxUozexoZzDRQwFqu8uNQaMf6bEjsdKUDDmuSmGaf7sFabYFoiIwA==
X-Received: by 2002:a17:90a:ea0c:: with SMTP id w12mr1003887pjy.65.1599808740186;
        Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com
Subject: [PATCH 2/3] iommu/tegra-smmu: Fix iova->phys translation
Date:   Fri, 11 Sep 2020 00:16:42 -0700
Message-Id: <20200911071643.17212-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOVA might not be always 4KB aligned. So tegra_smmu_iova_to_phys
function needs to add on the lower 12-bit offset from input iova.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 789d21c01b77..50b962b0647e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -795,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return SMMU_PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
-- 
2.17.1

