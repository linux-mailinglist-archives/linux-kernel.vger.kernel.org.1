Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF227ADE1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgI1MeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:34:03 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63592 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgI1Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:33:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUE1i012279;
        Mon, 28 Sep 2020 05:33:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=7EglEEMm+3pCOpsC53EJxDHflZObctgzcjMTfkCSJDs=;
 b=ep2AWz7OiiSFoZIK06nLn0VMYxZAPTDRByH8rBStL5mhgyeT80luT4DVkAJQgUH6Hqfx
 mWFtbKI0J1k2skxfF75LujpmqcZPOCMUDVw3w1SVjiEJkAxBEi/dC9GbiZMC8bNd10ev
 M+oM+9J9CBIrRIk0zpQC3JQntvixeUgCYiFIiArHcnFvYFe82k4s1GHQvnNCQdrM7goV
 Hr3peUH9PMmSxY1UDSygWPn1ucgu8UC3JkTH+A/epNl8MJBvLLOns52/gj7IXBqGFlrd
 MjiFYDZ0l/Mw/YB0iKMke/H4isLWckmya+Unf1NBCcqUbetJNjz9YIX4R1S3xiNqgE3i AA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz0wDEgTkK2uCfP+rdQ81OITTrPeh9MLSAL6vSZLbpzMgD+AMAOeRjs064HWe9ZPaKfLWzpAA+ysa9xYwr5pa3MEk6v5mjnq/oKfPJc1NFyfDQhmHL2VbjtnKxWt/2Sr1NEXhnzCfZaDldB0WWylyhmh5HZOa5mfcfeIkQ+QlnZYGCRJfI0wWy1MnDaRFNQC1DMkw//BMGPrTEOf52zFDc2r7VyFSLzAwIdHVfXlVT9Kbv+OXeJeEbnXXA9f8gJ9lsjDOm7yQ4ytojhEc3KQcrtTQzYXb1pFJ+l+4ZxiENnB6+0Miakn4678KIcQXRASEzuMLIx+xAyerQpZLSR7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EglEEMm+3pCOpsC53EJxDHflZObctgzcjMTfkCSJDs=;
 b=QU+2abR6/UJ1yAfJuySQlH0CqtwhN1dtykvf+MnPn8EqLUJiqBkwzPgj8ecEEGFD01zmdFdBnSdzXEjqlR8H/OtQJuMYgty9neQoTHaISkesfB0uEq1et8oovdfGIiG9FqMiqdd/1U1KkmWn9RNBQnPgZdAJLOZUXJgjbA6TGVebN67NNZXaFJjGk550Hm80jF8nkvd8pBUTYP8AhPFCGoZm5Q2IDxGOWnavSDxjCNKtowrplu9Aa9PjUX+lVnEaJjy6ZGhTpE4D9e/VsqLZ4pggItjkq3VPzu18MgJOQKlHLCgwZ8vUX6LcW/tn3zWstzZXbc4lrxO7Nk5wwg3kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EglEEMm+3pCOpsC53EJxDHflZObctgzcjMTfkCSJDs=;
 b=tiwIuRuiddXQD65mrT/NNPrFXj0h6OEXWwVUGnXLmij/32WRja1+WlhZh3zyrr5F8QJdfgLyrAoxvvNBzzSyIa91V53ZAcbzW2/dESrsv8mz0Wx3xHRFa6YrRTD13Pkgnhbs6joDQacp4C2hZI/6v53DP/9/HTJGT2HhgMbeXWI=
Received: from DM5PR15CA0053.namprd15.prod.outlook.com (2603:10b6:3:ae::15) by
 BYAPR07MB5878.namprd07.prod.outlook.com (2603:10b6:a03:13c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 12:33:30 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::72) by DM5PR15CA0053.outlook.office365.com
 (2603:10b6:3:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCV030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:29 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:25 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXPJ7019055;
        Mon, 28 Sep 2020 14:33:25 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXNP2019054;
        Mon, 28 Sep 2020 14:33:23 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 0/8] Introduced new Cadence USBSSP DRD Driver.
