Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC12BBF69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgKUOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 09:03:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:14271 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgKUOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:03:56 -0500
IronPort-SDR: W8G9RPJjHArU13ndF+uwwW9xAeiXYg2TE6VV+zATXCty2FsGMC/hXuCF9vZGruyMivskK36h9Z
 6PkKhtrdBW8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158634964"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="scan'208";a="158634964"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 06:03:55 -0800
IronPort-SDR: Z2RFuzugzo4ns16V5sHEud+UIphPrk3mALkPsmg1cl7H36gFouYodR0LRGd5IFF9Rel9+rt4az
 yAGIBG/HBVcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="scan'208";a="431852752"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2020 06:03:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v9 0/4] iommu: Add support to change default domain of
Date:   Sat, 21 Nov 2020 21:56:16 +0800
Message-Id: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The description and last post of this series could be found here.

https://lore.kernel.org/linux-iommu/20200925190620.18732-1-ashok.raj@intel.com/

Change log in this series:
 1. Changes according to comments at
    https://lore.kernel.org/linux-iommu/243ce89c33fe4b9da4c56ba35acebf81@huawei.com/
    - Move the untrusted device check to iommu core
    - Remove the requirement of def_domain_type callback
 
2. Changes according to comments at
    https://lore.kernel.org/linux-iommu/20201118135153.GB2177@willie-the-truck/
    - Replace pr_err_ratelimited() with dev_err_ratelimited() for more
      context.
    - Refine the getting default domain type code.
    - Add comments about the lock mechanism (vs. device release path)
      for future reference.

    https://lore.kernel.org/linux-iommu/20201118135137.GA2177@willie-the-truck/
    - Refine the ABI document.

Best regards,
baolu

Lu Baolu (1):
  iommu: Move def_domain type check for untrusted device into core

Sai Praneeth Prakhya (3):
  iommu: Add support to change default domain of an iommu group
  iommu: Take lock before reading iommu group default domain type
  iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

 .../ABI/testing/sysfs-kernel-iommu_groups     |  29 ++
 drivers/iommu/intel/iommu.c                   |   7 -
 drivers/iommu/iommu.c                         | 255 +++++++++++++++++-
 3 files changed, 276 insertions(+), 15 deletions(-)

-- 
2.25.1

