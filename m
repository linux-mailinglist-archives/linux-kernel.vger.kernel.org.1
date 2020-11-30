Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD862C7E17
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgK3GR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:17:57 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41920 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3GR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:17:57 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU683w3014038;
        Sun, 29 Nov 2020 22:17:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=OFiIHvZSL6bvdpskpP6ERAVb1D4EVIO1OaR+el3fwXjAwR9kMTVVUjLUsS1onPIE3f5i
 3imx++ry8i24pxhQMTF1PpXzCigbooCsbiYaw+ZbSlK4Uv7yAOYmkAyafEhiYq95ckxD
 szXJU1WlRioN2SA7Ej68vkx1uR+CHR/tDz06ZDHbiRtfT8uoH7ZuTwFx9DDXIdmX4Ner
 lsk95uxpugGV3eeZ5YGYqo0zCZB7MtopNzpN3GAdROx19YmE9sK6bhs7jBLTqbtS50iV
 OnizNN4XrVfOpTyNv2BffbalOxCCP1kDXsGhsYQQBchE1tj9GRFbrf5NsoEpSmOa+Kci Dg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v1ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:17:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfBVBH/WouWKbsXIHQI+PdGjENcYzk3l54oG1e5Qr1QpgSwnSHr1iCYSuYQ/uQqcfEaJYAx46SNKODXHuWhJlqYdK1RrVpfXAyFvAkBs8GBNECXKsD+JNXC75HcxHEz0uzymLPb7G7l/WSMY3p0KfT0ERAhxaapNsvWLkq+wr0En7e0QYkmPbutGDouTmJjVRVXKzmDVF9Ywku50MEFonX7iMVZrLPrzPraYcc7ERe5KMBHUu3MkgIGKq7fzDXn3qvZWMzhDRZPOxUMpio5DxK20zDBPphcD+Lp9wjBs2XKh5I58zQgqoFQCABvWdgxpYBfCDBV9Yry7SVOWafyx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=P9NlsOKRDy5vyyDdhOe6xQ4nu4z8o0e9t7tAWr/BVQ03u6pvKcAdHtTIrRyIjDbHXSwdvGTwcARx9ulHOQAYHM5CV/A5WUEZLgwaXfUQTuYqhEz90vBCCLwQY1l/M/BRBzAfs7lQM9SrDaqKF6qoBVM2ravtE2TmThKbbK7Y/2q2era/x7N5162Z4kzB1RbWY/gd6bC/aN0VxlbRRxK3Uyb8TyZocm2gFKU6ep0S9i/wpC1X2MOfwOFolM00zFCsUP0Q3O+mtEkd81nnwCZUhLcL6CM2vRHXujsmwILnBYmhbiaZZGnQcXfScmvHhiry4FujT+ZHKgkHhCGPWCHRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=FYJs7IWn+OEPde1EXIf0c6eccH37c58Fcf9wKk6Ob/OAdhde8Yj4CtBbIDi9bZXlkOIEDq1c82s37iRADwFlw+j+LwbGjKLwfGpkhtpV5rOIwm8jLqbMVR68fttlQpSuJp4bcBtrnR2p0G7ru2+zX+o7JoLemwsWycFpjxUVqg0=
Received: from BN8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:408:c0::33)
 by CY4PR0701MB3649.namprd07.prod.outlook.com (2603:10b6:910:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.26; Mon, 30 Nov
 2020 06:17:03 +0000
Received: from BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::6e) by BN8PR15CA0020.outlook.office365.com
 (2603:10b6:408:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 06:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT006.mail.protection.outlook.com (10.13.183.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.11 via Frontend Transport; Mon, 30 Nov 2020 06:17:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6GwdN016313
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 22:17:00 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:16:57 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:16:57 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6GvVZ003734;
        Mon, 30 Nov 2020 07:16:57 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6GvTr003733;
        Mon, 30 Nov 2020 07:16:57 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 1/7] i3c: master: master initialization flow document
Date:   Mon, 30 Nov 2020 07:16:55 +0100
Message-ID: <1606717015-3697-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82ed261c-483d-4a76-0547-08d894f78db6
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3649:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB3649FA003BCF26EB2C23369EC1F50@CY4PR0701MB3649.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMqNtQHaeEKyuPKmbjMXP7QMfJ5SZ27fJSZCsj3IpuDEmYP7eZVzCorvqMgw6Rry2DsGMhFkdHynhTpRUQPwdo2jKufz9rSUUdZ+JWr3Ll/knnYJNVjyOgmoV1p5jMKDzN4wjji4dF1p2EmkRBuPT6bl2MaOylNFICyH91KoyapARy20S924S8q7zEr6FifVhr44IeOJ+/sllDIzeFKgcFy0F2CbE8Y9CFd2PxAm8X/42B1KGoVogMfb89PLy3fZQPuFEUlI2JmXu6fMDxg1WVRO4lxgeiVGbne97x1niYwtOJ13REiidk+yd5kfEN8nK5trcIfCJ5/NwmY2oYhwwsXNl3nifwMND7csMm0wacc4PMq4CrAEveOR+gc+rKLVN3brCZuhXZNPtLQMjCXc5kdf58ORonfqVPI7YWMGW6I=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36092001)(46966005)(7636003)(356005)(86362001)(2616005)(426003)(8936002)(82310400003)(36756003)(47076004)(5660300002)(83380400001)(107886003)(336012)(42186006)(4326008)(110136005)(2906002)(54906003)(8676002)(70206006)(316002)(36906005)(26005)(478600001)(82740400003)(70586007)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:17:02.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ed261c-483d-4a76-0547-08d894f78db6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3649
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

