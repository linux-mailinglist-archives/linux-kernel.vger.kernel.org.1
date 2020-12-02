Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCA2CB7DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbgLBI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:57:01 -0500
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:3035
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387805AbgLBI5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo4g1VjjeNpD+m+0h54bDJSCv5eSt52W6wWRAK1/PYM=;
 b=uR0yYnVyuukvEXdXt9RpyTgABejcTt3QG6finUapNKgOUmOHa8nz0Tg6QBtcbYi9lNzMPBmLls8jN9J7veME++VXl4vnoze73i20vK0wvFfWdymFR3eZkdWvDUdJPj0Oe5+gHJFDCU4qn4Kifl1Uq2FADgd4GaMr9bp2GpXG3Uk=
Received: from AM7PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:20b:110::15)
 by DB6PR08MB2661.eurprd08.prod.outlook.com (2603:10a6:6:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 2 Dec
 2020 08:56:05 +0000
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::ef) by AM7PR04CA0005.outlook.office365.com
 (2603:10a6:20b:110::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 08:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 08:56:04 +0000
Received: ("Tessian outbound eeda57fffe7b:v71"); Wed, 02 Dec 2020 08:56:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc848dc2bf9ee73f
X-CR-MTA-TID: 64aa7808
Received: from 0fa8f2697906.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 37FA4EAB-0DB6-468C-BFA6-02371FBAA784.1;
        Wed, 02 Dec 2020 08:55:47 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0fa8f2697906.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 02 Dec 2020 08:55:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1/1/+BFQhLpclKryv/5T9Sqn2L1R9HY1wAPVRAxi8kcy1JI6QIOpY3Thq4jqB6JxAjn78UodcJq9wEaNlCMq+a5wrgK4J2dBTANCTdc5Mg51z4InKoyIUHa2ckirN9FhJw/GTabp+MU0SUiUol8yxvw/pnQNBMs4oRUGgVca/FLhW+msWhBK0nSBioEEEHkSU/a37HCKKP8Bkopj/DvQ02jzsRiL0GEnRjDaNdI91Nj8fPk13yzSk7roy5kjDPikG4eScSmoYaOQtOCZ+NL4v3Oy5PapvQzh2x3OvulxvcScl70KhuG7x40fAuRKg7oWYjn8eOPdXX3s+xtC7C1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo4g1VjjeNpD+m+0h54bDJSCv5eSt52W6wWRAK1/PYM=;
 b=aiszp8W6+gV9pf6VFMGKYbHYJZvH56b+uhhSJQTvrF9KJnnd6vzrBHf6rj3m0Lb1Ob7uy93M3e/9qjWBOQv6URfu/DO3bb9sY8oc2Ifz27Q8ZXfW+XUw/9PZ2Vcc+w/ndDH9H+Fz+EvvLa5R6+8qn4gPVa2v/Wl4gXr+b/PdshWYTU6lcUrL8RtVODUYrJW/4Te09S9TGArIh0iKN9qUbJGqxO8DbrlX4ijPzltPpRMGFAIopP9Tq8PK+tGloh/MN6F5JkMZ0OVeUUCJ4JyecbYXdCRhMgAK+hpN9PX4xJwp0VvQGNQ4L2gwbHN5lTVtrFTM/fPkQFtYct7dt1kBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo4g1VjjeNpD+m+0h54bDJSCv5eSt52W6wWRAK1/PYM=;
 b=uR0yYnVyuukvEXdXt9RpyTgABejcTt3QG6finUapNKgOUmOHa8nz0Tg6QBtcbYi9lNzMPBmLls8jN9J7veME++VXl4vnoze73i20vK0wvFfWdymFR3eZkdWvDUdJPj0Oe5+gHJFDCU4qn4Kifl1Uq2FADgd4GaMr9bp2GpXG3Uk=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR3PR08MB5644.eurprd08.prod.outlook.com (2603:10a6:102:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 08:55:46 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 08:55:46 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] aarch64: Use mmap to add PROT_BTI instead of mprotect [BZ #26831]
Date:   Wed,  2 Dec 2020 08:55:40 +0000
Message-Id: <7e800caa0485fec67b21ebab1e27bb23b2f0d971.1606898457.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
References: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 08:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7e4cc43-a5e9-477f-7291-08d896a01a0f
X-MS-TrafficTypeDiagnostic: PR3PR08MB5644:|DB6PR08MB2661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2661F855DF98DE29AAA328AAEDF30@DB6PR08MB2661.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: teIoYpkYojRI/jYUYuTkWXQf5GOXRSS2bpllNpYsSAsPClOX3OVjyCp2Uh32oooSxOCi77vFkN2xWjE5gSz8vlBd6gP85FObE6EmXyqhetwurUxpoUV1mK9wEmDniAxbxh2eHfkwON9nsCTI2fjeXryyUgT5CJgl1IsU7mI6ygF2ChXqmsHyChtHj4g/qpsLdTsETxlhBpA3KbP/0dqKAlnfcybwfXcZ1O5JC45tRvjdcoIztdKuzS66o/YC+mijWZluwsmxDn8VDpR3LL2gTC1jLNu/fEkilj69lDKj+1evtS46O9w3j1UorztSMsyrRxYCZ74NnfDMm+zrhfaTZxdL9/k8K4A7P2ol1r3ruW/UYkp6mBSAplhra/0v8d92
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39850400004)(346002)(136003)(44832011)(956004)(2906002)(316002)(86362001)(8676002)(8936002)(54906003)(6666004)(36756003)(478600001)(66946007)(66476007)(66556008)(5660300002)(69590400008)(2616005)(52116002)(6512007)(4326008)(186003)(6486002)(16526019)(6506007)(6916009)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jWjZJ7jpYgfUVyQ90oifYa0y+saFIDNkgH2AZFtIuJg4GU19GLDb1HHGKm3r?=
 =?us-ascii?Q?0WFWH5auFkkLgXYSZKNRjsdmES3r+ltfzUobUxl9PLkaqxCEEjNi1+dT1eEN?=
 =?us-ascii?Q?K8P+1MaWg2Lchmz+vRp4ERFM0V5OFQ39q7RBfACr6nNl0LAIjMv/idohamA/?=
 =?us-ascii?Q?O/P0LQ0p9hVvAYfofrum0X7cx1ENvSuVWI0o0sCpZOEnB8mWIVFbYWjAJaXG?=
 =?us-ascii?Q?7rG1WRDSGQCy+q6BownUtb/6an3nbNzIHzJrmihjwdSBW+KR7AVu5N/JKJz5?=
 =?us-ascii?Q?rmXS1/VyrLoznqXd7rbj6CjnEZqGqYfQLDoTGfuZXz/XyNAtK4RmNsSQq28/?=
 =?us-ascii?Q?M2MM/AM63r01EWz4kXAIRr8+E9htuxfHMu2BTQRGZ5NjEawojZ/FOsQGAxzZ?=
 =?us-ascii?Q?FcZw2OlRvom9qtmodJEk4eA1C5wtjhn+FGZ8P6xdd+JpIC5+e08dh+5BAxPK?=
 =?us-ascii?Q?YVjsD8uIM5tpcA2mR8LDHlLcgVfPVw9q0sVz7r009/GD5eI1kBep5Snm+7or?=
 =?us-ascii?Q?Pb2Q2As+RAAz76N7WaaCXoYWQDEAadhT6I8lCiJMilKU/nmq3PvzpiByfR9T?=
 =?us-ascii?Q?C2jO2gZtq6KACYixmyCYALDQKKfWlTXQLZ50krQNfsAQ3zfn0B3sWI/+W2mz?=
 =?us-ascii?Q?KXYKlvEYZmzebZb8Igpiyc3QJ6TmCmsomMSTlwmZDgAaBcntdNuGB7UU8dos?=
 =?us-ascii?Q?E0jz9qlDFgLsjnEPKBt4mYHiGVJOiSiAmBwiVS4nrytRXBzXPSnaSoH65JjN?=
 =?us-ascii?Q?4GImTmHG4FumUtV7fALtOudtUyRncOn+heFjgpm1LmnY734IbD4qtzGwgYy9?=
 =?us-ascii?Q?XbnGmlFkV7x+FxWtSMwtz4VRqq+IKm+Iam5WngxbYKpP13Ks+T5tVuQVgXJA?=
 =?us-ascii?Q?WFs4qWfgYULnwfn/bHTuIxPPezEXMmFKtBlBZ14nfxAtXgRae23uWbCkeVAL?=
 =?us-ascii?Q?JexpcRaqOOqs/tjK9kn0gD3V8jb/muhDZXxd3zEvcWkwdRuEg0U5sXaDT7cN?=
 =?us-ascii?Q?v0Gd?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5644
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d0817323-7a2e-48b1-7f54-08d896a00ed4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TI3cdSxv47VIRdMxsq2b6x96itJh2vzAoxkMYFLfIfQJEr47v5wFWYsA7MvxTyp9U5lHhl7Os1t+B+elCn0PccwX6Vv6Xg8OdQXWu+Lu5uIIPIPesPKUXKCbEXpaXp12y1pvUoRHfEcl8PgEPCZ0h62j0RqZ4oUJdzW3Qtkm1JF7ETRxIHAHFGfGD7VYnOPuBdXNcPxPayrNzPDYtdpLZyf77DkCe32qCv+bwfoBirqyXYHDCdh2ohkiOnZay4Rw99G/O0jua5z9NIO47i1mg4Mnf3jyZJQwbaKvAuJEc2p4mgQXIdPQB1VSx1c/Jmmdqd65fYoqONFUY5mttuJDJoXjlFompOsCkXyWgq3F28vPbqcdcUNjaFrgXpEtBWonRgnNpSYJX19cDZ2QecT0HTdkegj4Jq3RBtSAoCgYsoDMWL8PecUqiwHcFUHjT/dQ
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966005)(2906002)(70206006)(8676002)(2616005)(26005)(47076004)(186003)(54906003)(82740400003)(70586007)(356005)(83380400001)(81166007)(6506007)(956004)(316002)(16526019)(86362001)(44832011)(69590400008)(6486002)(478600001)(8936002)(36756003)(34206002)(6666004)(107886003)(5660300002)(336012)(6512007)(82310400003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 08:56:04.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e4cc43-a5e9-477f-7291-08d896a01a0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-mmap executable segments if possible instead of using mprotect
to add PROT_BTI. This allows using BTI protection with security
policies that prevent mprotect with PROT_EXEC.

If the fd of the ELF module is not available because it was kernel
mapped then mprotect is used and failures are ignored.  To protect
the main executable even when mprotect is filtered the linux kernel
 will have to be changed to add PROT_BTI to it.

The delayed failure reporting is mainly needed because currently
_dl_process_gnu_properties does not propagate failures such that
the required cleanups happen. Using the link_map_machine struct for
error propagation is not ideal, but this seemed to be the least
intrusive solution.

Fixes bug 26831.
---
v3:
- split the last patch in two.
- pushed to nsz/btifix-v3 branch.

 sysdeps/aarch64/dl-bti.c  | 54 ++++++++++++++++++++++++++-------------
 sysdeps/aarch64/dl-prop.h |  8 +++++-
 sysdeps/aarch64/linkmap.h |  2 +-
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
index 67d63c8a73..ff26c98ccf 100644
--- a/sysdeps/aarch64/dl-bti.c
+++ b/sysdeps/aarch64/dl-bti.c
@@ -19,9 +19,17 @@
 #include <errno.h>
 #include <libintl.h>
 #include <ldsodefs.h>
+#include <sys/mman.h>
 
-static void
-enable_bti (struct link_map *map, const char *program)
+/* See elf/dl-load.h.  */
+#ifndef MAP_COPY
+# define MAP_COPY (MAP_PRIVATE | MAP_DENYWRITE)
+#endif
+
+/* Enable BTI protection for MAP.  */
+
+void
+_dl_bti_protect (struct link_map *map, int fd)
 {
   const size_t pagesz = GLRO(dl_pagesize);
   const ElfW(Phdr) *phdr;
@@ -41,19 +49,31 @@ enable_bti (struct link_map *map, const char *program)
 	if (phdr->p_flags & PF_W)
 	  prot |= PROT_WRITE;
 
-	if (__mprotect (start, len, prot) < 0)
-	  {
-	    if (program)
-	      _dl_fatal_printf ("%s: mprotect failed to turn on BTI\n",
-				map->l_name);
-	    else
-	      _dl_signal_error (errno, map->l_name, "dlopen",
-				N_("mprotect failed to turn on BTI"));
-	  }
+	if (fd == -1)
+	  /* Ignore failures for kernel mapped binaries.  */
+	  __mprotect (start, len, prot);
+	else
+	  map->l_mach.bti_fail = __mmap (start, len, prot,
+					 MAP_FIXED|MAP_COPY|MAP_FILE,
+					 fd, off) == MAP_FAILED;
       }
 }
 
