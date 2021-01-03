Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5002E8E34
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbhACU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:58:01 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:33505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhACU6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:58:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFpBth/aQ2nRuEGF0pqOv1Sr8Yad3ZNUbLAmsNYghma3UpaYbOhEPT4aEWNNyxEz74Q0xq3MscLoU8ooxyy29WTJpgXRFGLZmJY4j0cwS2f1JGS3vieAxsmwNsbS9lhYvF1xDpaEe5cxRufYm/8pd120s1v0I5VF43KXJ9g3e0Ix0nI318L44luCivtJ51VlQboQnv1rSO2ZPAe6GYDsAxskWncTK2EuXpQKmJ57Lo0MegMeXjwcnp/11LPpYcXm19XHC3XRS1ZAQMvzCKi0N/5NQkaAQv3iOU3+xBs5okL9yhEOSQwo9RjnXMVcOpM70ggEXpDt0B8+YSFv+fvYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je8W3jR+Uhn9ukYaLn3Gk0w8nssgQGW36WP6KiwFBsc=;
 b=mmTIW/LJsnc5oGl22oXUCaN/zRrejyOrXTvs7xacd5iHdDFmqseoO5pbtzCTVLSyBNaQ8zl6h9TQz5dnwhVNtUOv64TtrTsPLVs6y+n+kcYIjGMxlr+vzVeou+rZF/+LxS2nmDGQ/l9Wv7pb6O1QE21z5cf7rGApljDdCKA/2baePHWtSo1Ze9hbZSNXXdGwfUec76f8D7prXgysdYIFADIVVjKG8OzfE4DP1pGf8Ud9/ytyDnKTSYNRgiYsu+zH59zDzRgffnmzqKk+BRm3pB87jPYb04jUTwgumlqRPZGrRJXQh7NQLlWH9FAuvdSlH1Yy38V6AL9WCyRifrNxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je8W3jR+Uhn9ukYaLn3Gk0w8nssgQGW36WP6KiwFBsc=;
 b=lmw0aVWJF262gnaR0K8ciGS8pbD+Sr/2+xFXiq5wxFSumgQl3sEgNfbsqpvyJam3Bx2hk1Zfj7DxQvhUsIXd1wIHJ7DVybA8x7qVB01dVgKvaKn/gPIQy+1dydKOBx1B70UTF8ZNTWDnBaHUfXUnZvOJN1HCGF1ReSta53bQWok=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:44 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:44 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 3/6] mfd: iqs62x: Rename regmap_config struct
Date:   Sun,  3 Jan 2021 14:56:06 -0600
Message-Id: <1609707369-11297-4-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609707369-11297-1-git-send-email-jeff@labundy.com>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: DS7PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::28) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ee7306-2d8c-4217-485c-08d8b02a13cc
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB715298EA98D4BD2334EE9872D3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GfHuynoVafLv63oGKaqSDJYuoV0E3KUOde7Dm+7X6FIQPKOi3Uz4QoUH6dlXpi26f8GiU2Q20FwSEKGPrkR9t8HKqmjlm45+TQDPnXFMXsoDjfXjryNgLVt6Turso+fx/2kCM70N3CRcycEyJW4yzBQhPHIh1jGN69dyFGHZcwgfIxbj3vbgYTNEuCnYzY2OztYgyepJnl1/y91aiypBoOq7G2x1gt07ZjhuzyhtN+vVytdBpc6LKCIx+HVVQEkm9pGIyopv+tA88e88Jfl68iDOlq2T08F+FS5EGzlyU10xj3PWOAwJBRy7Pkv+a0ox/YWLxEqjUeto6/dDn8oc3iFfRBOGSsBi1qIQMalpfeaiGlDYrcdQ9zByNCyY6RP7bN7AIQAdv1R3oLsxG52uef5SeOwgwrkVZAPpIfgxlhGDPuJVXDbk0AG2IBrLJwUwI/7VZbtNwnGMXHqcx/o1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kpUdN+a5FyjkfXyG3c6Qa/15hFR82GPuNMBv30hQEMQcveqYOVFIto9aK79N?=
 =?us-ascii?Q?BC5Qm1qJ1+4o7T7O1QyKDUumQprJYwtllhNvvuSQbLcrkfB/rNm0F/L726Jo?=
 =?us-ascii?Q?m+0V3m1eJalgSjClZJK6/poBjhduPBW3TjK7LJjI56tZmfNIQigXD8bz+KQO?=
 =?us-ascii?Q?FgObUNYXdWbLcmHL1DsFj/4aWR1q9bFri+Ut2ighd6kO0WRuACUrO3xku6Uo?=
 =?us-ascii?Q?eFNN2PXqzjhXQZwvPGwEOlajjhVqEVO97jRSWMnT5OFgbf5jbJT4EzeJLyZh?=
 =?us-ascii?Q?MZX/3iiSW7R/MQrm4e1/tlLE1fbiud87Bn8SpuRtt3cN8EFBZ/CC72VWG1XQ?=
 =?us-ascii?Q?vLpGMGGl8iycxqMJKlG7Q+0J7rIezDBV5A9domZmzqg9gG7hc6NDUSJk3MFQ?=
 =?us-ascii?Q?QexdrANT7nv3d7kHVulnrUhSw7ThT4PzunnIPbsfi7mukYWUNhxE3AqNiXU9?=
 =?us-ascii?Q?Et8DyvB9PXULrlWHI1PBgcfLgBBTd+hykGkJdwsKK1lzoNrDwb10A2H1YbQ3?=
 =?us-ascii?Q?YxFRzvuvvmTQk2b84dUxRbQd4Uytm9JfGxGMpVeQ1dkNSgM+WydfSO7s32u4?=
 =?us-ascii?Q?H1N3MQ2Hacifjhyh2g7xbS6iC3+S2o7eMpda0neBriFJH+UN9tVG1i0LzRko?=
 =?us-ascii?Q?ok5F5N3ms8CnIScxA9+9UpewhmX82KTcKJr4/kvTls6k5oVNZGbySSFJz3/T?=
 =?us-ascii?Q?hP65nkb9v4LiX4GrPWYakS/43/RNJCyj6JDqwtNfCaCH7e+rf0QLpKCZljbm?=
 =?us-ascii?Q?wPiu0FuHjD/dXL7OYRSYPRbC4Bld9Wxp+1uzeKj+TsvfUJiu+p+cmPqmqtq4?=
 =?us-ascii?Q?kXU4GQ7GakT2Cl2aJ3DFJGFuNvcbQgCanw7/9cY0vG4qTvzQLbihfPcpvDok?=
 =?us-ascii?Q?/RmBxzAJT0dU/NkNSgvsQ6rHAoFJye7Pi14lhY+oiS1a0hXRY3QzDAh9SZj3?=
 =?us-ascii?Q?r+o2dCrG5H4hXT3hKMAxHiECDLiTekJaeR/p8DcJ0UVOo194b/1EoEn7uuzx?=
 =?us-ascii?Q?WwmL?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:43.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ee7306-2d8c-4217-485c-08d8b02a13cc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHpZ2iIjy5ZTIdx1Q/oC7dnmJkSANJoPaI/6Jj1Kf3s9HQuarucDVIRy1K3anEAyBkDEzPhrH8n0oZsLjqfs2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap member of the driver's private data is called 'regmap',
but the regmap_config struct is called 'iqs62x_map_config'. Rename
the latter to 'iqs62x_regmap_config' for consistency.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
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

