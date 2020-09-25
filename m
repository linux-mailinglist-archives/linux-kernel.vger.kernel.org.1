Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B298A278181
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgIYH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:27:28 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:50314
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYH11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9+9YR0EeiFzApcjPrtmzfWVEQWrXwPmM8Xj8TAbOAKzEZqP255ULt8t6D1+GTODdedX/S7T9xnGzoOgt/JgiHEnJ7EyIYGtS2DKdq3f0F/RGFTqJBxoVvB3dyk5VVSLMq/KqIvIQogSq5FNvvHVRjfbbOFog0ixNQe8XFs/8RieGBsMxIm1viyZV2iVTpxHtSUP/HvTkhMY+L9FcUYAnvMcF97kOjX1yb0U7lDaYmEJkAJkTEdGXRlc7chKoYy/tsQKq9AZfbU2njkY2GkadoLi8i8EEAy6hbWbVN6Rm59u0rT4mmLHvbv1Mcx1cI1Iqj8K+VlGc/VZDexbNIOe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1iuCwRt74d2CtCjC+/e5x7CwoAeWxz8GfJIyNyzVJM=;
 b=isyfSy++ijC852ss2Ox9OAKzPNPkh19vbKaS79n1a+n5ny2ihZ9NFKxS51fzQHan/F+IKaKEPnadrEVQfD/WcbdJeT7Z0KXfAzZay35T+KeAoNvWQ1VeC0GrV3JLkeEpBB6aqb8ljaOYHGKxdMszGe8MxuoB6eWqHO1D8H1HyH+Da6pkKpB3NNrAMcQQ5szoH/1Wrsm8pjhPNeC1C/F4rE/pt1ykZZuJMs2cg1P/jpdNXnSJF2R0uMkASYxEfug6abh3iP4Hgmt+6gPrfNby0LmhVVGiRloUs09LDCUJQAjsg8j6C2nhEMjBD/fp14y3RJf2ZlUSSeFTiN4by7XMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1iuCwRt74d2CtCjC+/e5x7CwoAeWxz8GfJIyNyzVJM=;
 b=IP512iYl5Rr8sRreJC/fYUSeuGpzNZZD32r8yaiH+s4I5T0YR0bry4CBgJavGHtZWGLQ9ckDZ9y8qGHMzqURBCUkbkDavxybl+0ninPOvhgBTdA8DlkNQBvkO7ny61rZrhtxSFc2jXdbHtbzoZI8AJxsuDKIADnCw7C5KkiunsE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5216.eurprd04.prod.outlook.com (2603:10a6:803:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 07:27:22 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 07:27:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn, rikard.falkeborn@gmail.com,
        lee.jones@linaro.org, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/5] Add noncoherent platform support for vop driver 
Date:   Fri, 25 Sep 2020 15:26:25 +0800
Message-Id: <20200925072630.8157-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 07:27:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce6cb431-bef7-4f49-e47d-08d8612470ec
X-MS-TrafficTypeDiagnostic: VI1PR04MB5216:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5216EB5B677C7E4BA02B73DA92360@VI1PR04MB5216.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UO7k+0pR08dLMQpUGiP9eqGLMxRI25ycw7b4o49xYVdG+XxkwDB8jzLW7aVJB7VqLMVhec3JRJXq/b7/SkckDLdRGrE0KZUqyXAgmDmFrtEGi7HGtv2vDP+3viquRwx2LnjecHd1HzEX6LmWVZeAsbbdYWezEHNrsiRi9CSQXXG+TQEgfvzNTMWWIJZb3Z/t98E2Xw92hCG3CB12SkI6SXWqYEfE7f0AYvEnuwsvAW2NHH3a6gBedU969s9AA6FX+gYQA/UWyHBtKvfnO72OWGFQL0Nvi/GUfds/3Uc1IXhy7rC/w5vHCgE39HkiNRh73Hn8+T8irRb1ED3gyrwGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(2616005)(66476007)(4743002)(5660300002)(6512007)(66556008)(8676002)(7416002)(44832011)(83380400001)(4326008)(66946007)(8936002)(36756003)(6666004)(86362001)(16526019)(956004)(316002)(6506007)(478600001)(52116002)(1076003)(26005)(4744005)(6486002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WxCa7zQBBwMmBxhgpqyauA0KypYeHTUbg6SWONHs96KgYxtso3SLm27ITezi1g5uwKfkJpAJWiAB+wAX6GjgvhjQkGzAIIvp/vE8tsnrtpOySBYE29HTwhtEWWReojU/rU8KaNr9yuETtvJFbPayYyZUE+a2p5fm3dmT+mT0cqfcTvP+JeGt8sPa7fLyPwmC3DEy6hAT8CuxYb7YKKi1QlPOMgZFJ4pfXbf3PAAaQbGD0u1y3ye4utnXgOgPa/NW+TfniOqQGhf4LTWRyXCD56/8kjPLUiEkyNL7/E3RAPMtqgfuErYX6H/M00qTmykt2jfC+Ug2/4OgxKo14wM4bojG2nzjzA/q44iyDpcBrnk5Tih35YaXf0u5lHkjtbehZH6wSnahebVq4NRGmugYh9m5dmsyBMeAeEfs7iLq1vYAMUOaVD3VllhHJ2EyqMMoLMyecLUZt4YjXAYUD4nF0ARxkY4GZX05zAXsDWBCvO7mh/O+GJnBo6hfYupYOU1+SUR8GY6a200l6cTdjf6xjsRPZE1+kw+kQC+rw/mWJWGBHfD7Oscafldwz1azC6QtX0mC78HXMBgoy1AK4wg/RFUTtJstzQ6+BwkYSsIigpgFmvPV9xC1ohKZ9JO4zNlwOFIJg3Dt7er6yvU/m8OvzQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6cb431-bef7-4f49-e47d-08d8612470ec
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 07:27:21.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPNXbTt86l8ga1YAzOTawVeLx47wsWUKb4wmITs+rok1ZS4G8jKlI9cYNnB7LxotJ/QAZZ2JVH1FIOFxuv/94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way of allocating vring to support noncoherent platform for vop
driver, and add some related dma changes to make sure noncoherent platform works
well. 

Sherry Sun (5):
  misc: vop: change the way of allocating vring for noncoherent platform
  misc: vop: change the way of allocating used ring
  misc: vop: simply return the saved dma address instead of virt_to_phys
  misc: vop: set VIRTIO_F_ACCESS_PLATFORM for nocoherent platform
  misc: vop: mapping kernel memory to user space as noncached

 drivers/misc/mic/bus/vop_bus.h    |   2 +
 drivers/misc/mic/host/mic_boot.c  |   8 ++
 drivers/misc/mic/vop/vop_main.c   |  51 +++++++++----
 drivers/misc/mic/vop/vop_vringh.c | 117 ++++++++++++++++++++----------
 4 files changed, 125 insertions(+), 53 deletions(-)

-- 
2.17.1

