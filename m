Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB562E6D95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgL2D0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:26:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:39935 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgL2D0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:26:17 -0500
IronPort-SDR: 26fqxSic8V5xj7znyXqQWw4Ikt6V3VNQ2qR+XC8YkOHiy3xmJRxCq0O5WpTc42gXgdAaCsnibP
 Hjo5tgiQSCrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261204029"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261204029"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 19:25:37 -0800
IronPort-SDR: /8e8CaXnujQmaeiR61yr/eq8PqFVnJF/uypGEQMAk9nOqBPyV98vpee9o6OG9PQkUmVjAUas9z
 m3dLjbr8JX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="392962405"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2020 19:25:34 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, jun.j.tian@intel.com,
        yi.y.sun@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iommu/vt-d: Misc fixes on scalable mode
Date:   Tue, 29 Dec 2020 11:25:10 +0800
Message-Id: <20201229032513.486395-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu, Joerg, Will,

This patchset aims to fix a bug regards to native SVM usage, and
also several bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

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

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info
  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

 drivers/iommu/intel/iommu.c | 148 ++++++++++++++++++++++++++----------
 drivers/iommu/intel/svm.c   |   9 ++-
 include/linux/intel-iommu.h |  18 +++--
 3 files changed, 125 insertions(+), 50 deletions(-)

-- 
2.25.1

