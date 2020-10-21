Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B4294D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437450AbgJUNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:15:42 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:62253
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388975AbgJUNPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dASlDvF/kjT4eHO12asx+dBX57KKuX74cjcHauokmPBSnWMRDJskRsjtPnlw0/Iq6Xs+6kPJtpJJ4PmiEbgOfyuY9fF1s+iZw0HdG+F1YA/JWe4PKczIBXaW+y7Po7j0FohISPKfWAAB2dY1ZMI/SYHjROzxfdoBTbE6zfsXQpRxfqvn58mPp8mX+wAbWpatnKXSERWB5ymqN51LpLjDygq6POd+dPVil/yTphWML5/WUu9G8405BG6buQoLIh40pJDQa1o8kYUwFcnOIjVs+Oo1khmyNw3KNPBsNFDW1WKQL9MQZKzXNKBkzhJo2zWTGM8CcnwznF7T1ivSViLQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyD2BLpWkmy5KcsCUklteN89Y1KhkgRSxZUoriTxCzM=;
 b=fIfChzvNVuQ2pf+FJSxvVhXX9qWMp5Tdz74taGFKa4KfQ6TPk6jKdfhuRXg3ctZMu5GX6yhZ0mLy8AJJe/40hY0m7zxA84CqBkm8zO6EUpEkFEFoLIX3mzAdaUqCgu+k18brdH/mdB60CEhm7b4xgM/VvzONmcu2XFng0u0eRHOi/HrtBuLCBVgIbeuMARm0+RXU5tkdZXu5uEAjYTJ23esi/xK2s2T/GFrfyyh5I6q4n8iYH8rY6pdIY10h8H93e03Nk5/7IjSdPUxLlYgDFCZX+LveqK8CaM0BEaLtQ7ti1tLzlY8AlrdaS74LouFUjSkRmPVS0DZvRDhuEX5lDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyD2BLpWkmy5KcsCUklteN89Y1KhkgRSxZUoriTxCzM=;
 b=Q3uk5CdjTsIeZocSj+azTcCVuhRMHf7C7bI1G+ok8nkFGuovQ+0AXSe9ZxRRoNX1oJbK2MJMM4VKbkLeqHCJkf7C8ivD/LPuL7pNSA48giBKt5bYwl95/nfgVdnroAL6dvv/a7yFsInCrf06S9A5AsSIEilTFzAbySPP8qUb8BA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5995.eurprd04.prod.outlook.com (2603:10a6:10:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.26; Wed, 21 Oct
 2020 13:15:37 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 13:15:37 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/5] clk: imx: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 21:10:15 +0800
Message-Id: <1603285820-30196-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0133.apcprd03.prod.outlook.com (2603:1096:4:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 13:15:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 111268c8-99b1-4f98-2796-08d875c3662a
X-MS-TrafficTypeDiagnostic: DB7PR04MB5995:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5995BE634818202470C630D1881C0@DB7PR04MB5995.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMdVQ+9PMuvfIvSJy96aBblqdNsAC90JduAc2PhE3ORDq5JsA2hmEs/OFcO8wWNw2VO5Tq0LFl18KCPQGiXySIzJ7zm1tx/3KMq0fuqUWQb4Gt8N9ALw4YrzC9nhr5I8O87/Jo1u+FK7kn8ksz20DMAqL/tMXkJYtbUFkebQmWU3JHmVTThSTVKpopFdDykxK/CMwY2wVjiAqb2ztEP1fhbIP5A8hHWqAAzQZ7TuPk3uHuMOLG5APUyZuO5dnuASm7/jQrVgIMsc2pIQnfIGooYO5iP5pF4yUINlONgwH5gZmKWPT+juVTiO8OPNlS1+jpxDMFoK0tR9/8qmBSqrW1BbCcm66uNDw3QqffrkP2tEqKITWPiJa7vzq/H3Zm3wir9d/Sba/dIa6cCJbBNYhm0tsuxg/WxYYmTx2HhKUK0HUBcMcogkoAKLPmw2Q16RlyDq5WaJnQXHEspameBhog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(5660300002)(66946007)(4326008)(478600001)(316002)(8676002)(36756003)(66556008)(66476007)(52116002)(86362001)(966005)(6506007)(2906002)(2616005)(83380400001)(956004)(9686003)(6512007)(6666004)(186003)(16526019)(26005)(69590400008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4DDrvwyR5u7m96p9iZNUHh9NoYCkuUUMoR9Rf2YX69qEmbqODsZNxBmZmJbu/PtG4D/JiBUz63NsK7RDvul8caRFd52G+lWW2pEvG/eHbPVQD/meZw/kgbZBqJT9DqOJPZ+iMAFhQBEqErG3w3Knl2JKVwTfNZ6tfmpMo/16XFHgaYBQjhXm/xjf5ZWqJtjwTh5CXlMEf7W6rmrPo/nHE0IaOyDieeOaw+oivtrN2kjUnz0d5KJyV5906kUMVlKgG0oZPK2qCSxEthav6EBCDMrMF6KKVD9RwnK3C1NGcTkQqmw/tGb7YbbRUGVD+sAVeefIEbSl9jq6VP4k43lk3kXCyFX9UhVgBL9KGwXPheU5bJiKQXkoGwJW9oPGbVaGRpJWutv93jr9zfPKZtJbLqgc4X5Ul0QFC72anh//vER/CV93Z9pQgihMHpKwRxSElt4dfISfkhFvNoqDi4i7SAoRAviyGV4AhYkV4/fcqq+7cfD3RA+qxxip/7GvTATUjcrp9y6WTUxujuwICef98VcqqvdrWm2smSqS2d3HwTyTNJpmFgRFaOU6fP49vA3pLo20sHLkKsazSX0yXr+5fYml66+wcwIFTr+t/QWInIVgsvXFVxSgLsXoWPiUS3O0O27EyqkKw5e7p0d8c5QNFA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111268c8-99b1-4f98-2796-08d875c3662a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 13:15:37.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEfTXmOVirIo6N1RhvczbmrMRd7G3Cj/sC3zIM7ngZrKo2zFNZfh1R6K4lwjof+lYyAxsS9En7aQi2ojD5nh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
  Add missed Reported-by tag
  Add R-b tag

The issue is exposed by
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/
linux.git/commit/?h=for-next&id=936c383673b9e3007432f17140ac62de53d87db9

Since the upper patch not in Linus tree, I not add Fixed tag.

The issue is bus clk should be registered using bus composite api, not
peripheral api. Otherwise we will met failed to assigned clock parents error log.
Because peripheral critical clk has CLK_SET_PARENT_GATE and CLK_IS_CRITICAL,
you will not able to set clk parents.

We need use bus critical clk api to register the clks, so introduce
a new helper and use it.

Peng Fan (5):
  clk: imx: add imx8m_clk_hw_composite_bus_critical
  clk: imx8mq: fix noc and noc_io registration
  clk: imx8mm: fix bus critical clk registration
  clk: imx8mn: fix bus critical clk registration
  clk: imx8mp: fix bus critical clk registration

 drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mn.c |  6 +++---
 drivers/clk/imx/clk-imx8mp.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mq.c |  8 ++++----
 drivers/clk/imx/clk.h        |  5 +++++
 5 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.28.0

