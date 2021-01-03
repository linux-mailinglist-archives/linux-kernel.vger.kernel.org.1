Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290DB2E8E32
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbhACU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:57:39 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:33505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhACU5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:57:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoAwM6il39v9EBuABfTBSz4ywl0brr/OgkYttQfUjBqIKwpB4resBf2AOc17fUVSyKNBxUQPrf9ZFF2cEByBBFefzJA+qHS76rHAaW8a+l2932jQK+3DwiC6oWt8tMqXYBod2GxMzPnERJd8IFdHqroUn8LgkH368BezCuJQW9xNGeU8cKb4hbWr3F6zUJxmbS9DOfcOsbqNCDg4tXQzpwMhxPjfKEecJigB2IB/kDD9a3+CvKfQnp/o3jPD5WUZw0cCTCCs9eYE3VDe26ovGDOx2rbP5ocH/c9p9j0JB7+DHcEO2crOcwT7h2z1aMlAKp0qTOQtnqlQtqhhHTyR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8MoqvXLAsA1o6qHp1KlDeCMxw/iHPpolmk1cyDzkeE=;
 b=lXukPZ1lZ2UCadgYzebVTOt/gzya/0mDDK4KEBMCC6yHmDQxibqBP1UOyXc0I+tPC7npxNaIhsj2EXWDPz22rocVMiyZ+ESSeuYviJwM0cpDPrHfY612ktbag4eX9OklFIOC/htjkhaPVDiISQhw0LXTaEZJTp9tmqkWttN7hqQWws5s889BSvFf+YCUZrb/G1R5khCGQZ4lvb0yxFk2HjYmPCrEj/IFqu7FPMVhUO4qGzI44Tu97sqng63F6O+8kAl/5D+1XNBuG97WHjOoea19V+jEr+cy2X7sZLUsROA4QlmMLEhTCx7lOXtHh/O2fedDVcHXRcUvkI77ioS1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8MoqvXLAsA1o6qHp1KlDeCMxw/iHPpolmk1cyDzkeE=;
 b=mS+Hbd5Oz4hhyZRIehBgWmI9Xzv+fi6CrYil2HkSinQOgmmL84BS8FHh7zQCXTTVuE3DsLEetrrqI63IkeaHn44sVSXFM5JN/5yAAyRKKDT0wbhWVCqB/PHbGTvqf809aDA4OwizMkZJ7xGjsvZ3sgOSYeDtAEOicrG0W4+5euo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:41 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:39 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 2/6] mfd: iqs62x: Remove unused bit mask
