Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECF2CB48C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLBFmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:42:15 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:64484
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgLBFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:42:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNXKtGdeT3Bknsk3u7AAqaaRZCmTmW/8mYjmZGqt9IWwWJxER1zvYH7PR9Ry/BJ7P+Cq77ZLZ/1nzE7ENLFifHoZck6sul9mzNTGrUqJprnsW1tL5SNQMxakRHsWUskzZkAP2XNXArCfHvRzqA/WX7QTDWGLMPHXpcydktU2vkmNm8TFHFqIWx4zigG+zm3lmEAaTKQ+ntCl0InSk8cIbPfLVX7e4sRxgs0muF5QIWesWaj7T50WCyjVxJ7mLnucznTaYfwD1h7w6JGSlZPiMa2W5Hzrxh+EOfPGJ5c70bcn8LbO6Q1RUBEhDW6gi/nofjQiWiAL1OPCuaZEAxLJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AboUG5hTPxCRp6RYFh+cuIP1xq21BuJDQp3067OveDs=;
 b=hO9Pbc3QeN0TRHAuBXiXI+MUY/GZhK2NhLwOr7AGyzOPaWSmMhPiuo0e5PW53rQiB2wEKyswysLaFFQaF9gcb4h/qtO5zaATMpdNc3sYl2deqekU6VGP/EZCawuzfZKu/5IjF+YIho+EL3dwRkJHDtKUudP3ODJ5LTrONu5q8muujQVdzAI5q+8JqiPZBanOZO7A9W7STIwL4vxyTZUBAkUDkclLd1zvS/3YXKjX/EdxyQY/wesOwPqtqAWdK3Q7zrG7Xe9vHlIGudDvAAyy9X4fHF7aVshVnrN8AioRZMK853yEjkrFIPVkRALjB7J4EFWUeLyYCfKXvVH8AvA8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AboUG5hTPxCRp6RYFh+cuIP1xq21BuJDQp3067OveDs=;
 b=DldHR65N5GZVGe6dmuCRYr5ba4J9BglGMn827782jJammXMIYHwNyQyg/JNbbgKZoJ7UgXF+REr0D0sA8CJhvO6GYHmks+GnqhuMoIAoQPa7fTWmVGPVcxRX7bcrPLdG3655y40A+AtwhiWxGUy4JPeOHJgAM4wDMnkKrJh9v9M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB5184.eurprd04.prod.outlook.com (2603:10a6:803:5d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 05:41:23 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::dcb7:6117:3def:2685%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:41:23 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org, aisheng.dong@nxp.com
Subject: [PATCH v2 0/4] Add some clocks support for i.MX8qxp DC0/MIPI-LVDS subsystems
Date:   Wed,  2 Dec 2020 13:33:35 +0800
Message-Id: <1606887219-5854-1-git-send-email-victor.liu@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3632.8 via Frontend Transport; Wed, 2 Dec 2020 05:41:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfc1e6df-7019-447b-2e2e-08d89684e6bc
X-MS-TrafficTypeDiagnostic: VI1PR04MB5184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB518497BFC8FA930669651C6798F30@VI1PR04MB5184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGjbf7EgCvUIcD6OQ3LlD80LUDYoGWuLyNED2hBgmpAtsC/fzvbOuB8O30stX5u7z/RUfXdp+ImQiJpoPrQHdqJoFgtyrpWEYP9sCikJrc9/gV+leLMj9nUKrOaUOTAJDbknY9O2ToiS6YQTmBiXjF8JakqPP/yUBEar1wDic56ODHHktdkDBl+8glDZLLT0IrnyxHWTf4VuKrCfpP99ZgyYYiiR3lkb7p3ZYL/S2T/eP9jMpcSVKCpQxBoCSKclIc262sMSTEC6ogPV7rZvXdaxaZ/kKU0wRAl6G9EaFEoE5FjXVW46C2bCzv8Lk64ZIgRRoXs3VvxEop8bVM5uD47wQnwvT3/s6xi3FVCREAxgwdhji3UWumcZgc66khT7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(4744005)(6506007)(5660300002)(478600001)(26005)(36756003)(186003)(6512007)(69590400008)(16526019)(86362001)(6486002)(2616005)(66556008)(316002)(66946007)(8936002)(83380400001)(4326008)(52116002)(6666004)(66476007)(8676002)(2906002)(7416002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sVldsF9zuQUWCvCy5zP3bIhvO+foYQLCVVAghQASttE0Ri8jWMq9XzKh0yUd?=
 =?us-ascii?Q?qDgoDRuVITOzu6ALT8wNcmrBaNB78RwttAy9d2dQBoV4cxu6VcRd5pjO9jNa?=
 =?us-ascii?Q?dwYbhiKx8Fu77riOkg64LcMcXqDNH5BAnMPhmLE8NR0Mdju5ON599XXvLTMi?=
 =?us-ascii?Q?MFLkTnIwhvN0Pr8LpIpn/sbljd4U5xmK4wue/Jfsv+FDIj1YDKIewbThphIV?=
 =?us-ascii?Q?Yfuk9WUqsM7ZeG9l+QNTScfMBzcA76TQ2hxmm213m9SuTuLD9jq57zqC/yqE?=
 =?us-ascii?Q?cNyC7j5IcjqfThUqs9Bqr7wf7q1/6f2BaUhSvOAH6m4zapx67HUF1VmBb3hD?=
 =?us-ascii?Q?tVwwnRurxgmlhI8Qsx5KD48RyXIgT1RgJJxkn2Tg8gw2YTZfUpmlxX6dKINj?=
 =?us-ascii?Q?Z7qITT9fhhhlbS3GN5dD89svLT53EqGm7nqixVQ5IaB/1CeZRhxqY4Gm9HW3?=
 =?us-ascii?Q?DTjR7bBzgAG4VJmLPr1ZKl/F00Y3PVtEnXd71sACTgrp7wW86fie1ixFM+Wz?=
 =?us-ascii?Q?9l1lHmHHUVZJBC1j6Mxfnw2H7UGwMtBBMDhYF0D+/Vm8SB8wypId6GoXnq91?=
 =?us-ascii?Q?4olrkLx9JiTG6hYWc7KuM0V7FNgDHl6a6UtlA39m2v+YmTNNyFONYrxOd+O6?=
 =?us-ascii?Q?R69y2Vt8dV7AWzLOx74Rk4KLJOjY4GJCvXFdj9axOcVm7usPGUVZLPF40Oit?=
 =?us-ascii?Q?ARjZuz0+euoVsZtchEX24myf8YPq9J6xTc3WGmP+Ll9N8zfS4UQr5jxw2XhR?=
 =?us-ascii?Q?mNyV4xFI5W2mJ3+wO9bgDWc4yi2obGcLx9i+qBLmbGqu3tAWd/42C2ixgxrB?=
 =?us-ascii?Q?X9DYt53GVsSzasx0N0b40yrFDCtfiFJTkTu8Sy9/gEJhwKc+ZW2j/P7eV6K3?=
 =?us-ascii?Q?xQ0znLsj12kz4vBeM9OCKAVUa/9Wd/fEUXPRRGhVFmduzwBvDSbClKYOQePe?=
 =?us-ascii?Q?ujjFqBnOlKdTWzvNPhckhylJB63yt9W5UXqXvSkMWoo+5IM1JlHSUJbYmcNY?=
 =?us-ascii?Q?08gH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc1e6df-7019-447b-2e2e-08d89684e6bc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:41:22.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sKtHzoz5g2JNfR1xdPFLmBVa0BqBxWg+6yEsKCZnYUxJQOvK3Esxk3VZwDcG13oggM7jc1P1BEnZJPXS5WUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds some SCU clocks support for i.MX8qxp DC0/MIPI-LVDS
subsystems.

With this patch set, some basic clocks for i.MX8qxp LVDS displays can be got
by drivers.

v1->v2:
* Drop LPCG clocks as they can be registered directly in an in-tree new
  DT binding way.
* Add DC0 bypass clocks support.
* Correct the way to register DC0 display clocks.
* Trivial tweak.

Liu Ying (4):
  clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 PLL clocks
  clk: imx: clk-imx8qxp: Add SCU clocks support for DC0 bypass clocks
  clk: imx: clk-imx8qxp: Register DC0 display clocks with imx_clk_scu2()
  clk: imx: clk-imx8qxp: Add some SCU clocks support for MIPI-LVDS
    subsystems

 drivers/clk/imx/clk-imx8qxp.c          | 26 ++++++++++++++++++++++++--
 include/dt-bindings/clock/imx8-clock.h |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.7.4

