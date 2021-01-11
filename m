Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B702F18CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbhAKOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:17 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:62425 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhAKOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610376896; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JnBbZxRF3zkY63N32iw+S1nZmnw8Y5p/1yS9PAvI0Fg=; b=XlVVPXkTOgztMHgGJLHCAJxJcjULTEGuVyAhfOzo5wGUHftdeM1m2Bj97RhD1/trL+bTj/My
 1fwn+NzcVdZYF8JiOGoArJTEh6K5SBh74Lwdz05ANTMKAlIPK2w4Q8V/zO5k9OAghlnXIRQR
 ExQybx1VHUM0GiREH8VnQOH29Eg=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ffc66a58fb3cda82ff04a0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 14:54:29
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEAD3C433ED; Mon, 11 Jan 2021 14:54:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CC79DC433C6;
        Mon, 11 Jan 2021 14:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC79DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
        pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Optimize iommu_map_sg() performance
Date:   Mon, 11 Jan 2021 06:54:17 -0800
Message-Id: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
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

Changes since v1:

-Fixed an off by one error in arm_[lpae/v7s]_map_by_pgsize
when checking if the IOVA and physical address ranges being
mapped are within the appropriate limits.
-Added Sai Prakash Ranjan's "Tested-by" tag.

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

