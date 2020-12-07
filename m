Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDF2D0E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLGKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:19 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20200 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgLGKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:16 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AZNE5029451;
        Mon, 7 Dec 2020 02:41:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=C0rWzlAmBSFxbD0cf8qFiC3epv+wwPBdHYI2eJ6k6j8=;
 b=eaA1osbAdGiAsyAnq+7Jj01DfIif0mJOSU/TIYrebztDUiohJjhv3JnfymInn8Sy12iP
 bisktA2mdnyOOT4FmCdzMHxm29ESweT3lSjZUqWfgCR+3bE0qqzszEhRMJswfwH4zAGE
 LSpw7czmfhMkT1jqyqWjrcFRPjEyuW8/IU8QE39wFUNPUKmSOrsg/LstsnOogBNoixzT
 oFDT8Ttft2FiuNLH2I4d12hOf99q8eylrPfJA1HPP/S2GXODbXWNLa7rI7lc5i45wcNS
 Z9i6RDSvpaMB2my0zPvuqbhQNG7qXp9vSWNgGI7YZOlmUpR2qKOziwzNFM91cxCz149P nQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3586p3vc2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa7D4kNPS7T/r0YgT+MDCwHw4nWySiX9XZ3Cocel874hHsmBW1GJN0pa4rV3bxW6lseVYG0jCokZk05nU7tQcbHIbwXK0MU6Eemj2vD43bMnTx9kiQlTmgSeyGdVvDGaR7Ji7B2xOVOW3WTWor2VIyXugEBc2DYNcosQgA+smI3S3UB+Blud1ZJhEq6HV0IPW4edc84U6i0wV+/Pe48ZIHPmymg13aMNfn67Je7ODxplxn1zyMm1+G+QeBOibObTrmpsLMrLpLK8+bL/RXKEO0CQDgm4izqDsoJxA0L0V6MigrcRxXfm6PRXOPDlZtN3WZA630hywVKuDysS+zTc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0rWzlAmBSFxbD0cf8qFiC3epv+wwPBdHYI2eJ6k6j8=;
 b=QnJNkyfV2Awo4tFIRsQEXuMcvt7Yos02ZyoNUagwx6HLa7y/N0ipyHVwRRejdsNvds1r3fjSIINydNK1LJgERvDh84U1Gwp4SCnKb8zSLFkGax7BSL7wRoZpWi9TNwqgX73cZdb0wpmuN4qQttFD5gAfWYZYXe0Gh0185huZvzDYzEsYIJSbt++ta2s73NmlYWOPfESrpdHpHBcVoNIRQdcuR/Nn9djAdu4Q6vD+SKfYnZZvDIDkHilXcfQ6ZMHLYlb2KjaRv/VL3RL4rbsw4BtGE+sswLKXN8tIr4Cp/LDR8EKwrW7ctvy5dcLxkEvimXRFzGOMyoJzyXj4wSix/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0rWzlAmBSFxbD0cf8qFiC3epv+wwPBdHYI2eJ6k6j8=;
 b=tM/cAuFA8B/aoZ8TCTy2ytPf5YQsEHb8yiBcQIxm2RH9BY0CQ0SijJT4Q9SgtsGE62oJ9EnnBKKkoU9W7LdxMTyqKqaUrGXwiocmtXdUQhF3iRDcqjWLYUfUV/mMqet/UpVEREyUc9L2Az4yRKNaHPhvxfiE5BJ/e1h7kO4wLPk=
Received: from MWHPR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:301:4a::24) by SN6PR07MB4238.namprd07.prod.outlook.com
 (2603:10b6:805:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 10:41:00 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::b1) by MWHPR1201CA0014.outlook.office365.com
 (2603:10b6:301:4a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 10:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:41:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuT4007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:40:59 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7Aeunh006428;
        Mon, 7 Dec 2020 11:40:56 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7AeuBO006427;
        Mon, 7 Dec 2020 11:40:56 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 02/10] usb: cdns3: Split core.c into cdns3-plat and core.c file
