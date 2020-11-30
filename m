Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678502C7E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3GUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:20:08 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16946 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbgK3GUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:20:07 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU6AVZG015661;
        Sun, 29 Nov 2020 22:18:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=TgLuS+NS8K0Eegm8ujd8fCLMaxsJEqUcdj0/VC9sfArz773KWTgZyvtBea+ujyxksRhs
 uC2vkyK005Srr8bTZ0YNTd4uu2cUVk4QegQ+zLOI32G0OhunO+7BY1wHUNSCFi96oobl
 qFNnWYBIKqRlW+xpC/thfl44Q4IrhiyG69VfpbyjEwfTb5oibpJZ0I959Q7bLFj7A7YH
 IRKX3OkMSLVie4rEKTuT2lQGX4H+KPnvpBfdUoWX5Tti3Yn2PGmSJ+vn2ctQfDR2SlTS
 OHvMnRE4gYHXs/q9Inz0EP4mBdg+QIkGHA4r3XwpqSkNjyC/p/kEqdDafmZwn6aEtqlU MQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-0014ca01.pphosted.com with ESMTP id 353k12m4v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:18:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Saufv8hD2KI6okuk95xZW7dAofp7widQTJ8uccVO+hrtx1F3KoyEUtQDS35290jdKCj05iN4W/eeK+ymzKMyuzH1LMpDSmdD2HPy7hknLonghcL0nMuK3xS9vgriY/SAWLn+xNf2K7qoCG/UQE6fv/Tum2JNOu6ADSKJlCvR/VOgD33NN14lomPfZqoT/zvGtlADYsIs0s3zs5XO/ba79jglwnWzrPRT6FGAh2kx2Gp8zF8OY66OVBU+lwi9Sn+A3hWD2dZXTToWUv9gjAkNNXAGJGcdyynH2xYNMBytGu0PffDZVeqv7NkNHMQC8XClPfdFIyl9vIz5Sgs4tHXQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=ia5Sg5zzWn++vpl80kude8rSnQ6TC02Yv3BnrfBkgKMAX087GbCiYgmbp7Sn06TsreifXiWlKzoMr10km4fF93t5FlU2JrNyD47sXY3iyFzs9rtfo6jZy9XEDwgi5KWu/2tiscvHTN49MFyy//IsI7inyuwXansvFvzJ2mDavs4TGcsU75z9QRS5M8v/jYUhgJlM2pq04mq5f59E0xudDNLuqssDN6QqfNn8/UlTA8nnqoRe7mkn8gYhw3dp153heXQv7GvWA36JDYSsfO8eQ7Pz1uTFMWbEACvDaBBGgrOCmDqS756CELW2b5sbLbohs5Owi4j+nfOGp4zi7UpZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=hsC8iL3jz6blfSlHK2G3k4KAAT55hKZB9ZR9XtElfU12Cum6t6MwB0eEWItf5GDKL56hIoen2fhIPilUJhcblQwrHcDAIPrs1tB5LSdkuMCvXlW+Js7Kk4U28b+AfEKO1C8NAQiJ7iUepmSDOTDikGPwTo5YLAs9N2agz5gVliU=
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by MN2PR07MB6207.namprd07.prod.outlook.com (2603:10b6:208:110::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 06:18:45 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::47) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend
 Transport; Mon, 30 Nov 2020 06:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Mon, 30 Nov 2020 06:18:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6IgDT000325
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 30 Nov 2020 01:18:43 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:18:42 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:18:42 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6IgpG004094;
        Mon, 30 Nov 2020 07:18:42 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6IgQM004093;
        Mon, 30 Nov 2020 07:18:42 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 4/7] i3c: master: add mastership handover support