Date:   Sun,  3 Jan 2021 14:56:05 -0600
Message-Id: <1609707369-11297-3-git-send-email-jeff@labundy.com>
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
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcbd554c-2286-4913-ab3a-08d8b02a10ef
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB7152E5143C0E16BCDC1CD929D3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Po4WjE+f2QZIGuXDK/xLBg8aLFqbHPO1cwLZNkXtsBBg+1ng5PAMgu2ggzb+Slv+6mzSY2WncAIyxt/y2ZesZDHJxcS7m0xh4sPmh2MFb1kur1uWBXpBPluaoUDnwJEdjtOxp/D42YJwzubu7E3kP3Lt5XMPtUWFQGkZAkr9CrA2ofRa0ehhhippGCLgaEaiAaxVz4+wswu4ZGgcUP/sG2MmpWxBj/tNsNkoq/U81JPWGk0aY27gAkC+lThPsgiLz+LWGhydK1YyldyAyv4k1r3+vTrtUD9KNFV4Gnq0JEwN4CtknxHl724xAZae9nM+8g+xt88kEpJEGWXL89bBXfIqlACfg4Lm2D2PTj4+sqCMyFppXaF6U4tl2awR0A1Bhm7sojpAjdJzO9vXuyS+NrDQrvOK3E/LmCwR3ce6KK78PQINxD89cJrWdPMvAOI7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(4744005)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NQtmbatujxUYr3dQzEwhAUgqWiZPe69xW7OP69g7Lfq41/gjhfnBxgCF6pPW?=
 =?us-ascii?Q?M+0d4JMrSyakkuMXD6eTB3u5WuFXxQrG1BVfMkOh8538eCXzK7W1i5jkBxGM?=
 =?us-ascii?Q?syNFv9FF6ucb0SL00TDlCptVAcPjZk9h5APssuz+b11I2QW3mVU6HY0jfXYR?=
 =?us-ascii?Q?NiFvU7HIm+NwwHAr0QoNk1xnRZeb2svwyuqlpsZ5zJ4EgsaILwTZ/lnfzDzo?=
 =?us-ascii?Q?hZv/mbB+f5evmSCSsQJ/3XjRO5mpXGNScT2FGHUiWvYLsV1yNbT8v1WULUDy?=
 =?us-ascii?Q?FdJO34rk+JA7rHYWpSED3ic08WwnCiJn6SsK0fcggjvquIhxn8mVcb0mq3cp?=
 =?us-ascii?Q?Obxjp0q6muUDgzI+wq0RhPWBBuzFbVj9D88NOdhfBUariiXvRCn7Ccmw8rmn?=
 =?us-ascii?Q?vH5c4mCo0FH0R+AgpSU+QRG09Dm8+68jg9vTS9sS5ydgVzuYpekIh9YWDiVH?=
 =?us-ascii?Q?x/rgfRkRVN53UAm1GVf5UKyrqMWs8TO4A5FXiAkPg3RRfEdIaCyF/j8LQOMB?=
 =?us-ascii?Q?BUB2uSu/gNvsWW+eQHRszFsiChX+sBS1MLz48DToLnoDOV71UFRGBpbunajv?=
 =?us-ascii?Q?kkxBTLO0Orxu1RlzsHl9A2+A9JUbXnhvYuIyGfB/1uBSWUtm/oHLwWth3qha?=
 =?us-ascii?Q?iu1FVRPeIWU0cgF8BrU8h7BgiTJKlv0yYgYP9b84nFRVHFg+Efg9fTb6SFu2?=
 =?us-ascii?Q?cmkP6DTp1KK4jhgGd6q2mQxOmKo9bh4HdmXR8E3HDx865OtS/D78lVbXldi+?=
 =?us-ascii?Q?FeosicVRA5qlueN2+ok4XLaKOQZbLJ+RlJDxyyl7xV7swst7MfDckckXa+jH?=
 =?us-ascii?Q?KSupb1WUDjr2CNxEtTfgjvP6kUVXH1iCGxz+OSrIc8eOel7Z1icButS+acgG?=
 =?us-ascii?Q?oCOx0igySYebPycAcpKt91v7WqtVwBL/o9foNIGQ2yY9uGI+RFsuM/SVTwxM?=
 =?us-ascii?Q?tENQXQjS0bvNfFbmBPoO6wl8az/fJ8uuqHsuGgQxu3jN3s4axpIFbdimcmUr?=
 =?us-ascii?Q?q44+?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:39.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbd554c-2286-4913-ab3a-08d8b02a10ef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klbWy2oHsu+p5maJQ5WqfHjdgXeTwalGcQNImPshL/badtEqQomZ6yInrfc6fqypQU0RVuTspF5MvSrPYFvaEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register write that performed a mandatory soft reset during
probe was removed during development of the driver, however the
IQS62X_SYS_SETTINGS_SOFT_RESET bit mask was left behind. Remove
it to keep stray macros out of the driver.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/mfd/iqs62x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index ec4c790..ff968dc 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -57,7 +57,6 @@
 #define IQS620_TEMP_CAL_OFFS			0xC4
 
 #define IQS62X_SYS_SETTINGS			0xD0
-#define IQS62X_SYS_SETTINGS_SOFT_RESET		BIT(7)
 #define IQS62X_SYS_SETTINGS_ACK_RESET		BIT(6)
 #define IQS62X_SYS_SETTINGS_EVENT_MODE		BIT(5)
 #define IQS62X_SYS_SETTINGS_CLK_DIV		BIT(4)
-- 
2.7.4

