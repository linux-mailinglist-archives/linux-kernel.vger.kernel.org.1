Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6422A5E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKDGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:37:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58834 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgKDGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604471859; x=1636007859;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GuDHmTD4cCIJxFo1mNDrflivXzwsvLBT9XxnSTRGZ18=;
  b=BeL5XF8Jms7pnavo5BBmmHbXuJRCnuR0WL8f6p9uTjrAEDM0h7e3ZOZw
   XSH0Z3Zb4+vlutsOd+fT6j4OBeiLGt0xb7SIixWkhUU2oRqgArp32j4pX
   OQz67y+UKO5YpIoHFRW3B1Unnaqe/4cHVdJb9EhH6ig/Z+S8AGl8FtSfy
   atse4UNTrSp/dbGTFB29BmZTj0pPA1NBf6Tp0FSVvQO0l7huCxzg+TOpl
   te5orUgYeoLjZRjYUglA0XUJ4+q1vRZqP6Cu/ojb4Wn9YKGeCO7CCwimu
   6kyA8xzGXDEmQA43c9toEHdYXNOfd1u8jFJ9+7UvXqr6XxNQEeHnwQC5L
   g==;
IronPort-SDR: 9WYyv5mmoBPB8PiA0pCUB0JmhI6ETvK6pzZFmC0CJ5vEfPuo82TDr/Cbi5DL8zkyWreGJ/TBmu
 FYCNf8EJZbd1yOWH8pw2oJiu+cv82v+Xu0KSbY1Kc/xw5xDyK1EXFfuZtO3kxmtGg9chf/U+m0
 rIY5jVg6R492Fi2qeh4oyHjGqhz3035xZcRrsMEAwgrlzTJb/r3XQ4U4phlGO/wcQ+FBZZ3lrm
 XX2hczeAV9NTluBMGXsryont4AM7cejWN/ZL4owzyGOJj0LHeqXOW58s7t4nPcCv/agv8zTSU5
 nUg=
X-IronPort-AV: E=Sophos;i="5.77,450,1596470400"; 
   d="scan'208";a="156230017"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 14:37:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPWFS8LwrCtgWBxCPWYvqysgW4a/jh+KUkoahkZNfXz3hYwG5jFZTtBrRoDy0dpn094tv+Nk+W8jxYXnmnYROHSHRHhmk/8ltTSu9cxckfOM95sZ/jQdB44yr/RPjWu+nIgiYfdLDbTPNmL48D3GSAWaNv39ZoPLkvibJ11/2pH9HaGQpDO0kXgFBdrxFICI9+bTvMDDM/0LFpZF4FdARJn+h3Uyo7dvhb3+zPGO522qO2zp7n9vltR0ib8Lgnz80Md7ciYgDIaPPFFaAtbkGMBVCIISd9oOtyJdeXpBFJBrrc9AcJqkOvVoYaAjmLXVscGtx966PgCKiBXx2MEgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra1C5QrW1w5ihkOvdm2rhwlsrZPsaA7Ge+uE8jp9bBI=;
 b=Zd/g3Dt3Cgh+Cve0OyqdWnKgB3mVXFjDJ0b0nVDP5/AsxXJ0rAZy8Q3L1XXsfAzt16O/Dfm1P3DyJFr2e5wSYQHomRltMoaDJmAINxwOlJq18tzF3IjxyhDP8XZKADbxc17qLml+Ni0fOtJz0Cxhd+h8R4QjhlEQUwVmu1XHWWKhRfl1qANjj7V2NF0xn/18YeV3Tu/jOleugCkorwFT3bgOvRjGHzY7pTGTTMRaeVzWKsDU6SyD4pm9WjcTH2G2/F3cTjTp5zyV/T7O0kzUxycsQLeHL9mhphtX4hC6+UrQjI6l1dNNh7yYdytd2jAw7GzC/hxI4T1xhBuISCbBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra1C5QrW1w5ihkOvdm2rhwlsrZPsaA7Ge+uE8jp9bBI=;
 b=VmmDe4Ub6mRLWA+6DNbxfID5Buq44HrAdUjGgDN9xVXEupojoPfCv5UqnEu4d2mPlC2htr294bxQohVc0DH8HrXeBBxFQy2eDlG8uUAp0EknIwl2I2LkuDpwJ3G4lw9FzDVJgtNOtSriKO77Vz1ArHLqyb4hj0ehO6oK5AlUq1c=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0685.namprd04.prod.outlook.com (2603:10b6:3:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 06:37:37 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 06:37:37 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] RISC-V: Use non-PGD mappings for early DTB access
