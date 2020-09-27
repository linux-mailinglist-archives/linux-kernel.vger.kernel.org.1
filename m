Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2B279EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgI0Gku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:40:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:35933 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgI0Gkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:40:49 -0400
IronPort-SDR: q9E0pFWu8j41mxoD+a5yQKBYva+Yk/wfnXuFVqjdC3aiMDszIi+36zmNsH+6Dlx2crfyPy2/uU
 jB37DqMHoInw==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141863643"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="141863643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 23:40:49 -0700
IronPort-SDR: BcD1OrQHfpsDohmg8zEQeY/oyfp6Yvh2Q4v/w6YCEht/PqSE8MrvvNg8OhReoQQwT6f09GASjt
 oqbuR5dl6czA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="349457807"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 23:40:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
Date:   Sun, 27 Sep 2020 14:34:30 +0800
Message-Id: <20200927063437.13988-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The previous post of this series could be found here.

https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/

This version introduce a new patch [4/7] to fix an issue reported here.

https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/

There aren't any other changes.

Please help to test and review.

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
 drivers/iommu/intel/iommu.c                   | 901 +++---------------
 include/linux/dma-iommu.h                     |   8 +
 include/linux/iommu.h                         |   1 +
 6 files changed, 336 insertions(+), 808 deletions(-)

-- 
2.17.1

