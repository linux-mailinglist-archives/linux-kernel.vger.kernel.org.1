Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5345A2D0A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 07:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLGGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 01:14:02 -0500
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:52192
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgLGGOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 01:14:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKIS2DXi3sGRn8apowpokEfVHzAbcpRfMt2KdjZ3lN7nsGJGt3TAbuXrQr2MmnxS2a0pqeUAuJKS8a08S+nuQBuxaJLyPWxMd6REl8YzuIOMmBCOZ8ZcDjbHteHkF8u9KQSPmF4zHo6lMJe10tL5BazFEio9z572RVyYnyHiGvMGcLLE77y7XzQ7Tn/oGNasID0BUqKpU+5i/kFDFhc5taGCB2sh55qcywYap9KxyVV4mGb6oZyUoBzHrC4McvGVSPQO6hfGkgavsVvucEx48QK4MW+Ozm5YI3UA9i20RVHueNZFJGoi81VmKmZYZ6Huz9Mz8TIYn9Q/IDjLu9q2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOfUFflkbG4BIyUxW+1Tl9Zl34dMW2VK7RdMNftTx98=;
 b=R/ct0vsJRGQRHrNccIlj89R0DaMUR+XhWlZbEjsVaQopO5YoyFIrfEaLb2WjCJY+2VvEn/wi5OvAO49l7iMBJ64rqhV9mGfpJVPI/NTAwEMHuudje35W9H3/l7TksuSXbOiPjOtyY6RvcTd5cDNlvWJSg4/eycmDGvfAVr+HHk01iPdj9tWrMG7Qb0MLUwXELzr4jxytH/Vqi60va9O2NOPh9uBzCmAgqtgSv/vz1pzUMHShEAOJPM2A+700fHAphd3gBIleL3bz4Bb4u+048jVTmQ68+oT0hAsons5HLiIadtKB1t2WtRK0sP4jMNHtT1ysaHhjYHd96J6t3z4rLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOfUFflkbG4BIyUxW+1Tl9Zl34dMW2VK7RdMNftTx98=;
 b=3zwmIlFhYu8FOWMKY1Ja+NGoqNFf4f6rJ/2aDMSXBibtqGukkBgBGEF4uVSxYJXEaWr845x3TuvVm0fSwbTXmmG0i6BZN9zbo/7OueLIrdzsRJrn21wlWlQ3Xwk06l9TPiYsjC86+9iyijWd06Jb3q99ZZQdhnu3Rgh4FmAuYd8=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 06:13:09 +0000
Received: from BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::7487:6817:7115:4959]) by BY5PR12MB4163.namprd12.prod.outlook.com
 ([fe80::7487:6817:7115:4959%9]) with mapi id 15.20.3632.017; Mon, 7 Dec 2020
 06:13:09 +0000
From:   Ying-Tsun Huang <ying-tsun.huang@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ying-Tsun Huang <ying-tsun.huang@amd.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Toshi Kani <toshi.kani@hp.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Lapik <dmitry.kolyadintsev@nyriad.com>,
        James Lee <James.Lee@amd.com>
