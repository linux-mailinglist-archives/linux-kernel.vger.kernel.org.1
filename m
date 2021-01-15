Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1439D2F703B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbhAOBwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:52:00 -0500
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:60001
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731602AbhAOBv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:51:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCuTTnmV48+3W9BcUI5C5sZyVIQYHPbg5pPktE9xVRuGBheLupZR6F9X8p+/McU34GqhSVbF/nEAEqu+fy8V7sINJthycJREEXRblwXqY++YAuNJImVXkLWnBAyw5XkvE/1RQY6bbinV8SqHTsefLIVKWMcJRmpmrMPgQqMvP/u9TCVZungc8dBS4s321UTtQkHt4U9gwO9rgRwNWz8SIG34RCpA2zhND4d05Aqvn5N60YcYEqKgGLrEET+2fHFP18IWremgxr+10LKjANuQ+IswfUxmnS42QkDO0oGWyWNOaIlZwzXJhAAlpQfDV+IAN3jv4edJPY1U0zcIffbi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZq3BFPqy7tsxIdHNZ75A6IwzSF2HMgoWjUP7WB7opY=;
 b=ONYqiSWlBpi/nJZJVOs/wgCUoFAQpfX4qJfaCmnzJfWOuKF4zx5HA6DMdczmjE5pSgV8ouy4pG6O4BM56GXpwdwPIJ5BX5ijNOSL4ng4RNu7JpHyYYJ36ULN6x6MwmNizm33eGtLNPAFk3Fh+yWcO+jhJa6U28BIb5OJmQgQqfqTIMxgWkU07OFIdtgKKQuiolPaYbKKpW42CCXBY+FxowzDKvMspPdzf55sQB3k3sCY4ndxrLKadI31v9b/lCV3BCdyvKkv2fIHePBGYC3hiFX2pGvM7bX7pkB74wdCZKiRq44J+0oLcLpIiF2GKnTJCpN9Vz/T1CVpIkH2TyDRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZq3BFPqy7tsxIdHNZ75A6IwzSF2HMgoWjUP7WB7opY=;
 b=qH32bGZAf6tLvbUv5N+cfgYvG4MSrt8rf91kThWz0ee1fni3ODWqT3dmSwpS7a5qBYufApnOqhoCqMpzLDktnCqzOEVLf0oNwkmtoFDlQVfsqNtmHiExH4WG6ouVgf+ZnEarwt+Za7aJbPdAntOS7GSNatOegdhJOMkeh2Cq6eM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by BYAPR11MB2741.namprd11.prod.outlook.com (2603:10b6:a02:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Fri, 15 Jan
 2021 01:51:10 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::4934:bf21:e093:8c3e%6]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 01:51:10 +0000
