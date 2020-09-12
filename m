Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB98F26777E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 05:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgILD2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 23:28:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:27600 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgILD2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 23:28:15 -0400
IronPort-SDR: TN2EQYeWQLgwyU8dpKwrw1DUjVIW5EQn0aX/VCDpmHyuF4oWNrbDCmv8MyMCXLINMmtWO1AOHu
 sshP4FRI5DZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="223074010"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="223074010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 20:28:05 -0700
IronPort-SDR: vAnIu1Sv+EC2IcfvY8nEZeyNa/WSeMrZVFkDgx7RL++t/LyKAc6WdQoss2M0CYiDmJF740nZKt
 oOow2M0qgWOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="408321391"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2020 20:28:01 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu api
Date:   Sat, 12 Sep 2020 11:21:54 +0800
Message-Id: <20200912032200.11489-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Murphy has almost done all the work. His latest patch series was
posted here.

https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/

Thanks a lot!

This series is a follow-up with below changes:

1. Add a quirk for the i915 driver issue described in Tom's cover
letter.
2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
bounce buffers" to make the bounce buffer work for untrusted devices.
3. Several cleanups in iommu/vt-d driver after the conversion.

Please review and test.

Best regards,
baolu

Lu Baolu (2):
  iommu: Add quirk for Intel graphic devices in map_sg
  iommu/vt-d: Cleanup after converting to dma-iommu ops

Tom Murphy (4):
  iommu: Handle freelists when using deferred flushing in iommu drivers
  iommu: Add iommu_dma_free_cpu_cached_iovas()
  iommu: Allow the dma-iommu api to use bounce buffers
  iommu/vt-d: Convert intel iommu driver to the iommu ops

 .../admin-guide/kernel-parameters.txt         |   5 -
 drivers/iommu/dma-iommu.c                     | 229 ++++-
 drivers/iommu/intel/Kconfig                   |   1 +
 drivers/iommu/intel/iommu.c                   | 885 +++---------------
 include/linux/dma-iommu.h                     |   8 +
 include/linux/iommu.h                         |   1 +
 6 files changed, 323 insertions(+), 806 deletions(-)

-- 
2.17.1

