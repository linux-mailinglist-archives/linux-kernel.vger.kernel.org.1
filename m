Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8794728EC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgJOE5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:57:11 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24646 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729634AbgJOE5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:57:11 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09F4mD56024672;
        Wed, 14 Oct 2020 21:57:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=vSYhxBy0qlLnCRYJLWLM8Csh0SP9vD8mwREyrEe3ics=;
 b=Z9TDcFKgy6BBYKTkMCHthJfhwma8CXfZwdvCCNv6b47I6bDD8yqRu+Dj6zyhi39d/mNj
 /lMIgDt3BjacqT8n7ZAzSPGqEaq5PLcTwx3JECJoVm3tJ1Iio+olSaUvacxsbOfo6itS
 jiQ3G5jutP4g6eYb+deZ2qMkPqXgWmkTznvOxFP74ZFtE8qHnRCFeAIFA4MRR/dIunz+
 wyEnncz275A9zIuk9CU08b0EwGSdZ6BjBhcO1UeJRZECl0X1fYSZSM3HxjLMTRQ63ev7
 70HBVgWdshY1z3PjNi3+K/L/7IYVgEj9m43FbLpHqpwyfdJlQ+3TkOlOg9/rySbXZRvX 4w== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3439gwadkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 21:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE0D9TjEXodt0ZMZRLmbsHmH0TvTe8O5lXuX9aXBOcqAt/+bLbL+BGh+pITpWgrzFwnN8GrniBsPnBplToAbYD/TaxAp5UB8ADQoQFt5ee2b+OUNOCXfT08yavLanwS/aDN/v6B08JMjv6+bQex424Wgk2WLNwNx5nx8mhPi3ieTBfMe5GhZhRvkPmtgkM/qiATF0zayqYhFLKqJoAeFadGIKN/qKC9Yi/Oae9B4eQHlPnOA+gueHqLDRdaxn/3rJWnY27R69UE/iSd0KJBZFefEtzbRLSV48LSZj8D2J0VDSIcXAE23plhmvfeLEXSMEUEl6j5zQGfO6oThpjx3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSYhxBy0qlLnCRYJLWLM8Csh0SP9vD8mwREyrEe3ics=;
 b=fRJIu8lErHqzqhs7vjATb7Qnst1ZulYa5CMsOKzJvtdbvWiTQx/mBCpUco8aeZEzRBM3/MeEEiSUm99V5RKYOHSbyD9rf/KlHPYR9gLw/2go9TxhHkDbMLMM0Xciq3ZuWmjccMi4e9dT/2LbZrw2AM6zt3dZOu8tzXsGBbZbB3+l2n7QaVqjzvUeCPNQWK7ZOdG3sElW8Ky83tWNysIE8sjo5xIk0N/vctYILxcM6ceFSdbkH4xaSo0aqhGPASpT185DZ/iRhSpTb+q3tzPep8Si9DCc0Obx/dYO0lg1DC79GvAWQCKsAUWmar+gKdKPz0gv7HuZqZQPzYpjYojN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSYhxBy0qlLnCRYJLWLM8Csh0SP9vD8mwREyrEe3ics=;
 b=VDw6Kn1n3erC1qdU51Lom+hpHvWjOZx6J+VGm+Q0orsY7Har2swWuXMXD1T+3+KylajL/HRfXT9vs96mciN9nMBc0jvo2M5V8OK8pllBIwbjJDleQLvwyslBE0VVpxjkquXElBNmF9rlSmJerFbyphyeYN15ZASyGJ3CVl59vUQ=