Date:   Mon, 30 Nov 2020 07:18:39 +0100
Message-ID: <1606717119-4058-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 049be4b2-1383-45b8-1b0a-08d894f7cad8
X-MS-TrafficTypeDiagnostic: MN2PR07MB6207:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6207D551D5A4E62D664A5867C1F50@MN2PR07MB6207.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2R2ui0oFSs/bVhlpvebeS+F/PB2EAGIWZa17d+jUkNZWnkHizl+0juTO8HiZLzD1sgFP99RTwtKPUfNAV4EGqaNfxq6cfnyE4DSb07S1N604gKBLlQr9PxT92/hsukWWPhyHM4mn/2lWeacG2hycTqu814gdHsxr1jGlsPH77tgbesuo/JvLs8bOIbrsNNsYXOJHGX8hLSkWZaBSTV5Kvr2QIYtHN7Nos60BSx7F4MQim09IliEjmuUQp35jq1mB102euKhXj6En71IrbciRXHZBIAUInxOvd2oBKsYwHBs6IngUTDHjy+2t64W7kEGVwhOfC903/fcXa0ijTRPnSGDPSpzhUhx2iSaxkAzX1KUlFhATHgRK38Qn7hZh5y+gJVkxXHpOhBA3parG7040g/PDH7L5lkG1LbvQirJU8Q=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36092001)(46966005)(82310400003)(8936002)(81166007)(356005)(47076004)(5660300002)(6666004)(26005)(70206006)(83380400001)(2906002)(70586007)(82740400003)(2616005)(110136005)(426003)(54906003)(8676002)(36756003)(316002)(86362001)(36906005)(478600001)(336012)(42186006)(107886003)(4326008)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:18:45.2359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049be4b2-1383-45b8-1b0a-08d894f7cad8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6207
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=2 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added mastership acquire and yield functions.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       |  183 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/i3c/master.h |    6 ++
 2 files changed, 177 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index af0630a..51ef706 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -44,6 +44,16 @@ static void i3c_bus_maintenance_lock(struct i3c_bus *bus)
 }
 
 /**
+ * i3c_bus_maintenance_downgrade_lock - Downgrade maintenance lock to
+ * normaluse lock.
+ * @bus: I3C bus to take the lock on
+ */
+static void i3c_bus_maintenance_downgrade_lock(struct i3c_bus *bus)
+{
+	downgrade_write(&bus->lock);
+}
+
+/**
  * i3c_bus_maintenance_unlock - Release the bus lock after a maintenance
  *			      operation
  * @bus: I3C bus to release the lock on
@@ -451,6 +461,59 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
 	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
 };
 
+static int i3c_master_enable_mr_events(struct i3c_master_controller *master)
+{
+	int ret;
+
+	master->ops->enable_mr_events(master);
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
+				     I3C_CCC_EVENT_MR | I3C_CCC_EVENT_HJ);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
+/**
+ * i3c_master_acquire_bus() - acquire I3C bus mastership
+ * @m: I3C master object
+ *
+ * This function may sleep.
+ * It is expected to be called with normaluse_lock.
+ */
+static int i3c_master_acquire_bus(struct i3c_master_controller *m)
+{
+	int ret = 0;
+
+	/*
+	 * Request mastership needs maintenance(write) lock. So, to avoid
+	 * deadlock, release normaluse(read) lock, which is expected to be
+	 * held before calling this function.
+	 * normaluse(read) lock is expected to be held before calling
+	 * this function to avoid race with maintenance activities
+	 * like DEFSLVS processing etc
+	 */
+	i3c_bus_normaluse_unlock(&m->bus);
+	i3c_bus_maintenance_lock(&m->bus);
+
+	if (m->this && m->this == m->bus.cur_master) {
+		i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
+					I3C_CCC_EVENT_MR |
+					I3C_CCC_EVENT_HJ);
+		goto mr_req_done;
+	}
+
+	ret = m->ops->request_mastership(m);
+	if (ret)
+		goto mr_req_done;
+
+	m->bus.cur_master = m->this;
+
+mr_req_done:
+	i3c_bus_maintenance_downgrade_lock(&m->bus);
+	return ret;
+}
+
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *da,
 			 char *buf)
@@ -476,11 +539,12 @@ static ssize_t current_master_show(struct device *dev,
 				   char *buf)
 {
 	struct i3c_bus *i3cbus = dev_to_i3cbus(dev);
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	i3c_bus_normaluse_lock(i3cbus);
-	ret = sprintf(buf, "%d-%llx\n", i3cbus->id,
-		      i3cbus->cur_master->info.pid);
+	if (i3cbus->cur_master)
+		ret = sprintf(buf, "%d-%llx\n", i3cbus->id,
+			      i3cbus->cur_master->info.pid);
 	i3c_bus_normaluse_unlock(i3cbus);
 
 	return ret;
@@ -690,6 +754,33 @@ static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
 	return 0;
 }
 
+static int i3c_master_get_accmst_locked(struct i3c_master_controller *master,
+					u8 addr)
+{
+	struct i3c_ccc_getaccmst *accmst;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	accmst = i3c_ccc_cmd_dest_init(&dest, addr, sizeof(*accmst));
+	if (!accmst)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETACCMST, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != sizeof(*accmst))
+		ret = -EIO;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static struct i2c_dev_desc *
 i3c_master_find_i2c_dev_by_addr(const struct i3c_master_controller *master,
 				u16 addr)
