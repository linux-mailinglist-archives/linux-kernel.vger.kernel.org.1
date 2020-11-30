Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC22C833D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgK3L3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:29:03 -0500
Received: from mail-eopbgr30116.outbound.protection.outlook.com ([40.107.3.116]:60533
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbgK3L3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:29:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D25dl9Mre0JL8OEPIfvK3mcXFzbZ33BePVZsthKSjxnWMNlEEDrXVKkJmh0N7tTHtLAfyHqCinTjtmIoL5wCGSDGJNGqJOv736eBUQ0uqcMxjbfdh755iNucJYzmcrlSaiofLhgIsTp/8Q/puDq4ZDQCyh4eDd0m1HJf1tOOICmGwvYcuaw+kytjl03rUZ+DpdZxy6efnrtr86Il3N5KqR1ed3LAqjKdliixuOvTiULSZQ847vD3W81TWVFcJiME5mozGMBuOxNEy1h9mmlmCFSUPnfxHNucEf3Daqr4FO2fbyu6/fa9XmJ5WNeSuRgZMC8/GhhPZlCSYrNdpgQZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzF2N0NGvv5kaLxmKKgM+rd7yyD8vCVNs89i2nA5AwA=;
 b=VKVnsxxh1sPWIsHnPm8Ht5riJHcRIBQfi6w9bVhFUe3BIB+oF/dQ/6Y9exIz7vwo+Vc2LzGAYefqnG6C6/ERev+RvOdOP7ir84Eov03ovJDQAMrdj82OOP9pbltlAe78Foi2FzJfB1Hj1wDpWjEr8jTbx9jhfIqnaaL4vbT5jWwDAqsYoL58HwjmXzS5+h5WtOXDwR0ykvxiwtbNkW8Fmk0otICcZ8TpbxGs5ata5OlZlX9Zq+wBfpYx7akcdHUMGLPTlPjaW1mNePQmqN9az+yDrukyre9wrTm+lLvC/t+WIeDEzpb7dKJLXUueypR2ep7AUBi2iifZSao9vtO2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzF2N0NGvv5kaLxmKKgM+rd7yyD8vCVNs89i2nA5AwA=;
 b=BVFDMaz59rJ6yWzUvRHHRLdYW31TNcWz5H8//GOdjeDn/3DghyzIrerp6hg2r2GS7wHFAZccS3Xcibs8WdzacCfdyehMKp5FKNiCPbgTvNRCdf+k+Gk9JnIiZxGBW/2fq77IhvVK6k92mIKNowBKZ/XlRbMLakaJ+T23EUGTvh8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=leica-geosystems.com;
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com (2603:10a6:4:9b::11)
 by DB6PR0601MB2455.eurprd06.prod.outlook.com (2603:10a6:4:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Mon, 30 Nov
 2020 11:27:40 +0000
Received: from DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c]) by DB6PR0602MB2886.eurprd06.prod.outlook.com
 ([fe80::49c3:4b5b:289c:d62c%12]) with mapi id 15.20.3611.025; Mon, 30 Nov
 2020 11:27:40 +0000
From:   Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, krzk@kernel.org,
        olof@lixom.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] arm64: defconfig: drop unused POWER_AVS option