Date:   Mon, 7 Dec 2020 11:32:19 +0100
Message-ID: <20201207103227.606-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
References: <20201207103227.606-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4211acfa-099a-4faf-0a34-08d89a9c96b3
X-MS-TrafficTypeDiagnostic: SN6PR07MB4238:
X-Microsoft-Antispam-PRVS: <SN6PR07MB423806A5E3C6B66AE61FAB85DDCE0@SN6PR07MB4238.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n06qcJKDHapucYPtscmTFYDiF/JUWeIud5IXEyGtpBIV0L/cBaa9jdWfhO8nt24QOWAS9rtQrWcj8Aux2ZvwOhXcDnjAGP0mVgw6T/mEnlcN5MhhcvnGa2h0j5vdwrEaBmCHlZ50jWU0XjInkkHL/62N2gef4n1EyoRkeRHv0ZXpdMcjMZWuZxpEGP2RooS38+FBuhKCwQBGhVzsvmfZf7nyDp7V+p/WzgUtSqirp2mHDIgHClDBR0SxOk6gLRjCQ9MSwKDcjOJoqqsO3jz+hsnWnHcvM5o4tCSCG+W+jxvZyhyijR8jJhtnWaga84922nQccSWMJFv89V32YPJMhUYQUBd9s2h5tShC7pIet+ZvS0bQI4mTdnS0uPEx1IvuTtaBOEV9stVQzDeF0pDq3TQzr+9qHJ0BmmnyWGKD1cn6a0ozZfUdFRu0L9jdWeMH7uKvjQLmVcVo2ym3EF/y5A==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36092001)(46966005)(54906003)(34020700004)(8936002)(82310400003)(83380400001)(2616005)(7636003)(336012)(8676002)(42186006)(316002)(36906005)(426003)(26005)(478600001)(186003)(47076004)(82740400003)(1076003)(356005)(6916009)(5660300002)(2906002)(70206006)(107886003)(86362001)(30864003)(36756003)(6666004)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:41:00.6007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4211acfa-099a-4faf-0a34-08d89a9c96b3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=1
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch splits file core.c into core.c containing the common reusable code
and cnd3-plat.c containing device platform specific code. These changes
are required to make possible reuse DRD part of CDNS3 driver in CDNSP
driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Tested-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/usb/cdns3/Makefile     |   2 +-
 drivers/usb/cdns3/cdns3-plat.c | 312 +++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/core.c       | 284 +++---------------------------
 drivers/usb/cdns3/core.h       |   6 +
 drivers/usb/cdns3/drd.c        |   1 -
 drivers/usb/cdns3/drd.h        |   1 -
 6 files changed, 343 insertions(+), 263 deletions(-)
 create mode 100644 drivers/usb/cdns3/cdns3-plat.c

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index d47e341a6f39..a1fe9612053a 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -2,7 +2,7 @@
 # define_trace.h needs to know how to find our header
 CFLAGS_trace.o				:= -I$(src)
 
