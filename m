Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016682F986C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbhARD70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 22:59:26 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:60843
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731946AbhARD7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 22:59:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGCeMOOp9wjCuNKC7SVYITO71Ax834MzxDxhfPn9yNMLDz8+UvTBZWaVIvQFlFpseJeS/wu2gOAgBiTpVAkwgelQulwbw3vUS63bGJyg3BCm8xYPhBQYX5Mx3G4BP9JAHaMdchSgxjfsyS571JR4UCdr40ltw7DN8K8Et3GChdwAKcNdxP/th6giD/eykDey4NVTOvwEmGG8Um3Uwr4B/icD/ro9OMeMOOjSPUavv15yWhnpD4rlZ8g2mfSihYqyXBGs6YdVd2N94RHNkGkqjHoXDcW3i4DVU6GUXow42YLM4NDrimK6DFAAuHaeK7ptgYHyeDO8RDlwLisjX/qC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDZ5xOKqtkfOXdSuzKccMVthg5kq743w94QAPZLc98I=;
 b=YuWRIHNpfpMAsi0U8zDxXDJpjF/7y9YVSnuBsk4mOqcL+rqsXkYAI2JKjZHYddKqDGdWe24Dp0R7y5Xo87OQgUaZy0E3KMMWwwYbjOg1OQsgbWq5wODNaTSE+JuewqW5KCUvQnYL6XAS93Z5TVozP8zBJ1F7w6YsEPf8ajCZZUJnaMIru4nbprJDOlT8e0DysuzA90+5t1jyvE5Qjl47leQNNRLK8VXhue07NykdJKHP+z32Ihg6B1WSpRVXpdDjtbROMPnQkmhcfrG/sK2ZM4XEKpORsRUDgEQGZVOyHp13+G9fu7QkNebRSArz/pJBBO5s39uxTQ7Xy24sbRR5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDZ5xOKqtkfOXdSuzKccMVthg5kq743w94QAPZLc98I=;
 b=yA7yXWK1vxr1c5oVffEsNvwav74AJKCrOEAURtnz2rNmEaQLSHYaTtcjVWpFrcNpiDPBSrLfVcLgBkqDudlVYNsvB9Cot+u53k8BDKrZTKWWNg2/m+s6KIwFiZc+IVs8nrAht/xgtBUfPRXbnHWxoH2FUrn0De/EZLvM7yELI9M=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4878.namprd08.prod.outlook.com (2603:10b6:805:75::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 03:57:52 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::972:c257:aa68:9be0%4]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 03:57:52 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v2 4/6] mfd: iqs62x: Increase interrupt handler return delay
