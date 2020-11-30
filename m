Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90442C7E24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgK3GU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:20:57 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38010 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgK3GU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:20:56 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU684hw014074;
        Sun, 29 Nov 2020 22:19:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=EZ1uO8XK0xu6/ABhmd5XCr9gpQT3w0QsH37WDPvkG0PgM/BjIE8yx/UP9vFK9k4C/3vs
 hFygpj4JnmMgq42mzZgNJtDgZ2lRv3koLrqBOIr68hy3ZB+5bOV6CdJftxfJ3IVZLs7t
 VCYIqNYpmujXMlo7y+HMK8V19TkvpcIyuVnOFm4tVr2rwvkzrEAfa8+KzGlZpizeBPPV
 /TAs11YEeoB16/XAitAZmQ4DKciUrAkYR+KunZ9IPc4KY0B6zJaX3h6mHM6VGrcZM34v
 /Rfp9bWSD0Mf6wcBb+fH8QVEFuPtzs4Lpk7xDQBfqd0tw+chYZpWTsevg52dyF6vcPy8 6g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v205-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:19:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQg5TNFuE8oHnFAU5kAxzaSEo6y1MgHdMH3qWIwtfBagkvftuHjUAUgsyObYULLyg19xxctry1S5kMzNEjCz+76HuX9u1YuF4FD4l+Pd+RVgwJPJfpGcORxbeQ9dI/bCknlHy6QdHP+7A3U352J2bs442FUEJeIULS4zUYmLMwv205zcHVBTsHFsQoOFE7Ed8a/8LjArkNNiZCvlyGALY57k+J2rcZF8skSDXbCkEQnGnrhsQcQx0gDTmqq76hFr53y/Vp0U10Rr7FcCdF+cmL98i79gT4pc+qcd8dluW4TY5B+EahUBfCqNQK7vfXe/wmoqHxW9lcwYWP8hf/yYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=Fic5rIpVYkB2N5RrGLvoC+12Da7xMGXzTzmf4Weyg2fIp5nFpp7BWv28X1MgdgD9l2SkeQo7xzlLSxIy2mj97EKqv1dChN34lRDZfVMHN3QnUVQ3AsOccQ8aHSO/PEmKax/SKXlg/1oJOAeVpYS4Ado/HpuheNluWVsI4g5/FuLvo7PaYqqpgQKz/oZfDy7bMsRHplU1OhG08HM0fFz1abI2qcE37bixoHJwNh082WX6nPBxcENjhwk97MMXkeAi/Y8te4y2n2o+QmxZVVXudp8Pd6vsrCJeKEQH+P6wjQ6hUnFw60Z9mScFhQ/XH+Ja/ypVBn4ZZfY+uNdhtYrkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVLEsxpNGaMWv/9e6vww9tEBk/03TpXXpSZn2TUCTBo=;
 b=zgL7QOSHkbtXlx6DXnrgWx+/S6mkq0rBWkXBeebkFoWJ2yKjjBIBiRwHHZ5OIHsOVYI7YxzcX75McnUWXkbX7l62wmlodB2EXNZBWKIYGGkCKhdqvaqIE7sVWh+DK8Z0G/ZjfqOExNQX/eTwpPiJQpyhe/3qixF+HnQitEiqZ14=
Received: from BN3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:400::38) by
 MN2PR07MB7101.namprd07.prod.outlook.com (2603:10b6:208:112::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 06:19:45 +0000
Received: from BN8NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::3) by BN3PR05CA0028.outlook.office365.com
 (2603:10b6:400::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.7 via Frontend
 Transport; Mon, 30 Nov 2020 06:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT007.mail.protection.outlook.com (10.13.182.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Mon, 30 Nov 2020 06:19:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6Jf72016587
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 22:19:42 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:19:40 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:19:40 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6JeMH004188;
        Mon, 30 Nov 2020 07:19:40 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6Je1q004187;
        Mon, 30 Nov 2020 07:19:40 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 5/7] i3c: master: add defslvs processing
Date:   Mon, 30 Nov 2020 07:19:38 +0100
Message-ID: <1606717178-4151-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e72defc-88bd-40a2-b50c-08d894f7edc6
X-MS-TrafficTypeDiagnostic: MN2PR07MB7101:
X-Microsoft-Antispam-PRVS: <MN2PR07MB71018D10B4EA2546268BC89BC1F50@MN2PR07MB7101.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj2LI+u6m5TLMJCQl6WXtQoCsfsCXa2Yi304Q61sdz9elLxECsLzAgY6hjnNItUqYgSA5sQqtVv55QhNZ1pjEVs14Leotl03LlxmItPtQM7e4AKMaaIIbgtJQWqHGO4/YiywYDnEvKlUFYFF/9gH79An6JMcO3H1e6KXs4WYNo93vU6y6eUJPNWDvA7Sinmxrcv/Z/DWvuSRL0zEWFIxGc9uKd4QnKH59wmTboome4Uus3CJA+ZeP0Swp5veVKIyv7VRI0hzTW1Fuobun1DGSzQmhhupvgw60odK5cqTd4VA48WRICJ8kLYere1MQgXhWMoaNljqmNBlK8iuB9VXdoex8HPPyyk4EdV2q0lTbg8F2UixviULrTdnO1DbYHm7A+V5WTrmWGnLCwJ4JLdXf80oGEAr8Z+EAs0x51zTjlA=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36092001)(46966005)(82740400003)(82310400003)(8936002)(36756003)(107886003)(70206006)(2906002)(8676002)(356005)(5660300002)(70586007)(86362001)(47076004)(426003)(7636003)(110136005)(186003)(54906003)(2616005)(36906005)(26005)(42186006)(83380400001)(336012)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:19:43.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e72defc-88bd-40a2-b50c-08d894f7edc6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300041
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

