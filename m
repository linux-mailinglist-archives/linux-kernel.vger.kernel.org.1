Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0502F9867
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbhARD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:58:25 -0500
Received: from mail-eopbgr750040.outbound.protection.outlook.com ([40.107.75.40]:26509
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730433AbhARD6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:58:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFW6GHsbfw4Pqwc/lSaBS6NB0YDlFeGfIWWSsd70tWvU1zN2+cd6MK0+wtRn8DVFI+k3D4APUsHdjBpRiOEA7OI0qInFHqGlPJIO9NSgLytzVB/Ng+y9rgoscIt4xV7wj/ddTtOr5ku+Q1Vp6uEA/vMzqmjcoLInrOvlxufyaQ4g+8R34D1RRWgR4Q11BJsNnZsS2/fbchBw0ygJs5ZK+qsr6HuDu3g5NlhsvXE6xx9Vdeyx4q3soNNdtabHqzJheKs03XuWVA81sMV3jd2kMu8Cg/wMCr3Uvkja9V9dp7f/D4vaq6mEvc/BsNAR9kAjigdUxbOM3omIBivV2KN4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgFw2A6J/1XTPnjffihqogUydoq+2V5VJyM9k+vsVlA=;
 b=f9NgHKxyp31qpEtG3lTIs9QCg3JouonkeK1PDUtsPaIEzIOm85NflQ+s4DpDEd9mxyp8zpt6mP4q/Q5XlFr5xzvPuJYzUykrtZfcZpFpf2+LMXVXyiUY0lC0KCEaHUOC9mB6gNIsev0ogicUDQWr6aiJVzV9v5w4yTZlO5ZtKlChZyWh7ui24/as6wfJBtHQ0qckhsRdgU/o9gV16gY4y8+/4zSYRzGN5bfeEmkLyFEX54je9RIlLJtk7dw7ftthjUkTFRJscD8gYGh8MDHsb4U+TBMa9tuqrtIkUY41WRrpOiHtzirSDGlT+AyLrOrymAF1dGsOqGHOTpfG5dw5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgFw2A6J/1XTPnjffihqogUydoq+2V5VJyM9k+vsVlA=;
 b=IdD9q24T06+9O4IU6taLRwBOoIO2RTxD8tbr8HC8VV5iVb1pxB9a1wCVMNG6OxvxZyk5Qg5MUNMpg4kqmaCiBP0oD/R3SryUDUdtO9ymEOBA1Ga5MLBtnBldGmZPByGyMk8TkEsKhKco7CLsMdOEbxxZWFurUwAmh22bGsD1CtU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:29 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:29 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 0/6] mfd: iqs62x: Minor cosmetic and functional improvements
