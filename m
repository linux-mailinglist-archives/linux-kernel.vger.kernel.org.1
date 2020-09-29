Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E827C1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgI2KCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:02:44 -0400
Received: from mail-vi1eur05on2060.outbound.protection.outlook.com ([40.107.21.60]:17248
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgI2KCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:02:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMrs54//JrX5AA93W0NZt/F3A9JKWWwn2xZEGDXuCmMg7nQGkAc3zyZqd8qjFgkOOHQeAAQewK2WaRJcE6Q4a8Mx22DjUd8Q3HXXhZoL2Mm05EteZyUJhB2ECn13gN75sAeiboNFSFiTJEbTnUV0+0BhsIKyE7EVkUYk9Q3OTUykqL0c4xJ6nr37EBcpy6DVJ2t2SHsMouGnMDIUy8TWGL5fFSgcs2F/YXoP3VxuEY2WTLZ8yX75AoxL7wkP1rmQC8euWgJZ2R2OTnPkppeMQNYjpcdbFduc2q3jt2BVp2y76GcZuxluok1ZwcbCsWTxOsjMZiLzN1WAki55X4rB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ree8aHAhXf/Ui/x7pMq+p2E3z6eNpT3rE8Eyb7/UfhY=;
 b=QiH3H/kWpbkHZYExpuBQrY1sn4zXaS0DIpZ3ke3engvZRMx4j2MEvpdkIg9hXQam/MKzBdRq22iVbHMoKlmO2TNCglmGg5JJqi/y5vB/JUGnmvqeu6+dH63kF4J5sJdqPN1F7Iu8PUGyuaxewD9H++QwuO84ykDO8a83LCluweJGRayUdQXpJOcxXSnVD25XA6458FCfK0xlkoRIXy1xN8pLGAqiWxqGKqVnqWDSW1hQklsO8MuhnWcPN1GMGMEBdULCvVFgTN6RuQoa3tFLOiBPF/97898jLDzPzWcnfsYc4RTmeLCFvw5+TZhrf1DnZoWa4p6LJTC2ByQnVOhxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ree8aHAhXf/Ui/x7pMq+p2E3z6eNpT3rE8Eyb7/UfhY=;
 b=bdVrV/lLSs+XGjg69v19A0GCmX8nTowpN6O8Dyw+U85z08RVefjWEgB2x5P7AWYT16c8DMS4WEpl4I6P8bIwZuqJAcs6tbS0DuH6YQjGbkHGJL8WzVvhzwd7P8Ouft0W1AX9fW5qUMQOItB8PbIdKUa7BMEN7bvTz0FW/aJCF+s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB5190.eurprd04.prod.outlook.com (2603:10a6:20b:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 10:02:40 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 10:02:40 +0000
From:   meenakshi.aggarwal@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, V.sethi@nxp.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 0/2] Add device tree support for LX2162AQDS board
Date:   Tue, 29 Sep 2020 15:31:56 +0530
Message-Id: <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM7PR04MB6885.eurprd04.prod.outlook.com
 (2603:10a6:20b:10d::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0005.apcprd02.prod.outlook.com (2603:1096:3:17::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:02:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e98579c8-10fc-4198-b09a-08d8645ecd29
X-MS-TrafficTypeDiagnostic: AM6PR04MB5190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB51903EB1B02900C12437DD528E320@AM6PR04MB5190.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlOGnIX6jCrrm9gxN6oNkDTITneJPwqwb1nIrnNckWN0mvoaFPgs/qn6SZLviCVSz6dcqD1MF3SrjUiF45ExIbVygHPZc5irVK6UyGaK+4MMTs81xTVfpE6Mxl2jPE5YLX1amZ2NWP5+ysX1pwYsam/YA8t8PRZWBsfSaFySk5c3TDtODkIFGx3ye/vu0XRQJfDUlgGX40cZ16FU5Xi1FetPyze37990sOrycjsFZdIFO2qK94G6dJIk3hSmcsLswYbE9Up4mq7piFN4U0a2M3y//ylmw1isurEBSukiankh1/yZVnh5e+CJxiqa1kkVakZ4fUXB/7i4skOApTIg4P4bw5hxgv6SOdPlY9/qNLy45Zeg/CA5gd4WbOZTJilWl9C6z4X80wrnx/xjzWghk3bu8Hf+ouZOkXMSQfALgNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(5660300002)(36756003)(66476007)(66946007)(66556008)(2616005)(9686003)(316002)(4744005)(6666004)(1006002)(26005)(52116002)(956004)(7696005)(4326008)(86362001)(6486002)(186003)(16526019)(2906002)(8936002)(8676002)(55236004)(478600001)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZAKKKvkr2XdjxjlXxXZd0ymhvW2VUyaPxBNnJUOD0h02vrqJZX7A40ZHpkSH+PMF1uxuEop+YagX/WGi2Co0w0IrtyvegMoGoFoIDpXD4uvrz7/h7JVaRd2hy2auboX/dzhpcIqekr3MRjPpuUx1dNY+WspzXnY+ykxbk6Pa6jLeE0EWwTjtsgcvdxjaudsqDUKiMDRYeHHKSAiJbla3tBNG9M/TP+PSWSrH5tt3QgjrV5QlchDWyyh7fLMjIqag2KtLyyIYHwMZLDnBi5FiM/xJGXh+BrdxQhz/PKSxzSerPqLa97W4AzvCWftCni7fFvs/2lbmTG64hAKgGTlm2zdjnqtm5arEmrDqCbxfLoogu824NwL/dqqajR7u2PpAjulBh75QpTbrpuDbZPttZ6JJBGbvJE5Hg4U2984kcCB+HZ0cRe+HkztDvSjE3Bf5lJuETT0Yp4Tpm9JaASXK6Rn0n9mldLYZNd62g6LdBuVeDBDPWjW+t/YNA4/mMdB4Ey7Tdk81wS2eXKagiSu12UqLh9lN0z/7kpORlYCt1u4V37Id1XIG2CCYLG0Oinn+JQeqrDJrsTVcebOQETHDN5IgDIhLCzV8MqeY3LEqz/lRFjTlKyueGL5lfrqr5fJ5Y0Q+EkMG6Ete+5MWeM19+w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98579c8-10fc-4198-b09a-08d8645ecd29
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:02:40.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UAOyQItJDl/aRzMRCzx74GZm8YfAPVDbtX8FtJw36JfhXEledfkdGKvvlV2QT3vKJiOxq/0UCpiStGIau5tt12WAngEw5M0lzIIIKXOIR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

LX2162A has same die as of LX2160A with different packaging.

Changes:

        v2:
        - divided patch into two, binding and dts support

	v3:
	- incorporated review comments on voltage regulator node

Meenakshi Aggarwal (2):
  dt-bindings: arm64: add compatible for LX2162A QDS Board
  arm64: dts: lx2160a: add device tree for lx2162aqds board

 Documentation/devicetree/bindings/arm/fsl.yaml    |   1 +
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 334 ++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts

-- 
2.7.4

