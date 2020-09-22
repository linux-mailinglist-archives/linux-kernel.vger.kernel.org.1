Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7861C273995
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 06:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgIVEDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 00:03:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgIVEDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 00:03:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08M43Iut104004;
        Tue, 22 Sep 2020 00:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jJqNcxhxXULE8MgDHED8ti2HjArs/fPuzzLSKv1uFEQ=;
 b=YC1d0b0d/hXhyIEZmu/A8Pll1isUbSLThLlu9J5bvwZ3wusqcX9SMeZ+rcHj5mFaUi1M
 yVboL92laCT4ITHeeI3WzKeVgWODkKbUykX6mbQURBPYhajpNuB/u9pRXb8xk+aMEOb2
 u+1AV4cI/bVWtPQZLzLCfzaUIQygkykipu3drXJbcvyt/NC+myEDitEvcIpag+jQT6uq
 SH5b11+rbaMGBbaewUgBgzdMnl72spo8wh3qjZw0iKhwhOgQZo2eMI/BwnvRC+RGS/zh
 zZToTqYDZ013gl+JonpzaiUUGy47wtGPC0wt+0Bnx06cTTvnycJCWjoFrgtikk6nJXBr Cw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33q8r4sgpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 00:03:18 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08M3vrdF030259;
        Tue, 22 Sep 2020 04:03:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 33n9m7sccj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 04:03:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08M41SLw35455244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 04:01:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D2842045;
        Tue, 22 Sep 2020 04:03:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A62F42049;
        Tue, 22 Sep 2020 04:03:01 +0000 (GMT)
Received: from [9.85.69.87] (unknown [9.85.69.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Sep 2020 04:03:01 +0000 (GMT)
Subject: Re: [mm/debug_vm_pgtable/locks] e2aad6f1d2:
 BUG:unable_to_handle_page_fault_for_address
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20200921092114.GG13157@shao2-debian>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <289c3fdb-1394-c1af-bdc4-5542907089dc@linux.ibm.com>
Date:   Tue, 22 Sep 2020 09:33:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921092114.GG13157@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_03:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/20 2:51 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: e2aad6f1d232b457ea6a3194992dd4c0a83534a5 ("mm/debug_vm_pgtable/locks: take correct page table lock")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: trinity
> version: trinity-i386
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------------------------------+------------+------------+
> |                                                                      | c50eb1ed65 | e2aad6f1d2 |
> +----------------------------------------------------------------------+------------+------------+
> | boot_successes                                                       | 0          | 0          |
> | boot_failures                                                        | 61         | 17         |
> | BUG:workqueue_lockup-pool                                            | 1          |            |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c | 60         | 17         |
> | BUG:unable_to_handle_page_fault_for_address                          | 0          | 17         |
> | Oops:#[##]                                                           | 0          | 17         |
> | EIP:ptep_get                                                         | 0          | 17         |
> | Kernel_panic-not_syncing:Fatal_exception                             | 0          | 17         |
> +----------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   28.726464] BUG: sleeping function called from invalid context at mm/page_alloc.c:4822
> [   28.727835] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
> [   28.729221] no locks held by swapper/1.
> [   28.729954] CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc3-00324-ge2aad6f1d232b4 #1
> [   28.731484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   28.732891] Call Trace:
> [   28.733295]  ? show_stack+0x48/0x50
> [   28.733943]  dump_stack+0x1b/0x1d
> [   28.734569]  ___might_sleep+0x205/0x219
> [   28.735292]  __might_sleep+0x106/0x10f
> [   28.736022]  __alloc_pages_nodemask+0xe0/0x2c8
> [   28.736845]  swap_migration_tests+0x62/0x295
> [   28.737639]  debug_vm_pgtable+0x587/0x9b5
> [   28.738374]  ? pte_advanced_tests+0x267/0x267
> [   28.739318]  do_one_initcall+0x129/0x31c
> [   28.740023]  ? rcu_read_lock_sched_held+0x46/0x74
> [   28.740944]  kernel_init_freeable+0x201/0x250
> [   28.741763]  ? rest_init+0xf8/0xf8
> [   28.742401]  kernel_init+0xe/0x15d
> [   28.743040]  ? rest_init+0xf8/0xf8
> [   28.743694]  ret_from_fork+0x1c/0x30


This should be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/mm/debug_vm_pgtable.c?id=3a4f9a45eadb6ed5fc04686e8db4dc7bb1caec44

> [   28.744364] BUG: unable to handle page fault for address: fffbbea4
> [   28.745465] #PF: supervisor read access in kernel mode
> [   28.746373] #PF: error_code(0x0000) - not-present page
> [   28.747275] *pde = 0492b067 *pte = 00000000
> [   28.748054] Oops: 0000 [#1]
> [   28.748548] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.9.0-rc3-00324-ge2aad6f1d232b4 #1
> [   28.750188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   28.751641] EIP: ptep_get+0x0/0x3
> [   28.752226] Code: 5d fc c9 c3 55 c1 e8 1a 89 e5 53 31 db 83 f8 1f 6a 00 0f 94 c3 b8 80 67 02 c4 31 c9 89 da e8 16 5c f1 ff 89 d8 8b 5d fc c9 c3 <8b> 00 c3 55 31 c9 89 e5 57 56 53 8b 70 04 89 c3 b8 10 68 02 c4 6a
> [   28.755465] EAX: fffbbea4 EBX: fffbbea4 ECX: 000047bd EDX: fffbbea4
> [   28.756418] ESI: 000047bd EDI: 00000025 EBP: f406bed8 ESP: f406bebc
> [   28.757522] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> [   28.758739] CR0: 80050033 CR2: fffbbea4 CR3: 04928000 CR4: 000406d0
> [   28.759828] Call Trace:
> [   28.760235]  ? hugetlb_advanced_tests+0x2a/0x27f
> [   28.761099]  ? do_raw_spin_unlock+0xd7/0x112
> [   28.761872]  debug_vm_pgtable+0x927/0x9b5
> [   28.762578]  ? pte_advanced_tests+0x267/0x267
> [   28.763462]  do_one_initcall+0x129/0x31c
> [   28.764134]  ? rcu_read_lock_sched_held+0x46/0x74
> [   28.764948]  kernel_init_freeable+0x201/0x250
> [   28.765654]  ? rest_init+0xf8/0xf8
> [   28.766277]  kernel_init+0xe/0x15d
> [   28.766878]  ? rest_init+0xf8/0xf8
> [   28.767488]  ret_from_fork+0x1c/0x30
> [   28.768052] Modules linked in:
> [   28.768532] CR2: 00000000fffbbea4
> [   28.769065] ---[ end trace 9c4395cf49c7b3e7 ]---
> 

IIUC, Anshuman is reworking the test to follow the page table update rules.

> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-5.9.0-rc3-00324-ge2aad6f1d232b4 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 


-aneesh
