Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343EA2D0E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgLGKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:20 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63308 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbgLGKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:16 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AbI1v007273;
        Mon, 7 Dec 2020 02:41:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=mS0aj4s14kvu5inKRBhZr/Tk1uW9w7+UktyOTV2DnXw=;
 b=il+30mqqvt5zbkp5ZxPnUTs8mQSbceRDKRYVpFoCTU4mvJtdB+J7FVGv+7FS8BQ5rBJK
 H0UM/bObrkMBL4+ZnLUABxe/iQdgLJ/eAqaCuERVweICVXeVr5SsojJ9SmPVQyRPeByF
 4jKSbnVl1yWdjynQTrc7D3O0tNXsYhdWOLJMpDs9niY3bx1+g2/jnQui+p+QrfViLlAV
 tU9JzgqoD9DT6K2BrAcPX+cpKf5a3B36+6YccTfSjqz0th7xql17YF9ggqKp0mSrHvek
 FDViTG2z/oofe6kppZHsLf+Va+nYurT9vSIqb6PcnTMBQcg6RiEXyQETkkZVHQWLIpZ3 +Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2m7yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyJsPrsWcxytbXLklVzu2WAI/n+LKi3enFMBH6xsI9GZ13qVnkzri0iZAByUllaE8QHNtEwxq3Mw9knpotMO/6gJf25Pty3LWRqEFy68YNPDtsqpOKA1BxcKoDEWpo0tn3F+GFJXJSsX88rjcySDjft3G+3CwBajNkwyK8aaWviqeWEaDLQulS00AiVs7TrPMohrzlkPzM58UOPzXxjjhWBSAJLam2PEpG5f3HWRjDlCO9kWPNVHhvnFoGjG9nIDethFUQ+0CRJKCGDAVwSCzqgxM1vIlF3lawYCANMPx2ixz/vCRnYykOQB/wNHfGO4hvaBIhJtoMvCl3V6+ZuwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS0aj4s14kvu5inKRBhZr/Tk1uW9w7+UktyOTV2DnXw=;
 b=e6XnmS/pZqgl1wo/oL/611VgaVJ5wdkhnCq6JlBUIQntpEOoslji4JugmyZOuvFT3cK77V3TeNeEFELSIQfDrW/GvTN1GV498B0kMsOMmVjgbRbhxfRsOMwBf7y2DOmq+b4DVmF5zyKlXaDzB07DiZEZSWD0Q5Vfn4AEwBoVPN0ERKYKvwaJgqyOq+HhfcOhGDzR3VMkVFfkgyb5am+GGQ1E7fnr1meQJn0ohsokTjPOhGLdugboWSVa497dT/zTgc9wTmbFsMCti2dQz+UIIy3zsDMJvOJnNZlv5KLbTZ6mg6YUSbBjMeuKDNqih2LWfb4tzFi2R52ueF2g8jHH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS0aj4s14kvu5inKRBhZr/Tk1uW9w7+UktyOTV2DnXw=;
 b=KtFrtwhPFwLEPSai7ER7vWoKaULIR5c8Q8cWAKfZbfymSHfNf02Mt/VaxCFjx9ahrrEE2HSa/s4kgSRvExSBZKDS0bT2SGIkWnuwcsZCHMHr8jNgfPw5blgclxloi+sfir+DnTupFXoeqleDafFmOcH4MGVqDejM6SrGEKoy26s=
Received: from DM5PR2001CA0023.namprd20.prod.outlook.com (2603:10b6:4:16::33)
 by MWHPR0701MB3690.namprd07.prod.outlook.com (2603:10b6:301:80::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.22; Mon, 7 Dec
 2020 10:40:59 +0000
Received: from DM6NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::33) by DM5PR2001CA0023.outlook.office365.com
 (2603:10b6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 10:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT048.mail.protection.outlook.com (10.13.178.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:40:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuT1007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:40:57 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:55 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:55 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AetlH006420;
        Mon, 7 Dec 2020 11:40:55 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7AetHo006339;
        Mon, 7 Dec 2020 11:40:55 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 00/10] Introduced new Cadence USBSSP DRD Driver.
Date:   Mon, 7 Dec 2020 11:32:17 +0100
Message-ID: <20201207103227.606-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8d8a244-10d2-479a-8665-08d89a9c95d5
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3690:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB369048B0E14AEDA57DC90064DDCE0@MWHPR0701MB3690.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGk5EsseOW6RljK9iNVbdV0KLEyCKC0C5Bp4echzGMU/xt336dIldderNihKjfSHyzEwnN7B3BpauUFPOJo50Ef40261Vo6NUs3FtHEZjSduUEcx5Q2b1Rd/p+4HcO9ZuhtP7TQWEGO7Xe2DcOebVOr67ywPiHwLYvd0skpT0qpVyMKjV1DVDk3fvNCb8Y0N6pBXUscAFQ5Z2okXBfsLel2E/6c6DIXkrjl2UYrmJ7ZquPMGv7cO6Qx8s8xGQYP7tgiGDtuzFLzffQMRBmb17fB6rDXr2TPQmKh7BJy5hrRjEJL9EEA9FVH37bfKiTnaxhoGu80FL4vLkCd/ftWwYvhNeTc711rEiVyDykSdokQ8ehenQLi+WSboXCiWK/EghKRk3+EyiUmV1gHOCt1s6CHzx2LeZPYbXEu44NK0pCU8BVIeLbqcpA0UMa3vbTcA+1RtKea6KKx/1oKyI6fYNA==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36092001)(46966005)(86362001)(70586007)(70206006)(26005)(54906003)(82310400003)(356005)(316002)(36906005)(186003)(42186006)(336012)(6666004)(47076004)(34020700004)(7636003)(6916009)(8936002)(82740400003)(2616005)(2906002)(107886003)(4326008)(426003)(5660300002)(1076003)(8676002)(478600001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:40:59.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d8a244-10d2-479a-8665-08d89a9c95d5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3690
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=655 priorityscore=1501
 suspectscore=1 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070068
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

Changlog from v4:
- fixed bug in cdns3_plat_runtime_resume as suggested  by Peter Chen
- fixed bug in cdns3_plat_suspend as suggested  by Peter Chen
- some typos have been removed

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
- moved cdnsp driver files to cdns3 as suggested  by Peter Chen
- removed duplicate code from cdnsp_ep0_set_config function
- added cdns3 prefixes to file related with USBSS driver
- updated MAINTAINERS file
- fixed issue with U1
- fixed issue with L1
- some less improtant changes suggested  by Chunfeng Yun
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

