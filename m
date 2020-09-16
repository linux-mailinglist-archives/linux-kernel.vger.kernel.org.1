Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6950226B7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgIPA2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIPA1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 20:27:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C1C06174A;
        Tue, 15 Sep 2020 17:27:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so2938185pfi.4;
        Tue, 15 Sep 2020 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=urfxkx3OR1ztSEhIX65Ge5+NGsQrAveOSK0sp6kZKXA=;
        b=dgWQy05zNJUnJvdQqHziPnzCh1nOaOEkOIssdUMkSvRCWew96H4adTWK60g/pm4qZQ
         NYiKNAzKZABBY0/LzblOnFVWhWQ2vmDzS4VCTOqJNj8szJmfa4ByQDh8KUsvGXTmb/YY
         UMAsrscS3qmBifIWXzTBrLvGRWSqqS7jdaxn7vcJFriKvPSTt/qAbbTxm9LULoDDX7CG
         ezHNrTiQHjWfecw0wEMmmXoFDz6OK3ZmnEBs56AgWQVmoVrJ+keEMt7BYEDeL4XXD1sN
         HUdw1Z3Md6aehMprn8wdEctTiLn6ci3yK0NSztkSNn4LUD6EJe81JGkRTYKkwM14wual
         jBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=urfxkx3OR1ztSEhIX65Ge5+NGsQrAveOSK0sp6kZKXA=;
        b=dC4OrSVvRSnAoFCwVzLonNWlTL0r3B1/Ycg5O0fstkB+sYHXfjkeKJjbwgLJAYobqa
         N9u44bv0bKUEEzABSOdVPBjYb4T+98obFZBSUeC5J6eiynUuhgYlmoLwzHX4DtKgoTp5
         Am5JB3bV0GwJRqoyeWGsTmvZckMBv+v6gMLTBY6EGTIBeKWK09jpIUpNoRztDcgjWq06
         YrmE0UdSzHf2Chr8T/wTg2q0A1Fg5y6UGrmemhzsT0swltPRmSMjF2ufWTv883lx9EHr
         TJZwdzEkdFFMAXwYd7FeoY99uy/QXfpS6IBScXGLJtf3TlBlePn1cq97Hj9oHHWiN7Nr
         nJxA==
X-Gm-Message-State: AOAM532j+aigN7b4sRxF63J2kdw6wqjxEm56CfobLM6053oZtVQEj2so
        34N6LOniazVs5GkQPOJ6Glk=
X-Google-Smtp-Source: ABdhPJxqZUpJ2KjMHLyoOyJyyeAlMxBIRQdOJAjBKieBwezCDHtwFX49SqsG8HhjDN98jhf4PbJ5ag==
X-Received: by 2002:a05:6a00:1507:b029:13e:d13d:a13c with SMTP id q7-20020a056a001507b029013ed13da13cmr20277411pfu.36.1600216022778;
        Tue, 15 Sep 2020 17:27:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s66sm14876761pfc.159.2020.09.15.17.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 17:27:02 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com
Subject: [PATCH] iommu/tegra-smmu: Fix tlb_mask
Date:   Tue, 15 Sep 2020 17:23:59 -0700
Message-Id: <20200916002359.10823-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "num_tlb_lines" might not be a power-of-2 value, being 48 on
Tegra210 for example. So the current way of calculating tlb_mask
using the num_tlb_lines is not correct: tlb_mask=0x5f in case of
num_tlb_lines=48, which will trim a setting of 0x30 (48) to 0x10.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 84fdee473873..0becdbfea306 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1120,7 +1120,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
-	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
+	smmu->tlb_mask = (1 << fls(smmu->soc->num_tlb_lines)) - 1;
 	dev_dbg(dev, "TLB lines: %u, mask: %#lx\n", smmu->soc->num_tlb_lines,
 		smmu->tlb_mask);
 
-- 
2.17.1

