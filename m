Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6A296F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463703AbgJWM1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:27:49 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:11459
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S372336AbgJWM1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:27:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPneTnJYebWWRXjqeIUVZnjD0LSvGyYY0zp3eP5eclf6Ao/BjmctH+CewD3T2Ma1SatpFozc7vfn7S4UqsvK0XRfOHeJnw0mQAuunnf/RpWgGJFkGZFxeeQfbH2CxuXcX3snAj+YaqlLblcqIkjM7QZV0iez1MfJ4Cv0CnrvSsMGhtiNRrLdXNPKgYxG/ryJN0fCZVp++ZXhzzO9YeQJBBI51NxplKai+wWnKt4+NQ3r3/Mm7h5utFl8FE5/vkKW9IEC3zwVyGmDP9bzZ6KdA5Gno6NVAcTqB+xA14pWbGDsMWPgyTNL/aaF8dWQp8qaFr+N1Holt8fGKpbZ92vaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZDn5IfJqXwmoBFrgNHxnCn2pOvT3bFvgPHnEDNaGa4=;
 b=lDzU8mh59ygABJUiZIA/KEZL+2ZYzU+LgPvjW3v7vY+VZOt8g2/ySDuY0O6KEhDN0WQ3e9EzhdsP/0Y+sLNfcXQu2avJHMgka0FtaENrZIL+mbn0AHfR98yuIQwindE1nfLr6tD8/nuZe6KHozKI1LGlHI16xe0bqPzHiwJnPT8JHavYUDgvc9AiTAJsKshP3npPccMLvlepZq9F2zlJEO/tbc8uLNeuWWhZhaEuftl4/z3wfIV7nH7M4gU9ZH7i6aB7k7zem08sIV2U6BjyRDs5WZHyISAiv5k1ZJuMyY5RDQjU5B1lgMD6ADYotfWAbj0jVcmxrAumy3Okfafxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZDn5IfJqXwmoBFrgNHxnCn2pOvT3bFvgPHnEDNaGa4=;
 b=g4rlQkgZ42h2XJo/QTen4O02VpenbbI41ZcEpwmDrgYGERylECYboi0Eq4dhyM0dxAMz1DSPoBBj3qA9CICi4E47fX8TbletVUXAW7fcQD839f/A4VrQzuutORCGyg1VrQH+98d6B1Ep7+9ylr5rQKXT3k7XbJ/Gy1bITAmDB0Q=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 12:27:45 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%5]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 12:27:45 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanket.goswami@amd.com, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH] usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC
Date:   Fri, 23 Oct 2020 17:57:13 +0530
Message-Id: <20201023122713.460551-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::36) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR01CA0142.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 12:27:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23a13bd4-d53e-4f74-37b6-08d8774f0b54
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35900EDBF8E12B25F8880413E01A0@BYAPR12MB3590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaB9quBJnIsVIDQ0WO+QkRlCKHfoHJ8nfPmaHXY242EN/hHMxvmWDaH+syb5vYbFm8Vapx2FRsstnb9don6Rh+jrc8xHyjfVid1edGFCcEwJzqhL4QrX119aDujZg7bpzjUY5KuscR7ZRLju5xxT+dqctpG8MsUquFnAgbUbY+tNZ4DdrV2zXLKqWmWGLIMzScGV4L0dbxiwiYc5R7X3WrCum7WspeVMqg1vqTnTcOLluQe6ovFZe9Gx8wqUmf9M9NSTneMw+G6HrrHlVoMTFKYq5NxSCwOZNBhYaHCzpGosSh7vqdc0sNmkpJ7py8GFYpudahSCBCBkLWp3xgZ9Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(8936002)(186003)(316002)(86362001)(6486002)(26005)(2616005)(956004)(36756003)(2906002)(16526019)(6636002)(54906003)(8676002)(1076003)(83380400001)(66946007)(478600001)(66476007)(6666004)(7696005)(52116002)(66556008)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /lN3MdIgtoDY/DNECoFNxgvzjH1oTbwJ7IALJGGhGXilK7SwQ2xCTRvnY+bBRLNDu8eZv/az9xDTp9sv0uJ22wHyHbCRKcbr3PBfzuy0Zu6dW1YvyO0j/5+5QZmvZNRzMX9iCYkJwjqY8/woy8tj/OBRKZzdHFhdKOV6XrKo4KYi0CeH/ZtZCWxSHtdU9SbDT26t3zpxnRoejWJBt7Gtyjvtv/boLHw7UE7uJfGiF703HYxkawaXBqUrKqmiG8VRxRiEJ2gXBvQXDILNi+xbtE2pUWceWhc39KQUvVE8Wq6NCimkTHJPr0RTSL98ThT7ztV0q/ofJLycYYB++mUnHIhfU4D+JFtvoZczNfJDQDMF7ZjVy400XUlJ5sUh60JSXBEsthaw2J+klepHJIOT4JhDIF51+AluqGHDAk5xJDGiIJP13T3hUmqjNqxtTFKC/JdR+Z/4yThAxDTkWzombD6DwjkevF2mJKxSd5uzx0M9oDSl2Fsy72nDYzd+XaAXA17Z0g96qDhpRKHYeEVBZTxmS1nM9L8GQhUVgbZQ4x0bMHujCFhSZJ0NWBsrZ5qmEbhaloISn6z0k5NGq0jVS4EQC+io2gFfUgdAL8GhB/j0GOqXcahiF8ZfstsnlZiqegEix5d/TEqWFh95GNC/GA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a13bd4-d53e-4f74-37b6-08d8774f0b54
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 12:27:45.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GxlKI2QzI4tMjaq5HpVc0CpLTwrXsK6nI9fAeQ/dFGBcAFnu/1IUPJeyCvk3YK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

On some platform of AMD, S3 fails with HCE and SRE errors. To fix this,
need to disable a bit which is enable in sparse controller.

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
 drivers/usb/host/xhci-pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index c26c06e5c88c..bf89172c43ca 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -23,6 +23,8 @@
 #define SSIC_PORT_CFG2_OFFSET	0x30
 #define PROG_DONE		(1 << 30)
 #define SSIC_PORT_UNUSED	(1 << 31)
+#define SPARSE_DISABLE_BIT	17
+#define SPARSE_CNTL_ENABLE	0xC12C
 
 /* Device for a quirk */
 #define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
@@ -161,6 +163,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
 		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5)
+		xhci->quirks |= XHCI_DISABLE_SPARSE;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
@@ -498,6 +503,15 @@ static void xhci_pme_quirk(struct usb_hcd *hcd)
 	readl(reg);
 }
 
+static void xhci_sparse_control_quirk(struct usb_hcd *hcd)
+{
+	u32 reg;
+
+	reg = readl(hcd->regs + SPARSE_CNTL_ENABLE);
+	reg &= ~BIT(SPARSE_DISABLE_BIT);
+	writel(reg, hcd->regs + SPARSE_CNTL_ENABLE);
+}
+
 static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -517,6 +531,9 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	if (xhci->quirks & XHCI_SSIC_PORT_UNUSED)
 		xhci_ssic_port_unused_quirk(hcd, true);
 
+	if (xhci->quirks & XHCI_DISABLE_SPARSE)
+		xhci_sparse_control_quirk(hcd);
+
 	ret = xhci_suspend(xhci, do_wakeup);
 	if (ret && (xhci->quirks & XHCI_SSIC_PORT_UNUSED))
 		xhci_ssic_port_unused_quirk(hcd, false);
-- 
2.25.1

