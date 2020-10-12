Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42ED28AE49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgJLGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:46:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11892 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgJLGpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:45:10 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C6fqSD007642;
        Sun, 11 Oct 2020 23:45:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Srz9y+3z5XbLmoC1PCkaYtgC3cTPcmDg6qX/DwjhnaM=;
 b=XAkRwjVw6nXiNYTHRtzgpBvY3gd3NLVQCVZB6QeeFrsCn02gNitioAWM7P+aDnehaFTF
 iUoYZ0DGkgyjZ4OI4m7A2bvwdkT6BuWlntC0MED8qmN+7RIigc3PZ1DJTK+fT0BmSRjH
 36A33+GL/1e3bhXo312xLxQCIBP8yUBkfChOp4U0tXnTQjdOWY7h6NJtRSqUFL+pDYZ8
 nEae37Iw/0s2n0P9Op1xw7/Cek3+udNb01gx8aPR7YLKkOGKJuGCGtdl2tqMgG2ut8T1
 JEcILQfMGRXX+tpmtncB8sD8iDfGHRQy3sV8FcBhj9l1eUBhMATwO0jVgJRe6GaSXW71 Ww== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3439gvw6de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Oct 2020 23:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2L2uSw4CbG9cdL7YUPLuDXQotk2x64KXKsLkkmeKyL6NvDAOpN2CZgBmiWznQH0V+xMXM7pesHth9Su1amM47Lo4vnriARL2RVwmtoUEUD5O0gvbpvawPINmcw2L7u/VAKv9ApN+Hv+Vm9WGwDNNBl03dYWbR/5+IQmB4xuI0PAidQiR+6+ysHjDvZY7cJqx0xt7UErX7KC00Op/ECGcNRJ5XpE36QMgJruLxHEhRtXOeJgr167My8Ab7jEvDhWjrJt/E8ovXRK+saUnbL8YDi87n8pp1uKgo/I/ajFT0yBl0v7ximpW56kT+7AnPIrQmIShl4NQDjtnSjX8ChfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srz9y+3z5XbLmoC1PCkaYtgC3cTPcmDg6qX/DwjhnaM=;
 b=JXxVpXqhMYELpFjciQOOISOTMWX9/5dGnH5uCv0v7HYa0k89iW5X7XIwEFnBp4r/cAW1tEEf7LLwPFdyKJKYrpdKpkCtSwvEg/s4jw7nPEMMMGNrlOFfQz5vvaapyggeUd4tzi7awqH5QhZnZDsozagylJKiSBgn9Ft7ic8evhiLiCYqX/JZvvNo/u5j3NPyoEY6C4kaJP+JwOMBUyZupX1DllRBOaUuWPJQYJV1xM3GnFxuUBFXritHFrjETlYF5SjPN3+YSb1Vk+zf/llYhoR3kcKYr3NanWnHyE2LjMjFzc2JTmZSUwwdD2iJXQMHm4uoxypK7IAKJvbuS1OaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srz9y+3z5XbLmoC1PCkaYtgC3cTPcmDg6qX/DwjhnaM=;
 b=UT9i94N4JYLK2pvgW0raSz/+U12JlnCGYb44Jt5/rdRvVk1i8C/qRQjQ2Mq8UfK/v1FmtgoMZj0A8/r2UZm8o7Bp+M8QogT9/c4iStZmyV1yjTazmB2PdI8+qsrZ/6bsgni+a+Kd4jpDiqME24Gd5FLtM1hvesWgy89nFf4/kww=
Received: from DM6PR06CA0007.namprd06.prod.outlook.com (2603:10b6:5:120::20)
 by BN8PR07MB7988.namprd07.prod.outlook.com (2603:10b6:408:72::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 06:44:57 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ae) by DM6PR06CA0007.outlook.office365.com
 (2603:10b6:5:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 06:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Mon, 12 Oct 2020 06:44:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 09C6itjZ019006
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 11 Oct 2020 23:44:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 12 Oct 2020 08:44:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 12 Oct 2020 08:44:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09C6iqYf008533;
        Mon, 12 Oct 2020 08:44:52 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09C6ipp2008531;
        Mon, 12 Oct 2020 08:44:51 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdns3: Rids of duplicate error message
Date:   Mon, 12 Oct 2020 08:42:56 +0200
Message-ID: <20201012064256.8344-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b0447d-5835-4c21-3645-08d86e7a54f8
X-MS-TrafficTypeDiagnostic: BN8PR07MB7988:
X-Microsoft-Antispam-PRVS: <BN8PR07MB79882C9D327FF0FE8E3EDDCADD070@BN8PR07MB7988.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyXeVPzUusYZ9AIwdof1Na5ZcV+oEEZ6wFC9XMQHAHaIz5g0KanYM8mj/a9x1iDun5QqJOZxjzObMnfDNxiEM2mO+tWerwhekHtaRmaESA0N1nF0TJ+vD/dQXQlxu2R+GE0gI6zNl68ZxaMl0kQfefdJC6A5rjnm1mycYJj5zE7X4zJ6qNqaFFYN3B3s2sqdTs/lv3I+UQcAZn3xN84zjddR62F5lbbDw6/Lac6yKeYRKM/XHFJnIlYGgakyqUxMc4NFrPYyhg1mYmaS5x5tNBH8NjGsAlbqhbqbTF5l4fTBOLg5nrWLNxzx7XlI1RL0nkRfuOawhzkyj50FTTa1WpQXBm1WjUsFuCeF+s9eCpjXlyegZR+8B829IAnmMJ4T7jOWQ4YEGhgayjxyfVVfFPLUty5SC19PEUO5Gb2n0g18s+UQivLX42wew26+47uMmcrn/RdzvuQ3vkre745FUg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36092001)(46966005)(86362001)(6916009)(83380400001)(426003)(54906003)(26005)(15650500001)(1076003)(336012)(316002)(2906002)(4326008)(42186006)(34020700004)(82310400003)(36906005)(2616005)(186003)(8676002)(8936002)(7636003)(36756003)(356005)(107886003)(5660300002)(70206006)(478600001)(47076004)(82740400003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 06:44:56.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b0447d-5835-4c21-3645-08d86e7a54f8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB7988
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_03:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=1
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=710 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure, the platform_get_irq_byname prints an error message
so, patch removes error message related to this function from
core.c file.

A change was suggested during reviewing CDNSP driver by Chunfeng Yun.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2
- simplified code as sugested by Roger Quadros.

 drivers/usb/cdns3/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..85ef3025b293 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -469,22 +469,14 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (cdns->dev_irq == -EPROBE_DEFER)
 		return cdns->dev_irq;
 
-	if (cdns->dev_irq < 0)
-		dev_err(dev, "couldn't get peripheral irq\n");
-
 	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 	cdns->dev_regs	= regs;
 
 	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
-	if (cdns->otg_irq == -EPROBE_DEFER)
-		return cdns->otg_irq;
-
-	if (cdns->otg_irq < 0) {
-		dev_err(dev, "couldn't get otg irq\n");
+	if (cdns->otg_irq < 0)
 		return cdns->otg_irq;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
 	if (!res) {
-- 
2.17.1