Date:   Sun, 17 Jan 2021 21:57:02 -0600
Message-Id: <1610942228-7275-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b818669-ab95-4958-d353-08d8bb652cc5
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB48785F3F5C902B53B611DF81D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0TP+mI1W9Dv+UFUWk+2mj//eUSNAswQBqjftz0jgsM0S6pUtarv/xvmuEsXJFXkR4Rov+tb/d3XKOeK10Kid6jTbhcm4HdpeIF/5xcCCDCJZuVaz0qDfMJ153ynDovTbBhYNfmdLYdyMb6S/gOgy2opj5c+OUP+qIfjePtYNQWZTDnwMN2iPywmhfLQhYJIdeb79Vx3tcN9VKE+TzUjAopZ2ZMeY3L/KV5p0gkKxo/+8e7HiV0f3Ic0R3ofHuPsXNGPhH8l0S6sm1Egf5lQ4NPaQPG0A37UB8Uk//jV+DdMkAF8q++YHLjFCqs39MVvAJL/QQwiyCSiLq7Y/StwcZL2VYElC6jKwX/yMoGa1q2mcE34wHcLl2SuvS/XKJyC3e7fH5drUNAabcbtyCUrT1msZRxkpQncnZZY8QGt/SvflA0BPEdb+IWBZoRocArG8hyVLL0ul6dvImZcgbgZ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(4744005)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hm1RWbsfwzI6OSQSpjRhY+te1Hr8MgW1yoqSeVQXyFDO6vITCPgSuWb5w/8J?=
 =?us-ascii?Q?/QwjG0K7h8BjZKmW+Zzj0CMcGNry2AdtVSmi4DJAt0lKx9E41L1mdTtf6WrK?=
 =?us-ascii?Q?xxLuYSQfl4aCwiEzF7ksK0lo4YxXovC9MoRPemLIrfNjkAHx0PoxMNlfiEnZ?=
 =?us-ascii?Q?c9JIFL1mGoYDL2M0LvrEiKOUU0YZvmuGil0MyLvlwPSMXcVvBWpiTsakZgkv?=
 =?us-ascii?Q?nTW3x4/HDphgi9hp1yCmoCpSRkk7LAoDMPMMJ0recr9sjGG89drQSEMP6bcK?=
 =?us-ascii?Q?Lgp2PxFzkSVMuhYjPLIp9gEbebZWiUetS+2w/wGOAqTgCSTUZ5N3cq1LYjLt?=
 =?us-ascii?Q?WHZJMJRAXKhxvTbOHe27AguI5caoLfRCg4TIoga4ak8BWUNTzrYLCRahSaVc?=
 =?us-ascii?Q?mUa2DFjspITWoWXQbWjqL8mYgdkqCeQIwO+ZDOR18o/0tOG/sXhLTtxbthyz?=
 =?us-ascii?Q?1roFmTvXZXIOvp2PcodDc/xnhpL4Xc7zu9AcpFrusrU8xG0DxnzGP8eZuk3n?=
 =?us-ascii?Q?O++bn7tDUAjGtrxPHGhtM83nRbRBeuC5FfWMghvA0ZReIKEk9dAJFdp940r0?=
 =?us-ascii?Q?xufo5I9gHdbsog3uhP9i9XfEsiUwEam3Bs1PyZscSkUxrCOpt4a+hGxEj/GN?=
 =?us-ascii?Q?lrpKMPXW+MM1d4OqJNR5S7meFyJQOUkILFXaP+/yuB+rEbPJN9jSXxQJABzA?=
 =?us-ascii?Q?6SMP+/mCohcPhJiGvPi9V1QNDZg3CWGjArN232ExVLGHytp+RuZvQUs3ZmTk?=
 =?us-ascii?Q?5mIM264UAzFuFANk0NRdrFP34Pr9JC4dSMiGpKl5EPeg7iWt9RlxxoMZ3fsV?=
 =?us-ascii?Q?QjMflr95f8bBnYqvgYegM+5xWDx6N1J/EJci0XRK0X3TC1eR+nLoLsr1zZgA?=
 =?us-ascii?Q?RejtkCNa0gWDOnpa7BNnCI56P1Ipez8rNNjeSHdMMqVhHO3ba8WaMPj1slR9?=
 =?us-ascii?Q?aWf4C0wfSqNw2UpWFATwowJ+feTTqmYJuNh0P3KNNG8i5Z//LstUOtyIcq1c?=
 =?us-ascii?Q?y/HV?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b818669-ab95-4958-d353-08d8bb652cc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:29.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vhtz4SdHxrzwsUaZsjb+jG+Yq3uclhXQ7vNch/eJJ8YkpNoE0bPP0LHQ1P2u+XaPooUCIQfKHyeKJr8gzUIbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a variety of minor cosmetic and functional
improvements to the core support for the Azoteq IQS620A, IQS621,
IQS622, IQS624 and IQS625 multi-function sensors.

The first three patches are purely cosmetic, while the remaining
three incorporate learnings during recent work with other Azoteq
devices that have similar functions.

Jeff LaBundy (6):
  mfd: iqs62x: Remove superfluous whitespace above fallthroughs
  mfd: iqs62x: Remove unused bit mask
  mfd: iqs62x: Rename regmap_config struct
  mfd: iqs62x: Increase interrupt handler return delay
  mfd: iqs62x: Do not poll during ATI
  mfd: iqs62x: Do not change clock frequency during ATI

 drivers/mfd/iqs62x.c       | 144 +++++++++++++++++++++++++--------------------
 include/linux/mfd/iqs62x.h |  11 ++--
 2 files changed, 85 insertions(+), 70 deletions(-)

--
2.7.4

