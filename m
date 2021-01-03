Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F42E8E33
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbhACU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:57:42 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:45793
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhACU5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:57:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+6A6PTuSu3NAsp2Tt/a8uUZzxJrYbkdHUK/31rvMfFMvo63rS/+N1NcM98NikTiPspSEKt/JbXuo3vMG4AX4XJSwlnYXWw9KDT9O6/cCNexT7OR534I8dlB2wryWoLDSuMPayuhmT9LycrdDlbw9WdJGtLzH1EEM7mbeIeDz7DU9kZwLWSyAvHpSEW/KhM1WjND2PYebU3GwFhscyUs8AxLN9vt6KKYT4MsKF5NOlsYfhG4kRxNAlIoc13zByUdYUHcIykROryVJO35Qb8CTKmwvogzTTKGgJyE/Cf90UL5bhjwMO67y2xslmd16dpdc8LVBbuHE6Vj1HFtv18L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba8Cdja4pszkyJSgNAk4/VX+GY8WR6imn85afLQuJik=;
 b=ec/SZyyGdXJ8+EXBn+COpHwcnJU4H8l0M/jAXOlXrkJp7vwcvrdCfj+4GzH9Re59qXSV4JN6AKHk22f89KN5B0Hn/YVeRn7aniJ92PeFYp1+pWSQNHXjMQ5aFsBXIOJqDBnsI2NG2NWJNyc7iPzNWIXNG95bgEkdZrdtwZJQJKKn4ANsZiJvERRmAzG57QoDrR8O8JtHWVrZ4s2lykBefvI3B3yj0RGaj1ES2hqMSV5CY2Jm8gRP7r8Zrdwl1qEiaJl2OlViz4WxFC6cvJXMiyYSV89CEr7AITzG6ZBu9pO5avwZlkoqKMlvfjWHzqt3XSM1k+5F3FyV4nV7PzYO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba8Cdja4pszkyJSgNAk4/VX+GY8WR6imn85afLQuJik=;
 b=gS6vNQMf7dyPe0CKKqNy44oVlu0aRBLTQ927SbUTnFbRxOcuqsfbepdVYrX95thr8t/7Ny342B+wH7imQ6izrs66E6aoZ1izJba9ao4Aid3CQN/hcXIGX/jCYqBA/0BzpqaoJt1Pza0AgAOJtbWYBMrGeRoMSUzWLKRPzvlYzSQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:27 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:27 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 1/6] mfd: iqs62x: Remove superfluous whitespace above fallthroughs
