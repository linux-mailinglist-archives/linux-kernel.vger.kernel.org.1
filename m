Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3641D2B394C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 22:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgKOVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 16:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 16:00:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A23C0613CF;
        Sun, 15 Nov 2020 13:00:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so16595481wrr.13;
        Sun, 15 Nov 2020 13:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dLbdlp0c1Ky6bbcCd24/KxFE5FORT9BDtA7PPhpTLOo=;
        b=H57uoI271DVrV5SOv66p1juq12QoiklfYiJ2DppioVUMislwiPtIMyWpnVgqwa1/EV
         RHbSIN363vSAOIgYjofzLMINtndhGBOrWZIc5vc7moMGOcstRRKC/vF2ub84anqgGV0w
         W4zKkqlg6I0povJE3Ai5WJCSJ5K56NDM8SVusJdseqg5CeqbwE/7Kfukh7babvJ6JZK3
         MnIrHD7VZnct1j9NqsqJp/uMV4NLzLY/oP9VThux85SIbk3yX91NPadjcKyylxTdzvDm
         0PNOCjiakgy+aPvzmsJP46f5d9spQL6SBzEvc8P/Tr80HlwJuftvjLjY833172Ox9TAd
         Q3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dLbdlp0c1Ky6bbcCd24/KxFE5FORT9BDtA7PPhpTLOo=;
        b=F0Ux8PMyJ9D3vS1VITyt0A+doVV9uvy5IC/kGoztDcfU80HfbGgCryLPzo1FHG5JVQ
         q5n9PjtiLR97A9smGAaTWFv7IJW0QwSaF2FwZ51a7vXtWqrg1BGGfZR0kY6yP3Dl50Nv
         kEbpX9cc0vD7/vVbqemqWboWy320vdWwGq5yD6STjEhE7UHlIQid6mRvJg+48VRwLdGG
         WkfZCe/VF9VkIZ836Rk4TYJNO8HXGA20C6flKLYAwClCvjqm/XNozGMf98xeesrLsrUX
         Hca9GMSHJyKmbeqVNWzTCvTVbgKsw3xzAvklfFHjRG5MWDYumXBQK35NiAiRdXsXr9QY
         Imgg==
X-Gm-Message-State: AOAM533dLk9YNFOyccaJ/Ho0m9a7KL2BROUVVrKgFfBwXF6jjm7eW5tN
        dnMJ67auBLmocTxKi5gW2To=
X-Google-Smtp-Source: ABdhPJymqYAPnQftYmMxIKdNayAHJvCUYEkaHGB07m5wX9ik0olWdfP8ekTGsX8ar28q89N9UBSaVw==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr15984730wrl.415.1605473999601;
        Sun, 15 Nov 2020 12:59:59 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d94:6d00:d052:40da:8fc9:54db])
        by smtp.gmail.com with ESMTPSA id d16sm19845364wrw.17.2020.11.15.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:59:58 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM
Date:   Sun, 15 Nov 2020 21:59:51 +0100
Message-Id: <20201115205951.20698-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
introduced intel_iommu_sva_invalidate() when CONFIG_INTEL_IOMMU_SVM.
This function uses the dedicated static variable inv_type_granu_table
and functions to_vtd_granularity() and to_vtd_size().

These parts are unused when !CONFIG_INTEL_IOMMU_SVM, and hence,
make CC=clang W=1 warns with an -Wunused-function warning.

Include these parts conditionally on CONFIG_INTEL_IOMMU_SVM.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201113

Liu Yi L, Jakob Pan, Lu Baolu, please ack.

Joerg, please pick this minor non-urgent clean-up patch.

 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c6622011d493..7b32703c0b47 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5386,6 +5386,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
 	aux_domain_remove_dev(to_dmar_domain(domain), dev);
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
 /*
  * 2D array for converting and sanitizing IOMMU generic TLB granularity to
  * VT-d granularity. Invalidation is typically included in the unmap operation
@@ -5432,7 +5433,6 @@ static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
 	return order_base_2(nr_pages);
 }
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 static int
 intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			   struct iommu_cache_invalidate_info *inv_info)
-- 
2.17.1

