Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C22DA84E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLOG4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:56:24 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:37601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbgLOG4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Yj+eLfZapvSxfUAhZ/FR8f/BB3FKz0dZbPfG5UAL4OWjOi9zifj1VGSUq2Fb2TSf7EXM66G4A3pRAzDSmwtxuT65hQCQNUrLNJAt3MjErxH4hxen+59jUJYaP9eYwtCHT7VZ73kf8d6Ben7btsaa1Ku68j97qqSLd8j4aXUYlBxtsA8hv7OvNwxpg7pZQahlq6wVUp5xcqPZAxfJRvYvZbG8GZqu/ANLiUXh7llMGx4j+wzF9QdAizFJbxZuHDLDSh7wtyelZ92C1H9zzLOGZg1vUN/qjDn/cUx1qSX8Fv8xVQNVaEDme7Ct+Y0Xxeae+cce9SwDWrDDU98i6Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpVu+eRxsV15Ld42dwxFDEuCfVFciBUOeZO9cLc48BQ=;
 b=iQo0F+nSOskcfm0cKqJskxD05kEp1dVpNRxhjguF5Cktb/9eFXuq0MqXMFInm7Ijrm1MX3fekgbPE2RN3gVeJjc9DgqoD21fILJhxWfYY8Te7JOpNqN1Hng1ePtRwkowmG/FqpfX0JGvCPySrOXHpzGZgoHTjRiczNIAaKLjMBWYq4nHEeRevoJsoaZqaZFRXTEtg22JXJkKgibVJf67WA9dxPSt9gTAxFZe8xSoukN+8oZmg6ZAP7Si1RvZyMwmRxDK9YmAiplJnkhUKuY42j9JF8frbrFG1I8OAb6GvXAUj2taCYeEHbXgeO74f5aUIxBO5Nq1CJ6Fmi/VuDyX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpVu+eRxsV15Ld42dwxFDEuCfVFciBUOeZO9cLc48BQ=;
 b=i4VGL4oFTodKsVpmmPRG9r+rbzrVGXh8xro87ctVVP9LUJ4SEZB8r9zuTDl2sc8Vb9wa3lBsQNZ0hIh7YXAnOnfKP8j95PKLqcV1rsg4gl+I71EHuBHMKIHvXdk5PqzYsvg6gxQNqF6ugUgCNMrrAyCCk8+w+eoO2CrO3cXV30I=
Received: from CY4PR13CA0037.namprd13.prod.outlook.com (2603:10b6:903:99::23)
 by DM5PR0201MB3622.namprd02.prod.outlook.com (2603:10b6:4:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Tue, 15 Dec
 2020 06:55:14 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::a8) by CY4PR13CA0037.outlook.office365.com
 (2603:10b6:903:99::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend
 Transport; Tue, 15 Dec 2020 06:55:14 +0000
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 06:55:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 14 Dec 2020 22:54:55 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 14 Dec 2020 22:54:55 -0800
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
Received: from [172.23.64.106] (port=59582 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kp4EY-00068J-37; Mon, 14 Dec 2020 22:54:54 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 34F57121274; Tue, 15 Dec 2020 12:24:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [RESEND PATCH v3 0/2] Add a separate DWC3 OF driver for Xilinx platforms
Date:   Tue, 15 Dec 2020 12:24:49 +0530
Message-ID: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54100509-90e5-4db1-1346-08d8a0c65fd4
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3622:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB362253C2FF81BCF09A52B097C1C60@DM5PR0201MB3622.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiFA/0oAUIlbG0M6MqGFk3YaGTT8+4NEBHGk6v4vmjHvI5/EI6/GcWSLjwjcR0Oe3rIHuKIQyvcQ09QAMJneFlq88++ElVTCLyNVi9tFdf+GcWgIskrYi6hM0kj5HHld076EOfOMnrG3y6jeUsxnSCQk5lfmZQ2TT7gplWEsi0b7lPehy55a1vQXur3ePfzmbMLKLu9KDQ7Tm6QrCx/p+qNhWpJeBSQLKmBgZF2aCHuU11YBufBJCejJACB1+0sk9lDwqKz1eq1W4WPzugZ9Z9+/65TFnvCyfjsN8fAFklj54nJu7tLTdjaQgiz6VM333xXcBIutM1K7B4lRoFmWR9eQ8bquM0Q94IVreRce3V6aw6d/+yChLILmowFC4zXPpB6IGfuEmBWBycNbZUP/SZJgGn7SzqTtas844RkEuyQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(46966005)(356005)(70586007)(2616005)(70206006)(4744005)(83380400001)(7636003)(107886003)(47076004)(26005)(42186006)(44832011)(6666004)(36756003)(54906003)(8676002)(2906002)(186003)(5660300002)(36906005)(426003)(110136005)(6266002)(336012)(82310400003)(508600001)(4326008)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 06:55:14.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54100509-90e5-4db1-1346-08d8a0c65fd4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3622
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

