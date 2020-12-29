Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86D2E6FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 11:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2Kvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 05:51:50 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:56385
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbgL2Kvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 05:51:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFUnNm4eKDgTw4LZNESKqdtkoklm4dPygXSEiYtxU/H89k/RINkmwy18AapN8BpR7ZpBW0d1tWdDz10dSBy/QbmM6jf+Rau9owtz8S2vTbJMP0PVbLLPO5ukU3px0wywhHXMcikCnzLyxDwwDT2WAd3qNqhbPmJKHnY4qfWHCUuhniZJCPCrhCHZrlQeKv5sa9JrzdP6FyR78ZldskpCAb7jhU9qlHJ6nrN1u0FhoHmwUXqoahrzG1oy0jDmXvqWtz4ZZjDm8z/mYYMBut2hD4C/jYT6Urb7C/acSpRdK+cq4HPlt/r3nd/ePWJ7Yz4OLmk/QxLM/Y7bZvVEJdqSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjU5BmwXOze4RzKoNjECXt34IBYswkpNDNJCOrIzPGE=;
 b=H+8P848g5Z6uUNDqcGk3j5emMNzmK+nH+0AjukvFHEmCOp1NrpfLOAytd45tjvCHoRkg9K2+r2vXLnwJRCPYEe/idTczf4WuK6NyIKvnJnF/iS5qpohrC4uEweru6yiVoNqCg8J/ccUUtd159064YpvIGuAFn3CYnR4oLr1heh7JYM5NHEpYB4SLO2S9OtUeZUTekfSzCvPYWRRnHXC1dKJKg7URrUHBmjVuwVinNwvoDREmAOoaUI74UHJnmW2DMuq+3OyHfQKPCcpl0XOz6m/LwSIRf39agg/mcNTMbod19Pt4HSvI5o9IwkHYBlQck8zwbdoaHWU0UONxjkvh9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjU5BmwXOze4RzKoNjECXt34IBYswkpNDNJCOrIzPGE=;
 b=VlbDaH8q7+NBRRymTuW4Hb/Dc0W5Hz3tRMxoeR9tQ4g7fMAs2IKjkYxBrisnpCE85/uCYINh8dBJNSbAIdI/PSBK0dWR6CgaW0v6uBkyoWpvaDU1bQ1U0IyxynKbxBnEZVIYVncrgcF07XtRBiWwYcPqtuZw6tysQRNuj/JfubY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Tue, 29 Dec
 2020 10:51:03 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 10:51:03 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        david@lechnology.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] regmap: debugfs: Fix a memory leak when calling regmap_attach_dev
