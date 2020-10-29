Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9DA29EBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgJ2MZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:25:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgJ2MZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:25:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCPLg3082772;
        Thu, 29 Oct 2020 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=qVA/rW4VkvAMJ7tAUahvZVt4U+nmW5aRDWzpgV0tBX0=;
 b=yaU1RBFXJ+aR7oXUO7WC9tdgzUQXRfakJzQq6i/ZBV4anbPuyqPqEZElHiCLg5vzakka
 NQiPAgEkF7QBCZ00N52mMd9T8S9Bm3gICj2M/pwnMEt2paoH6LthoKy6zaTMSZ1SbQAQ
 bCQvgEZMhbuC/hMbeJHnm5jWr7Rn2htarMAj0ERrXD+Rur1TGNM+/DbVwi3AV+M8B96b
 ZO/0TnGybj25Vgn1A85tkHnEUnBGT066Jq9iGzSx2/n8hlEkc+6uYS/5UmOf9BRoSC+x
 kzuGQwgQFydrIc8MejQ7DklxouTwweyHhHn/OTRGPU1bEntj2qq0HlvudGofaLkyjQUC hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7m4gpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 12:25:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCAW5E063054;
        Thu, 29 Oct 2020 12:25:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34cwupqgpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 12:25:53 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TCPpJZ000866;
        Thu, 29 Oct 2020 12:25:51 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 05:25:51 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 4/4] misc/pvpanic: add new pvpanic pci driver
Date:   Thu, 29 Oct 2020 13:43:07 +0200
Message-Id: <1603971787-16784-5-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
References: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

Add new pvpanic pci driver to pvpanic driver framework.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/Kconfig       | 10 ++++++-
 drivers/misc/pvpanic/Makefile      |  1 +
 drivers/misc/pvpanic/pvpanic-pci.c | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/pvpanic/pvpanic-pci.c

diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
index 0c0c0b2..866cb37 100644
--- a/drivers/misc/pvpanic/Kconfig
+++ b/drivers/misc/pvpanic/Kconfig
@@ -1,6 +1,6 @@
 config PVPANIC
 	tristate "pvpanic device support"
-	depends on HAS_IOMEM && (ACPI || OF)
+	depends on HAS_IOMEM && (ACPI || OF || PCI)
 	help
 	  This driver provides support for the pvpanic device.  pvpanic is
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
@@ -23,4 +23,12 @@ config PVPANIC_OF
 	  This driver is one specific driver for pvpanic driver framework.
 	  It provides a mmio device as pvpanic device.
 
+config PVPANIC_PCI
+	tristate "pvpanic pci driver"
+	depends on PCI
+	default PVPANIC
+	help
+	  This driver is one specific driver for pvpanic driver framework.
+	  It provides a pci device as pvpanic device.
+
 endif
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
index ffd11b1..45d0a60 100644
--- a/drivers/misc/pvpanic/Makefile
+++ b/drivers/misc/pvpanic/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_PVPANIC)            += pvpanic.o
 obj-$(CONFIG_PVPANIC_ACPI)       += pvpanic-acpi.o
 obj-$(CONFIG_PVPANIC_OF)         += pvpanic-of.o
+obj-$(CONFIG_PVPANIC_PCI)        += pvpanic-pci.o
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
new file mode 100644
index 00000000..1261710
--- /dev/null
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  pvpanic acpi driver.
+ *
+ *  Copyright (C) 2019 ZTE Ltd.
+ *  Author: Peng Hao <peng.hao2@zte.com.cn>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include "pvpanic.h"
+
+#define PCI_VENDOR_ID_REDHAT             0x1b36
+#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0101
+
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC),},
+	{}
+};
+
+static int pvpanic_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	int ret;
+	struct resource res;
+
+	ret = pcim_enable_device(pdev);
+	if (ret < 0)
+		return ret;
+
+	memset(&res, 0, sizeof(res));
+	res.start = pci_resource_start(pdev, 0);
+	res.end = pci_resource_end(pdev, 0);
+	res.flags = IORESOURCE_MEM;
+	ret = pvpanic_add_device(&pdev->dev, &res);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void pvpanic_pci_remove(struct pci_dev *pdev)
+{
+	pvpanic_remove_device();
+}
+
+static struct pci_driver pvpanic_pci_driver = {
+	.name =         "pvpanic-pci",
+	.id_table =     pvpanic_pci_id_tbl,
+	.probe =        pvpanic_pci_probe,
+	.remove =       pvpanic_pci_remove,
+};
+
+module_pci_driver(pvpanic_pci_driver);
-- 
1.8.3.1

