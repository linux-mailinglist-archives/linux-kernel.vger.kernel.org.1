Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3252A95AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgKFLqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:46:16 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:21550 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgKFLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BhMeY009732;
        Fri, 6 Nov 2020 03:44:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=NzZ10DdkE9R0JzcbW97KvB+Lt9IVwPSvpRQA6k51ERY=;
 b=ttpW8Aarh0fLzl6066F1uvGSNKPgqRUAJ+mL5P/zsiCUBLbzTQQAx+rZ/Bw9BkCh6xfu
 06euTyAvIh2RR096PXdpxvr7tkieamWREN0M0LuAhE3FRFR7zJNyPufrFykMsyLpgM14
 qLOdXMEAqckkFhmbuGeBxzWddV2iTIh7WQEc8OWYxHn73PAmkKQGiraFRVfaP9mOtiH7
 4qHhcr6Ga1lUk0WOf45U4lie3GjfNm73Lg123ugq/K0f6X6/MFLt4I9jFEJ4nN10cKV4
 CSPxK+pQuc37K0qRnSpVQUrXPZmSWW56Q4TJ7cLZakNYydUAPVhJbP40ae/oNQBrrhAf dw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34h4fvsr85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoaFFMjJKp59LD3fiMvijcbxlo5nya1hVs1a+ih9KiAhxO4/t5I+taiOS7b/qOCoggL5zP7zN0HeMmnha7jLJGdhCdHLG0dSHD0H2wdD/WS8StYuzaaD0dAcGfmq7RNuf6VnbRdascGQXXy36NyU1Hjdx9EI/SXBtdBiDU4f420yzCKAWvmjARHSmT9hsEDmfMxMkRT07SMBQDabiuSDNRqz/zQO6lcF4ms2ZHyjAyzc7NSWlwueYq4/Gc7Bh4DmISkyYwoiYWa8WDAQjh4jp8+vw5xIcZCl2iAeyZUePvfIhwCNcQ7/T99iJ3KgHj78qIQlG3ZDGP7kJ7sVlGsDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzZ10DdkE9R0JzcbW97KvB+Lt9IVwPSvpRQA6k51ERY=;
 b=mJ2n8qvUb1QfyOH6aMpMpJbCqUr0ynqTKn2AtYp6h/vxC4a8JsNWKwVz8iR1pRTA6eb3hI1z+q68gIe+wUieJdOoLZMTY4kJ5ORXfosCqTTWGcmSfjicvWlIIcRTZXUuRiaRo+Y1XHL57unhcq0oBskjDteSfRIPfPotb/Gkd0Sa+U4hL6zevMWMPLaWFdibFkADhwz1VydD+0/ZdcjrekRDREMlNZVX+IJSvwfzdqplMTRyyWSHUnVDRO9KyZ40mZjgMaAA2vg5izTO5osgSKtjKFLf5R7XqzNSQkAJBZENeMUYvJ9LU6BxkkGdqu/PBdRhRXo5N8UemEJMvxeZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzZ10DdkE9R0JzcbW97KvB+Lt9IVwPSvpRQA6k51ERY=;
 b=XU7ZSnzOsKK+kGRs7TRcFinUrfpDz+4YldOpOP/noshvpen2jo6wRr1r7APbNX3tZJPMryHASyJmALmNfSHmSzXB7TdOGFSqCBvv6xTPmJCaxkKZ3WjkI4Ruegn8GwOBltRnxU481zwdj7lSv/Z5kN0cR/SFEDY7u6q/RGP8XHg=
