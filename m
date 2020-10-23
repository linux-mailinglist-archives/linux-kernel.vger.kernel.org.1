Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BE297021
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464412AbgJWNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:15:36 -0400
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:12513
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S464403AbgJWNPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7EAqFFW7tuXAXt/x0wH6v//7PFy6Rzr9HBCtDMimZlAjnLtAi6FHU/9txhAwXyQ0UOVVCns6XFSC/kZfF0qwTWMC0Nouw6imMcAb+jp6GBDvEXpWNR+SOQLMaGeBtYJzQ6Bvr2QnGoab8R0QvB8ZXm/QG7gMRMDMIIPYHwhYbGI+dQ7g2gsvYfTGc7pVvz8Kj7JyJHfX6kP+7hG4GpMtsr0oMIUxdGJyeT6A/AXhg3depKr8WY75LLrm2h++oJU5cFxuRnt5+bUGOxFLGIdAvBmLBZT68VrKK1wpUnoERS4IqNQ77nAJD7TEEVj/4nA6AVAGkT5X5aO+bbOCgxbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhNF3WIJOI+R7ojiHqcQnYQl9yTi13G+x0CW00x+reQ=;
 b=eA8QNxTYZzmrI9dGJaCHrCSQnQM0CSr+3kQbsFp+Sjsr7BD5KQmFni7sj4KSgE4MnOggKwg28ALtlmuajMSfbeILBAb23dq+X6GPcafACC/NIZ4N+hUMAt0yBPAyDCqXOUvKyMzq5sL6k98Cd2QTlw7JfKr348PDbzH2xe5XbPwoFcfhJsD9vRyHh8c202G7+1Dq6cmyndDGTAU8+wIxWjyOM/0rMyo5Ne4YKKsWLAm1JkJV5I6VE5OG5+wlS5namxLwPKpQowlS0jLa8QQHh2zCzqkWnvRnIAFrcnGfGlmt68QQlMz9OXsFaw7iz65PUoXWHgDalEkGuRTslUWGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhNF3WIJOI+R7ojiHqcQnYQl9yTi13G+x0CW00x+reQ=;
 b=W/LT8lhbXlh0fz1oNjX9s8eIAsAh3dKfMUfD92DoxmHd6tGDZrlsdCnWjlLTsAI1a8sjimWvmYCHky+0cTujNs1K8709BPHTCnLDTPMNLCdYMW80bV+0FA3JICo87xhs90/ZrqKH7UAhqo1ceL2NjSSUcPcuDwK1YJYfbAoDiOs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BYAPR12MB4726.namprd12.prod.outlook.com (2603:10b6:a03:98::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 13:15:30 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%5]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 13:15:29 +0000
From:   Sandeep Singh <Sandeep.Singh@amd.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanket.goswami@amd.com, Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com, Sandeep Singh <sandeep.singh@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>
Subject: [PATCH v2] usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC
Date:   Fri, 23 Oct 2020 18:45:03 +0530
Message-Id: <20201023131503.759671-1-Sandeep.Singh@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::24) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Fri, 23 Oct 2020 13:15:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4828ed8-f13c-4184-89e9-08d87755b6cd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB472686EEE2D52F836651910CE01A0@BYAPR12MB4726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5WR4LNaAfxNU0aofTFphZEjgN62aWIe8/Cxb8qcIOY2/K81v5UPh2RwKAVwjbjoaCaia/6VCie1EzgJ0QI3hh9+62bXGjdVGr+Jcq8U2Favc+c7T1jKHkJRd2ZhDOmM1erg8rUgS0qy0TST3QCIq/Iaz5t4lUUHQh2ACYX1XmRfBlAWNjqrCMC3+jcx9pozFG9klRR8AGZohDHRjtaTTlizD+mfcjVNTeQpbMcThZDlhDA+1wI5k4LhsSEiUKB059gQmtN90GuLHp9BME0eLtuRps3uYshtjd57r7sX7urYsrb6hCXhqIb7qkba6hbi6rLE2uxBFbLMcQqcL1FJMafrU5XhVG9o6mpu4wPwJoTczRS0e8ffUmtqcZvhJ0A7LvHbAEeDmeH9MKVX9s0cVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(478600001)(54906003)(8936002)(1076003)(6486002)(2616005)(956004)(83380400001)(2906002)(8676002)(6666004)(66946007)(4326008)(36756003)(186003)(16526019)(316002)(66556008)(66476007)(26005)(86362001)(52116002)(7696005)(6636002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iY6v9NDUzoiOXIbfbzdQxCagznOqAQ8V9fn10z5mm4uTkMc1oSUMyY1x3L/zmRaUlnk+chvInreyQbNYvYXKnVEXpx+KM50CbNxOaQKwASz49idcWSYIRf8dTxfQzRauCdu9g207IXqwOkLP1EaU0Dr9KtmYD8PHMhYnmXZGxl/9AYqvvrpFilE/AWUP8yGbjtASK0Gc1jO/nfWZQ0vPE7iXBbqM4q/dM1yjaYlwDasd/2PhDTK3L/wyux4Tu7B6CVj2XmuGyI9/RILN1cgbspmSUFzKl7qgJRP2rASQRDJLm/Y8laD6vvYFOZ2lRzFAx27SmCisoY7jW11yDCNSeCqLs7CgUk9W6AkqU31Fgm2BHrZ+H0UroJtIUHCFEtFOB17wexu9WIhJolU+DhgdL4UJdVLMA4Ws/iRIzVjzeNq2fkhV0GJIhpjV/6ixPp81kJvB4s1RWDGyNEEMGkPuDw+AUxtpaL39KRNn5GclOyFcLrrpJoqQOoRE36Q294eSTWlN3zfcJW6ulgM17Y3XXQYbj+pGxvOPTEBPm0iYvnN7LAvMDWEPtoxnAfgtxOnXAtI9ArbKZz4IK/wNNpA+rPWs3QxfTnEIY4pQ0aeMCVxVKaaoG7erMpLIlraSLc8Kh5djVjjnai/bk3ydox7A6Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4828ed8-f13c-4184-89e9-08d87755b6cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 13:15:29.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nJNcY/mFhFEAa5Rl29XBRuDEPwYQcSBnfHMQKI87DXw9y7zAUGaEKTrNxzOi17O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4726
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Singh <sandeep.singh@amd.com>

On some platform of AMD, S3 fails with HCE and SRE errors. To fix this,
need to disable a bit which is enable in sparse controller.

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
---
Changes since v1:(https://lkml.org/lkml/2020/10/23/368)
	-> Add xhci.h changes

 drivers/usb/host/xhci-pci.c | 17 +++++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 2 files changed, 18 insertions(+)

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
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8be88379c0fb..ebb359ebb261 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1877,6 +1877,7 @@ struct xhci_hcd {
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
 #define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
 #define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
+#define XHCI_DISABLE_SPARSE	BIT_ULL(38)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.25.1

