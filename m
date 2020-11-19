Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718A02B90CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgKSLSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:18:12 -0500
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:61721
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgKSLSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:18:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVLn8CzHvRR1E2qUjWzD/W7LFPRAogfmRCtqqldcXDYDMBDrOYWBb02m5pzJZfQ7AVl8POVQjTlWWB0uwHFOf5E+sQmaBqF+kQxSV5ffNz7irvi1RQq5c2lrLYmQYT+GWYicoENBBmIbVT+GOGbUAdUOP5bmPXHYnHrATEcfOAL6p0uv8Wux7gmfSrELQwQrH1SWweKqAPjHBNr+nTDROM6CvJ+TESE/6k6I6C5yf3PNhelYysqEmcI3qkvztBxhxS0VqtOqg9k1pwalRN0vZSO0u+gP9R1H7Tmcyy6W8lYoanJMSbMKtq1HKB/0ZDZoB3o095fq/F9c9LznkNNhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdG/Usm9xsTAwyfTpNgMq9/Qh/v8LFw7Z2/o1WlPyDo=;
 b=NIggY+kATOSTLYtaI1wHlS8mIXkzqpWSQ8Jj3WIDhenZmXVpOWlwAAOGO/sQc8gyX6CPHzhew3knM/EmXU3Wf2ROVeeWwYDwdzPtQFHpB7CPR49iVnMPzx9wtwqMP67Vm2Sm5ZnYCus/jFxj7oY0RIDs1AntZTUcHydpN0QeFi2g5Lpubl0nF5+K8Guc7+5JhODEBuepLvsflqtew425GXaaLsg5CohIbG+OvwmPwojhcWfmVWWwFRyvlH86nhtScvUbTaxkhLS86oQboH4GY1xoW8rvGjLuzYlXzGkP9PIfl1yEb2Y8wNkF2X2zQ+kbmEMBuyEHjMtMbp5mXAHblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdG/Usm9xsTAwyfTpNgMq9/Qh/v8LFw7Z2/o1WlPyDo=;
 b=pweYFg7VE9MV4GBiDqcHhUy/GOG3YCd2dwgGxqk7//3RYtmBnDAJXvPbB3vvnA1DgnWEoghkyNlDaNw1P4bVhInbuAEA2HH5lM+qRB63H65ymJsOI7/xH+6GXzZsKpu3S+Gq/SQra03mKHfa2VNPJaItQHaOp3u4+eXV/k/N4b8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 11:18:08 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 11:18:08 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-imx@nxp.com, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] of: property: add debug info for supplier devices still unavailable
Date:   Thu, 19 Nov 2020 19:00:35 +0800
Message-Id: <20201119110036.19959-2-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201119110036.19959-1-aisheng.dong@nxp.com>
References: <20201119110036.19959-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3589.21 via Frontend Transport; Thu, 19 Nov 2020 11:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6673b787-786e-4639-3ecc-08d88c7cc9ea
X-MS-TrafficTypeDiagnostic: AS8PR04MB7687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB76870FDF668CBEE792B7954A80E00@AS8PR04MB7687.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKiYkhbUgjDi7eioBqpBZTyxq1AMdDZ6ZTOuqeqjQW+MZaqpA6zBBnXG6WVo5mT+Y7y4NGmoHiOSjd7wZO78HExJ5frDprommzVhDGXmMlNphhN1rXsOYx0uqVSRa/cIGZv1mrtZ9JC1I7KvcxKdwkn4HS8Q5d0NzbApVZZMrW1iBVjis7fciIROO4mPVoT2ZPIS15E5k6MPBlCEftlTzM8aCGezV50DuywlQWsdfga6V5NIAJuLXEIPMkZDh6Z2nsU4jLuRmeLTE+qrNG6qchw0nXr1PWiMqz57UTNdm02snWAcos4ThuGhIusIlUVo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(66476007)(66946007)(66556008)(6506007)(52116002)(6666004)(2616005)(6916009)(4744005)(6486002)(316002)(1076003)(956004)(4326008)(478600001)(16526019)(2906002)(8936002)(86362001)(26005)(186003)(5660300002)(6512007)(36756003)(54906003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B7yDhYUm1Oj20poEQfjRDCM1fYv1FfTXeKrrIRUAwxoGjCUgcnOajQeMty2w50TkijHb6Tpy51rL/7vuRJB0bQNyp3Zx9uOp3cqvOvlQwwFPTRJxEIOnCAEXs6J6lHrtCAjT0nxGz96fECrCQ3bCMCg3rrUQoT918qUa5kIcrbpk2OT74BVq2lA5qxOh27kvk83vjJboeq7bnBETeHadhnGV3020gnzfrwwUskczvQbJ8pKcZxp35xDkBa7dGrqywH9l0sNMvL+FQOqRSuAqDSGi+suY8XhhEDE2zIWJRJt+iQcnTsSuxry3UJ0jeIWHIiiRbRXKqPNhXz6X9sDuGkBZHPdG1fkpVxFZTx1R2bNEgn/SFNHCn5dFgypLiffQSSi01Qrk9dtS0j65EGPjoednH1kvAVGxcl34rCeoka2zUfAqxN/dvbZNImBbKcuf4BdWpnydxA/LCYuxeJPX+L8LFPSl2lp9IsxA+xA8LyvVkYtdxhKh8/qYyBcV93VSAZoeMRksEBlScGzocrdD8EgD+g1/O5Py9n8ncTUjbZi7cIbmNcTLvmFHvMrg7+4AtyUsWHzKG+qmV/kDLMbigZyykONtTYVOnjuOhB+SCrYyjPmwdu0Hn67hPOKxwFihAW80y4txT5eS5lZW9NV5uQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6673b787-786e-4639-3ecc-08d88c7cc9ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 11:18:08.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPNGpIhjz4zglv3oynI9YRCKiULQQNi3fPUkpFN0GwZK3blnZRxz6QasnguIYey1VRvMhO9uQ/+0M3V7FF8GgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's normal that supplier devices may still unavaiable when parse DT to
create dependency. e.g. supplier devices populated by drivers.
Add debug info for this case.

Cc: devicetree@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 408a7b5f06a9..21a854e85234 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1150,6 +1150,8 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 			 * Can't check for cycles or no cycles. So let's try
 			 * again later.
 			 */
+			dev_dbg(dev, "Not linking to %pOFP - device may still unavailable\n",
+				sup_np);
 			ret = -EAGAIN;
 		}
 
-- 
2.23.0

