Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E78266A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgIKV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgIKV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 17:56:08 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92DC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so7532346pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7BjSVtSDf909ReswhXA+neV/Kc6sD4bi71wx2N5H7LU=;
        b=A8C+o+2fd8UsmwGVQND5DGvINunw0u7Dvp69GukWmaRVU8xVfnKpMMNTRwvGxX6qIx
         vTnQk02zBTtODhO0Cg11VU+E+zQmJK7GUowXrTHH88wY8oiyLsgMrCdiPSVhLOTm+ZFf
         LjClNr82QTpY8pFxaD7UTNolbP6HEK/84d942CI8nVbJzPr9dgcv6rNccexNn/MUHLWr
         QqRv9JqKMScsV/eb2B3dUAEcyX/gQX8ziyd3Qq/XgRrdWGfIx7CWBgsbcK2WW3grL1Hr
         AF9G+nCkyUkqMQb5SRLAX7UfRPWqF5Kzm0O7hyAkFS3JNvkxaTczL9cP3ofJKSPcDtv6
         JKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7BjSVtSDf909ReswhXA+neV/Kc6sD4bi71wx2N5H7LU=;
        b=T93Ce3RqYm/tzwPo9u3fMjc9oVXFnzjJ/lly4uDvqEpObouLo37xASRFEU57GvNN9A
         0NlyJWda0gdFTJDcPDFvh5NRfzMjyshtziCWYA2Ds7nAm2w5smkE7S4Ne8bgvGIrQzny
         gAvaLpWvFBG/psidBbDjtUkVy+Jt4asjdk+gsGfmSIXu2sRm5U7NBL6lWjfjF2XOalrv
         oYYa7zFe96gbzuD6j1b+fDsUIMjYkWAsah6eYKc7v9O7jWSCZboBNZGmBK9JX88SJzOA
         Wbk1ji493vt475dCQ9a0kXE4RJKzvSb3zhqnGw1yinrp3kfUPWrZAvV2ccJUhkXutsve
         215A==
X-Gm-Message-State: AOAM532jkIayLj/5PheUeHf88t3g6FrHKI5c05Qgo8ZpJyFcC12VF2Ha
        je1CoUpn57fNn1wf7bePDpKougdHEHw=
X-Google-Smtp-Source: ABdhPJxmwvCOhFLYI0HlF/wSBPLrK9ZM65jAoxM3LpnoRR+ftotb/M9S41OFO4PhAkpKeOz+04dVFg==
X-Received: by 2002:a65:5689:: with SMTP id v9mr3203008pgs.271.1599861367361;
        Fri, 11 Sep 2020 14:56:07 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id e62sm3171586pfh.76.2020.09.11.14.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 14:56:06 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>
Subject: [PATCH v9 0/7] IOMMU user API enhancement
Date:   Fri, 11 Sep 2020 14:57:49 -0700
Message-Id: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

This set is available at:
https://github.com/jacobpan/linux.git vsva_v5.9_uapi_v9

Thanks,

Jacob


Changelog:
v9
	- Directly pass PASID value to iommu_sva_unbind_gpasid() without
	  the superfluous data in struct iommu_gpasid_bind_data.
v8
	- Rebased to v5.9-rc2
	- Addressed review comments from Eric Auger
	  1. added a check for the unused vendor flags
	  2. commit message improvements
v7
	- Added PASID data format enum for range checking
	- Tidy up based on reviews from Alex W.
	- Removed doc section for vIOMMU fault handling
v6
	- Renamed all UAPI functions with iommu_uapi_ prefix
	- Replaced argsz maxsz checking with flag specific size checks
	- Documentation improvements based on suggestions by Eric Auger
	  Replaced example code with a pointer to the actual code
	- Added more checks for illegal flags combinations
	- Added doc file to MAINTAINERS
v5
	- Addjusted paddings in UAPI data to be 8 byte aligned
	- Do not clobber argsz in IOMMU core before passing on to vendor driver
	- Removed pr_warn_ for invalid UAPI data check, just return -EINVAL
	- Clarified VFIO responsibility in UAPI data handling
	- Use iommu_uapi prefix to differentiate APIs has in-kernel caller
	- Added comment for unchecked flags of invalidation granularity
	- Added example in doc to show vendor data checking

v4
	- Added checks of UAPI data for reserved fields, version, and flags.
	- Removed version check from vendor driver (vt-d)
	- Relaxed argsz check to match the UAPI struct size instead of variable
	  union size
	- Updated documentation

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


Jacob Pan (7):
  docs: IOMMU user API
  iommu/uapi: Add argsz for user filled data
  iommu/uapi: Introduce enum type for PASID data format
  iommu/uapi: Use named union for user data
  iommu/uapi: Rename uapi functions
  iommu/uapi: Handle data and argsz filled by users
  iommu/vt-d: Check UAPI data processed by IOMMU core

 Documentation/userspace-api/iommu.rst | 211 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/iommu/intel/iommu.c           |  25 ++--
 drivers/iommu/intel/svm.c             |  13 ++-
 drivers/iommu/iommu.c                 | 201 ++++++++++++++++++++++++++++++--
 include/linux/iommu.h                 |  35 ++++--
 include/uapi/linux/iommu.h            |  25 ++--
 7 files changed, 468 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst

-- 
2.7.4

