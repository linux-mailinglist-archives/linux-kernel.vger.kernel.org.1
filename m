Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660042874E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgJHNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:07:33 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:60129
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730121AbgJHNHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:07:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmDlWwzFcNuL55gkNqwPAQb25Kw4Mni0Z15cC4h/A3iv5Mh31M1IXJoitieGGmXsFpkh6fmGbBMGzuFxMFJJ7HC6NB+AAlCcDJPlag/aa6m1Sgyuk617jeWK+qlBr8fp8mT7Hjg7FOCHsdHBuwzEuvBhbBgg+vs0wEERC/WrzD1DqsL/dKHiUF7mSjTm+t3SgYfViFiyvoAwXg3k/MXl4m06mjxj4vu8N4hQcWe6cl8zdj6rJceNph+11L8t7RvJXVHtbN5KIeTNgHgfW/RWlZner2q296KEQJu4T7vto2g83/stFfYnk1WxiHa9kKUFQLK6LnTjlK6JHcwfJQZgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpR7+jXtu9ZuNjnuXfWsucpyJbjUIJ1vEWQDDX8JIlI=;
 b=S4IopKHgq7SUluZc2ZyCTvT+atSlOYREbm7gH+m7PVH5hGgKB0YS78Iia76Bb4aKqVrwLcbX+RNR3eLet+or/aaE54W5/wLeABnJXDLfXHqptegIWM9/meefnJgPH7DMsoq6wQj8zhbUtuF9jAXOeVGSAl2ZoWgWPZgqx/RmAFbKsqWHlj/DNR17mpAXjns0o6CaHSPNLBFoaf7GITCOhaCuxjTQpyr9ihFKyrIaP32pxMggm328uEv7TdVsoRhqIFrn0uYqGLntzFmSrWOuYBUTonqxV1x95d8LiDg9AAXNSVfn4kxs81FxUE1PLxKdkuWfsKn4JKKJjGpT4y4Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpR7+jXtu9ZuNjnuXfWsucpyJbjUIJ1vEWQDDX8JIlI=;
 b=iVFfD60yB7TdM3z+QCNDj8NWS6Yqq+tv6NDfmbD9phLZ3vQ1SqFIBvOi1m81FRRcluuu67iSWQdwCGQq7AK/2eIzfQa67eLcSH6hZWpo+lBcLt0YsyDVCrtC6ERJzWfSr6mM4Y6IE74t883UmARgHkzH8yruhHC56bmevLeJFFQ=
Received: from SA9PR11CA0012.namprd11.prod.outlook.com (2603:10b6:806:6e::17)
 by MWHPR02MB3197.namprd02.prod.outlook.com (2603:10b6:301:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Thu, 8 Oct
 2020 13:07:26 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::96) by SA9PR11CA0012.outlook.office365.com
 (2603:10b6:806:6e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Thu, 8 Oct 2020 13:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Thu, 8 Oct 2020 13:07:26
 +0000
Received: from [149.199.38.66] (port=53500 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVdA-0007Qh-GP; Thu, 08 Oct 2020 06:06:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVdl-0005vQ-WC; Thu, 08 Oct 2020 06:07:26 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 098D7HHx009714;
        Thu, 8 Oct 2020 06:07:17 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kQVdd-0005sz-Hx; Thu, 08 Oct 2020 06:07:17 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id EF2F2121083; Thu,  8 Oct 2020 18:37:04 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
Date:   Thu,  8 Oct 2020 18:36:55 +0530
Message-Id: <1602162416-28058-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
References: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b848b1a2-c61f-48bd-1c61-08d86b8b1a89
X-MS-TrafficTypeDiagnostic: MWHPR02MB3197:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3197D5819FB2DDD22B3CAC57C10B0@MWHPR02MB3197.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sefY14cGGzHQUkhTKA1zB3FpRWG+dp8GVJMtY0jZxiC8941xlcCO26ecuh65942ZlOmLwcVza7a2NL3JAY4XQMog6AO2FOs3fz4JX0yIHJ0t2+79h5am6BUGI72Hp9qtjeqGcN/gutwgWozcx90Ht8D8qeiKs2ZkM9Owz9JHbBuUrWV4uTPBaX1SwhcmImEuNio7mleAZA4x6bocSVblMWbXrnHQcD4zrh9JQd9wepGqDz4HPz9QzlLCqZqTw5NtXFeJ/vgBeni5xXtaSy5Dwaska2HwW/Wj/c/lw7U6o3Awhleo7wdOOT54C8zemTIVqr5ro8gu8JuJP2ZlYO5sHGMIvEVpeu5qd4wnBy0+ZDTQ5suCjfYwq8Y495D7W40q1c1L00HHprnYL4Pq91ACVQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(8936002)(83380400001)(5660300002)(36756003)(478600001)(2616005)(70206006)(70586007)(186003)(26005)(336012)(81166007)(47076004)(316002)(356005)(4326008)(426003)(82740400003)(44832011)(8676002)(82310400003)(2906002)(6266002)(107886003)(42186006)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 13:07:26.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b848b1a2-c61f-48bd-1c61-08d86b8b1a89
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3197
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Versal DWC3 controller. Add required property
'reg' for the same. Also add optional properties for snps,dwc3.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt     | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
index 4aae5b2cef56..0629f48cc807 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
@@ -1,7 +1,8 @@
 Xilinx SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	Should contain "xlnx,zynqmp-dwc3"
+- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
+- reg:		Base address and length of the register control block
 - clocks:	A list of phandles for the clocks listed in clock-names
 - clock-names:	Should contain the following:
   "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
@@ -13,12 +14,22 @@ Required child node:
 A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
+Optional properties for snps,dwc3:
+- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
+		flag configures Global SoC bus Configuration Register and
+		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
+- interrupt-names: Should contain the following:
+  "dwc_usb3"	USB gadget mode interrupts
+  "otg"		USB OTG mode interrupts
+  "hiber"	USB hibernation interrupts
+
 Example device node:
 
 		usb@0 {
 			#address-cells = <0x2>;
 			#size-cells = <0x1>;
 			compatible = "xlnx,zynqmp-dwc3";
+			reg = <0x0 0xff9d0000 0x0 0x100>;
 			clock-names = "bus_clk" "ref_clk";
 			clocks = <&clk125>, <&clk125>;
 			ranges;
@@ -26,7 +37,9 @@ Example device node:
 			dwc3@fe200000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe200000 0x40000>;
-				interrupts = <0x0 0x41 0x4>;
+				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
 				dr_mode = "host";
+				dma-coherent;
 			};
 		};
-- 
2.17.1

