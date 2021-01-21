Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C202FDF88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436748AbhAUCY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:24:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:31113 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392998AbhAUBzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:55:31 -0500
IronPort-SDR: udIA6znfSDmRDnDEj0g/Re1S7ihFPayAs5fjuYq/rCdjoWHm2izvaY3fCCuunDAvhnJYwuXpnD
 x32MBrXIuXxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243275396"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="243275396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:53:32 -0800
IronPort-SDR: MppMeJ08UYxsSLMBQbzoQhkhOCVLYCY6ifw48dPJBnnOGHCJBGjmtUPdIkUMTRGLGw81T2ibOZ
 sg11M0rsOxag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="391762240"
Received: from allen-box.sh.intel.com ([10.239.159.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2021 17:53:30 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Some misc tweaks in SVA
Date:   Thu, 21 Jan 2021 09:45:02 +0800
Message-Id: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes some misc tweaks in the VT-d SVA implementation. I will
plan them for v5.12 if no objections.

Best regards,
baolu

Lu Baolu (3):
  iommu/vt-d: Add rate limited information when PRQ overflows
  iommu/vt-d: Allow devices to have more than 32 outstanding PRQ
  iommu/vt-d: Use INVALID response code instead of FAILURE

 drivers/iommu/intel/iommu.c |  3 ++-
 drivers/iommu/intel/svm.c   | 19 +++++++++----------
 include/linux/intel-svm.h   |  5 +++++
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.25.1

