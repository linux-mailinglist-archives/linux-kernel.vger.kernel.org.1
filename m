Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23C4278166
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgIYHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:21:43 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:17129
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbgIYHVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:21:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnr0W2NgUeOZuWkF+nIOPOuQbgQ0IZnituCMZC9Vc+3D1n+nFtJ+HByuyPps+C0F/TN25Fl0j5RCcDC684dR3zUe92+IwY713id6sMe0lybswi0Vht+4LgucLgcl4IHAuUWLk/gF7E/M5Sg2OyIkAKGqFyTNGB/fIGgSciIV5VTkYZi0um5AQHimKhstXNrddHXQmhXDmmXkLLRLcE+k1xnKj1Lv41u03gq1wEC1+vIktsjnwAFLtWSPzaogUYj97Uea/GZ6GwTOAzF+1DxU0aflf0DXxMl5xvHVSautyNArHX7MommwEodDUWXrSrVIx6N8tFqRuv1n9zAuo+03Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjixaQ2EbZL93XNi9nuonEyoxLfdz4sQt8NmjR8aCQM=;
 b=nNyxi0A6b4jxfsCzjhw6SK49r6IqywQAIYlilvXTC/xK0b+1fXjD5WW/S9OVzzCeZ+FZYe1B1s5lxQiHSULrMIBTORVYD7vNr9VyCyb8GDFXn9yx7GtyIaIZKvDr1Z5cW4ayH00akKHnXsUkRPky1VTplj2/hdv6s7357Uu83LbWFADWNR1KD0fZYZtvsk7MIW6ajf0FBdxCu4Q+yo9Sv8PaI17LRHLW/GUaEvMxIWbTT+L74ob3lhwAOSjumDg0tHOIDO+fQx295eTd8iD0Y45AdYz7LE8kJ7q3sBHI0ePq0W6QcArER07aNyEbP+3ZjWp80ZugTyEhKwaSPz2nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjixaQ2EbZL93XNi9nuonEyoxLfdz4sQt8NmjR8aCQM=;
 b=hkDLqWSeZD0ZGqZLKq5tlHhkZ+XkFJTBzzOC35STjLxX3VLy2EknRfUmbrjaNmytQN4g91FRgXfxH2qnojV5qLQvtdu2HHO8gJVVWY6LUdm9N/a7q8CZSPJUxKxrgK6Z2oSBVHXFxQawS/NY1f3o5y+aaN7fkXT6wBGCOnlvMsQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3277.eurprd04.prod.outlook.com (2603:10a6:802:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:21:39 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:21:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/4] Fix some bugs of the vop driver and mpssd user space tool
Date:   Fri, 25 Sep 2020 15:18:27 +0800
Message-Id: <20200925071831.8025-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Fri, 25 Sep 2020 07:21:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81860a84-064e-4405-2846-08d86123a4d7
X-MS-TrafficTypeDiagnostic: VI1PR04MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3277BBDDC8B47D97E1D064D792360@VI1PR04MB3277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B344PZixvag7x52QHL1WTHSlYZ+han5OFHGDGwxiccUtLPDeJnrchjHZRPj6DjrZrve9rBIBIA9oBiBJUCNYBQ7jbz3Qa+v/cBUZ6QtkzgsmtquKiHsiZHKUUzbCDqKFa2yaZgA8fMMPr5NXs5jsQPSGh/nwA9itmfhPBqyqllxjsRDOJfpUyisH75CPvKH2e+KaxW+kieARxHThuqq1UYthJYhaiF80dijs81be8NryDQx72BCfZmN9Wlb2NyNT66YrxLhRypios5TSyqUIz0GQk42NBFyVUr/o/2631cPsZNJIjcYBaHezyWLU2zixKfW8nWlt/+TamF8n1b7Urw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(316002)(2906002)(5660300002)(52116002)(6486002)(6506007)(186003)(16526019)(26005)(6512007)(36756003)(4744005)(1076003)(8936002)(2616005)(44832011)(66946007)(66556008)(478600001)(66476007)(86362001)(8676002)(6666004)(83380400001)(956004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tV+UxiV3v49r1SMCbm1wO4YrSvwnkuL2SIa2l7dNHPuToUkdOh8yLQ6EPNK1pLyHYkEUjmm9lSPLbAeMYJ7Vu+0ggcq7m92OkXQ0AA/+7erZYFSuP3AEb2dqXP9yg1spczVm2n6/OYRsLqRi8CYdTqBhLZipphGcUWAWDzoOaMalxg4E7gV/xc8GwYNyqbUqoRAUYcoRAAvuyrE9FFbpdhNBFbuxUaMdUeaAgDMuUUWBLx8QDaninCnryOOok6o81HN7t+PYp9PYBVYOhXn1RffTj/B8Umqd9CpBYP9iT7QA5/eRAc2MBHHJ2uuGsYtKX6qT6/+UDs89L/SOQ2Q1aqkSoQU3k9NzoJdOWxOkR4deYipnYwDQpxhJjNKU4wFzZ1K0ar5iQjZlh21tM9uPnv+nl0h1y2gjqIEvNE5zJPUl6HXKDfQzYdZaUMhuW6FpYJDPEweQqu68pjoYX9q1Ib7TXkXCOaRsnUOckrqmjCoTIRz7Ux/VPOVTqwRRan2VUHVu4GSYPMDYliMppbVvYt/7teXRH1rRNPO7g9VgXpLOky/+AmB6G8/l7xdeDyEmEQ/+h0bTwvR0T1FHoOS13zhFPwB0UIiWvNYje549nXlcp1DmhyhTnxiqsoZG+tfpYrMozgf5n8/UHpHveHs+dw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81860a84-064e-4405-2846-08d86123a4d7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:21:39.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I17/4YxlZAlTVPME3aVExSt56C8AFfy7J1XxXvUb3mndQ6dBlESOsmAmUgOHen/6JCz77wo3ZEeKa9l5tADT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some bugs about the vop driver and Intel MIC user space tool
-- mpssd.

Sherry Sun (4):
  samples: mpssd: fix the build errors when enable DEBUG in mpssd.c
  misc: vop: build VOP based on CONFIG_VOP
  misc: vop: add round_up(x,4) for vring_size to avoid kernel panic
  mic: vop: copy data to kernel space then write to io memory

 drivers/misc/mic/vop/Makefile     |  2 +-
 drivers/misc/mic/vop/vop_main.c   |  2 +-
 drivers/misc/mic/vop/vop_vringh.c | 10 +++++++---
 samples/mic/mpssd/mpssd.c         | 24 ++++++++++++------------
 4 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.17.1

