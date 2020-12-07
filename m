Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4A2D0E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgLGKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:16 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31368 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgLGKmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:15 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AZlhi029920;
        Mon, 7 Dec 2020 02:41:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=c2i3MZ0TZ1JtlaiY4HJmXI3ifmhGY1U5MY9q44oX8bs=;
 b=AS9GSupaAKnzyHERyQWG4FdQfo0ZzNMX821KzwztOR/WULpO99VAC7og4r1zwG2ITsxt
 iK0XFKGFTs4Xall9Lqbjb0f5yX0K/6yuFa+R05jGBNyu06k+rzLZpdKPh/Gzl0p95171
 3JREh3FjnwQZRf9zIX+BeRZzGMMphERM41DoLGdF3xTkG2liOya0sGBDm0vWjJUJRlXQ
 5xROFhkWVRJxyxfbcjqtCIHZCNur3fRnpX2nC6cEN5rfBVvYxYNk1jOYIhC/XDB0A3YP
 ry0L4dOmhmJ2pMfxzb72U/XT75hzMG56PL+YJcayRNigSSluAMXZo++vValxmScxBMvT RQ== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3586p3vc2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPFFq0NVSukmIZ4wIDU95TS9Rzc45WqmSBpfqTUJFSk77VcLQ/gSLkT2bbVrY9aYTEMBNq7bQsy6iLnFEbFcDc1sAgdYA2RtfYc9Cggjo5hERQ7Pl28wSdL3qq6ee0eXL/LcpTcayAQgb14xvT1404u4UOVIojGG8lUeXbGNs0/mZNHMwQr+dsd19NX9p52Nsd8cqfB5LdDXIUZvyOj9+ZaZY2GUE1lwyxwNzU4HSUuPsOLYonTK1LYmDHpZBcvYYT2XqeeKSGMDem7XeAQujIrlqAwUFMW8nEBi73Z+gnEGyp755tVcNZ/oID1MqAnEBXxPPoPIzFoDAxXRF3hJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2i3MZ0TZ1JtlaiY4HJmXI3ifmhGY1U5MY9q44oX8bs=;
 b=VOurub6Mu4GwpFNBPHpci6J7HDERfV6IRNRiijSOfciM3BtnsmPG0AUOZJYxIIlJOpuah3ow06OEu9sangYNVD/QYgsUTylj3gBc64wcF2eG1UAUJN5Ileli4fT8jOIuFVDU8v7LWDuTc6zzNC/8UKYA9+8geJFyAy5/7QmAGwBJ8WuOXlEWQI/3lGaCub2zSQzLwTftD6yQ+tffD/PRkRKtQ5lgq5BejelYUyOrshC3Meb7siw6pzqcDJ9ibrysTWGZfr2hSrnYrMcEEPvD0qBMYCYXJG3tu1qR+fw7G+YAFojRteujy4N7BpTAtkINXZzieO7R45pTiWxmxrUbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2i3MZ0TZ1JtlaiY4HJmXI3ifmhGY1U5MY9q44oX8bs=;
 b=Pv6olep+eFgQ/79aGKFtvbTq5qZEEPVRldNEooy5hCB19GrC7jZUzmoaUFVI8S+OwhwIfPFpT6ntdxtaiyj0lc4uFZnWxv2yBVCE2hhH0lhvqT9NB11v0IebVc1Lz1mecphBUjJGhFI9RyYKFOHUiZPxdMxNQmi6wae/wNetPdc=
Received: from MWHPR12CA0031.namprd12.prod.outlook.com (2603:10b6:301:2::17)
 by SA0PR07MB7580.namprd07.prod.outlook.com (2603:10b6:806:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 10:41:02 +0000
Received: from MW2NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::4a) by MWHPR12CA0031.outlook.office365.com
 (2603:10b6:301:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 10:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT064.mail.protection.outlook.com (10.13.181.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:41:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuT6007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:41:01 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuNM006440;
        Mon, 7 Dec 2020 11:40:56 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7AeuSg006439;
        Mon, 7 Dec 2020 11:40:56 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 05/10] usb: cdns3: Changed type of gadget_dev in cdns structure
Date:   Mon, 7 Dec 2020 11:32:22 +0100
Message-ID: <20201207103227.606-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
References: <20201207103227.606-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50aba1e7-6d9b-466d-352b-08d89a9c975e
X-MS-TrafficTypeDiagnostic: SA0PR07MB7580:
X-Microsoft-Antispam-PRVS: <SA0PR07MB7580F71ADF5D5284ADC69689DDCE0@SA0PR07MB7580.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhIEeOC/yDG7CXeWhvV3kX/xDdX5ClpX0PVVb+5vKEWSrCuwbhM4leqRtAVw/1Ku3STkUUzw+Lc5j5jQD/MM3ojjHwrBqJIKDtKj+LjCR/OGpwyNwYMWf6f7AiW2+qQ6OLeFZ8j0qcz5tNEToCgRDlTcBwVmfwOnmBtuTEBb9yN3XJaWif+VPsPlOeDrR8BfG8+KBC9YDMwS7aUSOZH/zM5kTRw7PlziLFlmQpJ/nGKhCbfqFA3g1C2zDXGn1G/P83fcCthBqIwoT77+dFug2Cfb9CbaEm77qOaY7j9+7mYFAfdzf/rLXrDJ0y97NDArt/7N1pk4C2LxUoOzLOlsKtYPz3YjNwHtXNQaR+hhsWekPVBwDgUkPwukEzbvT6p3gE+8f6tkui8xACToqXKKA9Xken0w7CgME3MiT2Sr08iqOz2nnbat/PD2t2Q6h7P3wSpPQXBMPUnKd2oxEjGcng==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36092001)(46966005)(7636003)(47076004)(34020700004)(1076003)(82740400003)(5660300002)(356005)(107886003)(82310400003)(70586007)(6916009)(86362001)(83380400001)(6666004)(36756003)(478600001)(4326008)(2906002)(426003)(186003)(336012)(70206006)(42186006)(8936002)(316002)(8676002)(2616005)(36906005)(54906003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:41:01.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aba1e7-6d9b-466d-352b-08d89a9c975e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=1
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=377 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch changes the type for gadget_dev pointer in cdns structure from
pointer to cdns3_device structure to void pointer.
This filed is in reusable code and after this change it will be used to
point to both cdns3_device or cdnsp_device objects.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Tested-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/usb/cdns3/core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index f664eb2d8df4..cbd2e1cc8eb1 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -64,7 +64,7 @@ struct cdns3_platform_data {
  * @roles: array of supported roles for this controller
  * @role: current role
  * @host_dev: the child host device pointer for cdns core
- * @gadget_dev: the child gadget device pointer for cdns3 core
+ * @gadget_dev: the child gadget device pointer
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @mutex: the mutex for concurrent code at driver
@@ -104,7 +104,7 @@ struct cdns {
 	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
 	enum usb_role			role;
 	struct platform_device		*host_dev;
-	struct cdns3_device		*gadget_dev;
+	void				*gadget_dev;
 	struct phy			*usb2_phy;
 	struct phy			*usb3_phy;
 	/* mutext used in workqueue*/
-- 
2.17.1

