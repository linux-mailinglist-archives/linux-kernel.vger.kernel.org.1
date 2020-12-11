Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDBF2D712C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405457AbgLKICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:02:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9158 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389056AbgLKICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:02:11 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csjrz21rFz15bZl;
        Fri, 11 Dec 2020 16:00:51 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:01:18 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>
CC:     <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH 0/1] Add prejudgement for relaxing permissions only case
Date:   Fri, 11 Dec 2020 16:01:14 +0800
Message-ID: <20201211080115.21460-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Found that in dirty-logging, or dirty-logging-stopped time, even normal running
time of a guest configed with huge mappings and numbers of vCPUs, translation
faults by different vCPUs on the same GPA could occur successively almost at the
same time. See below for the trace log, and there are two reasons to explain.
     
(1) If there are some vCPUs accessing the same GPA at the same time and the leaf
PTE is not set yet, then they will all cause translation faults and the first
vCPU holding mmu_lock will set valid leaf PTE, and the others will later choose
to update the leaf PTE or not.                                                   
                                                                                  
(2) When changing a leaf entry or a table entry with break-before-make, if there
are some vCPUs accessing the same GPA just catch the moment when the target PTE
is set invalid in a BBM procedure coincidentally, they will all cause translation
faults and will later choose to update the leaf PTE or not.                      
                                                                                  
The worst case can be like this: some vCPUs cause translation faults on the same
GPA with different prots, they will fight each other by changing back access
permissions of the PTE with break-before-make. And the BBM-invalid moment might
trigger more unnecessary translation faults. As a result, some useless small
loops will occur, which could lead to vCPU stuck. We have met the stuck
occasionally in guest migration and migration-stop time.                         
                                                                                  
To avoid unnecessary update and small loops, add prejudgement in the translation
fault handler: Skip updating the valid leaf PTE if we are trying to recreate
exactly the same mapping or to reduce access permissions only(such as RW-->RO).
And update the valid leaf PTE without break-before-make if we are trying to add
more permissions only.                                                           

Yanan Wang (1):                                                                  
  KVM: arm64: Add prejudgement for relaxing permissions only case in             
    stage2 translation fault handler                                             
                                                                                  
 arch/arm64/kvm/hyp/pgtable.c | 73 +++++++++++++++++++++++++-----------          
 1 file changed, 52 insertions(+), 21 deletions(-)                               
                                                                                  
--                                                                               
2.19.1                                                                           

Trace log for a guest with 96 vCPUs and huge mappings by 1G.

*********************************************************************************
Recreating the same mappings and small loops in dirty-logging period.
*********************************************************************************
Recreating the same mappings:
      CPU 94/KVM-8590    [094] ...2 82538.821614: user_mem_abort: logging_active 1, vcpu_id 94, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 94/KVM-8590    [094] ...2 82538.821615: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 55/KVM-8547    [055] ...2 82538.821618: user_mem_abort: logging_active 1, vcpu_id 55, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 55/KVM-8547    [055] ...2 82538.821619: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 78/KVM-8572    [078] ...2 82538.821620: user_mem_abort: logging_active 1, vcpu_id 78, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 78/KVM-8572    [078] ...2 82538.821622: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 59/KVM-8552    [059] ...2 82538.821624: user_mem_abort: logging_active 1, vcpu_id 59, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 59/KVM-8552    [059] ...2 82538.821625: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 57/KVM-8549    [057] ...2 82538.821626: user_mem_abort: logging_active 1, vcpu_id 57, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 57/KVM-8549    [057] ...2 82538.821626: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 76/KVM-8570    [076] ...2 82538.821628: user_mem_abort: logging_active 1, vcpu_id 76, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 76/KVM-8570    [076] ...2 82538.821629: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 79/KVM-8573    [079] ...2 82538.821631: user_mem_abort: logging_active 1, vcpu_id 79, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 79/KVM-8573    [079] ...2 82538.821631: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff
      CPU 74/KVM-8568    [074] ...2 82538.821633: user_mem_abort: logging_active 1, vcpu_id 74, f_ipa 0x83fffc000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 74/KVM-8568    [074] ...2 82538.821633: stage2_map_walker_try_leaf_equal: addr 0x83fffc000 , level 3, old_pte 0x40002a7fffc7ff, new_pte 0x40002a7fffc7ff

