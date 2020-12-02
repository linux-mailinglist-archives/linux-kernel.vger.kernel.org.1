Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55CE2CBE33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgLBN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49382 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726979AbgLBN1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:22 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DObdM002317;
        Wed, 2 Dec 2020 05:26:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=wPXYXslqCDRuIzffFK3EYlekozDbrjgt3zYg2StZ4Ro=;
 b=TpXKjUNc5g7XBKU7MkViKSYcZu1eY9+Rg6XTvE5FEJrTAI2DsAH4nfJDcr1Zn9adiBQl
 YOCodESlzqH3W2DW+7bpyK/58udu/t9FPdyI9/UKKBmwIWdU75aHdE9qJmAWgkkHt+WW
 /w7mludAJiTeCmz2szw9w28dKHzkp63EjqaTnqCkdetZyf3y9J2vnh3xrfXT5s+5PMBU
 Al2iz8vebqwdM7goNjgTymvHc/+w9s8LZFnWXRhHzTYKrVTcA3dTRFdyn9748HDitlwp
 RJyQTICtAwgBigRGaXyk2UbdN20Ka5OfiZktN3SmpJ0o4+Mf49lUkcw7IGo3TyQkRj6O 7w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 355vn6apgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrdGj88JZ5LzRy42vwoLTmYZJnHcDp+wAK83amydYh4I3uWge91pq4rYBN2DSzPMC6CxkbFFVoCZePpNllpGDdKS7VqSeqmlJfMKR+7UshJ7EFGP5DxphdBdFo9nkVr6++4IjQ3ccvW62BQd4jkLy4ekVpQLxuePSYoV4xjsb4Qr/5A1ZKtPxHohe4xT49z7/IJjaYc8gnR7fYF1bjib3zjH1SGVl+kzT4Setn1T2GP5cmGbqq8VCLavooecxsNBymHtG5SpFD/Y5ab+8r39Dn0nBJjJC2pgHshfDhqfRE8Z65bwSJMzw1/Y0MfcWRKVzDJeEsZwt++sdKcVzKEXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPXYXslqCDRuIzffFK3EYlekozDbrjgt3zYg2StZ4Ro=;
 b=DqkyI+c8n1w76nWymbqf3fVW9xbyYR+ZUmapPRckZJuAcet2y83Wwk6alwTTXXEtkIusK4pnvJbw3l1GBM52sShvpFNtqgdtuyV7LopbHRmFir7CKdVqQxk4ZQVPqAdkukk5n9Y+V129Pc5hXkUhpTrgTmXeA2k13an6YZr0pdY6HsPB8VdwA3tRRCAo6E0v3iDc32Uy0B6MnE0AtiOpTjSRbAbwqj7KqA7NoYkVRKbwkFC83ZCMDB4FUceO4tuweeaMsCWmzJL419LS6g/GalzhjHpNNRyU4jy5RF5AUqo7OWOZtT2U6r6JhdU9vy6zZ9GABrYwrB7X4hui0vex9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPXYXslqCDRuIzffFK3EYlekozDbrjgt3zYg2StZ4Ro=;
 b=XYrzS2dYvCTFEJalqUhTcZ6Bz0ZWDquI9XsZuFyuEulTVWXopz4vXy7VYy9oqjRQbG5qsTK5iQpccatc4NCtYSjP+3IoA7wdAxDW5QL6LkgNeSu01ItGCsVVdqRVIFlhsbcdIa3nu0O8XLIkuEJX1yVH/MmiNn+0eqS+6ToSBsM=
