Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8427ADE6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgI1MeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:34:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35590 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbgI1Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:33:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUSqF012515;
        Mon, 28 Sep 2020 05:33:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=a/E+57kEPjtM+Hw9f23nO8T9g5W6OQmI6YsdFa5Julc=;
 b=nEyb8S4n+HKj4irIv7d0zpwMUUyMK0AgNFoazS5FhlVEYHA/4QpZIMA9sjczDeXHRHbM
 AbQCzyipuqWS6aBdo/AG1Q+qLrHcqMC/WT2iODDjz44AzzfR1jG+qB28iU97a1VNeHPj
 SIh62QwI56YpsQWqOmLqEF+h8ggCdq9oFX6YLgnfxfrIIhZbTMJBNptYktDuns2W30PE
 ejR9gKj19Ln0QGP+naROKQE9W68bd0A5IihI7ONK9z1O6vBfRm8XPd0uYwL/AmnQASON
 klBzbOiS3v7VZoUbx0B2kt8RxUZLuvLEnlvww+950YnYxUakjcMCSGsK4Jri2eEz6PuK fg== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkSLdiqRzCuHEWTuhkNHPe1s63c1XUeMEse1671sMrNpkVkd6ixl1P/vUNa9SHO1ZWmm6GGOVbMJC1tYzNsN0YKM0QtAcs0TKppOJDlJMVr5D07twsPLk7Ojo9HsRvYUXQbfJ55Xf1B3PCbAoe1J6Mk8pf+Txkk8nmwWMGTyN9dDBenwFhFQRWFHSphv3taNpuIyDNWVNwbFZd6OYFD8ANk0PwzM88kpSinDex9eN1eEbZavTHHe2mT5mz5Z72Y9hTIDpIisUWq85kKSiFIvsFR4yrE6D7uzUW+uzl1EKOYqTrUh5sDgoOuuS++YS5MNzNK39bwRRrufisOQ+jDPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/E+57kEPjtM+Hw9f23nO8T9g5W6OQmI6YsdFa5Julc=;
 b=mp+n0YnnEiAqNW5JUwWqFwjC+z/CpCnbFFbfPpVUsDVDKsiVF1gnvV9XMlDh4UA11EeSwJvmS0UtljhGxSgqj6ooFBRa3KGbGxEBxI+Nw4+z3Zgo6cb5Za1BtntdZeR3n5xvQAF+83k8l1yXy7yoaFawMT4bQspwz6knkECwGaUy6dAPMYB29ff85RP8Fj2J2gZk45RZ1dK7nlrtx0Amd9mwVoKlzqCGUp3wnJsOFbRSTblS8buEtd4POPtqlVYWfbbX8aw1KHwewCQwkrRPurN4XTKR+Tnzx5/RyGpBRtqlUFsihNBd1gFcq/dIr0ftJNSWCOYDNdsKfJNHPjWDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/E+57kEPjtM+Hw9f23nO8T9g5W6OQmI6YsdFa5Julc=;
 b=5DZkDxkcDSS9Jiv/i9/WyF5jv2FQ3JD+e0RWFQ47G1oQpNU1d9qSzpmrkRn2QuxVYasf1Od7tsg22UdzrQ6KDcFG83a53Uhf6sP9l1ApUdvM1M/M74zHvcGsBlCXq1LbEbR7nV1lekJGHTcQWnXZTymQDBiyzvjESnN/jKrCels=
