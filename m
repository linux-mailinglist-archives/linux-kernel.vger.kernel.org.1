Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38A26F843
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIRIb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:31:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64570 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgIRIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:19 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08I8P7K2022867;
        Fri, 18 Sep 2020 01:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=CNdpmbLWlIQTFWonJJzYPCxLl221J73kxZgsrgtMtEg=;
 b=FRwGa031pKuOVHxe5DCEoVOkNMup2mnNqmImHu1lMr4Pgx21JcJi6/S+GO86Re44iimN
 GrMLcSZOHDhZYHdyIXaBEzbF7d3Sr2zJ+S13fReaa+tlamlD/zNCPrrS+n/Yb/9OGXNR
 8HpSuWUozqyxwShxxVZl/Mu1oD9VcKl3zj4zHv50mAyj0nYd0u7Z6tN5ZYN6PxUw8WBP
 C6ZARz4tpUEII2IG3ufyaksWCSZfU1kuOMyf74mSB9ekK4YI4Onn7G55i//eLtrsRb1O
 tBIqkEZAhuJ0Xv0g01o627H/0BWStF5gZ71GRsddtATG4++oOiUiYtwR9hSEbPnLlNvY pA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5nk3bw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 01:31:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZL2lJ14qTz0ypxwQrhaONgrWOZo9zHeFZeWhHZWRCiUln3SU9xw8mbr+t9LvSBHfZEXQYbyv1Sjc3FSCYCn4RvzUkarCKakrKNZXUMW+sso1IEoZVbKDggwJUpIj3XvtcWiC9sf7PuSywsBguRQpvIftb7L14Y0qBTC0/UgTb70Q76H3HzYOFYUGxWwv7N5T3W6EegWRRCD+XxTDJlH1s6WS15rdixDyKeWhh6sQpFJNn4i8nIR9M9xsD4bCefRIQ0xUb1GQKlWNrfGDf1IvZWw/pe96BJkR3apTxQGyzmQ4vwqBIcynz7bxmuz2wq30aY8yE5Tz/0/OUjm08AcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNdpmbLWlIQTFWonJJzYPCxLl221J73kxZgsrgtMtEg=;
 b=AdfsU9UYbzd0jq+zC9GQrhFKKRzXL6IOzS4M4KJ7eLfB0frzy1PA6xPj81PNMmebIz07kmMSiQjg1fY8Bzb3+gRqkTWMkddJjl/FcDCiTi7Ed4KI+f9tpxcWXqYi+4+3nyoUd2p5PtDpldxMBW9CWNc7SLjehL+PwsvWhH713YeJT6kANNFr+X/8HVfgEcevFsrGEYKlXc3gZq0WrB7rwpUytArdm71veJc2y2WOSzumZDqiq9YhVr0oRbKXkj7bR+tO0l3Y/U3rbamLJIn6wPtr+eCfRq+4RB9EepLJcVZvv0CpQixYJIAi6EZtknRPb7ApRYLsNiqP8RQTJiHDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNdpmbLWlIQTFWonJJzYPCxLl221J73kxZgsrgtMtEg=;
 b=csrXwhhjr60PFEL2QmCxT2jRQGkWvhs8XOlhAXmEZvPPeqr3+Vzh22i0Geuid8uAp0FlphfP8p4xKSWQlazHvc3JG+nUPXLPwB9AS4HsdcqIY6BfqXh1MCi3n9lkv+ohthx24B8jKiokSHNJlisYZ6SW21aQ6VeyAarZgoDjOP0=
