Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0670F2A5CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgKDDKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:10:14 -0500
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:8513
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbgKDDKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:10:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esWmTX21lT3sWDzgUiBkBsJm1xMwtYX/bymbmeDeQMppoUBDykhjDZhdKD8lhVTMsrnYBrovXtFIOH82p9UO+eVJhHj29MX/gInt7ODCKaAFOp6owSA9GRhWAFOR1Apedoj7WlNUyntLtct9Ejjtqg2+LGC+J/EK2oM6D+ePFNqrdqgd5gTsp04mrI9JCQf/BPvRnkL870LyGrcPlWIv5E83Ds1ZM/pUXLUxTUUz68La/g/RiCsDwxHpYKuSEPRhiAyob1bFySPZEdZz41P+Q1eCqdfoTyUhPFljdfxisKcFqNaN4Y2aRARsQ2Pl39YC1PuS3vuArmmL5O2gYITtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcKvd/UaKkqiJP0lzO3I0WbpOCZnQFni9dKA1B08MyI=;
 b=mCJCj3NrbtllzMwAB6IVT0IPr/TxImBn+bVIoJcKOad4K+yYB8U6UotecMJOjVCkltcWZ2gBxHc6QOHPDZvaJwq/jwSqSEjDmBW+tQXEd+9TPiozmNeH1AeyBD3+mLV49nGiyBDmYmRFstgykft3XmmcXp7UKve1MjAYQDZfJeT27Y+AQcNA8XQO2HQn4EBmCksD0iyr0BPi4yix/8+nW/M7nRTL1E9ZuCaQvwLoyikJbUochVrIpPpcb1ZFVE541GWlV/l3VhFKxBEn6T1tChJbJLNjnDIvGaZNF8BChziJ8E4rvXpsZDwZdymKkAYr1ASHt01lvmoZ8wq6mD87pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcKvd/UaKkqiJP0lzO3I0WbpOCZnQFni9dKA1B08MyI=;
 b=MAyQ/fG1eijDlYeEjDUHrfr9p634g7EDKLyomiE9AxVZQn1oSG8ERhP58v7YcSk7fofsNZSKIDj05x4cUnya9za+5X9kRywXV/zodBek45prYF7g2VCETq2/2fQfJvpmNEY2vgC83CasHKyVN5eCgud6l380qa4OEdSyKvhYEa8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:10:10 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:10:10 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 0/4] change drivers/soc/imx/soc-imx8m.c to use platform driver
Date:   Wed,  4 Nov 2020 11:09:55 +0800
Message-Id: <20201104030959.13264-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0113.apcprd02.prod.outlook.com (2603:1096:4:92::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a6ba4bc-df35-4ddf-8cbc-08d8806f2381
X-MS-TrafficTypeDiagnostic: DBBPR04MB7961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB7961EC54ABDA27C5115837B2E2EF0@DBBPR04MB7961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jdh96fhKKC7s471SSI1+MdKdzJkrdmg8bDTXe23lVRU5zGVlbPGJW+05hnVAo3Lf5DvJ4fDmQVNvBQprC4NYEVNXJy6f2z7CED9nj3/tpMD169UKMvRm/gM78y7cIa4QHZg2akKxMKojj5I7AHbI0y7VNiYSOjFwZaO9l8H2yEO3EYIxlDWUpXpFcLdInx0jvRrpQtrnRyP7h7aLrotv0/dQ2TTgfWwzJIveLESebuHtpQtqIU4oUQAsKd2sqTUDqGpyHTHbKS3c3q6lHCRxbmmzpRCW6gDACZPjBDnZtH5PSzukLCtr1jk2Lm3ottHq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(52116002)(2616005)(1076003)(4326008)(956004)(66946007)(66556008)(36756003)(316002)(4744005)(6512007)(66476007)(8936002)(6486002)(478600001)(186003)(8676002)(86362001)(44832011)(2906002)(6666004)(16526019)(5660300002)(26005)(83380400001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vmxRPUHSoM55gf2x3X1IsooKW01ltzmjqOG/OKJ3WSye8SPqlEtuonRNLokNjwrqXg5snGXh/g8J/ERjk13bDV0IC13UY2R0IYncrW0nOI0/k+srhBvL6+MJwnJVTXo5e9qdrGo4I2zd1IidDDE1KuNKeXcDPEJ2aSOCS8Q/0D5iHHn7zhoigkvk5WWH8dBIlm7FJqCO3ysJ/uwHnf2b72QYeVw/7nRoAx+pc2flPlkMHy2dTLayxkmn15RbW5KQZWXL/l7t43NRT88Rh0JjEO2oU4q+CoOSkc1ksR+NB114X1AuJA2OK/RfrC3Kc7U1M3jJGMQ683UIo/geJ9xVGcusSdUn8qaR6Wa6bq7ivLyTAHVvlB1EE7LH2T2e2r6yPdaxyfh2PR8v5c1dsyKihPiRrS0shB20Dz8OJ6V/42SBwQT2TSYiHl8In9If2lBKTMj3cBLQ6AL/pWYdsjsLHbGqrS8rV0ecPmj5MAblapWvzWDqgwDFF4PmsDUtzX+w28uZ8yif4zjI4hfOv0tCE3sWUqZ1bgzMiF00FFXfepsuvTWJIfhns+9emOZjRBvBFMWRENtl8ZkYxTSpQ4TguQRhLcxipVEbFWFOjzIG/ZJK2y3LXIAuaa4GLYTSxw1WJiICnTZDYYSAxQJxkwxGQQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ba4bc-df35-4ddf-8cbc-08d8806f2381
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:10:10.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iT/N28L5vAS/dR9xSO8ehybl/x9//kvq1/L2k20v3bnkYldnYyWHCqKKgjh8Kv/4fTI0bJGuVXJ0EazsczQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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

