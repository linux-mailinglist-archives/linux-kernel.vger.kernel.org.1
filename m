Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6742C26E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbgKXNNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:13:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:18489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbgKXNNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:13:31 -0500
IronPort-SDR: 9oZuV1t/H3r8rXJukP2GR85GrDTvR0i4ehccCnWZkzfkt+srmKpqrtMSBoTo4F5xbFJ2P61zvP
 JGj/Qf4dSFGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172037938"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172037938"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:13:30 -0800
IronPort-SDR: /4IoJzqUjN2RdAup2H1oyId6005W/Kv4m0xbrbJMXI/GRTCPdzd4uyEzSO414ugG9+jphPwYrO
 J36B2FgvuyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="432602175"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 05:13:28 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v10 0/4] iommu: Add support to change default domain of an iommu group
Date:   Tue, 24 Nov 2020 21:06:00 +0800
Message-Id: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The last post of this series:

https://lore.kernel.org/linux-iommu/20201121135620.3496419-1-baolu.lu@linux.intel.com/

Change log in this series:
 1. Changes according to comments at
    https://lore.kernel.org/linux-iommu/20201123120449.GB10233@willie-the-truck/
    - Remove the unnecessary iommu_get_mandatory_def_domain_type()

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
 drivers/iommu/iommu.c                         | 248 +++++++++++++++++-
 3 files changed, 267 insertions(+), 17 deletions(-)

-- 
2.25.1

