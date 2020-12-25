Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140442E2B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 12:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgLYK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 05:59:53 -0500
Received: from mail-dm6nam11on2104.outbound.protection.outlook.com ([40.107.223.104]:62304
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729098AbgLYK7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 05:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIB5WZPFBvdvL/3e8wBPrbFUt+sgZZSEY9wNR8nud3qDrANpWnT6pK71jECewWoIU7fT4mmxB9Tylqx/Ix474jUERA8gJ1kw3kfL5uFOetb7ySJtOElLn3C780WfrIpexhK7GyDQ1ZqwamvyDUvZv7zh9rwPVAKpft5XBs/R6+Ne4BJ7EX6F0BXyb6Ex3EZCmRo/f0AzQZ3PcnDJd3k+PYVXd//3Xw1rxVnZiRedn1tKAMFoXv8KNw+uMWBuU/MF99+o0Bo5yV37p97LYsT+SdOaB1Hoijox1VNpkhUMUn4Wdthi2JOdU5xZgpNe8O7ZhzdzWR2QTUE6BxKW3/YTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB5dkbgC8duWxHUy8U1Z5e9DHyx6oyufLKga8RBNPz8=;
 b=dp3+/pSTgEBlGpY6FJ8uKZBS3MmriUSIWvFA/pDFrSrbnVj+2cA/Be/ckprq6309IFxWX+BgXS6TMmArYUk4CZRukGwSmgz9hhZYzKVywn4z9zYI3KoG1S8TvlDU9BugDF0pJpZqd3qsm/sTW9yn8as+6WFVZiu8Wje1m9m0wxfQYBCl7Z6ib8cxCWNHpQuUxLxmwxYA1tR4xb9kZazcpBW737bzQZ1o4w7gZr+RkY3R+jSmUTUYz+5GTDjqaq3pFwH9GFcpeH+UZbzigft5N4s9fTR35T1+t/8gPhDlxUiveiXaRJ5UvQDIP60UolvSmrFhVQEB/wROLKnPHV3Dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB5dkbgC8duWxHUy8U1Z5e9DHyx6oyufLKga8RBNPz8=;
 b=vlFnKb7kt5SDyJGljViPtKQgdSX56a1hKUt96mOMpFF49v3tXCKTKx8DOcfKWSqah9EyJg3pM9LOmuGo0+L9nlxYSKF+Q16v3+WbcKjTw8pnzOzUU+JNBPjESuJmF2Lv8tjNrLskD5n+wT6vUbQtXs3jZYbsrGhnfzeFSAp+jDA=
Authentication-Results: driverdev.osuosl.org; dkim=none (message not signed)
 header.d=none;driverdev.osuosl.org; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6788.namprd04.prod.outlook.com (2603:10b6:a03:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Fri, 25 Dec
 2020 10:58:43 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::441c:9020:2a79:3eff]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::441c:9020:2a79:3eff%6]) with mapi id 15.20.3700.026; Fri, 25 Dec 2020
 10:58:43 +0000
Date:   Fri, 25 Dec 2020 18:58:33 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Xin Ji <xji@analogixsemi.com>,
        Sheng Pan <span@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v1 0/2] Add MIPI rx DPI support
