Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD92DA851
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgLOG4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:56:48 -0500
Received: from mail-eopbgr750058.outbound.protection.outlook.com ([40.107.75.58]:44263
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgLOG4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:56:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUo6BYld+Mb14uDAyT/FTN5LdAxymI42bMJ2E85AVvI9xQF4g3fPOd3n7zEntkYq+IQxoGCl23f1w1ulCIQ7RmFembvjM5RmlZDX80M7ZD8XFCVgQdIY9t4dYhp1A19vrdMsGDJsYC9bkh/VhwH5u113nTY5crYXOJVPranYJKNR3ktK5vZ0ueXfx0pA7kkAAjwRlyZ6DWTqtTjqxsim+V+s9G/UDvuUgh2EAuPmfSqO7isn7FHh31fEQJ7KrfwCuFsWd7a/3UGwQbDOAqAwQW4W30XFW7FpMq3a8MMYuyffhWnWFLhJSo48ruI22gVruRZIuzT7qvZ0J7S36qvMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvW/J7ZlJgURjmLOAOl3/+zZKHyhlov0w7H/73sc5i4=;
 b=B8mCQ7CGYwAUfEw4E3AFeJMtWZCaIxFuJpVli7i536rNLsX+e61lkc/rGBFOo24sVfBFWCj4Z/YApLeR2jmiUG98OAbuEB6FZSlzqTW07c7BKDtTWCCToumUQYzh+qkjap2r3uHN9Oold9nhsTuIz5CYogsXbANC3o3iZqT6QnkKxlIWFqYDVlYEmGXj1sPDTnvALQAil7mrVwCCud7ym9tQWWpG8+KyZ5yipLCHVevC3bOQxw6TMZtBgYUscX8K0+n9CBofKeKcPVyxC5vASkFrVXe8GioYIEivN7nuwgZy9g3YkW1r2mySxRX0E5c5EtLucrI+51JSYsfR0jl1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvW/J7ZlJgURjmLOAOl3/+zZKHyhlov0w7H/73sc5i4=;
 b=Te0XWevU8btowGIafmVjjkiqg61VlKpjt/D2PI223CXzFL/eXqu0JMBZ3JaclwjLPmSuymMGlPgMK4sUO/ZfF2vCPaHLVDhea9IyFtsOGJ/uTptuCzTdZ+GYf8+oPAXR3LllHuGaR1KKl45nscmYFedSSvwST8WYsSlNj8+d57U=
Received: from CY4PR13CA0043.namprd13.prod.outlook.com (2603:10b6:903:99::29)
 by BL0PR02MB5394.namprd02.prod.outlook.com (2603:10b6:208:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.24; Tue, 15 Dec
 2020 06:55:26 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::ee) by CY4PR13CA0043.outlook.office365.com
 (2603:10b6:903:99::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend
 Transport; Tue, 15 Dec 2020 06:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 06:55:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 14 Dec 2020 22:55:13 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 14 Dec 2020 22:55:13 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=59594 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kp4El-0006EC-8R; Mon, 14 Dec 2020 22:55:07 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3A29A121066; Tue, 15 Dec 2020 12:24:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [RESEND PATCH v3 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
Date:   Tue, 15 Dec 2020 12:24:50 +0530
Message-ID: <1608015291-52007-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2f505c-99e4-4192-451f-08d8a0c666c6
X-MS-TrafficTypeDiagnostic: BL0PR02MB5394:
X-Microsoft-Antispam-PRVS: <BL0PR02MB53946B371FEB490C5658D80CC1C60@BL0PR02MB5394.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IolXB51d0u22sKyNUyDMU8UIUDQJpnHZLLVUmiqD5gdyloNYZ83FICMlxdlX3M47BJvn2HKpwJM4XFAoKbf0YTADEVr6pYNsK3W6H/F2252FLdv4o5IHKoqSZ7Naba0oHIbCldEWTMJEr+ACi//MEUsA4GATFuNdAitxoJwdfacFu2hXuySWZXM6vROHCI6twFQq207QQRZ0RSIeigr1s1UtzThUTrbzrzcaJxIDQL7JPoYnlm49bCP538iIiiHzJqIz/V6ejMJ7kCYLZtcGgqgo6oz/JFMAoTbzH96KqL/TI9Dus3FIf9fJMfTsD4z5uSnKBf8W9XkqGi1ytgoVkJYlEiZaNm4tJU8Piubep/dLRtVVbB+EUoXrgAbkfONoKWriY0WuQuqBWc1/BnLn9nk0eitXZB5i2A8OADGuhW8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(46966005)(4326008)(26005)(426003)(47076004)(8676002)(82310400003)(70206006)(44832011)(2906002)(36756003)(6266002)(107886003)(2616005)(186003)(70586007)(42186006)(508600001)(8936002)(336012)(356005)(5660300002)(110136005)(7636003)(54906003)(83380400001)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 06:55:26.0534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2f505c-99e4-4192-451f-08d8a0c666c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5394
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Versal DWC3 controller. Add required property
'reg' for the same. Also add optional properties for snps,dwc3.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

