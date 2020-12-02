Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF4D2CBE48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbgLBN1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:55 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18788 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbgLBN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:23 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DINb7004965;
        Wed, 2 Dec 2020 05:26:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ak+NFo0UvdL5F/uEz9vEIhkWZ1iqZHxX0Fh67SDUucc=;
 b=dhZo1+MyWOo5f0DLXbgT0AsY9MF+u2VQc/bNupmq0J+qPhk0kyxtAP4zZDnWwDpKhEM5
 7AxnW73Hxw1MVFDwclNykvffIYKTxt1G0jEaseYZtjtE6pDNBThhSYbJi43eYd5T9rHw
 7QRlU5we5yYH1K+/Jo0KScAIbHa4vFFDMeMA0XAJ7N5KN0ni51Y3Ge1CXsGPQg73lhd7
 tQEf3VXwRwXMBwlTjhELhKd58GenztIsIyWExNdknmYxn++1jPW1M8tifvjBThq8PTud
 iDEe8gL9o8bRkPc2SiqapN6B7MrO6bepeq0x9YFBaWUa9MznTP3xa5q9g+63VK0KhVH6 yQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 355vn4jjv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqzoDuq+P141XJjGPZz0sDR3hPtP/H4uWJ/Kg5Sy2hmgTgOjBikOnvJV2M5IKUsz3aaKekdN6Thn8VwGo+i+x6YobyklpkBXAe0NlJ8vlSNk6KMTM9m0odFLa8/grXPZUzOuyZbJoZAsVSo54QVhiJm/g6zrrEqA6LqPqiTGCPxin8fuWQfhvKp/IkWdC9WiXRBofw2o8FEhtp11+xVleqhVJAGL50OQtRLEczGjpawbosx8fvhf2xJCC90loiQRq1SWxZ1wm7SDufjKgbSmNUNUQX2UeBDOrCKB9CEDWYi8H/W/f7J3TOG5rnNy5NWpXwU1QkzbcUQC6gdf3OHytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak+NFo0UvdL5F/uEz9vEIhkWZ1iqZHxX0Fh67SDUucc=;
 b=l6rPhB+zfVSPeQtyVDraqmQ7OQyVM5pLj7e+2AHd0tbyLKjUENFDgGYdhg9aI3jUUa1Hl8rcg0L88gRywBYtmROrLYOK2D/euFFu+C5jeju0VDEE5U7JSK5ICERdmywkB/e5gIYGdP7l8raNAAJZbyesbI7dcbu5qDQLLzgKBj4DCoPWs2U1aoPfPUQSkO79DOuQaruh4HgqMeJ+1dnihLGsWXn8bQnIkcyzEu8I//oaxaPqF80SzfWI2Sfhooqg72dxtPiGkpP+BE8fpg4C7H08J0mwf5BUxQnnbLFtwIDCaxRDEsWGnZ6WORYB7p0kV9tuYvzumWfHxxLeX2e5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak+NFo0UvdL5F/uEz9vEIhkWZ1iqZHxX0Fh67SDUucc=;
 b=MgkbpNZ38NK7WSbwaHIh5cvqycc9lUXjeoVAyxHeLXFkShtEkWM+ZsbEP2Rco2LDUunNh2d/5iI+ycCBFvLUZyYqdtj5EfERI65Jbp82wg6rAaIAFJEKtjaEjJAopx0SFwF9aLSweCUFPEh4z0Mx6YgXqQfjzKwiAXY5mSyRU7A=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 MN2PR07MB6655.namprd07.prod.outlook.com (2603:10b6:208:168::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 2 Dec
 2020 13:26:11 +0000
Received: from DM6NAM12FT034.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::26) by DM6PR03CA0029.outlook.office365.com
 (2603:10b6:5:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT034.mail.protection.outlook.com (10.13.178.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.11 via Frontend Transport; Wed, 2 Dec 2020 13:26:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6o8007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6ja010794;
        Wed, 2 Dec 2020 14:26:06 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ68j010793;
        Wed, 2 Dec 2020 14:26:06 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 02/10] usb: cdns3: Split core.c into cdns3-plat and core.c file
Date:   Wed, 2 Dec 2020 14:25:40 +0100
Message-ID: <20201202132548.10736-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6b0383-fdde-4fc2-8390-08d896c5d5a9
X-MS-TrafficTypeDiagnostic: MN2PR07MB6655:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6655E2169A8052615B4DCE25DDF30@MN2PR07MB6655.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AvGrq01vBCp1xTxc/qImoMKk2yuMVzuaVvUf3zFjF4j3LYc7SHvKyDC50YsZdAhz4tvMsFjHTLuIcyvnFIkvtQcxEeT5kYxdS6oqkhGZNVvDz83NVNRwxTLTKvVme8kq56EWCjNE03TnC7SdI+grN/2EpUP7q5xLAIJ0cqHFEPRMwRLkudA46QbbLFEtcwAXtpLNYtFt5DnNpZ5zjkZpZ3b6+B3Lumu7wxS9mFpUQkb1Vux5vCcncauUO7YkAGH5uziPj+xoercbU8z9vasmbEsI5WEDi3FnFi1SmtHESKq6iDj0vIfkX7pTKUGwcfUIFkyypA+sTBeQHh0Huv0vSQjDsRzDE4i8KmJJ3x73v/KNzUZGZVNMSxfmfUjAZ0MdPQL17dXhXDMOxKCkGbZS0TQ/hBw1p4VV9f+YK/vGlA=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36092001)(46966005)(186003)(82740400003)(1076003)(30864003)(4326008)(86362001)(356005)(8676002)(6666004)(426003)(2616005)(42186006)(36756003)(36906005)(316002)(47076004)(6916009)(83380400001)(54906003)(478600001)(107886003)(336012)(7636003)(82310400003)(8936002)(5660300002)(26005)(70206006)(70586007)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:10.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6b0383-fdde-4fc2-8390-08d896c5d5a9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT034.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=1 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012020080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch splits file core.c into core.c containing the common reusable code
and cnd3-plat.c containing device platform specific code. These changes
are required to make possible reuse DRD part of CDNS3 driver in CDNSP
driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
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
index 000000000000..bfb57ded9664
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2018-2020 Cadence.
+ * Copyright (C) 2017-2018 NXP
+ * Copyright (C) 2019 Texas Instrumentsq
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
+	return cdns3_controller_resume(dev, PMSG_SUSPEND);
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
+	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
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

