Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05342B5A20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKQHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:14:22 -0500
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:22881
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgKQHOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:14:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMFt5pPyH4Ax2E9o7bFpVyu65MjoRlV37Tto3ePRgXEIScCjG0gzJ5mOdZEKEhgGpkoMVkBtJXq1jvHNh6uQVz3VHAqidk09uhkPTUV7xt8l4fDtGUD/2Lm4Jaq0jEsE88XwEAdwPSUv72VQqF0XCODuo8ZW0GlMzerMIrvQyvUmG+x7wHSRgi3lTnyFw1PjgHAOOAop4rvJO2GpkLkjIZC3of2hi0hqNkNr6vgp345yPgRwYWUNJI/q1eMOhoAwSxT5nDe6GWyLA9T2G1Zw6c+hh9LG1RNUZt/D5EOli+8P0UfyiZqhlJWNB6u+M2qN637D7tnKgJWH8Q6xk+UXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYlQRzsmelc2witT9662oGhEZD78OoHus8+r/dFoLCQ=;
 b=dP2gKoO9qBdHTnPVX2EDT7ivDHVby0elKGG1ycMViZ5IO0o7ZLNqCivJSn1qS9mkXSZNLJ1Ne6McQCQgh1eAN33QSaGEv5KoYjk1Yu3p3jMdzFeBdQ7XRckDluUvPrzQRb0UqDBYsl09umL4NkjvSZJvVRrDjOwB8NbfYe3BEeQinl1TK2yYkBi7+HkWL+Vk4IevytJg3jdmjvHAyXjxOwPJI3szeIcttyeABOpnzhTKNr35/+VUjiYV3MgDAfRi+v+z2OgPcnHTvRMGt337a1X1HXqp4O6C8TPvogsnYK72Y4d+4w+Z9Q0GOODtgyVFaCCRsy5g5jQSDL1w6+bfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=google.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYlQRzsmelc2witT9662oGhEZD78OoHus8+r/dFoLCQ=;
 b=F+lk2j8fFGgDwH16PBLJBX5y4wBImFIl/EtpBPFZXfIfZY+pcvf7NbgTThy+OqKqPUuBAor2UNyCRqau5VSi0P2N+8tUouqgEwZMmLMqqC9RSoGLrxAAaoljamRueK1EhNegHFj5G1uKZXrAf6ojy5GQ2g3+gZKpeEsaPRwEDbc=
Received: from CY4PR22CA0083.namprd22.prod.outlook.com (2603:10b6:903:ad::21)
 by CO6PR02MB7604.namprd02.prod.outlook.com (2603:10b6:303:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 07:14:16 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::cd) by CY4PR22CA0083.outlook.office365.com
 (2603:10b6:903:ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Tue, 17 Nov 2020 07:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Tue, 17 Nov 2020 07:14:16 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 23:13:40 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 23:13:40 -0800
Envelope-to: git@xilinx.com,
 lorenzo@google.com,
 maze@google.com,
 balbi@kernel.org,
 gustavoars@kernel.org,
 lee.jones@linaro.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=56754 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kevBL-0004M0-6z; Mon, 16 Nov 2020 23:13:39 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 60847121191; Tue, 17 Nov 2020 12:43:38 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <manish.narani@xilinx.com>, <gustavoars@kernel.org>,
        <maze@google.com>, <lee.jones@linaro.org>, <lorenzo@google.com>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: u_ether: Fix MTU size mismatch with RX packet size
Date:   Tue, 17 Nov 2020 12:43:35 +0530
Message-ID: <1605597215-122027-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67592aed-eb59-427f-3982-08d88ac864ef
X-MS-TrafficTypeDiagnostic: CO6PR02MB7604:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7604556323586DEE2C8B1EFAC1E20@CO6PR02MB7604.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Goe8FXLEreGJ9K1zHly5GeIuhsEw2hoV4VlMOi3l9LmaQShSaXYmpFbWpZPNFHanoi8c5s/sG6MVkZ2sTGLvAVR0hzEEhmNqA8jdd03E+IeZDxxsrz6BbD53fHMDJjROE7ohafS2ahBlPDY6PIl56irOU+q6GmMq3Lq9GFdbD8mPqH3M+RzaV2pW5xstSKl7EPaWeLkenNvrGiqDxgqNfQWUugCz8W0mgUOX1dCgIps4cZ48Um3PRkPmoNtMl3JacwtWBcydADIDcwDcYYJofF6ZeaUjoZvssDv/YNwSQcS61SJYn8ZhvpUxXn4Ygl1NWsnpcEOqNHlt7R3CfhpqZxZ/YHaZIvgpwagsUh8wPM7T33Gb4ZEYWswMkQUZ8K5O0KkKBPyiGoBFM5kuTQ5QgeM1JK4Yc7YuH0Qrdc+N0Sjmw9DxxlAToXvL1T+RdgEd
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(8676002)(110136005)(2616005)(36906005)(426003)(316002)(336012)(54906003)(42186006)(26005)(186003)(44832011)(2906002)(478600001)(36756003)(8936002)(6266002)(4326008)(83380400001)(356005)(6666004)(47076004)(70586007)(82310400003)(7636003)(5660300002)(82740400003)(70206006)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 07:14:16.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67592aed-eb59-427f-3982-08d88ac864ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7604
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the MTU size issue with RX packet size as the host sends the packet
with extra bytes containing ethernet header. This causes failure when
user sets the MTU size to the maximum i.e. 15412. In this case the
ethernet packet received will be of length 15412 plus the ethernet header
length. This patch fixes the issue where there is a check that RX packet
length must not be more than max packet length.

Fixes: bba787a860fa ("usb: gadget: ether: Allow jumbo frames")
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/gadget/function/u_ether.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 31ea76adcc0d..c019f2b0c0af 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -45,9 +45,10 @@
 #define UETH__VERSION	"29-May-2008"
 
 /* Experiments show that both Linux and Windows hosts allow up to 16k
- * frame sizes. Set the max size to 15k+52 to prevent allocating 32k
+ * frame sizes. Set the max MTU size to 15k+52 to prevent allocating 32k
  * blocks and still have efficient handling. */
-#define GETHER_MAX_ETH_FRAME_LEN 15412
+#define GETHER_MAX_MTU_SIZE 15412
+#define GETHER_MAX_ETH_FRAME_LEN (GETHER_MAX_MTU_SIZE + ETH_HLEN)
 
 struct eth_dev {
 	/* lock is held while accessing port_usb
@@ -786,7 +787,7 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 
 	/* MTU range: 14 - 15412 */
 	net->min_mtu = ETH_HLEN;
-	net->max_mtu = GETHER_MAX_ETH_FRAME_LEN;
+	net->max_mtu = GETHER_MAX_MTU_SIZE;
 
 	dev->gadget = g;
 	SET_NETDEV_DEV(net, &g->dev);
@@ -848,7 +849,7 @@ struct net_device *gether_setup_name_default(const char *netname)
 
 	/* MTU range: 14 - 15412 */
 	net->min_mtu = ETH_HLEN;
-	net->max_mtu = GETHER_MAX_ETH_FRAME_LEN;
+	net->max_mtu = GETHER_MAX_MTU_SIZE;
 
 	return net;
 }
-- 
2.17.1

