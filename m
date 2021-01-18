Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623D02F986B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbhARD7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:59:18 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:26509
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731945AbhARD7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:59:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvZ+LZYHBMnjtidl2DQ3R3Uugt5xjiiDyZR/pMRfOTsyUxLIvjE3jvk9dda5GXFsDKyKr0FZjltG4ipAdUggymPlds69iQkM4SioypLZyhw9Q7dkV/yj7jMgLDh+ayL3chwPlsiW2pU6kIZl8nlfKy9tVe7ZWV+hyjo+VcCpU7QTdm5U8QWkv1EQk3BSxoVhmHk/CV67lbu4J25G0iaIg9E7dnQmgh/d7tM+bOCxPao7oZ+cJbfNft8rqw/XLv3b8KviX/5u3ccBe6htGthk3b6n0lYMGM3ooIVRqdEP+smBrgI0No2RYSWPft2Gs/ZlMGR914gvTxkD6bGTOY+7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFNvZXJiPjAKCKXtFERZc4jobJ2Ab2+PeDvGy43qx2s=;
 b=eiqNyT+NcvkGeRNBw681FefQWtNz8a9MSJiph2IlkMzzBm2Ha6qKYhDToGFdQ8apEXI/CF7JCt7WEfFlpgASLKvQkAYB6MxVFBnGIW4TTvcYjChsDkbTtwHpLja23qtXdDRRrc6o7zxG6ZF3sXcAuj3WHWy16vgt2psCwwzUMt8XJxLEmpf7C5SWNn5wXzzghUcvy9vNQ/kZd62ZQOsYHoTyYED+xSUH+/ChAC6Keo64mlouvMRKSR6Knpu2vCsqxKN9sIhwXb6h2lsH513uOt+B1U6dk5CgFDTCOxyALw9iPBM5w2HsNJ6VezoiFbIFXnabSTU5y1hhZMgDH1uq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFNvZXJiPjAKCKXtFERZc4jobJ2Ab2+PeDvGy43qx2s=;
 b=ruqBT5ceNUHvFunKIKpFZvPF31V++MauwabrA+0MSfz73L3ieW594PN5+FOHW2rNNi+qXjvd2nvE0X1HOHwNU2yMFgWafCoLq7xlUCAae6dXsRo6rH2a2RKaAyyG1fazKEfGs8AFqkhoPjC/i0OgUmTqXjJG+/eavOkwzFB9WBA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:48 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:48 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 3/6] mfd: iqs62x: Rename regmap_config struct
