Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C423285776
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 06:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJGEDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 00:03:11 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35930 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgJGEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 00:03:10 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0973jLDi009034;
        Tue, 6 Oct 2020 21:03:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=TLum/5dsjyhbfLR7hoMnq/P/ZJjSJf/BTwLtrsfK26g=;
 b=AnW9Pkx14XFHHbewc++2gP3YShKJqARIVo3OKxh+O590L49gYPmYwqe8WFZhk9eDDpyI
 LZqsBPob/08EAyv5BSKEu7n3g5RnKroIw3UNbA/VvQgp84UjKZkc6eqh9FKWnOSAQxCc
 UhUl/7IxZYwdpD2BwqwqUHZIW0uPa05NW8o47FI0qCloFclXJmsHegr9HtlV1UwO/7uS
 H0nJYDvr3/4dQKLR+Gege9w7LxDr8av311XQsc1NjKfDooEe04YtXjMs33HTKCC4TjQg
 Y6XmBi/Lj9Qs0q8w6h2wjl2W4GW3+0f6vd+CZJ9rTix7MWMIMy8lt+1N+n04n8Gmth+W dA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33xmvyc5gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 21:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfVFfPUlVXk7UFdnMSzCUWMZjrkJo3wG1MedrC+l1LHA+CUcZNgQ3S87vRUlcYXrVGj8KpsBxgBIPcQj7LKQqaCN3zazOrMjtSIA+dBsTgEGpHHeoRRW5ByDwEQDfP8488cMK77GaGTSjyz5pJGAEBMrKLf7LZFc12Xe237oqrEejXZerDtVvMgIW3DXiiRrrztKgKmWWhVWTCTKSRliXxzJxJFis2GU2O94Oy7lZGvtRAQ8EvOR4EbU6LlYdbI4kUznKh55XjI0djGhiKXztZdHe1OIsn4RU0OmCOCGbVIStqGoScwDwlXqgw8YCQZhZ4NK3/XYrP8/riH+VURZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLum/5dsjyhbfLR7hoMnq/P/ZJjSJf/BTwLtrsfK26g=;
 b=dUNn2klIBZOnbun7QKoHweGUYPhzpe2ark51WIcCnJZzuEdjJY63ond7vwgabnxJj6K/BauO5EaTY0GYg+y/Otz3w4dTnu+a9R0221yvxaxT9N2bnLWXF22v+p3+aTqbBcIBFcJek3b7WjTNVWKslunpO6OPRiP0yKI59DW09UYIIOv1/hp9XTWakFcbEMK/JOXdhAOecYBBdTjc/DfNi7aPGt25yoFQr7D/cweRb0So0ywVmu3R1Xg6IBOORevxhEk3ux6O+3to753G+wOohyPApvy4XoFq6jbuPPfAj3dC/6RrBSOZR+gWWm7T5QECHyYOgzP749uMR0ZTYZZobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLum/5dsjyhbfLR7hoMnq/P/ZJjSJf/BTwLtrsfK26g=;
 b=WfIn4aTm8ZCNaKbtj0VhGtaExHHt8boI4Rp0DdPr5etq8fezN4jTl3+5h/EhQ63hYVfZtvGoODASd4xd67ugwE+pVydCZndQOlPdQgvrdeZiAi/Nuz5DhWjioDkR9W3lPJi73ZB1GtgLsRDXMxq3/eN/QsLGfWSB2/mDL0mwZiw=
Received: from BN6PR16CA0033.namprd16.prod.outlook.com (2603:10b6:405:14::19)
 by BN7PR07MB4372.namprd07.prod.outlook.com (2603:10b6:406:b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 7 Oct
 2020 04:03:00 +0000
Received: from BN8NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::d6) by BN6PR16CA0033.outlook.office365.com
 (2603:10b6:405:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Wed, 7 Oct 2020 04:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT051.mail.protection.outlook.com (10.13.182.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Wed, 7 Oct 2020 04:02:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 097430J3001157
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 6 Oct 2020 21:03:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 7 Oct 2020 06:02:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 7 Oct 2020 06:02:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09742t7a025789;
        Wed, 7 Oct 2020 06:02:55 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09742tPc025787;
        Wed, 7 Oct 2020 06:02:55 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Add static to  cdns3_gadget_exit function
Date:   Wed, 7 Oct 2020 06:02:30 +0200
Message-ID: <20201007040230.25741-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 549a9342-7818-41df-895f-08d86a75e159
X-MS-TrafficTypeDiagnostic: BN7PR07MB4372:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4372DA5D47CB75DDEB352CB3DD0A0@BN7PR07MB4372.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dc0D1bUmf/OlLMa3FdKNP3o3TPee8TjJRJymMXpZavNVimUrJ5KpacgfZPFZ2vwXBpT4c85RGt7Lw3ew1l9rsqKgctLcS/b9BB2DORA0/YX6roV16y58B6jfTFolW7i/jh08LdZ2+SNxBu9KS+KI3tu2zyvPD94tINrug6y67jdG1FwKK9/b01wcnB1RBQ+CEU3LsnnMUBocQKSFP05zB8g2GL19UK4wAakqC2Nx9BRhHOViNGTKqOTG5gd4yBku1mgZiXMHXquYAIT+noUOlgDVfJZhQT9Jp17/jhKsmQdFD5Q12kQolTpsTrll60iWwpdziz2oe/FcQSA5kzzEKHcMrsTyy5mtdIczYauxP1Y1VAXMun18NNgv9yZ5k/VW9B0l8A/OiN4O4EoWtf9u6WTGYDskZS2ZKvReexjCxCo=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36092001)(46966005)(8676002)(1076003)(86362001)(2616005)(5660300002)(36756003)(70586007)(70206006)(478600001)(426003)(336012)(6666004)(6916009)(8936002)(26005)(186003)(7636003)(42186006)(316002)(54906003)(36906005)(2906002)(107886003)(4326008)(356005)(82310400003)(47076004)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 04:02:59.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549a9342-7818-41df-895f-08d86a75e159
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4372
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_03:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=1 adultscore=0 mlxlogscore=677 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function cdns3_gadget_exit is used only in gadget.c file.
This patch removes declaration and definition of this
function from gadget-export.h file and makes it static.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
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

