Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9348028EC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgJOE4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:56:10 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35344 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgJOE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:56:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09F4sLVJ027625;
        Wed, 14 Oct 2020 21:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=c/MOkPiq6g39ZGCj32AuSKKCXJDKuQKv1ChAqx8RYGE=;
 b=hriQwMzyk0TN1xHFv3UYOrpUP7JbyfuYfRizLzhc2qE7dF/MIYQjF1hO4CcIUhRwRgeA
 YOgG7WB+/aFDg/hhFD+mBAtapR61CmXJ9zjYVgjOYHWzYiQF+JcCVY06XpLYPRBXhJPi
 Qruk9PPytSeewN1srqY1Xj4STRt2LF4QRt3/fnjAhru8mVH1WDLRzmZ8hpu7kiuURPTs
 GL7ZfEQ+K2SlI1la+DkoUHJyzanQswIWjTRaw0n84e/sGdt3hTnT7BzF4xoweZgFGYoT
 liik0Doq28cxSsyrtmKFrM6gRksKsY/eftaSNDtyLFttq2KBcl36MNTBPeJYHYdGwfMx kg== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3438hxawe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 21:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4ZiqjQnyupo6LjpqK9nbz9LN1pNiVH70m6YO/8Yti9syzrSZ1QwccMQAzKb0kQjeYysY/GC+AbieWCciSN+ML4Ehkqufu+cEf6n8K+loYjWijc+sV4eDa2tj3+6bb80Oib83BV7T5uzPVg9J6T1aWVa2Ouw00aWosyQxELsWboHGMfEq+ckxLhIy918/1/vq95c/DyNL5BCLSpUM54TgRWz8PfMDdGmI6VVQz8U8HAXlRa0kczL2+kQ2XAaWKNJYasoXlX3RbUWp6XxT3F03lmK8GszdGL3KWF6pLsgFiHa1bOW8/hQBES5Inu8+64m3SgVAIwnHGvgxv/19z8jAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/MOkPiq6g39ZGCj32AuSKKCXJDKuQKv1ChAqx8RYGE=;
 b=B/E7hbpTgol1yapGyFTv7LGyUxBuecVX1OQdxXME1iE3fGH4K/xZshSdw0N4Sy0Kh9DEOeLaTX4kByumdqC91+E6ROAcIdvD7mpgeX3EfPQQiVFSxIYgBatpF6GM3JioASdbr4wBRybsbn4XHwgXiGcvBYvG8mccm+9HexjV45QyIL5rQ35m5Iu610LTzwat7gOV5iKKQvGeyrCTgVTQN/R6GBJma7SA8S4zY0SbZmvf4EYItRexazkzI7dOmDdsannNuio8VIjfFAOL8sV+Bq4eAVRY8ReTjXAH+nMsunmLYWvlJcxOAAYDcS5W11eBA2t9feIKpq6g6rv4Jvdqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/MOkPiq6g39ZGCj32AuSKKCXJDKuQKv1ChAqx8RYGE=;
 b=n1YmM3yolrmeq7LV5FokxO+mXcIpZh/ZB9QJaIQgUrIAkZJvbJRt5eLEp3H8Z3ODFw6TYQD+1Dlb4gNaYFpZDV8Kdt4mm9pjvVET1+T0DTD2R1biEiJ4wzpHCSrHmKhQqX3mh4oDBaMlgb7yHwL89wGZm7bAvEfYk3+7JR5DfI0=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by SN6PR07MB7933.namprd07.prod.outlook.com (2603:10b6:805:ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 04:55:54 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::4) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Thu, 15 Oct 2020 04:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Thu, 15 Oct 2020 04:55:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4tvWK005389
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 14 Oct 2020 21:55:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 15 Oct 2020 06:55:50 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 15 Oct 2020 06:55:50 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4tpBc002071;
        Thu, 15 Oct 2020 06:55:51 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09F4tp65002070;
        Thu, 15 Oct 2020 06:55:51 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <balbi@kernel.org>, <rogerq@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Date:   Thu, 15 Oct 2020 06:55:29 +0200
Message-ID: <20201015045529.2022-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c2ef34-bb04-4a1e-d1bd-08d870c698d0
X-MS-TrafficTypeDiagnostic: SN6PR07MB7933:
X-Microsoft-Antispam-PRVS: <SN6PR07MB79334D5E9AFDD0AE99CFEE34DD020@SN6PR07MB7933.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVms8tUEDGqBdIXk9uT/KB1nfzVvFbK+H++GIVJRaHqMl11VRtPahPv8r1KgiVLRSsgObTqIBS/V0CfSPjBv0y3dtOw65bkjqCCxquODUykSRvT4AKiU04Bw5UmMLumka2W8maUKNkfm+PsXB46/7CKEc4eGq2ikSdwRI1eUet93Hdi3K7ToAdLDclQtR4oYfiVLgbmSw6k3JwU+BbrzWjqnxEEzoCW+PYxDOLSvs1x/jeECkdYrLtLESXQL02RfxzMg3rd/2oDU0134hLTXm+m7Ky1QL4JXG6MIreB0W/WIDazf3rnIAs5tSxsuIneKRoL++ynjmRL+5nXMt29xkwOL0VGCJ/Sen18ItpjzymvCBL969eUXCyacxo2hW5fcyo0O0XjIUFC8EvpQ9db5LpmM7Qg7W5nYG7g0ibT1x6x/H7wgQ9kG7riqY8cEmM5tYjpT0EDfLWELKNsrAk88ew==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(46966005)(336012)(186003)(26005)(34020700004)(356005)(426003)(36756003)(5660300002)(70586007)(2616005)(54906003)(4326008)(107886003)(70206006)(42186006)(36906005)(316002)(2906002)(47076004)(1076003)(82740400003)(7636003)(6666004)(82310400003)(8936002)(83380400001)(8676002)(6916009)(478600001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 04:55:54.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c2ef34-bb04-4a1e-d1bd-08d870c698d0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB7933
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_01:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=1 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=684 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010150035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes not used variable 'length' from
cdns3_wa2_descmiss_copy_data function.

Fixes: 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
Changelog:
v3
- added "Acked-by" tag.
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

