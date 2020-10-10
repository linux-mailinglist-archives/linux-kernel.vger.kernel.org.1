Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD23289F62
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgJJIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 04:32:41 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:20625 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgJJISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:18:38 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2020 04:18:37 EDT
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:55 +0800
Received: from localhost.localdomain (114.242.250.7) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:53 +0800
From:   FelixCuioc <FelixCui-oc@zhaoxin.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <CobeChen-oc@zhaoxin.com>, <RaymondPang-oc@zhaoxin.com>,
        <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH v3 0/2] Add support for ACPI device in RMRR
Date:   Sat, 10 Oct 2020 04:02:39 -0400
Message-ID: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.242.250.7]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS allocate reserved memory ranges that may be DMA targets.
BIOS may report each such reserved memory region through the
RMRR structures,along with the devices that requires access to
the specified reserved memory region.

The purpose of this series is to achieve ACPI device in RMRR
access reserved memory.Therefore,it is necessary to increase
the analysis of acpi device in RMRR and establish a mapping
for this device.

The first patch adds interfaces for detecting ACPI device
in RMRR and in order to distinguish it from pci device,
some interface functions are modified.

The second patch adds support for probing ACPI device in RMRR.
In probe_acpi_namespace_devices(),add support for direct mapping
of ACPI device and add support for physical node of acpi device
to be NULL.

v2->v3:
   - Add the blank line between functions.
   - Make dmar_acpi_insert_dev_scope() bool,change the 1/0 to true/false
     and add a comment explaining.
   - Delete unused initialization.
   - if dmar_acpi_insert_dev_scope() always returns zero,will not
     call dmar_rmrr_add_acpi_dev().
   - Use a proper error code.
   - Use if(!pdev).
   - Use goto unlock instead of mutex_unlock().


FelixCuioc (2):
  iommu/vt-d:Add support for detecting ACPI device in RMRR
  iommu/vt-d:Add support for probing ACPI device in RMRR

 drivers/iommu/intel/dmar.c  | 76 +++++++++++++++++++++----------------
 drivers/iommu/intel/iommu.c | 52 ++++++++++++++++++++++++-
 drivers/iommu/iommu.c       |  6 +++
 include/linux/dmar.h        | 12 +++++-
 include/linux/iommu.h       |  2 +
 5 files changed, 113 insertions(+), 35 deletions(-)

-- 
2.17.1

