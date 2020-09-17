Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEC26D643
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIQIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:20:14 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:18766 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgIQIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:20:04 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:20:02 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7skRd011971;
        Thu, 17 Sep 2020 00:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=tjKvoeonDhJsZHjEQnFYLyt6B8qcY7EEwVGEstSkGFs=;
 b=Kp84SfZqjMNOK34IipTfqJPwDrN15ILWM/iDOm3gylWODUARKvdaEw7UQwZQEp362CnJ
 zdfOpHbh5aVRrbrTcL/XUGzTy7184RU20ckVnOomVjRnAn3KEUzFkUsMlhnxfMn/KF2t
 6BLlkS/23tN3lB+IBpEt/0WweLXyjnXyUi2Spl8N2GMOt9lldpO6ieEWaq6SdrHH/jy9
 BgHbs46AnXyfQl2ziHOYtdP5jO8Yq1/Sh2grDqVLvV2nvkTOwm9DI1atojMPT898ZV+d
 SM8PbhogJHP6pM+Yko4tYQQXoluU/cL3JSHQ6tGhX68pvx279FAcLt6OSKzwUr/5X/jV /g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxphx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuNukgklqX9tpu2qQmbG+cE3mFT+MsQRzu1EP4nYnv/tZOM9ZskV0Qlp9q2FYfjk+f8HGObGMsjM+8/REo1j4N2QH7xQaGu1jt7KXaMJOOiAhvhMLWpTIfVDIghEq0r3rdqUH6VPa4k5FkMokTbneLF1ntDL+uj0a5RnRDrANepGizSM2Ul1BiAQ7/vojcKCFb38qLSuSXheoOGNHha0brXlP+twjO48Yk4e8R+kp9UlI6zXSwMrDdsWc80GMKFEg1axG58NoHH0thgObOE06O/sJNr5b2cA7eZ9TX1xxLZFeHOHiddAKVfq9X07Ns/oFEUqIQBuOvdmvuOZRLO2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjKvoeonDhJsZHjEQnFYLyt6B8qcY7EEwVGEstSkGFs=;
 b=RgPN64lBLwKdJ7AhxmbUZDR6LiD5W1NxFIM3n7rjZA4Ay47n0xpcFv0AN5zlO5ZtERlwvpUbS4Q8k9krAlYZPRS8c0DKpI2RrWdSf37LoV/FPexNcLNEPD1b87pzGbgTObODK1wPQhXlp0qw7X+QZr48cPwulYw40R21n9DDglLXhKwBd+fZnrxGbPzGKNOac7yOTNLrK34r/2bMmqzhz/9RKNIRvlkMIk10J8oe70UwHoFNUeolS38kPcVqbVcoC5SZxtoDR46aepxcS0nzbvojqS5uvo/XQ37OPHGikwRbYpDgKk4oliSdN4/dRXZ77YjpIxduiKtQUYsClKoXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjKvoeonDhJsZHjEQnFYLyt6B8qcY7EEwVGEstSkGFs=;
 b=3TN2Dp/p3HYMe0CIiypQaChMfcoCf0cz247gWy95RcnkL6eynPuxYWsWE6gmCKfenp3dZszTLy0CtdhK1UFnJNJPAOkftKSgzvsefytrW6ZV/534k+cggqy+qnL1cB37X3DoRmr6iBkay/Ems/+JoCx0W/oaFDRvW8qKkVAVapM=
Received: from BN6PR16CA0029.namprd16.prod.outlook.com (2603:10b6:405:14::15)
 by DM6PR07MB7116.namprd07.prod.outlook.com (2603:10b6:5:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:59:39 +0000
Received: from BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::c3) by BN6PR16CA0029.outlook.office365.com
 (2603:10b6:405:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 07:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT064.mail.protection.outlook.com (10.13.182.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:59:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7xbU1027227
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 00:59:38 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:59:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:59:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7xZU7027906;
        Thu, 17 Sep 2020 09:59:35 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7xYTF027904;
        Thu, 17 Sep 2020 09:59:34 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <jpawar@cadence.com>, <christophe.jaillet@wanadoo.fr>,
        <sudhakar.panneerselvam@oracle.com>, <gustavoars@kernel.org>,
        <pawell@cadence.com>, <Thinh.Nguyen@synopsys.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>
Subject: [PATCH] usb: gadget: config_ep_by_speed_and_alt instead config_ep_by_speed.
Date:   Thu, 17 Sep 2020 09:58:57 +0200
Message-ID: <20200917075857.27803-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f7d7260-f5a2-44cb-429e-08d85adfa0b9
X-MS-TrafficTypeDiagnostic: DM6PR07MB7116:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7116BD639910160F6E14E378DD3E0@DM6PR07MB7116.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppdJ9BZJ+f+oEtgFkiWlelyazWx8Mwctr8Rtf1jE/DFMy7ZWjSizFJnnMS+iKdrroCsxu+o/+kJcNcrt4myx3slBGSk6Ezmh0I2TvzP7BMDJoTaBiXSMbFOMK4sOm2i+sEIIp4ucsB/eRWthrN4CDyJNlvD7hQN1vc9+TeIy1sjlV5HFjTEkqnM7kf0GYrsceNaQH46ggk9pOMPcvFW/S1viaG6KPg2MOVlLrr3j9m5JMewniRmPLDagbCGni58r+dO2gckhvE3PSLghk4WDSk08S+c5nFdH8Hkqj83okKpv6NG7nSKRqAmTUrl4Weqbe9Fq6raC82GJi1MUrt1vIW0H0jJItj4m6dKAPEH1+k3DpTpijmm1jpgBO966KVZGaub9SApr+tYYZn7yq6x5FpSyMMO4eEi8FkPmHZrkoaI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36092001)(46966005)(2616005)(36906005)(86362001)(5660300002)(6666004)(36756003)(110136005)(70206006)(1076003)(54906003)(70586007)(4326008)(8676002)(107886003)(316002)(478600001)(336012)(42186006)(426003)(8936002)(26005)(2906002)(186003)(83380400001)(82740400003)(356005)(82310400003)(7636003)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:59:39.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7d7260-f5a2-44cb-429e-08d85adfa0b9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7116
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=520 phishscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace config_ep_by_speed with config_ep_by_speed_and_alt.
This change allows to select proper usb_ss_ep_comp_descriptor for each
stream capable endpoints.

f_tcm function for SS use array of headers for both  BOT/UAS alternate
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
and others are associated  with UAS.

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