Date:   Sun, 17 Jan 2021 21:57:05 -0600
Message-Id: <1610942228-7275-4-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610942228-7275-1-git-send-email-jeff@labundy.com>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9317056d-9be2-4f77-9c98-08d8bb65383a
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB4878F15AE90BE88740F8F048D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UyniDH8aB8HOjEvnqN6WeRwKUELDTwUBw2e2+XU1gefZnQhjnAm1fXwb8ycPZF7zrcTei2d2uSkVeLWfCneHGi/Rz6Xrg3y3h0aAKSCFDBuzQikm0pcasr6lDc41OiMzP4c9w9XGbVXjMSNJ+1ouEnNjkgBvYotJFvhQs1rPJ/6XoEaD1GD0uAoSlMZqmX9fKH7B/zb5+DKweaYlouiWCJaJGV26CmZNvx+FVSs00BNOlVzz1Z6MtJrGneganMFHcq5/ZrFE5a3kcGk3DPTqQgBsnEaYEZWzCvcxzmZ3DpNfFsjLSvkGOqkGADirc9Mug3EiviWc2QoEB/sS6Kl3NcEYzDJ0Mnj8M9lcTmBqh883+Q7WBr00+leSerTB80H68DNqo6GGyhK+ghHwynhjJ4PT272QJ1Pk8k3pkTqgiX/IGodT2u4uyWjsOAKCqXClliOlDh+FknlMcDluz+Ug4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rr3k9M727rkNRGQ0a59tCN/8zEK84wAZHrME06Hg5EtGrcp8nWoNexBTEbu4?=
 =?us-ascii?Q?NzhiGrgw2TNDwADLck6u6zM+6pmDcYyOJ9PVfu7vwb7WLdR7baguwVhF5A7i?=
 =?us-ascii?Q?c+ZcxdoEXggUB2+dmi5On4OinG4ftY+Pk0PdhjAIyJ/PMvPcP8zBXIDWi8kA?=
 =?us-ascii?Q?J+dLN2Ru6YTPxr58ViBIAXDWFAJsq6y9gn1I1qLGfBXlcET6gQF9k7Eew+sA?=
 =?us-ascii?Q?5w0Kg/6H7kEBSz3CjJNbdBeAFhNA8A0yTGh51degJNQZjz2lO8hYWFBk5rj2?=
 =?us-ascii?Q?y3Kjz8h30pKsn2iuqzwJrr1HSpw0Nm+sxQFTINiZ62d+n/bJDWkwjdEvmuPq?=
 =?us-ascii?Q?9KQMf+BehZJ1OD2NzJrUf/Ymm172uV/8H6s5dNEPFET/zghetBqAK0xRXxGa?=
 =?us-ascii?Q?f/LwEsPtZRd6xlf6Z1qYSaY2krtlqWaFIk0gypprErXlnH4J77pPXz8f7heX?=
 =?us-ascii?Q?lDCNaDqrymFEuJeCZOO8ApcdAPw6l6t48HSP+24I6xjLCz3xXUrNCbmuN5mX?=
 =?us-ascii?Q?VOBIKpXTduC6QHx7SSUXi/qi2yrP9axY+HwGgbtGh56mX76PweSFGj3WkLCk?=
 =?us-ascii?Q?8yqHSUDKz4hDVINyagATKi+nTq+EBLYVA22aMxKUmUl9jNJh7D96+Nk6NNjG?=
 =?us-ascii?Q?zNUmHUZnWmcy8kI8/NI4osrfKQyGr60YnPbitFkvlyQkNb8QMl+FLugaJTqt?=
 =?us-ascii?Q?YLIq6e3CNeim8m4o+fDEFY6h8jaaMnR7LSTvUkUae3eFvFMgR8007Jlfnb53?=
 =?us-ascii?Q?pNqew7vfkMRUZ8bGAy3873cpFB+2iZzyRkR8BKEn6gdokEDd+j+XmgPTaMJv?=
 =?us-ascii?Q?qTWTf0YALBextBDhSRyQa5mmDy9aUOcLBzEsnUDiaBZgMhtkRf66M73TrAGi?=
 =?us-ascii?Q?qTFjUwgZ+6g/5peVFqhNkX/UNKSiwYTDAXhudlLgB+pZvK4NhY1FbPqmgHiF?=
 =?us-ascii?Q?0L48hUdoODqycUNG4HLHJfJ1VVusMuVPVa2BoFSO2JFU7H4IvMPp9i3G04JK?=
 =?us-ascii?Q?bWXl?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317056d-9be2-4f77-9c98-08d8bb65383a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:48.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i/iQ05B6fvY2goL85KeQff8fDURenGmY3GVXG52d6dhf1NZPy4JpmruqmwIiiCczv53NsuU6MmFPkbLHx2P8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap member of the driver's private data is called 'regmap',
but the regmap_config struct is called 'iqs62x_map_config'. Rename
the latter to 'iqs62x_regmap_config' for consistency.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
  - Added Acked-for-MFD-by trailer

 drivers/mfd/iqs62x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index ff968dc..7a1ff7c 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -866,7 +866,7 @@ static const struct iqs62x_dev_desc iqs62x_devs[] = {
 	},
 };

-static const struct regmap_config iqs62x_map_config = {
+static const struct regmap_config iqs62x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = IQS62X_MAX_REG,
@@ -892,7 +892,7 @@ static int iqs62x_probe(struct i2c_client *client)
 	INIT_LIST_HEAD(&iqs62x->fw_blk_head);
 	init_completion(&iqs62x->fw_done);

-	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_map_config);
+	iqs62x->regmap = devm_regmap_init_i2c(client, &iqs62x_regmap_config);
 	if (IS_ERR(iqs62x->regmap)) {
 		ret = PTR_ERR(iqs62x->regmap);
 		dev_err(&client->dev, "Failed to initialize register map: %d\n",
--
2.7.4

