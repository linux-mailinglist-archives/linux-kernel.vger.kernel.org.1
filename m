Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51790292DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgJSSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:46:44 -0400
Received: from mail-eopbgr750048.outbound.protection.outlook.com ([40.107.75.48]:29827
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727681AbgJSSqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WazvUZJv2kMLo8zPh6tnBnqVnE/CHgCHk8tbbwkT/Ymfv1L3zPjMOIfXC6W7EDHhCQ4DAmaHS23j8r4MFhyw4KLamJqmDf/Le9CaGo6+ryU5RR/msZiYPgiSi1effSQLuhw0XUZpPLLGHcCqOjOsLD/dzEwwNuLWUdqBRApmjIyK0lmcAvxxi/NK2BBatuM5UxbVsrILcBHxM8XmTqfjaMagRuYa/fH1HZFW8ftDqI0iv073DtW4ANJdrH6C1YJ5YkeF2BeObtPxdzqNgxZH0laNicc4UUgWLSIgO/r6bJ4//9RtPFfBCwWGiViAwyMZGcD+U8VxSWDozFuAq0QPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR6mOpfNm4sudNbSWzLUuMhOPLghlndk5QpCLvl6fVk=;
 b=SWz5ZD1wLZfZPoWVyhFGdKrYr8wDPfBjJ8Rf7tpd9Q1dES3cnw08K/FOzH6fPOoeDPxOMDPQGKWXk5qzhgDK1P6/Vc/CnGMzzvXbQu0q0o3DPQbGPY1ftRkStERT62Q315NFtLekn+9J8tmeRYuMztfJH84/G3RLBrjQ7MFsgtvi+fQqtjDyZE4Hewc89odPDEQPaV5Pttk7D9igBfnZ+VscwhZfFQaVSI+AjfCCjpVd8nCzPgmWQBmoJfOgszJkhRBwZznGllwNgFwAzWQ30loeYDfCaxEoz1wPTrpKH5fWzwZ/BAOL5q8O4qdgrISqgy9dV2O2msrtz3KSDp3RTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR6mOpfNm4sudNbSWzLUuMhOPLghlndk5QpCLvl6fVk=;
 b=Fm5vAyAeZlT8FT3AjF41ORkUpgFJD108CBP6t1LQNLf+mVp/On6U2kcvelWwmd6NGwulZyogVgMxqQ+cnnPTewlSEGZFRYYy1YoZWoXX7icWGdt7eocSm9T90v9XBVZWGFWl/90Gy24qLvA7hI3vhjgVMQ6zEXMcCmsP2hcR7OY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17)
 by BYAPR12MB3173.namprd12.prod.outlook.com (2603:10b6:a03:13d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Mon, 19 Oct
 2020 18:46:40 +0000
Received: from BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31]) by BY5PR12MB3956.namprd12.prod.outlook.com
 ([fe80::9c0d:9f7b:9600:9c31%5]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 18:46:39 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     bhelgaas@google.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com
Cc:     linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2] pciehp: Add check for DL_ACTIVE bit in pciehp_check_link_status()
Date:   Mon, 19 Oct 2020 13:46:11 -0500
Message-Id: <1603133171-87982-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::31) To BY5PR12MB3956.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb2.amd.com (165.204.156.251) by MA1PR0101CA0021.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 18:46:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34c5ae62-9a46-4848-db5a-08d8745f5052
X-MS-TrafficTypeDiagnostic: BYAPR12MB3173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB317380E631BD2086801CB198E51E0@BYAPR12MB3173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14r0IJcHBlIZ107oVEuSuSE2XgJog5uD91fMBphPtShLC4XweQm0Xj25wdUJ6XK851eUiY/cDW8DaTQTWff8/UELIjC8jpWJzO4Ntzl7vB0QRpVuCBMLcbNjsMrjarIPLFIKaNj04tIdHxgZOQqlH8aMS64UlIXQcqVazKkFn0g28CW0YECh42nCUIXV1mgOSvuNYpwenCKymX8mmUeh0T0v3QkeBxDkSnMQNwltgY69dOIzuyT8MHU8Osn20g0ePYQiJpJIbQ2953JG7MpRMFZwUp6Km2gXifcPk+TmPOt8lXXc2S4syBXtBsvCwinWlTeZsOx9hqZa9fLqCgrj9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(4326008)(36756003)(2906002)(66946007)(66556008)(66476007)(478600001)(5660300002)(316002)(956004)(2616005)(16526019)(83380400001)(8676002)(86362001)(6666004)(186003)(26005)(6486002)(8936002)(7696005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UCYqkOYlxdxsdIlyDTa39fBUD6ugHOOIsLDAjpXsr1AQjVhUEgEYXbkGjwRm2zir2IFwE+UL5JVGnSEPn29is5SbmEwtiYK08BY7wl7tBF4eyXqJ09V4RLmyDgcrE8+BEwDw7fJE2NrMpz0JvuMwnUNVYC7zj7nSRBbuRexx0/k3CXt/XpFoxqsKyhCZ8sNsyCIx0aQhQJ6DWq1wHe6DhkU7M9QFSFOJASe9oPJ1iUfIet8G19B08S9qW5B7XH/tiJ9PCQbhh/RN720fEsVA4VOywKdWr85BS3RtDROC3J8XmxlwRhx8eSam5Z+McUROuBEC5UaKQ1IxM5b32Lhpl/FjtllH9/ksb/98NQfhurPiRxPFcaThxqK11IWa3iLdfruKiuq9S5d58gxKIlsc137oaEMjAGdcaEaHfANMFjxhhAk4EG2ZhP7e6zD2/FGl9E8zAILJAItDPnNIDvG2pViHuIIQGTONbvn8JYRK5UydRFgODZCmVWbNSJryVd9jUQ66ZfdJwTV45obXoGRwI+R0mtdam9nsxNtjcYb4KDHEjHWCf4empwsS6kb9kaaFBTynpOQ7N3LjL0uQ35ys3udh4tEWsezp428AcqPVHMxw4A6S/05/+g+Xxi38NwSG0rZ/2pBPNGaW2XmCVGA2jg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c5ae62-9a46-4848-db5a-08d8745f5052
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 18:46:39.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMLqO+VVU2oKSsMV1b0ITlWbcKLiyv1H6a4Z4kznTgWfjf96GI+FqY2m92Ol3CGpL5OJ9invTsxd1tG7a3nP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

if DL_ACTIVE bit is set it means that there is no need to check
PCI_EXP_LNKSTA_LT bit, as DL_ACTIVE would have set only if the link
is already trained. Hence adding a check which takes care of this
scenario.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..8ab2f6a2f388 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
+	if (((lnk_status & PCI_EXP_LNKSTA_LT) &&
+	     !(lnk_status & PCI_EXP_LNKSTA_DLLLA)) ||
 	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
 		ctrl_err(ctrl, "link training error: status %#06x\n",
 			 lnk_status);
-- 
2.25.1

