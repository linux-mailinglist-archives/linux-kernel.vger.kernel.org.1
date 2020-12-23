Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBA2E18EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgLWG2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:28:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:26586 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgLWG2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:28:18 -0500
IronPort-SDR: d4OcOXKsNcWeBD0NdpXiA+8dT2IwPl6KCWbstGx/c1HyfcdmcmptnTBWT1GoJlioasfP+kp7/W
 SZ9X5OM9tDZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="175193444"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="175193444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 22:27:37 -0800
IronPort-SDR: ipOPRoLKMqQ1PrvKHXtDvFixq5dER7SZRJf4GEUYfTEfruPizqCNMqRfhy+5ET0xw7LykzMO/R
 bkIVBkTZ4BVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="338703477"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com) ([10.238.156.135])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2020 22:27:34 -0800
From:   Liu Yi L <yi.l.liu@intel.com>
To:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        jacob.jun.pan@linux.intel.com
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, yi.l.liu@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iommu/vt-d: Misc fixes on scalable mode
Date:   Wed, 23 Dec 2020 14:27:17 +0800
Message-Id: <20201223062720.29364-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to fix a bug regards to native SVM usage, and
also several bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info
  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

 drivers/iommu/intel/iommu.c | 158 +++++++++++++++++++++++++++---------
 drivers/iommu/intel/svm.c   |   9 +-
 include/linux/intel-iommu.h |  18 ++--
 3 files changed, 135 insertions(+), 50 deletions(-)

-- 
2.25.1

