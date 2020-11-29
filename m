Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33342C7984
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgK2OWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:22:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20964 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgK2OWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:22:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ATEL9iF012596;
        Sun, 29 Nov 2020 06:21:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=YnvZcBuvc+a6gyMSsPneXg62ppSH83W7U4NeNffyVoIQLRDjaWLPvgwW5nuDvNeIe625
 E8LvRf+z7LEVmAsxLIhaHdk1w4U3oBFUm/RPsVeGj0fErXtcmWiBle6QXrwsJiUky1ZH
 sAGfDoHIrsDzsLg1qtfyJiNvzZMhirlv/9OEqTI9SeKSybna3++AZgpVMLXke6aZzwFc
 ea4Gy3cF4sNiUV+Uk8APgLxgzqeHNdpkaZTksv2eRq++aEtZ2Qjdtd26gS/LmSHABvdQ
 0KwLD/qvYls70Vg/DWB6jG1u7ao2yN7yflU3WFNz8Z+tZwMaZZE0t3UVruRORCnL37CP Wg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 353k12jj54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 06:21:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlXZlwbZ+WAUkrOPnpPSiMbCFZ6cGm51+uOwTahoJTWCbDTfdHIVMRmqxAvPeemmCIV+CtSMEeWPFxsFE8DeRqKtsz5/3v1KYvNnDC2f85dJf3cgBJjo2qUsmLda+rlJ8KnTPYv9dHxUTOjhS8xU8Y58tp7VQVOTR2A88JpBpJWFgKhSiClUaDHozUOUtHc+XZ9D2hmlA31HWg7lmezSbd35ml7oiiaeS/5YN1d6F+sj8pYhdZvoqeR5pptD0Z+eNsQadcRbO7p/v2F0Cc27yindd440kmCVXeAMxq/PRH0EPADWVadq8zPRzUPhCjepU5st8cIm68ssuTmEV2g/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=UGxaDrKmgKYOzta60rRkRnUr8PQD5t73fSrV0mhekFme9IvBBbtklZD+8m0kd0Itce45azM2RNN7HVuYeT4GDiWWMJTe9qaTXr/vHgLopa11MyjX2YAftTim/xK6OPDHDhpO91NiqwOigoMtaLLHtQL1JGaY1rwezumzzDDGJ94IV+rAjlp0A4QSs6mZV2t+L91DVz3M1KgpMxFrLW+m1J5EKLqEcdjcMVl9UiH8P2sb+ir6SgtOZqPjY/v6HXEQOtxI6f7XRI6jIGyv6a16oXu+Uhfr8QL0jZCpOXtySq7F4gy8ZcfA5siz3lOKciY3LTFag/dyg1p3C2/TrAQqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88SHouuxN1T5NkpQIeQ9gWus3kkJctUiZ2A8oMY0QhM=;
 b=cxzOCHXlOLXXCVs6zv1CKdRacIBzZstQWSwCpJKJZepmFjcFSOIztZ8tiSnAhH+xDc5qFOolZGsuRPMLPaau5We/qKp7yRlRp1GPsxTr1VO0SYGpF0qHmSzvP4ztFbGWOnlEuaX/as9f2SAv99DMA28KnPxozZBnI7pHIBut3Cs=
Received: from MWHPR18CA0057.namprd18.prod.outlook.com (2603:10b6:300:39::19)
 by BL0PR07MB4964.namprd07.prod.outlook.com (2603:10b6:208:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Sun, 29 Nov
 2020 14:21:04 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::1c) by MWHPR18CA0057.outlook.office365.com
 (2603:10b6:300:39::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Sun, 29 Nov 2020 14:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Sun, 29 Nov 2020 14:21:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATEL17w004618
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 09:21:02 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 29 Nov 2020 15:21:00 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 29 Nov 2020 15:21:00 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATEL0pu019376;
        Sun, 29 Nov 2020 15:21:00 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ATEL0w4019375;
        Sun, 29 Nov 2020 15:21:00 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 1/7] i3c: master: master initialization flow document
Date:   Sun, 29 Nov 2020 15:20:59 +0100
Message-ID: <1606659659-19337-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
References: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2fd9099-1f1e-4660-5087-08d894720134
X-MS-TrafficTypeDiagnostic: BL0PR07MB4964:
X-Microsoft-Antispam-PRVS: <BL0PR07MB4964E9463098F074DEE05AB2C1F60@BL0PR07MB4964.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n2JM36sKkpEblOCkhA3p/y3ERzh8la4UncGzABlNI0GtHBp8xN61QKzxSAZnnSSpxK1krhNGMjrpFno57UIh/uG3Pgla4DUIZmxU078mapwF5SO3izd3QdYVOyEXbDF0eoombJTHISGW1gwqAkZym37b2bFi3knqYe01pdK3do8p6hKV67XPSTo5AD3yNka+coLBdUlRof1YmDMePh/MWxOnqvbOvsEmo/x5Zz9uNtCm8nxurEtVxbTLtsbNLbxgpZ3P0WDHMudIbylDcOTl7EfGj4e/23soS57G59uvfT9DtHZz3KISdp9O6+xDDR22oFAy5Mjqv+hFLP6Pf8zfsOE6gY7ICVz+YfsALcAjdxKdgzeNxQpK0F8KRukOLB+oDvSytzLQjiA6jlwXr8XTV86H/y/5BtUgT8QaB+qs0k=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36092001)(46966005)(110136005)(86362001)(82740400003)(83380400001)(478600001)(4326008)(42186006)(81166007)(47076004)(5660300002)(26005)(316002)(36756003)(186003)(54906003)(2616005)(107886003)(356005)(8936002)(426003)(82310400003)(8676002)(70586007)(2906002)(36906005)(336012)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 14:21:03.8814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fd9099-1f1e-4660-5087-08d894720134
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_07:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=2 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011290097
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

