Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2D2AEF41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKKLLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:11:55 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:15499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbgKKLLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgU8GA3TThS/0TKYyYjdsb0Xvfykvtc3zHzt82M6Hl+FJsgbfFe4tyXtEksLEBjUV64k2432GoXR71gCImb/DUgYuWoLL04hE6taBC2xUS6AgMydW/cT/erIeSSbi/XFZbdlcm5XBXGEp1Vovzs6rSJMimB4c/Ddkf1XslVWEu9t8CRDARhNzCPFlyu7cTGozqLlCB4NJs8Lf/PbKcqCqLAdREAH1J9UeBEkqaANWkaqb9fLFINiPLFdKhTVAq38l17BiRsynew4kaEjFqvp6ZHoCfVR5HyGlvh6TAR51/Jz+nO3OJavOusIiHzAkCvxUxBCwMgoWWDJqwgqWQy0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Pw1qtjKZJ4yuJsVHhs4tCY0f9/NQQ08BwrznZNqpY=;
 b=JSjvQ3hxxWGpUo4j5BellyIo5+aZA27zTCi5c7RTnagwrI5nwrZPZZwQsCTD+4b0hpS92/CnkCQYS/5cG3GtYWsbEjBRZMOsViJw/jRHl7CWvLuHwFbPG8FtzFyVhjxsNzp5r/d7hyWSo3I8JnSp/NUIUB/6kCppOVxGoYZ32koGueIt5SJ+XLO6UAHuvk5ePBAyRPtie/GJZmYy0qfUT1AhL/pHDFCA+U3WEL6g0qshlvnW0cP1TB83eVnZmQHEK7B83snDZsatOv/E3G2gWJ3JhrOo3BXS4vwxvsbRzZnzuZOrGK7nKC3PS0dm+DrG7gxyqTgqiKH9B1juEEMLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Pw1qtjKZJ4yuJsVHhs4tCY0f9/NQQ08BwrznZNqpY=;
 b=jdjiYo6I/q7HiscN1mmOculXjA2Rgj5KVx1V4CmvoGbN/7ZkWPXej1re7GcgYAsGI1kcZdDEX/X/z4xDzQBt1mHe3W6VtQ/8C0ngTFUOXmZUZ1E6UH8Tu1+nBq7SfkFR0GwJ3Ukaql1bfR+k2TI+Nq4ZgJt8Yn+/CSpSfWIF6f4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB5774.eurprd04.prod.outlook.com
 (2603:10a6:803:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 11:11:45 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 11:11:45 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        shengjiu.wang@nxp.com
Subject: [PATCH RESEND 0/3] Allow on demand channel request / free
Date:   Wed, 11 Nov 2020 13:11:15 +0200
Message-Id: <20201111111118.21824-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 11:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a04323a-4349-4e8f-641d-08d886329302
X-MS-TrafficTypeDiagnostic: VI1PR04MB5774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5774262B09F0EE0EAAB68549F9E80@VI1PR04MB5774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQCkHXwqBBjJvjU4BEU9cA/c7yihbxPy4Fx8sBPqP+W1sm0GBJ9n/F3Bf7uxXJ7oT+XRSsVeiS+mL1lEoYycm460VCjbqYNfS7t9dVDvn7bs7TJJcP2N9pl898lkxPza57WRerJsN8Z2NJOswRHXJJ/5quHrc1X+8OC/wpN9izjSlMTdL/OcbQqJvT3U/+qFlTDdhu5BM9y3c6Btdr+a3gLlcJB9SISjU6+QEOc0fW+HAsqeIV/DGPGMexgpdeppMLyx03S3Rbx/VAp/ou82xKLVKRkTzzGpSewgGq6QbQ/bc4o7BZRq/JuYA5iJblX2W1hvZlRpI0U1GeVlC+17Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(66946007)(52116002)(8936002)(86362001)(2616005)(956004)(7696005)(478600001)(4326008)(44832011)(66556008)(6486002)(5660300002)(66476007)(186003)(26005)(6666004)(1076003)(16526019)(4744005)(6916009)(36756003)(83380400001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hCcB0y4lZ/dspYLaSGM9HJkwXONYe1eXGrSntnRmYZ89AiJpbR2YTNG2KQiYptGYWh7h3M3cbvZF0v7gQROCd0un50i4Lo9MYTpZbSBgNOQ+Kcns91/QjH1CIIu9Ws8RvaapYYP9gzxInpA7mGuBLgmhiZebzFSf3xd6DuZhUZgCjRTewcjcyNS29cp83hKcKFIUAlYe33slQ9Q9J4/9JOnb9Dhj5IqYB+8lcp/6NyyBiTYW4keJyaqZDkWX6jEmf367d0Xlxmi0sYCMD/Dxwvvx8cW755ZFNrCShtRpRJLMK1bIj8Eu3zMMuUgItllLehbRsFOLdUPAcC6QXaTxlp5TCpMEBo4STkQYFde5XOZ+0RgDkq8qBJM0BDjGVJzkYMOC6biLFPwjqFyT9tTnz3YlS5TO9oEtOTUw2TEj0lAoB+l1RDU+2h8k6NE+77p8A+bMBaMAIwlxuZgi0Y+Bd1oflxzhTFUNedVpG2AEhJ96aBwYVgKaOCnC8lnMBb3akmC7zZACQzWBGHNG2ActzVqz8226UD3Vc5cZQZtH0COEojJqDlQvds7j8+0qiCqggSz3ZTxT/YWFHId83EQ49JSwm0McOPQDhQb8kbOeQSKyBlh8es943OB1scsj9h9gIzoZSeV5xvYX3hP8uP6ka5LzKzbc9renUV/cVCc9Ud2IZ477SNEKBKywaBEsu+RXdT+cRurUs/E2IWUnCuqpuKqNbr4/elvxVg6yXHLowrQVMyvZZ1J8+SCWMb+gKU2h48jq2wDRt8Xnx1GhfO3HnIKMxWIYPDw/mnxX5X8xkn5sC5a4uBFXcVJTT5bu9G1mVEXrZHctiGSVhnIiy82hSGOuIVzZtTvQD+c4XESvVMrY4n3Iod62nYjtAwyTd04JCky90u6igCPTuGlnwbxiIQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a04323a-4349-4e8f-641d-08d886329302
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 11:11:45.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCGhtGD7O0bS2Omwmx7qo9ivyCZJqka03RsH42Hm5++7nILcs027GrU+Za5n1N4R0IaEJgIlI8l5zpdjaFCmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting an mailbox channel will call mailbox's startup
function.

startup function calls pm_runtime_get_sync which increments device usage
count and will keep the device active. Specifically, mailbox clock will
be always ON when a mailbox channel is requested.

For this, reason we introduce a way to request/free IMX DSP channels
on demand to save power when the channels are not used.

First two patches are doing code refactoring preparing the path
for 3rd patch which exports functions for on demand channel request/free


Daniel Baluta (3):
  firmware: imx: Introduce imx_dsp_setup_channels
  firmware: imx: Save channel name for further use
  firmware: imx-dsp: Export functions to request/free channels

 drivers/firmware/imx/imx-dsp.c   | 72 ++++++++++++++++++++++++--------
 include/linux/firmware/imx/dsp.h | 10 +++++
 2 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.17.1

