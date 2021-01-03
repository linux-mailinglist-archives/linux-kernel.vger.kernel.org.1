Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AA2E8E35
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbhACU6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:58:05 -0500
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:45793
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbhACU6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSYqBe9eFiKGqNld40wk5dLAg9iTL9X9nF57YBvMhTpdegbQ2P4rNue+ogXygNoavldWIFP25jEjnDcwUKj7MN4Ox9IDJzt9MGX3uCMzoVSdmnkFvatZVXDBmPuWjf8DgE+6qGqX1RaqRyjQ90M2AXZXgMpCWDnElr+MVNSTwsLG8LY7J41IzjYcwRMUtS3US+hm+7zFgzE3L70ArPViLH1To0QdwxZ/5wR5kNOSjNFKzUEtHoQ08VAj+ab3famVReGInZvbHwOuDrnw7ik/9RpHsaUUw7nFCH3Q91LCmv+vegSgVvvzn1GyYpPVBy4xyWc7cGV+dX8jznqRoFvsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNLyszE8AvaxnP3YZjiI/P9AVnIXr3o/3i8UGPpU3+w=;
 b=TYhkx8K3ahuw8jkB2MqGhOaixi0+pBI9f0qCM31wPYpfFt+HW5lWOaYoTOOjkHl5R1Ps6V+SJw3K75zSAwVlue4g+kKLbW12OCTKXI7/274C045MG9nIM+3Z7emYckejqTBznDPQaJCUASOoZe+FIxQTwsNsXPvk3WloBzmi5mXkeGlyY/c91aOEXzkkoFRT3/uW5ttbJUcXnH251CujtoyMkE66XNyAUS/6fN5Ok3kCaMTbNgefqZmYauHGTof1ZaoqHv9hFTgpzxv3J/zsSMWVpH85ZjW0Q+SizCDimhPzbfBbb13GA90ZXiGaZQI1u3OaXETnhmCFosiFwzRS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNLyszE8AvaxnP3YZjiI/P9AVnIXr3o/3i8UGPpU3+w=;
 b=x3U12dH9cXbVOA2TnHDMZiwHBmHcwOin6Zrnvkwkd79g6xdjcWC4IpflTbAfwVjj/9/rjRiiTpYHL9ARRtPrR9lf7eJkIGrmXXEhtKc9g9EI3exP1UNCsX1+q1H/xuIQXxrUqnC3hRpcYP6afZdXs7kl08B4/GLR8Jgzm1oFiiI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SA1PR08MB7152.namprd08.prod.outlook.com (2603:10b6:806:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.24; Sun, 3 Jan
 2021 20:56:46 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::b568:46ab:17f2:c918%3]) with mapi id 15.20.3721.024; Sun, 3 Jan 2021
 20:56:46 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 4/6] mfd: iqs62x: Increase interrupt handler return delay
