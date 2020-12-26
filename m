Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A222E2F72
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgL0AAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 19:00:10 -0500
Received: from mail-eopbgr670097.outbound.protection.outlook.com ([40.107.67.97]:54843
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgL0AAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 19:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Da2sFj+wF5h3BaCfsAac9hYAOXHXcMP7M8frV1xRTE89IExtyuKJOSpV98plBhWCaHFxpdr+U09acXq5MIYG8/Rx0GKWV7NBG3LCvyy7MpK6L8gTf/T8MUrV7PM8JGB2EHlwxLHLEiJkdkFSglX6jZw/+1UEF3y8RKKGQoyUJKuYCv8EpFmbi5kLnxwPMnOg2H1IeIbhIA68/N+VF0JyqwBean3wB2325hoZIb/VtlwS3Ci68aabyjEpg48n+5gMV2LFEEnitkSgKvPr44nUkObg3Lk91fqkJr03673vLToE9dOqJD2BH6osrTm5EtT9ZUZKTUf0gW+qkjBibYaCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3DYDQ2TaJuaMtXLzrtNWD1pu7oISHgpEYFRobaCkz0=;
 b=XeSg9JMrSclToF5l3JbsvtIQlUwnuZ9mnK+OiPggCAkPs51AN4FNUzA9b2YgcQlsVw5SPHe3jw0FBve/TBzZYJKn8TL0H01EebmQN630C7+QmyE55rpIqbxdzCPKVRxH2FapHhoxyNDfXwW4QkQQRwKq9ofZ2e2/+ZcN3McEas2WzZC4mKCArSHjIa7lYM1oDrvBnx28bBdzbIOT0Xjigy+6iyAs9vJeMEeV8Hn8hbQIbwH4XR6MU+2W/GLoIKsgw+gPQnJ9e0GvZ0xGB7YLGDWo519QiUhMM/FSFXxmeeZPNEI50vlalu75sel/23+vwgkERZdCs6IjCq7XQiXYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amanoeldawod.com; dmarc=pass action=none
 header.from=amanoeldawod.com; dkim=pass header.d=amanoeldawod.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amanoeldawod.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3DYDQ2TaJuaMtXLzrtNWD1pu7oISHgpEYFRobaCkz0=;
 b=UT4NQb5vNXve0Yo4xD5AmwA1KPGedgzOtYHk/4DOplyu9RYP3p+V0kul2W3E2bqP2epBY+xrbp/6W/1V3LjXqhqODETWgjmch31ORlX32Lvu37uUp7eV9eLVZfdXvppFRQd0FAu8rCoCDeJ0++7/j1woJ+M5ihC3Yf5C/v9CMMA=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amanoeldawod.com;
Received: from YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:c::31)
 by QB1PR01MB3137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Sat, 26 Dec
 2020 23:59:25 +0000
Received: from YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4dc:21ab:5ded:e779]) by YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::4dc:21ab:5ded:e779%6]) with mapi id 15.20.3700.028; Sat, 26 Dec 2020
 23:59:25 +0000
