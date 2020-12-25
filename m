Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0F2E2B78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLYM1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 07:27:43 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:49220
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgLYM1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 07:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGNmgv9WpRf3nY67MLE/t09E3kevhmKt8AjIu0lPnoNLUzKZr5t6hWqUl3VA23YeP+nqanu3rQQw0aCZ3drJww5Mc/PWrl07sMSGkCWuCd7Fe7qpXqKriLjtxYyhVIfQSQ5JC0eBayfeQ0osyt9Xa+eQRji2M04lsRKuEHKLSlmQP0OEPEXCy6vfLZGppZ9XXTDaHuThvE/P42XM3X75liisno16gCrCu6n5layVSD1JBt9MnmHHuShoGlSl6PeKt7g0+ziLkneorKaQeaj6viR0VJOqyCSalX/hcvIheAu7RiMLXfA0MzfzFX3sFmRfHYr+cmisgb4ZqrUMJnfIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpHpJISZ53yRFctO6WbF9KSBXauhxGOV77vdlDCwPfw=;
 b=dhtdk84LGV1qyUykeC86b8d+sqqFIfE6ewRGTpFSrZ+N7LjFdSje24WwzggAfvwaurobnUVJICxdLOY4+3eKJA7sJJy+uWwOudqvPdeVwyHUlFRMaAKAXNEQpWDUaANJy/ap0BDA190NirUV9h53reGcJ/2SMGwz2CBw/1AkEMLJhahreD0uoXZdgUod9lrzxBlKoV+gwpVpK403zZvtMuuoeKrhYByhvggPBIGbBnOTHFK76bGnoa8xkL0gvUdBW0zd9HJyhuD6nHgsGV2U3bqyg8JuYxHF2mxFeL0Cv9LbcaQtIqneqtZQHVhm7ZpjMclkK+S+lWo/eGc4geHEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpHpJISZ53yRFctO6WbF9KSBXauhxGOV77vdlDCwPfw=;
 b=Q7HRn9K+u+OI1olvXWQ+Qe/3/9OtcRd+bvQofia+SpXRv8Ex6wAo3yQe2SMntVbaB/4fWFf5U986ZihWgfh+wajeK50+DE02jK011rA1k4vQT86i9M1DkRsIOb4CcUN94h1uzdzDjTLZWQ/ya0LwsfwKO5gnAsyN/10clSQN7CI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5206.namprd11.prod.outlook.com (2603:10b6:510:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 12:26:35 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.029; Fri, 25 Dec 2020
 12:26:35 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: debugfs: fix a memory leak when calling regmap_attach_dev
Date:   Fri, 25 Dec 2020 20:26:13 +0800
Message-Id: <20201225122613.3810458-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.12 via Frontend Transport; Fri, 25 Dec 2020 12:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 224b1107-b732-431d-443a-08d8a8d051d9
X-MS-TrafficTypeDiagnostic: PH0PR11MB5206:
X-Microsoft-Antispam-PRVS: <PH0PR11MB520663C05C087FCC6F90C6E395DC0@PH0PR11MB5206.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le12UdtFey7jQwMh77Do7o7U72N2sp1O6lqj61i7zV9GBHBv7Buk63SH+JHgl2ytbF3jW02UGsY31M6olt2k+nmZrWOLr6K3J5BGjvtkA9wTrkmaJG8inGWqpcMp9dxSRKQTn5Xmnlo5VUYkpaXoJ1slgPTM2MD5NJIZsd3TF8yHOZHclFfZSmvjBwgnw6ugQj49xHfBs7vnYH4CIUPhAUEy0CC6J3LgmF9nDwjSlJwfuIZam/YDKQ6PDpRxP9fbcI7XW3S4mulvu1Si1dikoAGclCgqS7Bhcmlidc0F6yATyMU3PvgcuHNKJHeYrhGGwwvQVrEuIcDKdQFS57NrgDp4hca77PezFYhxcm1NC04PpllcS9AGTHCQfonx06xLnOMiTrIaWMWy8+f88RpTSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(396003)(136003)(376002)(26005)(86362001)(478600001)(8676002)(16526019)(83380400001)(52116002)(6666004)(6916009)(44832011)(4326008)(316002)(2616005)(956004)(6486002)(66476007)(5660300002)(66946007)(36756003)(1076003)(6512007)(66556008)(8936002)(6506007)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OaB4dRuy+H4/I6SjmxzYgg5fdOEFp5bFOVQW8jmNg2J67omTCp/5VlsQCRIL?=
 =?us-ascii?Q?FC0RBTUhInuQCVUqfpfcYtJnhdTD3fAdrJ52YKRM9sXeF5Fps5BRb9w/m2J4?=
 =?us-ascii?Q?VOP970IK/XwcA7OGo4hKtxnc/wHTIEbaeOPaJOCp8D4jMszQsw8lmoSQ8jh3?=
 =?us-ascii?Q?W2IFolgOTIkkhe+pW0eIqs1BvkTm3fzckjzW8ApEGAMuH/L5QKC191yMChhD?=
 =?us-ascii?Q?IG8c8h76chWN4ZMjKzv/gXBq9zyPxB6003/0s4UvATGnAABtDbeW4TLk6Gdb?=
 =?us-ascii?Q?c14WR0f0NVKr1al3FPG8wW5eRPYTUdxOwsCIYzZ29rH5VyNxwrkQq/vAcU+N?=
 =?us-ascii?Q?2xQHkXXQXxYgWTiJkndhCdiIRuA43THy+4v9u1tz+af06pdwRDQQfBGJfIC8?=
 =?us-ascii?Q?mkNux65b503QBZSMnutpsss4HKDPvUUrX9TgEFQ5J3lhSM1PqwxcfgkmUJi6?=
 =?us-ascii?Q?wYrcY/0gX660s4I1oiF0fkxTAJMnkFC7WK+r7QyFe2DlN6gKDpuUFYUW0D34?=
 =?us-ascii?Q?uz/l4Cmyb2GiL8QyY4UMcHpCgu6NxCKbzUZeGt53oNBZiFA30Q5K9d0IgZjN?=
 =?us-ascii?Q?PV0bZ1mWhYtlohgW0P+hK4Ucex4bIR7oMumRCM1tiJd529RqT9pdhySnKETJ?=
 =?us-ascii?Q?uROJvFoy4nfESVOImXJ5Vtj4zJcTyqrp7ZUSpJHvG8v5iNbJuH9pWlxfyOcY?=
 =?us-ascii?Q?c3XVDznseS1KyBaYIbqSWi2h942gxeMomXlV2GLGDPOHTPAunPcUgLt+nJo0?=
 =?us-ascii?Q?+qfwVHSbmUL23QTgacCCPnYJcpeQB4FDO51uT2ygjtYi3B9MetO/8A/aAmR1?=
 =?us-ascii?Q?SdTqBRnIKW8X5Q6soUqFvMS5J2WXSxtiZ4LyuPChcHK0Jhp8KHOaCAQK/QOq?=
 =?us-ascii?Q?DWL/K+L0KMljlJislRruSOJxBlJEeVNoiL9pruAnYoc9jSUVykUzwY9mWrgx?=
 =?us-ascii?Q?lkqN3jxFALxmA41F3exyKdMChk1WhwONq0aguiKRyVI4P1rUZyobL49al/Ja?=
 =?us-ascii?Q?kz7j?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 12:26:35.1000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 224b1107-b732-431d-443a-08d8a8d051d9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZ5gcPDeCwf7Lg8eFjjNCnc3ihmNSPoaTudnmrdn90C7DcjjZjREYgH+YghgxZ5+v/7gzbXrIi77usghTHAguc9HouVDb/OwcEHP38amZcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be caused by
commit <9b947a13e7f6> ("<regmap: use debugfs even when no device>")

After initializing the regmap through
syscon_regmap_lookup_by_compatible, then regmap_attach_dev to the
device, because the debugfs_name has been allocated, there is no need to
redistribute it again

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
 drivers/base/regmap/regmap-debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 8dfac7f3ed7a..271142981f98 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -582,8 +582,10 @@ void regmap_debugfs_init(struct regmap *map)
 		devname = dev_name(map->dev);
 
 	if (name) {
-		map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
+		if (!map->debugfs_name) {
+			map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
 					      devname, name);
+		}
 		name = map->debugfs_name;
 	} else {
 		name = devname;
-- 
2.25.1

