Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077BA2C1FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgKXI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:28:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:63905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKXI20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:28:26 -0500
IronPort-SDR: vhPNlxumuJeqYDAvh1DTIn0B2mn2k9HLNffDftmjcSjCSw+QTTBGA2scYTElnjmpp0tyDFbNoQ
 xyt2G0Kwx48w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171129615"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="171129615"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 00:28:26 -0800
IronPort-SDR: iGp5OK58xZilO/6G6DWOPCXNle4Qu9YVrluFKdklXDXJFfadBNXQWRp+WIWoBOhYAz9VfhPjvH
 7gpF/wwMfYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="432539680"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 00:28:23 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 0/7] Convert the intel iommu driver to the dma-iommu api
Date:   Tue, 24 Nov 2020 16:20:50 +0800
Message-Id: <20201124082057.2614359-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

The v5 of this series could be found here.

https://lore.kernel.org/linux-iommu/20201120101719.3172693-1-baolu.lu@linux.intel.com/

Changes in this version:
- Rebase the series to the latest iommu/next branch.
  https://lore.kernel.org/linux-iommu/20201123100816.GA26619@infradead.org/ 

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
 drivers/iommu/dma-iommu.c                     | 227 ++++-
 drivers/iommu/intel/Kconfig                   |   1 +
 drivers/iommu/intel/iommu.c                   | 904 +++---------------
 include/linux/dma-iommu.h                     |   8 +
 include/linux/iommu.h                         |   1 +
 6 files changed, 335 insertions(+), 811 deletions(-)

-- 
2.25.1

