Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924C92B9463
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKSOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:47 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3378 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727811AbgKSOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJE6moZ027517;
        Thu, 19 Nov 2020 06:14:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=/pFUSpsjVdqafYJMThsn/UezdHk61ORm/rQ83V5581A=;
 b=F4mYp/HxLT+dRUqCy240DTqcwnxfbdnVNsKECWXRH4DzVoknJ6C0MA6rAMRuBBSAv6H7
 hnWDTP7fARGib/q1Ozw8EvuZ4V1QhI5/Q6RDX1Vqa4vTnXpgCXuE2hUl6l0OQjMVk/eQ
 BwgXm+ClwAQVSd35pnQLpi9db/UBGm9W6qF6eFFPDDxfZidKVqBTNjsKCvt4wo0qlTuc
 LPAAf5TbY4YDzFq1Lf3gd7MykqqlhwmXYMQWWzPQmRgvMjCXsI34K0iwa/HNIImDW2Nf
 vYbYJZAHJXjn/aYkbl4rFixrX0zyA8+Nr0v3YLjIRAvEeVoff1O8RS7HECOEVUo0lOTr iA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34tcp24k4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 06:14:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRJ1eZe9pKZomS1u3pKWrBWHZR3vvnL+YD2XDkArjfgHsgpM82seD4gtq9fuK++TmvK+sDbBlOKqU53jqvAUr/OmQa9ykmuXOvvpe3SF9VdFQauMo0YKv/lB94pMtmSYFOaH0cj8MGUKsa3NYTo6VSbwlNnLhBnLK7KR5T4nFGnx4KzYk7koi9a5+oB2x+QhZ5ZYh3e/ZcbBhhIG6q/YlNq6/Nbk7aUzzlRgh9EG1zL2sv2fMiEN9gJjs1qthPGrRL/8MXsSVroIoBx4EC71ridNtnyEIDaiIr4x/Rwkb/pWJaueC+oZYW3mI4j6pe887fDItUdRyYouONZih2G8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFUSpsjVdqafYJMThsn/UezdHk61ORm/rQ83V5581A=;
 b=V/uJzJzoAGqxg/0W6i5Or4gnLrsgCWWs1rky3RvkQacaxRJs6tPnf3N8UVHJjLFaPm5nEOyK6zzc2sRq4crAPTtrZkw/JY14GcYsoQZ6/2v5dI3pkI2R18vi5UjOIUB9qt4wxzfyDUM40kawdN8Dy8PihFVZwCazbmeKm8LtauIBIm2kRo5LkVX6xjP5F9n1SQKD+rYWgcVXAveycCHSVoL1XXj5y3ZZKsYSNJdiu/QqBQQBTGgrlYepo19o1EoM5jh2iiHHT5t0gGWwGRLEWr3vBckzHEesrJJsKtmvmnAFimjLix5wBSOmtr+ol+99gKianj7VINZf9KiSIuqhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFUSpsjVdqafYJMThsn/UezdHk61ORm/rQ83V5581A=;
 b=3R4KOfhUdmBCNyXQ665Hz6m8jR5o3QguIlTPwt3NPJcjzbsiFyMubIUTdTUNbeTSrjxgIkQFTxAXpHG/zxUR36PE20PEsblBcS6mJwETvzFJmn8rHoeke+etk9+fXYvKGm2ISjPsRNsRSddYkTKutyWOiRTKNP3WRsmGaMAKJeg=
Received: from BN6PR03CA0103.namprd03.prod.outlook.com (2603:10b6:404:10::17)
 by BY5PR07MB6625.namprd07.prod.outlook.com (2603:10b6:a03:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 14:14:33 +0000
Received: from BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::fe) by BN6PR03CA0103.outlook.office365.com
 (2603:10b6:404:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 14:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT037.mail.protection.outlook.com (10.13.182.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.11 via Frontend Transport; Thu, 19 Nov 2020 14:14:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERJ2022418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 19 Nov 2020 06:14:28 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Nov 2020 15:14:26 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Nov 2020 15:14:26 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEEQgh011711;
        Thu, 19 Nov 2020 15:14:26 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AJEEPpr011675;
        Thu, 19 Nov 2020 15:14:25 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Date:   Thu, 19 Nov 2020 15:12:57 +0100
Message-ID: <20201119141307.8342-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5692ecc8-2062-44fa-4fa5-08d88c956ec2
X-MS-TrafficTypeDiagnostic: BY5PR07MB6625:
X-Microsoft-Antispam-PRVS: <BY5PR07MB66253DAFB1F04D4036119C05DDE00@BY5PR07MB6625.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oIiuT/3TCilMposCwPF+Wx+liy3CUud/Y9QZXvs2T8MYRqlEnbeU6TATq73Qv+B+neFQTSmCtASfBbLYL6ch+aXVGubxXNdtFLDn7dy2/JEHre30+U45BLjS520+/tXLFJ+zuz59X9YBl4UoZz2dIJzKv2VDa6ak/WqfzPKuuoWcuXRvJTkewM+HLKSFAxI/EW60R2P/OcuDEBCVMbQKeY87Xx2wqI6GOok16C5nuT8LS0thshPtq1o28e3U0DtRmqxMZfsmFzcJa3xBCME31qnXJbm7s6uFXUOi4D7IEBU6gZJPPejB8/R52Ki9IRB6ZZaPkSnDa4Z1x1K+Nw9OuZ4f9FTg/428mQ7EoiPMsGcQeC4lt2RB+Uw25MqybYUQNxBobkhMxsQaUMSDIMTHUof2EM84Hv0fKxSwHpGNbY=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36092001)(46966005)(186003)(6666004)(47076004)(8676002)(336012)(1076003)(82740400003)(426003)(83380400001)(5660300002)(36906005)(2616005)(42186006)(478600001)(107886003)(7636003)(26005)(6916009)(8936002)(4326008)(356005)(82310400003)(54906003)(36756003)(316002)(86362001)(2906002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 14:14:30.6990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5692ecc8-2062-44fa-4fa5-08d88c956ec2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6625
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=1 adultscore=0 mlxlogscore=652
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190107
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

 MAINTAINERS                                   |    8 +
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
 drivers/usb/cdns3/core.c                      |  454 +--
 drivers/usb/cdns3/core.h                      |   54 +-
 drivers/usb/cdns3/drd.c                       |  222 +-
 drivers/usb/cdns3/drd.h                       |   94 +-
 drivers/usb/cdns3/gadget-export.h             |   22 +-
 drivers/usb/cdns3/host-export.h               |   13 +-
 drivers/usb/cdns3/host.c                      |   22 +-
 28 files changed, 10398 insertions(+), 507 deletions(-)
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

