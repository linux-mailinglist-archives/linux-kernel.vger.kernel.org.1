Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A302A2303
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgKBCY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:24:58 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:19623
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbgKBCY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:24:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZzCjFHnxMPZX0J76N6aEJogx4ok+btcSDychAcTZ+LnJcq9ziRWwTQV4OeCojoeUBVVimQoztTAi07LoT9EIlA7dDTF6j0/xk9CITRaimholTUDe+aaL5KBlBbe81l04PpitBqA7wttLJSauW6jtT3x1jSq5YtfKaBYJ3vNzUCTZN5AlfL9gTfyxEE+i9Yd8HlejHOyTPImS7WkkwBt6BYW2YalaNhD0zMT6SFYFfTrkSS4i4uvfcX+V+ikbJXqohSAQ8boYM7KSV72UQov/yn1WvKRv9E/U/82GSLr9dsZM/spaovmrWBmrsI3wAZQXnkF9uaMl8kaBjKx/vbxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flXLY0uXq9eDXJT/A9R0SckRALR2OBIbCUeAlNHHKpo=;
 b=ZzF98BIjQMYLMbYUTu5C6aILTaL0th6yhShzxFXOCSlnLhpJbLEOE3nQW+0WKq++CoxeeUA+KxgLjoECVoJVQulTmutTmWJ5okMAp5LBVC5QUIvKAscPVAYq4FkgOutbwHuU/4LsgxGGO2NHEnV/wobzSrmoF72d7+kJ1GA7mTMivQevpN1OLdguotqdtobI8h8+Z53XQjgG33akYS0b6meCp4ga05YMj6w35Yc+84p/Qd2kxGNVHU3urOL1sdszw+gpGVK8o32qpd+yiWY06PXj9uwa9FZhPpFGvzquLHpPoe9fSoyAHrjkzLkA11A2mSaP8rwEQuNZrt27nu3P3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flXLY0uXq9eDXJT/A9R0SckRALR2OBIbCUeAlNHHKpo=;
 b=lzkLRhctzADix2SP+C59EkwNVnUKw9s2SbeYldPNBrUBpUoB+JKFmLqO7zdLL7IgI2JAf7hW1odguC+vjGNtQuBi2C3j2cQfzSyjfjcv0TygNhgox9TjKSREv3s1EwMIn7K4LBrHQeejWuoJ/UcxPho3t5nM2pu9QWFbhfjs5Is=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBBPR04MB7674.eurprd04.prod.outlook.com (2603:10a6:10:1f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 02:24:53 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 02:24:53 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: imx8m: add IR support
Date:   Mon,  2 Nov 2020 10:25:24 +0800
Message-Id: <20201102022527.14265-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27 via Frontend Transport; Mon, 2 Nov 2020 02:24:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 054145e0-6157-4c37-05ac-08d87ed67b69
X-MS-TrafficTypeDiagnostic: DBBPR04MB7674:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB767467FAF3B11B66678DD33BE6100@DBBPR04MB7674.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tK3XhpGUq4TrqvV1/COdYpNLP+DZW37FXhTSfFFstcsFxcKbHrXb/AbH0pW6gqIdOUZPEg7843d9qiPpjS77Li+1o/mFQFdJ4sMe313tsmF4I/p10GAwZCqeZInFme0GwneyfgX7MY0xM5nz6VbDRZEuNfH1lCZycELPd2PsCerlfp2+K6oXMbxCZe3CbM7cfokK06cEPqjFyuAPtNfBZUJO9tA37cZsQwzZ8taD1yhsZDMdCgarjeu3IFIuVvSoNpoWMnJpL/Mo8Uc9/0UzQs4NGOkUAUFERQ7CoKZf+aSS3LOu1Hc1Heefo9tsX/U8ULDKpLh+2VtrWk6gfLathwt87sDLNY6OUGDZsK+jlr7nw2yn3EqDeZjopmb9BXfrsP6Ip4BAGcV8JoIqYNJYHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(5660300002)(16526019)(26005)(2906002)(6486002)(6512007)(6666004)(6506007)(36756003)(478600001)(69590400008)(52116002)(66946007)(86362001)(8676002)(8936002)(66556008)(66476007)(4744005)(4326008)(1076003)(316002)(83380400001)(2616005)(956004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FHZQpSAm1JxR/KbLhqINU7/h1aov4q2JZFE48fiA5Nbk0bNdFXnCvCkqU9IJuOXuPy1+KUCyZ48J458nk8IY3F4eWhSzaF1Rp8mhuKJHL91lcSWiuAxqlY9mKszniP88NK/VtkiwrovJ+A256wmjaWwvqAt/WGrvtyJTkUXLZt2/leyVL2NZdZBpU/ec9WGo79Bkw+T4P33QfjxY1820AFxVkeMzUCNYbT0kWVpCDnHr6hIbz4yOyh+yqkIu0WvpcPA12oN5sOn+pdKH1MJSznrPAw8hKi35La5p7kEZvoWlkFFiKyg0wjeHET9iMjmP9uUvuCGeJ/kT9pQWkvJX4sZ9xrVGPgWyqJSLaieKfOQzPXh0bQr8jgo1BBdP5tz1b8++0YCg+KuQgGooHq9+5Z56/LipvqSs1qSKlYVXG0zQ8S3UNCivGf/eD+PRrJqbmh0XpftcJ9IySuu0W6vwl3j1x5XlbvcIjLrk9+QrI2WT9fsTpXvwhCxmmo38Ty13eWjRxMUE9XqcNzsaY3O7jRYaYQ09ZsnzrcBhzORgiXQNM19zcYtz76LrsuctF71741GWFWV/TVKhEs4XmogR3Tzx5KXgZHj+G/He4M/x7VWKQmQkggGTQvusmjmGsHybwo3GjLiGqp308Tim0hyr4Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054145e0-6157-4c37-05ac-08d87ed67b69
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 02:24:53.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b88s7h95DhCNTo2dv667msRp/exXhaxak7RNYnqNgP9OHH4wd0iqMr/K3/hilaNtIASgS9E7O+utFBz7dI460A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7674
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IR support on i.MX8M platforms.

Joakim Zhang (3):
  arm64: dts: imx8mq-evk: add linux,autosuspend-period property for IR
  arm64: dts: imx8mm-evk: add IR support
  arm64: dts: imx8mn-evk: add IR support

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  1 +
 3 files changed, 29 insertions(+)

-- 
2.17.1

