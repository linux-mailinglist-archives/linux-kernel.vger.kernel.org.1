Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCD2B9451
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgKSOPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36492 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbgKSOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJE6moV027517;
        Thu, 19 Nov 2020 06:14:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=eX3eQP0d4+HTTmH/tYrhDrpvZzopsZCxJzi4rc9JcGQIANDDFAiV7wDlOPBGBN/j5+kj
 VPug+G6OfZvVcjXGz5YcxickvRMnlpjo8BAW7bw5BcYC/S0iUO4GiE/KnbAuvidkkB4K
 OKOMjQyozrYAK7elYBfJiCPPaxegtHgEtlD/ZbSimJrq9FIdWUfQ8XUMAW4Z4mF8XKT9
 V72hwnpIqHxynB9fZcC2CqZY3ltdoYJQrRTv4RpI3zQKmYgCAkIyyfe8iW0Xh8DvNc5m
 3k8CtDGZNgn1IKZhQxFCY/ttemcWdAatE2TSHXFtyckSpECwirlT2wG4zml7Nkf00ACd FA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34tcp24k3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 06:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtxXUQEWIOZOEzNOylzW81v/thhiWOOM/4fdcQM6jF01b7Z4P8gJX0fZ0IocoweTgMHX76pRtyUzE1FJ8N9uf86TZdIDEys4tGKFFBIGunsTSyW2UDRSgkVTHLl4ed2byYnn6A5GCbwy/ky9LUPjCTYbs1ePTpznplAWrWMbpjyFYAxMCQa2Hlkk5v20sx9cDq03PNFRlIWae3pb74FdogNh0UvN0eCGXsn1KM98IZKp+Jrb3/MM8iVvGum6xYfTOrg206v3X8XsG1RXeNpLZVtx5nBZKsrjHaqX3sQ3/GhzXIc7J/nrGm6zyScATXIl9Tpit/HeyQLdisORu4/i0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=H247aqpzaCP17nYTYbhllRHcTccoERd9ii/75Eh+64HPUQgZIW3d8rt6agV2GA5NvmNECCnhlGkdif/3bVF7TcDpvyMapi8dChENW7oQ3MwX+8yr4NjI+dq+LMmhnPSULDnl9bm/UUbngVXCSAzXTuHbiB/d08JZFK9H8LIYRjNwiCDN5COcbtDE+VjcUD5kbdn8SMh/2wCafGlU4HqJ2dQSaBFqQ4hLBAmANJSDUTF7GYxge546LsImROxSgbySY/TGTN4M68+JsIJmbd1NAwHAx0eETNUNhkqX8U/ZK7guoR8Y2nadvqvdJ/G214dGSH6sY4cuscA3hX8kC32jRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtMcaEUKxI+myrGv+xDd1cmY7s6474FY+k9QsQmwEs=;
 b=z2fulgCFd6OUfBj1GY6zPhfpHAGc1Zo7dpcY3BkU32CZsUIc97RGETNK4sMk2QPsgkTCQLvrGmw3w+n3JSTotuhE6pTaZfP6r7MFMLHxn1kM4LwqjQrhZvOWV9cKvHdkMloKEQobkd8QgcjJ8uWREdPBIgiYbjmqCyR10NzHIFQ=
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by DM5PR0701MB3783.namprd07.prod.outlook.com (2603:10b6:4:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 19 Nov
 2020 14:14:33 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:5f:cafe::c3) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend
 Transport; Thu, 19 Nov 2020 14:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Thu, 19 Nov 2020 14:14:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERJ7022418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 19 Nov 2020 06:14:32 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERfj011752;
        Thu, 19 Nov 2020 15:14:27 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AJEER4H011745;
        Thu, 19 Nov 2020 15:14:27 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 05/10] usb: cdns3: Changed type of gadget_dev in cdns structure
Date:   Thu, 19 Nov 2020 15:13:02 +0100
Message-ID: <20201119141307.8342-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119141307.8342-1-pawell@cadence.com>
References: <20201119141307.8342-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38454b6f-9bd5-4912-4079-08d88c957025
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3783:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB37831FAEFCBDD9B4457E48A1DDE00@DM5PR0701MB3783.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ei6VrmPvyBU/iEtb7XP8cjm8lZCp08nsFfnMSEBMVLYu67OD19hqlciEQvop5OLn8cI35fu8Rd0SDLtVJdGMOv6nJc++DA9qgI7oyJ60CQ+DQJTofNKKtZ84aAK5UjJMghGfeqWkOLT8pq2usZtFleNgW7jf8/SCz4EWOuui1sWD2H5aE6+j0t5eLkhM5B3WrzUotIlM+7bV5nYUBEHLIiv0IchRg1L0C3DMLcFmg8NvDNjvMWp2zE/s3BUiAaCGGbw5mzOrq2eZqRsUTAzQBuTe46d1tI2v2efM4PBoCfg69uoLsi1wnfIFzHfLt7eY8j8/DXyw9kfPvQ7roLfnWcsZxVceMhaN2rAncJ3RwTzWSVLJSBfy5kDT2dIt4mHrXfmfxJy0sPmjl42VfzWro/rP2O+kkjuGuqAYTSegfSs=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966005)(82740400003)(426003)(478600001)(6916009)(70586007)(336012)(356005)(8936002)(8676002)(82310400003)(2616005)(316002)(107886003)(42186006)(4326008)(83380400001)(54906003)(36756003)(47076004)(70206006)(1076003)(36906005)(7636003)(86362001)(26005)(2906002)(6666004)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 14:14:33.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38454b6f-9bd5-4912-4079-08d88c957025
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3783
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=1 adultscore=0 mlxlogscore=322
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190107
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

