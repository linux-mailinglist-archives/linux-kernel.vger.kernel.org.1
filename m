Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA62D2221
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgLHEi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:38:29 -0500
Received: from mail-bn8nam11on2093.outbound.protection.outlook.com ([40.107.236.93]:37217
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgLHEi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:38:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1wE1L7YkY+YVOLmvVZ0QjlxL9TzfAKXHJI+cuLODGMglsDgIZapaEdJLW2tzpP8IIYtORaPp7e/dXQBA+4VjTFCJGVpwrlCyrDEGB0JKDJUx0JykO7i708kJcLgPXX9zg2uxEkfjIAnDJPwa8nPVjJU9xXQxOTipSzz+KdF8gM6qB4TQGBLMEuJlhxEAIwVl43iM0zbSNnhkZivKG+XknGK9U71h1RrkvmUlL5j1WR8VJtINTARtGi+z9y3pmg7o+eMjksGHXojXJhgVGoQj0X0lZLb8ywb8h+ls2jsqtfynfQlQwXJMCy4VbuQ24/q2SpaaICqyK+eS4swROrmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4znkgQyKhXp6p3mWiEGxsIHPbUWlM3JOTrkqaRUE8aA=;
 b=fO2qhCK6OgrLvNgYQevPBTZTIAGEXoIJxeSruGS2oGszl/sY6Ai+upl2RmEzy0SpYxdJjGoiFI8Eq2TPYCaOV0DR4PqWfM9bqRSMIUjaPNZbjMjXzvsrprpX1Q+sUfKwmsQAmdrm6lb7EvSD7yQzCtbvrkFW6GWPk205iena7q73PE5NIY33uZddyf4PrHUJqq3FkAhW3b2MklMFRfHQT1ZuO+F7CeXDODRlcjz/PlLPdTAe/EVklo/wjYWAWlryoALdh3SbJpOMsaGXtvh3P4zuclyANwf2gQ5MDYIFy7CdHMxOUyengLF1eHRlvlcnfh7VXbOVrvozkGBvxLWj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4znkgQyKhXp6p3mWiEGxsIHPbUWlM3JOTrkqaRUE8aA=;
 b=tJtSy6osQ6MJM3O9zFVhgtafhNKUIvNevfYcTYBIDET6z/tRE21DDwVjGXsFKXsyscAbshgiQaCRXem6dEbwaruycc/jse0RyUDAXprmD71ktmgHj7snObYx3PYfWB7cg+zI03rrG/sXGPythLI3yeKYoBICbBzNQbIkvOJtUYM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MWHPR01MB2383.prod.exchangelabs.com (2603:10b6:300:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Tue, 8 Dec 2020 04:37:35 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::e903:700a:f17:7a17%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 04:37:34 +0000
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 0/2] ARM: dts: aspeed: Add Ampere Mt. Jade BMC device
Date:   Tue,  8 Dec 2020 11:36:58 +0700
Message-Id: <20201208043700.23098-1-quan@os.amperecomputing.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [118.69.219.201]
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To MW2PR0102MB3482.prod.exchangelabs.com
 (2603:10b6:302:c::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hcm-sw-17.amperecomputing.com (118.69.219.201) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 04:37:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00788ddb-b7b3-4fa3-d9e4-08d89b32fbd0
X-MS-TrafficTypeDiagnostic: MWHPR01MB2383:
X-Microsoft-Antispam-PRVS: <MWHPR01MB2383138D2C3761C3648E0443F2CD0@MWHPR01MB2383.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4jlkHDsINEWIvuMAvBXOqp5T9RXGxwp9CT4vqcficDAH52CccZNIHWWneraPAWy+Qt2yUP0rckSbIcoGt6OqDwXhdIT3P1rjTGtQQ+5+uw0eOMmodkFtUgRmmCNg9bMl4ymkoBPinnUvL2mkzjurRtFIrjTEqOszm3t6Hz4d/rOfaI2yF9hRyc9CZ9AvHKj8KpbTKK+xbGwnXgSE9GwxKf9/smPgiK248pU+W0fQCBnBn8n8/EPNrbrtx6PDLEKT0whqtiVv1UpmTdac4NGnZOmCc1TKwO82DHEXJlUHGjSEfwV+SxPEFfT27+lXMZHrPMbOb4UGA3Inv8hmm1mYcGzHKYjx5RlxHG9RoQcdKvYz0HC47ZFCbpLUANt7g5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(6506007)(316002)(66556008)(478600001)(2616005)(52116002)(2906002)(921005)(66476007)(4744005)(6666004)(5660300002)(86362001)(66946007)(8676002)(16526019)(110136005)(26005)(6486002)(8936002)(1076003)(7416002)(186003)(6512007)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d1GHG+MA453MjPo6bjCiTPWSRoj7s3r8LStmHWBmCJkLEFtyPT8NrO7yrjOP?=
 =?us-ascii?Q?p7ZGR28ESiYmXGymFOzCNdqIEY1sbj+pvsv5BzohAb5rGT1H4nzFDIcW3kad?=
 =?us-ascii?Q?KskENhnuI80/04DZlTFccCraIsqTWCM4XDjFPGOctJ9+HCnRqFbRXM7mAfmw?=
 =?us-ascii?Q?xBedGmaWzXJsFWeC6T9eee2gvl4EJqGXbmgPG0LmfcrYAG/ToYgTA9qIb5mA?=
 =?us-ascii?Q?n6pEmh3+GezIOWpsrNHJQlFW2lO+eLRUqi70mprPdqXBpSyxqZKWhaPqR7D0?=
 =?us-ascii?Q?/Se9ycmVhEDFfJ/zdQnhZeGtDeCJPlfbaEJQQPoEFhaUufRxKRItxz5nHkaI?=
 =?us-ascii?Q?JckOaw1U6mDwXTHgZdCdRp6gz1dW15Swkp+5fVRhitCEPcBuTynO9jnNsOvU?=
 =?us-ascii?Q?wqSTT8r5Ndqilcr2xXU9Sz5GxglKRSui0BC10c5CWdyNGoahhNxxnxCMeRS1?=
 =?us-ascii?Q?Vwdzsr0HGHv6yBMpufvdCCK5PXDaV17oRRTcMndFCRhDOraawL+4lAEQ/5Wa?=
 =?us-ascii?Q?sqBUUQPmyUBUV61GNrEMicBStHLT/iItSSzb8tBbJne5eQ/ynAZx1ffCWcOq?=
 =?us-ascii?Q?natJ59le62t/9O5C4jZV3vqFoAkRpKv5GqNO5Mg+9L1qmx1dTVPuCaN0lfsS?=
 =?us-ascii?Q?uIu36hJCZkGxVe+tU2awQDoYIqQ+GHb3AmIOD7ADy9QJpY38+mPo4s2EhYfF?=
 =?us-ascii?Q?sIwbFmv4FsaN8fVfT+jiegreFEBn3/Yf1v2odNJl1IV1kEq+T6RrsaMGyAtq?=
 =?us-ascii?Q?8iGmonXzYuv1es6waJKm8Y5877EWZFR8tLQeCO6kqPYvT3zXMjQ4oQmfcFMH?=
 =?us-ascii?Q?t/YrEogweVKvkusH6TiUPq18mD5g1JevzdIpi4ZSc5vWtP8MFKHgfWr9LHpt?=
 =?us-ascii?Q?T1Aw3Hm0gPSI4PfQOg2IDfR6M5JwfyjmOXz6PS2qhd56HXxqfyNZji4cTUfD?=
 =?us-ascii?Q?N17CaTO1MtvAC7+ne8YsE1GZGRvkEX+ynpUv6VlIp/T0ZOdjjVcc8bus5Qij?=
 =?us-ascii?Q?VjGr?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 04:37:34.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 00788ddb-b7b3-4fa3-d9e4-08d89b32fbd0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSgnoKM+PRDLPqyJdXGGAI6ph1/Ws1EyquELHdghGqg3TAo4cvALAeGqfqSZg5d+sy6wkd1JDfWZlIrz2KqCeGCc+Xb/GE7Ph5HWvlnCTJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2383
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mt. Jade BMC is an ASPEED AST2500-based BMC for the Mt. Jade
hardware reference platform with Ampere's Altra Processor Family.

Quan Nguyen (2):
  dt-bindings: vendor-prefixes: Add an entry for AmpereComputing.com
  ARM: dts: aspeed: Add device tree for Ampere's Mt. Jade BMC

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 558 ++++++++++++++++++
 3 files changed, 561 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts

-- 
2.28.0