Received: from BN6PR2001CA0037.namprd20.prod.outlook.com
 (2603:10b6:405:16::23) by DM5PR07MB2906.namprd07.prod.outlook.com
 (2603:10b6:3:f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 08:31:07 +0000
Received: from BN8NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::99) by BN6PR2001CA0037.outlook.office365.com
 (2603:10b6:405:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Fri, 18 Sep 2020 08:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT016.mail.protection.outlook.com (10.13.182.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Fri, 18 Sep 2020 08:31:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08I8V5oq003952
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 18 Sep 2020 04:31:06 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 18 Sep 2020 10:31:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 18 Sep 2020 10:31:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08I8V4pE018188;
        Fri, 18 Sep 2020 10:31:04 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08I8V4N4018186;
        Fri, 18 Sep 2020 10:31:04 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <jpawar@cadence.com>, <christophe.jaillet@wanadoo.fr>,
        <sudhakar.panneerselvam@oracle.com>, <gustavoars@kernel.org>,
        <pawell@cadence.com>, <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
Subject: [PATCH v2] usb: gadget: config_ep_by_speed_and_alt instead of config_ep_by_speed
Date:   Fri, 18 Sep 2020 10:30:35 +0200
Message-ID: <20200918083035.17280-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db352c63-2812-4564-24c1-08d85bad302c
X-MS-TrafficTypeDiagnostic: DM5PR07MB2906:
X-Microsoft-Antispam-PRVS: <DM5PR07MB2906F4D0298A772FDC8642ACDD3F0@DM5PR07MB2906.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IW+HNK2L3Xaxp+evEd+amPzGOmug5KS0MEeA4ChypUCnmqHfQPXYao5g0E6/M6HYq+SosbX+LfV47nGVelGydHOct49tCU8BO6pjNje4v1vaMzBGZYpYppTTMJSdUFVyARtChOmuv4nNx8f20hfutc/jNBOEDSRG57bzWVEYxQx2paZJ2S7ouYkRIvcurKg00nlmaCfcB9xxAVN6xk/Oz5drMFancIJdq0jdsovDVpNUHaXDHBnf6UIOii6Tt5/6GV3CzgTUGzStjVP95vsPL1jNPFqG5jG20248fvVZlQexN9Qh3tIv3UbUB73cyTaxZwj4RlV4a22kcUAmVmks4ylv5nnCIW1t5Xkkfu3db7Fyrnot9o4pLNBG+BVXRbkX3en7kBnwuw//B1dUkuF8AdlNNtcQ9/tiCAi7yuAodQw=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36092001)(46966005)(2616005)(356005)(107886003)(81166007)(82310400003)(47076004)(82740400003)(6666004)(478600001)(83380400001)(26005)(336012)(426003)(36906005)(42186006)(4326008)(8936002)(54906003)(110136005)(316002)(86362001)(5660300002)(186003)(36756003)(70206006)(2906002)(8676002)(1076003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 08:31:06.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db352c63-2812-4564-24c1-08d85bad302c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2906
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_09:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=763 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace config_ep_by_speed with config_ep_by_speed_and_alt.
This change allows to select proper usb_ss_ep_comp_descriptor for each
stream capable endpoints.

f_tcm function for SS use array of headers for both BOT/UAS alternate
setting:

static struct usb_descriptor_header *uasp_ss_function_desc[] = {
        (struct usb_descriptor_header *) &bot_intf_desc,
        (struct usb_descriptor_header *) &uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_ss_bo_desc,
        (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,

        (struct usb_descriptor_header *) &uasp_intf_desc,
        (struct usb_descriptor_header *) &uasp_ss_bi_desc,
        (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_bo_desc,
        (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_status_desc,
        (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
        (struct usb_descriptor_header *) &uasp_status_pipe_desc,
        (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
        (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
        (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
        NULL,
};

The first 5 descriptors are associated with BOT alternate setting,
and others are associated with UAS.

During handling UAS alternate setting f_tcm driver invokes
config_ep_by_speed and this function sets incorrect companion endpoint
descriptor in usb_ep object.

Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
case set ep->comp_desc to bot_uasp_ss_bi_desc.

And in result it uses the descriptor from BOT alternate setting
instead UAS.

Finally, it causes that controller driver during enabling endpoints
detect that just enabled endpoint for bot.

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>

Changelog:
v2:
- typo and unnecessary space have been removed from patch description.

---
 drivers/usb/gadget/function/f_tcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 184165e27908..410fa89eae8f 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -392,12 +392,12 @@ static void bot_set_alt(struct f_uas *fu)
 
 	fu->flags = USBG_IS_BOT;
 
-	config_ep_by_speed(gadget, f, fu->ep_in);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_in, USB_G_ALT_INT_BBB);
 	ret = usb_ep_enable(fu->ep_in);
 	if (ret)
 		goto err_b_in;
 
-	config_ep_by_speed(gadget, f, fu->ep_out);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_out, USB_G_ALT_INT_BBB);
 	ret = usb_ep_enable(fu->ep_out);
 	if (ret)
 		goto err_b_out;
@@ -852,21 +852,21 @@ static void uasp_set_alt(struct f_uas *fu)
 	if (gadget->speed >= USB_SPEED_SUPER)
 		fu->flags |= USBG_USE_STREAMS;
 
-	config_ep_by_speed(gadget, f, fu->ep_in);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_in, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_in);
 	if (ret)
 		goto err_b_in;
 
-	config_ep_by_speed(gadget, f, fu->ep_out);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_out, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_out);
 	if (ret)
 		goto err_b_out;
 
-	config_ep_by_speed(gadget, f, fu->ep_cmd);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_cmd, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_cmd);
 	if (ret)
 		goto err_cmd;
-	config_ep_by_speed(gadget, f, fu->ep_status);
+	config_ep_by_speed_and_alt(gadget, f, fu->ep_status, USB_G_ALT_INT_UAS);
 	ret = usb_ep_enable(fu->ep_status);
 	if (ret)
 		goto err_status;
-- 
2.17.1

