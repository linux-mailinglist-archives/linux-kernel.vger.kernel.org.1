Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B53045A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393323AbhAZRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:46:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:7329 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389656AbhAZIRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:17:42 -0500
IronPort-SDR: WhJ5/kB2Tgb541Udojk1eA3Pz2YsL3G5E0uZSEFSv8fDdAn9/5cVLONbx0wDiVShIyraK411cW
 RYW9x0+xvkUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179946984"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179946984"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:15:50 -0800
IronPort-SDR: e/fSyhZG9rDLlzvsJ06TPGj1CGwEPgtCmI6wdhztK1UOLumOcWYbdeQoT5D2oXfTs96ru2V7wO
 PXhHWzlhzsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577725446"
Received: from allen-box.sh.intel.com ([10.239.159.128])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2021 00:15:48 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Some misc tweaks in SVA
Date:   Tue, 26 Jan 2021 16:07:28 +0800
Message-Id: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes some misc tweaks in the VT-d SVA implementation. I will
plan them for v5.12 if no objections.

Change log:
v1->v2:
  - v1:
    https://lore.kernel.org/linux-iommu/20210121014505.1659166-1-baolu.lu@linux.intel.com/
  - Keep the logic of clearing PRO sane
  - Drop the device outstanding PRQ number patch. Need more test and
    will repost later. 

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Clear PRQ overflow only when PRQ is empty
  iommu/vt-d: Use INVALID response code instead of FAILURE

 drivers/iommu/intel/svm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.25.1

