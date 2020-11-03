Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7252A41DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgKCK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:27:37 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:22325
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727186AbgKCK1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+UNM3Lv5/vv+slUK/0uE5dl2sBpP1JzcBI5gH+FV0Y=;
 b=U+JRAS9dkHmx8i2SXzWRtugfJCWqyf5SOZZz7jSCM4rLJM2jksLVPauVzvlu6c2OeG1TBGTGfpxNHTub1ofTqN6qt2X/beNnHL5js6hmrqIovE6jqe0jEYlx2EvO5h26lxDlTIdskIsT3f+Wk+hoX4BNsGh8ZHcf+FNoIo9Kdms=
Received: from AM6PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:20b:f0::48)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 10:27:31 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::6a) by AM6PR04CA0071.outlook.office365.com
 (2603:10a6:20b:f0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 10:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Tue, 3 Nov 2020 10:27:29 +0000
Received: ("Tessian outbound e6c55a0b9ba9:v64"); Tue, 03 Nov 2020 10:27:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a0ddbe5a41be8d3e
X-CR-MTA-TID: 64aa7808
Received: from b1f5d2e3f37d.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 767AF9CE-5DC1-4C50-A568-C4CBB4D6BE4F.1;
        Tue, 03 Nov 2020 10:26:49 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b1f5d2e3f37d.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Nov 2020 10:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVZ71hYgIZjZfbwrp4bNq9AK8oPE/6SLJ+z086UwdxCOBKpUc5XUIIKGyTeN/kEg++bx2gH+ZTjnB8AqeqById0zX4cZBAM3wB0YwL0RVNMe6Gfk0PzACcrYmQ2GBvJKuoJ/12iglN4YSYouNYGQP4CpwrVd95L9a4Qk/Axz2ZlSSSxvZ3JeJqjgnhZOiizaFEy1x7yny9IFqzFLDALzhex0dRRHw3hxs53VB6Q4HJxwbV26O+HlIcyLlkBoUzoqv2AY/TTR229h6WzHBa2yEnQZai6gxbX+3FasWeVfv/abOTK3q1cXR2szH297wO/H/T247PfoBpATSn3KpylTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+UNM3Lv5/vv+slUK/0uE5dl2sBpP1JzcBI5gH+FV0Y=;
 b=KNk6/OCe3IQR8jqPiC6DnnRD9RPI+Q+6X57WOWuPTYPIDn0eVTJiJ2mmgVzDqPoE/KJuqKK3nMtnEt0XzZDnBex1kSGh7X0idjy8eNh7bEImbPTausoY5IrHh1/T43EpKPHVjbMaeIZaUNpYwrbHcrhnSZlJHnMPO3Ihw8cfSyID2GsUZ67iJPERNEnW5zFAtK5xP+cP1zHnIXjWCOxOJWRMLfBOIGD84i9FVVroTcojIavluSwVJDtqHtDwFsm+XnEfV6xD5ASTyQ3CHDJIl3x6dJzpp31hStSTTkQCPSnRicIOek2P+Xfn26bpR0abpBeeKVj4Ux6zgc6ZLqvecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+UNM3Lv5/vv+slUK/0uE5dl2sBpP1JzcBI5gH+FV0Y=;
 b=U+JRAS9dkHmx8i2SXzWRtugfJCWqyf5SOZZz7jSCM4rLJM2jksLVPauVzvlu6c2OeG1TBGTGfpxNHTub1ofTqN6qt2X/beNnHL5js6hmrqIovE6jqe0jEYlx2EvO5h26lxDlTIdskIsT3f+Wk+hoX4BNsGh8ZHcf+FNoIo9Kdms=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6223.eurprd08.prod.outlook.com (2603:10a6:102:e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 10:26:36 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::2904:edcf:b299:f792%3]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 10:26:36 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] aarch64: Use mmap to add PROT_BTI instead of mprotect [BZ #26831]
Date:   Tue,  3 Nov 2020 10:26:29 +0000
Message-Id: <f5eaa74cb7538382b2fd2439755386ac68f7c8db.1604393169.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604393169.git.szabolcs.nagy@arm.com>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 10:26:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4248ffe4-b2e5-47fd-5cb9-08d87fe311fb
X-MS-TrafficTypeDiagnostic: PA4PR08MB6223:|AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849F43ACD561612C58C15F0ED110@AM6PR08MB4849.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pFJzWG8Yw5e/GUYk3D/pVFVvWPOjiV6M9uIjJphRlHnGQsHOn+hoZ3lsdtBSnnEOZn6nzma3/gtL/Wuh4ePIs0zTVYWKqRRMHASmjNHe2bw+DgY8UMa67sZ3XcvVwKBgwJ9wG3Y4DeBO+ptvj2aAml4LqAFvNKOgdi9EEkq6/F1nOe87MLSLk124ih2ufbVpqYsyVolpKsaaEbXxxxWI4TZJBXRj3bS+M0nzfXm4O6Enxsc4Pf5HH0LFx8jap5gGHsJ83AIlu55M9hXgpZnfPn1uOsGj133zcyJ7tXhILSlk0KslmUQ/0AGemmVAmWh4p/HINnqrzheu35ks3ltz5fAkECWnn46EwORlqchOfrL+WjFjNKKRso8ta5jhra/2
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(5660300002)(2906002)(66556008)(6506007)(8676002)(66946007)(478600001)(54906003)(66476007)(6666004)(6486002)(4326008)(6916009)(6512007)(69590400008)(186003)(16526019)(2616005)(7416002)(36756003)(956004)(8936002)(86362001)(44832011)(83380400001)(52116002)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hDNYcEUHdOkCPtFy9z0Y2Fh3enuTGFcmEu04hq0ufK3iZbr6P8OO8W+GP0Y8X3C4AFsLoSg36mosfLULF2RAVNZdvrjzyXWjP3m6ib6Id1HwrefhRCbvEeRh/XTfRAVtgv0Jk9cApl56ktRou/zIUDBWkMBLBd/lUc7WaSlfrkXiL7SyOPiGveqVcNfygaGp+7UZP1ONGX5YPwZIOCB5piaTKceGDN4E3gdOmeq5StH6PxZhLVxN1GSr7ANTnLuSubLU109DsXmfgCHiyDd8awvL9xnY4w86/sWaAT1yjLHFB02kkWnZjjWTcPu+X6tVO+vzt88rCc3jh3lFQHaExjsnm8U+j1+RutF260PvPYGVs6f2UJVKW9KeYh+vU6zQOmDxxPkn4JeIHCY22PXLRaGdiuW51fv2KiW/SiJb2nz+4ye/vEeTMGvY4G58Zjo5J0q6qKK+jESJcJba8edbH8oFD2VTT5XMaZ9i7M12TBJ9MsTJ/gDL6LT8V5rEDg15Hr1HbQBkd++OG5E+gdwxIR4s7iS1LcxShHALONAla/NsnpWJt2mJjMYT49Lgctjm2d9iaVjlya3L2ElQ/sWqOh6xKK7Sc7XB0OOTzIOtlvsjeCEphsIzTFjE71Olm44W+yQzxm38E1F5t6Dg1aKqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6223
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: facf50f2-b8a2-48ba-8cb6-08d87fe2f13c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbdjhTBZSyjtI2uaq9coCZAtqjYn2+7JBvjhzrZdeB2vfVgckehFFNBbAJJ266F5va8MdQzOTF8ZKdBHiQdlYdqlMJynnZUtBiAXWzaem2/HF2+DhefsQ+wGNxl2kchjcPp1XtXiXt/nhiOjaepqkXdHiZuXagBKRHCiEQIn1SlRTr7RTTSAOS68UgrJHWR2PcCMi/c74ObJYtYSFjSb6dpl9aUMu+TOUW1fMmTDvjrvQvzhfWxvRGwXeAvIM9fGPASvGJ5KScouMMQd0iIa1/ggUBiDmrY6iA0/2Be6m5sMuAqdGvBqTtUbQJ3QwNWkKLfLO/7rz70VqvS6ehqbawoR6V5nJ6OJctTnLIZzaMn1Kb7Y2jynB0a7e7SzMwH2mdzj03cGqqI5XS5jVNv5l2oAOC9KDDi+vZ3dHS0cLmXtLn+lFMeLio3aYXLqs995
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966005)(8936002)(6486002)(8676002)(44832011)(956004)(2616005)(54906003)(4326008)(82310400003)(69590400008)(34206002)(6666004)(450100002)(186003)(478600001)(16526019)(6512007)(70586007)(26005)(70206006)(86362001)(82740400003)(36906005)(316002)(6506007)(81166007)(356005)(336012)(36756003)(83380400001)(47076004)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 10:27:29.7190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4248ffe4-b2e5-47fd-5cb9-08d87fe311fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-mmap executable segments if possible instead of using mprotect
to add PROT_BTI. This allows using BTI protection with security
policies that prevent mprotect with PROT_EXEC.

