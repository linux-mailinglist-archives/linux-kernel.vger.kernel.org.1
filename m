Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA22774FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgIXPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:16:13 -0400
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:4259
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgIXPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:16:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3RjitpyOPxtR0fb/5aQE/V5kXLXBuTooE0eTOotyPNTeZMlu4HIjAOvIcKQg7+U1p8MezZpVBLYth6e0EVBXWONe6cKnbEWh9iWWbwiuCknUoOIzPPn6ZjjOhL2fqqKbs6jByMxmbdQLaJJ7GZTNyMGUbsneMfBjb4htVUHf/oqywYzSK6fq1rhv24ihRPMLOF8vjQSdXL+9xEMUr+nBS0EeUcd2/shIek18xW9mrvqt3+eRIxdDp17BvbalhiBAerokvpSot95t7vQYj9TdvjLph6aq4nGxyb13cWmPgtxifGQ3s1Dfp3SSFEamvPvOToZLS3VcPNsbU7PeOZ38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vH0EEbfKl+TNy4dUY6oj3CH5C7Kmld4fxykE0RM238=;
 b=NdpyQyezZ5nLNrsUPjwjj/2cJZHGL1jOeu7GbQ1CqaglK66QML0ZoeXy9FXD1OmdxGRy1hvwn+KWNNmZbME+r29/xQC5Awd0AfPJpkjgdgCGUQdX8Iq+BVgm73zekvYjUpWJ0Nm5AchA4CzZKtHjSxQ9SYhVeH8UeNLIcU0uTncFhlyAVmTgx6R4er3jimKEZs1m/v8R6MfRPOizxOT4g0YTFl94Dxs+kQI7dIzrUeHud4JXeliKmBS1FIu+YxeGLeDFcKIzlkmbEcC39jAU3e04kSzQ400wEuolcYT6rddNFyPgpiNGra93AFSvpVNfVbg/TyErGYuPVXSg7S1DPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vH0EEbfKl+TNy4dUY6oj3CH5C7Kmld4fxykE0RM238=;
 b=EHEhDKVSFt4dlt4fG8loPjW692f2r5LnzRXMGIVcEVpZE5k3bGZ1x6XUp+9RAZktDxYV6BsoVR4+xSeY4IeSM7kqExKu5gWVte3d55iq2qVEU7GC39bq+mkGPWaUAn5nk07V8PY5BOyuCpTEv5Lb72aZCdbCnx4cA7upRyhrueI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB3054.eurprd04.prod.outlook.com
 (2603:10a6:802:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.24; Thu, 24 Sep
 2020 15:16:10 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3412.023; Thu, 24 Sep 2020
 15:16:09 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Enable runtime PM for SOF device
Date:   Thu, 24 Sep 2020 18:15:16 +0300
Message-Id: <20200924151518.15841-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::34) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 15:16:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65505f1d-1a41-4c66-70df-08d8609cc415
X-MS-TrafficTypeDiagnostic: VI1PR04MB3054:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB305414029BC5D7D3464CA601B8390@VI1PR04MB3054.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xqS5LvZ1ra/ymeZBbYQQVO4ulCgTubRuO/xrro18SMTRNg7Q8Obnv/fyHa+UCshtoi43k8n52MB81S6seNKCoV7wWqlwrmOgiKyJV9NGiH993+DmpFdjP3lZA+pmCu2vQJuSm3qW/FsEOg/LWi2qxZBGRM9WrYsHC6YJZmyJYN8RpVfZmNuSEKugPlkGgHiEMm0oU3BfAVNacEjvfa6JL5NlBakzhRKVquLoqgfOAoH1ELG5BXbMvcftM1q0esG1UWC1McQsv0fisD3x3C1Ymaax3anGLJhBNFpgfGI2Zg2WT9x11jYjc1NnMLBz0Oq1imif8iDQn3CV1EbdNPUYE1Wk4VzAu9AI0X+MARLsBwSGgL23sZP+8oODjOeS89A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(16526019)(956004)(66556008)(66476007)(83380400001)(66946007)(6666004)(8676002)(52116002)(8936002)(1076003)(6506007)(5660300002)(44832011)(2616005)(4744005)(6486002)(86362001)(478600001)(2906002)(26005)(186003)(316002)(6512007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PUlOzHCasJU799ZabumauQucwWVnq2pFivKr5D1r8vr6WLudYvKJkVlOUrOlb/+Ci62XnrACJzs/EW2ttsF6ziNqlYJEWXQ1ybPj0fbBMuNLYmAzKsEbrM0k26BoYcrs2aClPVb93IvqOKP5qu9YjxJBTN8JKi1NKQPSf4R/222sFElG2Ad05NMH1hrU71a9lEPUTyQzCegNK9+zn9XzojRJPm2O3op4vEtgSSwggX8F+ZXkmILZFkOjS6IM2tSZPGTrF2p60yt08GYT6VSSCbrlwfFHqtGRGSKlBckvyh5WDDiOXzAvkzwK+/bot3zs66RRO/emeyrU3u0RdhmLLRJm0qYhgPZ4kmVcgQx1QCtFrPCPd26gbRk3ao5yB9vkkHAslMCwb9DNXwzzd2Draq2RXIKOUoNTkIHHRCdBQIG157hepwyLBzJzkep6IDF+5D4yFg+cukzk2eJcIixhHv9EeEPZnwKmJfKy0Yiod6UYm0NXv3N+K/eEhB5AOZMQd8SWT3l4iel7TK9zx4rBQl9xijTFh+AezMK7QlebjFT3m1nienYBrxI5mwt5i/XRhpb4tiVFX7JowfpEpUgHaMDOv5soxrRGkscnHVEIPFBYu+oPWsdwftQORVBEWwWTbd3wdiLi9IwUha4mSPzGLw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65505f1d-1a41-4c66-70df-08d8609cc415
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 15:16:09.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdO3/7TlNQX4X+DTh1eYcuJ7buJK6mId4+v6XpPu06wBwYMjyMEXRvw3XnMcykry8ZklOmHIvY/EP+KP7Wz8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This enables runtime PM for SOF device. Next patchseries will
provide PM suspend/resume handlers for i.MX8 specific devices.

Daniel Baluta (2):
  ASoC: SOF: Activate runtime PM with SOF OF device
  ASoC: SOF: Add .prepare/.complete callbacks

 sound/soc/sof/sof-of-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.17.1

