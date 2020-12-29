Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9323E2E7083
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgL2MKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:10:45 -0500
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:49409
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgL2MKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:10:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0+EhZ3r+E66TXYOqpK3wFNHvfq9sVsWJKaD4knDRhiip4OZMKzT/h1zEf1jgInW5BX+zGMnvchIMvemhKReJvlsDTVxfn4/zisLo8Muq6W9hDi5Zkdh0KsGChSXzbQTtA/xctTjdFfsv+BMlmTVse8mbT0uztvsJ8W8KsX21BpUoQFTH/Awz/3DeOPrBFLFay5FWu9j70Q1UQODqEeg2C+IxI+hhfzrVeLsd/njNvOwXl7v73VwPS9xcDbp4E14pK3DuGEj4/t9airCMG8vHCF9sgUvddw6YCgkxKza3Pi/ngJzkRyqVbnMNv12jWxOpz+quoF0oGkj1tA+443dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrdX5qQC0bDMROMzITwpF1um9Ec4pjifGKg5kLH8/C0=;
 b=UYoVj1XFYohJb3Cp8p/tHjGhHwqSRvtiioMNAuNX5UNbBigksyw/UJJEDRZFMS1GyHZeRduKfr4sN/dRf9zUGvnGdrgdn/Cn6Vfq3p6u9dhlf0EO+9Mbuo6gvr9O0RYd2+r2M9mgZk/HJbbrXLB/7Q576W1L/GErZBsau9LnuJTJZqtruUP0r0WFB9/D4OMOYKlLX3ZN/YSjpdRZ9K/gukVLOLXHaR35d4yrjEZh0177geHrHaONZ5eCgpFqd9r7GX9WefIHHkPdLfnC0cQp3yl7imaIHKWy72Hzl4Gjp20M6TIAQbEPiqN2f4jD15/4xevoy+tqOX6mZvRg8x6l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrdX5qQC0bDMROMzITwpF1um9Ec4pjifGKg5kLH8/C0=;
 b=f53WKKlfXo2YubD69HC4bSKL2zhduGcMeK+vQyUr5RN/H8XKnJ+DfZFRsk3gU0NKsYpVTuJUdZKDWulYlO64mLW9+S20tXonX8lOlDXChpFA7HgxkiSsg+U7HPtxtJluF2uxkgYdA7utEufxe0yKiJUAeDRVh2Tbd382vUnIBBw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2533.eurprd04.prod.outlook.com (2603:10a6:4:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Tue, 29 Dec
 2020 12:09:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:09:54 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] arm64: dts: imx8m: add spda bus