If the fd of the ELF module is not available because it was kernel
mapped then mprotect is used and failures are ignored.  It is
expected that linux kernel will add PROT_BTI when mapping a module
(current linux as of version 5.9 does not do this).

Computing the mapping parameters follows the logic of
_dl_map_object_from_fd more closely now.

Fixes bug 26831.
---
 sysdeps/aarch64/dl-bti.c  | 46 ++++++++++++++++++++-------------------
 sysdeps/aarch64/dl-prop.h | 14 +++++++-----
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
index 196e462520..385f1731ca 100644
--- a/sysdeps/aarch64/dl-bti.c
+++ b/sysdeps/aarch64/dl-bti.c
@@ -19,43 +19,45 @@
 #include <errno.h>
 #include <libintl.h>
 #include <ldsodefs.h>
+#include <dl-load.h>  /* For MAP_COPY.  */
 
-static int
-enable_bti (struct link_map *map, const char *program)
+/* Enable BTI protection for MAP.  */
+
+void
+_dl_bti_protect (struct link_map *map, int fd)
 {
+  const size_t pagesz = GLRO(dl_pagesize);
   const ElfW(Phdr) *phdr;
-  unsigned prot;
 
   for (phdr = map->l_phdr; phdr < &map->l_phdr[map->l_phnum]; ++phdr)
     if (phdr->p_type == PT_LOAD && (phdr->p_flags & PF_X))
       {
-	void *start = (void *) (phdr->p_vaddr + map->l_addr);
-	size_t len = phdr->p_memsz;
-
-	prot = PROT_EXEC | PROT_BTI;
+	size_t vstart = ALIGN_DOWN (phdr->p_vaddr, pagesz);
+	size_t vend = ALIGN_UP (phdr->p_vaddr + phdr->p_filesz, pagesz);
+	off_t off = ALIGN_DOWN (phdr->p_offset, pagesz);
+	void *start = (void *) (vstart + map->l_addr);
+	size_t len = vend - vstart;
+
+	/* Add PROT_BTI.  */
+	unsigned prot = PROT_EXEC | PROT_BTI;
 	if (phdr->p_flags & PF_R)
 	  prot |= PROT_READ;
 	if (phdr->p_flags & PF_W)
 	  prot |= PROT_WRITE;
 
-	if (__mprotect (start, len, prot) < 0)
+	if (fd == -1)
+	  {
+	    /* Ignore failures: rely on the kernel adding PROT_BTI then.  */
+	    __mprotect (start, len, prot);
+	  }
+	else
 	  {
-	    if (program)
-	      _dl_fatal_printf ("%s: mprotect failed to turn on BTI\n",
-				map->l_name);
-	    else
+	    void *p = __mmap (start, len, prot, MAP_FIXED|MAP_COPY|MAP_FILE,
+			      fd, off);
+	    if (p == MAP_FAILED)
 	      _dl_signal_error (errno, map->l_name, "dlopen",
-				N_("mprotect failed to turn on BTI"));
+				N_("failed to turn on BTI protection"));
 	  }
       }
   return 0;
 }