Date:   Mon, 30 Nov 2020 11:27:30 +0000
Message-Id: <20201130112731.30599-2-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain
X-Originating-IP: [193.8.40.112]
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To DB6PR0602MB2886.eurprd06.prod.outlook.com
 (2603:10a6:4:9b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 11:27:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f015060f-76d7-41ae-7bde-08d89522f24c
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2455E78BE7E56C670698295BA6F50@DB6PR0601MB2455.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tpEw0wpCv8j35xEy+3pRJc2xsTkqrlj8mGcV7/u6ocEEDz6pffg9wMSceZA/66P10qvRmVUxM7d8yLiHHXnNfprBVo6Egan3wugCRvSEeXd+lvLX6atrC+yu00OtjRTcPPQkXxdpFdstJ9GHLmCkJdAFA6wCnZ9Gq82FmWxHkJUlOghKKumuDqtbWyuhMBgP5Evv+tgyWCA5MOFCSy/FSy7i3cTPU2rWbJ5lLGpWqj00rAKqAV5/fCpvPdMJBkubupJkxprwdpoRwga5l4nEl8dr+B21C9/3SnJOgq+rMg2mFz/iIAY4cBDqsDM7jW+OaHz1zQlVE+9A6pNjk81iC5qgxPuxSqPQksvsT/20cPmqjbLZbMfI+VU3p1aOfvH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0602MB2886.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(6486002)(86362001)(83380400001)(6512007)(66946007)(186003)(26005)(66556008)(66476007)(921005)(16526019)(7416002)(1076003)(6666004)(44832011)(956004)(54906003)(2616005)(2906002)(4326008)(52116002)(5660300002)(8676002)(6506007)(8936002)(316002)(36756003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SqdZBWxAjfAF1VND4hmotFrIIPYac86HdmIoyza2n/UDmgAryTM9WyXQ2G61?=
 =?us-ascii?Q?4Cw9OGN0OyS3M1KdFw3twk9f63buDhNrncrN4SjZphmrDrk+5s10duqaaw9R?=
 =?us-ascii?Q?At9AFymloWi9J9hNMG9sSFw/bMosktJ2YFRkFICnob0RA+kTQRIki3mGaD7/?=
 =?us-ascii?Q?fZLRvezE+PEpXO09fww85LVbBra1K5NGLPTXN1cFzAigT7D9QAVCjcHsi/+Y?=
 =?us-ascii?Q?+bLd/486MjwsPHRAWKh+G8cGBf0V6p+icxy+9iVR1gBBXH3N3W0qsvWrBYGJ?=
 =?us-ascii?Q?TZS/CJOED0tx9x8dMjLiNlRgS1kCQ5oLRvMSRfJroDLXz3dGBLbHV6T0LjV3?=
 =?us-ascii?Q?lG+dN+b1wZXEWUbNA0Djk8+iO7DRHNoWBIX3bUd6z3k1wSxz7Sc5mGEW5qTy?=
 =?us-ascii?Q?4knj3P4G9Otcbfk0ZdQQKAlek1ijy6Gggseyh8IQL7plNFo0sVRxL1jYegzc?=
 =?us-ascii?Q?0DQ5ckfn4Sj/yVUnqj6d+N30cgadIsXKu67reAGqffXC4Z1FNA2I8Pdl/1XE?=
 =?us-ascii?Q?i1Lra4jiuBcWQui/J0MYN2xTYMXnozJPqDK7kA2hiVeobqgyU+ynythNJzIP?=
 =?us-ascii?Q?U9QTUC5kgOZRb0FeBpnh2FP6mdhU44CCzfQhT95cCjv1GmfZ3Q6OopE/c7Q3?=
 =?us-ascii?Q?RBTHN4dGk/7KhsiZqsGFpih+OH/JczdIB5TiaXeKYHqgNkp42omkPndBcosB?=
 =?us-ascii?Q?0j09csM7lmiB4pdo0ixxEBQYsi8wagGyPkwGjRSor7Mq7ZU1nLllyq4LNZ2j?=
 =?us-ascii?Q?SGuTZwojDbeIYkzLDAxFc/N3XmiJsKiGRHpIruyN7tghcHZm6m2bk/PWv5Ga?=
 =?us-ascii?Q?THbSBG1a51ENd/KcLSosu5l4M4Yr4I/0FZo0RYgEoH4u4h8Wzpe8I4RKgC9g?=
 =?us-ascii?Q?Scy8Tvi9CgDLLfJdQjlSruiKyQUWzsBhLApCLcMuwXidUuXmPyZNozkrLtoe?=
 =?us-ascii?Q?oma0TyW4VKD3oZ7Jjoov7XVFW+es1CjjUwh7FgRzxaSoLW4WAaVqOfTEHtVL?=
 =?us-ascii?Q?Gi6V?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f015060f-76d7-41ae-7bde-08d89522f24c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0602MB2886.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 11:27:40.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZANSu5nVdkkU3FJk/bLCj16IOJRJg8onlq3cCFLQkfCiRTDcudWZNci8o5SFq4r+ub3I+/idY8BBtyaRLykakyxMJjH6BQxsdiIezwsaqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
corresponding Kconfig") moved AVS code to SOC-specific folders, and
removed corresponding Kconfig from drivers/power, leaving original
POWER_AVS config option enabled in defconfig file.

Remove the option, which has no references in the tree anymore.

Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
Cc: Nishanth Menon <nm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..8e3f7ae71de5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -513,7 +513,6 @@ CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
-CONFIG_POWER_AVS=y
 CONFIG_QCOM_CPR=y
 CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_POWER_RESET_MSM=y
-- 
2.17.1