Received: from DM6PR13CA0002.namprd13.prod.outlook.com (2603:10b6:5:bc::15) by
 MW2PR07MB4121.namprd07.prod.outlook.com (2603:10b6:907:9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.29; Wed, 2 Dec 2020 13:26:10 +0000
Received: from DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::5d) by DM6PR13CA0002.outlook.office365.com
 (2603:10b6:5:bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT053.mail.protection.outlook.com (10.13.179.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Wed, 2 Dec 2020 13:26:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6o6007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:08 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ68l010786;
        Wed, 2 Dec 2020 14:26:06 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ5ZJ010785;
        Wed, 2 Dec 2020 14:26:05 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Date:   Wed, 2 Dec 2020 14:25:38 +0100
Message-ID: <20201202132548.10736-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95516d5e-5b26-4b84-b1d7-08d896c5d50c
X-MS-TrafficTypeDiagnostic: MW2PR07MB4121:
X-Microsoft-Antispam-PRVS: <MW2PR07MB4121C8B3D5E6A760A4A50DD2DDF30@MW2PR07MB4121.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iN338GvxnjAp4Hs4JqciEqCuSzI3HluwvryDL6MRsuZe1TLoSYbqjQs8iKkbsYU6MVVeox1pRbCp8gBya8DnCX0mBxjBnaLIdNO+5JB47TJ/r/kpiLPn9S4zjhMCGos5SJQNhHUaGNS+Il9kUA2dySpqB6AUi/mNuabDRJosI4mSf17x/uCHeDQz02xSUB2Uey2OmxXMkdNZYsKKszcwIhKgyfpRKXUXYbhx1n+5mWQLFqQy7LltiE8himG7Vg5JsuDqoGDY7wqO3a2dDXc9deIKHLQpi1fPuy86s2AcSXLtxBNEr6n5K40OrFT1JAz/D8ZtfxyZ2tu45F5z0YSxgzlal/5RiPkk76ILTGQpOlMRf1ltx2o7xFO8rt6QeojWVoJ7yGZuFCwa98Nn1lgomieWXz2f8nh+WUaI1aYKAvM=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(46966005)(6666004)(426003)(336012)(1076003)(5660300002)(8676002)(54906003)(2906002)(42186006)(6916009)(316002)(36906005)(8936002)(186003)(47076004)(478600001)(82740400003)(107886003)(26005)(4326008)(70206006)(7636003)(356005)(83380400001)(2616005)(82310400003)(70586007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:09.9068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95516d5e-5b26-4b84-b1d7-08d896c5d50c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4121
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=699
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=1 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce new Cadence USBSS DRD driver to linux kernel.

The Cadence USBSS DRD Controller is a highly configurable IP Core which
can be instantiated as Dual-Role Device (DRD), Peripheral Only and
Host Only (XHCI)configurations.

The current driver has been validated with FPGA burned. We have support
for PCIe bus, which is used on FPGA prototyping.

The host side of USBSS-DRD controller is compliance with XHCI
specification, so it works with standard XHCI Linux driver.

The device side of USBSS DRD controller is compliant with XHCI.
The architecture for device side is almost the same as for host side,
and most of the XHCI specification can be used to understand how
this controller operates.

This controller and driver support Full Speed, Hight Speed, Supper Speed
and Supper Speed Plus USB protocol.

The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
The last letter of this acronym means PLUS. The formal name of controller
is USBSSP but it's to generic so I've decided to use CDNSP.

The patch 1: adds support for DRD CDNSP.
The patch 2: separates common code that can be reusable by cdnsp driver.
The patch 3: moves reusable code to separate module.
The patch 4: changes prefixes in reusable code from cdns3 to common cdns.
The patch 5: adopts gadget_dev pointer in cdns structure to make possible 
             use it in both drivers.
The patches 6-8: add the main part of driver and has been intentionally
             split into 3 part. In my opinion such division should not
             affect understanding and reviewing the driver, and cause that
             main patch (7/8) is little smaller. Patch 6 introduces main
             header file for driver, 7 is the main part that implements all
             functionality of driver and 8 introduces tracepoints.
The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.

Changlog from v3:
- added 'T' to MAINTAINERS file for CDNSP entry
- updated common code with latest cdns3 fixes

Changlog from v2:
- removed not used pdev parameter from cdnsp_read/wite_64 functions
- fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
- replaced some constant value with CDNSP_ENDPOINTS_NUM macro
- replaced 'true' with '1' in bits description in cdnsp-gadget.h file
- fixed some typos
- some other less important changes suggested by Peter Chen

Changlog from v1:
- updated common code to latest cdns3 driver
- moved cdnsp driver files to cdns3 as sugested by Peter Chan
- removed duplicate code from cdnsp_ep0_set_config function
- added cdns3 prefixes to file related with USBSS driver
- updated MAINTAINERS file
- fixed issue with U1
- fixed issue with L1
- some less improtant changes sugested by Chunfeng Yun
---

Pawel Laszczak (10):
  usb: cdns3: Add support for DRD CDNSP
  usb: cdns3: Split core.c into cdns3-plat and core.c file
  usb: cdns3: Moves reusable code to separate module
  usb: cdns3: Refactoring names in reusable code
  usb: cdns3: Changed type of gadget_dev in cdns structure
  usb: cdnsp: Device side header file for CDNSP driver
  usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
  usb: cdnsp: Add tracepoints for CDNSP driver
  usb: cdns3: Change file names for cdns3 driver.
  MAINTAINERS: add Cadence USBSSP DRD IP driver entry

 MAINTAINERS                                   |    9 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   61 +-
 drivers/usb/cdns3/Makefile                    |   30 +-
 drivers/usb/cdns3/{debug.h => cdns3-debug.h}  |    0
 drivers/usb/cdns3/{ep0.c => cdns3-ep0.c}      |    4 +-
 .../usb/cdns3/{gadget.c => cdns3-gadget.c}    |   28 +-
 .../usb/cdns3/{gadget.h => cdns3-gadget.h}    |    0
 drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
 drivers/usb/cdns3/cdns3-plat.c                |  315 +++
 drivers/usb/cdns3/{trace.c => cdns3-trace.c}  |    2 +-
 drivers/usb/cdns3/{trace.h => cdns3-trace.h}  |    6 +-
 drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
 drivers/usb/cdns3/cdnsp-ep0.c                 |  495 ++++
 drivers/usb/cdns3/cdnsp-gadget.c              | 2017 ++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h              | 1600 +++++++++++
 drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
 drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
 drivers/usb/cdns3/cdnsp-ring.c                | 2439 +++++++++++++++++
 drivers/usb/cdns3/cdnsp-trace.c               |   12 +
 drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
 drivers/usb/cdns3/core.c                      |  455 +--
 drivers/usb/cdns3/core.h                      |   54 +-
 drivers/usb/cdns3/drd.c                       |  222 +-
 drivers/usb/cdns3/drd.h                       |   94 +-
 drivers/usb/cdns3/gadget-export.h             |   22 +-
 drivers/usb/cdns3/host-export.h               |   13 +-
 drivers/usb/cdns3/host.c                      |   22 +-
 28 files changed, 10400 insertions(+), 507 deletions(-)
 rename drivers/usb/cdns3/{debug.h => cdns3-debug.h} (100%)
 rename drivers/usb/cdns3/{ep0.c => cdns3-ep0.c} (99%)
 rename drivers/usb/cdns3/{gadget.c => cdns3-gadget.c} (99%)
 rename drivers/usb/cdns3/{gadget.h => cdns3-gadget.h} (100%)
 create mode 100644 drivers/usb/cdns3/cdns3-plat.c
 rename drivers/usb/cdns3/{trace.c => cdns3-trace.c} (89%)
 rename drivers/usb/cdns3/{trace.h => cdns3-trace.h} (99%)
 create mode 100644 drivers/usb/cdns3/cdnsp-debug.h
 create mode 100644 drivers/usb/cdns3/cdnsp-ep0.c
 create mode 100644 drivers/usb/cdns3/cdnsp-gadget.c
 create mode 100644 drivers/usb/cdns3/cdnsp-gadget.h
 create mode 100644 drivers/usb/cdns3/cdnsp-mem.c
 create mode 100644 drivers/usb/cdns3/cdnsp-pci.c
 create mode 100644 drivers/usb/cdns3/cdnsp-ring.c
 create mode 100644 drivers/usb/cdns3/cdnsp-trace.c
 create mode 100644 drivers/usb/cdns3/cdnsp-trace.h

-- 
2.17.1