Date:   Tue, 29 Dec 2020 20:00:41 +0800
Message-Id: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0161.apcprd03.prod.outlook.com
 (2603:1096:4:c9::16) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0161.apcprd03.prod.outlook.com (2603:1096:4:c9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 12:09:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aeccf346-8cbb-4940-b4e5-08d8abf2a736
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB253362850C9EAF8AD83C398788D80@DB6PR0401MB2533.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GE30/zwyi9fx+CyZQ6qyiLJst5ttV7L71m9pI/j4ZKXGrb+YRbDOnqS5msUq7jJTVqLcVYtmnxqOFDVfH6V+0qjUahChXe2HsQVLzfSHAW8PFCpJld3/bM+mdxidPYCykp9jTfqRzlAslxGl2dcWPtFmHMFqr4khT/YjNiuXp0sf//ubgRRJzXtTPzLWAt0sIPGlJ9bhoA3+lGIZaO5UQu8JWO7wqnUaJSZYVMtJXxHI6lZO+VliFawp+Zn5q+U9hRgX4hTT2uB7bsX4aT2Sfy/KIiQIHgof7aGmRBQ7VqNGg1o53baUl2fMrDHM0qUCwV0nnhSFBfLCp0+vhEfJAsUEK76VxyOrxuQrTj8q0UCO3oTEZyKkZcglhodQu7TiBexX7pxl98/ctCZi+/im91LtKHSRRJyUXwYKrGAsNclwQf1YIyFGQDYA6v0moe+CiN2bBY8QvDm2HHXSSSXKRJae59bcSMBzk5NCU1tDiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66476007)(66556008)(66946007)(86362001)(52116002)(5660300002)(4744005)(2906002)(8936002)(26005)(16526019)(69590400010)(6666004)(36756003)(6512007)(8676002)(83380400001)(498600001)(9686003)(186003)(956004)(2616005)(6486002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+yPoRMAxpolMzsH0WA5fEldB4R56Esj8ze7y/C+163M5BqayFWGozvvPiVO+?=
 =?us-ascii?Q?nYG/3uD9HNTKKQtWdlyQwOoA0ZjMqB+Ar7XFqJSZLsdbq9thLPrYwt0faUjG?=
 =?us-ascii?Q?Wi6trrowlApnez0AJXq5K4jsPZbXONf7qK84IeNLr3NGRKHsTyzLCYoLRc2w?=
 =?us-ascii?Q?Mv1CVae8eft8LIwdtMSMixRo0CkN3A9os1Gsp61LwABZsW8xK5okWzO03aeE?=
 =?us-ascii?Q?kfOw1ovCVVQDbmLxRPtmZQr/6QuzwJBs+djHyNDCWM5RmjdOuBepz0GKQG0A?=
 =?us-ascii?Q?hAZTZ7v4pXJssgmo90YXW1HXNUj3eUdUndtsHWVrKrqRnhMeJ0EXnWjCDuFe?=
 =?us-ascii?Q?cLdv2CDPuPMpQHPZnb/Jl09NYciJAjzr83/Y8fECTwp/iGdtqVvfjZZ8+g8Z?=
 =?us-ascii?Q?bBjbIYstaksAHS0pLpx7rsTJLc65CBZE30vOeb/09biDXIkTHCwAL4/XCqLZ?=
 =?us-ascii?Q?3/mAuehT1BxN1FE4cyENrF2ozWJrgnUe7U8gRRgrTyNb3YYCdXbSic1JauLo?=
 =?us-ascii?Q?/IIltxybJD2wr66hhjcfguS7YOHNlgxuX2Obypyfj4Tp2qfr4wbggiGZJ1Zv?=
 =?us-ascii?Q?reFa8SpA2vvUr6VIZnVkjVsOH6PmiQNqAdQI7FcKBwuSlgnWoKDZ2IJqlK48?=
 =?us-ascii?Q?Yu9q9DwX0fqXoTE39nP+W18oLtx+RFWmICm4xckmB+OkCbcvyPqYZ7YX6wbb?=
 =?us-ascii?Q?mGUhLwP+v6Z2Rdh5cy8zc1sKYqPsSNLaLHBJMB98zUiStRE/4KQ3dEmi2GvP?=
 =?us-ascii?Q?v5pGBVjndrMk3biAB5VR8JNQZMS7oFmcnQbN2v3pMreOUjlhz9wccOBL7lJl?=
 =?us-ascii?Q?XPpKGIxa8CHxDiyWeo8gJGHlYpF09HcV4qo37XESUlA5cUWbJEtqaBpr/c3V?=
 =?us-ascii?Q?piIVADqznTYVa2WXkJsu7csRsKoCh6r+HefDjmrFmaFDfkgEfqZo1b6bjo9Y?=
 =?us-ascii?Q?ARYeO8Wd0guzW+jxvPzYR+QZXbjIRRSks7H0t34Xwn5zU0tqSwp/FcqScQEl?=
 =?us-ascii?Q?2SLy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:09:54.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: aeccf346-8cbb-4940-b4e5-08d8abf2a736
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/oiZWPrtv/YErEEfdZIp53eLYWdPGDRW2kpKgBUNs329RHrsei7+Q8SShdoojEeUqbcp+z5Ofdc8ceikORf7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is spba bus in aips1 and aips3, each spba bus has some
peripherals inside, add the spba bus node

Peng Fan (4):
  arm64: dts: imx8mn: add spba bus node of aips3
  arm64: dts: imx8mn: add spba bus node
  arm64: dts: imx8mn: add spba bus node
  arm64: dts: imx8mq: add spba bus node

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362 ++++++++++----------
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 146 ++++----
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 386 +++++++++++-----------
 3 files changed, 467 insertions(+), 427 deletions(-)

-- 
2.28.0