Small loops:
      CPU 65/KVM-8559    [065] ...2 82562.645538: user_mem_abort: logging_active 1, vcpu_id 65, f_ipa 0x80e82c000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 65/KVM-8559    [065] ...2 82562.645570: user_mem_abort: logging_active 1, vcpu_id 65, f_ipa 0x80e82c000 , fault_status 0xc, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 67/KVM-8561    [067] ...2 82562.645615: user_mem_abort: logging_active 1, vcpu_id 67, f_ipa 0x80e82c000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 67/KVM-8561    [067] ...2 82562.645616: stage2_map_walker_try_leaf_unequal: addr 0x80e82c000 , level 3, old_pte 0x40002a4e82c7ff, new_pte 0x40002a4e82c77f
      CPU 67/KVM-8561    [067] ...2 82562.645651: user_mem_abort: logging_active 1, vcpu_id 67, f_ipa 0x80e82c000 , fault_status 0xc, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0

      CPU 19/KVM-8510    [019] ...2 82562.645840: user_mem_abort: logging_active 1, vcpu_id 19, f_ipa 0x7e6aa6000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 19/KVM-8510    [019] ...2 82562.645873: user_mem_abort: logging_active 1, vcpu_id 19, f_ipa 0x7e6aa6000 , fault_status 0xc, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 16/KVM-8507    [016] ...2 82562.645876: user_mem_abort: logging_active 1, vcpu_id 16, f_ipa 0x7e6aa6000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 16/KVM-8507    [016] ...2 82562.645877: stage2_map_walker_try_leaf_unequal: addr 0x7e6aa6000 , level 3, old_pte 0x40002aa6aa67ff, new_pte 0x40002aa6aa677f
      CPU 19/KVM-8510    [019] ...2 82562.645902: user_mem_abort: logging_active 1, vcpu_id 19, f_ipa 0x7e6aa6000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 19/KVM-8510    [019] ...2 82562.645903: stage2_map_walker_try_leaf_unequal: addr 0x7e6aa6000 , level 3, old_pte 0x40002aa6aa677f, new_pte 0x40002aa6aa67ff
      CPU 16/KVM-8507    [016] ...2 82562.645908: user_mem_abort: logging_active 1, vcpu_id 16, f_ipa 0x7e6aa6000 , fault_status 0xc, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0

      CPU 90/KVM-8585    [090] ...2 82562.646211: user_mem_abort: logging_active 1, vcpu_id 90, f_ipa 0x818f9f000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 47/KVM-8539    [047] ...2 82562.646218: user_mem_abort: logging_active 1, vcpu_id 47, f_ipa 0x8189ff000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 47/KVM-8539    [047] ...2 82562.646219: stage2_map_walker_try_leaf_equal: addr 0x8189ff000 , level 3, old_pte 0x40002a589ff77f, new_pte 0x40002a589ff77f
      CPU 42/KVM-8534    [042] ...2 82562.646221: user_mem_abort: logging_active 1, vcpu_id 42, f_ipa 0x8189ff000 , fault_status 0xc, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
      CPU 59/KVM-8552    [059] ...2 82562.646226: user_mem_abort: logging_active 1, vcpu_id 59, f_ipa 0x8189ff000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 59/KVM-8552    [059] ...2 82562.646227: stage2_map_walker_try_leaf_unequal: addr 0x8189ff000 , level 3, old_pte 0x40002a589ff7ff, new_pte 0x40002a589ff77f
      CPU 65/KVM-8559    [065] ...2 82562.646231: user_mem_abort: logging_active 1, vcpu_id 65, f_ipa 0x8189ff000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0
      CPU 65/KVM-8559    [065] ...2 82562.646231: stage2_map_walker_try_leaf_equal: addr 0x8189ff000 , level 3, old_pte 0x40002a589ff77f, new_pte 0x40002a589ff77f
      CPU 50/KVM-8542    [050] ...2 82562.646232: user_mem_abort: logging_active 1, vcpu_id 50, f_ipa 0x8189ff000 , fault_status 0x4, prot 0x4, vma_pagesize 4096      , write_fault 0, exec_fault 0

