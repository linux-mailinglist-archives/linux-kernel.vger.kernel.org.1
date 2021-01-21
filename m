Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF262FE3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbhAUHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:31:28 -0500
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:49816
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbhAUH1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:27:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSS5mdXuisxuCsszC8MWvuXFBYsos+NRWueKcN6VslRKwrN89HHPw+i0wmrr1EniiYVmJTTbn4E3Uf1YMKy6eqkYGIVSJRuWUVf7aGVGOQebLaYIftYjhs7rGx9xJ9GsynfEdYg9cqTmjKG264bltq+A5nsZjf6whNhDZ6bx3e0PM+LNClz3RDRQptFj1yZvL/NHysHNr/HifS1jTTASp+ff9xOGI5Z8KDOOhgJNKG8uYzfJUrw1b53bSHzEZvplrDZ2AWccRLdc9sx+y8VYdj/uP6YhIPS4dOFVYYNAjDHRzmunF3YsgmLWYinfkeTm0ImBSNt02R9Y3ro+MXmaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gHpvDNfsYZ3YIk0AE7nafolKwTtiumoSz3Gtc53P6k=;
 b=c6G3s+dUFE0IvvPWP71+mLqf+LlBOkEo5hL+lCbEGgBlhuwx44gWsVtNGNOqU9GhNu5NMgkHctKHp8p3Rj6R8maibb+GEZkC1Zsubw08AdW2CZQrUO+H0+vxpnjjoe7HlJTPmcfVyBS0y3mj+/Xl2nsUsb+VIVtl9QQtAP6DL0ewygY5PlaNWDUbGIXuQ3UIO7iKRAiiHCuJLOcM7COoyIY8vcOZwxVDNH8Q8KDQa1G6mEQdOUKuANystJIKMNa155cs1zqVQquHbW2G4DKEfgOW7+NnRT0e9ylFFFsXZuJuUUh8gEI1A3Z8QP9I3TvkLt8/ZuaHalreAzAMgqYVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gHpvDNfsYZ3YIk0AE7nafolKwTtiumoSz3Gtc53P6k=;
 b=O6SbSdFcBFH9LqD8YixtIlXqpNqkGU9e+IbtoycoPnFCNazKCDC4vEVLjN+558Mnp04L6WJiPWrPk/eLqlr8S3bDgeDtNrev/6AaqchBQPVetQNZpou66FS1BbWa6JOeZxekPfnEf0aEr1t+Z9mV+2GozYhTQilDJEBq+dFLwQ4=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5711.eurprd04.prod.outlook.com (2603:10a6:803:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 07:25:28 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 07:25:28 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, laurentiu.palcu@oss.nxp.com,
        guido.gunther@puri.sm
Subject: [PATCH v6 4/6] drm/atomic: Avoid unused-but-set-variable warning on for_each_old_plane_in_state
Date:   Thu, 21 Jan 2021 15:14:21 +0800
Message-Id: <1611213263-7245-5-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611213263-7245-1-git-send-email-victor.liu@nxp.com>
References: <1611213263-7245-1-git-send-email-victor.liu@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR06CA0123.apcprd06.prod.outlook.com (2603:1096:1:1d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 07:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a054a40-afaf-4b66-680a-08d8bdddb9bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB5711:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5711668DF39D2FFFAA802A8398A10@VI1PR04MB5711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 189Y1DqzdGzrLctFg2VOVw+mHAlFvNKfl07XUom8b9PvNPw1ql2JwpjMGAVywJ52qHoWgVo0fFYxP46pYG7FCs2uPnuDdIydkMFwYShPa5meYcYM2vaGFmIb7MVH0aF1cbeGTCvpxc7B19n13SwuGnhl76lkC7Nm0wLm08VMeS41S2QtSg2f9ZRZrUVK4ua/B9euzRzeumD1xWEhaQ97B2XZcCpwI43MlKlmxCYN0qzrPmKtp21Li4og1bH6CvaReD/YqRTqEBZfpkG9NK5C6fR7sMQkMUN/SC5elFtWwEPNTiWMTwnw5tZ5q6Vn/p9nwCtD0C2tjKlV3SOHon3REg2gaY9YV7/NYrFVvZ3Tb7wGUG6lUjtbv+EbDNDaO9KrEqS7WhU6XIkNrZVqjxMOn8y0GYsFSYioyhXBtCssu1nXy0dnk6iuWcSJpuc1b3/2vXez3+6RFQkltPP5fA9oEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(8936002)(2906002)(66556008)(66476007)(478600001)(36756003)(186003)(4326008)(16526019)(66946007)(83380400001)(6512007)(7416002)(8676002)(69590400011)(2616005)(26005)(52116002)(86362001)(6486002)(316002)(5660300002)(956004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bi9ygCOpYhx8m6rpEVCELbAv46mqPKdXTt7ePT+B6bPAiMIlQnjw9/V7kwn/?=
 =?us-ascii?Q?GRVvWSy19BkIsgu3a9C651j4mNVQitkr5R8UcdkG2oDcESjMRQNZPbfVG8Q1?=
 =?us-ascii?Q?vo+jAliBlYB2CMCTgI8n9IpFdhvgGdNSCkYxSisINfsFvQ2rL5XQ6T0jUI0A?=
 =?us-ascii?Q?LH8REkQd77wxR8Wq7VVOSWp3g1xUrgeIs/bM9PTDB7uc2i80HOQwthc0emZH?=
 =?us-ascii?Q?aj0YYRFElhxO9J6+WpJTbcDDDkBiKMwAgmoNDY2MqF/MqcnIc9jHwXlYtScz?=
 =?us-ascii?Q?vbz1PitCpZLf3m8BNM5lKSQrmKjcCOB698QCrKqna3J2xtqhT5A/A67lv3zm?=
 =?us-ascii?Q?zclO361Pg5Lchi1F1C3l3TO0t3PoFaS/uu/3M5ylJCrjBYKOvXMqLMK5qsw9?=
 =?us-ascii?Q?A23e44eR76jsFo7s5zRBiH8oKVSaxwFQlVbHzktjcGKkXBBLo125l9wCsMwV?=
 =?us-ascii?Q?hZM5NBLFxhUOYsTKetak/s5dfeIaWRfRZIkjSOdM0U3h8OCTy8MsOv0Ck8X/?=
 =?us-ascii?Q?TmTwOZAdtSe8cV4SdtzNFqz9mqCmeVR7FMFlBW1rUgjH0I0RTvda3hnW1l1f?=
 =?us-ascii?Q?XJ4/hukmD+ai6yfq+YW+ggFWwEsTJ5MH50hMaM2Ft6HLrXfIxjBlu7hjrBfx?=
 =?us-ascii?Q?PuhiM/4UpkzbON7zEWtNs4Hw5jhur96nnLT7SGXgBhqwTMhtP1tk9tUbTvLE?=
 =?us-ascii?Q?D8jYx51m/0GKOQK0mIG9vPk9BqBYg1zELIj/7S03spzF6IdKtsOOdmVL+F+j?=
 =?us-ascii?Q?aJMeWPHlyfpSWSpx/RfrPLwzuJ8lB1Io0wp4gc45u2ePq1Bxo0dRftyFQgiF?=
 =?us-ascii?Q?uOkcZDSgepGHuWT2XqAFPViIYX4ZD78ZH8XXyMTo694EuZK5Pmbz9aeRi066?=
 =?us-ascii?Q?xzaJdSz7R94+wtQjxqWU73fJJnasvBYIOT/KcU48FWt/CJYxwLkFiZIK5vGj?=
 =?us-ascii?Q?pPqeM3B3xqNSRs8NY6kD3aT+sz5UssQuLVAZbHNw0c5KYbSjEt3FBz2PAVgh?=
 =?us-ascii?Q?7a6L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a054a40-afaf-4b66-680a-08d8bdddb9bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 07:25:28.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnTbB7zz19ssmKz2Z5VU6+lm2hQsoqW4+0kA8rtC3FI+GeThod1uvXVwB5KBplqYj7TtKf/LFRuOIXYoVRes1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artificially use 'plane' and 'old_plane_state' to avoid 'not used' warning.
The precedent has already been set by other macros in the same file.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v5->v6:
* Fix commit message typo - s/Artifically/Artificially/

v4->v5:
* No change.

v3->v4:
* Add Daniel's A-b tag.

v2->v3:
* Add a missing blank line.

v1->v2:
* No change.

 include/drm/drm_atomic.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index ce7023e..6ade7a1 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -908,7 +908,10 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 	     (__i)++)							\
 		for_each_if ((__state)->planes[__i].ptr &&		\
 			     ((plane) = (__state)->planes[__i].ptr,	\
-			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
+			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
+			      (old_plane_state) = (__state)->planes[__i].old_state, \
+			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
+
 /**
  * for_each_new_plane_in_state - iterate over all planes in an atomic update
  * @__state: &struct drm_atomic_state pointer
-- 
2.7.4