-
-/* Enable BTI for L if required.  */
-
-void
-_dl_bti_check (struct link_map *l, const char *program)
-{
-  if (GLRO(dl_aarch64_cpu_features).bti && l->l_mach.bti)
-    enable_bti (l, program);
-}
diff --git a/sysdeps/aarch64/dl-prop.h b/sysdeps/aarch64/dl-prop.h
index 2016d1472e..762bc93733 100644
--- a/sysdeps/aarch64/dl-prop.h
+++ b/sysdeps/aarch64/dl-prop.h
@@ -19,19 +19,16 @@
 #ifndef _DL_PROP_H
 #define _DL_PROP_H
 
-extern void _dl_bti_check (struct link_map *, const char *)
-    attribute_hidden;
+extern void _dl_bti_protect (struct link_map *, int) attribute_hidden;
 
 static inline void __attribute__ ((always_inline))
 _rtld_main_check (struct link_map *m, const char *program)
 {
-  _dl_bti_check (m, program);
 }
 
 static inline void __attribute__ ((always_inline))
 _dl_open_check (struct link_map *m)
 {
-  _dl_bti_check (m, NULL);
 }
 
 static inline void __attribute__ ((always_inline))
@@ -43,6 +40,10 @@ static inline int
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
@@ -51,7 +52,10 @@ _dl_process_gnu_property (struct link_map *l, int fd, uint32_t type,
 
       unsigned int feature_1 = *(unsigned int *) data;
       if (feature_1 & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
-	l->l_mach.bti = true;
+	{
+	  l->l_mach.bti = true;  /* No longer needed.  */
+	  _dl_bti_protect (l, fd);
+	}
 
       /* Stop if we processed the property note.  */
       return 0;
-- 
2.17.1

