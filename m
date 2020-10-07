Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC697285729
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgJGDlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:41:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8134 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJGDlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:41:13 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0973RGgR024752;
        Tue, 6 Oct 2020 20:41:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=TwXR40QDTd2h7f/veXUUEZREyv4ylgqGQOqD3DmmmUo=;
 b=q+mE9KN55nvJE2Di4OIvbK+kYNiXaRvp5Vi5axYlNsMepab7msIzphMps2glKIEc7usj
 8OrubmiFVKEzAzlr06btg5P4I78LYN8j8xp+9cjY1jXlI1tOcQfmowDbXZSlo+jusg+4
 saTkx7YFkM1iGvYgZygx4CFgOXXL9lA+KaxD+uitYeUoBWMO0ePAE0BUYhNxsTWCamKe
 DbWlc1vLk3X2u0QUl6/WLIAE6NuHYc5RDEwgOGGJdyw/6B5RuwdXkW5EU3p6H1tPEeCn
 2jKqwmzDVyN519+D4pU1o+UcGqD9meliQ15gOdkLzXLAeL4Wzcsy9yGhdrkXMWWr8zC1 1w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33xnuxkt53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 20:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSbXgPe0HrWX/keQTpAROFYU7C/MugRNHmfU9VMLKCvXJ817FKWk/aIJ8wRzUDfu1qtp5wbqLJZR9BKQMtkYC3id429lghp9IpAvikptzaHKTAnnBMHdzmkX3nj2i58plF25txg8bjexI8Sj4cRqAVolMd9EAKXaPHwSd2k3pAvGgF2Jdu3aSb1lZiEPRYLb4I7U6muKN0r+ij56gBdwCNS1yAAoleMPSBrHOk+iNIxtOuPvclgcZBxSXnMATM3wG5J9SfXO4s5FIZ6hzvPWhcsBgEnA3xsQ5J+oKMrIIsEIEjCB0MNjGrzzORzrUSBX5fZUISm8NYIqKFKRM7Uqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwXR40QDTd2h7f/veXUUEZREyv4ylgqGQOqD3DmmmUo=;
 b=RoN/hLmzp0V3iH7nXQuN5ps8nXLK32kBO9MnkGoI1sFcr8nQrdve20KPB3tfV86kfwmum9vBKa/1sIGVWYvO1495Ka39InZ6cQc1pD58dJlpA2hKN62MEyog0XwqxbIZFpnAkEzXwgCaR4j2a+ZH15PJxHHFHHYG4dQ1qYOnv+tid8U05qjCknLMPlBk8d7jr/IbnD+z2vA4TAknVwBtpJSZSn2VYlnp/SwqeneWbiBau4XPBiQJ6DPLG6Nw0dEAVqyoQMqIwu3vDe5/xRG2jWPQ3Ro57+Q0rqvP4catsLf/XN4oxoDeNue4uX+0EWiQsjeLeN/kIuB9RHZvMw9VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwXR40QDTd2h7f/veXUUEZREyv4ylgqGQOqD3DmmmUo=;
 b=63oaIoENRFX5v00A3ly3f5dARZALkrgG13u+0zkILXiBQyWPX7sBYSx8CuK6lS+B6w+jBZJ/aARF5uWhLWje+l+7Ymynl35EkTgWRF1PKIyVigxW1ViI8/EpIrYZM+81dPOHe3aoCF2RbgxjfWk8j1rl12dqVrsL9yIDB+KYvCU=
Received: from BN3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:400::13) by
 MW2PR07MB7897.namprd07.prod.outlook.com (2603:10b6:302:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35; Wed, 7 Oct 2020 03:41:00 +0000
Received: from BN8NAM12FT054.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::c4) by BN3PR05CA0003.outlook.office365.com
 (2603:10b6:400::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.15 via Frontend
 Transport; Wed, 7 Oct 2020 03:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT054.mail.protection.outlook.com (10.13.183.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Wed, 7 Oct 2020 03:40:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0973ewvF002155
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 6 Oct 2020 20:40:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 7 Oct 2020 05:40:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 7 Oct 2020 05:40:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0973euSD023135;
        Wed, 7 Oct 2020 05:40:56 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0973euAP023134;
        Wed, 7 Oct 2020 05:40:56 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 2/2] =?UTF-8?q?usb:=20cdns3:=20Variable=20=E2=80=98length?= =?UTF-8?q?=E2=80=99=20set=20but=20not=20used?=
Date:   Wed, 7 Oct 2020 05:39:32 +0200
Message-ID: <20201007033932.23050-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 378b6b33-88f4-49ae-0aa5-08d86a72ce97
X-MS-TrafficTypeDiagnostic: MW2PR07MB7897:
X-Microsoft-Antispam-PRVS: <MW2PR07MB7897BFB65299C5CB4BAC40EDDD0A0@MW2PR07MB7897.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7CVikTv2MbVf4XcKz4QCXDkjKLiS1SR5R9bDe74K67dWNFgGhd0xKWqypRfT/TnO/uIjWTx9epyNU8HrGVxqQq2gibQ4bLJof6R0uscNtirSdxpju6UH0WAOUbvFDb0/rUhdepJEXK/mlYXxvPv1iKcsjQk3cFD1VHXgTAXvLvP0lAp54gONfsx8KxmE6xkeqA6F49Hc4uCD8xYYDCCSwv5ELPoLXR0VJhdKS5ZKKeYqZDxdqSgCiieW6wL3Fn61/7KkIFmmiLlRZLtPSyIRwGB+J1HwcDF5WW8cJvCimKJBvMjehxvLIiqEA9l/WUNJDmqSvGZcy6sxcm4jrWXUP+xkIJsAv+MyGPMBvhJSL5d1pn7YFQiVFlFhByoP0UApA1D6cnMh0DMQ6j2wcei01p4Hff2M9FueZdRZB2myAU=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36092001)(46966005)(4744005)(2616005)(356005)(4326008)(186003)(336012)(6666004)(70206006)(36906005)(54906003)(70586007)(6916009)(1076003)(42186006)(7636003)(478600001)(316002)(5660300002)(83380400001)(426003)(82740400003)(8936002)(26005)(47076004)(82310400003)(2906002)(36756003)(86362001)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 03:40:59.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378b6b33-88f4-49ae-0aa5-08d86a72ce97
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT054.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB7897
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_03:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxscore=0 mlxlogscore=685 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=1 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes not used variable 'length' from
cdns3_wa2_descmiss_copy_data function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 6e7b70a2e352..692acf7b9b14 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -506,7 +506,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		int chunk_end;
-		int length;
 
 		descmiss_priv_req =
 			cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
@@ -517,7 +516,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
 			break;
 
 		chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
-		length = request->actual + descmiss_req->actual;
 		request->status = descmiss_req->status;
 		__cdns3_descmiss_copy_data(request, descmiss_req);
 		list_del_init(&descmiss_priv_req->list);
-- 
2.17.1

