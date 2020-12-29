Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208992E6CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 02:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgL2BRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 20:17:48 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:17374
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbgL2BRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 20:17:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0k86/akjpIGudCFC1kh6LxG51RpsfCEVvGRBDg2awErlaI81bQ0Wi2pmyLEJfCDQuzOVBz+O/MBaKa1rKYVNRaoVqt/eCSMadCL9i2pqK5Wx6PgrA1ZR65KHDzNhu9jz+UWwZ4n4WY17hWBeZKgb01WOhZjIKvO1h65qdY3Ut4vpX6rvvYUyzDeJS0HR6MaMvU2YaoVhbAhJpxLeHwmD3r22iy+aFT0X50lu+njDFfGhCff3JH+UqWH6RWSzJ6JuSCnzrrhmW8TOHz7Qmprt1FqPjQzLK4mVLTKDZLHgmcMC3FKKYjfcbde+N5Kyj/dCdbNscV7zgNb/qlsMLotmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgpzCMUwwCOaK01z61+JK4feMYO3TBRVPY/9eEGoTTY=;
 b=OBwr8yLQTZUjtL8/XEOJpQTVyf918GQCw9Bi4xYozH5vtWpjritKKD/X/56hXTE0N6PVJQizS2Gepsn+gPHtZwBuVoCigr9qciZ1NaBEftsyuCApXnXuPm2iMzVMxs1c5Wca2YZQNRtLi1CrMLbWasu9nYP4O1/1mXRQoccVby/7QTL5BmzRUcLAVyfNBq5CqLLOresCTNnddhd1s57b3oLh+weDufUw81BFsBrnT94uRRhnkWdL5Ul2VHHT8hdzbznY3yLsZW1G1NXBOXd4/UMI3/SoGhcCSRgT7jom8q+ujvQQlDZ4YOoJaEOlwHDaMlHAB4qykSvqBWrMmgor9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgpzCMUwwCOaK01z61+JK4feMYO3TBRVPY/9eEGoTTY=;
 b=nLJF0qxp74HpUkjQho0dWEfsYfbieMGPvZD3U3Dfm7Tct9MBX1IsCBw9dRlxA/a72jpYEvD2etOMQO5IR3YXXni4n0bBy71as1TLR5sWfz6Jaxi6Bk1qdk8I8b8zAxIbUswLa5zAh3cLtyjw54vWCKq/5wVc1+P+x/eP57dfHRk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Tue, 29 Dec
 2020 01:17:03 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 01:17:03 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        david@lechnology.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] regmap: debugfs: Fix a memory leak when calling regmap_attach_dev