Date:   Mon, 28 Sep 2020 14:27:33 +0200
Message-ID: <20200928122741.17884-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 448b1e68-b911-4b21-720e-08d863aab4dd
X-MS-TrafficTypeDiagnostic: BYAPR07MB5878:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5878EABA2711400F6BFD7709DD350@BYAPR07MB5878.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDjyQcl9hyuKf352lf8QqTtv4wSAFYy8CQGK9jH1Svm9t1WTCNTv/8jOPmNB0nd9YwvJ0dQqpW3wuJxU4Auxp6w6VGD+AuzyX7SnyYM8Q7Gzyw5om6W02BXiasjZxvyXTbP13Y2ktFlFsB3aiyAWRjYGIO5/kIfZNdecabqcxJ6wNoiDx4WJCKvkvxvb8pyx1xPGjYlphoBmaXCPYjCXWXo95IptHZJryrJkUTvLQyYgiDabXHtlyP0Y3QkClNlK7qA5h/tOthEWQZqnvQ2QkoqxcJ+KAiTemVXNH375+Ee4VTyN6WwIdja/3TacVYEFXiXOWyWBKpav1vfb6fL4wpS9uIZYvyijBQqQsQ07JnIrxiMuigepzsziUvAUJIxSmFIY8Upt4TwoyW1Q8MBzTKxJhx07C8TLAtqs7YuxXJE3vNGeHxWLe9fC12iPqX/kmpKfU3wfnzI9QRg4Wm1bYQrniIh465lEeCwnrs+MjVg=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966005)(70586007)(70206006)(5660300002)(7416002)(54906003)(426003)(83380400001)(81166007)(26005)(82310400003)(186003)(356005)(4326008)(47076004)(1076003)(2906002)(86362001)(36756003)(82740400003)(8676002)(8936002)(478600001)(6666004)(42186006)(316002)(336012)(36906005)(2616005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:30.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448b1e68-b911-4b21-720e-08d863aab4dd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5878
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=361 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
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

The host side of USBSS DRD controller is compliant with XHCI.
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
The patch 4: changes prefixes in reusable code frome cdns3 to common cdns.
The patch 5: adopts gadget_dev pointer in cdns structure to make possible 
	     use it in both drivers.
The patches 6-8: add the main part of driver and has been intentionally
             split into 3 part. In my opinion such division should not
             affect understanding and reviewing the driver, and cause that
             main patch (7/8) is little smaller. Patch 6 introduces main
             header file for driver, 7 is the main part that implements all
             functionality of driver and 8 introduces tracepoints.

---

Pawel Laszczak (7):
  usb: cdns3: Add support for DRD CDNSP
  usb: cdns3: Split core.c into cdns3-plat and core.c file
  usb: cdns3: Moves reusable code to separate module
  usb: cdns3: Refactoring names in reusable code
  usb: cdns3: Changed type of gadget_dev in cdns structure
  usb: cdnsp: Device side header file for CDNSP driver
  usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
  usb: cdnsp: Add tracepoints for CDNSP driver

 drivers/usb/Kconfig               |    1 +
 drivers/usb/Makefile              |    1 +
 drivers/usb/cdns3/Kconfig         |    8 +
 drivers/usb/cdns3/Makefile        |    8 +-
 drivers/usb/cdns3/cdns3-plat.c    |  209 +++
 drivers/usb/cdns3/core.c          |  336 ++--
 drivers/usb/cdns3/core.h          |   51 +-
 drivers/usb/cdns3/drd.c           |  219 ++-
 drivers/usb/cdns3/drd.h           |   93 +-
 drivers/usb/cdns3/gadget-export.h |   26 +-
 drivers/usb/cdns3/gadget.c        |   29 +-
 drivers/usb/cdns3/host-export.h   |   10 +-
 drivers/usb/cdns3/host.c          |   23 +-
 drivers/usb/cdnsp/Kconfig         |   40 +
 drivers/usb/cdnsp/Makefile        |   12 +
 drivers/usb/cdnsp/cdnsp-pci.c     |  247 +++
 drivers/usb/cdnsp/debug.h         |  583 +++++++
 drivers/usb/cdnsp/ep0.c           |  500 ++++++
 drivers/usb/cdnsp/gadget.c        | 2009 ++++++++++++++++++++++++
 drivers/usb/cdnsp/gadget.h        | 1598 +++++++++++++++++++
 drivers/usb/cdnsp/mem.c           | 1326 ++++++++++++++++
 drivers/usb/cdnsp/ring.c          | 2426 +++++++++++++++++++++++++++++
 drivers/usb/cdnsp/trace.c         |   12 +
 drivers/usb/cdnsp/trace.h         |  840 ++++++++++
 24 files changed, 10228 insertions(+), 379 deletions(-)
 create mode 100644 drivers/usb/cdns3/cdns3-plat.c
 create mode 100644 drivers/usb/cdnsp/Kconfig
 create mode 100644 drivers/usb/cdnsp/Makefile
 create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c
 create mode 100644 drivers/usb/cdnsp/debug.h
 create mode 100644 drivers/usb/cdnsp/ep0.c
 create mode 100644 drivers/usb/cdnsp/gadget.c
 create mode 100644 drivers/usb/cdnsp/gadget.h
 create mode 100644 drivers/usb/cdnsp/mem.c
 create mode 100644 drivers/usb/cdnsp/ring.c
 create mode 100644 drivers/usb/cdnsp/trace.c
 create mode 100644 drivers/usb/cdnsp/trace.h

-- 
2.17.1

