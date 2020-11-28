Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00E2C71A3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390851AbgK1Vvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:38 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43692 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729815AbgK1Suy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:50:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ASEerd8012303;
        Sat, 28 Nov 2020 06:46:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=HLF1zaGAf/EaJPbcp1GB/nzDvm29uHx20avwY2NUW8VkCFMBZpJnYOotfhIorC27nUDY
 li1LyRa+mtl4fXsw3MR/e3jRR8kWiXOAdOAp2LRuQjOMnjKmGSD/MAe5vOBdANbu3gcS
 WblXcMc4c6oMstCDQkFxQ8N4kY00S2vf63hbSFVF5q7ouAZhxpspHS6aCcnoYzRC/lbs
 pdCiiQeKQ6iicwFPU31x7YA9hwEVFcbuCypDdQ47ac5HE/Uss0oTCNSKmt5S0+YMC2ES
 ZpEtiu3H5HqLwixwvA+R7QxaIx6Nx1InaSIIergD+8gY/UkFfnntE3dv6c8usY2pytAN qQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 353k12gk42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 06:46:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUdWMmQAYElvpaRMTUp2Jhdc2o26jMG31KAeQegDTPkNB3QPTuSyNVCrmQKNlt/xSCfuOoren/FgTInNhoTtrl4nKMGlmVVXYTIUDEax0FCaoyAC9ScG4MTeOrw/GEODyrX0BaFABBnBmR8zFtKgzmVYoY990CKg3Kh8U42Z7FDFtdzCu1i7aMmZtCHFi4lGX4iayeXuvyRQFGI7ARnX55K6Iie4jR3A3kVZmbSfv+kIxogH2qgtbueDlR26ZoaB+/a+a4tqz2yRPeiFBGBZN0ApCyrBudhPG3sZnwnJQQgllNvlAK7eV57scXimugcU06jEVinpgXBk481jdWAh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=QrPRMDZ2H9xvIFsArGFlF57tQkGDasBXrb/ts3YAvcHlTTO3SuCGqgL96fJsgDn08lIRXH+MRse6NdVJE8ppbPuLJCm64bpCm8qIppxIiqlrt+gYwRWdYDC1Qe+xiV8ERG/Xa9DeZxaPc5eexYQAznchHdDgElxZcWJkWxZc5rEiN+aZZDBXTevWiBVcnwEVG3mbyPgI4ccrX+6jp/c/Eq2c0XTmtPnlk+O+HxcRSfT11QBlmd41hUHCYHGw/omiqP/CM+SUavN8U870ejp7zbT6HUXCV6N0Y19AXeQsXKJJKS188cj2yPDS53PW1V5V12eZJFLEE0wwjEjNWnsWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=NRgPVCDwkHyvrFCQjdatT8Ogqt+SuAv6miJE+P/AFrz4HVsUEYSqaRvltLrbO338Lp7JyUcwHU03v04ZpYe3qbkK67sumoWaVgU3D+wFbA4iSkK1Kh5Mc5nIPStfKQKFDLwy9n4MaQL5Fn6r2ItwQJNCl1TlT1XbaQEtHVYEVN8=