Date:   Tue, 29 Dec 2020 09:16:17 +0800
Message-Id: <20201229011617.3795455-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 01:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0138e764-696b-4bb2-1a8a-08d8ab977306
X-MS-TrafficTypeDiagnostic: PH0PR11MB5176:
X-Microsoft-Antispam-PRVS: <PH0PR11MB51765CB5B9F2FAE05B4F2FCF95D80@PH0PR11MB5176.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fUA1jaB+vfJGbEJhVENxqAxXgqSmgzBYg6IRxqKJ+IJeZs0fXCddoBG8GGDmkauPCi/P2IqBnXZbV7cO186Q27AQV8kK5XudUesmyciRlkHlKaMkyZ39q/VHfFPZ9F9lhlOUjGGCpW5koKmSdhf1RhZw4o3RMeGF8jovsTKTP4HK1HPMRHL5127sarMqbZmug9tdud4qs6hPkoLHn7aoS/zXJKYZ896SvuRMW9pIcngLielKY2xnvzs9nid9lFtdnkL1hFxRlafxl006wcAXJszzbkiIoSHXlOPj9d7bVUsp0x+DKDjcfop5g/7xYNGlFoKaq7ynC2KyH4WH9Lf0jlnkHJ6EBTJz/iuAvnDNOy8z/+iF1xen3AfJE+1pADr2+WtU50bow270NUaOCRiug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39850400004)(44832011)(6506007)(2616005)(16526019)(6486002)(956004)(36756003)(1076003)(26005)(8676002)(66556008)(66946007)(66476007)(2906002)(5660300002)(4326008)(6512007)(83380400001)(8936002)(6916009)(186003)(86362001)(52116002)(478600001)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eLzlxh7knG7krlIzQjY7Iv88XGpyaiVIPepwkQ8LHgwboOhFZpcJdC+qmNxI?=
 =?us-ascii?Q?FgEKjS9ClfQJcBTiuptLe4EZH767+NueiX3T7KtJjWyH3BtA98TBCzZ9VF52?=
 =?us-ascii?Q?IyafEvcF/4VPSCpE66WaFrexOPw/BM5tWPkesRp9bwQUDvxpCMty9rhPfLcv?=
 =?us-ascii?Q?Tdq3flrGLK8yvwp/FVtJ3JpuUyNZtC6jPyhawp6nP2I7r3Fjj8EKRG36HVhC?=
 =?us-ascii?Q?FJY42H7R5YSuYrAR0hxCkNraLRo1xgZOm4ILSBDHm3fd5xnzhoZi2n8SQ+OY?=
 =?us-ascii?Q?NwU/MesPXZnLyecw97JMZH1Y6YuxQzKVxqmA7IA07m6k3Q+8iS9Hd2lPjP5v?=
 =?us-ascii?Q?Qyxlpm5wxbB6TC92e/bwPFAzl1IYTOobeDDPbv0ULGpqyrXCDzWtFaytxRrg?=
 =?us-ascii?Q?LhqR65xJEOaa/2RtWkA4zlQUfetvHc/RAko68Mn+wHDS6dn5rgRHAol9tJIs?=
 =?us-ascii?Q?XB5XKTF8HnYxdvAxjF0HKPlVpDT1AfsSwqD7f7AhjPxkZSls+9KE1/5T90j2?=
 =?us-ascii?Q?unCxf3kiLPsVjK/P1Cg7zX43n3SC9IN7wfXvzBbpx8yq7DqViTb07B582C9T?=
 =?us-ascii?Q?G8aZHcBFOCTkJUOnc64zrqGxYhhxIvLzabFxXufDGuiiW0cZorq37OBbtS4c?=
 =?us-ascii?Q?bGUJcj/SsKeW9B5TlEfybAgIDbX7/KW3XduxAB8Z753SatB6JsOCR3docQ7I?=
 =?us-ascii?Q?oRlJkq+3WlavgyQcZTun9TDHfNVdKHnlhqcLvGef4g8D4q2bAeXfzT4wmPKs?=
 =?us-ascii?Q?WH+zMmAkb1TYvBRPbPTbMvu2rYn4h5MUNTWE+c1eUUK1tq1gWYagSH9R3CM3?=
 =?us-ascii?Q?Y1dTa+kDe09I5ggb0Jftkimqg/ygRHh2yhnC3J/yu/QP92uEDoxKENAzGu1F?=
 =?us-ascii?Q?uAJ+i9sVx81gJ82gvdnVMT6UbVWVLNROAhOnuEQ5Tuo5N65UU1uFA5tPDUpV?=
 =?us-ascii?Q?ZpPO/uiF30GsptOffSrVHdVrk7B9oQm0Yy62K0B9CwitxYBdMorIKBEzm7e0?=
 =?us-ascii?Q?Oplm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 01:17:03.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 0138e764-696b-4bb2-1a8a-08d8ab977306
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjoj8ZJsYJsTnMgMoT6BZ7wl2yN1YbXuwihdndaFthHiep/bKYQP75Ws8WWneTU8SbJxPdOu2nC077tf3o2TSglbQ/bf7YiaKbwSKvXsods=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")

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
+			return;
 		name = map->debugfs_name;
 		dummy_index++;
 	}
-- 
2.25.1