Date:   Tue, 29 Dec 2020 18:50:46 +0800
Message-Id: <20201229105046.41984-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:203:b0::31) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK0PR03CA0115.apcprd03.prod.outlook.com (2603:1096:203:b0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 10:51:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16013c9-99ed-45f2-1698-08d8abe7a344
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:
X-Microsoft-Antispam-PRVS: <PH0PR11MB51918139FB7FCA2A78B0B15A95D80@PH0PR11MB5191.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RieKCx+UjzAwM8bfvg87HNkBeemMMg120HnP61ogCOCtbp6jPjyNdSo3ryc+SgQ15Nf/qRVfZ2QA1DYFYVBsln+SxIS9H2Yf1pT7296iGV2gfkDUSlFzJ7aaoNtyYL5dS0UFekX3/3nLxHrNO0+ysv+5tIzozCSRPxwuPkTvB5Z07lYWhVTWnxxWQ46J17y842o98B6iIVft7s8uG2P9JPyRSqRJkfXYFwhHMc5Yupm3x1iXTFjeeCmbJ5o3YoEzXfTnv/36alTzTuqgN55vPa31CRnlKjR39TKDOZ7EOP7WbB5kP9Tfl15/uDM/4sbNwPmJsEinVFNYxaPKmI437ez7uz4mO3yQBprdIJMSnxXaxKQToXMTvEbQWsAugY2L+S+70TA+ueXqJrDGc5YCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(6512007)(36756003)(186003)(316002)(66556008)(6506007)(2906002)(66946007)(86362001)(1076003)(66476007)(5660300002)(4326008)(6666004)(44832011)(83380400001)(6486002)(16526019)(956004)(6916009)(8936002)(8676002)(478600001)(2616005)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ORJ4AsNxY0sCmDXMdE4gW7DKUfWw+oJ+tYrpMlGnEMko5cYA1+b0NXOvBnve?=
 =?us-ascii?Q?rpcfmaVvM84IEWzt7g87Zj538dXkoOO+CemzxH/Yfy3hd63XE8nVerrn+6uf?=
 =?us-ascii?Q?ICIJUbzmy3J09bBlI3bPyfQMKJl8xO37WOCIevvHZyiNP1Dmr4vC0lrTh8tq?=
 =?us-ascii?Q?VudQCMNjwvd3jrL/otCD8+Y1cHS10M15uasojTqdw8o0yTmOxADTbQeHuGHP?=
 =?us-ascii?Q?tG56Y1GfObMmr48tpxAE0OMhkqTFZ3ith8Gj9Su2HaNENKlYrxMEVkzoLGhM?=
 =?us-ascii?Q?pYvC2pjhkb3Sc+6umV4FCgyjRc1BiilaHbGFr2+ClBe6/VfBS+Xe/WY3GCJl?=
 =?us-ascii?Q?NtTWG5o1JdgrYtZoHxwVQYXssDwM8T88DiV6KTGDTs9P4k31zZooonP9e674?=
 =?us-ascii?Q?hsZ7JbVa3irM9SSWgTU41o1zpfpWNn3f2Lj8inN4XWvzC9DIWZZb6FwvJZmN?=
 =?us-ascii?Q?zhnsU8paEFegg4znKnpAODNi5BrKpogOhPFT+CtjuHrYEmiPfgF35yl7cYoy?=
 =?us-ascii?Q?zxW3nqaN1uoaaI83lKDk3AhVgyZxb2Z1oh/r4w8YS5Cpk7juADo+wLdqOFV2?=
 =?us-ascii?Q?r8B6CQLtjmhwK15j3cORllj2pOYfPk/6XuFAdkvNP/MTdxrLWJYHqolnJUW8?=
 =?us-ascii?Q?N/mLzfeO3rP6JzzUOz4LdS+o6XuN2Me1LkMQDyTcm4vCIcg6l1jQsct9S1Io?=
 =?us-ascii?Q?YaJExmPjkgOwYZb5yWk523tybkftZwYDg+W3knu6Un0y+KZcrJE5vOtaZnP7?=
 =?us-ascii?Q?XCnbUwYLLNy/42z1Xq9PwwStLJNkuf6LAwFsrT6R3NSytbl40qZMUcxfXF6Y?=
 =?us-ascii?Q?gcjn17KjH4XADcztLy1hFhqcLvJAOuwu282IFpUwtBfGpQO35D2x+wjgSBYf?=
 =?us-ascii?Q?rQw8VKyBjb4YzB4f2qaOJl1M5vxkWmesHlyzJw93D15nTVsX141UcUnmoYTO?=
 =?us-ascii?Q?narBHA1zDWcvgJaXj69ubuaTutEmwkvn13PjElpTi79/cyTXXNTIdrTKKoFW?=
 =?us-ascii?Q?AEFO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 10:51:03.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: f16013c9-99ed-45f2-1698-08d8abe7a344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnSIGTg3Ka1ndbuflpFubM1ujS4UTmzMtDu2o5BYhfUANA1MTkdYkJk8J8ok2HZBhQ3TsLLEfjOSWUn7vpKnMGbB6rldtGnbHnXsg15HTuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After initializing the regmap through
syscon_regmap_lookup_by_compatible, then regmap_attach_dev to the
device, because the debugfs_name has been allocated, there is no
need to redistribute it again

unreferenced object 0xd8399b80 (size 64):
  comm "swapper/0", pid 1, jiffies 4294937641 (age 278.590s)
  hex dump (first 32 bytes):
	64 75 6d 6d 79 2d 69 6f 6d 75 78 63 2d 67 70 72
dummy-iomuxc-gpr
	40 32 30 65 34 30 30 30 00 7f 52 5b d8 7e 42 69
@20e4000..R[.~Bi
  backtrace:
    [<ca384d6f>] kasprintf+0x2c/0x54
    [<6ad3bbc2>] regmap_debugfs_init+0xdc/0x2fc
    [<bc4181da>] __regmap_init+0xc38/0xd88
    [<1f7e0609>] of_syscon_register+0x168/0x294
    [<735e8766>] device_node_get_regmap+0x6c/0x98
    [<d96c8982>] imx6ul_init_machine+0x20/0x88
    [<0456565b>] customize_machine+0x1c/0x30
    [<d07393d8>] do_one_initcall+0x80/0x3ac
    [<7e584867>] kernel_init_freeable+0x170/0x1f0
    [<80074741>] kernel_init+0x8/0x120
    [<285d6f28>] ret_from_fork+0x14/0x20
    [<00000000>] 0x0

Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/base/regmap/regmap-debugfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 8dfac7f3ed7a..bf03cd343be2 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -582,18 +582,25 @@ void regmap_debugfs_init(struct regmap *map)
 		devname = dev_name(map->dev);
 
 	if (name) {
-		map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
+		if (!map->debugfs_name) {
+			map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
 					      devname, name);
+			if (!map->debugfs_name)
+				return;
+		}
 		name = map->debugfs_name;
 	} else {
 		name = devname;
 	}
 
 	if (!strcmp(name, "dummy")) {
-		kfree(map->debugfs_name);
+		if (!map->debugfs_name)
+			kfree(map->debugfs_name);
 
 		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
 						dummy_index);
+		if (!map->debugfs_name)
+				return;
 		name = map->debugfs_name;
 		dummy_index++;
 	}
-- 
2.25.1