@@ -1582,10 +1673,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
 		return -EINVAL;
 
-	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
-	    master->secondary)
-		return -EINVAL;
-
 	if (master->this)
 		return -EINVAL;
 
@@ -1594,7 +1681,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 		return PTR_ERR(i3cdev);
 
 	master->this = i3cdev;
-	master->bus.cur_master = master->this;
+
+	if (!master->secondary)
+		master->bus.cur_master = master->this;
 
 	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
@@ -1637,6 +1726,74 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 }
 
 /**
+ * i3c_master_yield_bus() - yield I3C bus mastership
+ * @m: I3C master object
+ * @sec_mst_dyn_addr: address of device requesting mastership
+ *
+ * This function may sleep.
+ * It is expected to be called with normaluse_lock.
+ */
+void
+i3c_master_yield_bus(struct i3c_master_controller *m, u8 sec_mst_dyn_addr)
+{
+	struct i3c_dev_desc *i3cdev;
+	bool dev_found =  false;
+	int ret = 0;
+
+	i3c_bus_maintenance_lock(&m->bus);
+	if (m->this != m->bus.cur_master)
+		goto mr_yield_done;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (sec_mst_dyn_addr == i3cdev->info.dyn_addr) {
+			dev_found = true;
+			break;
+		}
+	}
+
+	/* Requesting device not found on i3c list. This should never happen. */
+	if (!dev_found)
+		goto mr_yield_done;
+
+	/*
+	 * Maintenance lock and master check above is used to
+	 * avoid race amongst devices sending MR requests
+	 * at the same time, as soon as ENEC MST is sent by the current
+	 * master. It ensure that only one MR request is processed,
+	 * rest MR requests on losing devices will timeout in wait MR
+	 * DONE state. And next MR requests are blocked due to DISEC MST
+	 * sent by current master in yield operation.
+	 * New master should send ENEC MST once it's work is done.
+	 * maintainanace lock is also needed for i3c_master_get_accmst_locked.
+	 */
+
+	ret = i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
+				      I3C_CCC_EVENT_MR |
+				      I3C_CCC_EVENT_HJ);
+	/*
+	 * Once mastership is given to the new master, it is expected that
+	 * MR is disabled prior to that and new master is responsible to
+	 * enable it by broadcasting ENEC MR when it's work is done.
+	 * If DISEC MR fails and we still go ahead with handover, chances
+	 * are new master will get interrupted by unexpected MR requests.
+	 */
+	if (ret)
+		goto mr_yield_done;
+
+	ret = i3c_master_get_accmst_locked(m, sec_mst_dyn_addr);
+	if (ret)
+		goto mr_yield_done;
+
+	m->bus.cur_master = i3cdev;
+
+mr_yield_done:
+	i3c_bus_maintenance_unlock(&m->bus);
+	if (ret)
+		i3c_master_enable_mr_events(m);
+}
+EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
+
+/**
  * i3c_primary_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
  *
@@ -2522,6 +2679,9 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	     !ops->recycle_ibi_slot))
 		return -EINVAL;
 
+	if (ops->request_mastership && !ops->enable_mr_events)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2536,10 +2696,6 @@ static int i3c_master_init(struct i3c_master_controller *master,
 	struct i2c_dev_boardinfo *i2cbi;
 	int ret;
 
-	/* We do not support secondary masters yet. */
-	if (secondary)
-		return -ENOTSUPP;
-
 	ret = i3c_master_check_ops(ops);
 	if (ret)
 		return ret;
@@ -2665,6 +2821,9 @@ int i3c_primary_master_register(struct i3c_master_controller *master,
 	i3c_master_register_new_i3c_devs(master);
 	i3c_bus_normaluse_unlock(&master->bus);
 
+	if (ops->request_mastership)
+		ret = i3c_master_enable_mr_events(master);
+
 	return 0;
 
 err_del_dev:
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index e186d53..77c0422 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -426,6 +426,8 @@ struct i3c_bus {
  *		      for a future IBI
  *		      This method is mandatory only if ->request_ibi is not
  *		      NULL.
+ * @request_mastership: send mastership request to the current master
+ * @enable_mr_events: enable mastership request handling by the controller
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -452,6 +454,8 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*request_mastership)(struct i3c_master_controller *master);
+	void (*enable_mr_events)(struct i3c_master_controller *m);
 };
 
 /**
@@ -517,6 +521,8 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+void i3c_master_yield_bus(struct i3c_master_controller *m,
+			  u8 sec_mst_dyn_addr);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
1.7.1

