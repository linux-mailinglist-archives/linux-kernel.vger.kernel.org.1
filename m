Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE37A2CBE31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgLBN1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:21 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45992 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726556AbgLBN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:21 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DIU85005094;
        Wed, 2 Dec 2020 05:26:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=hyczcB3uvkkoLUDgdZLRPDhYRg0a62qZU9eyTUGLljtDVltv8zkQQM0mjxji1z9j9nIx
 oinf1o2W7EQ68BD7lbI1ad3XfS4q8kVUapiO48fqSaMRiv9wCGTh1nWuytPkpLvlq11H
 LSYNtKo6l9OBKYVKTClmrVS9UMTJ7iO4yY8fu3P3jbqOqHDG2qqmdWuMFx01HdAEjPTv
 bZtMlWVKW9kSiTMfCH/c61zG0Mnvr2pzTeZhvO1NtgY6dX+aXN+p2B71WxFFz22r/2zv
 mhOfewXzIcBJUQHbIGRL1iTZdRf+1e2IubUmS33mSiPVWierwDJjOGCjwlVwL2vOV8hv 5Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 355vn4jjv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSLyNtnjuyz1m9RucpbHMwn6B9fwMmCSA5WR3mS6FVJe5G00qAVs93Rx8CDDJzJHF+BIXrCgq9jKHLz3FutbqMbYcsZbLGs+2CzeimSGZ7SJAqB2VTrN97TxJeFImytYapbIrLKYT0K5uHyrcb2CVY9SfzqKbjFeVavQ1/XzVZKcC+1y6lV8gR2Yw98Cg3FsgUYF0M0x9vBQuDzurj2tiTLpaaUYUEZxf0aduWJsm+DrqB6nHE8QIWOJgwMe0BB0hMS5kkqpAN+audQihhMQAJvZ9VA1fKTu53RAU9r3gMd5zL4G0Bc+3VuPxEuISeuMt23joPGlgmh4MCQpqsGCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=fwGEXijbDtVWQD5pjFp7hBXSQGgOg4vAsc9YeZnVFvxOw9eY3pJxLaolxyYweidGb0QP4E7CYbC1NeiuzlyCymHUHnMlFr0XeBzpC3gw67YFxXZSiLDCmEdbYRvT3IrsjcdU6PnfrD20PxVcGMaY5yiSMO97JF2JNuU22FKshlNJioaGJYqBMbFshY3ArhAh1Z16sZgriX++aL9UbyLyFtlBxvWS5LSjATyaSrngbKOM5FwnRknWyWKjYVv/Kp1imNg0+zG3jmlBUg8YYkvFLsS3N/rXqMCU2ScaamL37Vvd+eB+ZrYDKIfD38pO/bIjEhdmRL0+obqsBQb6S4U6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=qcD3wMBeggPU5m0Z1fytsuoiRMN9tfw3RRpw1Gwe6qw2f3mNB8LpM7CfhMoyerC8XvOEt4x+Y2scAeC6RBYLaBGTBolq73jjJ0HQ3n9c+RhvIKMsqMTzH+lo7Mmt4EOQubY3qOnYI6rO99tlVTpsJdvLLbS3jWjUV2IjivwV4SU=
Received: from MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20)
 by BYAPR07MB5157.namprd07.prod.outlook.com (2603:10b6:a03:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 13:26:12 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::79) by MWHPR14CA0034.outlook.office365.com
 (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Wed, 2 Dec 2020 13:26:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6oB007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:11 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6Xc010807;
        Wed, 2 Dec 2020 14:26:06 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ6ww010806;
        Wed, 2 Dec 2020 14:26:06 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 05/10] usb: cdns3: Changed type of gadget_dev in cdns structure
Date:   Wed, 2 Dec 2020 14:25:43 +0100
Message-ID: <20201202132548.10736-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7842077b-8d93-4865-1b59-08d896c5d6a3
X-MS-TrafficTypeDiagnostic: BYAPR07MB5157:
X-Microsoft-Antispam-PRVS: <BYAPR07MB51575D8E645CF91974EC7A55DDF30@BYAPR07MB5157.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOL0YwUch7x+WQLZLlXWHdYjZ3APK3YNsWWmASvRc/UGFwxU9iVO7/AZYQ7kE2vpbmU3d/p+UybEmNPaI4kL8RTc+8IZIqX0KRb+GfOd6am7jXUeECljcp1AxF1xfHVM6ECgQcE5COTuNPT3aWPuYnJSXdhMlZVMBvzTqUd5Pdf4ln53IMW3tAOxFo2WP+ZybLcZzjOW3RGOojRm+qOI7xchF0rYyxC7FF5O4V89R7zc1mm9Al8ym8EuNpSY7XcUovG8OD4CgJlKN04eZxuW9zsGGUIm8t7/oxO38pg5pnSXD5YTpDjsacU5Iq8TbfN5eMnsSW9bSNHYfK1RinFP5d52qltwG/NSgX366tnrFc4AlTt8YZYjfRuh0yKT5T8cHPCV7GTJ+RQpFEB/fZbVFpaGnZDvEp3OJAZNsntzBAQ=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(46966005)(54906003)(1076003)(7636003)(2616005)(186003)(336012)(42186006)(5660300002)(26005)(82310400003)(86362001)(478600001)(83380400001)(426003)(6916009)(107886003)(356005)(8676002)(2906002)(47076004)(6666004)(36756003)(70586007)(70206006)(36906005)(8936002)(82740400003)(316002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:12.6102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7842077b-8d93-4865-1b59-08d896c5d6a3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=1 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxlogscore=337 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012020080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch changes the type for gadget_dev pointer in cdns structure from
pointer to cdns3_device structure to void pointer.
This filed is in reusable code and after this change it will be used to
point to both cdns3_device or cdnsp_device objects.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
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

