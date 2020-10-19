Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1072923BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgJSIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:36:49 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:12128
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728239AbgJSIgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt6yTIHO0ZVYSOnCU1+eDtIaoHW1mwk0Ra5s1gKSIeQWCMNagurq0h0gAkH4x0OMN3BRhOCNzwJrcMvjAnvMIg6z3hY88/nvIom2YxlkboUgoPULJmMKKfYnYBYVA+vnPpk09qMomheg4IYVuG++uLBCOSyJrC5Km7pzhABOPG5wzbe3fKVEwwLKmXqOwWoV7tHV+P9MV7SybsKCQ04VmUyPOhqjn1W5GkfZl6MQGz7bUCJn8rh6gtSydzFcqgf798956EqpHwFWN0t1btHhF7EDtLTYpRcB+8s2+rBD3lWH6GtApYVDQIcQ3NynpSPuKENBU9RNZfhkUCaBKHf6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gonx6GmelUKyPods6BznnwAd1jOzdL0zdBMbxmHzbrA=;
 b=idBtQTNHzxSH48sH6SdAEvybcxmZ4ev1PC1Snr2r+50d72SSi3TiNU13wR/Yhj+hPa+9Gura4oEpBClWvpChkbJyiYnzzj7lTtjlRflb0fmtJoRsAyQg0J4VJUcuvIc/Dcm0YMw0hZGMdrIqkc3Cf+6OSdId1MdyPu9nraixc/tZrHPBBc3EGIrXYKLCknDpb3aVkIlpbxt964QPANQwdMGtFTMR7EkcqViWTyxTqfLW6TouW1JCNOq2XQbH/I0I/OYf1lcIPMiwozbFs3lt8VKS3FIclCvmcCYDN+NIpd0YZZKLBfUDebQAspTlDDn+7He5o7ca1kCPdNbBlqvbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gonx6GmelUKyPods6BznnwAd1jOzdL0zdBMbxmHzbrA=;
 b=JNbCgWD1O8EjKYu9LngP7wgNCTazNDnxkpi4pkWSrWySeQWozoBMX/mUlP2e4W3SJd0HzZxxN1LJLhViFhoorLaW8gAzfd4RPqTrwMOWd0JVwZSB7hz1D9xgSgvtnuriBiq2hkyMFL4dbFcoq/5HcldsSZUCHvPOZ0GvpAtVkdI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 08:36:46 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 08:36:46 +0000
From:   yanfei.xu@windriver.com
To:     akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/compaction: Rename 'start_pfn' to 'iteration_start_pfn' in compact_zone()
Date:   Mon, 19 Oct 2020 16:36:32 +0800
Message-Id: <20201019083632.25417-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:c8::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HKAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:203:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.6 via Frontend Transport; Mon, 19 Oct 2020 08:36:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc41fdd-8909-4082-cf99-08d8740a1d03
X-MS-TrafficTypeDiagnostic: BYAPR11MB3256:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3256185049CA44D576BEF03CE41E0@BYAPR11MB3256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8q3fqeWchOOfQtFrGn5bYt6dbzfSQiEm/i1yJ4YdiluE3FdzpyFcVwgx7BsVHuqhBx7NhWI08hhC/XlsoTkLT7ayJM5GoZ/3Kpz8wHXkIWGRYs9rVyLAks1QlLJ2XUY7B++lb6HoaPanzukqxBnygR2GnOGXxE/U4EhFAYafFS1g4Ijawnt8DE5YCwMOYR+xy13IsAkrwLKW/HoGVsjEpHTJIGEl61Od6VzKkKljUh2qQLfg4t5SMCy3UJUFfFsEOyGGnpYRzPT7q35VM9Rt3QlH9Febn0AoevdABtn9+PpnzRqs4uyaKrMsTpwaumX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(4326008)(6486002)(8936002)(8676002)(26005)(186003)(16526019)(83380400001)(36756003)(478600001)(9686003)(6512007)(86362001)(2906002)(66476007)(52116002)(6506007)(66946007)(66556008)(316002)(5660300002)(956004)(2616005)(1076003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k+DQhYRuCXZ5QpeZdFhv8F29A1BhLy20m8N1z8JUAnGZc0oG2dknt4secWfLEHp5b2/6wm+jjkv4HVxaJpvOvaVm6JnaTuoGIyf0IM0FTAHBeWZUrSyYWsci2PT3L5OclirYTOgpPQTaSqBIm+rzkkHPA3jObOLFCzSSeEdbTXSLJFmJMTgBv8s/AgNVF2vJDnedxHuHlvhqCv7C5b0i5AY3mkuM2dMUoM8/BmaJygOnx9KAGNqwNUOD2neBK24Qiepp7RHxFHHB3bAQyiJ2xDfgN9/iYqw/wcZCQ6w4j1rIWaaWHsrcFPNgLKMqTT8860WKJ2Fz7du5oD60eqbv8o6yuKPSbOzn/UhPAsRPIy5cj74AE/45E9oLvLjE6PB3vVqhuOxM5+wAXQDZzSbUbWtWOtFqClV6ENwLLtoANghoXr6aYwuHrok5b4yJg2mrUG3yhJgvDaTQKkLDF9Q1ynqQBypwr0Fdv1kfTTpg6LZG48hKKlRBus5moZEN6i/yRwijVy8U9OGGUuXCKea17Wqoee0+CxGs3nJgJS+YpXVCYiNAb606kuz9vxVJ8vaLA5ttUYriVQ4hbFA00llkVynv+rKd2EROP7rPsYY8aIvLZk1TYO0BhuXwnRcDu41X4nOC5Uaqomhw2uEHGt2WsQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc41fdd-8909-4082-cf99-08d8740a1d03
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 08:36:46.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We8lIuqarXASmIjwTjya8JVfrnat0AYB46sodPfjM2AboU6i+BgjEQOSoKPDsd0ggx0uePbAu6h4Nx3qkyqoqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

There are two 'start_pfn' declared in compact_zone() which have
different meaning. Rename the second one to 'iteration_start_pfn'
to prevent trace_mm_compaction_end() from tracing an undesirable
value.

BTW, remove an useless semicolon.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
v1->v2:
Rename 'start_pfn' to 'iteration_start_pfn' and change commit messages.

 mm/compaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 176dcded298e..ccd27c739fd6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
-		unsigned long start_pfn = cc->migrate_pfn;
+		unsigned long iteration_start_pfn = cc->migrate_pfn;
 
 		/*
 		 * Avoid multiple rescans which can happen if a page cannot be
@@ -2284,7 +2284,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		 */
 		cc->rescan = false;
 		if (pageblock_start_pfn(last_migrated_pfn) ==
-		    pageblock_start_pfn(start_pfn)) {
+		    pageblock_start_pfn(iteration_start_pfn)) {
 			cc->rescan = true;
 		}
 
@@ -2308,8 +2308,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 			goto check_drain;
 		case ISOLATE_SUCCESS:
 			update_cached = false;
-			last_migrated_pfn = start_pfn;
-			;
+			last_migrated_pfn = iteration_start_pfn;
 		}
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
-- 
2.18.2

