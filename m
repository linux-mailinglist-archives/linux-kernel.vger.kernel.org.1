Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C527ADDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgI1Md4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:33:56 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56464 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgI1Md4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:33:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUDl1012178;
        Mon, 28 Sep 2020 05:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=owI1d6LPIYaT6nmsetvZIgTvIO4hxUxnxPf3IbnJ01Q=;
 b=b/3J6N0kBNmGoWCPordfCirBRup+pBxeGybxi1aHz0L9rlM31aovON0ZGKER3QQnAsmJ
 2ar9RGpl41cs/kDMYotzkWQDr+CAUVtPT9r3za8+GzgVYH2lyd4fuYhtlOzowxxI5ueB
 tPiegtzS264ENU3Y+bAn4e1rgkjD8crjAw0zMxcfZ7y+1gmXvRviWK1BwNKJDvkEjSX1
 rv4iZHfe+TVrURbbvu5Ssufu1fS7JtQYmmpK+XVnb5YGgUjfCdWUZoCR8TUCTuXYpbF+
 9cp7VXm5mX98YB6GayXTanR+twhsi43sJ6T5A04KXoVUONa3hmxn0QOp0rHDq5BdEDjs 2A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blvLyq60wgdB1497uoArMC+HYcvtVcWvHN/8Bphh8P2nVHa6mnREjB4rkEZME4JG50ndBvzHhjyJPZ41YVUdD1qH9cIZOu/UgL98P2Gj4j6jB2TigEi+qEmgJvMU87/r1jt+Q7Ups47hExALkUFdEwZOjcFAzfF4s/hxq1nguqAFA6eob3LVRDY+pFP5KKKss8WMdRaAVkvAVHRIcLF7Rsqd60DweO8tQ9TMmofkD+JYzTuC0Bmx7OS4tPm1Ju14WCABkvu7ruO7m3iig7m7SvUHSX/+3G9Irh0tWWlJ7VwER+PJ9YahffYpK8hbGed6qnv9V0fAL8EpeWPwGCva+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owI1d6LPIYaT6nmsetvZIgTvIO4hxUxnxPf3IbnJ01Q=;
 b=R7PeHdFDixRDFWXGAikycFFsxmaA8GFEeQNsJkhl9u7RGo7lxMMK6rUuJ4csSlvWLpD98Mfg3NeEJ7mxcBM6UGFEQqBLvxWTtbM/L3LfX4zQgEUBfUJYtTWK+u0oVSER6j0uIv07l+xQR9TsogVtYeLYBjOkolAf3vgV2wpMkJBm+iLdpsWMtsIDBfGB71BIDWGqFk6ZICbB2w83YBWWGlTw+Jlu2tCfsE9nHINoO9z1PTNpvsw5xDIFnh5BfsqsI4i8bT2cKiVHs1r4xL/Y3E1k4c00zNZsShJXjvQFKO7R7dxHJhJEFV0WbUUt5EJiiUdhVSiLLmgsTBb/SyIgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owI1d6LPIYaT6nmsetvZIgTvIO4hxUxnxPf3IbnJ01Q=;
 b=wkS6N2LS7FGmb2kwGqWenmG1TfZIYMDAJtHUWncpyxWtS3+RjXRtkQU6McI2U5rDAwgcHLn7b2T1zif3Fns1LNpcVGYAg6tNgEekiIbRTFuLF0WgWg9U+ku5Pd2CHgvaKwVmgNHTu7Htary5Ixt0AePDoXqBTnTSFwkSsK6LjQs=
