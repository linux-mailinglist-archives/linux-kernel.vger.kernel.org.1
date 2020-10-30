Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3934E29FBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgJ3C6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:23856 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgJ3C6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:14 -0400
IronPort-SDR: 8pzFZLV2sq89oGv9vud7RKdOK+VM/7o00yDjZ6acixqrKLF9vE7w303y+aO5jcivaL4cQUrfBB
 64g4GdZTHYiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156326125"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="156326125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 19:58:13 -0700
IronPort-SDR: FD/AEwI0yVS5kY8jkVsWhYxD2oP8AKjMoLYNqDloNC5pFCqe/e5bkDF8HinCaODScUxx1yVJ9a
 zbAebystXiHg==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="469374387"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.144.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 29 Oct 2020 19:58:11 -0700
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        jean-philippe@linaro.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.l.liu@intel.com, jacob.jun.pan@linux.intel.com,
        Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v2 0/2] iommu: Fix a few issues related to PRQ
Date:   Fri, 30 Oct 2020 10:37:22 +0800
Message-Id: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a few issues about PRQ. So, two patches are cooked to
fix them. Please have a review. Thanks!

Changes from v1:
================
- Modify subject of patch 1 to make it more accurate.
- Move get_domain_info() up to the sanity check part in patch 1.
- Remove v1 patch 2 which is not suitable.
- Add description for current patch 2.
- Add 'Fixes:' tags for all patches.

Liu Yi L (1):
  iommu/vt-d: Fix sid not set issue in in intel_svm_bind_gpasid()

Liu, Yi L (1):
  iommu/vt-d: Fix a bug for PDP check in prq_event_thread

 drivers/iommu/intel/svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

