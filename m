Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C899627ADE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgI1MeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:34:16 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33636 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726621AbgI1Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:33:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUE1k012279;
        Mon, 28 Sep 2020 05:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dc+vVasiXYsGdDc1U7ARHfSA/2y/8rjb1HJvvu35hXc=;
 b=G7HXszzAiV3uOeEnw/6Lu7T9M1NfD78IrYgf9xHU/7wJXHOTq3fOyHBkXVKaXg0FNGNm
 09+znXOX48sE0VeK3nWVRMKsyWcFe5mNYfWnc+Qn7pmBlAy5/gM7UejpyIgN13Fb5Ngi
 Tev97CLIJuAfA6rEh/ZGImSjwrCYOAhEnXFOhOgLhbTb0W5xBmYOX7nRIzQHdRqiJe1j
 88FbFOh/1a1lNDxt9Bew1Yh8EpnHigjaBGpZ20rXBPr6VCHIe6TY5WaBoGonsVoEqMU4
 M8U7Ib0GTqemF+cGVNC/XOLz6RKQ8vGHNSdVy/s9x502Zpc05aO/UYarWjgaaVl8Nn5t PQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnA6mmQuaNMk7X8Publcv5uLqD5XHk92oPzyIwZpa6db2S0SEqUalwdmz3FGv+OMS2eivzsjBApZOUh53Dlf3KKU94cdDaIpzAmP30H03fayYvRk01E+8Rur0Fb4Go5F2M81Pf9q4DlzvD8aVcetXA25cTi5g+lR2NhOq3vNdP8Ue8jBZdN+uc7DvlvxwFldH+4yOpBWEoNEC2nWRil8e3RtZ95lwbSdRVoSBJcO4wXsddJE7s69t/LbnrvqOLjXmOf5TvO+Ch5ffF3wFWphUsQLYKHS+DSsC0favYovwAn087Umwg+kpzCQ9K2b9wN5YuVhN0TKQ6lyJH3fr22gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc+vVasiXYsGdDc1U7ARHfSA/2y/8rjb1HJvvu35hXc=;
 b=bMzz/lWB65wxDWpVZu++21m4Uo5z/+tmbGUM14gRSGrcdXztiwoCQFOiUlnarZbYKPf+U3sPGNfaFF3Uud0eto+xkgPD1j/NMszS0Hvs0ipkdUtcwv/JCqNe8C7yiRtRHU+Ol3vT44orb7gMw88M+o3KariR/nj8kYgABP211njN/RYJ0RMDv4YEnAJqpRTeGzSW57pMqk3msNAPKk5XlU2+yma6BDZT+LxVG7xaHuGZdaIQ3WtF4czgGV2dVHpZR1FiRgnkozMIsKRMjoWjXya+f6d1uNapp1M5QqUhbQLp8TMng+5sc0+3VcOiFv4riGnt4xQXB4LZinje45PEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc+vVasiXYsGdDc1U7ARHfSA/2y/8rjb1HJvvu35hXc=;
 b=z08DD7jNbl+udsy+89HsKkQDzLLD4A+t4nNOJnCsu0u+nitY64bAN5+NZ6rX4LZn+Ca/F4hpIMmOPgQuznuJ9gQzFNQKAeC2/0GYU9PA9dH+xZHDqN46Cep42MZxuP+18DtGzedcpLEBXv5sfJVdvnskjPZVTN/KoxU49+2bEx8=
