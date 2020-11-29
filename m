Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CB2C798D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgK2OYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:24:07 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:16050 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbgK2OYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:24:05 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ATEM7R0014478;
        Sun, 29 Nov 2020 06:22:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=aO3n6GUhZRcBXT8Ywo/lTrFbpEYGVzrnUIp3g3s6GQCAzmjwBuIxV/sYAgRcKziWIjWJ
 SLxC1nOS/R/5Ql3sqw4dD23EOltuj6vky7d6g+nsiNwR3uRoXObTlhN/+nRMfL8zR3Ur
 zuvlsK1yTk0G5ll21V7p8a0a1snffY2A/8WKn+5htFFOhJ6Nb8WswwQfAE2XEGSjZ5yN
 28B5l5/MPbtYg+CKmK+QnxRupClGNwKS3bK7pIHUVaSTwF2JAl/yiciB7uWcNqHrjYgz
 xYXr0YRBffvQgplpJ+jjLWYtBZZXbYlrJsb0Y/NtTNo1YQP5TFvaj85aBsT0oPrYBOiX sA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02tf5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 06:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqjie0bU7OCZzuOtHQ+37AVJ84zPgXUwLvZ5Rk9YHoGfYTvzNVRAmoX2u196x9O/P/rzHPcA8+yobF+6V58TzO7vajQH8YS1ilnXsRoVphc7a90+S2YkO6jBX/xT41u7scI5yKIS1mO3FxwJ+T2gy0Wt/jTYi2Fx04KKkQI/TxzWnPXxW2SPyaDeBMAaPYIdjBtGTh1pHT4FGRXf0/I5KJ9+TMdatqLpV0JpFR0zEwWASDw5AQO2xC5z7TKNv8lbI+aL2Tw8hmy2MTKhPmBWGERI2H6XlHkG7k/GcFklw9g2kxUIhdzcS5SNwJjA5gV5sozUJYcOSjlUYzRZCxQo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=Fk25WZlBtO7e1Dtq/Miyg0XE6EVQN47uda79sz2yobVAqQf3X4nXMiEqb/2DUUsrEY0a47bLb4OyUV3pR96Gaf3bzGSH7MjsnSn/PDwMJT5eDfcxGkuXHsX6cUlvyMJjfEZTp5bsCN/zdfgzhmoMjsGrGaCCIBpgKU8K6ugYIFQqvdRUcaA3w4NQ6zGTEH3+FQ+cPSSZp2R8DeoYEF1VXBfnHUcEukLwC2yj6YpWfhUGCblmoO/SrMwdFX8HZf17GwLNOtqdRTFyUzw0Z6Y2olQlqt1BaWQE7tTXYv88Mxau62lNyUlUtJof9U8y+FKG6aTDQ7HgXpLkVcSLqdSjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=lV6/DFNbxuR17GUbJMqaEWWVx/m3/eVj5J1tLapard9dpFHQXMnehVLhAGfI+t62bDoeX3v0GKMrOuAOcIbg51gCU1Rb/kBNGvnAtH9+qgJVPNJX3RPi0ZB3/H2pQWNfqkxMfORkvvh3CZs9U9G2LffFcPXOFtY3yp5yNBgyTmI=
Received: from DM5PR2001CA0014.namprd20.prod.outlook.com (2603:10b6:4:16::24)
 by BL0PR07MB5219.namprd07.prod.outlook.com (2603:10b6:208:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Sun, 29 Nov
 2020 14:22:51 +0000
Received: from DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::4e) by DM5PR2001CA0014.outlook.office365.com
 (2603:10b6:4:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 14:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT022.mail.protection.outlook.com (10.13.179.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Sun, 29 Nov 2020 14:22:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATEMmgu011804
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 06:22:49 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 29 Nov 2020 15:22:47 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 29 Nov 2020 15:22:47 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATEMl2A019530;
        Sun, 29 Nov 2020 15:22:47 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ATEMlwd019529;
        Sun, 29 Nov 2020 15:22:47 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 3/7] i3c: master: add i3c_secondary_master_register
Date:   Sun, 29 Nov 2020 15:22:45 +0100
Message-ID: <1606659765-19490-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
References: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73492a19-bdcb-4df3-3970-08d8947240e4
X-MS-TrafficTypeDiagnostic: BL0PR07MB5219:
X-Microsoft-Antispam-PRVS: <BL0PR07MB5219368F0B85874220127C3AC1F60@BL0PR07MB5219.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Otg0NR5J1boTR1ePDa1/FoACmWkFK21Cduv9K+MOQ1ID2EYpWxSZ/GUfO7ufvlu3aB//HnJWYvrytQMKniHWC8smXUfCBMjpHvzanNnUo9YQ0Nqy1woHJi7ONeD3wNX0WK8KspV2HKgnm/9BgHCpCVIRQGWzXLViYJZjZkzSiah9wU3Fo3S8YxMJjw/i++qI4vsny2dmdANGi2FoGk989gGSa/mZTyfkR49hlV6Vm6gZ0UHZwf6GDki6BThjI6TV8tigT63VHYDSjtMpgEq3ZMUgFmBjf9nZb2wDuMJW4nLr3VrD3sFO+DZ3xt/MFmX9ahq6DmbQBuF1srS91l59JDVHUlGSER/W6fgyCUutvOE6BomzKsVDZC0ZQNF5YsXmPDDdjXjBHQxt6UksH6Fv3kw/5DbFj1Vf/JDsJrRMuT4=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(46966005)(2616005)(7636003)(26005)(83380400001)(426003)(36906005)(186003)(336012)(316002)(5660300002)(70206006)(110136005)(8936002)(42186006)(36756003)(47076004)(82310400003)(356005)(8676002)(4326008)(2906002)(82740400003)(107886003)(70586007)(86362001)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 14:22:50.7857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73492a19-bdcb-4df3-3970-08d8947240e4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5219
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_07:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011290097
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

