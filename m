Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30D2736E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgIUXxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 19:53:01 -0400
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com ([40.107.21.108]:48225
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727124AbgIUXxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSRoVN+7eCcnHtbBNgUs8pB+LV8aRrEshggXSU4T6b88DOoSbpM1AyyewcDOlZyhc0nK1CE8nvFLqytO1qbCEn023EBB61dgfg5WjNXM3UhPABbsqEqaMfIUpqorXAN+hwsPeYjkxsp8HSss6XJ7C/1FtououZBVXaKf3iNdvPsJ18FjNb50P+pdH9RCOkRiHRQquufR2Yc7f7to+nUpFAn/GE1xYfpFxYM6GnAqJwWVq22LeouYhIGT0Eye/aNe7DL4quSuG9xtuTuTOfTkXY5EuWsYv9n/8KEabj4ikjknzEGNXFqzTPoDBuRzP7rN4iOQyNSRlmkbz9JHrpjhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U0pCgg+rAebkggTpxJUnwCwSVLP5zy8BT215l5jVrA=;
 b=TL8BCPvV9iOl5dMaYXm3SNmtIw6mDZTgzO8KK58BbLj7uw9kBJlq5ISP3QCfnA/WipSuz3sTl6W/oG3wR8h+s55HVED/aD8lrwfsb7+owP5ynryPmmSjt9tLOaLi54kFTaKlR4r9y8QrsZG/eN8kWlDcb8n/no4oFfLHsNJP/sRrTmukFv8+86nKJoXz5ZY3F1zznOtHSHVxoo892uhlIh8+Br2IhLmMAV0rwI15YfNmvBhHt5i1gGTjdPuUTrg/F3kQA83kGPLZhJudBNgq9cpyySvIAr7IL4JNKfpCOMx/+oELcNzmSHaQsV1r1oSbeKSnsZbrEyp6obwi9pG9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U0pCgg+rAebkggTpxJUnwCwSVLP5zy8BT215l5jVrA=;
 b=ZDt8Bk9QsKlqEhwGd390/Gw9xkOtqflGYbSSoMm2pf1X09SwCMoRVK3WttQlNuoor3dHHpiVnEeecidzlqCLMmOKMQiZ1im2x0xAj+GGJEqEEw6a7XN4PBZna6QP22/TtYgMWjsCdsygnBYjUeaug0KrbO1Y18gUKBpR71K0nxM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0299.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 23:52:55 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::c1ab:71de:6bc2:89fe%6]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 23:52:54 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 0/2] Add ONIE NVMEM provider
Date:   Tue, 22 Sep 2020 02:52:35 +0300
Message-Id: <20200921235237.7980-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::46) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM5PR1001CA0069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:15::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 23:52:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdff5d07-11f2-40bb-bf8e-08d85e897530
X-MS-TrafficTypeDiagnostic: HE1P190MB0299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB02997B00516D0973BDCF973E953A0@HE1P190MB0299.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwHNkDhefEmUyv0Pn8qKTwZyvZP1v0H4rU5HfKtIK3f8+Kr8RaKR8WNGSsgotMC+nhqs/8PXqhMEC7PLzKhsFCT6xOPn+fvVl7ajJfKg3H5f/JaH5n5xEYpzAPrI35L2EO2U8n8sYLzWQjJD4FG1mYnDAZJStVC0NZcEn8ULWpykG5iCtFzCcUre2IaCGr0Zy9GvKDxzD0g/nRCweZiPX7rapopOtcSUenCuCWku3AlwzbqV2JEwanM6SOksFkIIeQ7agZG3Nh4amkEFz4QjWMRDt3hxJPouPd2/TD5y9HNwo2G2fSRquuVT5C00bjrS6YPKFhCKbhflxsFUdbzjPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(376002)(346002)(136003)(8936002)(2616005)(110136005)(4744005)(316002)(8676002)(44832011)(956004)(4326008)(6506007)(52116002)(107886003)(478600001)(6512007)(66476007)(66556008)(6666004)(36756003)(2906002)(1076003)(5660300002)(16526019)(186003)(66946007)(86362001)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NvVxehSXXrQnOqTsc6/BhdMeOGckWNnZY0AYxHZ6gtHn7SMvkLy0UE2iMxoi1sCYPRqiZx4ei7t9fgU6dwsjuBJbnso7C6jWAWfo7eIV9TfYkTvBHzlZI1UkiD6YsBlQOSH5jbkkCdZYb3FPb8Nq8ZkgYE2XFRNFFBnzaStYK6Vge+rawlpFMaABNhsqMuEe2f9TyvMXRnH25nTCLM0btNROq91d3SzYcnI1TwPK7XDUMXKfC/g6XZSFgPLeOXq+6MtHOpo1QGpbH5FhC4osv2Ol40Dk0EKIHavtuSa0fZRpR3+XEdnobP+ew2ksCxOa41Ex7MQipN3nFu82P8U2Azi4x2Ver/BF7S9rS/S927ATG5pGvB58OvvR48q7qNyFR8+h7y9aIrjsPWGx7UHZU9TesLquQoGZX5530YXcgdYysJIhzWa97QbmoyA+Z3AcUaAzyKI+Gk3AJtGZqg1tsnmeH72hWBeUoqNAzEg/BPYbZODzs7eIQd33qWiapZZ1LQuyIddqsL3X4t7Qk6Vwe34QLH+5tHUHuIYvybweAc0wHVcZNKo3Mxntg2g64OOocH5RHetuCKIlJkttn/1cYf3ZsuRmkDKBlBEskWlqJs4iOdBfHyFpwzXspwDhTKkmeIaClz15JwH1j0CrkxUz8g==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fdff5d07-11f2-40bb-bf8e-08d85e897530
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 23:52:54.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TECEMpZiImvh9iBYf7ctoJvPlEDr0GcxCxrsenAuP6WHlg534DmMH0h6DmtJxtCvXW8fbF9fOCr67mWA6251W9IPATjFj5CE9hkDf7GTws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds NVMEM provider for the ONIE TLV attributes which are
stored on NVMEM device. It adds possibility to read the mac address (and
other info) by other drivers.

Vadym Kochan (2):
  nvmem: add ONIE nvmem provider
  dt-bindings: nvmem: add description for ONIE provider

 .../devicetree/bindings/nvmem/onie-nvmem.txt  |  11 +
 drivers/nvmem/Kconfig                         |   9 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/onie.c                          | 357 ++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/onie-nvmem.txt
 create mode 100644 drivers/nvmem/onie.c

-- 
2.17.1

