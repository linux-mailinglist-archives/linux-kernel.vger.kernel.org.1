Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A244E20580F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbgFWQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:57:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:50069 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbgFWQ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:57:30 -0400
IronPort-SDR: lJ8uqz6bdiWfYv8QJhe1G9+jzhRuaFqrxAz61WH4tRdwaqqHtxIgeOXFN6N57nTm5ScM5kXSOG
 Z12NcUFIJ0cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205653749"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="205653749"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:57:28 -0700
IronPort-SDR: szCn53MB1Uk1N0/XTJ4rc7Lm5QLlMGsD4yOrTHf5MiOjm5hzM90eV5u32GK6v2Rl/VSvUagQAg
 Au0OlEPdxhqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="452290890"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 09:57:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 0/5] IOMMU user API enhancement
Date:   Tue, 23 Jun 2020 10:03:52 -0700
Message-Id: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

Future extensions are likely to support more architectures and vIOMMU features.

In the previous discussion, using user-filled data size and feature flags is
made a preferred approach over a unified version number.
https://lkml.org/lkml/2020/1/29/45

In addition to introduce argsz field to data structures, this patchset is also
trying to document the UAPI design, usage, and extension rules. VT-d driver
changes to utilize the new argsz field is included, VFIO usage is to follow.

Thanks,

Jacob


Changeog:
v3:
	- Rewrote backward compatibility rule to support existing code
	  re-compiled with newer kernel UAPI header that runs on older
	  kernel. Based on review comment from Alex W.
	  https://lore.kernel.org/linux-iommu/20200611094741.6d118fa8@w520.home/
	- Take user pointer directly in UAPI functions. Perform argsz check
	  and copy_from_user() in IOMMU driver. Eliminate the need for
	  VFIO or other upper layer to parse IOMMU data.
	- Create wrapper function for in-kernel users of UAPI functions
v2:
	- Removed unified API version and helper
	- Introduced argsz for each UAPI data
	- Introduced UAPI doc

Jacob Pan (5):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Use named union for user data
  iommu/uapi: Handle data and argsz filled by users
  iommu/uapi: Support both kernel and user unbind guest PASID

 Documentation/userspace-api/iommu.rst | 244 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c           |  24 ++--
 drivers/iommu/intel/svm.c             |   5 +-
 drivers/iommu/iommu.c                 | 138 +++++++++++++++++--
 include/linux/iommu.h                 |  20 ++-
 include/uapi/linux/iommu.h            |  10 +-
 6 files changed, 413 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