Date:   Sun,  3 Jan 2021 14:56:04 -0600
Message-Id: <1609707369-11297-2-git-send-email-jeff@labundy.com>
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
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95a5176-2972-4cc2-fe93-08d8b02a0a14
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB7152308CBC25D59220B962A5D3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqN4qSDdb+QRrv50W1aRe7qVlUx18GIf4iJ+/Lc4RgyCvHImKAhcNUghj6R6TKFKoAb+Q1du+12euJLilvIv004u1zsIl4Xg6ZY9XWQO5AOhJlQyTBeBDLaqicL4uN2wcfkLry0tXgdAmVSzngs5t9twjLSzDWc0ay50HxvjtlgGErrFwFOtjqC29193JkA8bVsFU0YDWZofE5CAVlypl83SAvz69ZaOYjlE9NxAmCqSOawksYovNwep0XI5D3Q1f+V4gBkTkgRJJeOnXrQH/6BwzIxOW9c6joYDl/F/f6jPFQ20zVOWH/u5gfL6xLzbsbpT11ZmpYelQlSwODj8KYVLwoByN7ccHYgTdkbWrHfB4aMjOX80ouUDJ6nzC1BKP4wjgZw96Buny2EHgYDuDPIuQrm7FXXNXliIeeF6SRwYbxayfSqziewRLdHdnOPLSIPx8E19LxP2lhU1TEXEgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SDSAG4RVbbxPD396KLm2G/9RO7+5zUze+diz3i3Sw2W8RejVZ/l9jFfWg5pX?=
 =?us-ascii?Q?HSEutbmaNMMVxQINdi7nigTJmQwXsKYx1iSpZ/vWsBhx5OkFVpHU8iz9Oz8F?=
 =?us-ascii?Q?Be4ardzULaeYUDnVEuVpHEVyPeAtFP4Bq0E5AKkeR/mcoDdfJ/NTbchVNwQj?=
 =?us-ascii?Q?Ev9KovwjC97OXssROyiLa6SXwGLts+h8gA33DLgbli/QZVAOnNp6I5N4HFFM?=
 =?us-ascii?Q?MWOClHxjYP2crMrn93U20eT+LzZIIJKf4wmc5wVWhsAoInL273lccfozUstc?=
 =?us-ascii?Q?KRmiuLtidB9Fo3lG+2T9+/0Mw/gOKhQi4uazNzut0PXUiBYmYKzfIGaGgnSp?=
 =?us-ascii?Q?hxGj4lSANRPowbRhoMODFNV6L5RqyzOIB+tAeSdg2BXDbA031pQabIOmu1J6?=
 =?us-ascii?Q?XLsoxw/kIldPFvWQiXeXWtqNCN6msu92LBqbUNvEmAGs1DmhtDQ6IJt//CDr?=
 =?us-ascii?Q?co0wumPH9FxB3W4C3HUax9uDwRxM90bfme/7ur4+0sSCJzmdAqPx8jb8BfPF?=
 =?us-ascii?Q?jEtNdfAUkDwGt4HG6byGjf4DZXCe+8jOaknuUm9HQKc8XgXsJ3PBDTBb36RO?=
 =?us-ascii?Q?KTxCAKFM/efu1A5xaPFnT2DcmuwPbii1DtL+Wpclp6FIyQ9aIb6OYyBNO7Xe?=
 =?us-ascii?Q?pnMJlXdtw5U+wmOyPBnhWCDm7ib7b9PoNIZ3tnPbG+N1ANMISp6+1V61UJvq?=
 =?us-ascii?Q?qN6C22F0S811gesgxLvZDhdGWhj/6aDm3UXvIfAfdx3eJPJK1+izT3QrLwaz?=
 =?us-ascii?Q?XTWhfhzpjGakzmhLtAGGxV05CBL/fcVSyHAz8Yrl12M+iaUU4QfGwDj9PgAi?=
 =?us-ascii?Q?FqnLYZSrA+OFUZ2CaENgwG3A9Jyg6/w5G4pFN8sxGYFPj00g0UFEeTWxJ3pP?=
 =?us-ascii?Q?Qy5G6XXP1rtyURddhjkN809POILFlVgwUHtro7YdMrqhe7Xvbpv/p6sAJBzj?=
 =?us-ascii?Q?nuf5WwP3Tuy5GRtwyOfkltn+FSjAxxigFwRec6Y2hmhyJXKx5G/guLwT2IO0?=
 =?us-ascii?Q?x9aX?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:27.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: d95a5176-2972-4cc2-fe93-08d8b02a0a14
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKkrXcjTyfb+SjDNF4DK0ULl8o7XqprLwXCDXyxEoC/O+Jsg2NH7nZoi4mgzJOV74Ry7/IMU0qiM95htK2JBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, all instances of the /* fall through */ comment were
preceded by a newline to improve readability.

Now that /* fall through */ comments have been replaced with the
fallthrough pseudo-keyword, the leftover whitespace looks out of
place and can simply be removed.

Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/mfd/iqs62x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 761b4ef..ec4c790 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -135,7 +135,6 @@ static int iqs62x_dev_init(struct iqs62x_core *iqs62x)
 
 		if (val & IQS620_PROX_SETTINGS_4_SAR_EN)
 			iqs62x->ui_sel = IQS62X_UI_SAR1;
-
 		fallthrough;
 
 	case IQS621_PROD_NUM:
@@ -469,7 +468,6 @@ static irqreturn_t iqs62x_irq(int irq, void *context)
 		switch (event_reg) {
 		case IQS62X_EVENT_UI_LO:
 			event_data.ui_data = get_unaligned_le16(&event_map[i]);
-
 			fallthrough;
 
 		case IQS62X_EVENT_UI_HI:
@@ -490,7 +488,6 @@ static irqreturn_t iqs62x_irq(int irq, void *context)
 
 		case IQS62X_EVENT_HYST:
 			event_map[i] <<= iqs62x->dev_desc->hyst_shift;
-
 			fallthrough;
 
 		case IQS62X_EVENT_WHEEL:
-- 
2.7.4

