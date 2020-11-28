Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE62C7352
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgK1VuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58268 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729169AbgK1SHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:07:38 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ASEbvU6013117;
        Sat, 28 Nov 2020 06:47:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=jH3/o7IxIIV9rmCYfPO/fIQfQwnGuHN6O0ayFTa3GKJ0n7d9YbDIMMAuc/KpFZrlNDde
 gUZdAxoBqN4YQs5Sq+n8L8nkV974zc8Kc76AxL9ZgbfRQDCkrqe6xX+BJ7QwtAXzLV6J
 ZjBMlgaugT4J7ebtI13Evv4LUbtL2YcNTDtsTw3XToyLBs9dnU9HTRS4VDVMrzZer91K
 4eWOWBU+vOsbZB2RM8T/fsLczo/cm9Q5PKaT4MbNBfr9oeY6emExo25vZBHvCLCOVuYa
 i4RZlDWw6t/bB54uy6c+Pf4xNh3kdAJnhDx4s/n2jwR9Ro1LQHk+sqc//sfdqyfi6AxS WQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02rf4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 06:47:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO7zdh6bTmqvNA2uGzh1mJR6xue41vL7JwXUEZHi2XvI/R+d8QYJqOsI4+h/TBeT/4MsXh9zgGVlUL6Lbnd5Z1JlAyI+fu2LjuT+wNm5m+3T70TOcM8t3dSoivojwKrvKF01TjkpA4SPuddQsP++nOq2ksmMUGzWxGH2cbtG4bjjq3yEFbx88mjLLkBfzUiEdoV+YnZs2t2eYS2mCe9UewXOMrkRQOT7zkVPqPdEbdmLxpI0qmmEPH5hzFhD3Pbke6OgbP/f93P8kb+UrLF0sIR47rYwQFHICDGtxttpDSIYr3tZlG7oglpjS6BnWnkLewmzZhcrNf/sm8QvnsM4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=UVDvHbEmhyEsm6FXr3g136bC4sd5X6csFkIwvNk3O/hTvi0/lB9vepFew+odFCkXO/Xnl5VwheMWU/fohUc7782zzQTEQrtifn4SaNsYE2Qwe3hAGXHLuuKdy7znWt+fz/8MnpSsewApC0gD2H2OIUraV8zUwh/YPHTFYjlV8Zbc3cdMpF+vbER4j3GocYlIaqvNLUHmF+9wVtYyg732zhrJDbdMePGi73vTgM77r8MV/Y37awBE9RnbleVsWljv8Zq/TofaFkCxIMeW864P1V0PsZfgk7PYtw/NA0/pzmnbaXepPIZoPAFmofBEU/ubCkbZGm+s5N6yIF8q4dpZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3xuo9c6g9jg2s/GancGklUt4jhLGdxsMbfrj+14mdk=;
 b=tbH2MjVBdHuZ50Em03pBTUqlS6z1qGmdr6Ac8hypHF3F8BILdgK4VKMhEwrY4/o5kFKRqy72IdFvzietwQadyP6rBlFt1V5Tep8w1amfY5umAp91mczELkTwj8DO2FjPRa/JMjMHWxRETXKhMhZYWAnl9w7GJyunsydB7LFxQsU=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by BYAPR07MB4344.namprd07.prod.outlook.com (2603:10b6:a02:c6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Sat, 28 Nov
 2020 14:47:29 +0000
Received: from BN8NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::59) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Sat, 28 Nov 2020 14:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT029.mail.protection.outlook.com (10.13.183.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sat, 28 Nov 2020 14:47:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0ASElO7H143977
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sat, 28 Nov 2020 06:47:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 28 Nov 2020 15:47:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 28 Nov 2020 15:47:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASElNIf021366;
        Sat, 28 Nov 2020 15:47:23 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ASElNZS021365;
        Sat, 28 Nov 2020 15:47:23 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 4/7] i3c: master: add mastership handover support
Date:   Sat, 28 Nov 2020 15:47:21 +0100
Message-ID: <1606574841-21330-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d7676df-30fa-494e-d67e-08d893ac869d
X-MS-TrafficTypeDiagnostic: BYAPR07MB4344:
X-Microsoft-Antispam-PRVS: <BYAPR07MB43443780AD1B76CFA44AF7EBC1F70@BYAPR07MB4344.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwm9P5xziWBpPrSNkAQHLvLiZxbVZxxSWDE3QzSFucxTYdFJKQYgEOGJ8ohHRtWlcHYL8/PaWu0oNZAOVxzgqADVt4IQDNEovbhDBiOfTc4u1NXyHqXevhREUY2UkJPZYWiul9Hd1lct0mL/C1bewSxWaqPapm1Y/068tw2LYUguhxL3YRvdKdKDFIgFKOgmmy0N/271dSoWusAonrJHDMcjqIKBVdGAn//j+BeQ/fWZ15in1bUTHd3gqF9LqvYjTyBQeOeZqZpABkJBQ/3jnDxiZPkVQTLcKK7sHGnOcrN/e3gsYy1VN+ol5N0RSF4ZyBf+Ry1PoStz6kAdi+CiBQ4VpJ5JZuUFONjAP5NkgGhNbjzgvb5kI7j+vKk40j2GhD38bRTwWwSduY/0TJQKBKDmzU4SlMxXAfiT7YhdHms=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36092001)(46966005)(81166007)(86362001)(186003)(110136005)(82740400003)(356005)(2906002)(4326008)(26005)(42186006)(83380400001)(426003)(47076004)(36756003)(54906003)(107886003)(2616005)(336012)(316002)(8936002)(478600001)(8676002)(82310400003)(70586007)(70206006)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 14:47:27.3595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7676df-30fa-494e-d67e-08d893ac869d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4344
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

