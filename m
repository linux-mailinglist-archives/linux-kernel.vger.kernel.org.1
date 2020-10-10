Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8772289F50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgJJIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 04:24:16 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:20769 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgJJITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:19:51 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:58 +0800
Received: from localhost.localdomain (114.242.250.7) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:56 +0800
From:   FelixCuioc <FelixCui-oc@zhaoxin.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <CobeChen-oc@zhaoxin.com>, <RaymondPang-oc@zhaoxin.com>,
        <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH v3 2/2] iommu/vt-d:Add support for probing ACPI device in RMRR
Date:   Sat, 10 Oct 2020 04:02:41 -0400
Message-ID: <20201010080241.14642-3-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
References: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [114.242.250.7]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After acpi device in RMRR is detected,it is necessary
to establish a mapping for these devices.
In acpi_device_create_direct_mappings(),create a mapping
for the acpi device in RMRR.
Add a helper to achieve the acpi namespace device can
access the RMRR region.

Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  6 ++++++
 include/linux/iommu.h       |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 594b2f29c043..a0fe867aa1f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4844,6 +4844,21 @@ static int __init platform_optin_force_iommu(void)
 	return 1;
 }
 
+static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
+{
+	struct iommu_group *group;
+
+	acpi_device->bus->iommu_ops = &intel_iommu_ops;
+	group = iommu_group_get(pn_dev);
+	if (!group) {
+		pr_warn("ACPI name space devices create direct mappings wrong!\n");
+		return -EINVAL;
+	}
+	__acpi_device_create_direct_mappings(group, acpi_device);
+
+	return 0;
+}
+
 static int __init probe_acpi_namespace_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -4858,6 +4873,7 @@ static int __init probe_acpi_namespace_devices(void)
 			struct acpi_device_physical_node *pn;
 			struct iommu_group *group;
 			struct acpi_device *adev;
+			struct device *pn_dev = NULL;
 
 			if (dev->bus != &acpi_bus_type)
 				continue;
@@ -4868,6 +4884,7 @@ static int __init probe_acpi_namespace_devices(void)
 					    &adev->physical_node_list, node) {
 				group = iommu_group_get(pn->dev);
 				if (group) {
+					pn_dev = pn->dev;
 					iommu_group_put(group);
 					continue;
 				}
@@ -4876,7 +4893,19 @@ static int __init probe_acpi_namespace_devices(void)
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
+				pn_dev = pn->dev;
+			}
+			if (!pn_dev) {
+				dev->bus->iommu_ops = &intel_iommu_ops;
+				ret = iommu_probe_device(dev);
+				if (ret) {
+					pr_err("acpi_device probe fail! ret:%d\n", ret);
+					goto unlock;
+				}
+				goto unlock;
 			}
+			ret = acpi_device_create_direct_mappings(pn_dev, dev);
+unlock:
 			mutex_unlock(&adev->physical_node_lock);
 
 			if (ret)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6d847027d35e..ffd470297ea6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 	return false;
 }
 
+void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
+{
+	iommu_create_device_direct_mappings(group, acpi_device);
+}
+EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 82876f682367..bfc46e538c29 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -516,6 +516,8 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
+extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
+						 struct device *acpi_device);
 
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
-- 
2.17.1

