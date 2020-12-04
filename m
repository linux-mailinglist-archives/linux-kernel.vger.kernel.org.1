Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCDB2CEC58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgLDKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:39:35 -0500
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com ([40.107.223.86]:48503
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729858AbgLDKje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:39:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoBlHWFP6QGskLGoGasFvn86LPuGncdghdDG+akxzfBAv8zTl/8hngsluE1CC5zGmJMPGs3NLRcyMeXNfUlfhoeQGumOvhRyHp9s+laP1QRbYnbh6dclHHaIHe7K4idaP9KzYTfK8yzdWB26wgADKbQFffLvF+i1BJmJRZ3y+OjoEjWNVzD/g0Ns7ZErxXk2UqNBFl3SOStZpxM/2kR6JxXtpIGhe8N3jHyTfTgvt0E5vTCuTVelGh/XA0k9cCLi2Wj6Tyzn7sA2rPqWf0r/BlI9ySdsCXNsQfcRQNgJOrZTPrgl+CxMLJTD4kI4o7osB6+RdprFclVrCDghd3NAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBvjVE5Zcie2A2lkIze805LcC6PKKDd4S9Edl6daNU0=;
 b=jYI2NqP6hRrflcyvJs3GeCrepcyeOZ0YSYPGh4QYuAxvpo+paZ/oHxOvRCLR3S1kjYizUdT2uLflk5l+WmLI/qDSf8nXTNlsWFrQSzd299voJBPEwhQ+YI1HETa8E4A3AUdzXgYT94scHStuoj32Mr/DhQVSMAEbthBImFK1b3rfQQleDtddvrcND2sN8YZCPMUwhMvyTODwziRbUqN54cbmUktxhmfeo+CNf5d/kL7slmht3NMALWIRcbsTyQMX4ZCqdrmznAXauy+L6bZmwBOpZOhppoh9uusf4Sv7SEacPJ3nz0RtUBXRlEfguWpYkNEUZzQHj5ccRAypp6AwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBvjVE5Zcie2A2lkIze805LcC6PKKDd4S9Edl6daNU0=;
 b=phwHs82ycmNGzIZaic/FYMtm2bBf4o047FEDwpVr5VicwrE/UjszjDQkkscmYj9oJFZeCrYxj6whWGo/OItpxveDEtRC3oazb/oAi/EUbxveRwkedzmf4vujy73EY5kmAjOJ6lMAE1X9zfVX0jDQapi1JuQxWr1m66nmixFEZTk=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2903.namprd11.prod.outlook.com (2603:10b6:a03:89::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 4 Dec
 2020 10:38:20 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 10:38:19 +0000
From:   qiang.zhang@windriver.com
To:     aryabinin@virtuozzo.com, dvyukov@google.com
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, qcai@redhat.com,
        kuan-ying.lee@mediatek.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: fix slab double free when cpu-hotplug
Date:   Fri,  4 Dec 2020 18:22:06 +0800
Message-Id: <20201204102206.20237-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR04CA0070.apcprd04.prod.outlook.com (2603:1096:202:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 10:38:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e55f0a6-acf7-493c-680d-08d89840b758
X-MS-TrafficTypeDiagnostic: BYAPR11MB2903:
X-Microsoft-Antispam-PRVS: <BYAPR11MB29034A4B9795E390126E6CFDFFF10@BYAPR11MB2903.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNq9c4aXmiB1mZqcB/h2bndcCLkAOtEEQeS9tV0hlndURORbPhJvEiRRCRC0LmZq0+CDKWXqjDtiavLPViWLA8ooM2WYPyBliWQ8zbVWdpgB7/sUPn0sscYTWscaTm83jE7xRBWSbjsqM8SfwlBAbuFtGcjF37q3kgkhRAO+8YlmlnYSqEafARYsYqc/F9Sm7gVRak6jD4Ulne+/Od/XBe7d5AcdSNaCucpocjmfgzFis/zOly4bDNzbF0h6EL2y28bRh1chX4wwjonQ86Hhr+BTGTlkivihKWT9u4Tn01GJC8cN3NYsHbtZPAvNxSmz4twoorXBstTZBVD3JuuEBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(52116002)(6666004)(26005)(66476007)(8676002)(2616005)(6486002)(956004)(6506007)(5660300002)(86362001)(16526019)(4326008)(83380400001)(186003)(66946007)(4744005)(478600001)(8936002)(6512007)(66556008)(2906002)(316002)(1076003)(36756003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K/91uS6PBJP26I7CzBabnVv7/LzCxj8MoOHtpmmi7oMAFs3l4BXyQPsYK+2r?=
 =?us-ascii?Q?3UIrFnnQ15Ql+SzPK/wbuYd9myZ+vLg/Z0MHCsO92bvq2mdFPCjhKsD0//Oc?=
 =?us-ascii?Q?duHfukZkShbjqqRBN6Mf93eGhZxYQGLclPAG7lpTtKg7wGoQVALyCZ4eQvzy?=
 =?us-ascii?Q?OfS/qcqdj4HR1X8Ck4epJ4HSz5DB/Q8M6xe4+HBRhSSJ+/OUTUgzQtSN6V0M?=
 =?us-ascii?Q?3r8qRnWzLN5dJUPClJirAkfCyBVLiraWSddwiJNXmmXPVkdeW9SFCp9Pfwce?=
 =?us-ascii?Q?Bq6REjYHbDKawykYtHkIRWytD1NBLEVIN9kRuDC/mhMhCQeW701Tvy0Yh2BI?=
 =?us-ascii?Q?kWM4Fb0tRzbwbjPomFLv7WSpqXS9aMpCovF3nYW4Ah6/10f5B4EYslox+IQO?=
 =?us-ascii?Q?sEBeND8LM3C1TV3drjgZ+xriNZr5wI+qTxU8SGSTZbmC0NqszjHdjNEhx9lS?=
 =?us-ascii?Q?PcMMlDx5cxinT20K6pnZkglaRFt/arjj8UVopykCJIPqb2CqK1UnRCnnt/lz?=
 =?us-ascii?Q?0EhOGuu1R5BTZQsdKY+m3MnlzDz7jCwnc5wi90W4qd57wCiG02OFK8Ej5292?=
 =?us-ascii?Q?8P1OV4ORROyA60me9j0RiBmQm2hJz8vSV2zqZ1LAfrT7lZfZikw9AuSXYbD+?=
 =?us-ascii?Q?bJDXYnAURb+bP+ep0zZYaK8z/dqJ19iudAToPDWuAQrZ7W2gYXrUovrxdhYw?=
 =?us-ascii?Q?eoZw9JLmCJcr2SHGLt7Gbd4uRMCNMLbpKwOh9KkDRxlqZxvnZzzTppZRr/G4?=
 =?us-ascii?Q?g3RcHqHvQSiE32wpalkH7DdvCigdwIHD4axV0EaKGMsyLndN3ndUyCY6flJH?=
 =?us-ascii?Q?iC6ybU4gwml5P9XYxAqiUetUH2miaCBvDz88rTv5TOLuEvXCYKTVAvLOHMEk?=
 =?us-ascii?Q?J65E8/Eua1wU4dXh9Id5siNDa14g3xeumUFhjsdHvafVqjmDm01zVyeRg9An?=
 =?us-ascii?Q?BetPHecJmQksmroq+M2udpJ8Mbw5ZkeOiRAk8uaJ6ck=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e55f0a6-acf7-493c-680d-08d89840b758
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 10:38:19.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C2dCfWZt77LcqjBd83skumSoL8rwxXdYIRIM062MCZEtWRY8+RgHCo1/q1jxRAjZY9Tg6rw2ZXG5zHuaEak7+pIZp/6BUCwtsREP1SJano=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When a CPU offline, the per-cpu quarantine's offline be set true,
after this, if the quarantine_put be called in this CPU, the objects
will be free and return false, free objects doesn't to be done, due
to return false, the slab memory manager will free this objects.

Fixes: 41ab1aae781f ("kasan: fix object remaining in offline per-cpu quarantine")
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 mm/kasan/quarantine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index d98b516f372f..55783125a767 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -194,7 +194,6 @@ bool quarantine_put(struct kmem_cache *cache, void *object)
 
 	q = this_cpu_ptr(&cpu_quarantine);
 	if (q->offline) {
-		qlink_free(&meta->quarantine_link, cache);
 		local_irq_restore(flags);
 		return false;
 	}
-- 
2.17.1

