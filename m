Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266842ECB17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbhAGHvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 02:51:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:19927 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbhAGHvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:51:05 -0500
IronPort-SDR: eLwwUoXWwgwoAOVxq9oIr4EzqeFqJ8hMI59vHK/DfH/9IM1qveAiRvj3WTxGNX3lsX7Sxwpp0p
 iLI3Sb2Ecs9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="156577776"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="156577776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 23:50:24 -0800
IronPort-SDR: 9YdZFIBcPf8U4ESpvdlwqFf73EDaS3lYkTKtl77/RxxXueoBQdik4LGfqBIvnbSHTrGj4EoBQb
 pzIepB77KerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="351169562"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev2.bj.intel.com) ([10.238.156.135])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2021 23:50:15 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, yi.l.liu@intel.com, dan.carpenter@oracle.com
Subject: [PATCH v4 0/3] iommu/vt-d: Misc fixes on scalable mode
Date:   Thu,  7 Jan 2021 00:03:54 +0800
Message-Id: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu, Joerg, Will,

This patchset aims to fix a bug regards to native SVM usage, and
also two bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

v3 -> v4:
- Address comments from Baolu Lu and add acked-by
- Fix issue reported by "Dan Carpenter" and "kernel test robot"
- Add tested-by from Guo Kaijie on patch 1/3
- Rebase to 5.11-rc2
v3: https://lore.kernel.org/linux-iommu/20201229032513.486395-1-yi.l.liu@intel.com/

v2 -> v3:
- Address comments from Baolu Lu against v2
- Rebased to 5.11-rc1
v2: https://lore.kernel.org/linux-iommu/20201223062720.29364-1-yi.l.liu@intel.com/

v1 -> v2:
- Use a more recent Fix tag in "iommu/vt-d: Move intel_iommu info from struct intel_svm to struct intel_svm_dev"
- Refined the "iommu/vt-d: Track device aux-attach with subdevice_domain_info"
- Rename "iommu/vt-d: A fix to iommu_flush_dev_iotlb() for aux-domain" to be
  "iommu/vt-d: Fix ineffective devTLB invalidation for subdevices"
- Refined the commit messages
v1: https://lore.kernel.org/linux-iommu/20201220000352.183523-1-yi.l.liu@intel.com/

Regards,
Yi Liu

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info
  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

 drivers/iommu/intel/iommu.c | 148 ++++++++++++++++++++++++++++++++------------
 drivers/iommu/intel/svm.c   |   9 +--
 include/linux/intel-iommu.h |  18 ++++--
 3 files changed, 125 insertions(+), 50 deletions(-)

-- 
2.7.4

