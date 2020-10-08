Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9072874E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgJHNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:07:09 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:13683
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730162AbgJHNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXJ7/Y+45RLLyPK9asUeYpNcpQiPtfiiN8h2FYsvcVawI2RgOCABe66GmlmYl/JqzRaeDF3VTLBTsyr3fmANmR1yN/x57dbA6gmgfM6A3kwP+F17l+4NELfahozHKi0Zh4h5K6RO5jB/w0JcrYjxy9y8e+PEon30DPmdqZLIirP+MbffhLYZZ44k0LujwG0gHXIQMObv2DKg6DsoGW44oU3CJtqEu7VtzapuT+3lbJ2zTVdCCFwuIZ2AwUaOcvxLWHSr4rRtNVkrcTWGx+d0evI5Tp4EoqRR58Ht8qoMlhSctk4Cr3DjY4YVQRNouAy7CsNXpY0Ak3zrPhsIVcsZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpVu+eRxsV15Ld42dwxFDEuCfVFciBUOeZO9cLc48BQ=;
 b=kLmR9QrrKkt1ze8bOj8lpz3kN5JtY6SONH3Tcb+Qa0jOtDlvXuEfryiU1haHC/jbPikL/UGqMn4HJHj43AwRHImKb+XeLRDme1biJqO7S/JuC361U7MmcancxuvwtEzG2h2xgcAP57a396jvSchX7wi4kMrMchkuDTkjOVLg2PXvIF8Ea69JBsBqZYRGoi173PFwfe0mJOqcH4ZrwcBNxS+sbaq7e5HWPTkM+T2CASo7EHS2e5jkQSRFie1jWsJNf0wsXJxpNKITbdrLdIrDKQEIWRrOp0BurJC4lLkKc2///5E8fEiuUt8FfF+hU2n6N61Txmf8UprwzKXdUjTMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpVu+eRxsV15Ld42dwxFDEuCfVFciBUOeZO9cLc48BQ=;
 b=amp1XA6NrbgLT+l0lWmZZmkHV2UWCY3PV5phY2Qz/iXZ1VigqAPdfGN+pdfpoSsXe2OY2zHwFq61ISB7UCPwf7WOoSMV4IDNMQKGUY6Gh34dGZ9DpQFCR+0+BvQIeMB/WCJXk4W7uP1QnYq9w8VTAQELrMMY0GXmdLb4k/CbX04=
Received: from SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) by BYAPR02MB4597.namprd02.prod.outlook.com
 (2603:10b6:a03:11::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 13:07:06 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::20) by SN6PR2101CA0019.outlook.office365.com
 (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.10 via Frontend
 Transport; Thu, 8 Oct 2020 13:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Thu, 8 Oct 2020 13:07:06
 +0000
Received: from [149.199.38.66] (port=53050 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVcq-0007QJ-AX; Thu, 08 Oct 2020 06:06:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kQVdR-0005oX-QG; Thu, 08 Oct 2020 06:07:05 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 098D74LJ009646;
        Thu, 8 Oct 2020 06:07:04 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1kQVdQ-0005nu-64; Thu, 08 Oct 2020 06:07:04 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 63AE9121083; Thu,  8 Oct 2020 18:37:03 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, balbi@kernel.org, p.zabel@pengutronix.de
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 0/2] Add a separate DWC3 OF driver for Xilinx platforms
Date:   Thu,  8 Oct 2020 18:36:54 +0530
Message-Id: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7c9249c3-3208-42b4-12d6-08d86b8b0e85
X-MS-TrafficTypeDiagnostic: BYAPR02MB4597:
X-Microsoft-Antispam-PRVS: <BYAPR02MB459790C251400CECB357FC8AC10B0@BYAPR02MB4597.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUzbRtl+McoQdKvc8597qrgh0VJ7aFmRJ7mCD+NAf+vPJENx3d7ibBvX5SJ2iE4wAwIpeCnkKeOemqf/IkEPOIKI91kHq4ZA5zn/zKhuLshc1PStaj2JOE3grGScvIOgWBrzNH+DUc7ao7jNo1ZnIeZFzMfhr4y08WVESM8Anr4kl6DOfI+KosnoBXCFaPD2Fp7KY7/1lsIqUGKy4aSJOpkQ/NkNYHzuzkX7lM+u+/n5LjGrvE1zRok9QOWiZV59994b3F5rEzNSIVR7jsXYZw2UxwzUFQdbHUPFsZ1u/YMJ0tXdCVcIlaiUsLFDtd8vvud3scs57kxJ81f+bO0xeIrMbCov1/lAklU1zyf5Tz3eE1ilJS6bQ2NxDkJyebxAUEz2YNUBilCiz5JXAEqkvg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(46966005)(2906002)(336012)(5660300002)(44832011)(107886003)(4326008)(426003)(8676002)(356005)(47076004)(82740400003)(478600001)(81166007)(186003)(2616005)(70206006)(4744005)(36756003)(8936002)(6666004)(42186006)(26005)(82310400003)(70586007)(6266002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 13:07:06.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9249c3-3208-42b4-12d6-08d86b8b0e85
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4597
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series documents the Xilinx Versal DWC3 controller. This also
adds a new Xilinx specific driver for adding new features in the future.

Changes in v2:
	- Addressed review comments from v1
	- merged normal and runtime suspend resume functions as they are
	  same
	- Improved description of some register operations to avoid
	  confusion
	- Updated commit log for patch 2/2 for better clarity.

Changes in v3:
	- Removed snps,enable-hibernation property from the devicetree
	  binding.

Manish Narani (2):
  dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3
    Controller
  usb: dwc3: Add driver for Xilinx platforms

 .../devicetree/bindings/usb/dwc3-xilinx.txt   |  17 +-
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-of-simple.c             |   1 -
 drivers/usb/dwc3/dwc3-xilinx.c                | 334 ++++++++++++++++++
 5 files changed, 359 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c

-- 
2.17.1

