Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C622926AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJSLvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:51:03 -0400
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:57185
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbgJSLvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4+LdHkKLTQOHRc+WPwg80aE58HP3xmrfORwU4rS1+ppktbNWxWTF1SMOSb9V7Lfvia5JiEh2mPfP7tZp2z5EPgN9T7IO9eMcnZZtRD6yHMvdYcCnOJ3F6i/R6+3bdQQCRpyL48fkPi51hUQepK6T0Ttut5S0tNDZV/m2D22bDBEdXnRVe4qQ0w/w0gZFLihHtquD+w55whY7ROPFYHn9ENwn+yn8k5z/P2sQPcZ/Sg3zsgsDOYslSQZ4efFIzE7o2FEbA8MOi5qdLcCuiD0/ekZFbiNsOPreCe7qG5JmVk7j5VHbEpYpqZYigzkIQM56iTqSfr5BAX6qWbIEOZtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCpJaLr+R9sEAAwoJm+/m1uI/4+Nq1viuVJqSyePLm8=;
 b=Rdz5fhhjppJDBF9JhV9q8AYFvT4ynkMOWeM0/wmex6aWt8F+yUGz5Fc0hYjqaif5OzoS7NMTUERylV5Z7HYaT3eGx6YDNnPfemtQ8+Y+kx9pcsWBwvlrZtTJgV8XrrCt+/Eu/RfmvZs49GdMJcs3NgmCbmxuhE3TjX8/F5jO4dq8hOrqoNjto+nVq2H4mWQvQyeoMDrlCoRTkyX5+QcKnald72VM09ZjGkKTwqqAnAvxMtpEzCXPxDjXbNfz9tD6ozoiLgZ62lxr4KR0FRFlwf8eykHWwwrzDtf+apr6iAUmHVkLi7vct5IKmZvh4GQ7HyXBTlT5Sgg7bg0rrG4Qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCpJaLr+R9sEAAwoJm+/m1uI/4+Nq1viuVJqSyePLm8=;
 b=G72MRzMnnaeT7+wdqDdWfAqUlBDY0wyM19kBXoEkBE8Tb3cNTKc4ZHqGkKjpklupQRCHeL9dDDeHMTofMylKFr+d96/GVEZ0X9Y6Fw6+4Q4KvLdDrINlZlIso3j8lovwkUJ1GXkMQNLu51oLwtygUJ+Ob1x0TJnRMJze6aucstI=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4370.namprd11.prod.outlook.com (2603:10b6:a03:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 11:50:57 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 11:50:57 +0000
From:   yanfei.xu@windriver.com
To:     akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        pankaj.gupta.linux@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/compaction: Rename 'start_pfn' to 'iteration_start_pfn' in compact_zone()
Date:   Mon, 19 Oct 2020 19:50:44 +0800
Message-Id: <20201019115044.1571-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0089.apcprd04.prod.outlook.com
 (2603:1096:202:15::33) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR04CA0089.apcprd04.prod.outlook.com (2603:1096:202:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Mon, 19 Oct 2020 11:50:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a89ea1-9433-4f91-8175-08d874253d8d
X-MS-TrafficTypeDiagnostic: BY5PR11MB4370:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4370A08C80559454129E25DFE41E0@BY5PR11MB4370.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvHUDKt9Ljxg1vADE1MfbROL+jRbB/JQjf5Mtj3Va/AK1uxTEkv1WDhkcaM2I/uHBAch4uGrvhtXi2deBHc3Tyqy9+HOhboX7owV1442xuL/1zHvEy7kNANfzl0QA6qA0G1NPFX5eAg/EE+CEmzjgffq+YH1DmMVBYHDUK4uZECQFbNhJ7pKYAofg1O/h3nSEvfgYr0ZeKEyfBpJN4pCPZVPwVteRzNxVR4E88uCaG/AMdycY2GcJ10YNo+v22qVr1NLHSCGYMv+KdhL3ky2sIW/eDfi4wS5QcP+wT3rJ7dHyYl/dimc2V8WQM8LASRi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(8936002)(4326008)(86362001)(6512007)(9686003)(36756003)(6666004)(66556008)(66946007)(66476007)(83380400001)(8676002)(26005)(52116002)(2906002)(6486002)(478600001)(1076003)(6506007)(16526019)(186003)(316002)(956004)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Yx/93bbY8u5iD3/5w9WcDTb21INvyhxCFrb/D81aYp2EhY78320AvTO/pgnDaqTH4OoxnlQW7P27emH6acJk1PVjCGhNRwMYlfF2HednRANFdl3bDg2xLWd9HOsdHsAD+yJGjWNQpvw051mEgUGCXe/X3VzOn9mj2X5n5QmFbPvNgrH+ESkvHxzKFA8bgaAE3HdSrSikypH41eJ8rjTxmS+mPTTK0vgNUGxQ4xZOvG52iVcEQ/AAfnWSjmkLIWn/HAQYQphtpFALRNiR5Rim158GsOuBaeM68UZP8qII6t+dIXjAAjjN0Ep0FTFFGaz0pc6B5sIzSg0jDNCAv+escZg0ABKXoOuRSkzOSzLtiBzh2CMdVyW6ljplZvNwtP8uwQrIvA6FJbXc63SjQdPoqw8Fh6fjMg0Myb8849k0hn3/QEOcbATnxHvC1mYitnacfsmZUZwKlT/DIsQUpFZA8mIDf8rHHNDFV/12kDKtpqHcPPFyBTqzqj+up1H5Kk9cBL9z53PvtiEFB+yEa3IfcrG6km5cWiXU5yo7ZlIWlEN83A7aDlARgCnzsBrvPdOKcGMUphlVdHkte1VikoXUU3qrhsvy0Ue/MAoVhLDZrK8s9L6i1LwEU0YkD11IsoCDPF51DvdJPxAEoZech3Xx2w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a89ea1-9433-4f91-8175-08d874253d8d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 11:50:57.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61GGK79z9ajHF0TI0dHwOrypCLuePSKITkqCjqrB8r060xGSXafZigOSAVe6wFHUnA7E098PLboBIr+vH3BmkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

There are two 'start_pfn' declared in compact_zone() which have
different meaning. Rename the second one to 'iteration_start_pfn'
to prevent confusion.

BTW, remove an useless semicolon.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
v1->v2:
    Rename 'start_pfn' to 'iteration_start_pfn'.
v2->v3:
    improves commit messages.

 mm/compaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 6e0ee5641788..ee1f8439369e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2271,7 +2271,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
-		unsigned long start_pfn = cc->migrate_pfn;
+		unsigned long iteration_start_pfn = cc->migrate_pfn;
 
 		/*
 		 * Avoid multiple rescans which can happen if a page cannot be
@@ -2283,7 +2283,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		 */
 		cc->rescan = false;
 		if (pageblock_start_pfn(last_migrated_pfn) ==
-		    pageblock_start_pfn(start_pfn)) {
+		    pageblock_start_pfn(iteration_start_pfn)) {
 			cc->rescan = true;
 		}
 
@@ -2307,8 +2307,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
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

