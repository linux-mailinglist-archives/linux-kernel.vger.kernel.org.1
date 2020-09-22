Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE1273AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIVGSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:18:38 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:17441 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgIVGSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:18:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600755517; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Fm7wlYfhgVMZejk/GgfLZ8aRZKX8FVfC6swIamjl3hY=; b=RHrQzAFaJScOemvOJ0fe1QGwL2CK7p0iXYrc3YVGK2PEFKXnCXS/ZgVx3gap1NzGQevVHBmf
 rX9ImS5lvfBD5PImaCVv3DWTP7U69qfkNYhOSZ4WX8//hYd8EyrWZeLSc76m6F9ArFGb3KZN
 99RJDTyH9FGCts8t9Hz1+v40O18=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f69973a36c8ce93e83b9ef4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 06:18:34
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3727CC433A0; Tue, 22 Sep 2020 06:18:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 048F3C433C8;
        Tue, 22 Sep 2020 06:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 048F3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv5 0/6] System Cache support for GPU and required SMMU support
Date:   Tue, 22 Sep 2020 11:48:13 +0530
Message-Id: <cover.1600754909.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware variants contain a system cache or the last level
cache(llc). This cache is typically a large block which is shared
by multiple clients on the SOC. GPU uses the system cache to cache
both the GPU data buffers(like textures) as well the SMMU pagetables.
This helps with improved render performance as well as lower power
consumption by reducing the bus traffic to the system memory.

The system cache architecture allows the cache to be split into slices
which then be used by multiple SOC clients. This patch series is an
effort to enable and use two of those slices perallocated for the GPU,
one for the GPU data buffers and another for the GPU SMMU hardware
pagetables.

Patch 1 - Patch 4 adds system cache support in SMMU and GPU driver.
Patch 5 and 6 are minor cleanups for arm-smmu impl.

The series is based on top of https://gitlab.freedesktop.org/drm/msm/-/tree/msm-next-pgtables

Changes in v5:
 * Drop cleanup of blank lines since it was intentional (Robin)
 * Rebase again on top of msm-next-pgtables as it moves pretty fast

Changes in v4:
 * Drop IOMMU_SYS_CACHE prot flag
 * Rebase on top of https://gitlab.freedesktop.org/drm/msm/-/tree/msm-next-pgtables

Changes in v3:
 * Fix domain attribute setting to before iommu_attach_device()
 * Fix few code style and checkpatch warnings
 * Rebase on top of Jordan's latest split pagetables and per-instance
   pagetables support

Changes in v2:
 * Addressed review comments and rebased on top of Jordan's split
   pagetables series

Sai Prakash Ranjan (4):
  iommu/io-pgtable-arm: Add support to use system cache
  iommu/arm-smmu: Add domain attribute for system cache
  iommu: arm-smmu-impl: Use table to list QCOM implementations
  iommu: arm-smmu-impl: Add a space before open parenthesis

Sharat Masetty (2):
  drm/msm: rearrange the gpu_rmw() function
  drm/msm/a6xx: Add support for using system cache(LLC)

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 83 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 17 +++++
 drivers/gpu/drm/msm/msm_drv.c              |  8 +++
 drivers/gpu/drm/msm/msm_drv.h              |  1 +
 drivers/gpu/drm/msm/msm_gpu.h              |  5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 14 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 17 +++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 drivers/iommu/io-pgtable-arm.c             |  7 +-
 include/linux/io-pgtable.h                 |  4 ++
 include/linux/iommu.h                      |  1 +
 12 files changed, 152 insertions(+), 10 deletions(-)


base-commit: 115b1aca7a2a9c0649b1f5f6cffee6873c7efd89
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