Message-ID: <cover.1608883950.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [61.148.116.10]
X-ClientProxiedBy: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-user (61.148.116.10) by HK2PR03CA0049.apcprd03.prod.outlook.com (2603:1096:202:17::19) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3721.12 via Frontend Transport; Fri, 25 Dec 2020 10:58:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a39b5d06-964c-4163-0acc-08d8a8c40b82
X-MS-TrafficTypeDiagnostic: BY5PR04MB6788:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB678870C720E82E144AB0F3E3C7DC0@BY5PR04MB6788.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrUMfecfqYVJnV8u3BQUkZiuUuPGqZDm9RHlooj0tDbcOHIn+SPT5V/LKyFAS4b9TCW85XckBrKpLRo61Rq8oKU1sA2cNhj9O7YJummvIS6oY5DAPT7voXQ4+YRpEwWtSQopKH5JBJGLyiSmxZ3+U0ASepHx2fHsuhpXMqNpaAdQwLqPyMOgyVWem87qKzGhkQ/4lPR0pXCnLwppslx30w2KsM0AqkTQvCC8GbCnfQ0WEtWVOPjrpNmZ02Ui2KuVfO615mIFXKwKzVSJLQFYtY0OwAll5eP4Ebxp6HPlKlCcrNgubwTRvdjKfAwdcxIoPIX3cCIJoL4SLNXl/9iSioka/WIx5QuzRZTQQtcGHvCjsnRTE++CgmvSxewbCeiISx546QF02hoMwItyyuiQkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39840400004)(8676002)(8936002)(956004)(54906003)(478600001)(110136005)(6496006)(4326008)(2616005)(26005)(6486002)(2906002)(52116002)(36756003)(4744005)(186003)(16526019)(83380400001)(66946007)(316002)(5660300002)(7416002)(86362001)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r76i1x1iUS/MFF3sBko3KZI1itLJFKC9/BTIZ4loOJfET30UKEZMeh4i7Hpr?=
 =?us-ascii?Q?rnH5+XtLBjP6GPU9criM2nnCSqSN7ymwbmV03e9lEiZUqYx1YAgSoYAZv9q7?=
 =?us-ascii?Q?TdjmivSHsuNJfHTbC5fv+nb1fqYbmT+D/nzRuCi2NixL5Mat+pxUuHiwvjDf?=
 =?us-ascii?Q?VIv3VktVXymQ3dALLHYwhf0SQ43cRYLzV9TgDkTGcjzFuMsmK8HafsqRcz2S?=
 =?us-ascii?Q?/AA4tHLoCdAxha7PMJarNJiDk1QgK5qhXAOn6vHfHfDSCXsaOvXcXN+NT8Lp?=
 =?us-ascii?Q?ChYoBB2styTWanDv265roadzTvl2GvLiZLuCdV6naTKdeunJDWoDARvBhBAL?=
 =?us-ascii?Q?64cWxtUqb7nqACweuVkM2pwGAT3SiKKPGrtyZChv1i4/QaCTdHtTzf/r9voZ?=
 =?us-ascii?Q?UsHkJv+sF0HuOhL60QBnzK1oc4fLCDB5EyKO79VGunyDvObyZ6pZN/NjrpVz?=
 =?us-ascii?Q?1PluGdgdbK87v9EKkLjAvjMprI1BcNSP/Ik/7E1aJAxRjLHqAYbLj9uUcJyw?=
 =?us-ascii?Q?wUzQHAGVsiZK65Rsidh0a1Y0qNwgaRBpFW83bzUJjcmix6Qgc6eggsHMgrSp?=
 =?us-ascii?Q?b/mIf/P9NOMjjFz57uwfJ5L5mohY0vjU37N3M5a4e2q7CWv/S82+UTM20Gjr?=
 =?us-ascii?Q?Vgxwat+D59NqJgav1lIkaK2TNDvJo67REklmIk/7Btzvc8USbVLDa9M0uOzs?=
 =?us-ascii?Q?ju2kYqEiU+jiOpaz9jPWY2646YWIdZyPyjgKC2PHsMb646XNZMejpRU+FU4w?=
 =?us-ascii?Q?iDwOhMpCP5MrM+99m9XglfrOVLRfU/RGyS0JsZXvhfqrkbec2KHhBwstnbDq?=
 =?us-ascii?Q?rGXGD6248YStsyCQ+eDfm9qVZbEITdJ8TAWeTHZb6h0ZBv0/R0W4vsLLYR7e?=
 =?us-ascii?Q?ZeZPOtr5gdawjzxj1FB7aTttL49qvUPxijq8T26+GTMJafu8rjbuRLWhYRWP?=
 =?us-ascii?Q?suD6xoWjnnvnsuiy34svP9+QvdFPyQs3kAFALiSZI+IqaSPd1U1mRJSObu3W?=
 =?us-ascii?Q?SRjW?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2020 10:58:43.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-Network-Message-Id: a39b5d06-964c-4163-0acc-08d8a8c40b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RciemefEtUHAA2EjCRi8Qs6X9V3YefyR0rZV/trr+jw6w1TYzGu827P/32dP7UfxeG0CB+N6yzcEbT6xJ8daBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6788
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, this patch series implement MIPI rx DPI feature. Please help to review.

This is the v1 version, any mistakes, please let me know,
I'll fix it in the next series.

Change history:
v1: initial MIPI rx DPI feature support

Xin Ji (2):
  dt-bindings: drm/bridge: anx7625: add DPI flag and swing setting
  drm/bridge: anx7625: add MIPI DPI input feature support

 .../bindings/display/bridge/analogix,anx7625.yaml  |  19 ++
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 352 +++++++++++++++++++--
 drivers/gpu/drm/bridge/analogix/anx7625.h          |  24 +-
 3 files changed, 375 insertions(+), 20 deletions(-)

-- 
2.7.4