Subject: [PATCH] x86/mtrr: Correct the returned MTRR type of mtrr_type_lookup.
Date:   Mon,  7 Dec 2020 14:12:26 +0800
Message-Id: <20201207061227.131580-1-ying-tsun.huang@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0089.apcprd04.prod.outlook.com
 (2603:1096:202:15::33) To BY5PR12MB4163.namprd12.prod.outlook.com
 (2603:10b6:a03:202::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ytubuntu20.amd.com (165.204.134.251) by HK2PR04CA0089.apcprd04.prod.outlook.com (2603:1096:202:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 06:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32054721-dd53-4b3e-80c9-08d89a772b57
X-MS-TrafficTypeDiagnostic: BYAPR12MB2966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB296693FC5ED76F9318AF8EF5AECE0@BYAPR12MB2966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: algewRKGDy9XrL0FCG8EAnDtiytgWM1SMHagyCsQWt69ZGQ3roCuvWX1anAL0VcC+/q4s6KM94tzq0HJ0e7tOF/jPP/eKTsPcLPQsiAXD6/iH2Xdvjh81gI0YzF/nJc/xBorAzNgaaB5g6focdXcNkIF2tCnPLW1n2roOhvQ32PQZI94R6UEkBF+cDpDE3NuI0uA7801AJfgu6ba2kGIDHb5xQnJTC+UyQOI2vQ1f8TDeGk3Lq8ep75FjSbY8WX/6OejJE4aWyOJPRyB/AkHaWTu5SV9EZ7l/W9tQbIMgo4FpeSsAO2jWJ6dU0E6bMZaWD6eU9gHsd7GDv5Nfe/yaMwAXOQ2/IoCARWb3L7g5s7XaBwDR6IwAQ7TD8ts/xiP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(36756003)(66946007)(316002)(5660300002)(66556008)(7416002)(921005)(956004)(26005)(7696005)(52116002)(66476007)(1076003)(2616005)(83380400001)(478600001)(2906002)(110136005)(8936002)(86362001)(4326008)(8676002)(16526019)(6666004)(6486002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rIoTP8B9vhNugQsNMtE4jHUQEa2qCNBP8eKVDg+91xn1SrUvJUWrjO0KGrpp?=
 =?us-ascii?Q?Keugr4Y2fRw2wbueyluGpWUajRMg52jtO7dBYlzcDUewvLop8p6H5eOc4kgp?=
 =?us-ascii?Q?txyWnr+c+nHADVTH7YynWgxFYUtiUpqegVzFnntzW/yy5J8kKaTTRoqFm/7L?=
 =?us-ascii?Q?jEey55QM/gOtlVA87KtRye24Ip/pmyJhvEFgtvfrN5inGzJFFpbpw3LJY/xB?=
 =?us-ascii?Q?dQRstVAUw8ctILlp3hsmXeDzCx6MqXOwYHzSqm3COS2SwoUX3JPry/SKTHN9?=
 =?us-ascii?Q?56Lgw670EDS7IdNF4h4Gr8ouKY5vm04HUC5rfxfXlqANJPDbkWaMfa62rWHs?=
 =?us-ascii?Q?rCTSnaBKX6Yl6WbnNnDd5f1eY2HgtHmzwMsW6UmlF1nKBGo9mTafV2hcU1pS?=
 =?us-ascii?Q?XbKLk4w/qV3RrQOVUUB/bdvrJZT5MzGF0p+79+aulDytaJH7/ab7HUh6dqpP?=
 =?us-ascii?Q?puQ66n6GXk1DIzP8OB2GqUD5GMnV5aFplazw4mQB+yQXvkdjqETa90wF2Fx2?=
 =?us-ascii?Q?nP0vGFxBIhfNcLBTgb/OmM3yvzGvsd8BZQ6PVf37P4QLUjX6h9LxNXesqS3a?=
 =?us-ascii?Q?xJhmwKCmwQ+4nj5KmK+CrK5Uurn5e1u94ulsTZt8X8wnhNSQByBjzP5S60EX?=
 =?us-ascii?Q?8dSuuQwaAitgoXmN4A7lp7AphPpvrcfLvbUbelLMabKIGKv/iYSe8zIvB0La?=
 =?us-ascii?Q?6nzKvHA8OuSLYCNhUovTUMr/HCqgVgRiDSn5szyb6rEWIFcTWmRvZloPugLr?=
 =?us-ascii?Q?lKjbSOOvwP+uSwYfE16WIezwOKdJxkZiuvkoIVjPBnqoUCsc+yC+dyZwzNGt?=
 =?us-ascii?Q?CqyIxufB8awmVtFqrb0PC4+PCSy3IPL9WgMcE9CcS6zuRHdZMkLuTizJJpjt?=
 =?us-ascii?Q?lyOA63YoMVpkHIz9qbzLt+14vsdLxwEEnCFerLVt0Y74R7rcCjm11e6y2hrq?=
 =?us-ascii?Q?Kj0dAXObFXNw1UUUwR244Xxy6EvOU34zSKRYfVWkKL4rxSvmcBejfj9q2TjU?=
 =?us-ascii?Q?uGPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 06:13:09.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 32054721-dd53-4b3e-80c9-08d89a772b57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ComQJ39ghx8uz7l3DSKvRKlDupXV6T+/GtebIUwD5dHq+y8GIECNmtonpyeAoPRjsHwkRetECbWxs5XK+y6faA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mtrr_type_lookup, if the input memory address region is not in the
MTRR, over 4GB, and not over the top of memory, write-back attribute
is returned. These condition checks are for ensuring the input memory
address region is mapped to the physical memory actually.

However, if the end address is just aligned with the top of memory,
the condition check treats the address is over the top of memory, and
write-back attribute is not returned.

There is a real case of NVDIMM. The nd_pmem module tries to map
NVDIMMs as cacheable memories when NVDIMMs are connected. If a NVDIMM
is the last of the DIMMs, the performance of this NVDIMM becomes very
low since it aligned with the top of memory and its memory type is
uncached-minus.

To check the top of memory should use "<=" instead of "<" since both the
input end address and the value of top of memory are actually the start
of next region.

Fixes: b73522e0c1be ("x86/mm/mtrr: Enhance MTRR checks in kernel mapping
helpers")
Signed-off-by: Ying-Tsun Huang <ying-tsun.huang@amd.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 23ad8e953dfb..b13e87dba27d 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -303,7 +303,7 @@ u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 			goto out;
 	}
 
-	if (mtrr_tom2 && (start >= (1ULL<<32)) && (end < mtrr_tom2))
+	if (mtrr_tom2 && (start >= (1ULL<<32)) && (end <= mtrr_tom2))
 		type = MTRR_TYPE_WRBACK;
 
 out:
-- 
2.25.1