Received: from DM6PR02CA0086.namprd02.prod.outlook.com (2603:10b6:5:1f4::27)
 by SA0PR07MB7628.namprd07.prod.outlook.com (2603:10b6:806:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 28 Sep
 2020 12:33:32 +0000
Received: from DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a7) by DM6PR02CA0086.outlook.office365.com
 (2603:10b6:5:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT040.mail.protection.outlook.com (10.13.179.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCX030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:30 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXPQn019074;
        Mon, 28 Sep 2020 14:33:25 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXPIJ019073;
        Mon, 28 Sep 2020 14:33:25 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 3/8] usb: cdns3: Moves reusable code to separate module
Date:   Mon, 28 Sep 2020 14:27:36 +0200
Message-ID: <20200928122741.17884-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
References: <20200928122741.17884-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a42a4c-3b3d-4805-3642-08d863aab566
X-MS-TrafficTypeDiagnostic: SA0PR07MB7628:
X-Microsoft-Antispam-PRVS: <SA0PR07MB7628CF81A33A12B96F26B8F4DD350@SA0PR07MB7628.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y85CDU6K0ZBvuCo9CQ41Js4fP0YWmAnITJXptdOX+yTQECYfIFXyJpN8IfBuw1cFqlLm6HIj9PNOPqOEITsJzaVERD1AJUyqZCBi5VhIIjQ0vwYVpBfUW0PyotHifR9XWwbk3hG3D7qpb6EyDL6dAcDNf8x8cXOy1r9y4mQSOwMvuKh0LawwggygNuJOpmjUr6cfw2x/8vbdPq+Cxq5SsbusJEuyf5/ACGFIKTPZep0OzmoJGJQ2KwYj4QwTnJ53DiSRkDPHayCPqaCnFWQZTgQEUxBUZdtDdpQwdNC50fUzy9UguDCvkLXs7pbLgtzictOrHxFs4j9HdiEBLVGG0S/ThA9DwwMbPhCD/R5WGmF9+QTF6Zfmg1tYBkZJrbO6+wRUMdfzdFy0y9NjsN4TPuDKxDXvUY5rETGGyZ2N3+Ve7IP47VhaIDGcAv/pAi5iGjLjvmcgViN3pDyq3JMVhOLrGar62h43DOIjNW5+wX0=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36092001)(46966005)(110136005)(316002)(36906005)(4326008)(5660300002)(82740400003)(81166007)(47076004)(42186006)(8676002)(36756003)(478600001)(356005)(7416002)(8936002)(1076003)(26005)(186003)(2906002)(2616005)(426003)(6666004)(82310400003)(70206006)(70586007)(336012)(83380400001)(86362001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:31.0920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a42a4c-3b3d-4805-3642-08d863aab566
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7628
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves common reusable code used by cdns3 and cdnsp driver
to cdns-usb-common library. This library include core.c, drd.c
and host.c files.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Kconfig         |  8 ++++++++
 drivers/usb/cdns3/Makefile        |  8 +++++---
 drivers/usb/cdns3/core.c          | 10 ++++++++++
 drivers/usb/cdns3/core.h          |  8 ++++----
 drivers/usb/cdns3/drd.c           |  4 ++++
 drivers/usb/cdns3/drd.h           |  8 ++++----
 drivers/usb/cdns3/gadget-export.h |  2 +-
 drivers/usb/cdns3/gadget.c        |  1 +
 drivers/usb/cdns3/host.c          |  3 ++-
 9 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 84716d216ae5..58154c0a73ac 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -1,8 +1,15 @@
+config CDNS_USB_COMMON
+	tristate
+
+config CDNS_USB_HOST
+	bool
+
 config USB_CDNS3
 	tristate "Cadence USB3 Dual-Role Controller"
 	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
 	select USB_XHCI_PLATFORM if USB_XHCI_HCD
 	select USB_ROLE_SWITCH
+	select CDNS_USB_COMMON
 	help
 	  Say Y here if your system has a Cadence USB3 dual-role controller.
 	  It supports: dual-role switch, Host-only, and Peripheral-only.
@@ -25,6 +32,7 @@ config USB_CDNS3_GADGET
 config USB_CDNS3_HOST
 	bool "Cadence USB3 host controller"
 	depends on USB=y || USB=USB_CDNS3
+	select CDNS_USB_HOST
 	help
 	  Say Y here to enable host controller functionality of the
 	  Cadence driver.
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index a1fe9612053a..16df87abf3cf 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -2,17 +2,19 @@
 # define_trace.h needs to know how to find our header
 CFLAGS_trace.o				:= -I$(src)
 
-cdns3-y					:= cdns3-plat.o core.o drd.o
+cdns-usb-common-y			:= core.o drd.o
+cdns3-y					:= cdns3-plat.o
 
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
+obj-$(CONFIG_CDNS_USB_COMMON)		+= cdns-usb-common.o
+
+cdns-usb-common-$(CONFIG_CDNS_USB_HOST) += host.o
 cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
 
 ifneq ($(CONFIG_USB_CDNS3_GADGET),)
 cdns3-$(CONFIG_TRACING)			+= trace.o
 endif
 
-cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
-
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
 obj-$(CONFIG_USB_CDNS3_IMX)		+= cdns3-imx.o
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 079bd2abf65d..2c79fd5dbacb 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -431,6 +431,7 @@ int cdns3_init(struct cdns3 *cdns)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns3_init);
 
 /**
  * cdns3_remove - unbind drd driver and clean up
@@ -445,6 +446,7 @@ int cdns3_remove(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_remove);
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -463,6 +465,7 @@ int cdns3_suspend(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_suspend);
 
 int cdns3_resume(struct cdns3 *cdns)
 {
@@ -480,4 +483,11 @@ int cdns3_resume(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_resume);
 #endif
+
+MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
+MODULE_DESCRIPTION("Cadence USBSS and USBSSP DRD Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 284707c19620..f868c415d4e7 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -97,11 +97,11 @@ struct cdns3 {
 };
 
 int cdns3_hw_role_switch(struct cdns3 *cdns);
-int cdns3_init(struct cdns3 *cdns);
-int cdns3_remove(struct cdns3 *cdns);
+extern int cdns3_init(struct cdns3 *cdns);
+extern int cdns3_remove(struct cdns3 *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns3_resume(struct cdns3 *cdns);
-int cdns3_suspend(struct cdns3 *cdns);
+extern int cdns3_resume(struct cdns3 *cdns);
+extern int cdns3_suspend(struct cdns3 *cdns);
 #endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 2d78ad7e3e78..ee6c6ddb6a6f 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -159,6 +159,7 @@ int cdns3_drd_host_on(struct cdns3 *cdns)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_host_on);
 
 /**
  * cdns3_drd_host_off - stop host.
@@ -177,6 +178,7 @@ void cdns3_drd_host_off(struct cdns3 *cdns)
 				  !(val & OTGSTATE_HOST_STATE_MASK),
 				  1, 2000000);
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_host_off);
 
 /**
  * cdns3_drd_gadget_on - start gadget.
@@ -209,6 +211,7 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
 
 /**
  * cdns3_drd_gadget_off - stop gadget.
@@ -231,6 +234,7 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
 				  !(val & OTGSTATE_DEV_STATE_MASK),
 				  1, 2000000);
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
 
 /**
  * cdns3_init_otg_mode - initialize drd controller
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index b8379c36194b..b4e4c5330f06 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -207,9 +207,9 @@ int cdns3_get_vbus(struct cdns3 *cdns);
 int cdns3_drd_init(struct cdns3 *cdns);
 int cdns3_drd_exit(struct cdns3 *cdns);
 int cdns3_drd_update_mode(struct cdns3 *cdns);
-int cdns3_drd_gadget_on(struct cdns3 *cdns);
-void cdns3_drd_gadget_off(struct cdns3 *cdns);
-int cdns3_drd_host_on(struct cdns3 *cdns);
-void cdns3_drd_host_off(struct cdns3 *cdns);
+extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
+extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
+extern int cdns3_drd_host_on(struct cdns3 *cdns);
+extern void cdns3_drd_host_off(struct cdns3 *cdns);
 
 #endif /* __LINUX_CDNS3_DRD */
diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
index 577469eee961..03a78593a04a 100644
--- a/drivers/usb/cdns3/gadget-export.h
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_USB_CDNS3_GADGET
 
-int cdns3_gadget_init(struct cdns3 *cdns);
+extern int cdns3_gadget_init(struct cdns3 *cdns);
 void cdns3_gadget_exit(struct cdns3 *cdns);
 #else
 
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 02a69e20014b..132c7ed945d2 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -3227,3 +3227,4 @@ int cdns3_gadget_init(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_gadget_init);
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 36c63d9ecd37..d4b911e7fa49 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Cadence USBSS DRD Driver - host side
+ * Cadence USBSS and USBSSP DRD Driver - host side
  *
  * Copyright (C) 2018-2019 Cadence Design Systems.
  * Copyright (C) 2017-2018 NXP
@@ -73,3 +73,4 @@ int cdns3_host_init(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns_host_init);
-- 
2.17.1

