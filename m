Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDA274B09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVVUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:20:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:47227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVVUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:20:50 -0400
IronPort-SDR: fpuJoTrJBxQjwgCXu6c+Wefbi+N9vsNtXN0935BSo26+54VXsUtz8NeV04rLplwxCxQ3trzacH
 Fb9zzvtCnpPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158093404"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="158093404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 14:20:49 -0700
IronPort-SDR: F5jcSKWyUM+mVFsGRH8HH9aEu9+OgFxKJvBk9m3GXgSeIxhLPZ9PkEhJGVvIWSwDKps5sHhRJW
 JNN0wWnEP7Gg==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="511368011"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 14:20:49 -0700
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        sohil.mehta@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH 0/4] Audit Capability and Extended Capability among IOMMUs
Date:   Tue, 22 Sep 2020 14:02:36 -0700
Message-Id: <20200922210240.27178-1-kyung.min.park@intel.com>
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