Received: from DM5PR17CA0070.namprd17.prod.outlook.com (2603:10b6:3:13f::32)
 by BY5PR07MB7061.namprd07.prod.outlook.com (2603:10b6:a03:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 12:33:32 +0000
Received: from DM6NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::93) by DM5PR17CA0070.outlook.office365.com
 (2603:10b6:3:13f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT035.mail.protection.outlook.com (10.13.179.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCY030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:30 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQkM019092;
        Mon, 28 Sep 2020 14:33:26 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXQEs019082;
        Mon, 28 Sep 2020 14:33:26 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 5/8] usb: cdns3: Changed type of gadget_dev in cdns structure
Date:   Mon, 28 Sep 2020 14:27:38 +0200
Message-ID: <20200928122741.17884-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
References: <20200928122741.17884-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0e6f8ce-e752-4412-605a-08d863aab5b7
X-MS-TrafficTypeDiagnostic: BY5PR07MB7061:
X-Microsoft-Antispam-PRVS: <BY5PR07MB706182F15399A93F6B2378D9DD350@BY5PR07MB7061.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5ZPi3FSm5K+zdk0uiiUT3CS/VegYU+xwibKHWnVLjkIEovsm/tUcjO4VFSHZOia09M9kidRtSKbVPmd/WSAscrrv8cojTvyfGi23zK4v1950hTGXYANMBYL1vSlKwQr2H2pl/mvAGZNve3XvihJcO0hQREMLb/bgm+omAfy/wqYieQKaUwo2bl2sdZ5updcVhstFBH2Vmw+6wNVWhwTHqVV5ayEDXJEUFRQYRcj0DS4BgYS4aG7Tp9kWyzJl1fhe2AhwLhkaMfZcHdtIKGI6/aIjQqhvERikvAYMchzGWnoPrcrLEpYh40za07N1ziIGAImilhNsB6cY7FlIo+TkPs8BLm5ciyy9frsWWJzxl0xCMWyZBZ5eZNRU4O7u1DfAwxu6lE8vKz0Jsx+eR1M9UQk9/NlqwwRTnQqgj4oViSLpermM2PPe8+iVlRNIFu1hSOz05a4he6jw6iuncN/LEh9J8nrMV5EBqmyVyBj/3k=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36092001)(46966005)(36756003)(8936002)(8676002)(336012)(478600001)(70586007)(70206006)(7416002)(54906003)(110136005)(36906005)(6666004)(5660300002)(26005)(86362001)(82310400003)(42186006)(316002)(186003)(4326008)(82740400003)(47076004)(83380400001)(356005)(2616005)(81166007)(1076003)(426003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:31.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e6f8ce-e752-4412-605a-08d863aab5b7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7061
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=393 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch changes the type for gadget_dev pointer in cdns structure from
pointer to cdns3_device structure to void pointer.
This filed is in reusable code and after this change it will be used to
point to both cdns3_device or cdnsp_device objects.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.h   | 4 ++--
 drivers/usb/cdns3/gadget.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 0c6e14683b36..267923904a37 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -55,7 +55,7 @@ struct cdns_role_driver {
  * @roles: array of supported roles for this controller
  * @role: current role
  * @host_dev: the child host device pointer for cdns core
- * @gadget_dev: the child gadget device pointer for cdns3 core
+ * @gadget_dev: the child gadget device pointer
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @mutex: the mutex for concurrent code at driver
@@ -87,7 +87,7 @@ struct cdns {
 	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
 	enum usb_role			role;
 	struct platform_device		*host_dev;
-	struct cdns3_device		*gadget_dev;
+	void				*gadget_dev;
 	struct phy			*usb2_phy;
 	struct phy			*usb3_phy;
 	/* mutext used in workqueue*/
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 26f68182e65e..f9cbc84bbfb8 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3177,7 +3177,9 @@ static int __cdns3_gadget_init(struct cdns *cdns)
 static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
+	unsigned long flags;
 
+	spin_lock_irqsave(&priv_dev->lock, flags);
 	cdns3_disconnect_gadget(priv_dev);
 
 	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
@@ -3186,6 +3188,7 @@ static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 
 	/* disable interrupt for device */
 	writel(0, &priv_dev->regs->usb_ien);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
 
 	return 0;
 }
@@ -3193,11 +3196,14 @@ static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
+	unsigned long flags;
 
 	if (!priv_dev->gadget_driver)
 		return 0;
 
+	spin_lock_irqsave(&priv_dev->lock, flags);
 	cdns3_gadget_config(priv_dev);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

