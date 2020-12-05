Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4672CFF7A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 23:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLEWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 17:19:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:56475 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgLEWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 17:19:09 -0500
IronPort-SDR: uRRSXbuZ51+x58WQJkzYLgyEpwksioqhRyu2yFpxbY9WfS288dG2aSJ80u+yfrW0GUKyf9aGSX
 z8EH91R1km5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="152791254"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="152791254"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 14:18:29 -0800
IronPort-SDR: zqqrqwyBarlR0XINBBu+Ca0VvXghTsoLlMDVAcbn4NQOcemOOpPQScDPEEVlybsynO78EIabs/
 qOzKtscV2tPQ==
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="362584189"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 14:18:29 -0800
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, ravi.v.shankar@intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, ricardo.neri@intel.com, sohil.mehta@intel.com,
        Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH v2 0/3] Audit Capability and Extended Capability among IOMMUs 
Date:   Sat,  5 Dec 2020 13:57:40 -0800
Message-Id: <20201205215743.27803-1-kyung.min.park@intel.com>
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

 drivers/iommu/intel/Makefile        |   2 +-
 drivers/iommu/intel/cap_audit.c     | 219 ++++++++++++++++++++++++++++
 drivers/iommu/intel/cap_audit.h     | 132 +++++++++++++++++
 drivers/iommu/intel/iommu.c         |  85 ++---------
 drivers/iommu/intel/irq_remapping.c |   8 +
 drivers/iommu/intel/svm.c           |   3 +-
 include/linux/intel-iommu.h         |  40 ++---
 7 files changed, 395 insertions(+), 94 deletions(-)
 create mode 100644 drivers/iommu/intel/cap_audit.c
 create mode 100644 drivers/iommu/intel/cap_audit.h

-- 
2.17.1

