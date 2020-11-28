Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CF2C730C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbgK1Vt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24934 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729536AbgK1SDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:03:40 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ASEbvU3013117;
        Sat, 28 Nov 2020 06:46:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ruawUC7L5j1CY4fCnDgudQjMdcRdTHF3WLOvJVbTgJA=;
 b=n1N1bJHTK7vaUVIjVd7HjDNV+YmLDOA8mM0zZZPyKaYZ6rvooUKHEYqkPZwGjtk7FXiX
 ze3hdujFoGO70tfcUzDtf/pOq4HfM13x2/DzIl02Zo+f9WZpo4NbI3Oo+66o6aoXnlVb
 0N95L8krX2WOwLAwsgN4tBWghqzz9usImrl7I3o+ZL5pAp3/h3pmW9QBDxe7+JXvXEcb
 5YHzeY9dqDQ5DosVcPZZXg0tB6y+0mDP0lOdrZtcjVmR1+x9L58LBTBPayNZeTQHzvbE
 ZOu/fNnGifR799PxkUsFfqUvDrLneXiy1KHJwYtA6RyVMNbPoDMjvyXp4qf7HqitzxKI qg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02rf2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 06:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaul9GUgvzZiVDd+qCvf4ixmpdxMJGA55nXWJKszhufYHkcqoImfJ4eYvsFvYHrgZMKla3f+Rl8ULOkzUTRWgCQJHSo3opv1vQYhqKOHPnhAuO5mCb3DZkLAsWvNCiYT2TBdA7K0yl5V9WUKZvXQ9BfSqF59QVF+AIQWxg7q8YCi1VCJJDxJWeVTYotdzefoUBq54z/3zo16uwNnJM3lS73KGQQNCQzeKq2HBsqmz73CUQyEfesL3ETbVN1iqvgq4Pv3yt+fze5rW0aAKTaBi6s+Yos73gQxJEYosi2GDyF9c/iwYkvwiA3gzA3Unp9p8xy69z4xFw4bL95aVxmydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruawUC7L5j1CY4fCnDgudQjMdcRdTHF3WLOvJVbTgJA=;
 b=cJSz6ArM1TECQpKx+kf7jrmOs9iGoshd/XvTCGywPaE13JO+9Yumw71PuPyukmTTV/35eUjk/QxnKtFXVW01OyDyWTDfxKeqKW3eEdBOVI2RhWkqFzqi1ijsIG7HwHzkP474tEGRFdpWSR0BYCusxj8/FKnu4w7fhKHk5oxms28yVp6S0uHRraAEkCDcJ4X59yh224M5rI1GB4e4P/SkzVvy4IrraCfraoAutv4I2ffX2yFa+lme1aV0/O0psVaFpY0T5KKAljBDz4GnQ/oMHN1HvdYzp6eW7aguzGKdTOkRmliq7sXk+ul4QDWpzOBFaFofZpwhtkftXhX3LB0Vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruawUC7L5j1CY4fCnDgudQjMdcRdTHF3WLOvJVbTgJA=;
 b=ZhSD6N0ZHvY7GL6IB3OaGBFXsosI+gxIUhfNd+x09wx9Fmne35gRr+U8Zz0ECpueu5cPmqKr4Usv8krytl3xjtGcLSXG/LLa+TN0t808GRlvFX51MBKIbI88NEvVcKCrlHo1yyknakgl7Pwzuhm4ZzwgIU0cwoyF70UBHJMQ+V0=
Received: from MWHPR19CA0096.namprd19.prod.outlook.com (2603:10b6:320:1f::34)
 by DM5PR0701MB3624.namprd07.prod.outlook.com (2603:10b6:4:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sat, 28 Nov
 2020 14:46:36 +0000
Received: from MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::c7) by MWHPR19CA0096.outlook.office365.com
 (2603:10b6:320:1f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sat, 28 Nov 2020 14:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT043.mail.protection.outlook.com (10.13.180.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Sat, 28 Nov 2020 14:46:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEkXEm013685
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 28 Nov 2020 06:46:34 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 28 Nov 2020 15:46:32 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 28 Nov 2020 15:46:32 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEkWxT021261;
        Sat, 28 Nov 2020 15:46:32 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ASEkWOG021260;
        Sat, 28 Nov 2020 15:46:32 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 2/7] i3c: master: use i3c_master_register only for main master
Date:   Sat, 28 Nov 2020 15:46:31 +0100
Message-ID: <1606574791-21224-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a82b00f-cdb0-4133-0117-08d893ac67c8
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3624:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB36249CAF00EF29FC2D91D257C1F70@DM5PR0701MB3624.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkigbKTJkyKoL1v5hfQlT0XocsVXtWeNNGovAggUKyrB5jSGZ7PEg+Cac7Xg3yBgywOGHHRIGfiSEMvGenea4kbTklM0h16PUBjS4VKTIIOmAu4m/Q1zh6CbHqB2godM5yHpkdCYCUmyIkf1lOJTAUJWk3uSOR0ivo+14IqxkXJistQBnRTVj40mLtqg/LqUIKAGe8cj38rn5flAk4faqCGrjq/RBuSYBHm/hsrycVC8fq09ZfPXHCSOTABkA+Gr6e6yNKxaJhC5Ig/vhNwcQbAvE9Hy1I7UR3Gt7HeXSVsfvA6o6SQltzPaRS1KiV83T5VVtRyQXGVH0749HbmLnawJcOPBGYccE4IRX93Mhy6yPr1L9piKLRID2FiYVaibkTGlq828D78w7P/2G4smaVYoPx1WgrrLAizuz2jN5LM=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36092001)(46966005)(336012)(2616005)(478600001)(8676002)(316002)(186003)(4326008)(47076004)(42186006)(82740400003)(110136005)(107886003)(54906003)(70586007)(36756003)(26005)(426003)(5660300002)(7636003)(86362001)(8936002)(70206006)(82310400003)(83380400001)(36906005)(2906002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 14:46:35.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a82b00f-cdb0-4133-0117-08d893ac67c8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3624
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_09:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011280089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed last argument 'secondary' and restructured
i3c_master_register to move code that can be common
to i3c_secondary_master_register to separate function
i3c_master_init.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c                 |   78 ++++++++++++++++++++-------------
 drivers/i3c/master/dw-i3c-master.c   |    4 +-
 drivers/i3c/master/i3c-master-cdns.c |    4 +-
 include/linux/i3c/master.h           |    7 +--
 4 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b61bf53..56e8fe4 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1637,7 +1637,7 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 }
 
 /**
- * i3c_master_bus_init() - initialize an I3C bus
+ * i3c_primary_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
  *
  * This function is following all initialisation steps described in the I3C
@@ -1668,7 +1668,7 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  *
  * Return: a 0 in case of success, an negative error code otherwise.
  */
