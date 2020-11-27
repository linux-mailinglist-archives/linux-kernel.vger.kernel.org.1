Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261562C66B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgK0NWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:22:08 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:11748
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730017AbgK0NWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNhDXoIacsU34w/3BvmYpkHf4Z/z/9IrNSX8sg3eJMw=;
 b=Ai4rrVEbR5P0boFd6cuSuVZHXHC7jIWIr6j0VrY4gsiI97au396Biv7U6so79xRLz4cui4tD7kDBwPo8v0suW6XFUMY80pTE9N0n/XpZjCHp5H4LtTrNXp2iXcdsz99xKT/pnwunMuSVo6nQVnFUSlDvoECLSO6zZ5NW8d35igg=
Received: from DB6P192CA0010.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::20) by
 AS8PR08MB6183.eurprd08.prod.outlook.com (2603:10a6:20b:29e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Fri, 27 Nov 2020 13:22:01 +0000
Received: from DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::f3) by DB6P192CA0010.outlook.office365.com
 (2603:10a6:4:b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Fri, 27 Nov 2020 13:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT004.mail.protection.outlook.com (10.152.20.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:22:01 +0000
Received: ("Tessian outbound d6c201accd3c:v71"); Fri, 27 Nov 2020 13:22:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 40dd52e927242136
X-CR-MTA-TID: 64aa7808
Received: from 7260ca125c44.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 34BDB80F-9248-4D34-B61D-26C210692084.1;
        Fri, 27 Nov 2020 13:21:56 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7260ca125c44.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKJ1A4jFkTZwRzjEfloDbnaFiZR1YOxRrPK4rz8Aoh9K2AtBdUvPmhQ6HFSv7y44ddmfXki1tIuIY7I48zuzC90xP/8nKtHqaCCyYpyIJydhf0CilyxPzd+JY0dRCF1LR/nfqN/OWEHuU+31t+ffFv7Zgl+V2RM5WIL+6ms4I79bISfi11TRw1TBj1LaquLlTEgOZzc6LCaDCkAPbdjjn121Wb4ZZGpMcbQvYtmSBwgiF12u/Jyd4mmKWqrHpihGJ6/WRA9DQDEGW0PASYKqPy6YW+RACJRjmH+GePZZQyGjtgg6Rhi0lU0iTvlLH1fKQOjsWMUpuQGTeFUmWqVPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNhDXoIacsU34w/3BvmYpkHf4Z/z/9IrNSX8sg3eJMw=;
 b=BvWP7tGZSOZNttkIXg6IQYanOXe+Hk0NPXmuBKvXUIg47mXMosfqFD6d5CfJQztYf0ghJizBH0fxXiW12fEAUB9KKHVfZ0ZddeRg8EyBm6S+koZZuidvdyLzh/0E0l3FLxPhT9ITEXp7k0cMWZbG/ppUnNw0tsJZ5Ba75CkBMZFukHoWaVOvAK48Gk6053q9MReSfA7pH55GnW9wuT1PljO50WnURnWNtygEGFDZGZSIrxDiJx51utLyjiZ6iOgq7UeQolj5tS2n+ubtJsOYjhNXQlLuhkSC5JVSWafrkw/U7NtXNIC7RiOHfqH8lhQPbRDL3pwmbcqVWP34quyJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNhDXoIacsU34w/3BvmYpkHf4Z/z/9IrNSX8sg3eJMw=;
 b=Ai4rrVEbR5P0boFd6cuSuVZHXHC7jIWIr6j0VrY4gsiI97au396Biv7U6so79xRLz4cui4tD7kDBwPo8v0suW6XFUMY80pTE9N0n/XpZjCHp5H4LtTrNXp2iXcdsz99xKT/pnwunMuSVo6nQVnFUSlDvoECLSO6zZ5NW8d35igg=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:21:55 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:21:55 +0000
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
Subject: [PATCH v2 6/6] aarch64: Use mmap to add PROT_BTI instead of mprotect [BZ #26831]
Date:   Fri, 27 Nov 2020 13:21:41 +0000
Message-Id: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606319495.git.szabolcs.nagy@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by SN6PR04CA0108.namprd04.prod.outlook.com (2603:10b6:805:f2::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:21:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a2e21be-08e2-499c-cc82-08d892d76cfe
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|AS8PR08MB6183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61838A7666786C20432572BFEDF80@AS8PR08MB6183.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:497;OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BaBuPb9/YuYaqm6UJpQ+WP7akESjJp71I8Ow31uIMF1TpHrI2zvDRmlKv0AP4BLZGzpv+LS1h3GAR2sbXBMfIkim12QEmMtK4mZQV4jomdjZMkCiDKpKn3enGdI/Jzq+eYMaFWvGpPwyVrIi6NqCso8nydIiw0a/3ZWuVc4U0G6jYxKDCOdp5oo5yHHHRHZgr88CDSNxvzyny3xnZ6iYwqCSCHDQua0+t5hRuM+t5qFCJyEmrdaG5cYPNpuJSL+Qv255ei6omgWn9uUWeuPi6pj07Ezd2JhTmCIvIw+bKkNV9t3H1fIGm7F3BIrvKtYEwh3IFdSvsQ2O7mTHkKq5OzYhtR5VbhVMgwuanoWxUKm0dgZrL2ZBoO66TlGBAGmn
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(54906003)(69590400008)(6916009)(6512007)(36756003)(6486002)(6666004)(316002)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(26005)(8676002)(66476007)(66946007)(6506007)(66556008)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aBkv4e8QhDD/Lzlh8V/SyjUP8T5/lAC12SFWNYWmYVo5bKLLwRESK3gDvWTs?=
 =?us-ascii?Q?Y59yzqsNcMchEywEBLfj8NLUbKcNAcCPOvf4AyabEpV7XFjfGshbcuH8XxgX?=
 =?us-ascii?Q?GN6xGcwwFF78GFLxn9Ico3Ngh0hVDNEeaB2i8fusthlwqnIw4uYReM9+mCxs?=
 =?us-ascii?Q?Ke3qTHNIpalCN683Nhx6tAN40Ik5cFzBMgVdRp1lQOzFhteTnJ8okdrlfgJ5?=
 =?us-ascii?Q?TCSDD0V+oedtUKfDXDYgxk766oAJo8/XTxPLV49GKQT3S6Je2EStM+uG8w0O?=
 =?us-ascii?Q?SUpZ0lB52M1qb6Pc4EmOutbD93ipjgB2JOFpMFnWwo1W90xCv8Ge8tBfxEMb?=
 =?us-ascii?Q?q6Om/oXyYhli8u7bbX2FXJPlpFMFE1wH0zgG9UATUGqJuNEPu1nf1Rqj7Vh3?=
 =?us-ascii?Q?8X4UdrmlRFk7ExWSn6v/qijBNHhhRboPyJbqMW2hVF7slSbaWRIlDiW+umAv?=
 =?us-ascii?Q?90+9Z/5FWraNObzrhv3WYQwE/x7IkcflGLye/b1J63wePBufw8OqbxdZly9c?=
 =?us-ascii?Q?0Y2xNzJC70bsGUvstrpJY6xa7E0gsEJKkg0915tbbFTXhLKVMrIsEhfv+e8V?=
 =?us-ascii?Q?94woZjoKeZ2tsHoGOghExm+tmKvCpES9Bdyi7vJdxfYNj554Eh5k7gifKlEg?=
 =?us-ascii?Q?pNSSjLWk+8tELIAD6dYKYLXrvzxUd13waXvYu9nkjxWJe5b9VYoCkmEDL/tH?=
 =?us-ascii?Q?/Qd+srAmfIn+4/Had0HRKagUxL2KSk6tPwiKHU0inEjtJ8l8iUMb2ZdEFsg2?=
 =?us-ascii?Q?IeuHdYiUXoUhkUmEoe4w/xM5j93qwXkh6u0cz7Cyuo8fhfTGApNpRmQeheur?=
 =?us-ascii?Q?kndBTlJtl6X1Rd9fTfEunWkkWDzBoU+pNQHqLHf1MOoh8K3B7OPRxmA206TC?=
 =?us-ascii?Q?Wuhu+0arIQOH6MdPs/3ta0JtrDNEMOMkRnnWYZ2EspXNNUnKspZ5OkMalj7s?=
 =?us-ascii?Q?YuYn9452aHr+y3+UdHMisLslGgfUNoJN4dWS+xwpLiZzvJV6ZtlwQa4428w+?=
 =?us-ascii?Q?hWuZ?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f345003f-ce57-4f90-ab51-08d892d768ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwm+/GZuAcnoioBNYOf41xI13OuiRdCRDt5TZSGVYbxonOXbKnwN2hlQWZ4xhWPL5EAZyMr72ZtxrU3pvcoz8Ill3sPeFeeecQwDco5v5/tOXzhGEA6iLshIEwzsIiOLOywMsfe8q+lctqch7yHjyidSOd+UQJ70delWcHUahNcVE0QkhsU2W0sb9P6nkeH/w4Mvken8qNhAFqq9Q1JHdh3YN8U7IFwPQgjG/e6d6syIHuLCx15RbRXTo12zRKl2LlZeG1z8E8DAo9YxAkeJ9z4rzTnwdm1ZCc9RVodcJlsOaklO2FPrKh6LvsY70fsnnmVukrwjEvaXyOc2ownqePIazYslbKhio7JKOMOlGoD7kfY0cSaaq/ECgd0aY/TMH+ExtmQjk2Uf6K+Y2+PKzykW/ui/QGPPvWpdCpRbUpPpzooid8BDFzbfS4zCz2h1
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(107886003)(4326008)(34206002)(54906003)(69590400008)(6666004)(6512007)(36756003)(6486002)(316002)(356005)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(336012)(26005)(8676002)(70586007)(70206006)(81166007)(6506007)(82310400003)(47076004)(83380400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:22:01.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2e21be-08e2-499c-cc82-08d892d76cfe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6183
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

Computing the mapping bounds follows _dl_map_object_from_fd more
closely now.

The delayed failure reporting is mainly needed because currently
_dl_process_gnu_properties does not propagate failures such that
the required cleanups happen. Using the link_map_machine struct for
error propagation is not ideal, but this seemed to be the least
intrusive solution.

Fixes bug 26831.
---
 sysdeps/aarch64/dl-bti.c  | 67 +++++++++++++++++++++++++--------------
 sysdeps/aarch64/dl-prop.h |  8 ++++-
 sysdeps/aarch64/linkmap.h |  2 +-
 3 files changed, 52 insertions(+), 25 deletions(-)

diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
index 8f4728adce..34b5294f92 100644
--- a/sysdeps/aarch64/dl-bti.c
+++ b/sysdeps/aarch64/dl-bti.c
@@ -19,39 +19,62 @@
 #include <errno.h>
 #include <libintl.h>
 #include <ldsodefs.h>
+#include <sys/mman.h>
 
-static int
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
+  const size_t pagesz = GLRO(dl_pagesize);
   const ElfW(Phdr) *phdr;
-  unsigned prot;
 
   for (phdr = map->l_phdr; phdr < &map->l_phdr[map->l_phnum]; ++phdr)
     if (phdr->p_type == PT_LOAD && (phdr->p_flags & PF_X))
       {
-	void *start = (void *) (phdr->p_vaddr + map->l_addr);
-	size_t len = phdr->p_memsz;
+	size_t vstart = ALIGN_DOWN (phdr->p_vaddr, pagesz);
+	size_t vend = ALIGN_UP (phdr->p_vaddr + phdr->p_filesz, pagesz);
+	off_t off = ALIGN_DOWN (phdr->p_offset, pagesz);
+	void *start = (void *) (vstart + map->l_addr);
+	size_t len = vend - vstart;
 
-	prot = PROT_EXEC | PROT_BTI;
+	/* Add PROT_BTI.  */
+	unsigned prot = PROT_EXEC | PROT_BTI;
 	if (phdr->p_flags & PF_R)
 	  prot |= PROT_READ;
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
-  return 0;
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
@@ -59,16 +82,14 @@ _dl_bti_check (struct link_map *map, const char *program)
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