-/* Enable BTI for MAP and its dependencies.  */
+
+static void
+bti_failed (struct link_map *l, const char *program)
+{
+  if (program)
+    _dl_fatal_printf ("%s: %s: failed to turn on BTI protection\n",
+		      program, l->l_name);
+  else
+    /* Note: the errno value is not available any more.  */
+    _dl_signal_error (0, l->l_name, "dlopen",
+		      N_("failed to turn on BTI protection"));
+}
+
+
+/* Report BTI protection failures for MAP and its dependencies.  */
 
 void
 _dl_bti_check (struct link_map *map, const char *program)
@@ -61,16 +81,14 @@ _dl_bti_check (struct link_map *map, const char *program)
   if (!GLRO(dl_aarch64_cpu_features).bti)
     return;
 
-  if (map->l_mach.bti)
-    enable_bti (map, program);
+  if (map->l_mach.bti_fail)
+    bti_failed (map, program);
 
   unsigned int i = map->l_searchlist.r_nlist;
   while (i-- > 0)
     {
       struct link_map *l = map->l_initfini[i];
-      if (l->l_init_called)
-	continue;
-      if (l->l_mach.bti)
-	enable_bti (l, program);
+      if (l->l_mach.bti_fail)
+	bti_failed (l, program);
     }
 }