From:   meng.li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        Kexin.Hao@windriver.com, meng.li@windriver.com
Subject: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for regmap_config"
Date:   Fri, 15 Jan 2021 09:50:50 +0800
Message-Id: <20210115015050.26657-1-meng.li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp4.wrs.com (60.247.85.82) by HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Fri, 15 Jan 2021 01:51:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121f9d6f-56fe-481a-f27f-08d8b8f80839
X-MS-TrafficTypeDiagnostic: BYAPR11MB2741:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB27410EFF541AFA32A135BBC9F1A70@BYAPR11MB2741.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: polIExD5dmxMRNk/B3mDmBLeKQ9++DcOamceWqIIilPr1LejoUQ7hARPXdZHh/p4iLTjfqWPInyBCYYmJjmoowyksVc0fSLDKKysWQ5Hf7vzdgOZNykY6YKB8g3WHmU7FNB3NO9JDf8SalsqLHpjbp2ZztVrkd3dHks9/5NP84kqcOGCicniiBJ02AAV0G3jwjSSuuSv8MScOqFzjfF5kaPT+G8PWrSou0OdFk3ccemJ72vA1vlFmn4y58f4R8q5ryN7CvubUAUIS3YXBJdrcyCziOOtvy+uRaFIaPcZzXypxTe6eiS0nW6JG7C5zSzIslYfmTfde3nhFPjo5qdrvIaWT749qSrIK30lbXn90swob6GPCA1z93fjpwFd06SXZPsyf71r5a2geWTBY3o1jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(366004)(346002)(478600001)(36756003)(66476007)(956004)(66556008)(6512007)(16526019)(8936002)(186003)(316002)(6486002)(2906002)(6916009)(107886003)(83380400001)(4326008)(86362001)(8676002)(6666004)(1076003)(66946007)(26005)(2616005)(6506007)(52116002)(9686003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QeU/zO1f3Di4Uod/e1t0O3AkhhEygz+8+NdpSC43F/uM9WJlzUtK6xMOVDVq?=
 =?us-ascii?Q?WNso2vgrxXRQJ9JtTdH5LJ1YAYubuJA8IHfkTtkwGySF9BmgwPMBZRuEbtOu?=
 =?us-ascii?Q?B2tJuOofuHCxFTdplQ8eMC8FEWdUc90s++LYIGYYh6ODten+i/KEBzZYrhVi?=
 =?us-ascii?Q?XtKvSquiIKXOq81liZnnomN0tWGM84iu1FUqy99WydlsGBsY283uWWnCjTAX?=
 =?us-ascii?Q?vJ2TaMCEK3OqkDVELis/gpaWlk83I/le/BqeMXic8XeHu3ceiwtG0JEr5CoF?=
 =?us-ascii?Q?fnwewunULvHz8lAJ34O2rH10LHqgRi+Hy04mzjHfH+PON94GCG8SY12/CZ1J?=
 =?us-ascii?Q?si2hozhMhiEy8d9rnv1M7H4Leu+FultXXg9nA06QHbuU1oiHtQiK+lMHua8q?=
 =?us-ascii?Q?6gXOT3ULmBaSY31kc23G9vGsTd9ctuBJAkJr/fw5XnSjrI7HDCPoa96uLs14?=
 =?us-ascii?Q?FvE0QAlcBv3f75Xtq6uHTxCM8fjcKO3PkTev8oehQmW/jjvxVJ7nBksqDjJ3?=
 =?us-ascii?Q?IDBhqW9f4Q6IXRMzV/THBg54QumtKl8IoYUajGBMhD3HRCFn5nvZkXvU5GGU?=
 =?us-ascii?Q?Un0Fk0D3pr8Ym54NV331SvOcRoKgr+EaK+VnQw+03UQx723lFaM6IiTN45Ad?=
 =?us-ascii?Q?Uh0zm/rOlXN304uK4y1Ti4IcEvkI6mz03P/mAAZVDrQzwfnWt5Axj5oXPo16?=
 =?us-ascii?Q?DoR84V10Hw2GP7SJM+LtwyoWPguTydNi3xTcY1gP8BctKqotHpJ7gu7vZmSz?=
 =?us-ascii?Q?88uIwCZ4heIpXi3iaYUP7jt/xMuOJ8lvqft5Lgoeo+gsLRezB4bSMV2lXTRN?=
 =?us-ascii?Q?duupB5Yk5b5gnZZl3FmwRrcWuQbK1m/vhWDhJb1qz9RZFbNuvDqlH+NYlBdi?=
 =?us-ascii?Q?uLXb9b7x8TiW64hLNlxczslzhfnSSNMVUl5p4SqhHgXFG1eN/TKc2mB5tIQO?=
 =?us-ascii?Q?ofk03uetUf6yMOd7F4ViafKqOVr+5zpbF4V4GmSLM+YDV1Ep9LG2ZXhuoWFY?=
 =?us-ascii?Q?8cO4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 01:51:10.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 121f9d6f-56fe-481a-f27f-08d8b8f80839
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CbJNm1DYTp/AeJd7f2bLSUv5uTr/MtC6JOS8XZ0KOhFRsAkGG3l1Hj7c6oh1a2/ERHAOblSWvWntR9t6/8SAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2741
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

v2:
Notify the author of the reverted commit by adding Cc:

Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
Cc: Marc Zyngier <maz@kernel.org>
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

