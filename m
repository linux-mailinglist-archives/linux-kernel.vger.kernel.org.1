Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E42C66A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgK0NU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:20:56 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:13801
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbgK0NUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4W8h42KC+tuve8tPTBuxxqbSUaADFodArmw0B4sZp4=;
 b=ccRhqIZi9UVo4l0UYwQ5++Is4eHPOXlA+3b5poxqiHO5dd512DUC7UgMEB0CS9ODpUfhavp4vpt3AVsWZXBBRGFBU524xIvgHVW5faL3ZzceRZjGzpe50Mtd5yRwwVG6dMqunCnWs0TONgafGaEPjLR6IMo8dMPN5oM3uJMXKDg=
Received: from DB6PR0301CA0070.eurprd03.prod.outlook.com (2603:10a6:6:30::17)
 by DBBPR08MB4537.eurprd08.prod.outlook.com (2603:10a6:10:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Fri, 27 Nov
 2020 13:20:49 +0000
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::92) by DB6PR0301CA0070.outlook.office365.com
 (2603:10a6:6:30::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 13:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:20:49 +0000
Received: ("Tessian outbound 082214a64d39:v71"); Fri, 27 Nov 2020 13:20:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c722bb8456fde5d2
X-CR-MTA-TID: 64aa7808
Received: from 7d851b936626.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7F3099A4-5F71-4A5B-B361-4FD5C8893D90.1;
        Fri, 27 Nov 2020 13:20:44 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7d851b936626.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdLqBmhKUuS1hsf5G5Ghty0uZZBkyD8vxTF22waWWH4hEkVvL/QFzWxyBh/LliRhK3ZF1wtrABqszxrhplkT3EFQxZPr/onlsHC1nX/aehBCuvAeEKSZcHH3omXTjDtUiA0uahbPG2JfhPaoGFQGMZAYpM3L/Grlh/e1PMW4oQV0wkSuTBM2ajn4ZE8yQNnpWRHf2/iFjb7SFGEq1SysvTQUQYBPw4/ZvReQhBwQTe8rlt3yX8V4gCf7o+X6aJO97gbCCMFMdcM90N86xzcnHE7nhw1WIl3ehcG6EFO5X46Kkl+ShPkzz8u3wMHgWIslBvXYJFGivEH3yeDk/79oHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4W8h42KC+tuve8tPTBuxxqbSUaADFodArmw0B4sZp4=;
 b=oQpWL0c5CrPlCUrwIZBCyM3WCFHFfOEpHEfbM5Roxsk7i51yzNDT2dfGKUjebf68dcglj3oiW7kbxXH/QccpJ4Qf+FR5NXmCVhX+TmOhIUwhUqI7eqmcue/IaSr+iY7CmpW9ZKi9z3oEfmtTqeMfqpOR7DGIJy52MArNtXMRSSrvhabOy6BnIxZKShAXq8kPkbnL5BBZm+agtYOudfXnL9vtdjoBgy9/Ch9KbAsJ937jlZHESqto4NBP7GZQ9/uftzwamBv4tDQkcofJLkOlFfdee80xLclSS7uuVUET4UaO0UBT9Lxfw+rTU94KRqvX0AMhN17FP4YMlrDDu7dA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4W8h42KC+tuve8tPTBuxxqbSUaADFodArmw0B4sZp4=;
 b=ccRhqIZi9UVo4l0UYwQ5++Is4eHPOXlA+3b5poxqiHO5dd512DUC7UgMEB0CS9ODpUfhavp4vpt3AVsWZXBBRGFBU524xIvgHVW5faL3ZzceRZjGzpe50Mtd5yRwwVG6dMqunCnWs0TONgafGaEPjLR6IMo8dMPN5oM3uJMXKDg=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:20:43 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:20:43 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/6] elf: Fix failure handling in _dl_map_object_from_fd
