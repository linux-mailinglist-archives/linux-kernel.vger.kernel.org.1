Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77F27C097
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgI2JMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:06 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:4078
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2JMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuHeoN2TOvMwQGWGiSlZI+jyO0zXE4IVvvAQFDwLDaon7F+u0OdXQUnJPysoM0P/dPJ5fqPPIyBmgD8jCoqlfBMUs2fmvh/yNxk/cb1bQyMuGspX8fQ1zvnq0hn+8/+91MzCA7aI+AJV3BnYLvlJNSiEzoBVyccVSef+H/AoVtTYwAdkg1uOmVLl0QlcJaGMZZ7bN7dWyjuZuWqUViWkpxxB5ecrxF/uEtY90H+H9bfz06dr0DcgVZbaYa13zuPzCemjuirqpnMrZlZ+v1Sf23YMNS7FumvfK/rPdJCLn3C+3GrG+JxtintOxomkppL5G5eITX4xzo2GT4+FQcPf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XKWZIrLq5uhXQObLF/p+knE7SdZGHHxBD4yREltqFI=;
 b=Q/LZh6frJv2wLEkCEF7DwIIL69Jry/+rU6kunFSR3uVxa0c5B2Z6+P7ImHNSLFBD2HJXuZ5Ag4bhPUYNbt8CFZ2jL4/aKAnW0mldAZ4ObVuEUqXoqUnT7xYwgwnaSWhJm5Zo+igZHMibw3nzk76w06+r+EzQDm6yFlNwAL884r3Pte4fxQ/xBMowmZTpUTmsWNIAEMjzqaUCcDibtkHdq39NbEp5w7tosxQPBPD2TEKkQFKpAXUcDGR8SG3c4LVoIpWedgRiJaU7N8fcpYUzvcakDoD69sKnjIKEx1W9AngfOQiuTDSsPYDrCwLTWzA6ADFTlYQdYptRUkSu6GLaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XKWZIrLq5uhXQObLF/p+knE7SdZGHHxBD4yREltqFI=;
 b=mLWs+y8KfmvZ+ihVgCq1Bv5YAy34qk7Orv9daMvpZaxQEtDGK3aN316aZHkRWTW/JtJka5yxIzwk5P07YwGDh7AicvH3d9y92g9WSX8/AMlHr88O+SnWeoi+3UyKDhqT02AztsSzdR84NHbu8vwZ6VdBw0gFQExomt+2BkFO40E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 09:11:57 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:11:57 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 0/4] Fix some bugs of the vop driver and mpssd user space tool
Date:   Tue, 29 Sep 2020 17:11:02 +0800
Message-Id: <20200929091106.24624-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 09:11:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b28ed31-f949-4d80-5f80-08d86457b71e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4751D29F7CF7C7649DC774CA92320@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lubdWV4jXUgbGEXPYW7f+V7uVkFxNosZKb6m28HUTln8USe6m7mz+9C64kDXoQim9E5VfobURcqgRqOhHk1n5VT3YVMOAdo6xgN3ifCEfbQR8Uz1/F3M+t/SVm9KwvKPS9dCSHWShXzzdeI1Enblt0y4j5U1mxCYG68j/kiuTkQ8FKrmH4917e7h1ehp2on+3IzzzyVNZYbHUS7ocKcNN1T8XttYgoEyNrHG9hpB6TJL/HvzGPQmv7H09a5PHvXy8rDy3hj6L6VHDaC6SrBsbqXMxky6IZBV/9/uaz+ob7lEWOToJzUhnHhwpISYLwXZdfy+DVdYwAE9ryzeIWEL80MSUHcd9xTBfHGdTdtMrhi/U19ndmpvTx/LjEto3oon
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(44832011)(1076003)(26005)(2616005)(16526019)(186003)(4326008)(5660300002)(956004)(6666004)(478600001)(316002)(2906002)(66556008)(66476007)(66946007)(83380400001)(6486002)(36756003)(8676002)(8936002)(86362001)(4744005)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FSM3PXwj3f2yTwY59sTAZU5/rNwTjY2jOadJDiE2Gt6ikugf/JpDgPjYVnUN29IqsXArpw5ccpTrAhUraDRM3jMr+it5ECyvBgk4my0BvssXf374G6+0mUAM4kekxlDJA1Xhq0ADpCkLRPJj37eRM+2wQoyp1Y6F6nZwpfJyJwcqJE/GS/3hxpyFA1486O7VKVQcw22O6T0vj1FXddrPE8Y7IZNJAMByopC//zxBd2TOV1UuFduQdmEeu0WQ2gnXvZbR5p5dMPZiSkEbWEGk9Jr+ZZFSd9gVnR4cE5bVfeZvH6Xup2r9SwzEDrvH/hGuK83UXSHD1p1E1LdJ4RqgxnQmFPq+BpiFZba2j41uwUEbTQ/b5REgfyCc1eACfI+xmgSH6DZtZsNqg6/jfr+Irub2kVZdJHjwqj9g2zYX+uAfQY46Kh0tCvoJxN0Cmh98UDdfGjhq7q8swbsVpl/KQvZP3PAZl78XxfbJ+BM09lQvdzRg0hcVAGFWTSw7FKGQGMkHf0TKb6s6zo3pAWvKO+GVoWDezSzvkREiGATigqdZZsh/kdF7le87+q8odzlL7M3P/bQSknWNjIHAtd3pBOYfLg3fwu1RApV0VI2aRa8Gqoaw0CGPSoprdFof7MlfTmrWmvOZbLTg+eh1tPORxg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b28ed31-f949-4d80-5f80-08d86457b71e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:11:57.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuDwjNjRVXV4/2elNLkkfgTwgtimTHyY3vfoOTLrX5UREw54aVabMBVGrHo+MvXuYcSO2mzIfjGF6nEN4UZiSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
1. Change the way of copy data from ubuf to dbuf in patch4. Reuse the allocated
vvr->buf as the temp buffer and add a loop for multiple copies if there are too
much data.

This patchset fix some bugs about the vop driver and Intel MIC user space tool.

Sherry Sun (4):
  samples: mpssd: fix the build errors when enable DEBUG in mpssd.c
  misc: vop: build VOP based on CONFIG_VOP
  misc: vop: add round_up(x,4) for vring_size to avoid kernel panic
  mic: vop: copy data to kernel space then write to io memory

 drivers/misc/mic/vop/Makefile     |  2 +-
 drivers/misc/mic/vop/vop_main.c   |  2 +-
 drivers/misc/mic/vop/vop_vringh.c | 24 ++++++++++++++++--------
 samples/mic/mpssd/mpssd.c         | 24 ++++++++++++------------
 4 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.17.1