-cdns3-y					:= core.o drd.o
+cdns3-y					:= cdns3-plat.o core.o drd.o
 
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
new file mode 100644
index 000000000000..5dcb83af6c86
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2018-2020 Cadence.
+ * Copyright (C) 2017-2018 NXP
+ * Copyright (C) 2019 Texas Instruments
+ *
+ *
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *         Pawel Laszczak <pawell@cadence.com>
+ *         Roger Quadros <rogerq@ti.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "core.h"
+
+static int set_phy_power_on(struct cdns3 *cdns)
+{
+	int ret;
+
+	ret = phy_power_on(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
+	ret = phy_power_on(cdns->usb3_phy);
+	if (ret)
+		phy_power_off(cdns->usb2_phy);
+
+	return ret;
+}
+
+static void set_phy_power_off(struct cdns3 *cdns)
+{
+	phy_power_off(cdns->usb3_phy);
+	phy_power_off(cdns->usb2_phy);
+}
+
+/**
+ * cdns3_plat_probe - probe for cdns3 core device
+ * @pdev: Pointer to cdns3 core platform device
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource	*res;
+	struct cdns3 *cdns;
+	void __iomem *regs;
+	int ret;
+
+	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
+	if (!cdns)
+		return -ENOMEM;
+
+	cdns->dev = dev;
+	cdns->pdata = dev_get_platdata(dev);
+
+	platform_set_drvdata(pdev, cdns);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
+	if (!res) {
+		dev_err(dev, "missing host IRQ\n");
+		return -ENODEV;
+	}
+
+	cdns->xhci_res[0] = *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
+	if (!res) {
+		dev_err(dev, "couldn't get xhci resource\n");
+		return -ENXIO;
+	}
+
+	cdns->xhci_res[1] = *res;
+
+	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
+
+	if (cdns->dev_irq < 0)
+		return cdns->dev_irq;
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+	cdns->dev_regs	= regs;
+
+	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
+	if (cdns->otg_irq < 0)
+		return cdns->otg_irq;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
+	if (!res) {
+		dev_err(dev, "couldn't get otg resource\n");
+		return -ENXIO;
+	}
+
+	cdns->phyrst_a_enable = device_property_read_bool(dev, "cdns,phyrst-a-enable");
+
+	cdns->otg_res = *res;
+
+	cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
+	if (cdns->wakeup_irq == -EPROBE_DEFER)
+		return cdns->wakeup_irq;
+	else if (cdns->wakeup_irq == 0)
+		return -EINVAL;
+
+	if (cdns->wakeup_irq < 0) {
+		dev_dbg(dev, "couldn't get wakeup irq\n");
+		cdns->wakeup_irq = 0x0;
+	}
+
+	cdns->usb2_phy = devm_phy_optional_get(dev, "cdns3,usb2-phy");
+	if (IS_ERR(cdns->usb2_phy))
+		return PTR_ERR(cdns->usb2_phy);
+
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
+	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
+	if (IS_ERR(cdns->usb3_phy))
+		return PTR_ERR(cdns->usb3_phy);
+
+	ret = phy_init(cdns->usb3_phy);
+	if (ret)
+		goto err_phy3_init;
+
+	ret = set_phy_power_on(cdns);
+	if (ret)
+		goto err_phy_power_on;
+
+	ret = cdns3_init(cdns);
+	if (ret)
+		goto err_cdns_init;
+
+	device_set_wakeup_capable(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
+		pm_runtime_forbid(dev);
+
+	/*
+	 * The controller needs less time between bus and controller suspend,
+	 * and we also needs a small delay to avoid frequently entering low
+	 * power mode.
+	 */
+	pm_runtime_set_autosuspend_delay(dev, 20);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+
+err_cdns_init:
+	set_phy_power_off(cdns);
+err_phy_power_on:
+	phy_exit(cdns->usb3_phy);
+err_phy3_init:
+	phy_exit(cdns->usb2_phy);
+
+	return ret;
+}
+
+/**
+ * cdns3_remove - unbind drd driver and clean up
+ * @pdev: Pointer to Linux platform device
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_plat_remove(struct platform_device *pdev)
+{
+	struct cdns3 *cdns = platform_get_drvdata(pdev);
+	struct device *dev = cdns->dev;
+
+	pm_runtime_get_sync(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	cdns3_remove(cdns);
+	set_phy_power_off(cdns);
+	phy_exit(cdns->usb2_phy);
+	phy_exit(cdns->usb3_phy);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static int cdns3_set_platform_suspend(struct device *dev,
+				      bool suspend, bool wakeup)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (cdns->pdata && cdns->pdata->platform_suspend)
+		ret = cdns->pdata->platform_suspend(dev, suspend, wakeup);
+
+	return ret;
+}
+
+static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+	bool wakeup;
+	unsigned long flags;
+
+	if (cdns->in_lpm)
+		return 0;
+
+	if (PMSG_IS_AUTO(msg))
+		wakeup = true;
+	else
+		wakeup = device_may_wakeup(dev);
+
+	cdns3_set_platform_suspend(cdns->dev, true, wakeup);
+	set_phy_power_off(cdns);
+	spin_lock_irqsave(&cdns->lock, flags);
+	cdns->in_lpm = true;
+	spin_unlock_irqrestore(&cdns->lock, flags);
+	dev_dbg(cdns->dev, "%s ends\n", __func__);
+
+	return 0;
+}
+
+static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+	int ret;
+	unsigned long flags;
+
+	if (!cdns->in_lpm)
+		return 0;
+
+	ret = set_phy_power_on(cdns);
+	if (ret)
+		return ret;
+
+	cdns3_set_platform_suspend(cdns->dev, false, false);
+
+	spin_lock_irqsave(&cdns->lock, flags);
+	cdns3_resume(cdns, !PMSG_IS_AUTO(msg));
+	cdns->in_lpm = false;
+	spin_unlock_irqrestore(&cdns->lock, flags);
+	if (cdns->wakeup_pending) {
+		cdns->wakeup_pending = false;
+		enable_irq(cdns->wakeup_irq);
+	}
+	dev_dbg(cdns->dev, "%s ends\n", __func__);
+
+	return ret;
+}
+
+static int cdns3_plat_runtime_suspend(struct device *dev)
+{
+	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
+}
+
+static int cdns3_plat_runtime_resume(struct device *dev)
+{
+	return cdns3_controller_resume(dev, PMSG_AUTO_RESUME);
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int cdns3_plat_suspend(struct device *dev)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+
+	cdns3_suspend(cdns);
+
+	return cdns3_controller_suspend(dev, PMSG_SUSPEND);
+}
+
+static int cdns3_plat_resume(struct device *dev)
+{
+	return cdns3_controller_resume(dev, PMSG_RESUME);
+}
+#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops cdns3_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cdns3_plat_suspend, cdns3_plat_resume)
+	SET_RUNTIME_PM_OPS(cdns3_plat_runtime_suspend,
+			   cdns3_plat_runtime_resume, NULL)
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_cdns3_match[] = {
+	{ .compatible = "cdns,usb3" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_cdns3_match);
+#endif
+
+static struct platform_driver cdns3_driver = {
+	.probe		= cdns3_plat_probe,
+	.remove		= cdns3_plat_remove,
+	.driver		= {
+		.name	= "cdns-usb3",
+		.of_match_table	= of_match_ptr(of_cdns3_match),
+		.pm	= &cdns3_pm_ops,
+	},
+};
+
+module_platform_driver(cdns3_driver);
+
+MODULE_ALIAS("platform:cdns3");
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 04990812181d..7b67a7c74586 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -385,26 +385,6 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 	return ret;
 }
 
-static int set_phy_power_on(struct cdns3 *cdns)
-{
-	int ret;
-
-	ret = phy_power_on(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
-	ret = phy_power_on(cdns->usb3_phy);
-	if (ret)
-		phy_power_off(cdns->usb2_phy);
-
-	return ret;
-}
-
-static void set_phy_power_off(struct cdns3 *cdns)
-{
-	phy_power_off(cdns->usb3_phy);
-	phy_power_off(cdns->usb2_phy);
-}
 
 /**
  * cdns3_wakeup_irq - interrupt handler for wakeup events
@@ -431,16 +411,13 @@ static irqreturn_t cdns3_wakeup_irq(int irq, void *data)
 
 /**
  * cdns3_probe - probe for cdns3 core device
- * @pdev: Pointer to cdns3 core platform device
+ * @cdns: Pointer to cdnsp structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-static int cdns3_probe(struct platform_device *pdev)
+int cdns3_init(struct cdns3 *cdns)
 {
-	struct device *dev = &pdev->dev;
-	struct resource	*res;
-	struct cdns3 *cdns;
-	void __iomem *regs;
+	struct device *dev = cdns->dev;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -449,87 +426,8 @@ static int cdns3_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
-	if (!cdns)
-		return -ENOMEM;
-
-	cdns->dev = dev;
-	cdns->pdata = dev_get_platdata(dev);
-
-	platform_set_drvdata(pdev, cdns);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
-	if (!res) {
-		dev_err(dev, "missing host IRQ\n");
-		return -ENODEV;
-	}
-
-	cdns->xhci_res[0] = *res;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
-	if (!res) {
-		dev_err(dev, "couldn't get xhci resource\n");
-		return -ENXIO;
-	}
-
-	cdns->xhci_res[1] = *res;
-
-	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
-	if (cdns->dev_irq < 0)
-		return cdns->dev_irq;
-
-	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-	cdns->dev_regs	= regs;
-
-	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
-	if (cdns->otg_irq < 0)
-		return cdns->otg_irq;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
-	if (!res) {
-		dev_err(dev, "couldn't get otg resource\n");
-		return -ENXIO;
-	}
-
-	cdns->phyrst_a_enable = device_property_read_bool(dev, "cdns,phyrst-a-enable");
-
-	cdns->otg_res = *res;
-
-	cdns->wakeup_irq = platform_get_irq_byname_optional(pdev, "wakeup");
-	if (cdns->wakeup_irq == -EPROBE_DEFER)
-		return cdns->wakeup_irq;
-	else if (cdns->wakeup_irq == 0)
-		return -EINVAL;
-
-	if (cdns->wakeup_irq < 0) {
-		dev_dbg(dev, "couldn't get wakeup irq\n");
-		cdns->wakeup_irq = 0x0;
-	}
-
 	mutex_init(&cdns->mutex);
 
-	cdns->usb2_phy = devm_phy_optional_get(dev, "cdns3,usb2-phy");
-	if (IS_ERR(cdns->usb2_phy))
-		return PTR_ERR(cdns->usb2_phy);
-
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
-	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
-	if (IS_ERR(cdns->usb3_phy))
-		return PTR_ERR(cdns->usb3_phy);
-
-	ret = phy_init(cdns->usb3_phy);
-	if (ret)
-		goto err1;
-
-	ret = set_phy_power_on(cdns);
-	if (ret)
-		goto err2;
-
 	if (device_property_read_bool(dev, "usb-role-switch")) {
 		struct usb_role_switch_desc sw_desc = { };
 
@@ -541,9 +439,8 @@ static int cdns3_probe(struct platform_device *pdev)
 
 		cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
 		if (IS_ERR(cdns->role_sw)) {
-			ret = PTR_ERR(cdns->role_sw);
 			dev_warn(dev, "Unable to register Role Switch\n");
-			goto err3;
+			return PTR_ERR(cdns->role_sw);
 		}
 	}
 
@@ -555,153 +452,50 @@ static int cdns3_probe(struct platform_device *pdev)
 
 		if (ret) {
 			dev_err(cdns->dev, "couldn't register wakeup irq handler\n");
-			goto err4;
+			goto role_switch_unregister;
 		}
 	}
 
 	ret = cdns3_drd_init(cdns);
 	if (ret)
-		goto err4;
+		goto init_failed;
 
 	ret = cdns3_core_init_role(cdns);
 	if (ret)
-		goto err4;
+		goto init_failed;
 
 	spin_lock_init(&cdns->lock);
-	device_set_wakeup_capable(dev, true);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
-		pm_runtime_forbid(dev);
 
-	/*
-	 * The controller needs less time between bus and controller suspend,
-	 * and we also needs a small delay to avoid frequently entering low
-	 * power mode.
-	 */
-	pm_runtime_set_autosuspend_delay(dev, 20);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_use_autosuspend(dev);
 	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
 
 	return 0;
