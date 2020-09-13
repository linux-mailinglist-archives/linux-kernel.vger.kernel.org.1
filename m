Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6D267E92
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMIWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgIMIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:22:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08D83Pah173464;
        Sun, 13 Sep 2020 04:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=e9y4cv6iBhHI2cqaW9HJH8rS0B7NE4/FGSiM9ERFfK0=;
 b=LqFFJRkLqx0OLVV8PoqqKlKK2+8fVPLyFl1FhAs6g8xQaMJW6dDXOnXNSJgXiin4fmuA
 y+fzwxj9zSOyFfHkHpzvt6pEt1mG1vMknlk+zX2VQr34KiSov5ysD5yAdYnjlPL0jrfT
 mjgOGbxzVbWRNT1Lr0P1XBvdpTA0e03Lu429uGptLTbfI2hyCZFHrF5EZRYFISYiLQPz
 vXOA2Ae/uxkUseNLQF8bxxn2tzvOQDISmo91YuSjZJSeCbwdZVJZt03Qs2bGXGXG1LOC
 JADfw3tyC3XYakXnHPV4OfhCpqiPgURIBLepPkcm0pP9HAqnyNmJzrt0S6jKWvwh+xx4 5w== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33hexj0vdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Sep 2020 04:22:11 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08D8GINr026365;
        Sun, 13 Sep 2020 08:22:10 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 33gny8huex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Sep 2020 08:22:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08D8M9HZ60817880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Sep 2020 08:22:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53E2F7805F;
        Sun, 13 Sep 2020 08:22:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A28978060;
        Sun, 13 Sep 2020 08:22:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.55.193])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 13 Sep 2020 08:22:05 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm/debug_vm_pgtable/locks] c50eb1ed65:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
In-Reply-To: <20200910075752.GC26874@shao2-debian>
References: <20200910075752.GC26874@shao2-debian>
Date:   Sun, 13 Sep 2020 13:52:03 +0530
Message-ID: <87wo0yw0gk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_11:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009130073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: c50eb1ed654b59efad96884cc26895a0acd7a15a ("mm/debug_vm_pgtable/locks: move non page table modifying test together")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
>
> in testcase: boot
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +----------------------------------------------------------------------+------------+------------+
> |                                                                      | 5c65ca35e5 | c50eb1ed65 |
> +----------------------------------------------------------------------+------------+------------+
> | boot_successes                                                       | 18         | 0          |
> | boot_failures                                                        | 0          | 10         |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c | 0          | 10         |
> +----------------------------------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>

How about this?

From a654324a2d09c61b9fb271b550f543ef7b09adc1 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Sun, 13 Sep 2020 13:34:26 +0530
Subject: [PATCH] mm/debug_vm_pgtable: Avoid doing memory allocation with
 pgtable_t mapped.

With highmem, pte_alloc_map() keep the level4 page table mapped using
kmap_atomic(). Avoid doing new memory allocation with page table
mapped like above.

[    9.409233] BUG: sleeping function called from invalid context at mm/page_alloc.c:4822
[    9.410557] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
[    9.411932] no locks held by swapper/1.
[    9.412595] CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc3-00323-gc50eb1ed654b5 #2
[    9.413824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    9.415207] Call Trace:
[    9.415651]  ? ___might_sleep.cold+0xa7/0xcc
[    9.416367]  ? __alloc_pages_nodemask+0x14c/0x5b0
[    9.417055]  ? swap_migration_tests+0x50/0x293
[    9.417704]  ? debug_vm_pgtable+0x4bc/0x708
[    9.418287]  ? swap_migration_tests+0x293/0x293
[    9.418911]  ? do_one_initcall+0x82/0x3cb
[    9.419465]  ? parse_args+0x1bd/0x280
[    9.419983]  ? rcu_read_lock_sched_held+0x36/0x60
[    9.420673]  ? trace_initcall_level+0x1f/0xf3
[    9.421279]  ? trace_initcall_level+0xbd/0xf3
[    9.421881]  ? do_basic_setup+0x9d/0xdd
[    9.422410]  ? do_basic_setup+0xc3/0xdd
[    9.422938]  ? kernel_init_freeable+0x72/0xa3
[    9.423539]  ? rest_init+0x134/0x134
[    9.424055]  ? kernel_init+0x5/0x12c
[    9.424574]  ? ret_from_fork+0x19/0x30

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/debug_vm_pgtable.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index d12bde82ae95..109fdf9953ad 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -994,7 +994,10 @@ static int __init debug_vm_pgtable(void)
 	p4dp = p4d_alloc(mm, pgdp, vaddr);
 	pudp = pud_alloc(mm, p4dp, vaddr);
 	pmdp = pmd_alloc(mm, pudp, vaddr);
-	ptep = pte_alloc_map(mm, pmdp, vaddr);
+	/*
+	 * Allocate pgtable_t
+	 */
+	pte_alloc(mm, pmdp);
 
 	/*
 	 * Save all the page table page addresses as the page table
@@ -1048,8 +1051,7 @@ static int __init debug_vm_pgtable(void)
 	 * proper page table lock.
 	 */
 
-	ptl = pte_lockptr(mm, pmdp);
-	spin_lock(ptl);
+	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
 	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
 	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
 	pte_unmap_unlock(ptep, ptl);
-- 
2.26.2

