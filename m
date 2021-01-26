Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C584304E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390485AbhA0AYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:24:44 -0500
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:17409
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389141AbhAZRNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:13:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBsp+B0AN1gQqbigfPj+RPx0IuMTsL+b/TJ+CzmhdUg6Q+XKsTP0mCY3D28JScd+divHjbQtubYA56iLy6t7JDJSnvC7DB/P/axTD2pxMWm+orWlxQTPe3S0whAwDAJCslsXLoAY0JzXt/JsOuVpFtQzcuvkNBePHtw7q2bFKxag1MNE14y59qrV9AyJxa/mVc6CvOZlnpUT6AeX1bmAn+6Vc0r1NTJePRIo0iIvYR9rU+biGePn4bB2exDMseD2tNDjEz8MwrLWBkpcJneE3uE4TdxBuCy04s9177Y+kUREJTrsxjwJPQ+QuQgKgHp1fccsF0NVGHqBoV6nGH/CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaXetgaanjcR5A6ra95FopujqmLHCWTxDv2A7D531WI=;
 b=IXPGL4N9oA1kHZrydjpSGTTMSwV2yLaaUfnCju4E9wzIgrwrOYsVvqv2/jVEy4zNNWF61k2gyKBomAcxjkcyZ1aako7VuXoowUvTBW62di+5NkJg4tB8XRJTTxlM0G0Slcg39DSzuCPFcMMQq/oiEj9kAwxYFjJUXX0V3Kw0o9usTA7ekXlHtmogjosHCzY1iha2S+jRZpsE0uu1oIljaMAnkmYWbgH3tFBformlwQHJgtNRmjZdhuftKOQ+DB7vxhf2g+fHxjcabBz2DCHHqSqByo4GOOn6+/FWCsBVTNUMvZeU2uAP0fPuNbUMUf6daGn8qAFSibOjH3gg/nniAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaXetgaanjcR5A6ra95FopujqmLHCWTxDv2A7D531WI=;
 b=JvKZDN9JkamiUugnPh9iaGRCHcnVR4QQ0irz8CsTl2V70lAwhuQAUVlN5kFSRlh4C3PGaipXHdWMgfYdDA3HNestKtFpoXBC6pRMHxf9/XxpU5iaOgqA5u2Yf2yZaQOQRMnWlnEYlhXRzjlf9JyGo7JVusddVlh8Cg5AZqPFfgc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1900.namprd11.prod.outlook.com (2603:10b6:3:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 17:12:31 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:12:31 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        josh@joshtriplett.org, yury.norov@gmail.com, peterz@infradead.org,
        paulmck@kernel.org, fweisbec@gmail.com, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/8] lib: bitmap: move ERANGE check from set_region to check_region
