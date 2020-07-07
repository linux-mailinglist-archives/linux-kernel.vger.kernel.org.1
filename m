Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0462162CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 02:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGAGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 20:06:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:18972 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgGGAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:06:17 -0400
IronPort-SDR: Rm6VZ2RgrznLhz1acNMP/IRW74eCf07b3VNKRnPRGDmp39+298Eiabrx3aUcDK68M5721O7ag7
 Wr+qzj/7VT7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212492286"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212492286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:06:17 -0700
IronPort-SDR: VrRVTkhV5Kkl8bkovYinkC2tlC80oMlpdIW65zKC5YQI3igcyF+gPzRtvI0VC5fV63kTqJQJIj
 sogfGByOhuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456913803"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 17:06:17 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/7] iommu/vt-d: Misc tweaks and fixes for vSVA
Date:   Mon,  6 Jul 2020 17:12:47 -0700
Message-Id: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu and all,

This is a series to address some of the issues we found in vSVA support.
Most of the patches deal with exception handling, we also removed some bits
that are not currently supported.

Many thanks to Kevin Tian's review.

Jacob & Yi


Changelog:
v4	Address reviews from Eric Auger
	- Additional warning for unaligned mask and address in guest IOTLB
	  invalidation
	- Comments rewrite and code simplification
v3
	- Use pr_err instead of WARN() for invalid user address range (6/7)
	- Fix logic in PASID selective devTLB flush (3/7)

v2 Address reviews from Baolu
	- Fixed addr field in devTLB flush (5/7)
	- Assign address for single page devTLB invalidation (4/7)
	- Coding style tweaks


Jacob Pan (4):
  iommu/vt-d: Remove global page support in devTLB flush
  iommu/vt-d: Fix PASID devTLB invalidation
  iommu/vt-d: Warn on out-of-range invalidation address
  iommu/vt-d: Disable multiple GPASID-dev bind

Liu Yi L (3):
  iommu/vt-d: Enforce PASID devTLB field mask
  iommu/vt-d: Handle non-page aligned address
  iommu/vt-d: Fix devTLB flush for vSVA

 drivers/iommu/intel/dmar.c  | 24 +++++++++++++++++++-----
 drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 drivers/iommu/intel/svm.c   | 22 +++++++++-------------
 include/linux/intel-iommu.h |  5 ++---
 5 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.7.4

