Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFB28DA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgJNHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:24:07 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:8545
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbgJNHYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8fLeHHCrHl7w45l6y2Y58/KJltk+T+LaMNtahPmQjOrR9q/lIO9JQbyh8NJk8fE/lEQGPf4lQRKa2KrOWzx2OShcOoi0tnA51uxxfO/E3U9ejyz0pIftn1euAtNqNyUz9Xyl8fAffRiF2dxM7W+NUP873xL6nGBRjiOLVevs4L8JBJpCzFIVLLSXBnU9Ou9LqsY7r8COzb16kZQmbW6bKobbjZHus4B54sBjLFWLeQq8kYM1vfQu/cIc9ktksHSV6i0rHzZdSurP3C95BuSBdjwO/rMEl2CWDeBTZtMv79WV9K63IxGyKt0R8LVjiAwdKHL2oGNX7SRuzre027bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX2VtEEV09k8UoGWYMojp7v8moPBfTzLlhRYqVrZlVE=;
 b=cBqE2GKNi075SgkuZjbcs6xDA+DM501b9m59CxtMyigmNnyb4kll1h9nn/pcQ9/YjQCI277hvxrii9uYNE5dq3wuYN0KPKxT64b+d14mUzgyGQAfx5tBwzFbWUFOl8+Fzax+BUSfgFjFPKQjfT4rovIytXQGMhMyvny7kwHx+5/DOJ+ft7tvM90oktXjRgqVpM0oGzIrHmsnTYZprZ+kJWW4TKRNKr2G4myqzT5wtKk/2MmoWy7rKTQLxuFEJ4U0AZdXFiDN+g9lG4zed0HIgdQFC028+rMHp63mtDSYz40O81vZPEXN/ejv68RzxAkTJkgbw3F1OK3I6OJmbBqYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX2VtEEV09k8UoGWYMojp7v8moPBfTzLlhRYqVrZlVE=;
 b=WS2NHreEuN6P97Co6kJLjPYCCGHv3Bof+a/J/2F9hn5/izsKxj/ztOapgNQZuw3VkZpX9NT0JNFwylok9Pfo5fv5niDerhQmFUEhxTJI3mmZscV/4yRNMEHVyJG5vs/Wom8JJNBcr6R826v08zWypId3PX2/K+I4KmrOEu/32gE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 14 Oct
 2020 07:24:01 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::3581:4d13:b613:eb81]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::3581:4d13:b613:eb81%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 07:24:01 +0000
From:   yanfei.xu@windriver.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/compaction: Remove some useless code in compact_zone()
Date:   Wed, 14 Oct 2020 15:23:49 +0800
Message-Id: <20201014072349.34494-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK0PR01CA0053.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 07:23:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1fb9a74-45c3-428b-b4bd-08d870121f3d
X-MS-TrafficTypeDiagnostic: BY5PR11MB4007:
X-Microsoft-Antispam-PRVS: <BY5PR11MB40072BE56AA880D2C8D4CFD4E4050@BY5PR11MB4007.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YKT8usR6EEmNPUO+uUaTrCK+xO4uLjq3jGs9PB9Lx8gmykIKjF6yfTMtr7elCQ9XJCPs6XSr9qekp+8hHJp+zQkXE+GEMN/AgE2GOlN5KCSjZKaT/bu8tCDiy2DgDzKgaqCjmJ/qGY8GycdB4E2nFE8SfTj0UOrMeUuDI+1+HKJ5diSa3C7sJcMjrY7bBBJ2AChH4kDWEo/NF6zdzo29lHaHjTq62mS19Bg/EbgjsHITxT2WpFCV216cbHncpW7guFtnSW0+S0NpQjfY1oWZf4BwtnxB4EFlrzfqtpv6ZCUe6UjPgJ/oZjAJTsK57OUDgOUOeHmWozM9Euf+bROfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39850400004)(6916009)(6666004)(8936002)(83380400001)(6512007)(8676002)(9686003)(66556008)(4744005)(1076003)(66946007)(66476007)(52116002)(956004)(36756003)(16526019)(2906002)(4326008)(26005)(478600001)(186003)(6486002)(5660300002)(6506007)(316002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TX9PlaGjtN+lky8cH4jaNT0zGkTiKMNEAHUu1sHFF1mMiFroP0PLHhpuBoimnMbPFc93/MGFvwpb7WHSdwXq/gCaPxPkRQZLTC0fY1mXLctVz7g3p2YyWQ3FEoT6z+A/okth1JbTou22KTUjl4c8JNdBBAe/C/qtf+IrPU2yHhWRG8EURwaUYIFI7hoZTc8ScvNNmu+B6ng9BEPRNvBvhRs6L1NHuCw/CwfKfLIOFA/6CoxEtbwqTOXU1hAVBCgS+s8RLvX8U22hWs6dGgYql7HaFZK3Mksn+5moRktd6qGBpB63EAJzHceTY5Rs60L2dlso5yz3hovlUyjSlEb57eX+lTCNS1nEZO2/xAUdgeG6cBwm5PfoxyhfP+7Rc3wVP6Y2p/r6pijNIRNasUNdGa8HvjMdKubVjmAyrY7msaJBLRXGFJFKWCNXJZDynwi84ecE0pQDPvOXqb5F6VyJrDRWRLMPIUFd0xzt8/JBq6QaWpl221H7NMVLhLRluqPqcrQ4ZZNDGEIAlFH1mRE6mekRBAV/zdVBg8BrTYwCIgg/UHXlh3FYwhWVDBpzpO5asb826ne4sFW4gwmpgXDvMtyg7izCytZK4yZahZ+V1gzeiE4+VdQGCVwGtw3/KZR5m0A3JUtu4+ns3UH/dAnGTg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fb9a74-45c3-428b-b4bd-08d870121f3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:24:01.3552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pu7pN9v5YGnU2D18tpTqNMySipIVErIxBuq6Ji6C3TzK9fgxbQ8zDD/Tveillm4o6oaFupriJf7pekNFVxO0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

start_pfn has been declared at the begin of compact_zone(), it's
no need to declare it again. And remove an useless semicolon.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/compaction.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 176dcded298e..5e69c1f94d96 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
-		unsigned long start_pfn = cc->migrate_pfn;
+		start_pfn = cc->migrate_pfn;
 
 		/*
 		 * Avoid multiple rescans which can happen if a page cannot be
@@ -2309,7 +2309,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		case ISOLATE_SUCCESS:
 			update_cached = false;
 			last_migrated_pfn = start_pfn;
-			;
 		}
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
-- 
2.18.2