Date:   Fri, 27 Nov 2020 13:20:29 +0000
Message-Id: <8ebf571196dd499c61983dbf53c94c68ebd458cc.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606319495.git.szabolcs.nagy@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by SA0PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:d3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e42a5194-6261-4371-2da5-08d892d7421c
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|DBBPR08MB4537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB453704E2D144F420DB5880B9EDF80@DBBPR08MB4537.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wckCYhRrptvH2hDAGN//RAyND2YoofEg/92zhQ7sYK0lOQ2Jjb5usPsQRDTvlD1L0saDq+prR+YySojIqIr+tTiZEPeZKvmXEsE1B7WFt7aAjwMz4k+kV0Y+Wx9F1r3Mk4SO2lqXP4EC/Ogp8NkyYT1bpPl7wEEaQG2HyY0oOxubZRtUmPFEkHaNxFafO2s4JTf02neahrLDyE63g6LvUl6jx1Dvs8NfKdOOfqRBgZQOA5LBzTCZo/X4YmilR7WQr5WHZEhbG1I3XTZYTbL6rJKZsevwOdtL+LnMnDiOwtj/Jn1gGKlIoWh0FJYintTr/isrH0WYvyCPHgQZCGoO/qAEOAlPZxGqsHAwG9Xu2eE23FH0gc4VVW+3e1H9Xb5G
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(54906003)(69590400008)(6916009)(6512007)(36756003)(6486002)(6666004)(316002)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(26005)(8676002)(66476007)(66946007)(6506007)(66556008)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R4Yu4qh4lbx4/u1KQNldVSznsB/U3fxexII6Bdbq50gSBJj+Kk425A6yfbiD?=
 =?us-ascii?Q?7uVhGsOcpP7kTTcKZTCDGPrv//KbpyXCgAlC93yzju1Yhqw8TlZ4rkDIk+Ug?=
 =?us-ascii?Q?EW8D/bCCaQl+lgmhPd3R2DZKk9Ux2+kpi1PhYrY6jP2KzKU9iEwP7dC53lWp?=
 =?us-ascii?Q?zi4eEUyO7HJVcdaRTtumnevelG/0UqayNnKmH7FqMM+42j+UbXfT1dEHb2DW?=
 =?us-ascii?Q?v+XoyYmhaUgulzLwSvGLZOM1nQshQs+WdESnewIMM9bfWbWz6QosE8er4a3b?=
 =?us-ascii?Q?ZMxdvAtQBHdhnUfAC1VprnE0iKrfrvJPTfTNZafm6dJF+31yleBTmpPaX5xl?=
 =?us-ascii?Q?VyZQL5Dor2SmhaE4HtFs2xu34CfrvCZ2KaSikbI4C4HAyKkDQw3BFwJfj2Q7?=
 =?us-ascii?Q?NHBlXaR60WLkR/gMxYRM47AQJ+AntTVl70F4OAHHpStu/yh6XlyNl3z6rmjd?=
 =?us-ascii?Q?eQgSMExqifH/uerZiIOz3C6W6IDl9fty5pmB62vjOyDdac1vmcp75laBYkY2?=
 =?us-ascii?Q?e7N5lUNKxdiVXn1zQY9AGqJPpIWNjPrn9qWtkfOpkmiAC3a3e/b0Hla+bSIl?=
 =?us-ascii?Q?wD4fZYe810GDKyTBomcJCObuKqYZL8MvhErlo1RL5SKRef8GH0eGZmfxoKi1?=
 =?us-ascii?Q?3E6CGTbyMXrEV4DsKGlYiHOJOqK/0dMFNz0cdWxTATcVsPgI+zqrikft0WmT?=
 =?us-ascii?Q?RtT20PtSSwU5Fa74+cekZiY1Uz8rLBlDv9WDA3OY4IhomgzZhRyGD84H3az8?=
 =?us-ascii?Q?9Y6cYMvBj/CZgfgWTZnauVgH1mlqvjzgvT7hz+jqa4aIN9A+PGzVZuzfHp1Q?=
 =?us-ascii?Q?ehFSsasWhFYBjO8+mMW13Y/SV5ChI5586gVeTWamTbCznCrZzGdLOi0iMtbU?=
 =?us-ascii?Q?0emQ2SmOuAnGuEibN839vY+Sa+VOS2LvvUiOlhE+jxDC9dH0CCc9W8H5xpLy?=
 =?us-ascii?Q?6KuKcaCQfmt+RpvUT/BGG/0AFh6Y92eIk0PZ/fU237yCfWucCNvb8xuq84cO?=
 =?us-ascii?Q?5NQn?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9dc536e2-20e4-4c3a-86a4-08d892d73e03
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCkQb1NEHIdTeR0xUbo88rv3Wy7oR8F5wWeyREVHaLhngJup8RvdxZOqvJEhghSOP0CvLI32+17lcEm4ns+N/gngrW6cLe7SxigRQOOQ3/I1y6HkocdOVFtYWzqLTAokc3eYhW/AW/yNC1hEtbsWrKdG/LsSJ+40BC5K6iLPVtw4W42topq82SKqCVGDarePblon0aIRWpY05m0etAR8LbyVoCeASd09L58eZDeHXpyqWopK57NI3VU8lnNRjso5Z/RlRNxDzF/UOdsYB5KvBumVR6rFpJ4Qg8k7wvJLKt/3LDWcGC5tC3KuoKDEO71qeSJEPSWsw1rUnAHkw3i8aFuL4q5T3DvQZuCDAMtJva5OcX4FOTqOCfRGNy3kDpJ4tZe7wqcl07KKog15zix1SnpaYnmaTkJUHlZYNpnh7+2yiG0Fr4DY2qQw3Xp/G8NP
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966005)(16526019)(34206002)(6512007)(478600001)(8936002)(107886003)(356005)(6506007)(26005)(70206006)(316002)(81166007)(2906002)(4326008)(956004)(83380400001)(2616005)(6486002)(70586007)(6666004)(82310400003)(86362001)(82740400003)(5660300002)(8676002)(69590400008)(186003)(54906003)(47076004)(36756003)(336012)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:20:49.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e42a5194-6261-4371-2da5-08d892d7421c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many failure paths that call lose to do local cleanups
in _dl_map_object_from_fd, but it did not clean everything.

