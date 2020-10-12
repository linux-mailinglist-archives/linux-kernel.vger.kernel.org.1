Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5580D28AE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgJLGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:47:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25952 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbgJLGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:47:06 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C6hxTA003901;
        Sun, 11 Oct 2020 23:46:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=+rDmKy6Uf+Q07AweBnpu5V5ZMk1L7l46S5zS6MzQhMs=;
 b=nPPbjnUu6jZOE+wouWR8K/pYqOxgzqRxZgk8wtLjL6DWhqR6UEUSF9fH+b3ar5MoYRtR
 DaWooCkNRQc8kSuQvWqho089XjLSkezMBXelyOsbUo7KQtsyhLno4c8NWay7DifIk2s+
 aSIJNHvljzyyHESJIargZri9pU8yZt0L1BQb1nWEIZikGGombDGMMh6RMVJRx1OnrTZA
 0YM5pe0zxrKqyk8YvKEvVrVCn88bKfijE+S1NyPAwIxz4FaWeYdaBOzDEG4NyM4nWbX9
 hOEAbdewO8zZWxQxXu/OtP/HICqqMyMLCMAp8Xugbao2Ji60PssXoUqz4IqUvOeS4ah1 3Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3438hwwdq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Oct 2020 23:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZa+cfhEDfMJ0PTKnLwZr5Sgqy0ngqC23tl+R2YkG67iQcmVQSoovpenkX7B0rreAM30IsGK+PudrGIXnV7PnOIj0NKcKT4KFi9qFDUTtRbN6xfwSG2ZTIMWJ3qQ6Lu/CcDwCh/dsbcQd+mYm1e2i+WMZ8ifZu3lHLZCljayM9NqUer/DXO5m9fA+AIwgHrgKSt5xnpAAgxIsysL9w/OzqdN1SXgJ57sdMiOD6Jh4sCfICablWg6y6tLHu2yV+iG6osxGlIe94f0GhFcBKJvXu7ZarqdSmia5obvFR9OA7or5QN4DjEmyJjCteRvvTss7Eb5F2SpKu3PPw2Ixn5U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rDmKy6Uf+Q07AweBnpu5V5ZMk1L7l46S5zS6MzQhMs=;
 b=buVvS4W2ZVgF6uS/iMMUtg93IMCLC0tz0fa98FfBHl6nJdwtTVmC7PsXYiSb5kbQpFag0SfFGkwhReVnvfO8RN1yJ40QhTnf3QpbqgriZ5iVlwEi0d2XlJ70bIBhiDNYLJPIY681kJs4hR4qbLVQz8kIKsKKTkrZ1lyRX9+lDWJuyR7soQXYZM1DpNSc+A+LntvxvADtMD3pK8Zsvc9OVwMkhty79zANt3Z7IpxpeM0wgDt87BCfLNxh65YQXC6McpLp7lWN1szpD9LvRn5xmXTYwxMq3LegBpmsTp0w+7VvoBrV9el21EdtXztLELRrpOYOSuazFRtSBm40XcBTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rDmKy6Uf+Q07AweBnpu5V5ZMk1L7l46S5zS6MzQhMs=;
 b=HqyFzj0/fYegtphjiEtVDgofKirD+dAhutM544nuoZjKtMeJmS2YsTYoUW1x4c+1vl9MmBfXBM/CjVc+BOMdz5FNQGOBTGZIciXGcKFXe1pKKfvCrcuXH5Baqh6mAapK2xyWOqeEMT4wBepXxYc4e/f4pJ6w9uuGzPWO1BwvGnQ=
Received: from DM5PR13CA0052.namprd13.prod.outlook.com (2603:10b6:3:117::14)
 by CY1PR07MB2651.namprd07.prod.outlook.com (2a01:111:e400:c63a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 06:46:57 +0000
Received: from DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::9b) by DM5PR13CA0052.outlook.office365.com
 (2603:10b6:3:117::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend
 Transport; Mon, 12 Oct 2020 06:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT013.mail.protection.outlook.com (10.13.178.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Mon, 12 Oct 2020 06:46:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 09C6krDK144848
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 11 Oct 2020 23:46:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 12 Oct 2020 08:46:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 12 Oct 2020 08:46:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09C6kqcO008794;
        Mon, 12 Oct 2020 08:46:52 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09C6kqSh008793;
        Mon, 12 Oct 2020 08:46:52 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdns3: Variable 'length' set but not used
Date:   Mon, 12 Oct 2020 08:45:48 +0200
Message-ID: <20201012064548.8725-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baeaf320-1e46-4e04-18b0-08d86e7a9c2c
X-MS-TrafficTypeDiagnostic: CY1PR07MB2651:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2651E1D11C74DCAB8AFD1FB4DD070@CY1PR07MB2651.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1gX9QnBWGsN4b8Qpt0qFyOo/eSOqJ1tWohogNmtxIrwUGhvC8gWFhL9OWocwKBSXK4Uvg1agZI9xJEvmBAZrAu5FfgSgs5QIMzyh/YShCQP6ERJo0S2DYsUNyh9AF3hoMO+GOO+ZLMOQS4BF0i34PSWDJeGS7+ztPn+KtykvQ+GS5QG7Zclx11bO1bciOXq0uO8P9NbjjRwxH4Jl5YgdRJ4qYQRg3iboiX3Fl9aYMA2UcGR5C+YkICPZnfFXZIZrI2XxZGlHXA1InQeNs1YtYHvm4E2MgGfcepV8/1x6XQWg5OZfqyKy3f4fUyYsK3fr/Z/YSF/CuwWVD6kdHZvWuO/EsR/H7PMkC5QIEqzLb+7TSNTfKhkoc5PNdNW701FPPdy4WHKerV7jq2FSIpC2t/M8S8pln+ZWSfh5ahi4Hf1QygjnFUybIvBRMXIzNIM3tIVS9YTsMOON7VN+IM+dLA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36092001)(46966005)(426003)(478600001)(336012)(82310400003)(54906003)(316002)(107886003)(36906005)(36756003)(83380400001)(4326008)(82740400003)(42186006)(1076003)(2616005)(34020700004)(2906002)(47076004)(70586007)(5660300002)(356005)(81166007)(6916009)(86362001)(186003)(26005)(8936002)(70206006)(6666004)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 06:46:55.6956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baeaf320-1e46-4e04-18b0-08d86e7a9c2c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2651
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_03:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=1 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=629 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes not used variable 'length' from
cdns3_wa2_descmiss_copy_data function.

Fixes: 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2
- added "Fixes" tag.

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