From:   Amanoel Dawod <kernel@amanoeldawod.com>
To:     daniel.vetter@ffwll.ch
Cc:     yepeilin.cs@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Amanoel Dawod <kernel@amanoeldawod.com>
Subject: [PATCH] Fonts: font_ter16x32: Update font with new upstream Terminus release
Date:   Sat, 26 Dec 2020 18:58:40 -0500
Message-Id: <20201226235840.26290-1-kernel@amanoeldawod.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [99.251.240.29]
X-ClientProxiedBy: YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::36) To YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:c::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ugallu.localdomain (99.251.240.29) by YTBPR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Sat, 26 Dec 2020 23:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12465754-93a5-41ff-7ab8-08d8a9fa45e1
X-MS-TrafficTypeDiagnostic: QB1PR01MB3137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <QB1PR01MB313710EF7895F79E7F065E9EB2DB0@QB1PR01MB3137.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4vHTfaSEHRd5XB515sYW+Bd98JNE71FJTdFLfXzBqb/Co4SJBz5PYlmmShodqx/UlO8+n8gicgiTzi1i/eRAd/XBE+HGqdkGWNF9CiEGYYIx89KujvhZLT6jxsGD29LcfUav4amTMMQA+IIm+Z7Wl3/TPF+ltlDibUb9fhUa4Mw/XYFxm9GWfLCp+q3bzmJGdGBwxbsafx+zuYD7mbQGe70qTh1b4FI3Hflezx2IRtOjkTmBJvFWm458uSaHPA0Y1EPrUvsXqpN0p3VwOa+0VzlZ9rY5aYRxKyov+oFx7roOZir/elQtsyRz8SUFNsBpm1cEXvZodmZeLASuCJJzbmRcBBVruxbyFvfq4TAxuITXTUnXU3fuNefqfkpuNRjDSfMkMF85FKZxdN61skb0bh9XCrNjNl18/G5kdkCB4FNpJayh4p8U6hAvH7W1ngasb391WUf4F62jmP00te8BsC2hjHqFHmdgaRU4z+MePK95yfLvMJJnW4AeQr9CGwTkqZ87+Fb261brFJrRTDiAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39830400003)(366004)(316002)(66946007)(26005)(2616005)(1076003)(966005)(107886003)(6916009)(36756003)(478600001)(8936002)(86362001)(2906002)(956004)(8676002)(16526019)(186003)(52116002)(6486002)(6512007)(5660300002)(66556008)(83380400001)(15650500001)(4326008)(66476007)(6666004)(6506007)(376954003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mLjgAl/IHIA9hHW+w+th31uQihQN9rJ50ASQ9pYxw2fjvByCoDJ8uehpznGO?=
 =?us-ascii?Q?iMW2uvIz0pjm5wGn3/9Zx4yMWocon8hRTP9uo1LhfslpBtksIbPjoasM1GwF?=
 =?us-ascii?Q?oBNyhx8B5dytyR7jy7wXI3l7ZQSsf0CsTf0L1QcSNdk2B88+j6nQWuD9zNS5?=
 =?us-ascii?Q?ZqnTDz1DbZPBjtvmFKn96fFONZKt27gLFsBN8WNWp2zknKJXmEYqDr3VP5sC?=
 =?us-ascii?Q?Wel7kiK+d80tSxeLC11igh706dwC6VDiGXMJZH+7aEqguOhzTTH4c9TmHYBq?=
 =?us-ascii?Q?52ZjzEHPIvycDj9AObgrSvZIk+ePPIhvVrSi00GXMn6qreBmBkwXKBn2jQt3?=
 =?us-ascii?Q?TBwkmPiuRTbM6O+kLdCgFq+610cp0VpqvpnJHZw/5vrnyZPnVT9jJuYzZhjL?=
 =?us-ascii?Q?oNAVQ1E85XO6LxsfFCAlNZCtMwugeLHJI1DxnSxEM8di9mJXUlhukq+IvCa4?=
 =?us-ascii?Q?R6zdyU1byBGD96zeKporNzSvqWJeZ6KO+tTs7n/tBZZSu3Iyic3HV9TBKI6z?=
 =?us-ascii?Q?85WiEPoUsui1sNSKW7DPn+tX8hBVTgrBbnBaBSGLPHLKpLYRtFGsPLR74Kto?=
 =?us-ascii?Q?PD/HsL8y8it8ZXGSYWskdHyok3TOUQksC8CBtM55Vx+JmOna36XPlKsaCxRV?=
 =?us-ascii?Q?qi4o/5lKvO7ySaXCg2xOfDgoplxADzxe9k0mtl8Fhxpv6PYbqM7OOblm1Loy?=
 =?us-ascii?Q?hqxgZaXCDlhty8MH4OE9orhpH5F8V1YiCEeYbCByf+mAf1GEsnbzqmDCx2zf?=
 =?us-ascii?Q?NP0CkYsgMK2ts+UZrsl8+j9iuOQF7ZksJsEvVDEK0xrsQaQbQCP/VnW/3zqL?=
 =?us-ascii?Q?zq4v9VMaLmQulD8bStxuGFU0N5lXIzB11BtFIicKPziMAs54M1DaraWyKfO2?=
 =?us-ascii?Q?By8ME1Jun9bzCll4Hk0h9VS7aMrLJuWnvgLzxp1DANg8sgtJdl1s3VN9j4mK?=
 =?us-ascii?Q?PIyj6btx0S4du6Gj4iyoxnaZhwRWNMxUHLXCraizO5I=3D?=
X-OriginatorOrg: amanoeldawod.com
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB0769.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2020 23:59:25.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ef867f9e-891d-4268-9a3e-e63bc74e43cf
X-MS-Exchange-CrossTenant-Network-Message-Id: 12465754-93a5-41ff-7ab8-08d8a9fa45e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLavqHWdFfwoFGCgDo3OWwn8Da9Dn0wkPgI2m+++fwDxbPFNs6Nas13owiW3rcZw8VVUAbwFKJBy3pOwpXqchA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PR01MB3137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a maintenance patch to update font_ter16x32.c with changes
and minor fixes added in new upstream Terminus v4.49.

From release notes of new version 4.49, this brings:
- Altered ascii grave in some sizes to be more useful as a back quote.
- Fixed 21B5, added 21B2 and 21B3.

Just as my initial submission of the font, above changes were obtained from
new ter-i32b.psf font source.

Terminus font sources are available for download at SourceForge:
https://sourceforge.net/projects/terminus-font/files/terminus-font-4.49/

Simply running `make` in source directory will build the .psf font files.

Signed-off-by: Amanoel Dawod <kernel@amanoeldawod.com>
---
 lib/fonts/font_ter16x32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fonts/font_ter16x32.c b/lib/fonts/font_ter16x32.c
index 1955d624177c..5baedc573dd6 100644
--- a/lib/fonts/font_ter16x32.c
+++ b/lib/fonts/font_ter16x32.c
@@ -774,8 +774,8 @@ static const struct font_data fontdata_ter16x32 = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xfc,
 	0x7f, 0xfc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* 95 */
-	0x00, 0x00, 0x1c, 0x00, 0x0e, 0x00, 0x07, 0x00,
-	0x03, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 0x0e, 0x00,
+	0x07, 0x00, 0x03, 0x80, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -1169,7 +1169,7 @@ static const struct font_data fontdata_ter16x32 = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x7f, 0xf8, 0x7f, 0xfc, 0x03, 0x9e, 0x03, 0x8e,
+	0x7e, 0xf8, 0x7f, 0xfc, 0x03, 0x9e, 0x03, 0x8e,
 	0x03, 0x8e, 0x3f, 0x8e, 0x7f, 0xfe, 0xf3, 0xfe,
 	0xe3, 0x80, 0xe3, 0x80, 0xe3, 0x80, 0xf3, 0xce,
 	0x7f, 0xfe, 0x3e, 0xfc, 0x00, 0x00, 0x00, 0x00,
-- 
2.29.2

