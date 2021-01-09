Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D12EFCE4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAIBva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:51:30 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:30157 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAIBva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:51:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610157069; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ghU2g/Iny5eN7E5fSfRXmvip4hkqKRjVxmdD1byGeNg=; b=ksCG/5TgP+vNQlquw5/kSWUOOYfNrGRIAZBfmiVoPX4tXurVWewpk/o9IzKXLTP+LlhZobcm
 K6VBl4nHC02NwUeWKxY8XnJKNObWUYNRDOZ1OD+T2ZWmZO7qdrDDPhwPqLpr1xlooQAGfBxh
 03PmtXNJ86DQiNT6pK1DIWDOjp8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ff90bf2d84bad354727cadd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Jan 2021 01:50:42
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89015C43464; Sat,  9 Jan 2021 01:50:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50452C433CA;
        Sat,  9 Jan 2021 01:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50452C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
        pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Optimize iommu_map_sg() performance
Date:   Fri,  8 Jan 2021 17:50:26 -0800
Message-Id: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu_map_sg() code currently iterates through the given
scatter-gather list, and in the worst case, invokes iommu_map()
for each element in the scatter-gather list, which calls into
the IOMMU driver through an indirect call. For an IOMMU driver
that uses a format supported by the io-pgtable code, the IOMMU
driver will then call into the io-pgtable code to map the chunk.

Jumping between the IOMMU core code, the IOMMU driver, and the
io-pgtable code and back for each element in a scatter-gather list
is not efficient.

Instead, add a map_sg() hook in both the IOMMU driver ops and the
io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
map_sg() hook with the entire scatter-gather list, which can call
into the io-pgtable map_sg() hook, which can process the entire
scatter-gather list, signficantly reducing the number of indirect
calls, and jumps between these layers, boosting performance.

On a system that uses the ARM SMMU driver, and the ARM LPAE format,
the current implementation of iommu_map_sg() yields the following
latencies for mapping scatter-gather lists of various sizes. These
latencies are calculated by repeating the mapping operation 10 times:

    size        iommu_map_sg latency
      4K            0.624 us
     64K            9.468 us
      1M          122.557 us
      2M          239.807 us
     12M         1435.979 us
     24M         2884.968 us
     32M         3832.979 us

On the same system, the proposed modifications yield the following
results:

    size        iommu_map_sg latency
      4K            3.645 us
     64K            4.198 us
      1M           11.010 us
      2M           17.125 us
     12M           82.416 us
     24M          158.677 us
     32M          210.468 us

The procedure for collecting the iommu_map_sg latencies is
the same in both experiments. Clearly, reducing the jumps
between the different layers in the IOMMU code offers a
signficant performance boost in iommu_map_sg() latency.

Thanks,
Isaac

Isaac J. Manjarres (5):
  iommu/io-pgtable: Introduce map_sg() as a page table op
  iommu/io-pgtable-arm: Hook up map_sg()
  iommu/io-pgtable-arm-v7s: Hook up map_sg()
  iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
  iommu/arm-smmu: Hook up map_sg()

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c    | 90 +++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        | 86 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c                 | 25 ++++++++--
 include/linux/io-pgtable.h            |  6 +++
 include/linux/iommu.h                 | 13 +++++
 6 files changed, 234 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

