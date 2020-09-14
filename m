Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2D2685B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgINHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgINHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:23:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22CDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:23:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so11832257pfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FgYJJ59Xq6gP9NQOhQuV3NPG4SMshHnKOvl37XR57Lg=;
        b=ALCuuDTCtnPChypI77VManpug+BEsagYoWT+KEAHORA/1P+QrrUxiNNAJFMdfgEnEr
         zqpmfXqDzDMhYJwyeyhWYi8cQCJbRyKNErkealPqobOMABvkZFzfrNSmPMCOCo+WyUIG
         dFkLXiDMDbcAd3zJQ5BE4OZr/nc7CM4s0ZMks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FgYJJ59Xq6gP9NQOhQuV3NPG4SMshHnKOvl37XR57Lg=;
        b=agLJEgA7ICSQ1GvjGRJygNfmTVTl8eHxb8qF5qYZ6WtGcWBgvWCS7pow91raAY7bJv
         5eUdKGvPy6ecHBughH023W2UyrBm6MyETn++Kk5S/IGmOqZOjzuy/T+Bt3CfKYZREFXt
         7ncfnJjjHXSYTuN/mI4RSTeshbekSENnJTlJCbj8RPBT3wXIViWPiSrp9OnnLWnwYFO6
         3lzX6UUe2+azxWifB8FGz5jHtHLZuCMNAhWwYtAATCMouJdMSM5XQn7LpXUiuZXNq3SK
         IDvuE/aoqBTUsUw2NpsYrFpOylKKCbnD3iBnIUNGy571pXvRCObiTYVvWkM1yUAPHvXn
         E+tw==
X-Gm-Message-State: AOAM530UEwLGNm+pvCcGpn1gWlIheG3cYUHFj9w7oEiRw+6l43uPCfh0
        GwPtKwHdpXpyjEZs3ikDoAENJw==
X-Google-Smtp-Source: ABdhPJzwO0XCFMYQ+LPRxhAGL7kKJAYluHoXtdQmAfZmBI5GxErXjKfeazcrGKA97FK2ZccycGRY1A==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr12319563pfk.32.1600068225293;
        Mon, 14 Sep 2020 00:23:45 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z11sm9573077pfc.181.2020.09.14.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 00:23:44 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Date:   Mon, 14 Sep 2020 12:53:19 +0530
Message-Id: <20200914072319.6091-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IOVA reserve failure in the case when address of first memory region
listed in dma-ranges is equal to 0x0.

Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
Changes from v2:
   Modify error message with useful information based on Bjorn's comments.

Changes from v1:
   Removed unnecessary changes based on Robin's review comments.

 drivers/iommu/dma-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..5b9791f35c5e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -217,9 +217,11 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
+		} else if (end < start) {
 			/* dma_ranges list should be sorted */
-			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			dev_err(&dev->dev,
+				"Failed to reserve IOVA [%#010llx-%#010llx]\n",
+				start, end);
 			return -EINVAL;
 		}
 
-- 
2.17.1

