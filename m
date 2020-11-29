Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA72C798E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgK2OY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:24:29 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44214 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728025AbgK2OY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:24:28 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ATEM0ZJ014440;
        Sun, 29 Nov 2020 06:23:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=j+GZsRC16L1t2nfuRac4mfXyCDHqZU4/Su1RM0sH57LGEOQuavkC8igVdnUlPWBY0qXD
 /ayGL1C4gj+SlpLH2F9ccb2gbo6GY9vroRPCus1r5tXZ0Wxw22MRPEbDF09i1ZNPCkQB
 iZ/DR7yCX13+226BD9g6Tknjjdp27kCtxzpKQi3AEDkYn3MJwzxVjWM5rGFVM8+QnW7D
 ip6PjRvXGX4U/dhR2nV/ZrciwKW1r2z2S575cmGhU/ywS6JM3jg8ZM6RP7vVXfHZt9gb
 S3HvEa+Ae3Bm3wYOaZKCktumG7W3tMJ2AudgUa/7p1iiMS5qye5uhWoqMzbJkH662zQO GA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02tf6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 06:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqdp/Wyt9kioRsyXa+W4Afj4XoFATWsHXbvh2N0Y24zBASET7QLj7bJxaFeBUP7Rg0OkB61BA+VEWO5moPhf39pY4h8wj1kNPv+Cr8DMZgcLhOSWnc77h8GD1bmSc8z3D62/Y5KdUjIYey+6qU3nHQwDuQCzxLGzDHWECjV27YP8IaeLDo8XBaLX5uu2NiW1q+UkJ7CpVqV9RgOMXMpMex2kKYlVC3IBjC4JEoixfIso3eM+UTwitw+UFLdIum+cNxBhN29Lho7iktFA4BQ6vmJWMH9s5xq1VJ8i6cXMTjZ46d2NFDZUYNFDX7A5YIDyGDrgozTmpaGOBJfPR0+kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=IcbL5UsYm2Fnrk/pB/tqnzeK3hWstv2a6SoGGKL7jAJ7CSXI2eX6/+olu39lMWT7opsK6nTXKKsrKnwP+p1Wbguxyx2ediunZvJ4Yd7ArLXCGw9FLrOFzTmXXeuaj6hy5tgKXJvbxsqlQPVvAwBsWQD/3/FEuCVWDuMwOoIw+ZtKHbK4a9uY0MynSMs3KTMXpR+yqHZm2Sniks2r997ssBaqqIY6COPVlJF0uj9fOyWNZAFzhYJzji8OCR76fNPiuEGQ5IMmkTR+bDxYQ3cGiqRKXJbsEA9k1/TSz/dviBnvHwQpqLp+XuRExNEWs13eg/NGNSYnTgAYVbg8/md5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=lNEcPANACfd4w+QLb1EAUREi04BOggZiQK1FAf9UEKJltMUoF4HqXI5SFOVM6+/fZHn9JFFd8BK8Bi52XrVuk+fbwWXeQA8HFAwR8dDGDtQwN6c7f9QhVf1lkmJW0iVf2dsE2CgCvi7IQcySMo64upwUCnvYJGHKTeTDjNSey4Q=
Received: from DS7PR03CA0103.namprd03.prod.outlook.com (2603:10b6:5:3b7::18)
 by BYAPR07MB5269.namprd07.prod.outlook.com (2603:10b6:a03:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Sun, 29 Nov
 2020 14:23:34 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::5d) by DS7PR03CA0103.outlook.office365.com
 (2603:10b6:5:3b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.26 via Frontend
 Transport; Sun, 29 Nov 2020 14:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sun, 29 Nov 2020 14:23:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATENVUo004766
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 09:23:32 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 29 Nov 2020 15:23:31 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 29 Nov 2020 15:23:31 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATENVrU019766;
        Sun, 29 Nov 2020 15:23:31 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ATENVkL019765;
        Sun, 29 Nov 2020 15:23:31 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 5/7] i3c: master: add defslvs processing
