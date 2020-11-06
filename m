Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E952A9597
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgKFLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:44:54 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:27404 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbgKFLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:49 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BfbD0006090;
        Fri, 6 Nov 2020 03:44:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DyRbdjON2SjrlVnjYtqlYj5DPC94mcQNLP/jv5f5Tjs=;
 b=O84JCp3S2IOEvxFgyn1JSTq+cI0RQjjSvRE3vXh1Zdp7t2CQRgjBzcH0Zq7k4pvqcUsQ
 EFIw87OUut1q/yrPExKzgXTCYyIFk+yJ37TKEzvWpFG6Xyw0/kDGparmBgwNq53q5yI7
 xfycFzQFBdHWCmrcQcPWYHlWHLWNvxenytcodkpnVCiKocR7QGRW5nKiAwFdXz0kiiLi
 KnbqvZiOyPmolXfTg7h1oOq+l/Aw81SrlGsZgFzPdtqA+ibFZnvvc+WZSiTiVdaT8g8z
 gwRR22ZGU5DnqHg4Xay1NkzQmaABtFEKUQBqUTTL4RHe/qdLT1G8TQxzc9/SjKag3LFx IA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34h3gxac8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv4g2EI6Ql+iObkEi8VMTNkpT3BC3rgGPNJkqig+qDWcd4sDNstOn+mErZ4ALhFAPcr6EYHt8xXNmUz2WnOHdIpL1Uu/loRxHkSmvfHiGW04FQQKPqov9K/oaZqXJqNMPC8pyzZqdoJlf1SqJQdauiVtm5+ECQN6NF2wbXjT2zsAMEXyqtRSeoMNzZvwvcyo1W3mP9jiqMopeaR1P2UmDTuTqpcFH3Ex5DtL+eTS6ILJAaLK2WUTkjkzq+qF5tiXPP+o6KsEjQ+SB28cXky/MGXbvNBAYVd+nNwtsjFf99GyPJsDm3wD0hEcFCmhPEO34zqKUWs2FkKXVz++DnQ2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyRbdjON2SjrlVnjYtqlYj5DPC94mcQNLP/jv5f5Tjs=;
 b=gILCLjujcwTnYO9ooG6VLIVjI6lB13vlyELIYtiaaj3VJZb9jeN4hSA8gxtLblh6Pno6SENJkPFFm94mOZYwiM47N0otiWYRwMAjauCF9gmu7NvEeEwvl/VFph5yUuCc4Abi3SgBYlb/sHwGMdk0mlRpN82AcksF3Bp3uuxhKGniwUcP5c6X7xp+K47i3qbP12NdVDYhaHO5OTSuHgwvcoP/Xt28rlJhgAUdmXJ9tiGjPqyA0TGrFvv8+2FmwGOBO8AJcw+bsa1VDXqxCkxYaxfEpWN2HO4Va5X/7E6ShOAc7MtHv2+H0ZeT4sp7MVHM7REAsb2rioOTu+47RwGSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyRbdjON2SjrlVnjYtqlYj5DPC94mcQNLP/jv5f5Tjs=;
 b=e4MZKIfNEJ5NTEGYsbzvieZsvBkiUDXMumAob/PUGvJoXhVbgl7DwHgvVhtmYNrvMM/BcSdW0fNWxUAdj2X8Y3ypPXfmv4OtsCSfVENVdqo1WvEwkQJ5TAu3F5aVe9KmHKd2ZJkhAo+/y32nxIdYYBrvi64+o7rodORrmFdTzVQ=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by DM6PR07MB5386.namprd07.prod.outlook.com (2603:10b6:5:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 11:44:21 +0000
Received: from BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e5) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT060.mail.protection.outlook.com (10.13.183.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAo094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:18 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiFf2001584;
        Fri, 6 Nov 2020 12:44:15 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiFJZ001580;
        Fri, 6 Nov 2020 12:44:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 05/10] usb: cdns3: Changed type of gadget_dev in cdns structure
Date:   Fri, 6 Nov 2020 12:42:55 +0100
Message-ID: <20201106114300.1245-6-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3677fa6f-4c74-4f60-b3a3-08d882494c70
X-MS-TrafficTypeDiagnostic: DM6PR07MB5386:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5386A5A39AD9CC11C9FDE45CDDED0@DM6PR07MB5386.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUj41w+Z44RX2ItAula5/DdjIqPYzX79O+ue0/QC//DkC+4F8zTmNS5InhPQp13tq+g9kFxOHHy2JqpqwOyF4E8pE/FMY7aMmkM8wKpmom8/IARnz6ns63oSLjWY3gJFBvMninnFZ4/xmynEbq/y/D+Mh2cccw1D5vIzNHXULW/+dN8GPtKLHvJ+6M3pm6/wfSZwfAfgWKJlSnwh/PAvSxY2Mrkbe1StRMAfTIpnm4s2C2TmAKvU6dfyDNN95MOJyspoFGU+T5wcxN5hB7t3Sk5HSRcSMyOQD+rnExg6ZvvY9I8bWDC1FpsF58fP06m8gWup0sPlNXP1hUuoNA8533gaJRA9/KWcaeICKJ/DkgvE1prpvMsq4APy60RzMVJVia9Mi/d/2P0EZ+WK3rjxcYiTIAbmBUnJKCoFJHnJ23A=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(46966005)(6916009)(83380400001)(6666004)(336012)(2616005)(8676002)(8936002)(356005)(81166007)(5660300002)(82740400003)(82310400003)(47076004)(36756003)(1076003)(426003)(2906002)(4326008)(42186006)(36906005)(107886003)(186003)(316002)(478600001)(26005)(86362001)(70206006)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:19.8113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3677fa6f-4c74-4f60-b3a3-08d882494c70
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5386
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=1 mlxlogscore=323 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060086
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
index 2dc4bb1c6b6d..055bb89f54ca 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -62,7 +62,7 @@ struct cdns3_platform_data {
  * @roles: array of supported roles for this controller
  * @role: current role
  * @host_dev: the child host device pointer for cdns core
- * @gadget_dev: the child gadget device pointer for cdns3 core
+ * @gadget_dev: the child gadget device pointer
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @mutex: the mutex for concurrent code at driver
@@ -101,7 +101,7 @@ struct cdns {
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

