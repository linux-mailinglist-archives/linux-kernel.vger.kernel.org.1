Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8683294962
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440502AbgJUIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:37:00 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:59471
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408113AbgJUIg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjdrq1DPK8H3Gcjr9p9radct6o9ZlXxXohYsO3U3iUo7FwVqqhoSJ1U5qHwsNRp/TuDfj3ZbXWGzG0keKZenEWva9ayEqlUibRyQR8mjXYQgEZMmMI1m+n+jWB8vL9wcqf0A0ARkqpB6/Dq3EljazDIVC+giiQp5YqQZgP5/gnMqh3+O0BAbWeBqCGrImVmMGXboQvfpE7AdmLhX9Y4ix1zqH58uFfH1GL1XhLgo8d4U+lljvfsdbHHyThaZ2kTAQpajAoYiCiGS/Bog/xS9kdf/8LLvgGH0J3M9iYTxfn8r+ukb9CVHnkg54whvRbqEkdNRbHzYjYFa+rnosUvjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjBlu8dd+HbRB5BRC3rgx3KdHTCcot+sQJdNGJF/i3I=;
 b=dIgcSAgic2PTCWMSYa6G2XTVpLpi6WtJAcQKwm8bSB9XLrVQ8TkWZc1R6Jtd5qOSm0uzieufv2BoI4OxLW2mCTW2hWv16e2rzdrhju9MT2WMM0vb5m7aa4DgTyDfP0srO/AZLnGyWuPGIn9rORgJ9SkAO14tjLDnuBXFl0uT0i7JaurnzjWVZb33U1a+RA7XSp0XZa3oaXNdrPmuhYl7L1wBHvt8OoMXtiPGclJXUQ8qBuSBRwfjgH2XlOLmRpdRevZIK8h78Kg39m4nJKAAmrQ6b13Wr6TGq9hXO5AlTJIBwkEOYOZJYqu0S/EiNK4gBY+ZxJgiwM60kuevX8OBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjBlu8dd+HbRB5BRC3rgx3KdHTCcot+sQJdNGJF/i3I=;
 b=I6BB5mokONH/Lx0P9L+e9e/VYpqgabB20iWpvKOsrsXBqiHJywd/+gPgnfhqagLJ0i3rVaAIXXA8wX2nrSh9/BnNY5M/h2vpVFYUOIv9fqzO65fWNwpXFYNEgU1TG4bF4pUX6aFESXGhOfzDbQAXzd8XWJh7P1rrjbUw33tlmnY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2376.eurprd04.prod.outlook.com (2603:10a6:4:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 21 Oct
 2020 08:36:52 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:36:52 +0000
From:   peng.fan@nxp.com
To:     sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] clk: imx: fix bus critical clk registration
Date:   Wed, 21 Oct 2020 16:31:29 +0800
Message-Id: <1603269094-29367-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0155.apcprd03.prod.outlook.com
 (2603:1096:4:c9::10) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0155.apcprd03.prod.outlook.com (2603:1096:4:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.4 via Frontend Transport; Wed, 21 Oct 2020 08:36:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 061eba6a-1e53-4029-8d73-08d8759c7590
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2376:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB23764DE109E50F067EA602E9881C0@DB6PR0401MB2376.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVqWRAPP+/9/mk9lI6akYRq/H6FeGKvLpVcZnhcG/2TRQdfXdE0YRZ0xYCixHm5dz5YxAwwdO/KHVfWhu9O3r9wS/ck2jx8LdwXPr1SV8hdZ1GBIyvW1yq6WLR1r+cq6IiD3jxZnaIPoX0Fw15sRcjGgom3VI8ZSDxT6YQA8W29bLAkCY6XRS+E06ApMz8uxzEwkyb75qYRIlW6DIV9ugmRSM8JqPadw7eXyAFt3Rx5j7pOgT8DBm8VhpChBs9Jy7Vocf+M6Um+OU1NqlnJpB+0PEnH6rwFYEBcNgFI0i8OmCrEa1zjYMXDunjcovkoX2SNPjK4BdHyNZkbBvdf+3WsSveEN9PWsKLtTjwjr9SUejbxaISHNbwi1KKCEJ6rL/nrYroCfvblOVl+m+s6rhKek+J11CQgwmoaKmkqn8+kZcP7/i8CAJBk1ZH4MMdms77G7yfxT03zC5iN1iIdoxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(69590400008)(956004)(2616005)(16526019)(966005)(5660300002)(83380400001)(26005)(52116002)(4326008)(6506007)(36756003)(316002)(478600001)(8936002)(66556008)(8676002)(186003)(66946007)(9686003)(6486002)(6666004)(86362001)(66476007)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0IMl0VFbniP0pTK310LB8JyNn6geyIoepQHtDp/wwtC9e0fRWkBpSB1/Psz0QabeJGaMU/nPjDpet8sHVDChvpfCbZ2A+LjC8x46CZit3oRMab8UYm2bKgMeRMf5+z2AFffzg1yxK8sLbQO7MQCarHqzM1UE0A18ZEfaDfWs4qPoU2GFSO5JEU4CB5ponYIG1IqkD++bsnWQCRWvHcXpwegn4psQVGpDilqJcpUzwkVLeDv1hrGMjign3/fJK94hIwkLG5oI3eyGalDErdk97eqlJKGivSTcMRTGPl0eCUKY0/FN++56/ZB8mCAz/np0yhmMRKrwaCTw3htsveobZ53tdjQtANlMiW/mHf0r0Vugh3t69o2CL/8zEpbdLpyz/QuHz4m0YnBGhudZei5T3X78Iu+36gOsgpAiHCUfYk2/YTvFdVZK6LOOgv1ShjKmnUVm0fbTL/vIRlQJnt6Bdhm7AYnEl59vcbNHYUcporI2fZsXA3C16r1WhbZqhmEytFfcWMXol1sGfyYVReKlp6Gz7qQLAACEqcfV9TpPGBvKHUhbMcgBFUAZr11dBDL+n51UFppZlYkg8PErBPnRkYAqRDnwHrQeKbNcJDYMOi1KWYSndFrxdlWOoaw0T8jungYfXksMNKjlKW+pgGQ/ug==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061eba6a-1e53-4029-8d73-08d8759c7590
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 08:36:52.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woiyPXXeVTEYWe8Pa30mrYU5xQ0EOAdsR0x6Qp+BaAPQ6PaXbkqn3FHczH9fJcGoicEbR9GmA+3112Z7dkFlHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2376
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The issue is exposed by
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/
linux.git/commit/?h=for-next&id=936c383673b9e3007432f17140ac62de53d87db9

Since the upper patch not in Linus tree, I not add Fixed tag.

The issue is bus clk should be registered using bus composite api, not
peripheral api. Otherwise we will met failed to assigned clock parents error log.
Because peripheral critical clk has CLK_SET_PARENT_GATE and CLK_IS_CRITICAL,
you will not able to set clk parents.

We need use bus critical clk api to register the clks, so introduce
a new helper and use it.

Peng Fan (5):
  clk: imx: add imx8m_clk_hw_composite_bus_critical
  clk: imx8mq: fix noc and noc_io registration
  clk: imx8mm: fix bus critical clk registration
  clk: imx8mn: fix bus critical clk registration
  clk: imx8mp: fix bus critical clk registration

 drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mn.c |  6 +++---
 drivers/clk/imx/clk-imx8mp.c | 10 +++++-----
 drivers/clk/imx/clk-imx8mq.c |  8 ++++----
 drivers/clk/imx/clk.h        |  5 +++++
 5 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.28.0