-err4:
+init_failed:
 	cdns3_drd_exit(cdns);
+role_switch_unregister:
 	if (cdns->role_sw)
 		usb_role_switch_unregister(cdns->role_sw);
-err3:
-	set_phy_power_off(cdns);
-err2:
-	phy_exit(cdns->usb3_phy);
-err1:
-	phy_exit(cdns->usb2_phy);
 
 	return ret;
 }
 
 /**
  * cdns3_remove - unbind drd driver and clean up
- * @pdev: Pointer to Linux platform device
+ * @cdns: Pointer to cdnsp structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-static int cdns3_remove(struct platform_device *pdev)
+int cdns3_remove(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = platform_get_drvdata(pdev);
-
-	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 	cdns3_exit_roles(cdns);
 	usb_role_switch_unregister(cdns->role_sw);
-	set_phy_power_off(cdns);
-	phy_exit(cdns->usb2_phy);
-	phy_exit(cdns->usb3_phy);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-
-static int cdns3_set_platform_suspend(struct device *dev,
-		bool suspend, bool wakeup)
-{
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	int ret = 0;
-
-	if (cdns->pdata && cdns->pdata->platform_suspend)
-		ret = cdns->pdata->platform_suspend(dev, suspend, wakeup);
-
-	return ret;
-}
-
-static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
-{
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	bool wakeup;
-	unsigned long flags;
-
-	if (cdns->in_lpm)
-		return 0;
-
-	if (PMSG_IS_AUTO(msg))
-		wakeup = true;
-	else
-		wakeup = device_may_wakeup(dev);
-
-	cdns3_set_platform_suspend(cdns->dev, true, wakeup);
-	set_phy_power_off(cdns);
-	spin_lock_irqsave(&cdns->lock, flags);
-	cdns->in_lpm = true;
-	spin_unlock_irqrestore(&cdns->lock, flags);
-	dev_dbg(cdns->dev, "%s ends\n", __func__);
 
 	return 0;
 }
 
-static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
-{
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	int ret;
-	unsigned long flags;
-
-	if (!cdns->in_lpm)
-		return 0;
-
-	ret = set_phy_power_on(cdns);
-	if (ret)
-		return ret;
-
-	cdns3_set_platform_suspend(cdns->dev, false, false);
-
-	spin_lock_irqsave(&cdns->lock, flags);
-	if (cdns->roles[cdns->role]->resume && !PMSG_IS_AUTO(msg))
-		cdns->roles[cdns->role]->resume(cdns, false);
-
-	cdns->in_lpm = false;
-	spin_unlock_irqrestore(&cdns->lock, flags);
-	if (cdns->wakeup_pending) {
-		cdns->wakeup_pending = false;
-		enable_irq(cdns->wakeup_irq);
-	}
-	dev_dbg(cdns->dev, "%s ends\n", __func__);
-
-	return ret;
-}
-
-static int cdns3_runtime_suspend(struct device *dev)
-{
-	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
-}
-
-static int cdns3_runtime_resume(struct device *dev)
-{
-	return cdns3_controller_resume(dev, PMSG_AUTO_RESUME);
-}
 #ifdef CONFIG_PM_SLEEP
-
-static int cdns3_suspend(struct device *dev)
+int cdns3_suspend(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct device *dev = cdns->dev;
 	unsigned long flags;
 
 	if (pm_runtime_status_suspended(dev))
@@ -713,52 +507,22 @@ static int cdns3_suspend(struct device *dev)
 		spin_unlock_irqrestore(&cdns->lock, flags);
 	}
 
-	return cdns3_controller_suspend(dev, PMSG_SUSPEND);
+	return 0;
 }
 
-static int cdns3_resume(struct device *dev)
+int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 {
-	int ret;
+	struct device *dev = cdns->dev;
 
-	ret = cdns3_controller_resume(dev, PMSG_RESUME);
-	if (ret)
-		return ret;
+	if (cdns->roles[cdns->role]->resume)
+		cdns->roles[cdns->role]->resume(cdns, false);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	if (set_active) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
 
-	return ret;
+	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
-#endif /* CONFIG_PM */
-
-static const struct dev_pm_ops cdns3_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
-	SET_RUNTIME_PM_OPS(cdns3_runtime_suspend, cdns3_runtime_resume, NULL)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id of_cdns3_match[] = {
-	{ .compatible = "cdns,usb3" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_cdns3_match);
-#endif
-
-static struct platform_driver cdns3_driver = {
-	.probe		= cdns3_probe,
-	.remove		= cdns3_remove,
-	.driver		= {
-		.name	= "cdns-usb3",
-		.of_match_table	= of_match_ptr(of_cdns3_match),
-		.pm	= &cdns3_pm_ops,
-	},
-};
-
-module_platform_driver(cdns3_driver);
-
-MODULE_ALIAS("platform:cdns3");
-MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 0d87871499ea..c97c2bb1582f 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -118,5 +118,11 @@ struct cdns3 {
 };
 
 int cdns3_hw_role_switch(struct cdns3 *cdns);
+int cdns3_init(struct cdns3 *cdns);
+int cdns3_remove(struct cdns3 *cdns);
 
+#ifdef CONFIG_PM_SLEEP
+int cdns3_resume(struct cdns3 *cdns, u8 set_active);
+int cdns3_suspend(struct cdns3 *cdns);
+#endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 95863d44e3e0..ed8cde91a02c 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/usb/otg.h>
-#include <linux/phy/phy.h>
 
 #include "gadget.h"
 #include "drd.h"
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index a767b6893938..8f3625ad4ef8 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -10,7 +10,6 @@
 #define __LINUX_CDNS3_DRD
 
 #include <linux/usb/otg.h>
-#include <linux/phy/phy.h>
 #include "core.h"
 
 /*  DRD register interface for version v1 of cdns3 driver. */
-- 
2.17.1