Document describing master initialization, mastership handover
and DEFSLVS handling processes.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 Documentation/driver-api/i3c/index.rst             |    1 +
 .../driver-api/i3c/master-initialization-flow.rst  |  187 ++++++++++++++++++++
 2 files changed, 188 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/master-initialization-flow.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6da..604f1c5 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   master-initialization-flow
diff --git a/Documentation/driver-api/i3c/master-initialization-flow.rst b/Documentation/driver-api/i3c/master-initialization-flow.rst
new file mode 100644
index 0000000..e02b90d
--- /dev/null
+++ b/Documentation/driver-api/i3c/master-initialization-flow.rst
@@ -0,0 +1,187 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+I3C Master Initialization Flow
+==============================
+
+.. kernel-render:: DOT
+   :alt: I3C Master Initialization digraph
+   :caption: I3C Master Initialization Flow
+
+   digraph master_init {
+       ranksep=.25; size="35,35";
+       subgraph cluster_0 {
+           style=dashed
+           x0[shape=ellipse, label="I3C driver probe", style="filled"]
+           x1[shape=diamond, label="Secondary Master ?"]
+           a1[shape=box, label="Do I3C master controller specific initialization"]
+           b1[shape=box, label="Do I3C master controller specific initialization,\n
+           except enabling the DEFSLVS interrupt."]
+           a2[shape=box, label="Call i3c_primary_master_register"]
+           b2[shape=box, label="Call i3c_secondary_master_register"]
+           x0->x1;
+           x1->a1[label="No"];
+           x1->b1[label="Yes"];
+           a1->a2; b1->b2;
+       }
+
+       subgraph cluster_1 {
+           style=dashed
+           label="Current Master";
+           a3[shape=ellipse, label="i3c_primary_master_register", style="filled"]
+           a4[shape=box, label="Initialize I3C master controller object."]
+           a5[shape=box, label="Create I2C objects for devices in DTS and add to I2C list."]
+           a6[shape=box, label="Set appropriate bus mode based on I2C devices information."]
+           a7[shape=box, label="Create a work queue."]
+           a8[shape=box, label="Call i3c_primary_master_bus_init"]
+           a19[shape=box, label="Add I3C object representing this master to the system."]
+           a20[shape=box, label="Expose our I3C bus as an I2C adapter so that I2C devices\n
+           are exposed through the I2C subsystem."]
+           a21[shape=box, label="Register all I3C devices."]
+           a22[shape=box, label="Broadcast ENEC MR, HJ message."]
+           a3->a4->a5->a6->a7->a8; a19->a20->a21->a22;
+           a8->a19[style="invisible"];
+       }
+
+       subgraph cluster_2 {
+           style=dashed
+           label="Current Master";
+           a9[shape=ellipse, label="i3c_primary_master_bus_init", style="filled"]
+           a10[shape=box, label="Call bus_init to do controller specific bus initialization\n
+           and enabling the controller."]
+           a11[shape=box, label="Create I3C object representing the master and add it to\n
+           the I3C device list."]
+           a12[shape=box, label="Set current master to the object created to represent I3C\n
+           master device."]
+           a13[shape=box, label="Reset all dynamic address that may have been assigned before."]
+           a14[shape=box, label="Disable all slave events before starting DAA."]
+           a15[shape=box, label="Pre-assign dynamic address and retrieve device information."]
+           a16[shape=box, label="Do dynamic address assignment to all I3C devices currenly\n
+           present on the bus."]
+           a17[shape=box, label="Create I3C objects representing devices found during DAA."]
+           a18[shape=box, label="Send DEFSVLS message containing information about all\n
+           known I3C and I2C devices."]
+           a9->a10->a11->a12->a13->a14->a15->a16->a17->a18;
+       }
+
+       subgraph cluster_3 {
+           style=dashed
+           label="Current Master";
+           h1[shape=ellipse, label="MR request interrupt", style="filled"]
+           h2[shape=box, label="Bottom half i3c_master_yield_bus"]
+           h1->h2;
+       }
+
+       subgraph cluster_4 {
+           style=dashed
+           label="Current Master";
+           i1[shape=ellipse, label="i3c_master_yield_bus", style="filled"]
+           i2[shape=box, label="Check if this device is still a master to handle a case of\n
+           multiple MR requests from different devices at a same time."]
+           i3[shape=box, label="Broadcast DISEC MR, HJ message.\n
+           New master should broadcast ENEC MR, HJ once its usage of bus is done."]
+           i4[shape=box, label="Get accept mastership acknowldege from requesting master."]
+           i5[shape=box, label="In case of failure reenable MR requests by broadcasting ENEC MR, HJ."]
+           i6[shape=box, label="Mastership hand over is done."]
+           i1->i2->i3->i4->i5->i6;
+       }
+
+       subgraph cluster_5 {
+           style=dashed
+           b3[shape=ellipse, label="i3c_secondary_master_register", style="filled"]
+           b4[shape=box, label="Initialize I3C master controller object."]
+           b5[shape=box, label="Create I2C objects for devices in DTS and add to I2C list."]
+           b6[shape=box, label="Set appropriate bus mode based on I2C devices information."]
+           b7[shape=box, label="Create a work queue."]
+           b8[shape=box, label="Call i3c_secondary_master_bus_init."]
+           b12[shape=box, label="Allocate memory for defslvs_data, that will be used to pass I3C\n
+           device list received in DEFSLVS to the I3C core DEFSLVS processing."]
+           b13[shape=box, label="Add I3C object representing this master to the system."]
+           b14[shape=box, label="Expose our I3C bus as an I2C adapter so that I2C devices are\n
+           exposed through the I2C subsystem."]
+           b3->b4->b5->b6->b7->b8; b12->b13->b14;
+           b8->b12[style="invisible"]
+       }
+
+       subgraph cluster_6 {
+           style=dashed
+           b9[shape=ellipse, label="i3c_secondary_master_bus_init", style="filled"]
+           b10[shape=box, label="Call bus_init to do controller specific bus initialization\n
+           and enabling the controller."]
+           b11[shape=box, label="Create I3C object representing the master and add it to\n
+           the I3C device list."]
+           b9->b10->b11;
+       }
+
+       subgraph cluster_7 {
+           style=dashed
+           d1[shape=ellipse, label="DEFSLVS interrupt", style="filled"]
+           d2[shape=box, label="Controller driver can chose how to handle I2C devices received\n
+           in DEFSLVS."]
+           d3[shape=box, label="Read all I3C devices information from DEFSLVS message\n
+           to defslvs_data structure in the master object."]
+           d4[shape=box, label="Call i3c_master_process_defslvs."]
+           d1->d2->d3->d4;
+       }
+
+       subgraph cluster_8 {
+           style=dashed
+           d5[shape=ellipse, label="i3c_master_process_defslvs", style="filled"]
+           d6[shape=box, label="Acquire I3C bus mastership."]
+           d7[shape=diamond, label="Bus acquired ?"]
+           d8[shape=box, label="Handle I3C device list from DEFSLVS."]
+           d9[shape=box, label="Call i3c_master_populate_bus"]
+           d10[shape=box, label="Queue defslvs processing task for retry."]
+           d5->d6;
+           d7->d8[label="Yes"];
+           d8->d9;
+           d7->d10[label="No"];
+           d6->d7[style="invisible"];
+           d10->d5[style="dotted", constraint=false];
+       }
+
+       subgraph cluster_9 {
+           style=dashed
+           e1[shape=ellipse, label="i3c_master_acquire_bus", style="filled"]
+           e2[shape=box, label="If device is already holding the mastership,\n
+           just broadcast DISEC MR, HJ message and return success."]
+           e3[shape=box, label="Call request_mastership method"]
+           e1->e2->e3;
+       }
+
+       subgraph cluster_10 {
+           style=dashed
+           f1[shape=ellipse, label="request_mastership", style="filled"]
+           f2[shape=box, label="Return success if device is already in master mode."]
+           f3[shape=box, label="Return error if device don't have dyn_addr."]
+           f4[shape=box, label="Return error if MR requests are disabled by current master."]
+           f5[shape=box, label="Send MR request"]
+           f6[shape=box, label="Wait with timeout until MR_DONE interrupt is received."]
+           f1->f2->f3->f4->f5->f6;
+       }
+
+       subgraph cluster_11 {
+           style=dashed
+           g1[shape=ellipse, label="i3c_master_populate_bus", style="filled"]
+           g2[shape=box, label="Free up all I3C addresses to handle address\n
+           re assignment by main master."]
+           g3[shape=box, label="Master acquire dyn_addr received from the driver."]
+           g4[shape=box, label="For every I3C device in the defslvs_data\n
+           call i3c_master_add_i3c_dev_locked."]
+           g1->g2->g3->g4;
+       }
+
+       a2->a3; a8->a9; a18->a19;
+       b2->b3; b8->b9; b11->b12;
+       b14->d1[style=invisible];
+       a22->h1[style=invisible];
+       d4->d5;
+       d6->e1;
+       e3->f1;
+       f6->d7[constraint=false];
+       h2->i1;
+       d9->g1;
+       a18->d1[style="dotted", constraint=false];
+       f5->h1[style="dotted", constraint=false];
+       i4->f6[style="dotted", constraint=false];
+   }
-- 
1.7.1

