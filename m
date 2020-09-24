Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1658D277500
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgIXPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:16:17 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:37634
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgIXPQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fM6s8iAVlbX8gghqCf7JD5KiCXxBRFzhFlrs+mgzay2weDtJFxDMZuknsMIYsbL6cJBjH87VQ7HNCsORi7IwHh4LFyg8I4Uc6ZuWtAgdjZM0ofJw5PZk4g7h0ZIVy3LfPonb0pfxWtziCUDJ5jbWdQHfTTVqIKBlB8Ns+x+YNB4OWyReHpSYqI7Ib3Rccndb/bzQfQZ6XSEObKStBu5jxg1MKYdpbLWofwPnuSZ0eUbjfojFv4sV+EjECbP6eThO3tuRFRQaXahEOOcZzU10pv7WAmdQELdpTvaoGr0S0UTmzSUvOt1R+twModGoXbVrLyem5E8eyFp3uCBGINAokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6DejHqzmPLB/44/ftIC2eYPqzSWQXU/L+RnJb2ovgk=;
 b=liSEn0GRgNygFTqadkF6UH0S4EtEGSOirlIbX4nAEIWeIClDWwak6sYYZKvSIP1U+PcqO78LTGUddWK/tARQ5Kp024n4kQS6V/bI1e3jxWJYo3noVap2CoxePyN/cl5GSX73lX0FJXG2dzqWnMG67OTzGxK62kDxkyg8D7D97Lvz5yRfDArn2hf3UUFo0YTfTOrj7xBvkdPLoZ+gHr/fC+GtTCDIl/0TM/0UtPgq4KvoxBRDvUdplOD6VHQ6wh+80mJJlrdAVVfEZ+UcAE/JzpMuZvgGlUiMgDjXBqS8lNtn0k/LDWQyLdxiIatnPNxkUb3kQs8Opd0N2dw50sbE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6DejHqzmPLB/44/ftIC2eYPqzSWQXU/L+RnJb2ovgk=;
 b=F0oxZUoUAdlREUPvvM1Qedg1h8JuFJMLxlW//AOIyHDMlUSkRZV/4p5G0H9bIWA17JEyrAEq2rDLT4SwsEtNNrSA1RSQ4Tz+Ow79Sa7xofzrF4qy8eWKO6IkF6KW+AyZMbFWyfR88Ubk6NIU8vpcTfvld3E2+7Pj3bHg+iYA4xs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB3054.eurprd04.prod.outlook.com
 (2603:10a6:802:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Thu, 24 Sep
 2020 15:16:14 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3412.023; Thu, 24 Sep 2020
 15:16:13 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: SOF: Activate runtime PM with SOF OF device
Date:   Thu, 24 Sep 2020 18:15:17 +0300
Message-Id: <20200924151518.15841-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924151518.15841-1-daniel.baluta@oss.nxp.com>
References: <20200924151518.15841-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 15:16:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65f17ba5-2281-4297-a922-08d8609cc682
X-MS-TrafficTypeDiagnostic: VI1PR04MB3054:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3054F0801A39B0185D8CB983B8390@VI1PR04MB3054.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 333ZxwyKtUStToeFt3gGgwjaURFMzFUT1mO0dy8tZvvyGDYAKyo44oOJjzFe1wWU8fV6na9I1qPR5tlS/gtgcoqtLmAju4rUgW1XFwIH6s1qsClwIofO01U7fzsnC7oNXm7Rq7iltUwb9BTZV9hmM8nxPvEm/BedSiw49zcPs2NdWBoAPzF6T0E0hysjQnh3mR2qcbOIB9n6v1WoakJTJTGYpkiUuNgILGD3M0h+uiXbcnTmCoUbpqf+bg3xzUUWsDYM++cZupvzHNg7VvngT/6dB5SxDCve6Nd/0ibNQQSYU6IrtIEgQCQQVf6OecBGBkJ7FL0MZwPXfijT4ebnPbtKVp6p/gU428PbGe8QRNJkMdLLnFpAclawRLV8IARo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(16526019)(956004)(66556008)(66476007)(83380400001)(66946007)(8676002)(52116002)(8936002)(1076003)(6506007)(5660300002)(44832011)(2616005)(6486002)(86362001)(478600001)(2906002)(26005)(186003)(316002)(6512007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v6FwLc4w4TiE0SplL1pmEp3XXtBD1JHCYnK3zfJILLKHpfvOVWh+j9qU+yrlOL4aXtJip8Bibjhcrs3PZ1tVjyutnWwxVD4YEgF/meXBLySDgtxlih2MBk1QWfsjlzbb5kKT5OW1xSDFxAxr2wQB/i6MQCawp+PSZSAXDOcjSXdi8os74fsc5gG+NDN73nzNKoPWya0kRJBt6GScaaOAWIr294GoV8Sc5ZYWDG/3Iie95l9KeZASOC80wAs2lA9LiV8A6e8UNyVlkJKAo7dA9MrlH/3aJ6tNUv4ngT3qtwJZ7AUY/XKeYD/WlzdxzgrE5fve2QGWEFncqqrg4g0oz16u7E9AovEfvhe5aAqTut+awDqOt8CC6Bqq8aDJeiayAvSMX9F/yTa7acSxju1gU6slpBpCvP0/U21T2SW6lYQn/j8uIqg0PynMif+n8ajpbSBGz0xexmvXPENZoYmSHKJkfT5uQB4BgZkAWHVrCXv8T9+fC2K3pXiBb8Ifwgxt9ZzuyJMYxKVApenyX/+oRCRAVv/TW1UwPRokcj7NJ3J2CW3DULGMaI6USXfSs3nF+kHHOPZXXlO7wDKrmMkcX4Hg9MuRgVujkuQLX4DKyaNS1Z2qR/q8KyQ9Iw3Fp24wkWlFnwgkboZDsezkY2fj2A==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f17ba5-2281-4297-a922-08d8609cc682
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 15:16:13.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv1xRYyO3SjkXdZtpTSCQPPcXQRiUiZ1FL6jy3RFEsXzT2V87bw8Fx/6EQYh0SKjO16XKp9GqcSGenQhD0uidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

SOF boots the DSP at probe and keeps it up all the time.
With this change, after booting if no one is using the DSP
the SOF core will turn off the DSP to save power.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/sof-of-dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index f492c5dfa659..de9acc0e33cb 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -56,7 +56,11 @@ static void sof_of_probe_complete(struct device *dev)
 	/* allow runtime_pm */
 	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int sof_of_probe(struct platform_device *pdev)
-- 
2.17.1