*********************************************************************************
Recreating the same mappings, and small loops when dirty-logging is stopped.
*********************************************************************************
Recreating the same mappings:
       CPU 3/KVM-26553   [003] ...2 29434.296315: user_mem_abort: logging_active 1, vcpu_id 3 , f_ipa 0x783627000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
       CPU 3/KVM-26553   [003] ...2 29434.296319: user_mem_abort: logging_active 1, vcpu_id 3 , f_ipa 0x7e2a28000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
       CPU 3/KVM-26553   [003] ...2 29434.296326: user_mem_abort: logging_active 1, vcpu_id 3 , f_ipa 0x783628000 , fault_status 0x4, prot 0x6, vma_pagesize 4096      , write_fault 1, exec_fault 0
       CPU 3/KVM-26553   [003] ...2 29434.296332: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x7e2a29000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 3/KVM-26553   [003] ...2 29434.297387: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x783629000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 82/KVM-26634   [082] ...2 29434.297665: user_mem_abort: logging_active 0, vcpu_id 82, f_ipa 0x819a98000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 93/KVM-26645   [093] ...2 29434.300387: user_mem_abort: logging_active 0, vcpu_id 93, f_ipa 0x819ae6000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 93/KVM-26645   [093] ...2 29434.300391: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 92/KVM-26644   [092] ...2 29434.300392: user_mem_abort: logging_active 0, vcpu_id 92, f_ipa 0x819ae2000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 92/KVM-26644   [092] ...2 29434.300394: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 85/KVM-26637   [085] ...2 29434.300396: user_mem_abort: logging_active 0, vcpu_id 85, f_ipa 0x819aa4000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 85/KVM-26637   [085] ...2 29434.300400: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 84/KVM-26636   [084] ...2 29434.300402: user_mem_abort: logging_active 0, vcpu_id 84, f_ipa 0x819aa0000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 84/KVM-26636   [084] ...2 29434.300403: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 87/KVM-26639   [087] ...2 29434.300405: user_mem_abort: logging_active 0, vcpu_id 87, f_ipa 0x819aac000 , fault_status 0xc, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 87/KVM-26639   [087] ...2 29434.300407: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.300410: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.300412: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
      CPU 88/KVM-26640   [088] ...2 29434.300417: user_mem_abort: logging_active 0, vcpu_id 88, f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 88/KVM-26640   [088] ...2 29434.300420: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
      CPU 80/KVM-26632   [080] ...2 29434.300425: user_mem_abort: logging_active 0, vcpu_id 80, f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 80/KVM-26632   [080] ...2 29434.300427: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 32/KVM-26582   [032] ...2 29434.300431: user_mem_abort: logging_active 0, vcpu_id 32, f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
      CPU 32/KVM-26582   [032] ...2 29434.300435: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
      CPU 25/KVM-26575   [025] ...2 29434.300438: user_mem_abort: logging_active 0, vcpu_id 25, f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       
Small loops:
       CPU 8/KVM-26558   [008] ...2 29434.303759: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303761: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303767: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303767: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303773: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303774: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303776: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303777: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303780: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83f952000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303780: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303786: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303786: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303793: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83f952000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303793: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303795: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303796: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303799: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303799: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303805: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303805: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303812: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83f952000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303812: stage2_map_walker_try_leaf_equal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303814: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303815: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303818: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83f952000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303818: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303823: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303824: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303828: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83f952000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303829: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303834: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303835: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
       CPU 8/KVM-26558   [008] ...2 29434.303838: user_mem_abort: logging_active 0, vcpu_id 8 , f_ipa 0x83fffe000 , fault_status 0x4, prot 0x6, vma_pagesize 1073741824, write_fault 1, exec_fault 0
       CPU 8/KVM-26558   [008] ...2 29434.303839: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x2028400007fd  , new_pte 0x402028400007fd
       CPU 3/KVM-26553   [003] ...2 29434.303844: user_mem_abort: logging_active 0, vcpu_id 3 , f_ipa 0x80c321000 , fault_status 0x4, prot 0x7, vma_pagesize 1073741824, write_fault 0, exec_fault 1
       CPU 3/KVM-26553   [003] ...2 29434.303845: stage2_map_walker_try_leaf_unequal: addr 0x800000000 , level 1, old_pte 0x402028400007fd, new_pte 0x2028400007fd  