Received: from DM3PR11CA0012.namprd11.prod.outlook.com (2603:10b6:0:54::22) by
 BL0PR07MB5684.namprd07.prod.outlook.com (2603:10b6:208:84::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.24; Thu, 15 Oct 2020 04:56:58 +0000
Received: from DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::21) by DM3PR11CA0012.outlook.office365.com
 (2603:10b6:0:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 15 Oct 2020 04:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT064.mail.protection.outlook.com (10.13.178.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Thu, 15 Oct 2020 04:56:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4uvqU028487
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 14 Oct 2020 21:56:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 15 Oct 2020 06:56:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 15 Oct 2020 06:56:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4usZm002318;
        Thu, 15 Oct 2020 06:56:54 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09F4usXg002317;
        Thu, 15 Oct 2020 06:56:54 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <balbi@kernel.org>, <rogerq@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdns3: Add static to cdns3_gadget_exit function
Date:   Thu, 15 Oct 2020 06:56:06 +0200
Message-ID: <20201015045606.2084-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868e16eb-1e23-4e85-9838-08d870c6bf17
X-MS-TrafficTypeDiagnostic: BL0PR07MB5684:
X-Microsoft-Antispam-PRVS: <BL0PR07MB568425070C8AAC9129040766DD020@BL0PR07MB5684.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mF8aJEPafcgTCXxg5+A+i3dii6hGnj0TAZj5D/o1W4yFEeDSoiOd6icnc0WTMROIRLgChorUNeI7NEdgDVfWntw48m9q2ANkxepcBVnu1vbduh1ZtaU0BteqM0+mAb1rMp9iFxgNMrdg0lmy93JtU3aGVCR0s4/fE1Vkgb+0RPoYGMO77raeLTAPTvOKAkqtCjDBSJjvICvxkDuF0xK78MD2iN3R8ImMdf3+yXXOPiILBMWDufgv7YVtngiK6YML05j+CJC+Xt2DD5BZTzaLirMWyf9f+nSzGZypZbVIB7AGaClg7FiLflwUpF7ThAhpR1Auc25zM3pUMfZ3wACTeAuc7ldLzXRCVQVzrjkYepeNh+EKBqLVJfamvb45S4cOj7AOuPn2mkB+8pt0MfmwLNaHPDY+B0PffJh25TWINqs/PRJZIxNaBfNl3ekO74VJI+HMlfJRYwd2HpoeL28oXQ==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36092001)(46966005)(70206006)(86362001)(6666004)(107886003)(47076004)(5660300002)(54906003)(1076003)(36906005)(42186006)(83380400001)(82740400003)(34020700004)(8936002)(82310400003)(8676002)(316002)(186003)(356005)(4326008)(7636003)(336012)(478600001)(2616005)(426003)(70586007)(6916009)(36756003)(2906002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 04:56:58.3775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868e16eb-1e23-4e85-9838-08d870c6bf17
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5684
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_01:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=1
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=742 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function cdns3_gadget_exit is used only in gadget.c file.
This patch removes declaration and definition of this
function from gadget-export.h file and makes it static.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
Changelog:
v2
- added "Ackded-by" tag.

 drivers/usb/cdns3/gadget-export.h | 3 ---
 drivers/usb/cdns3/gadget.c        | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
index 577469eee961..702c5a267a92 100644
--- a/drivers/usb/cdns3/gadget-export.h
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -13,7 +13,6 @@
 #ifdef CONFIG_USB_CDNS3_GADGET
 
 int cdns3_gadget_init(struct cdns3 *cdns);
-void cdns3_gadget_exit(struct cdns3 *cdns);
 #else
 
 static inline int cdns3_gadget_init(struct cdns3 *cdns)
@@ -21,8 +20,6 @@ static inline int cdns3_gadget_init(struct cdns3 *cdns)
 	return -ENXIO;
 }
 
-static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
-
 #endif
 
 #endif /* __LINUX_CDNS3_GADGET_EXPORT */
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 692acf7b9b14..6ff3aa3db497 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3069,7 +3069,7 @@ static void cdns3_gadget_release(struct device *dev)
 	kfree(priv_dev);
 }
 
-void cdns3_gadget_exit(struct cdns3 *cdns)
+static void cdns3_gadget_exit(struct cdns3 *cdns)
 {
 	struct cdns3_device *priv_dev;
 
-- 
2.17.1