diff --git a/sysdeps/aarch64/dl-prop.h b/sysdeps/aarch64/dl-prop.h
index 2016d1472e..e926e54984 100644
--- a/sysdeps/aarch64/dl-prop.h
+++ b/sysdeps/aarch64/dl-prop.h
@@ -19,6 +19,8 @@
 #ifndef _DL_PROP_H
 #define _DL_PROP_H
 
+extern void _dl_bti_protect (struct link_map *, int) attribute_hidden;
+
 extern void _dl_bti_check (struct link_map *, const char *)
     attribute_hidden;
 
@@ -43,6 +45,10 @@ static inline int
 _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
 			  uint32_t datasz, void *data)
 {
+  if (!GLRO(dl_aarch64_cpu_features).bti)
+    /* Skip note processing.  */
+    return 0;
+
   if (type == GNU_PROPERTY_AARCH64_FEATURE_1_AND)
     {
       /* Stop if the property note is ill-formed.  */
@@ -51,7 +57,7 @@ _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
 
       unsigned int feature_1 = *(unsigned int *) data;
       if (feature_1 & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
-	l->l_mach.bti = true;
+	_dl_bti_protect (l, fd);
 
       /* Stop if we processed the property note.  */
       return 0;
diff --git a/sysdeps/aarch64/linkmap.h b/sysdeps/aarch64/linkmap.h
index 847a03ace2..b3f7663b07 100644
--- a/sysdeps/aarch64/linkmap.h
+++ b/sysdeps/aarch64/linkmap.h
@@ -22,5 +22,5 @@ struct link_map_machine
 {
   ElfW(Addr) plt;	  /* Address of .plt */
   void *tlsdesc_table;	  /* Address of TLS descriptor hash table.  */
-  bool bti;		  /* Branch Target Identification is enabled.  */
+  bool bti_fail;	  /* Failed to enable Branch Target Identification.  */
 };
-- 
2.17.1

