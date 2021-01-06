Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1788F2EB7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbhAFBwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:52:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:48745 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbhAFBwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:52:30 -0500
IronPort-SDR: lymGc/azJ1Bw0jNC1sLRfzpOTSlWWZibAYIg/j8jTdS2WME2annbYYXQ/cP98QOMnAKJOnOMSu
 shhto7fgklBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="156402495"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="156402495"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:51:50 -0800
IronPort-SDR: QAz4tl1dFNjrArGzYCE5AHO5KTudeizzxbVy8iC428crbeCWwOJyZFIKy98Bp4egqnENnYdf5A
 B0rKwgZhMc3g==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="361387904"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 17:51:49 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, ricardo.neri@intel.com, ravi.v.shankar@intel.com,
        kevin.tian@intel.com, ashok.raj@intel.com, sohil.mehta@intel.com,
        kyung.min.park@intel.com
Subject: [PATCH v4 0/3] Audit Capability and Extended Capability among IOMMUs 
Date:   Tue,  5 Jan 2021 17:30:32 -0800
Message-Id: <20210106013035.6476-1-kyung.min.park@intel.com>
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

ChangeLog:
- Change from v3 to v4:
  1. fix the build error for when only enabled irq remapping.
- Change from v2 to v3:
  1. fix the wrong macro names and rebase to v5.10.
- Change from v1 to v2:
  1. Add missing cap/ecaps for audit.
  2. Refactor function/macros overal suggested by Lu, Baolu.
  2. Skip audit for gfx dedicated IOMMU.
  3. Change commit message.

Kyung Min Park (3):
  iommu/vt-d: Audit IOMMU Capabilities and add helper functions
  iommu/vt-d: Move capability check code to cap_audit files
  iommu/vt-d: Disable SVM in the platform when IOMMUs have
    inconsistencies

 drivers/iommu/intel/Makefile        |   4 +-
 drivers/iommu/intel/cap_audit.c     | 219 ++++++++++++++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 132 +++++++++++++++++
 drivers/iommu/intel/iommu.c         |  85 ++---------
 drivers/iommu/intel/irq_remapping.c |   8 +
 drivers/iommu/intel/svm.c           |   3 +-
 include/linux/intel-iommu.h         |  39 ++---
 7 files changed, 395 insertions(+), 95 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.17.1

