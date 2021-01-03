Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED42E8E31
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbhACU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:57:17 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:33505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhACU5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:57:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXlz08zh/iQRfnq7ApxLcImSFDx/htR0a/rWtl3BhyLp8ub6Wx7T1w4rPc+D6TxOcjh9ZYvAVJ5fbpVetDpjD2S/SmGTApswNzF+ZGgKL7UHaTKjIjPscax3sr0ohwigo2iCZounSSdPjMY8p7r2n8oX8P3bH/gwwkyg4AE1AWYtrjghC2OjRp/C1hR+92YQHMim/i/1LERgtDM1wQz7v2xm56lt38+TzbRi6bExhccHPW+Ic+Nw3OT1M+8AazqUMB/YCKUu1eVC7y/sRWQRiwrAnfTA6s2Kz1SOTk5Y4TeD+6hdU2QVryMiEPCPsZFU4iSDTg7ntXx9tj4n3BBuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqMy9xMXLsJhkw3RdLckm0rNLGlFcDuCyyd1x/Wdf38=;
 b=OFvAfqyZ0HJQu1XqQaGzGApUCLBndLFM5YgH9rMYDa95LvkVvZN5N9fBPAz8FbLaMJZJSD+zTbdPCbpdq8k/Dwyw7WKqNDfGMMBeX1dJue9BnmQ7aLNpYDfYnmeXcEg3mpu5GRZkn/46CZFfeoQaeQO6tbleoqpkDPiimwvVgbwX1BTG+Z1mBHJbyHrM0MnhK/2DXPdp/JTlch14DxxYWL2LtEjwPX8SShAJ/bRSEWU0cczFzVoBV/l8/l+nWWduFxbgvrR8KcxNMwmFZqmpWhzbGPzXpQxcqlZyYigut6OrU9o3pKoTVMy4HiEMIMopym9Y/ApXciSgPoq2bqbuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqMy9xMXLsJhkw3RdLckm0rNLGlFcDuCyyd1x/Wdf38=;
 b=HQAapcrXTChVqsaoaABke9+Ih+d66r349DORFtJyCq9cjAZB6oqb/JOjTAaEtYA2bpJtmNU/w9vhevvn1ahguOwCWrD8hKms142B+dbOqmRPjrnPaypOgSyPm6F4W+NTRVljD2uR/rH9XyThjPUGeYvDzpVZ/DLtYu631qIXCgg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:21 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:21 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 0/6] mfd: iqs62x: Minor cosmetic and functional improvements
Date:   Sun,  3 Jan 2021 14:56:03 -0600
Message-Id: <1609707369-11297-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: DS7PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::28) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eacaa2f2-1cb7-4117-b3a1-08d8b02a0642
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB715299A8A7FC6912E078A2BAD3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSMfI3DjmvSzW3WzPRcPBYWE86k47pUGRQgm/afCOmbHom0o3dsi6XL65Gq5Y8HQ+i4FHOYDJwgllKwGRbDapQpvL2oBx6mo+f7A99dv+Q1c2AkoRHdbn6djIYQsYShVcosk5bjtF3cW74ojsLroQ5wmXzseI31UUGrFhxbpaIZP42zZiwnl+iAS9yVzr0VK00Ldym1LPRitoEiCUH+wnSSYn0AjGVDBy5CxIsfs2r1WL9DiAJFVwE67OQ1CijgH6GuhkF3soGYFiBw6htoFtdb3K2BevBmSnDLFhD3Ue/UC6dOkbV3UfYXtbxJmt60VO/5nYvYkJ1bXnYoU3K4D+hNjN5GQzBmb6iDNMmoGEcDIYvUgxkUXcSX9nPUvRfG3PJXsTML3cStRoNfbIPpFp573w/2yno7l9m4kP/mY2NYrWUWNCzwpUM42QqqNReOPFmMluWsaR7/R86pipqzvdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(4744005)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jiN7a8ObY2ifYXaWaimVZSH3i3YpP/0CLeaFx95ISqIaNnXXhtOjRECcCF2Q?=
 =?us-ascii?Q?c+e9LPtshydpyDX5cOiWkBIZa3F0BKY5doz+26J4Iqi74JFMUfc8UY8hzSOc?=
 =?us-ascii?Q?7BUvILLcqWeDo6wlsQ1CaUTvtSR40Fjks1dYIXjMTRB3tEe0V51SCZ9zohpD?=
 =?us-ascii?Q?K88zwGinGAaclJO3GA0pAK/GDIAcUsknLeQ3l+dNHNCJXbfVVKe0g8dVNTlo?=
 =?us-ascii?Q?QBhuliVIQQuI1WwDGEnT0WdzTvyUwYGvBlKAmJXzVhlc+rXSe8yI1+mCDwWT?=
 =?us-ascii?Q?PBkVitEPuyEiQaXItFC1OPSz3nX4oZeBoDkf/IIjb46a6tXxt3yTh3pCeHM2?=
 =?us-ascii?Q?fpdZBKwdC+9DrTTZjNo3wUTbJocsQy+JfYiF+xWxVf2nv7skdkndpy3Ydo0F?=
 =?us-ascii?Q?531itzJtOJSjY6vJJ1RcTkRlTnr0f/8trruUCF2gsZpz7hvqi1DziIR6hkhr?=
 =?us-ascii?Q?T+BJzoGfqhfUvUR1ooZk3sIYnod31zYOQtGZ81fdkArrT8bkw3ZGmTZUiRJe?=
 =?us-ascii?Q?XKG/zoezEnm4ErnR5y1X0o2bFYgs2iZH7C4vLMJ6CwmKlP5blDjJgbSHL3t0?=
 =?us-ascii?Q?JdvpExAkT3fhfGcd/O+X9LngmAavLGVVQ2U38JFO0oCQRj+lV89hw5kKnK7E?=
 =?us-ascii?Q?ck1pVn5QSfSImaAshnzovohS0+8b4GQfWdHoSzWm14tJOr50ogzcZEqRZo59?=
 =?us-ascii?Q?kAhD5Q73tGBdMQwSIsz/l9ZXuBgmGBKg85/oP7T0GA+27tHDwh61vFeVKH2V?=
 =?us-ascii?Q?UJgknAo6MyKB9DM9bcmp6GQ806/Yph2y3TWtUMbF4535LTA409O9VydgU6gt?=
 =?us-ascii?Q?tceeOji9YWCp8R7SVC9W/5qtN0lN9NqtVfUy9HOWBeup/UC87ftxu08gOeXD?=
 =?us-ascii?Q?kPULZguFKj8TotTX4Uo0VTnJP4pXygYLQwwYlvK4RWcL/50/0+PDwzFG8yEr?=
 =?us-ascii?Q?hdznElsXZ8ePlcmu0Itw4DI7O7FaM0OJU6XW/LK0SI9EmAnTVKC90SluDQBm?=
 =?us-ascii?Q?CunG?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:20.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: eacaa2f2-1cb7-4117-b3a1-08d8b02a0642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRUvXJoX4/x3PnmbQo+0Z7udBywqfxy+mVmB7uxM+Zp/8muEbZbrx6DOdrKW4DVVd8mJkmWeDqlM0mBOFUGksQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
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

 drivers/mfd/iqs62x.c       | 122 ++++++++++++++++++++++++++++++---------------
 include/linux/mfd/iqs62x.h |   6 ++-
 2 files changed, 85 insertions(+), 43 deletions(-)

--
2.7.4