Date:   Tue, 26 Jan 2021 12:11:37 -0500
Message-Id: <20210126171141.122639-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126171141.122639-1-paul.gortmaker@windriver.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.252.2) by YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 17:12:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6983936c-a799-408e-f2c7-08d8c21d90b9
X-MS-TrafficTypeDiagnostic: DM5PR11MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1900CA93258C1D04CE6C2CBB83BC9@DM5PR11MB1900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6x+D6YrPpYEBrvFzy9TTfOQbUjN7ygN+kAnDrvg1vZ40hGdk17trWtz6Gqp7nkg9Vr7tqNmFZiYHlLI9lcL0+C7Zx19RrrUhxUJL9dYN+gZ1F6oBKL1R1GySyiKqCkoIq8In1OgdeU07dLplHZaYx4rqtlHhRlQhtz512eCrN3+sG+yTo4MEK3qJRfRxmgoLFNoij8cW1dlQJmV63JmvHXXrgCIwYuMNcfd/hcu6V2vmW5PZpUhsaX+hGqq3qsjTXIdE7YRSXKKy+HNADjyg1a6NWj8j33Fe79rNIJSbyxpHSV0dEWl726viq+nDxbyuXmKY17dhR2+z5mC5+8kzC7aRoem/H+cwJ478NqaSFZPLZhyelUBOoScqIOvbS0489/AOV0B7qFf2uvF0XSvig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6506007)(6486002)(83380400001)(2906002)(66476007)(8936002)(16526019)(5660300002)(4326008)(36756003)(52116002)(956004)(6916009)(44832011)(2616005)(7416002)(66946007)(26005)(316002)(8676002)(186003)(86362001)(6512007)(107886003)(66556008)(1076003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D5yZlxmO7kgqNSGZwRehRPzRW87QwbkvmLmC1tmlaC8jPRAbmYu0QMbR4BFd?=
 =?us-ascii?Q?Uc0uvD4DW8EU9ea09yTBrfR9nNvOidhw4U2WaPs2QyzHAz4t97UL8bfBVOfd?=
 =?us-ascii?Q?FRj5F86IS0itdP+WInankMyll+H9HIBaYIylFkoyHHc42iG4OYa79c4FZNF7?=
 =?us-ascii?Q?t7RIHWYlUrQAFWZv+SJEDgrT+DfKrn4RvdqffABdWZq3ppa+zfQ0iU7Y6Grw?=
 =?us-ascii?Q?Ug2p9h+qmaarCcOg4Vt78qsY3MAy+1nB6NXxJzb8WSBcuWj2/G6fPXAnzLZZ?=
 =?us-ascii?Q?bJzz7tt5DJtswQE4k0BwGDSSyPjAeK58Tt1E+NXO0lE7zPS8XuFqmcE3Arz6?=
 =?us-ascii?Q?wh2WdSMmgp1oL8BxX8UfP/lq4qA3IaGoMt+ipMAz74JAqWdI/AybGaoLxZsy?=
 =?us-ascii?Q?PG6tDg91yMqDAwqWkQef3Nafb2EI0WtEcZfg6Tm2KuZKKSmrUq0Vp4eryWJz?=
 =?us-ascii?Q?4IIFNp2XiKqvTpRZ4fSMWT3GRkxkuc/hLfDkd19VD3tjKKrh3J8PKo5Zkh4L?=
 =?us-ascii?Q?Owwv+hIOYTQubJkPKMORrGGHR6GTvlOVG8+pDV7xt62jsOzErGxgQfTds4Lw?=
 =?us-ascii?Q?4cr19a7+VO7/+QAOvI8VypX2CBDuwcFsaAuWL0k7I7ob7FR/i3RLrwZGS7db?=
 =?us-ascii?Q?JbNzAFKcehKuxzH3W1l9bcZC49QfJtxTqC7Kjl7At1H3avzpSSL7yep3Zfl6?=
 =?us-ascii?Q?qMe8ndr0QmISu428dsbsT3RLArG7lhPCHToBmj7qdX/w6Gwp+MhtGyEsQc3Y?=
 =?us-ascii?Q?PP8E7uuXa+AObKbpbI2eGj5cTOano4dBVFCfmLs/RZQ+Ly6N2j7LngFSuLXW?=
 =?us-ascii?Q?kB41JU13Qni99/o8YiAlUcWhNq/lPG16f2/4fNz8uuNMI3zQ6ZeYKk83WM0V?=
 =?us-ascii?Q?yjqA/8XM6rHvTSniInyIDVoqyca/IIttRNKenR4hZF9s9qbSDcGopUqADMR3?=
 =?us-ascii?Q?VelSvRvOvyuAFHMonoFpywJ8m35AxCJkQLjdRvqF4XGauA4BNEP5eJc/a7Za?=
 =?us-ascii?Q?RA2awpmLpjqOouxxbtGYaTARhtXeYPMJl9byWxKKG+nmpvTflGmH31Whv/4b?=
 =?us-ascii?Q?7KYSrVYP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6983936c-a799-408e-f2c7-08d8c21d90b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:12:31.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvVgGiXbB5WhxcPLOoS1y2grEzoUjgZOW7oVnH/MbCSQyYMevyGc0IbooUXlKGvLH9+549pvsYTwRvRz25aCwIXR3yZ6Mu4fMcfbXPtK55U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1900
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to do all the checks in check_region() and not 1/2
in check_region and 1/2 in set_region.

Since set_region is called immediately after check_region, the net
effect on runtime is zero, but it gets rid of an if (...) return...

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 162e2850c622..833f152a2c43 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -500,17 +500,12 @@ struct region {
 	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= r->nbits)
-		return -ERANGE;
-
 	for (start = r->start; start <= r->end; start += r->group_len)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-
-	return 0;
 }
 
 static int bitmap_check_region(const struct region *r)
@@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
+	if (r->end >= r->nbits)
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp);
-		if (ret)
-			return ret;
+		bitmap_set_region(&r, maskp);
 	}
 
 	return 0;
-- 
2.17.1