Date:   Sun,  3 Jan 2021 14:56:07 -0600
Message-Id: <1609707369-11297-5-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609707369-11297-1-git-send-email-jeff@labundy.com>
References: <1609707369-11297-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: DS7PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::28) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by DS7PR03CA0263.namprd03.prod.outlook.com (2603:10b6:5:3b3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3721.20 via Frontend Transport; Sun, 3 Jan 2021 20:56:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f97d342-5027-4b2e-6121-08d8b02a1515
X-MS-TrafficTypeDiagnostic: SA1PR08MB7152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR08MB71528604FF143C4EBFD66A1CD3D30@SA1PR08MB7152.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ9A80KPM0+QBsx28o6dAnYB9l4HKifEn8yqn0HOBa7pA9lTK19xLZ1uY7gbbNHGb5zSBbcSJehj1sEFFmMfUgnjOKXIgVBk93ve2dZ93vHjN8dprRv8FAZ7TVPuRlkB9TsrmfDmKPW7/Tcuso3uUvnZhryHgJ2hNrJGI1MkgbFY+ZPbylVKPT48MkC5wT5+i06IE43dfD5IOP/bLF3Z70TKmO0DDstQp6gt661cJqT1mSzv7NvurfJX2YwyAcg5aJtixSiDYhDVkogeiOr8q2TQwkWsQUakj3DWNYciSt/wnRTYugW2xFeP5YhxdZ+rbBM2OZjoBJiO3L5a/segQwsmMrDnnzVZRBcPUSSXYGtAm5IoMdqUA2FHxJxlZv9otN7BfMnxroNo9OyByVd3Dunpx5bH6cMVA+RVAeAnSHpDkCovcFHd6Mv9FNGlpCxlTC4cBNSd3GmApiQKC0OFLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(346002)(366004)(6666004)(107886003)(6506007)(86362001)(6916009)(8676002)(26005)(2906002)(316002)(69590400011)(186003)(16526019)(6486002)(66476007)(66556008)(6512007)(4326008)(52116002)(66946007)(83380400001)(478600001)(36756003)(4744005)(2616005)(956004)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N2UQNpEYUATttKvwa6T+rI6jHaGLR/5bVz/GbyUDn7pHCF+RZJLkV2Jy8Wvg?=
 =?us-ascii?Q?JrKq7+eWT5S5uPCiaky7EKn1obRBUXDiT6wMhdy8z/kot/oCZeWFBBdou+t6?=
 =?us-ascii?Q?5/lmWQxU1knrqPHRqcd8KpSnOnDm4rLSjUXjczUEuuvKDYjZjvQipoCJiHfC?=
 =?us-ascii?Q?2rnmcb6I3UGuCXfwUcgdefcAvCne7JkCZFCbsbZy2fiEhMhldAkAvZ9XvClg?=
 =?us-ascii?Q?FvWpHlCcThM68ORG0tKatoLE3O99SxplgABMNlm3DjiLXhs3xfCeHyg9meEZ?=
 =?us-ascii?Q?T8ZarEmoA1D0+1S0tyykiVShVkFSlswLoX9vqobPMQ6m+kUFInUTZDp9UTxh?=
 =?us-ascii?Q?bp1BKpZqN095IK4LNv25zFYE1+V8pYyqXNONJPINU14cZ1CIPlXKB/BOqFOw?=
 =?us-ascii?Q?pAszdxJunyfCmcGamtjpBysa3b+viq/5f875kis4g+H3yHZB5pjAwkDpBqGa?=
 =?us-ascii?Q?cCCeVZBeVYL0jSULn3zCTqcEFpJvP+BLJx22yNGeOt15hkryyCH4GBR+/HKh?=
 =?us-ascii?Q?UpMRyCkODrxYPXSBXZahehnr0tyxB8Bf4Vj8ltQENlcQLt1vnTBsRyb1sCyN?=
 =?us-ascii?Q?kd2rv7j3yDrbN/XhzmXrWOqoSaJcXE/1AeuXcqhkdRVHVH53lBWhVblrcEpU?=
 =?us-ascii?Q?XisKHn4W6k2zUTG2wVCDhLqhiunBXzG00DtNtg87F3kdNQpRlLE/4XTra0pL?=
 =?us-ascii?Q?gvyqB9oZY19OsbzixLJZx5dCh5oXGHHZ6AvPFvYlUSREacwjjw52YfkvIIBf?=
 =?us-ascii?Q?wnU1UcKI4WB1drVEkg7qLNXMQsU1I2Go61WXIiUwkvPOC4HYK6Vrnigoj5Ow?=
 =?us-ascii?Q?N2UXvstnm754oJonGPklVpKi/QOl1ip7K4gp6f9ZKRsrGq1y0/i5lUM+T9ry?=
 =?us-ascii?Q?l63/OXDxkexxdr7yU7x7rQh5IipAWgpRCed2jAyUnlUuIOMqn/j2H/ajKLuw?=
 =?us-ascii?Q?YFIByuG81fFfLaBeaU25lxwQ6llUUDHuzTZncgnp1Df3eEQpx/foNDSOyf0r?=
 =?us-ascii?Q?n9gh?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2021 20:56:46.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f97d342-5027-4b2e-6121-08d8b02a1515
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sK3kkjozZXQUwxDpgBIZkQ0hswCT+rIoV8iJG/pTr/V6dQ8xY6y6pLeewvS1dWtm91M2L+veGp0Hlad1j/QMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time the device takes to deassert its RDY output following an
I2C stop condition scales with the core clock frequency.

To prevent level-triggered interrupts from being reasserted after
the interrupt handler returns, increase the time before returning
to account for the worst-case delay (~90 us) plus margin.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/mfd/iqs62x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 7a1ff7c..07c9725 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -533,7 +533,7 @@ static irqreturn_t iqs62x_irq(int irq, void *context)
 	 * ensure the device's RDY output has been deasserted by the time the
 	 * interrupt handler returns.
 	 */
-	usleep_range(50, 100);
+	usleep_range(150, 200);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

