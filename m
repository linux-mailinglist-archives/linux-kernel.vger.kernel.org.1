Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5F22C7E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgK3GTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:19:11 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57906 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgK3GTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:19:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU68bUA014443;
        Sun, 29 Nov 2020 22:18:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=pf21OGi+1QsAoZcDaCXKi0UjSqD93lfOIlnHKCNh9L2TOQWdAIwibvs4A7m9f7GnVcyY
 4Ia8L8V5cz+kfMmLOjsxbvMz60nheO+IHI6fDzOWA1zXfnBrsMGKPEC6r/YVOZCPNJ32
 lBAcTsauvYZe36Av7w2Qs7DnIRWfeNttw4d6NNzoDFTLmJHR/Q347/9B3vGY1IfVPY2a
 OH/lTqf+OgDeFjaHM5qnn/pYU8uYZsW5i+H1SLp4Tq+bX9gq3zKV+jvdUoXgGrjYM4xD
 182GenREilCvKYyFtgADIcbbwexShgTOVZNEJFev2lPDpzqIhLUkOSXBclFwWCZ2GC05 ew== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v1w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:18:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ1QLLcaQkCkXtqnAs8goeD5Rebcwn8cXmCl7WrCnYTzTl7+K6C+xlKwpduEaQJWxG6iZ2mWGmqmyyZWEV3zNKE64KzrDHIiwWNFBu12tIZBu6j88nY5q9XTojBykx3bdEXkitNKc0pF9FCWhWML54OTGTkBt2PlEw5YQokJDNWy8roDHZlpbXoOM22z6ZEMpP1Jw1eBbIjap81TcETtzoxCtpesmDrDCafujyJ8DtiR3u0xavGQSMfE2NoMrLUXuo5KTq+Zs9YqKWZcnT8d615EJly0MBkOVn490+GvP3Rbks6m6wSLPCvdP/KMuTERprsJ/LjOeA7yQN4VYUkXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=ZrMn29J0h1u77tn0Sy2xLFPcNHgOXEfRw6EakWw7iXsnIChySQXqJNlRgDv+/5bhYGidmASqPZcUvucKrJ6y8XDnscb/t4ExnjryTxIdy8TBzjubVC6oovMFIOEhvJcT0hZnHI4HyB+7tP/fG9sbkHp94JFUvaO/UNv+zlPDZgRf/9d4bmPmFPd9hTXnRMdpdysFb5rV/c00WhdLTymnhuqv1T0tGCn2WCDxQhvxetpdyA18dcMkc6ihtnAXc0TtI+QH6p/XgfT0OZNcZ8ARixYcwWR84oECklffLbwvB34j/q/YuVD3s0FQXZjo7ObIYAgtixOdOANYzCgDdp9uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAot8ZKLmBihRtXXOEijPs4fo3Dtmbdp2ADXmAaIpfw=;
 b=m2u0nMM4FfM8eLJbkAtk14hvlIHyn7TBB3jsuoPlx3lCQNC0bwLPIL5/3DrMiJG7gj97rLTvBGBUQGsFglgUttjWmDn3hzD24mfEbQiE0ULsZhmhJOd1fPZEVASO3qMEwzU9GE2lhpZmbBgMh6e0/y7QptlygVyxiSa8nHkfhnE=
Received: from MWHPR14CA0044.namprd14.prod.outlook.com (2603:10b6:300:12b::30)
 by BY5PR07MB8102.namprd07.prod.outlook.com (2603:10b6:a03:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 06:18:19 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::d1) by MWHPR14CA0044.outlook.office365.com
 (2603:10b6:300:12b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 06:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Mon, 30 Nov 2020 06:18:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0AU6IDo7027742
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 22:18:15 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:18:13 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:18:13 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6IDNS003883;
        Mon, 30 Nov 2020 07:18:13 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6IDoA003882;
        Mon, 30 Nov 2020 07:18:13 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 3/7] i3c: master: add i3c_secondary_master_register
Date:   Mon, 30 Nov 2020 07:18:10 +0100
Message-ID: <1606717090-3847-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a907ae73-2f2f-40cb-afa5-08d894f7b9c9
X-MS-TrafficTypeDiagnostic: BY5PR07MB8102:
X-Microsoft-Antispam-PRVS: <BY5PR07MB810229EE5E08940873AB6EAAC1F50@BY5PR07MB8102.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIPXVFCNd1J/z38HrPnTkssnQHLct2X9BA0SOoneWObRJMJonaZ9gQOUV25iuaLQc2iEJIeS042M69wLg1oT5zW1n3OWvlu2KnJKekN+R3MyfDydhO5JCkmi+E4uAGMhqTVzuLt1EuwNW+MO/WK/c40DQbxI6Hn3F4Bb7GOicr4zbY+gnLINGjL5wiLcvly9r8RbJ49SX7vOHSdoRMvObo2BSmT9+KURlFrpXtmPkhx0ShiGwOSMP/TnKRIgKFA5t1NuJkowmz4RJVn5piQ3tM8LpOoPtETwOrZnNEeNofqIeKHHvesHutL2C3VfsaSx+ms20YJZIFpix47mqezKrwKEjFSRLkJ7D9lYYydekLmJF+WeJ+hiXl+R13wMm5RGk8KUo96KyQsv5BFF6syqIDNTTVM8N9EMRESHH9m/ZSE=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36092001)(46966005)(81166007)(26005)(356005)(186003)(70586007)(86362001)(2616005)(4326008)(107886003)(70206006)(82740400003)(426003)(82310400003)(47076004)(83380400001)(316002)(336012)(8676002)(42186006)(54906003)(36756003)(5660300002)(110136005)(8936002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:18:16.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a907ae73-2f2f-40cb-afa5-08d894f7b9c9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB8102
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300041
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

