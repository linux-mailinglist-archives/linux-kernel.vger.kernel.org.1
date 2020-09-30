Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB427F685
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgJAALz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:11:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:47606 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgJAALy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:11:54 -0400
IronPort-SDR: 567a9nzYM/EcQMCZpRB739eDj7AJtzy3N/doT9OuclelLIVUDgp+my5I/G8Hmd3l5TDt7lNeCC
 ERhmQXJyvHGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="162639990"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="162639990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:53 -0700
IronPort-SDR: 4R3BVebGzy45SAg5UmoEuqws7o6A/pzDV/eMbxD6JOlYwo9zf93OGFUDzgrW9SirHQ1+z8GsbP
 B2peItqXGUiA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="500276811"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:11:52 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, kyung.min.park@intel.com
Subject: [RESEND PATCH 0/4] Audit Capability and Extended Capability among IOMMUs
Date:   Wed, 30 Sep 2020 16:53:05 -0700
Message-Id: <20200930235309.22841-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern platforms have more than one IOMMU. Each IOMMU has its own
feature set. Some of these features must be consistent among IOMMUs.
Otherwise, these differences can lead to improper behavior in the system.
On the other hand, for some features, each IOMMU can have different
capacity values. So, different actions are required to deal with the
inconsistencies depending on the IOMMU features.

Currently, some inconsistencies are ignored by the IOMMU driver.
This patchset checks IOMMU capabilities and extended capabilities
centralizedly during boot and take different actions according to
the impacts caused by the mismatches.

For example:
 1. Disable Shared Virtual Memory.
 2. Use common capacity values (normally the lowest capacity value) for
    all IOMMUs.
 3. Report feature mismatches.

Detailed information on the IOMMU Capability / Extended Capability can
be found in Intel VT-d Specification.

Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Kyung Min Park (4):
  iommu/vt-d: Disable SVM in the platform when IOMMUs have
    inconsistencies
  iommu/vt-d: Report out when IOMMU features have inconsistencies
  iommu/vt-d: Audit IOMMUs for Interrupt Remapping features
  iommu/vt-d: Scale capability to the lowest supported between the
    IOMMUs

 drivers/iommu/intel/Makefile        |   4 +-
 drivers/iommu/intel/audit.c         | 193 ++++++++++++++++++++++++++++
 drivers/iommu/intel/audit.h         | 103 +++++++++++++++
 drivers/iommu/intel/iommu.c         |  12 +-
 drivers/iommu/intel/irq_remapping.c |   8 ++
 include/linux/intel-iommu.h         |   3 +
 6 files changed, 320 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/intel/audit.c
 create mode 100644 drivers/iommu/intel/audit.h

-- 
2.17.1