Received: from DM3PR12CA0130.namprd12.prod.outlook.com (2603:10b6:0:51::26) by
 MN2PR07MB6206.namprd07.prod.outlook.com (2603:10b6:208:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Sat, 28 Nov
 2020 14:46:51 +0000
Received: from DM6NAM12FT008.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::ab) by DM3PR12CA0130.outlook.office365.com
 (2603:10b6:0:51::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sat, 28 Nov 2020 14:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT008.mail.protection.outlook.com (10.13.179.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sat, 28 Nov 2020 14:46:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEkmQr004296
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 28 Nov 2020 06:46:49 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 28 Nov 2020 15:46:47 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 28 Nov 2020 15:46:47 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEklWG021314;
        Sat, 28 Nov 2020 15:46:47 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ASEklKT021313;
        Sat, 28 Nov 2020 15:46:47 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 3/7] i3c: master: add i3c_secondary_master_register
Date:   Sat, 28 Nov 2020 15:46:46 +0100
Message-ID: <1606574806-21278-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823f0620-71f6-45e4-44de-08d893ac70fb
X-MS-TrafficTypeDiagnostic: MN2PR07MB6206:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6206F3B5DC87EB04ED394710C1F70@MN2PR07MB6206.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSBpKI4v5g9DQmOb5P7vx/LaN21IaPudjf0hjGDO57gEDWGXPCdAmWFZiB9xskSs7vcRASUsNTRMK5JrJu7XJ9UiIBTbV5ySROOs4tNMqi5WTUUX+dcvlQGe5HGhKwPzvY2E9pek91iC2oS+y1S/6RJz8CrV4I8aBd9j7KWyJeRpSvuVkuU5TuxOQv6wNg9BKdiext0pIlXqZ2RPpyTmQY0raEowel148ZFRcwfOQv1+NmkMLFFQ8WtHEHdnDz5ZejKFIlhPNBpmKcITNnGi6GW8lojksp/20PB9SRnle5k1yMDBIMHqfORBnmbRGFtEIb5ZYRcILL9EFiARY6LBGkP3Imzk7djPchtsuCvb+NHtQaxJJsOHpiN9cqJvPqpG3JB9yjsR2PN/Mr6kASctETcnnkM04kzx6RiOsAfc4wE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(36092001)(46966005)(54906003)(356005)(7636003)(47076004)(82740400003)(8676002)(5660300002)(4326008)(107886003)(70586007)(70206006)(83380400001)(186003)(36756003)(426003)(110136005)(86362001)(26005)(478600001)(316002)(36906005)(42186006)(336012)(8936002)(2616005)(82310400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 14:46:51.1149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823f0620-71f6-45e4-44de-08d893ac70fb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT008.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_09:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=2 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011280089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add i3c_secondary_master_register which is used
to register secondary masters.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       |  154 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i3c/master.h |    3 +
 2 files changed, 156 insertions(+), 1 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 56e8fe4..af0630a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1797,6 +1797,90 @@ static int i3c_primary_master_bus_init(struct i3c_master_controller *master)
 	return ret;
 }
 
+/**
+ * i3c_secondary_master_bus_init() - initialize an I3C bus for secondary
+ * master
+ * @master: secondary master initializing the bus
+ *
+ * This function does
+ *
+ * 1. Attach I2C devs to the master
+ *
+ * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
+ *    the master controller. That's usually where the bus mode is selected
+ *    (pure bus or mixed fast/slow bus)
+ *
+ * Once this is done, I2C devices should be usable.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+static int i3c_secondary_master_bus_init(struct i3c_master_controller *master)
+{
+	enum i3c_addr_slot_status status;
+	struct i2c_dev_boardinfo *i2cboardinfo;
+	struct i2c_dev_desc *i2cdev;
+	int ret;
+
+	/*
+	 * First attach all devices with static definitions provided by the
+	 * FW.
+	 */
+	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      i2cboardinfo->base.addr);
+		if (status != I3C_ADDR_SLOT_FREE) {
+			ret = -EBUSY;
+			goto err_detach_devs;
+		}
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i2cboardinfo->base.addr,
+					     I3C_ADDR_SLOT_I2C_DEV);
+
+		i2cdev = i3c_master_alloc_i2c_dev(master, i2cboardinfo);
+		if (IS_ERR(i2cdev)) {
+			ret = PTR_ERR(i2cdev);
+			goto err_detach_devs;
+		}
+
+		ret = i3c_master_attach_i2c_dev(master, i2cdev);
+		if (ret) {
+			i3c_master_free_i2c_dev(i2cdev);
+			goto err_detach_devs;
+		}
+	}
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_detach_devs;
+
+	/*
+	 * The master device should have been instantiated in ->bus_init(),
+	 * complain if this was not the case.
+	 */
+	if (!master->this) {
+		dev_err(&master->dev,
+			"master_set_info() was not called in ->bus_init()\n");
+		ret = -EINVAL;
+		goto err_bus_cleanup;
+	}
+
+	return 0;
+
+err_bus_cleanup:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+err_detach_devs:
+	i3c_master_detach_free_devs(master);
+
+	return ret;
+}
+
 static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
 {
 	if (master->ops->bus_cleanup)
@@ -2514,7 +2598,10 @@ static int i3c_master_init(struct i3c_master_controller *master,
 		goto err_put_dev;
 	}
 
-	ret = i3c_primary_master_bus_init(master);
+	if (secondary)
+		ret = i3c_secondary_master_bus_init(master);
+	else
+		ret = i3c_primary_master_bus_init(master);
 	if (ret)
 		goto err_destroy_wq;
 
@@ -2595,6 +2682,71 @@ int i3c_primary_master_register(struct i3c_master_controller *master,
 EXPORT_SYMBOL_GPL(i3c_primary_master_register);
 
 /**
+ * i3c_secondary_master_register() - register an I3C secondary master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ *
+ * This function does minimal required initialization for secondary
+ * master, rest functionality like creating and registering I2C
+ * and I3C devices is done in defslvs processing.
+ *
+ *  i3c_secondary_master_register() does following things -
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ *   initialization
+ * - allocate memory for defslvs_data.devs, which is used to receive
+ *   defslvs list
+ * - create I3C device representing this master
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_secondary_master_register(struct i3c_master_controller *master,
+				  struct device *parent,
+				  const struct i3c_master_controller_ops *ops)
+{
+	int ret;
+
+	ret = i3c_master_init(master, parent, ops, true);
+	if (ret)
+		return ret;
+
+	ret = device_add(&master->dev);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/*
+	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
+	 * through the I2C subsystem.
+	 */
+	ret = i3c_master_i2c_adapter_init(master);
+	if (ret)
+		goto err_del_dev;
+
+	/*
+	 * We're done initializing the bus and the controller, we can now
+	 * register I3C devices from defslvs list.
+	 */
+	master->init_done = true;
+
+	return 0;
+
+err_del_dev:
+	device_del(&master->dev);
+
+err_cleanup_bus:
+	i3c_master_bus_cleanup(master);
+
+	put_device(&master->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
+
+/**
  * i3c_master_unregister() - unregister an I3C master
  * @master: master used to send frames on the bus
  *
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index e543f68..e186d53 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -541,6 +541,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 int i3c_primary_master_register(struct i3c_master_controller *master,
 				struct device *parent,
 				const struct i3c_master_controller_ops *ops);
+int i3c_secondary_master_register(struct i3c_master_controller *master,
+				  struct device *parent,
+				  const struct i3c_master_controller_ops *ops);
 int i3c_master_unregister(struct i3c_master_controller *master);
 
 /**
-- 
1.7.1