Received: from BN6PR16CA0007.namprd16.prod.outlook.com (2603:10b6:404:f5::17)
 by DM5PR0701MB3639.namprd07.prod.outlook.com (2603:10b6:4:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.29; Mon, 28 Sep
 2020 12:33:30 +0000
Received: from BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::1f) by BN6PR16CA0007.outlook.office365.com
 (2603:10b6:404:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT060.mail.protection.outlook.com (10.13.183.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCW030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:29 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXPRu019070;
        Mon, 28 Sep 2020 14:33:25 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXPOT019069;
        Mon, 28 Sep 2020 14:33:25 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 2/8] usb: cdns3: Split core.c into cdns3-plat and core.c file
Date:   Mon, 28 Sep 2020 14:27:35 +0200
Message-ID: <20200928122741.17884-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
References: <20200928122741.17884-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b298ec85-b993-4c97-174f-08d863aab4f2
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3639:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB36397265024EBC5E5F982308DD350@DM5PR0701MB3639.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/yogPfv+RMguao2z1JpF1ccj40mQy0iH3Ex5ZxWWGlmdsph9B0vBdp20uDJpsY3WgCM0ez3ZjBkOSVWkVD8GP7MYIHEBPALIw/duNmyyTXfyVqLDP2BjErgdc9pAfOWiXxTMGMf0ersbIzjU0tHpVX1F1EQqxyF4ypJD+2GWeAV+z6gpWsZsPLMQggwN5u7RlxwRqikdbsS3tAWHI6Ap9llx6w2fsQK6049x5+7KDggIWRYf9S0WFrsTRNxKlJ5V5s7M4e8Re8pYlFhW+4MfcrZ1i20m+1k+7Bhecz6+Ns8gR/rwAeWLoPvi7Afk7rwntkxuqBugiYgqFU7ueBHxSkp68LpQza/Xs9oC822w0Cm9ouMHHzVHOmWC+TT0ck4OxpXgDxPnIk+i+mZFp7w954NKmkULZ+CWQC7vbDRXx4SJov6ooZRkukeB8DUWBNAHfpfFtDJRAcwOf0yWilE/3K9RKavVUCIJcKAcviIqsc=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(36092001)(46966005)(7416002)(36906005)(2616005)(4326008)(356005)(110136005)(316002)(336012)(26005)(81166007)(70206006)(83380400001)(82740400003)(70586007)(47076004)(86362001)(54906003)(82310400003)(36756003)(186003)(426003)(8676002)(30864003)(5660300002)(42186006)(8936002)(1076003)(478600001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:30.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b298ec85-b993-4c97-174f-08d863aab4f2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3639
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
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
 drivers/usb/cdns3/cdns3-plat.c | 209 +++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/core.c       | 181 +++-------------------------
 drivers/usb/cdns3/core.h       |   8 +-
 4 files changed, 234 insertions(+), 166 deletions(-)
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
index 000000000000..f35e9dca30fe
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -0,0 +1,209 @@
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
+	if (cdns->dev_irq == -EPROBE_DEFER)
+		return cdns->dev_irq;
+
+	if (cdns->dev_irq < 0)
+		dev_err(dev, "couldn't get peripheral irq\n");
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+	cdns->dev_regs	= regs;
+
+	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
+	if (cdns->otg_irq == -EPROBE_DEFER)
+		return cdns->otg_irq;
+
+	if (cdns->otg_irq < 0) {
+		dev_err(dev, "couldn't get otg irq\n");
+		return cdns->otg_irq;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
+	if (!res) {
+		dev_err(dev, "couldn't get otg resource\n");
+		return -ENXIO;
+	}
+
+	cdns->otg_res = *res;
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
+	ret = phy_power_on(cdns->usb2_phy);
+	if (ret)
+		goto err_phy2_power_on;
+
+	ret = phy_power_on(cdns->usb3_phy);
+	if (ret)
+		goto err_phy3_power_on;
+
+	ret = cdns3_init(cdns);
+	if (ret)
+		goto err_cdns_init;
+
+	device_set_wakeup_capable(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/*
+	 * The controller needs less time between bus and controller suspend,
+	 * and we also needs a small delay to avoid frequently entering low
+	 * power mode.
+	 */
+	pm_runtime_set_autosuspend_delay(dev, 20);
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+
+err_cdns_init:
+	phy_power_off(cdns->usb3_phy);
+err_phy3_power_on:
+	phy_power_off(cdns->usb2_phy);
+err_phy2_power_on:
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
+	phy_power_off(cdns->usb2_phy);
+	phy_power_off(cdns->usb3_phy);
+	phy_exit(cdns->usb2_phy);
+	phy_exit(cdns->usb3_phy);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int cdns3_plat_suspend(struct device *dev)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+
+	return cdns3_suspend(cdns);
+}
+
+static int cdns3_plat_resume(struct device *dev)
+{
+	struct cdns3 *cdns = dev_get_drvdata(dev);
+
+	return cdns3_resume(cdns);
+}
+#endif
+
+static const struct dev_pm_ops cdns3_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(cdns3_plat_suspend, cdns3_plat_resume)
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
index 371128e9a4ae..079bd2abf65d 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -2,7 +2,7 @@
 /*
  * Cadence USBSS DRD Driver.
  *
- * Copyright (C) 2018-2019 Cadence.
+ * Copyright (C) 2018-2020 Cadence.
  * Copyright (C) 2017-2018 NXP
  * Copyright (C) 2019 Texas Instruments
  *
@@ -383,17 +383,14 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 
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
 	struct usb_role_switch_desc sw_desc = { };
-	struct device *dev = &pdev->dev;
-	struct resource	*res;
-	struct cdns3 *cdns;
-	void __iomem *regs;
+	struct device *dev = cdns->dev;
 	int ret;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -402,85 +399,8 @@ static int cdns3_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
-	if (!cdns)
-		return -ENOMEM;
-
-	cdns->dev = dev;
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
-	if (cdns->dev_irq == -EPROBE_DEFER)
-		return cdns->dev_irq;
-
-	if (cdns->dev_irq < 0)
-		dev_err(dev, "couldn't get peripheral irq\n");
-
-	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-	cdns->dev_regs	= regs;
-
-	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
-	if (cdns->otg_irq == -EPROBE_DEFER)
-		return cdns->otg_irq;
-
-	if (cdns->otg_irq < 0) {
-		dev_err(dev, "couldn't get otg irq\n");
-		return cdns->otg_irq;
-	}
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
-	if (!res) {
-		dev_err(dev, "couldn't get otg resource\n");
-		return -ENXIO;
-	}
-
-	cdns->otg_res = *res;
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
-	ret = phy_power_on(cdns->usb2_phy);
-	if (ret)
-		goto err2;
-
-	ret = phy_power_on(cdns->usb3_phy);
-	if (ret)
-		goto err3;
-
 	sw_desc.set = cdns3_role_set;
 	sw_desc.get = cdns3_role_get;
 	sw_desc.allow_userspace_control = true;
@@ -490,78 +410,47 @@ static int cdns3_probe(struct platform_device *pdev)
 
 	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
 	if (IS_ERR(cdns->role_sw)) {
-		ret = PTR_ERR(cdns->role_sw);
 		dev_warn(dev, "Unable to register Role Switch\n");
-		goto err4;
+		return PTR_ERR(cdns->role_sw);
 	}
 
 	ret = cdns3_drd_init(cdns);
 	if (ret)
-		goto err5;
+		goto init_failed;
 
 	ret = cdns3_core_init_role(cdns);
 	if (ret)
-		goto err5;
-
-	device_set_wakeup_capable(dev, true);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+		goto init_failed;
 
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
-err5:
+init_failed:
 	cdns3_drd_exit(cdns);
 	usb_role_switch_unregister(cdns->role_sw);
-err4:
-	phy_power_off(cdns->usb3_phy);
-
-err3:
-	phy_power_off(cdns->usb2_phy);
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
-	phy_power_off(cdns->usb2_phy);
-	phy_power_off(cdns->usb3_phy);
-	phy_exit(cdns->usb2_phy);
-	phy_exit(cdns->usb3_phy);
+
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
 
-static int cdns3_suspend(struct device *dev)
+int cdns3_suspend(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	unsigned long flags;
+	struct device *dev = cdns->dev;
 
 	if (cdns->role == USB_ROLE_HOST)
 		return 0;
@@ -569,28 +458,21 @@ static int cdns3_suspend(struct device *dev)
 	if (pm_runtime_status_suspended(dev))
 		pm_runtime_resume(dev);
 
-	if (cdns->roles[cdns->role]->suspend) {
-		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
+	if (cdns->roles[cdns->role]->suspend)
 		cdns->roles[cdns->role]->suspend(cdns, false);
-		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
-	}
 
 	return 0;
 }
 
-static int cdns3_resume(struct device *dev)
+int cdns3_resume(struct cdns3 *cdns)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
-	unsigned long flags;
+	struct device *dev = cdns->dev;
 
 	if (cdns->role == USB_ROLE_HOST)
 		return 0;
 
-	if (cdns->roles[cdns->role]->resume) {
-		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
+	if (cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, false);
-		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
-	}
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
@@ -599,32 +481,3 @@ static int cdns3_resume(struct device *dev)
 	return 0;
 }
 #endif
-
-static const struct dev_pm_ops cdns3_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
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
index c09fdde3ae8f..284707c19620 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -3,7 +3,7 @@
  * Cadence USBSS DRD Header File.
  *
  * Copyright (C) 2017-2018 NXP
- * Copyright (C) 2018-2019 Cadence.
+ * Copyright (C) 2018-2020 Cadence.
  *
  * Authors: Peter Chen <peter.chen@nxp.com>
  *          Pawel Laszczak <pawell@cadence.com>
@@ -97,5 +97,11 @@ struct cdns3 {
 };
 
 int cdns3_hw_role_switch(struct cdns3 *cdns);
+int cdns3_init(struct cdns3 *cdns);
+int cdns3_remove(struct cdns3 *cdns);
 
+#ifdef CONFIG_PM_SLEEP
+int cdns3_resume(struct cdns3 *cdns);
+int cdns3_suspend(struct cdns3 *cdns);
+#endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
-- 
2.17.1