Date:   Wed,  4 Nov 2020 12:07:13 +0530
Message-Id: <20201104063713.3039035-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.38.184]
X-ClientProxiedBy: MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.38.184) by MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 06:37:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c02ac2d9-df2e-4f05-69d7-08d8808c1e77
X-MS-TrafficTypeDiagnostic: DM5PR04MB0685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0685A8345E43E217195C385C8DEF0@DM5PR04MB0685.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLjTNZ8ZbbNXR5/uLckDxwcYXfGC2sr6WLWhFJHODcBtm4mPAAG3QJ6XYb9Yu2e+gHFEK6debbpWpwTFsPuA1BgrKbh7aiqAPWO4uaSLLSwukDgGzc8DDuxkT6lv4BHoEsln2aPFb+Rr5VsSmH3q5eGRwV626s5bzgzdjKVkeR29A8H9uvbCjCdqbVTeBeX3SibrgKNmYKn9JBq2GvLTQ0YC+dPHP8eqqRognAhj1Lx6Uhjp5KFGF+NuZbAXOaU2BarvVp9f+VCuHMt/+nG0wGOyMlyMy9mw28X0NB9neZ1v0sZeD/LwYiuNnHNOeJjKaXEVhLSzy7rpKuCnkyf3SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(16526019)(110136005)(86362001)(66476007)(66556008)(6666004)(186003)(52116002)(36756003)(55016002)(8676002)(54906003)(7696005)(1076003)(4326008)(2906002)(8886007)(66946007)(478600001)(44832011)(83380400001)(5660300002)(2616005)(26005)(8936002)(316002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: t6WO7SkhUbe1b/CQ2f9r7i2BJ/Jbx866WzKK9oqI1gb4tcL+BrGLlCrhjb37Fd9kjLxcKrBx+WqO19EeWtvgmy1wrPL4Wq6gxMDLT40YrNOc8qHcO+aj6EFNDwkRdzDKQn8LuyB7doYQC9Mc/x2vzPofotqozm06sSbFuojJIkYd8soXD5WQXe750EBAgfd9TEE80vf9dWkuk1Dqi50opSa+5FYEpVwHRu2xUi1n+uLFFj6u3UmwaLIPFkSnWJOJLmt7+zRsZPnSrAJMyvI7pFxWNUn1xXgtBaF/I1HO7XPrF/MF6Wv4zmM4JAT5ZaO4rkoHiy8Vy4imBt2HiqbQKUUxaJwnviLhAJZN7lNg1iGJtlyCGm4ptYDjIMqbnmMyCa4RT97eMIRnYOFR0jF6fQ7vLNIvgXtSi0AbxgVzt6CAKGAfc31H37/3qX2c0vN9U/AXsq4IrrR0QGFlp75h8ewiasb8QS55u0PF97BKjeX0xbzpYZkb8FlYKi9otthdBGOwSRH7wwFsz+HhILHPMfvheoe3Cn77b3fZHkUSqxyHO1Sn4mK1IWJD6Tt6FV6x//lp9UAQiOsmlAhOZXc6eK+GbGN4xoKve5thjj8T1mSo0ehR/ICVETUZ11j37aGm+NgzFYbHePepMuaY0iyF5w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02ac2d9-df2e-4f05-69d7-08d8808c1e77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 06:37:36.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wBgFaw4nKSq7fVTCrdZK5dJkIn87nitPyZyLMAllyb90B1zAgkjQdyUz6eR6g2eC9RRQjafsIwTXwOGfGcY0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we use PGD mappings for early DTB mapping in early_pgd
but this breaks Linux kernel on SiFive Unleashed because on SiFive
Unleashed PMP checks don't work correctly for PGD mappings.

To fix early DTB mappings on SiFive Unleashed, we use non-PGD
mappings (i.e. PMD) for early DTB access.

Fixes: 8f3a2b4a96dc ("RISC-V: Move DT mapping outof fixmap")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ea933b789a88..0d13d0c36a7d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -297,6 +297,7 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
 #endif
 pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
+pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
 {
@@ -494,6 +495,18 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 				   load_pa + (va - PAGE_OFFSET),
 				   map_size, PAGE_KERNEL_EXEC);
 
+#ifndef __PAGETABLE_PMD_FOLDED
+	/* Setup early PMD for DTB */
+	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
+			   (uintptr_t)early_dtb_pmd, PGDIR_SIZE, PAGE_TABLE);
+	/* Create two consecutive PMD mappings for FDT early scan */
+	pa = dtb_pa & ~(PMD_SIZE - 1);
+	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
+			   pa, PMD_SIZE, PAGE_KERNEL);
+	create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
+			   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
+	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
+#else
 	/* Create two consecutive PGD mappings for FDT early scan */
 	pa = dtb_pa & ~(PGDIR_SIZE - 1);
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
@@ -501,6 +514,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA + PGDIR_SIZE,
 			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
+#endif
 	dtb_early_pa = dtb_pa;
 
 	/*
-- 
2.25.1

