Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE752A5CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgKDDHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:07:02 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:58081
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729078AbgKDDHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:07:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko+3N5kUKEmZJQP3ug8v4ZkcQ89I/6Lg6Oj28debAbEpwO2101tiGzW3K6FZcMX4nmttI/S1GvaOQ0xtGrtVglUZvhGNHsNPEAJjLo0WEWfWXDJVOOpjpKn+xAcuZe32IqNqoXbpRlVKp2+Dp4xWlmrVaSt/3DU0tI7RFYbJlz5tHyqEG5ziq67oGWh92tVRluhdOhXTcnD6pBh33da21QNQgirSJPRHHuarYhD92vSKPpSw9ol3sDlUextkT/Zq0s32NGqZANegErryWbw+vn3s2e549s0l34nUQy62KkH0ArqyAm5syUenFRQ6F5PDGE3sqkm7K6eGqNzOzGocYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcKvd/UaKkqiJP0lzO3I0WbpOCZnQFni9dKA1B08MyI=;
 b=kOlsrvnWw2j45hO6YBo8Fi2IkQbBkBbVxap+5MkNxgKKNx2F+iGelRzywYiBHODjF2b1ggGDsBmifEWeXl9d1ZrLAQs0WNqSy5gUd87PYWiopFd+OrrxBQKjBxkTozRJ1gnY3JbhyJjPLvVuv0yTP2Iht0FcLFoKLNh14uJHqDCm8Ot/qD8Oh+KxCvah6EPE184wSUi/vZyQ/xE1LbCnOKexXga70MKx0I6QFS2iOvDw7aB1vQvh2DPj1YkevZ1xwNeUa0AXq6EmJnA3pGPtsWXS7o7ialomtNrn5gJDhaJ1PCcCerUe8YlcULANci9ue0Pky5ov9h+j4SZeWTfwNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcKvd/UaKkqiJP0lzO3I0WbpOCZnQFni9dKA1B08MyI=;
 b=ZCrTlcoX4t/Zl1bPQ1WtGk66r2oPL+EsPFV7gQ4M4JrKnuToqRPHAqv5f2GA6G//oXwNIXy6zm5S6bwhlbN1fl2dmc4pmWPmqCrFOh7YgciZy+lTATVSvcNujb2eLkNxVCd48v1F1V5IodZc1u1BB5DJw5VNAvV++VXujJRuPK8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:06:56 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:06:55 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 0/4] change drivers/soc/imx/soc-imx8m.c to use platform driver
Date:   Wed,  4 Nov 2020 11:06:41 +0800
Message-Id: <20201104030645.12931-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0225.apcprd06.prod.outlook.com (2603:1096:4:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:06:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4f08d4d-0c2e-4bd2-9c3d-08d8806eaf8c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7365B0A1232EEFE52D0640E7E2EF0@DBAPR04MB7365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uO9UrmqthZvBOZlUEmj3uPc0LOxFVUpPEKmUSkdPF2DZ8XuVDE25rVeFj/CaZ1CoMgfe2o65zBSlf60Pov1E6eDytDwqVD+Q3At69ya5LdkP6vrrQprQNnQHXzgHUvBtfdLFg9ZZ1bpa7IgiYe+vNAoV23mcCfuc5f3+VT39N8uLGOeBFxZSfIlPQVc20qC8Wmcq/lBCjc/rdXEtCEyKWeChpBO74IHe/SLxIxrzIYO00zOfnQJfvyxmasfuw0R56d5tZU4sxhR+cu5z6Ta8fcd7PS6b8Hy9xcMwBSCzWVsrhkGF3P7jhsILirUaDB5G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(26005)(6506007)(2906002)(2616005)(956004)(36756003)(186003)(4744005)(6666004)(6486002)(16526019)(478600001)(83380400001)(8676002)(4326008)(5660300002)(52116002)(316002)(66946007)(86362001)(44832011)(8936002)(66476007)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hlDLKQVRjLw+pvBjZ56CnqpEK7U+5xNh6l83ozfGSSpcKYM/Ih5QjFgjyT50EekwK2a0FWqOD6K+FUYwqaBT1VhSdqd7jR1fo6n4hL+al/uI2l24wroh9r8qfQypnnF3e7Qck/K9d+vUie/E6XaLYK8Lirqv+WR9XAgat0S+HPNgIU9vHybgw1ppEGTbklYU7kPJfO0qSm9Ro19yx+7ucowmGsXTZLf1ht+N2/+0vlAAO1ltM1n5SvFWepVxmbbXjydgzQzFro8quYU2oBisQ26Bha/OpzkP6gufRjTE+dZHicI8JF9s0nHV7a4wK1Q7LlFugKdEYbiw4/fH/tS/xMYP322TMzhjjtNV9zbD+82Y9ZGN6hfC9q9PjPtMAMMtA1PTQuOCzc/FJ4yga+TQ+kZ9ERIeDZLRTFMLkfdYEgBo+2DMXZBA40Muzud8oybFAfgQP32nQTEqALVhOOo5IMOpuVwP8H4EoRCRpJzdxOIX6NoymGRJS72NDWrT2PRqQ/QoxJtMQJ8cqAZorNjBbc0/MeIfHxFiJKMNt20o6xGT/BcA1w25DgN8mynzkx1g1dxclFOL3oKaVsURMG+dZR0GQsfIJ/52bCyKjuW/rSDxEeu2TRnOLLcqHXH/Rp9VxFkAodEoCYH1i9WxAjDLdA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f08d4d-0c2e-4bd2-9c3d-08d8806eaf8c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:06:55.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6bFFulrFrt3Ej7BPrBkVJb30J+pQ8ckhRBi2MzcG7nLEZSK2yHGQ7mz5wzJWBEH4GGuuGVA6gSuiE1RBAaCFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly reading ocotp register relies on bootloader to enable the ocotp clock,
which is not always true, so we need to use nvmem API. Using nvmem API means
that driver defer probe needs to be supported.

Alice Guo (4):
  LF-2571-1: dt-bindings: soc: imx8m: add DT Binding doc for soc unique
    ID
  LF-2571-2 arm64: dts: imx8m: add compatible string to .dtsi file
  LF-2571-3 arm64: dts: imx8m: add nvmem-cell related stuff
  LF-2571-4 soc: imx8m: change to use platform driver

 .../bindings/soc/imx/imx8m-unique-id.yaml     | 32 ++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  8 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  8 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  8 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  8 +-
 drivers/soc/imx/soc-imx8m.c                   | 75 +++++++++++--------
 6 files changed, 102 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml

--
2.17.1

