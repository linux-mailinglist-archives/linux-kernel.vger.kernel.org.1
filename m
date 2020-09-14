Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA326886E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgINJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:33:02 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:61021
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbgINJco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:32:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhjR5M2dXJubtjb3SmLnZ/9lGEfhcy3p3dGWTN+1CsOXJSu1IO2rWelD7SSzLERo1vxlGsaTiQUkwH48edxLBW7Y2y4ohNssld66vV2pO/EZIqfJUniL+c0Rl2Y+hS1C0eLDMBah8+xJLXO3vT2kcMGc3HwU+SPhVWlyaq+LxX/MiTI2RDVlrSpldKGjnDbGqz5IFGHtBwe1tXVNJf067jOpYq2GA4g7My/NRwft6RENqeIC+FqJOnOImjP0M436dr0b3girmiTGcZaSHqq70TKaQ5gQz8kVPYaMyFsz1trIl7zb/965y4SC4E+3HzRcBwTOCwOKBDPx2U1FvHfpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIrf6XmG+2q7KDoYFGD7m01T8hk6JPx/FshZKQ/TdUU=;
 b=UScBoEUMb0b6bnn3fxwD+NZ4eEx53bh/gpLe17XRs7zmK0pjnOCqIkkSE7r4lKs79p6iRERmTxkXA7c6omgImzV8BhZRQ3Q6WwF5jiPX25MduQsuN5JpOGurNssOi9KeQzUrsQXqHJ8/At8sAhovJJUa6dhEcpBotuGw9g/0aSZJ98kvcfgyS3YaIlrvf9jEmt5FniShygKFSAj/GdnwWPDL7wGodfPIIXRU4CjgWZFfx4nZeGZ+JrHzzbo8cERhQNvwXN9PQgwW2y2692asQol3gd5kHn0O3DeZbKHJJe0c4BSNTy66YGWKA5B707KpY1J56lK1ixbeW361h+3MSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIrf6XmG+2q7KDoYFGD7m01T8hk6JPx/FshZKQ/TdUU=;
 b=T3qW8+owFHiDSGQdS7QFDC0XucaglNXqKaTTJjf88LBJ2VQWf/OeA7yb6WYJnK/L6sQPQ5qyiy6vKDV+4TltWS+CLEQa48S9tURPoXrhDsiNzLZgTp6Rj/QYNTpzmFAUlaghq+rS9+wVAiqevMehHmt4afufBbXQmBquOLBN7WU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 09:32:41 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 09:32:40 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/3] Allow on demand channel request / free
Date:   Mon, 14 Sep 2020 12:32:24 +0300
Message-Id: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:208:ab::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 09:32:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9c3c3b1-5792-45a3-6463-08d858911fd6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6688:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6688D882825CF48FB03938CBB8230@VE1PR04MB6688.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alOY1FcYvuJ0HsaQLeN8ZoON7jKipOVB/NiqtYrNydxWIp5V4cU2SBFv1ydKStMMyOzYj9/YXsO7T7NTi2yLrKGnCrTZoNuysgH4IjcpWfFRYaDNg2FceOPQV3pEpw1vLdToDYlFQoiGPCkDhlMt9O3T32iiv1NFlFxt7fNZ/+mxJjXj/j7H2v0wac51PQ9pn9CIjbKsXTGdEzt3Dbuot2V9bJdj4p/ipwJl5rKtc3c+B8EXXVxFDDMyYoLJKd1Dg4tF3LPdGugkKdXAD3k70ywtlqAxWvjHSSNTfhkzl3p4fs8ZDLftiG+p35VzPcl6Vq9KpIwmjGR6McUlxhYLqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(16526019)(6512007)(186003)(6486002)(66946007)(52116002)(66556008)(66476007)(316002)(26005)(6666004)(4744005)(6506007)(478600001)(956004)(2616005)(2906002)(44832011)(8936002)(5660300002)(86362001)(8676002)(1076003)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D399ezxWlPxxmsl5iZWlFoKAD0UYdyNYbX9FEc4xmS2kkyW2JVFKy/aujhsJjj64zT4eyjSHjqBeYt/o13mQiwqlJy2XxJo99jJN454p+JGqLCeGniZAn3odgPrsLfI10krfWBdhUgBtkUevWott70NX2/6w4qwcTHUBedKXsy4Fey/vhp5hwrtlWZFPNbebOqLAmxCYMG5OWA6Nj1FG+yYSVjI27WcU59rWl3bKMg/VL6KKyAjKFnUjGeok8yFeE4yNzRWOYn+qUIBAkxUeO47yP4FuOB4trsleS6c3a7DCfNLbHhHloAMgog5vKjqGaDNX2MG72N91QwkSfTB3lhB5m2ursa1NHF3wFhEtf38AWA5zkhZxl5qibNCEzyNNKIpnqallJo/pSuQHIOufvF+CEQ1JqEbexif/i12t2q/SIJcCqlVuQKYTt3IH82kLXxsor7g7j8NTA7kGjlL6Ds+iByCfldUP3pEz3M52m8/EoyUDze75raxRmx7BFK0UHSxI6rAn4b1F/17LuOSfCIQ1Q8nig3gxqvVF+FGwe+cElCTpOitM6SfIt6nyHrPN5AbyWCrA2eQzvIpiIo+iUWNXoHpjKPN/uoKziNRLUzs/91LtrwpzAQqH77A0PExyflGjCg00jj4noFQnAMVfRw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c3c3b1-5792-45a3-6463-08d858911fd6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 09:32:40.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRvtNSwazEW68FOrsjLWQH9HYvuKOoR8BSUKYUefx4pQjvQTpg3t4Nya+a9+Gbeau1IjtKzBEIF2KYZqJXC27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

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