Handle l_phdr, l_libname and mapped segments in the common failure
handling code.

There are various bits that may not be cleaned properly on failure
(e.g. executable stack, tlsid, incomplete dl_map_segments).
---
 elf/dl-load.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/elf/dl-load.c b/elf/dl-load.c
index 21e55deb19..9c71b7562c 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -914,8 +914,15 @@ lose (int code, int fd, const char *name, char *realname, struct link_map *l,
   /* The file might already be closed.  */
   if (fd != -1)
     (void) __close_nocancel (fd);
+  if (l != NULL && l->l_map_start != 0)
+    _dl_unmap_segments (l);
   if (l != NULL && l->l_origin != (char *) -1l)
     free ((char *) l->l_origin);
+  if (l != NULL && !l->l_libname->dont_free)
+    free (l->l_libname);
+  if (l != NULL && l->l_phdr_allocated)
+    free ((void *) l->l_phdr);
+
   free (l);
   free (realname);
 
@@ -1256,7 +1263,11 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
     errstring = _dl_map_segments (l, fd, header, type, loadcmds, nloadcmds,
 				  maplength, has_holes, loader);
     if (__glibc_unlikely (errstring != NULL))
-      goto call_lose;
+      {
+	/* Mappings can be in an inconsistent state: avoid unmap.  */
+	l->l_map_start = l->l_map_end = 0;
+	goto call_lose;
+      }
 
     /* Process program headers again after load segments are mapped in
        case processing requires accessing those segments.  Scan program
@@ -1294,14 +1305,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
       || (__glibc_unlikely (l->l_flags_1 & DF_1_PIE)
 	  && __glibc_unlikely ((mode & __RTLD_OPENEXEC) == 0)))
     {
-      /* We are not supposed to load this object.  Free all resources.  */
-      _dl_unmap_segments (l);
-
-      if (!l->l_libname->dont_free)
-	free (l->l_libname);
-
-      if (l->l_phdr_allocated)
-	free ((void *) l->l_phdr);
 
       if (l->l_flags_1 & DF_1_PIE)
 	errstring
@@ -1392,6 +1395,9 @@ cannot enable executable stack as shared object requires");
   /* Signal that we closed the file.  */
   fd = -1;
 
+  /* Failures before this point are handled locally via lose.
+     No more failures are allowed in this function until return.  */
+
   /* If this is ET_EXEC, we should have loaded it as lt_executable.  */
   assert (type != ET_EXEC || l->l_type == lt_executable);
 
-- 
2.17.1

