Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926112D96FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407561AbgLNLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:06:22 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41450 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407536AbgLNLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:06:02 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BEAo4kF021967;
        Mon, 14 Dec 2020 03:04:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Nn8sdbgH7cJ8yop6E1gQYaQLI0mlAj2zbdgkgw9cdBM=;
 b=l1eZ1+1a4Z9ZlAP/RBUP6vlgaalpPXUXnenQ+oxCxwXQc4wdKj9PyVgIYFYv2okJynuJ
 eetGJ6FxuKYAxbFTe0yWNCc6qqedbGtKkK1zky6g5LwS8TiJTH1Zy96D942wiLCTOWfQ
 laI4SYcNr3R3KoYgF6aOBIaU9KWIp5QCOqruWaleDfVs8xSGaSXuIT70qZenGMQkFvhM
 JBi5c+c6o8/FbhfVzE2sw/+zIggqRo7kt7M3YdwftYg2YzRx6bQNpYwL550emAjVF5ja
 evGqvRund8I5ZxxnVsQImMFqlL2qRm07QUiXtp8dVGkkH8hXoBC/UBvbLlrwK0kUKX93 uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35ctb2n242-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 03:04:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T28i3Ttk8LQemKd6kQn1d/BA1XzK+0E+nYSKg++aRTEVLeeQToXxR7mY8CcsOnXMlPIMa0HgbzKscjf21I8pOmAaG8uZXctaIcqyCdnM1BwIvlSv1gpibpfI/zeX3I25Ci3Xab66fEeLb9mBnsP5WbsJW3dgxKhfCtkDf7DrTYkWuEvR5/1p3N0/OCHX6vvIpomaMt/j6IwZorSGz/Yt7MsgLBMUu+nKgBEFUH5848RKL2v3MMvl8CFBwrkLXJxsikmI/oVfc/+Yj44nWlWmk2qf9wuVpc95TR20sf6Jr2rBFpPyhc2ZoUt34L4ZqwAEgJotz+BVsxrOhrI0hGLnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn8sdbgH7cJ8yop6E1gQYaQLI0mlAj2zbdgkgw9cdBM=;
 b=LGWFcajv+OFQHcUv/3mpajZmPuYCY7MEDfdQs6me+g1bSMMvaZUvrI7mFsaKkOscrx21xJI5cE3Vznd/Z0y/vQyYGbXokv6GrsEgo3ni1Vo3f/fbeLley/01sWB+ZY40eC+NpU3PDn4E42CfrG1fuDlaQmXSJ6UaryJTVNosZTvZCBFK3cHSWldnOG6+K+e6NppGO0PvnvOCczsuQeG4ng76drxoepsrPu0WKSTUP3hOJSS1ca2ov4cjubeYTNfXhUXMZRafZM5ApnrZXzzCYRjTulS4V+IpGG4B+A7WcMblkR0h6mmkvZ2INlSQilquBMvG9gF0t77RS2x3hedVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn8sdbgH7cJ8yop6E1gQYaQLI0mlAj2zbdgkgw9cdBM=;
 b=AY/fqHt9PKB2hNOIliDfDFhxvfZGQnlKx1Logspv213melBYTJwrbhl/h8fWox0flCiaf4YYR2LnC6zQ9HPYJ7d+5bKPai44exxeHoZHP2ObDeX0pAYa3t2Lq6TPwW4nc1D1/SDAAE62gzLYy4ZaP8hwqdj3ytyGFkt1swo12C4=
