Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4F2E3390
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL1CH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:07:57 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:51565
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgL1CH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:07:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExQbP2jCU1kxzs2BdaH90+ItsfOnvYmFwzH2Pgut1o0AZMRTF51AsdhNFcS4+oZk4c9fnPFATqi8FE4RqYUilSQ7Ql5f2MWrBZxu0f1up9TH1j0P/H0JJ9bDWm7XTaef1xjfG4BcCYleF/L1rO0DfwXvwm4WCNqYoKtpQYB5pgmyvUyBb9hSEEuBExuO1oyKDuXa8QNSj9QGyLJCEPyFPINKhH3hk2l64Q0mWllMvmfrDZYdvMcelEot43NRh9IEDWmQu611v3GmeS8NNyDn2U99EwCrTjw93t7dod9aZLlj/zmZN3v7tyVNeYmyvckXzOIR4BtM354cQh0fmuUeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJUoXYAY9isxK3RLEunZ9ok+Hhs3TNU466+XqBXr260=;
 b=ayVUwjTVPWIPyGxfjCUPH0zFZ05VY+i0QXY8QLPazb0pau+UYkQIK4VfvoMoVeIL53WBk0TK3j4p71bUedQ9ZDr0Vdawt3I1SdjIS1kpUaTLOeTw+r62PtP62tsvogdsVGZH1fv4NWzNdg4N2a/KdJULu6iVRvRxbJnTG/YYMUmY81lU2dVyNUhSIKnkmUz1dqKGyuI0wPkPBVNR2MC44REwUfuObvuoQK72ANv34hB8ayK/UZ/3VMS7Z6ggNfylNlO/2di2F4YKODi7kVUA9qtw8L+Dc5KDIQ/iqS/+V+JMMAmWHN+NpBX1xfsjHBnqgTgCmY+RK0tEC95z3NemSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJUoXYAY9isxK3RLEunZ9ok+Hhs3TNU466+XqBXr260=;
 b=idSTNuGQGu73zsf5G7DtdVvP3S7XRWw9u3WY8UJrMWWiqZdfSvfFxhq8NmwEo46vT5TSZbYHjOs1TiCiVC9Jkf2/Z16vT6WJ41nbksXx34EpF2vVFuttBpfibO2jxzwT3c1PJ940UCUOQM0C7O+MP4xFqMNn90bmGO9aFj77K/I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BYAPR11MB3846.namprd11.prod.outlook.com (2603:10b6:a03:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 02:06:42 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 02:06:41 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     lee.jones@linaro.org, arnd@arndb.de, Kexin.Hao@windriver.com,
        meng.li@windriver.com
Subject: [PATCH] Revert "mfd: syscon: Don't free allocated name for regmap_config"
Date:   Mon, 28 Dec 2020 10:06:24 +0800
Message-Id: <20201228020624.4821-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:203:c9::14) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HKAPR03CA0027.apcprd03.prod.outlook.com (2603:1096:203:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 02:06:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eeefe63-2c1a-4573-d98a-08d8aad53820
X-MS-TrafficTypeDiagnostic: BYAPR11MB3846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB38468BD78D5928CD86A4B90CF1D90@BYAPR11MB3846.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfGILhmSgfIzJlxcFd+zXVaJ/TCyXn/Ibpovjy0kXK5IAqjYcQylrxlWRzbo6oIb2bc56DkscsiEyxw9/T0eHdnj8SfaJfxI0Zl/GPSt4hERkrcnhIzc/jzXf5MeljDU7pz92PexxfiJckKgfrxT/LDKdO82PyRtD0WAVt+krmVdsnUYravSN0qhnX/fO3bOgGbbqHfT1qlsAfDXuKI0ccxL0nhGttVMCpKUpDuF+aVEzDnDuVZf2w8YZHvV8FZHbhqFSq4gQDb2WnjcibdD2sJRw2kyx3ccZMDbbn9aLJSpQAwCQ3o4HArY4GXcIRNOWTkcKSXyuqxzmyan/VglhhGH29hgXqXPuXFmOkFmeBquKZb9GgUmrWgRInHp7Zu/xSxwY73CPP7RLDKxVeLHMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39840400004)(396003)(66946007)(66556008)(107886003)(66476007)(2906002)(5660300002)(36756003)(1076003)(8676002)(83380400001)(52116002)(86362001)(16526019)(9686003)(8936002)(6916009)(2616005)(6486002)(956004)(186003)(316002)(6506007)(6666004)(478600001)(26005)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bP4VSkYZfgb7kgIEuTE6qBdxTqV7o9Ym+2GVD9E9K2z9N4BOzGuAVTz8XUHk?=
 =?us-ascii?Q?a/CTYKmv8AGNFHb3WPVTYB9MuZGwPiZ/Z+er9FIvU/IBJHn9Fpff/ThiTIpe?=
 =?us-ascii?Q?/+EiLJgYbW3yi02ZVWbOpi1o6F9OuZcT3+CSn4b8NNnu8PRnlAS1vxIZX4hm?=
 =?us-ascii?Q?RkyL5KppceGIVtTF6jw8n8wCRmOFaZriZD9A6ORDqSx/xlYnvjp/8pDk6DJZ?=
 =?us-ascii?Q?zgo7dio9jtwWQC/KX8NXGP3qsephemPVnHrk+ZiZgtY+2XWe2LFfmQYQOjq7?=
 =?us-ascii?Q?rXJa0pkSzaQN8C6yDhe8+TmCq1xYTnsd4zivUsK2MOAk24nfec1WBs4QUzuC?=
 =?us-ascii?Q?hquzcHmu81x7Q1xYzVuP6DGwvcVWuv0X5oMk1dy6npT+11Lz8JeN8bcRWDRU?=
 =?us-ascii?Q?RJAaL+nZT9Rz0zuaTK+EQsucgAa3ZD92fP9/2DUhtqSQSObN8c5ets+z62Kc?=
 =?us-ascii?Q?RUgSsCP/xE376tPSQU7octrKIv/RUG+8o+mZxq7ZLJShslrM/q+rt3G4tT3/?=
 =?us-ascii?Q?BqkDfEwnI3d+zAoCDdh55sqjAovabZRoI8Cpqm3OWQUeM7Dy54jtHPFVaXH5?=
 =?us-ascii?Q?H0GQae9N4vT6cILAthOxavhQx9vo5GGuhN9jNew7KD25o2zzazbpfsSSoOvL?=
 =?us-ascii?Q?Bd5C8iaBgoJPI91hIy6ui4LnOvPYtH1DndyZwDl7534X5b1+IBzk3r+Kh1c/?=
 =?us-ascii?Q?Juxt8trUq2cDD+90lcxuKns4KSa1Kc+Cub++cnwpOmtiw3MX0UIFrc0bnE+G?=
 =?us-ascii?Q?mUSLs+Fhnq/6pr6eYn1T4VJEVDJOfdj1tVUn5/n/S3nvYWNc9Vl7XnnedYgQ?=
 =?us-ascii?Q?1eB/MCNZLHS2ZItB5G7lm5NmC3Wzhd2K9PBiHB2JzRsJOnF38mgpVqnSLH1Z?=
 =?us-ascii?Q?AguDBeYFW3cuhiSSf9FjRJc810/sLaVdiHCs6KQjgVNHZ4zucE7CgXLM+1aJ?=
 =?us-ascii?Q?V8+zGbwiTmy7uyrwRYFTy5KdY58kgV8O5vz15Lpltz8r1RmX5jPWLVDlUZXG?=
 =?us-ascii?Q?Okpa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 02:06:41.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeefe63-2c1a-4573-d98a-08d8aad53820
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD5DZ1d8CRTglm7snRQrwW9/q+BtO8aa3a5qvOMd55XmpVWrvV/dPKgubmvQI6i5prehCJMyAlFAfGl2K4gXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Limeng <Meng.Li@windriver.com>

This reverts commit 529a1101212a785c5df92c314b0e718287150c3b.

The reverted patch moves the memory free to error path, but introduce
a memory leak. There is another commit 94cc89eb8fa5("regmap: debugfs:
Fix handling of name string for debugfs init delays") fixing this
debugfs init issue from root cause. With this fixing, the name field
in struct regmap_debugfs_node is removed. When initialize debugfs
for syscon driver, the name field of struct regmap_config is not
used anymore. So, revert this patch directly to avoid memory leak.

Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca465794ea9c..df5cebb372a5 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	kfree(syscon_config.name);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
@@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
-	kfree(syscon_config.name);
 err_map:
 	kfree(syscon);
 	return ERR_PTR(ret);
-- 
2.17.1