Received: from CO2PR04CA0097.namprd04.prod.outlook.com (2603:10b6:104:6::23)
 by CY1PR07MB2668.namprd07.prod.outlook.com (2a01:111:e400:c610::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 11:44:14 +0000
Received: from MW2NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::ae) by CO2PR04CA0097.outlook.office365.com
 (2603:10b6:104:6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT063.mail.protection.outlook.com (10.13.181.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiBPQ017667
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:12 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:10 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:10 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiAXW001556;
        Fri, 6 Nov 2020 12:44:10 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6Bi9SZ001555;
        Fri, 6 Nov 2020 12:44:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 00/10] Introduced new Cadence USBSSP DRD Driver.
Date:   Fri, 6 Nov 2020 12:42:50 +0100
Message-ID: <20201106114300.1245-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d67101d-7c09-4d99-6720-08d8824948a9
X-MS-TrafficTypeDiagnostic: CY1PR07MB2668:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2668AC4D234A1940AB1F835DDDED0@CY1PR07MB2668.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aj/fxqc2/uT4eD/BcRIn7XroRXDwOaVImbJYBbgSb11ka+Huy7EEtJGroraKhAG7Of9ioWSztdK2mQFY/V6GXO1RaKYpj6LrwmKii0sJjDImFg1Yu5tgZbnIlDqe5KVqTa61E4zeN2jWoVfs/NsTg3E2CdDxoNf6Ge5WI6orive45FT2Sek1Mvj/428a/YBCWrqT8spyHF2eyS6o5mYMUk5dFzQjjDrXViiY3LBdkJ3ZRzBkEvvFldSewX8fZsjDgfb8Vn1Wq/wN5SposbgB3ZMnKq3ZqO2Zpfi53DpyVaHZT3Y2lM7lBSb9165LW8Opz5VYvGDUc5zjhPmfRJwj+hOHmAkuA8Z8HHON0SIGMx1/wqaJBU/eoz3vE2A+nJEucCIbk0KDOyjSPp1uQvvqHk05JDBL9+dzT4lbe4Rs5c=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36092001)(46966005)(26005)(8676002)(47076004)(336012)(316002)(36756003)(82740400003)(6916009)(186003)(54906003)(1076003)(36906005)(42186006)(70206006)(4326008)(6666004)(8936002)(70586007)(2616005)(2906002)(82310400003)(478600001)(7636003)(426003)(356005)(86362001)(83380400001)(5660300002)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:13.5600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d67101d-7c09-4d99-6720-08d8824948a9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT063.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=1 phishscore=0
 mlxlogscore=229 mlxscore=1 clxscore=1011 impostorscore=0 spamscore=1
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060086
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

 MAINTAINERS                                   |    7 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   61 +-
 drivers/usb/cdns3/Makefile                    |   30 +-
 drivers/usb/cdns3/{debug.h => cdns3-debug.h}  |    0
 drivers/usb/cdns3/{ep0.c => cdns3-ep0.c}      |    4 +-
 .../usb/cdns3/{gadget.c => cdns3-gadget.c}    |   28 +-
 .../usb/cdns3/{gadget.h => cdns3-gadget.h}    |    0
 drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
 drivers/usb/cdns3/cdns3-plat.c                |  314 +++
 drivers/usb/cdns3/{trace.c => cdns3-trace.c}  |    2 +-
 drivers/usb/cdns3/{trace.h => cdns3-trace.h}  |    6 +-
 drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
 drivers/usb/cdns3/cdnsp-ep0.c                 |  496 ++++
 drivers/usb/cdns3/cdnsp-gadget.c              | 2016 ++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h              | 1602 +++++++++++
 drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
 drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
 drivers/usb/cdns3/cdnsp-ring.c                | 2439 +++++++++++++++++
 drivers/usb/cdns3/cdnsp-trace.c               |   12 +
 drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
 drivers/usb/cdns3/core.c                      |  453 +--
 drivers/usb/cdns3/core.h                      |   54 +-
 drivers/usb/cdns3/drd.c                       |  223 +-
 drivers/usb/cdns3/drd.h                       |   94 +-
 drivers/usb/cdns3/gadget-export.h             |   22 +-
 drivers/usb/cdns3/host-export.h               |   12 +-
 drivers/usb/cdns3/host.c                      |   22 +-
 28 files changed, 10398 insertions(+), 506 deletions(-)
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