Date:   Sun, 17 Jan 2021 21:57:06 -0600
Message-Id: <1610942228-7275-5-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610942228-7275-1-git-send-email-jeff@labundy.com>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-Originating-IP: [136.49.173.128]
X-ClientProxiedBy: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (136.49.173.128) by SN4PR0501CA0055.namprd05.prod.outlook.com (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 03:57:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9865e7-8274-4b25-7614-08d8bb653ac0
X-MS-TrafficTypeDiagnostic: SN6PR08MB4878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB487844453C62496BA868EA62D3A40@SN6PR08MB4878.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zlgxfEFp4BkopFdYRL3ylTyDKi1qbxDMfgg9Im8erm+kBKzN9noRTkfraTSU/vH5a2nWjb5DkG5HeXKTndUs8a/pJOLMHXTmyaEzjjfSwIpZliEPmJvkEMPoFcbl+/Vl+8gJqOEp51clQlOWBM//1onN1N0UpWt6YHVp47nekkhBwunz4pKtFAh7Fb3GbEJJcvseHOW99pgy7b3nSpNDeEQSaYYseWzZEHOIEH4yhXRm9sFOcsrD5ZU/7mFdQhWZzz69uYANfuNMJ3CSWi6zscnK+MWGrvQY4BLmG6s8H8IOx/kA+Np+hAEsBFnfUsWBsvEaCePZR88IQwElos5x5pnEJcTgaBamSU3MJncjXL7RaPQ9fP4RXXmm7xO7ANZbqtkbZ57dvzsDPDCxxEzB043Va+Jniyt/0B6vpQLAw2YXBSvBEeikhKkZWad3aicrWGM7zD0WpYewgNUBVf4wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(366004)(376002)(396003)(52116002)(66946007)(107886003)(8936002)(5660300002)(6512007)(69590400011)(16526019)(6666004)(66476007)(478600001)(956004)(316002)(8676002)(6486002)(6506007)(83380400001)(6916009)(2906002)(4744005)(86362001)(36756003)(4326008)(26005)(186003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VFMAiBi8UMKE1HJDkLVroEt5edTE9IMX+8VFAslrrCmmecx6iWJ5b2AUdfO3?=
 =?us-ascii?Q?CTBCAHOSPWz/d8GLD9JFFSML5yVsWuMrHswnBKAAiiZuBRb6H2qnOo2ahzdn?=
 =?us-ascii?Q?BlP0llgWDGC/9dbzsWp/hyVBh/L45EYjoiVieXNB1Amn0hWGP5pC4BRjsl6R?=
 =?us-ascii?Q?UmJNbuVW8IG1WpyP29tRRVUoPqjCA6/xpWoo6Rlibw5DMxAg8nAmZOBh9LhU?=
 =?us-ascii?Q?qE1YnlwRcDx6GVA93uTuP8BS+KYBDFV0xUZr/JGBMTEg5Gc1FSHwla8HD+sC?=
 =?us-ascii?Q?RrbK067NbwoAMcsIv8B1fhNhTBIJZR9lu96JJY0zOSfMTkpbWf5IFQr+yAAx?=
 =?us-ascii?Q?ck6okUKbIVM2+L+Qc2Oiyz98v/Fng8GaAtHd8qADj7uyOFQjM6qQfO34pl81?=
 =?us-ascii?Q?vIuQEERdEqapmKr2MyeaQIpGnb4MkAbFPMKk9jJECQkcKaEmzu6TE+tBNRHO?=
 =?us-ascii?Q?6CX1i8b10bjbQ8k3oRD+cCV9e5Hm/MvTHtTzCKR8kEthO2XtMildLhzC3ws+?=
 =?us-ascii?Q?d/sBM2N4QrE9lauCWleqHZnjP7FivlCX0yFLM46r49a5bE/CTtjYpNRE12Mv?=
 =?us-ascii?Q?ve+TMFtiTPjlB/Oeg7b26DV4X4oupufbcutoTu3Xpi1/TDGNE255F7VFRgQB?=
 =?us-ascii?Q?EM4lB8QukKmSVmsR5IIEBQXyt77a9Fb/fDyGjhHahUmj+SMUAfeKXbF5IA4F?=
 =?us-ascii?Q?T3Egg7Bk0dLPRw0Z3y5H7CdGRRjVN7ME1ab/51YmkRIgQeBltuDgGQI6WyKz?=
 =?us-ascii?Q?nOySPQUjvccPyzTc/8PgQU3Ow8BUsKIkthDUY9iNdviX7VL/ZFdaH0IT6A96?=
 =?us-ascii?Q?p7Nx+HZoa6BrCC2XwbKGsv5UVbRml11knmJ98bgDqhliTulUWAQTP1PPlE8a?=
 =?us-ascii?Q?M7s28sGCaYyHjXvFl0oOP2sGrgdlyLpg71VErHQMDwJp4HHK3dZH64NTGGF1?=
 =?us-ascii?Q?q1+2iisWAy0mAdbY5QXxLXzJ+JCk/1xdiX7hiOKr6xM/YYQueNcPJ6Hx8eSL?=
 =?us-ascii?Q?1goF?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9865e7-8274-4b25-7614-08d8bb653ac0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 03:57:52.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f899kc7NI6I+Iz5EWcrsc/H8xGEYqh0hdEssfIkS/hEnqq54u1Echz05Flobw5HRFDOVCu1VIc0T4TN1qMS53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time the device takes to deassert its RDY output following an
I2C stop condition scales with the core clock frequency.

To prevent level-triggered interrupts from being reasserted after
the interrupt handler returns, increase the time before returning
to account for the worst-case delay (~90 us) plus margin.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v2:
  - Added Acked-for-MFD-by trailer

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