Date:   Sun, 29 Nov 2020 15:23:29 +0100
Message-ID: <1606659809-19710-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
References: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5394c338-fbba-4312-3b36-08d894725aa5
X-MS-TrafficTypeDiagnostic: BYAPR07MB5269:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5269968EE2C87BFDD0B52B91C1F60@BYAPR07MB5269.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnvvJykEBcJ0rVefXUHOuyrQOEq89DQYVfVqu1StorHCak9X087Qcf1dXE8mbF3V3v1h0YYPt5lxhpy5kexQG3gkLCdO6+Y5hcu19S9VUPgEtkoW+WHs0WI9Ry1Y7fNL87QItsEoxbXm85pm93S+X/WH8ntoH2fdmir61raRQ9g0wK9AbS6yDxijOFEOoWjlxAzEDJYu8BJgqkmiDtRLgY94EywhTkR2pl1R83uNBhltn784EfabhIGgDGHmpAlQd1X5aPQDKTrcVmys8pbpucNezlFs1d/IITBr2RTYZiX92pxZsPxsxsz9MSUfcodwNs6Hg/1qCeh5H4bV1Y9j8L487/dcqiAh3KIYiJSRzyEwSTGMzz2eKUB2ymXmdD/qRTFq3r2Iuj4GEgMcfHDKX9jOfvEq7Z+CpVWYXyUfJJ0=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36092001)(46966005)(82740400003)(336012)(426003)(110136005)(186003)(8936002)(26005)(82310400003)(478600001)(36906005)(70586007)(47076004)(316002)(2616005)(42186006)(54906003)(36756003)(8676002)(83380400001)(86362001)(107886003)(81166007)(70206006)(4326008)(5660300002)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 14:23:34.0116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5394c338-fbba-4312-3b36-08d894725aa5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_07:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011290097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added defslvs processing code to the I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       |   68 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/i3c/master.h |    7 ++++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 51ef706..c01ba00 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2172,7 +2172,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (!master->secondary && newdev->info.dyn_addr != expected_dyn_addr) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.
@@ -2867,12 +2867,20 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
 				  struct device *parent,
 				  const struct i3c_master_controller_ops *ops)
 {
-	int ret;
+	int ret, sz;
 
 	ret = i3c_master_init(master, parent, ops, true);
 	if (ret)
 		return ret;
 
+	sz = sizeof(struct i3c_ccc_dev_desc) * I3C_BUS_MAX_DEVS;
+	master->defslvs_data.devs = devm_kzalloc(&master->dev, sz,
+						 GFP_KERNEL);
+	if (!master->defslvs_data.devs) {
+		ret = -ENOMEM;
+		goto err_cleanup_bus;
+	}
+
 	ret = device_add(&master->dev);
 	if (ret)
 		goto err_cleanup_bus;
@@ -2905,6 +2913,62 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
 }
 EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
 
+static int
+i3c_master_populate_bus(struct i3c_master_controller *master, u8 dyn_addr)
+{
+	struct i3c_dev_desc *olddev;
+	struct i3c_ccc_dev_desc *desc;
+	int ret, slot;
+
+	i3c_bus_for_each_i3cdev(&master->bus, olddev)
+		i3c_master_put_i3c_addrs(olddev);
+
+	master->this->info.dyn_addr = dyn_addr;
+	i3c_master_get_i3c_addrs(master->this);
+
+	desc = master->defslvs_data.devs;
+	for (slot = 1; slot < master->defslvs_data.ndevs; slot++) {
+		ret = i3c_master_add_i3c_dev_locked(master,
+						    desc[slot].dyn_addr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * i3c_master_process_defslvs() - process I3C device list received in
+ * DEFSLVS for device plug/unplug and address change.
+ * @m: I3C master object
+ * @dyn_addr: Current dynamic address of this device
+ *
+ * This function may sleep, so should not be called in the atomic context.
+ */
+int i3c_master_process_defslvs(struct i3c_master_controller *m, u8 dyn_addr)
+{
+	int ret;
+
+	i3c_bus_normaluse_lock(&m->bus);
+	ret = i3c_master_acquire_bus(m);
+	i3c_bus_normaluse_unlock(&m->bus);
+	if (ret)
+		return ret;
+
+	i3c_bus_maintenance_lock(&m->bus);
+	ret = i3c_master_populate_bus(m, dyn_addr);
+	i3c_bus_maintenance_unlock(&m->bus);
+	if (!ret) {
+		i3c_bus_normaluse_lock(&m->bus);
+		i3c_master_register_new_i3c_devs(m);
+		i3c_bus_normaluse_unlock(&m->bus);
+	}
+	i3c_master_enable_mr_events(m);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_process_defslvs);
+
 /**
  * i3c_master_unregister() - unregister an I3C master
  * @master: master used to send frames on the bus
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 77c0422..835f823 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -478,6 +478,8 @@ struct i3c_master_controller_ops {
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @defslvs_data: list used to pass i3c device list received in DEFSLVS message,
+ *	from DEFSLVS controller driver to I3C core
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -497,6 +499,10 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct {
+		u32 ndevs;
+		struct i3c_ccc_dev_desc *devs;
+	} defslvs_data;
 };
 
 /**
@@ -523,6 +529,7 @@ struct i3c_master_controller {
 
 void i3c_master_yield_bus(struct i3c_master_controller *m,
 			  u8 sec_mst_dyn_addr);
+int i3c_master_process_defslvs(struct i3c_master_controller *m, u8 dyn_addr);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
1.7.1

