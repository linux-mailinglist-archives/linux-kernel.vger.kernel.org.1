Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5C274F60
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 05:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgIWDFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 23:05:47 -0400
Received: from foss.arm.com ([217.140.110.172]:58612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgIWDFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 23:05:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0921ED6E;
        Tue, 22 Sep 2020 20:05:46 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8003F718;
        Tue, 22 Sep 2020 20:05:42 -0700 (PDT)
Subject: Re: [mm/debug_vm_pgtable/locks] e2aad6f1d2:
 BUG:unable_to_handle_page_fault_for_address
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20200921092114.GG13157@shao2-debian>
 <289c3fdb-1394-c1af-bdc4-5542907089dc@linux.ibm.com>
 <84ce4dc1-9763-c7df-b7b2-55000e53b502@arm.com>
 <07bd693d-86e7-c82a-8b52-644e6c08f8b2@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5112f721-2d36-6162-f15a-b32ca38db4fc@arm.com>
Date:   Wed, 23 Sep 2020 08:34:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <07bd693d-86e7-c82a-8b52-644e6c08f8b2@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/22/2020 02:50 PM, Aneesh Kumar K.V wrote:
> On 9/22/20 2:22 PM, Anshuman Khandual wrote:
>>
>>
>> On 09/22/2020 09:33 AM, Aneesh Kumar K.V wrote:
>>> On 9/21/20 2:51 PM, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>
>>>> commit: e2aad6f1d232b457ea6a3194992dd4c0a83534a5 ("mm/debug_vm_pgtable/locks: take correct page table lock")
>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>
>>>>
>>>> in testcase: trinity
>>>> version: trinity-i386
>>>> with following parameters:
>>>>
>>>>  ï¿½ï¿½ï¿½ï¿½runtime: 300s
>>>>
>>>> test-description: Trinity is a linux system call fuzz tester.
>>>> test-url: http://codemonkey.org.uk/projects/trinity/
>>>>
>>>>
>>>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>>
>>>>
>>>> +----------------------------------------------------------------------+------------+------------+
>>>> |ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | c50eb1ed65 | e2aad6f1d2 |
>>>> +----------------------------------------------------------------------+------------+------------+
>>>> | boot_successesï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | boot_failuresï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 61ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | BUG:workqueue_lockup-poolï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 1ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c | 60ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | BUG:unable_to_handle_page_fault_for_addressï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | Oops:#[##]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | EIP:ptep_getï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> | Kernel_panic-not_syncing:Fatal_exceptionï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 0ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 17ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |
>>>> +----------------------------------------------------------------------+------------+------------+
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>>
>>>>
>>>> [ï¿½ï¿½ 28.726464] BUG: sleeping function called from invalid context at mm/page_alloc.c:4822
>>>> [ï¿½ï¿½ 28.727835] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper
>>>> [ï¿½ï¿½ 28.729221] no locks held by swapper/1.
>>>> [ï¿½ï¿½ 28.729954] CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc3-00324-ge2aad6f1d232b4 #1
>>>> [ï¿½ï¿½ 28.731484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>> [ï¿½ï¿½ 28.732891] Call Trace:
>>>> [ï¿½ï¿½ 28.733295]ï¿½ ? show_stack+0x48/0x50
>>>> [ï¿½ï¿½ 28.733943]ï¿½ dump_stack+0x1b/0x1d
>>>> [ï¿½ï¿½ 28.734569]ï¿½ ___might_sleep+0x205/0x219
>>>> [ï¿½ï¿½ 28.735292]ï¿½ __might_sleep+0x106/0x10f
>>>> [ï¿½ï¿½ 28.736022]ï¿½ __alloc_pages_nodemask+0xe0/0x2c8
>>>> [ï¿½ï¿½ 28.736845]ï¿½ swap_migration_tests+0x62/0x295
>>>> [ï¿½ï¿½ 28.737639]ï¿½ debug_vm_pgtable+0x587/0x9b5
>>>> [ï¿½ï¿½ 28.738374]ï¿½ ? pte_advanced_tests+0x267/0x267
>>>> [ï¿½ï¿½ 28.739318]ï¿½ do_one_initcall+0x129/0x31c
>>>> [ï¿½ï¿½ 28.740023]ï¿½ ? rcu_read_lock_sched_held+0x46/0x74
>>>> [ï¿½ï¿½ 28.740944]ï¿½ kernel_init_freeable+0x201/0x250
>>>> [ï¿½ï¿½ 28.741763]ï¿½ ? rest_init+0xf8/0xf8
>>>> [ï¿½ï¿½ 28.742401]ï¿½ kernel_init+0xe/0x15d
>>>> [ï¿½ï¿½ 28.743040]ï¿½ ? rest_init+0xf8/0xf8
>>>> [ï¿½ï¿½ 28.743694]ï¿½ ret_from_fork+0x1c/0x30
>>>
>>>
>>> This should be fixed by
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/mm/debug_vm_pgtable.c?id=3a4f9a45eadb6ed5fc04686e8db4dc7bb1caec44
>>>
>>>> [ï¿½ï¿½ 28.744364] BUG: unable to handle page fault for address: fffbbea4
>>>> [ï¿½ï¿½ 28.745465] #PF: supervisor read access in kernel mode
>>>> [ï¿½ï¿½ 28.746373] #PF: error_code(0x0000) - not-present page
>>>> [ï¿½ï¿½ 28.747275] *pde = 0492b067 *pte = 00000000
>>>> [ï¿½ï¿½ 28.748054] Oops: 0000 [#1]
>>>> [ï¿½ï¿½ 28.748548] CPU: 0 PID: 1 Comm: swapper Tainted: Gï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Wï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 5.9.0-rc3-00324-ge2aad6f1d232b4 #1
>>>> [ï¿½ï¿½ 28.750188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>> [ï¿½ï¿½ 28.751641] EIP: ptep_get+0x0/0x3
>>>> [ï¿½ï¿½ 28.752226] Code: 5d fc c9 c3 55 c1 e8 1a 89 e5 53 31 db 83 f8 1f 6a 00 0f 94 c3 b8 80 67 02 c4 31 c9 89 da e8 16 5c f1 ff 89 d8 8b 5d fc c9 c3 <8b> 00 c3 55 31 c9 89 e5 57 56 53 8b 70 04 89 c3 b8 10 68 02 c4 6a
>>>> [ï¿½ï¿½ 28.755465] EAX: fffbbea4 EBX: fffbbea4 ECX: 000047bd EDX: fffbbea4
>>>> [ï¿½ï¿½ 28.756418] ESI: 000047bd EDI: 00000025 EBP: f406bed8 ESP: f406bebc
>>>> [ï¿½ï¿½ 28.757522] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
>>>> [ï¿½ï¿½ 28.758739] CR0: 80050033 CR2: fffbbea4 CR3: 04928000 CR4: 000406d0
>>>> [ï¿½ï¿½ 28.759828] Call Trace:
>>>> [ï¿½ï¿½ 28.760235]ï¿½ ? hugetlb_advanced_tests+0x2a/0x27f
>>>> [ï¿½ï¿½ 28.761099]ï¿½ ? do_raw_spin_unlock+0xd7/0x112
>>>> [ï¿½ï¿½ 28.761872]ï¿½ debug_vm_pgtable+0x927/0x9b5
>>>> [ï¿½ï¿½ 28.762578]ï¿½ ? pte_advanced_tests+0x267/0x267
>>>> [ï¿½ï¿½ 28.763462]ï¿½ do_one_initcall+0x129/0x31c
>>>> [ï¿½ï¿½ 28.764134]ï¿½ ? rcu_read_lock_sched_held+0x46/0x74
>>>> [ï¿½ï¿½ 28.764948]ï¿½ kernel_init_freeable+0x201/0x250
>>>> [ï¿½ï¿½ 28.765654]ï¿½ ? rest_init+0xf8/0xf8
>>>> [ï¿½ï¿½ 28.766277]ï¿½ kernel_init+0xe/0x15d
>>>> [ï¿½ï¿½ 28.766878]ï¿½ ? rest_init+0xf8/0xf8
>>>> [ï¿½ï¿½ 28.767488]ï¿½ ret_from_fork+0x1c/0x30
>>>> [ï¿½ï¿½ 28.768052] Modules linked in:
>>>> [ï¿½ï¿½ 28.768532] CR2: 00000000fffbbea4
>>>> [ï¿½ï¿½ 28.769065] ---[ end trace 9c4395cf49c7b3e7 ]---
>>>>
>>>
>>> IIUC, Anshuman is reworking the test to follow the page table update rules.
>>
>> The failure here has been attributed to this particular patch, and
>> IIRC we did not see this particular failure before this series.
>>
> 
> IIUC that crash is because the usage of pte_t pointer. With  highmem that address is unmapped earlier with the series as expected. But hugetlb_advanced_test is wrongly using that pointer instead of using a pte_t * that should be allocated by huge_pte_alloc().

Hence, now it does not really make sense to keep hugetlb_advanced_test()
test and create this regression on i386. Will probably send a patch to
drop this test altogether for now.