-static int i3c_master_bus_init(struct i3c_master_controller *master)
+static int i3c_primary_master_bus_init(struct i3c_master_controller *master)
 {
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
@@ -2441,31 +2441,10 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	return 0;
 }
 
-/**
- * i3c_master_register() - register an I3C master
- * @master: master used to send frames on the bus
- * @parent: the parent device (the one that provides this I3C master
- *	    controller)
- * @ops: the master controller operations
- * @secondary: true if you are registering a secondary master. Will return
- *	       -ENOTSUPP if set to true since secondary masters are not yet
- *	       supported
- *
- * This function takes care of everything for you:
- *
- * - creates and initializes the I3C bus
- * - populates the bus with static I2C devs if @parent->of_node is not
- *   NULL
- * - registers all I3C devices added by the controller during bus
- *   initialization
- * - registers the I2C adapter and all I2C devices
- *
- * Return: 0 in case of success, a negative error code otherwise.
- */
-int i3c_master_register(struct i3c_master_controller *master,
-			struct device *parent,
-			const struct i3c_master_controller_ops *ops,
-			bool secondary)
+static int i3c_master_init(struct i3c_master_controller *master,
+			   struct device *parent,
+			   const struct i3c_master_controller_ops *ops,
+			   bool secondary)
 {
 	unsigned long i2c_scl_rate = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
 	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
@@ -2535,10 +2514,49 @@ int i3c_master_register(struct i3c_master_controller *master,
 		goto err_put_dev;
 	}
 
-	ret = i3c_master_bus_init(master);
+	ret = i3c_primary_master_bus_init(master);
 	if (ret)
 		goto err_destroy_wq;
 
+	return 0;
+
+err_destroy_wq:
+	destroy_workqueue(master->wq);
+
+err_put_dev:
+	put_device(&master->dev);
+
+	return ret;
+}
+
+/**
+ * i3c_primary_master_register() - register an I3C master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ *
+ * This function takes care of everything for you:
+ *
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ * - registers all I3C devices added by the controller during bus
+ *   initialization
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_primary_master_register(struct i3c_master_controller *master,
+				struct device *parent,
+				const struct i3c_master_controller_ops *ops)
+{
+	int ret;
+
+	ret = i3c_master_init(master, parent, ops, false);
+	if (ret)
+		return ret;
+
 	ret = device_add(&master->dev);
 	if (ret)
 		goto err_cleanup_bus;
@@ -2568,15 +2586,13 @@ int i3c_master_register(struct i3c_master_controller *master,
 err_cleanup_bus:
 	i3c_master_bus_cleanup(master);
 
-err_destroy_wq:
 	destroy_workqueue(master->wq);
 
-err_put_dev:
 	put_device(&master->dev);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_master_register);
+EXPORT_SYMBOL_GPL(i3c_primary_master_register);
 
 /**
  * i3c_master_unregister() - unregister an I3C master
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 8513bd3..4f4d41f 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1166,8 +1166,8 @@ static int dw_i3c_probe(struct platform_device *pdev)
 	master->maxdevs = ret >> 16;
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
-	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &dw_mipi_i3c_ops, false);
+	ret = i3c_primary_master_register(&master->base, &pdev->dev,
+					  &dw_mipi_i3c_ops);
 	if (ret)
 		goto err_assert_rst;
 
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 3f22269..f1d6d68 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1644,8 +1644,8 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
-	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops, false);
+	ret = i3c_primary_master_register(&master->base, &pdev->dev,
+					  &cdns_i3c_master_ops);
 	if (ret)
 		goto err_disable_sysclk;
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 9cb39d9..e543f68 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -538,10 +538,9 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 int i3c_master_set_info(struct i3c_master_controller *master,
 			const struct i3c_device_info *info);
 
-int i3c_master_register(struct i3c_master_controller *master,
-			struct device *parent,
-			const struct i3c_master_controller_ops *ops,
-			bool secondary);
+int i3c_primary_master_register(struct i3c_master_controller *master,
+				struct device *parent,
+				const struct i3c_master_controller_ops *ops);
 int i3c_master_unregister(struct i3c_master_controller *master);
 
 /**
-- 
1.7.1

