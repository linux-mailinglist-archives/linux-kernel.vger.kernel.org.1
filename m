Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423B28518E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJFSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:24:55 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:60805
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726760AbgJFSYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYG72qoLlVuSTzPjD4yy1dso5Ol63VRqi6nfscthCcnACQLmCMhs2c36brna5JNXtUnc9OfTlW6JvmmZ9g3rXqqeOtY1UwxY1Sy5WhCZuH8B0e5oHQT+hJOumiHsZa8/hcKdnuJ8fcp9xcwBYD7m7bnd/nDAbb83oH5ZwFgiAH63zmwtQgTENSJ2B0Tx0A390dO/GzpAYvCkxbQ5cQI9AsohTu0OWI2YpN063icyoIMmnRiwib26VCzUUT+ZCxxCcc5XhChJOglgtgzid25mor4/BcHPXkwLGsBr6py69EkndoeiplpDOvmI+WqIlpvC030a9fEMAIqaLGilXXnPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL78pO+HrAwrAzd0TjW64oSIZDto6DF7/RfGsTsOmHM=;
 b=A1Ojq2+r7SGjcvS0No+PNQFQjK0kn0i14sg/ova05TbxE+sRuk1RAWfGnkdaxJ+t3Sz0NOmBpopVNqPxzdM2i9QnXHMhuT6qoUb7jlXu86zwR8TZEokoWLR4nC1wlg7ENwEZQuxxPAxcDzzDYg9r6KXj9dhRdGuZzIEdT4b5BjyBqUvfsdcQ3Y4KQiBvzSfBp5m77Hpqz+Ksx++icyqWMdLzXcBw3xIFoDrQbqxiJRe2T+/FhC4ugn06XNIhxuIp7aoQ7Tb/hQ5Yhxd2H5273iGjBzCmcJ0GXuMCLQDm2X+UejRt9ThiwA2kW7RS/moY+ydWqgsXzGOtvxX0n6Y6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL78pO+HrAwrAzd0TjW64oSIZDto6DF7/RfGsTsOmHM=;
 b=D7NlbQ2iv9HUdGx4CN/IDuPy+um/byThYGEE+uywXordNt3RI9Bm8Er+VZnmbXe8fSu8pRuRH86XOmv4FFl6PAwTG2tB8A0usylznvDCcQUzr33Gqa6nE71wBJ1ilJ9OHuB64h5fWMgF5IfjSpLuhii3Ovzy/aYsdscEtr5YnmY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 by BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 6 Oct
 2020 18:24:52 +0000
Received: from BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7]) by BN8PR12MB3540.namprd12.prod.outlook.com
 ([fe80::9d06:595:4be5:3af7%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 18:24:52 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     bhelgaas@google.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com
Cc:     linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] PCI: pciehp: Add check for DL_ACTIVE bit in pciehp_check_link_status()
Date:   Tue,  6 Oct 2020 13:24:28 -0500
Message-Id: <1602008668-43646-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::18) To BN8PR12MB3540.namprd12.prod.outlook.com
 (2603:10b6:408:6c::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sanjuamdntb1.amd.com (165.204.156.251) by MAXPR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.35 via Frontend Transport; Tue, 6 Oct 2020 18:24:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c740720b-dad2-434e-edcd-08d86a251ddd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00174456640C69B8E61E911AE50D0@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMOKSaeOLhDjCqFn/2khwLo87bl+Uu3ciIN/nX1PXhP2LRSXWNQAbI1XG8ATBVb9VzffRgmQ/VGeIpqkB9ajcPRwZT6bXQo5Op7vNPZ3EXLOUUPZNK8DPKFXiUir86ZtZDoKTNY1FY7Tn5MHMV7nI37f2FUt6aaJzO4bOLBmtR3OV9WXGWKCGga5F1/jCCe7e0hsqJcj1IFwchIMkHRULiE8AYIk5DjFKdLTkemokdfThoTJhuYg33MqV1UsvnvRZFSdVuZfs9oTgyR2XQA14QfYRkqktG7IobV+qwuoa/NpLGkwnZPLLfoxhsENL7QQNUV5o4cP27DQTl7iTZCoTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3540.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(6666004)(4326008)(7696005)(52116002)(2906002)(16526019)(26005)(5660300002)(186003)(66556008)(36756003)(66476007)(66946007)(956004)(2616005)(86362001)(6486002)(8936002)(316002)(8676002)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YjDn28wGrvI5weFTIFgYJTWIRIQJ9EIrBzGfZiNTvEVtrLF/YA5VUv84tL8sRyKkiGJhCBFSD1r+W4DIQjNUdVA2rYJ1ihhHNpuPHkIQF7YIl+AoTfQPpajgMUXKVVAX7G1vncqIxW8ZQQFCnmkEN57SC/YdlVuW6aqIYsUGMLwhx5dEOfqg8gCMQO5bF9/dQkJs++6yd0IoVniji3kdVCOMj33Y0QnaRihwyV+/+y/oJqRgDyL+Ek1zlj1JPkm2OTxuPFejrDIU1/HtHINBToNUG/YlOo4+2cg56dZkmITFqTyFg8cbpF9bkYCqjo0vmU9qMva7YX6Fo/jigH033q/NlgsPJlaobwLNKygGTICwgo0smEVS94yo3+kmnkdoX/UV1FVzBopMxreIfDmuAy3qPeU8lvF2i2ovpGOv2DWBmKZnOfhaA325/xwn7YAaD5Uo29PyT5kA4z6aCspOMKk9I+gewLLfgPkGA2zbPMw6n1W6bkMflMza3AuwJnyL1rHetr6fkxKBKDIDRARFYOoAgvh0am3MCKvlSQPsDUirXemMLYzzl51WclOwytWQQq0v/YlooqDWZKdAFkd/4pCsnPA7zzH5uqScZu0fUIDxOXeCGsAof72b3xdlVga0Pj0D+piM7jDS1IDPKQd5Jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c740720b-dad2-434e-edcd-08d86a251ddd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3540.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 18:24:52.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BCLflugAQuJ8TwztiiFOSapBG211jY4XmBdUPv3i928J5jUR876ctarTv2uhGkryH2iffK9Wavzsw9RGILUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
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
index 53433b3..81d1348 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
+	if (((lnk_status & PCI_EXP_LNKSTA_LT) &
+	     !(lnk_status & PCI_EXP_DPC_CAP_DL_ACTIVE)) ||
 	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
 		ctrl_err(ctrl, "link training error: status %#06x\n",
 			 lnk_status);
-- 
2.7.4

