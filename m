Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6462BA75C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTKYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:24:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:17833 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKTKYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:24:41 -0500
IronPort-SDR: rPmsEcO4JtS6NAyIT5BRJKTyCNZLMKj2xp8D4yoQ77IiG0/6V8a9a1ZUEpuMZ5e3qgcxcSJyWA
 hPJ237ZDVdew==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="150717589"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="150717589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 02:24:40 -0800
IronPort-SDR: 82QxPtX+MY911QEA499NebKqFnj+SlZcS99DH6LeAs3dgNH7zKJTQsnslR1nDiVgejQHrsD/kK
 j9ionfDGToUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="545393633"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2020 02:24:37 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/7] Convert the intel iommu driver to the dma-iommu api
Date:   Fri, 20 Nov 2020 18:17:12 +0800
Message-Id: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

The previous post of this series could be found here.

https://lore.kernel.org/linux-iommu/20200927063437.13988-1-baolu.lu@linux.intel.com/

Changes in this version:
- Add Tested-by: Logan Gunthorpe <logang@deltatee.com>
- Rebase to v5.10-rc3

Please review and consider it for iommu/next.

Best regards,
baolu

Lu Baolu (3):
  iommu: Add quirk for Intel graphic devices in map_sg
  iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
  iommu/vt-d: Cleanup after converting to dma-iommu ops

Tom Murphy (4):
  iommu: Handle freelists when using deferred flushing in iommu drivers
  iommu: Add iommu_dma_free_cpu_cached_iovas()
  iommu: Allow the dma-iommu api to use bounce buffers
  iommu/vt-d: Convert intel iommu driver to the iommu ops

 .../admin-guide/kernel-parameters.txt         |   5 -
 drivers/iommu/dma-iommu.c                     | 228 ++++-
 drivers/iommu/intel/Kconfig                   |   1 +
 drivers/iommu/intel/iommu.c                   | 905 +++---------------
 include/linux/dma-iommu.h                     |   8 +
 include/linux/iommu.h                         |   1 +
 6 files changed, 336 insertions(+), 812 deletions(-)

-- 
2.25.1