Received: from MWHPR14CA0069.namprd14.prod.outlook.com (2603:10b6:300:81::31)
 by BY5PR07MB6515.namprd07.prod.outlook.com (2603:10b6:a03:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Mon, 14 Dec
 2020 11:04:48 +0000
Received: from MW2NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::5) by MWHPR14CA0069.outlook.office365.com
 (2603:10b6:300:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Mon, 14 Dec 2020 11:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT006.mail.protection.outlook.com (10.13.180.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Mon, 14 Dec 2020 11:04:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0BEB4jKR013186
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 06:04:46 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 14 Dec 2020 12:04:44 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Dec 2020 12:04:44 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BEB4iT5019511;
        Mon, 14 Dec 2020 12:04:44 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BEB4hQM019508;
        Mon, 14 Dec 2020 12:04:43 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <rogerq@ti.com>, <a-govindraju@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Fixes for sparse warnings
Date:   Mon, 14 Dec 2020 12:04:33 +0100
Message-ID: <20201214110433.19461-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953e9045-0104-4238-64bd-08d8a020126b
X-MS-TrafficTypeDiagnostic: BY5PR07MB6515:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6515C8C1EAA1C4645B6ACA00DDC70@BY5PR07MB6515.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QEgc45M8UsJMbn0Vq/UWcjF+8GKXM9Gkh/nmHiO7mio4dYAJqxf4ltXpmYNRjXzDPuMAYXFKTDp11D8uwKvbrlptSkEH65aSL85m/aC0O1AZ5z2S7YjLxWTqgmNYSd/1hNr64G0ARZ7tXhAFZ1SQ1oXmfylwvWzFTD45A5lfxQ7o0zfOgfaZkgn/1/I49wWkB0BPpDQ2CEG88bQuT0RPr2Mjh5wWPQmJ8HU/UMrrpE6LoeLcfb7ujolaJLlG2b4WwJ54pb35WEV/kVyCo+pwYLhT1a89u/2E7CslKM7zHvOWAiYiPjZl2wHKzLZ+ZxnH/7P5KK4jXDI/9F1Pu0sAIOnBap5K+/I9cMPxbPMxHqkfcaKPMwIIe69sWtJcG9HYBK8bKqPsojirfaATp18OOnwdjQo0Dx2Sdkpg6NI4Zp+nGpQiCz1kW/hoH5siDMKIBWM61fL+pDkvVq/zeu9Yg==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(36092001)(46966005)(336012)(2616005)(8676002)(81166007)(6916009)(36906005)(34020700004)(54906003)(86362001)(8936002)(2906002)(107886003)(1076003)(42186006)(426003)(508600001)(83380400001)(6666004)(82310400003)(356005)(47076004)(70586007)(26005)(186003)(70206006)(36756003)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 11:04:47.9791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e9045-0104-4238-64bd-08d8a020126b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6515
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_04:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=493 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012140078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch fixes the following warnings:
cdns3-gadget.c:1203: sparse: warning: incorrect type
                     in assignment (different base types)
cdns3-gadget.c:1203: sparse:  expected restricted __le32 [usertype] length
cdns3-gadget.c:1203: sparse:  got unsigned long
cdns3-gadget.c:1250: sparse: warning: invalid assignment: |=
cdns3-gadget.c:1250: sparse:  left side has type restricted __le32
cdns3-gadget.c:1250: sparse:  right side has type unsigned long
cdns3-gadget.c:1253: sparse: warning: invalid assignment: |=
cdns3-gadget.c:1253: sparse:  left side has type restricted __le32
cdns3-gadget.c:1253: sparse:  right side has type unsigned long
cdns3-ep0.c:367: sparse: warning: restricted __le16 degrades to integer
cdns3-ep0.c:792: sparse: warning: symbol 'cdns3_gadget_ep0_ops' was not
                                  declared. Should it be static?

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/usb/cdns3/cdns3-ep0.c    | 4 ++--
 drivers/usb/cdns3/cdns3-gadget.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
index b0390fe9a396..9a17802275d5 100644
--- a/drivers/usb/cdns3/cdns3-ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -364,7 +364,7 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
 		return -EINVAL;
 
-	if (!(ctrl->wIndex & ~USB_DIR_IN))
+	if (!(le16_to_cpu(ctrl->wIndex) & ~USB_DIR_IN))
 		return 0;
 
 	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
@@ -789,7 +789,7 @@ int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
 	return 0;
 }
 
-const struct usb_ep_ops cdns3_gadget_ep0_ops = {
+static const struct usb_ep_ops cdns3_gadget_ep0_ops = {
 	.enable = cdns3_gadget_ep0_enable,
 	.disable = cdns3_gadget_ep0_disable,
 	.alloc_request = cdns3_gadget_ep_alloc_request,
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 9b8b0cd3d2c2..582bfeceedb4 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1200,7 +1200,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		td_size = DIV_ROUND_UP(request->length,
 				       priv_ep->endpoint.maxpacket);
 		if (priv_dev->gadget.speed == USB_SPEED_SUPER)
-			trb->length = TRB_TDL_SS_SIZE(td_size);
+			trb->length = cpu_to_le32(TRB_TDL_SS_SIZE(td_size));
 		else
 			control |= TRB_TDL_HS_SIZE(td_size);
 	}
@@ -1247,10 +1247,10 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			priv_req->trb->control = cpu_to_le32(control);
 
 		if (sg_supported) {
-			trb->control |= TRB_ISP;
+			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
 			if (sg_iter < num_trb - 1)
-				trb->control |= TRB_CHAIN;
+				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
 		}
-- 
2.17.1

