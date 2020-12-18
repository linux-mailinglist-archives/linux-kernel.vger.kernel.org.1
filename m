Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEF2DE002
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbgLRIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:39:55 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:49580 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgLRIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:39:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608280769; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1FjPyQUiEQRFSNgMgFxEduBUw7HO1HzLVIZtFQNj/zM=; b=PDTCd3opIn9oD8gY206pEQOV61Ku9JT36CT4V+lLgN4P0J/A7vyd5zquoolk8YO87ikNIaI4
 IM5ojE0SC0RbSL/54ty7movyI9S9ahnlpgfi6BHiO6BI6J+3g5X0/fYXPNMCOhtO6H8IAobS
 x4h71jhq9+reUAIifdUMyERXiwc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fdc6aa60564dfefcd502cfd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 08:39:02
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90CD8C43466; Fri, 18 Dec 2020 08:39:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 696AEC433CA;
        Fri, 18 Dec 2020 08:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 696AEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org, robin.murphy@arm.com, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: [RFC PATCH 0/3] iommu: Permit modular builds of io-pgtable drivers
Date:   Fri, 18 Dec 2020 00:38:39 -0800
Message-Id: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of the Generic Kernel Image (GKI) effort is to have a common
image that works across multiple Android devices. This involves generating
a kernel image that has core features integrated into it, while SoC specific
functionality can be added to the kernel for the device as a module.

Along with modularizing IOMMU drivers, this also means building the io-pgtable
code as modules, which allows for SoC vendors to only include the io-pgtable
implementations that they use. For example, GKI for arm64 must include
support for both the IOMMU ARM LPAE/V7S formats at the moment. Having the code
for both formats as modules allows SoC vendors to only provide the page table
format that they use, along with their IOMMU driver.

Modularizing both io-pgtable.c, as well as the io-pgtable-arm[-v7s].c files,
works out rather nicely, as the main interface that clients use to interact
with the page tables is already exported (i.e. alloc_io_pgtable_ops and
free_io_pgtable_ops). It also makes it so that neither the io-pgtable-arm[-v7s]
modules or the io-pgtable modules can be unloaded without unloading the IOMMU
driver, which can only happen when there aren't any references to the IOMMU
driver module.

Thanks in advance for the feedback,

Isaac J. Manjarres

Isaac J. Manjarres (3):
  iommu/io-pgtable-arm: Prepare for modularization
  iommu/io-pgtable: Prepare for modularization
  iommu/io-pgtable: Allow building as a module

 drivers/iommu/Kconfig              | 6 +++---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
 drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
 drivers/iommu/io-pgtable.c         | 7 +++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

