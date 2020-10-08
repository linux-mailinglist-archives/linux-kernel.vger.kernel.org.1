Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220EB287AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgJHRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:30:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47414 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgJHRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:30:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098HO1tU159365;
        Thu, 8 Oct 2020 17:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IcMgS4l7AuuIK49RC6MByzv1q0Uka9so2qKSQP2QQxU=;
 b=jSOdK7D7MJI5WHnHFxG2dmOUSHwVHOtb4pdybJWs1pUFLVPztab2/86yIm+CINRMo2ab
 g4CDzYDg8lXvms4vfrXYilHwAZcmNvjo2uGTw6u39L8tPvgaabxzN2BAsLaJeM6cfmik
 qjXtNu9oqwKMFTIUdiPS2w78nRsGufFBM5t1CVOC4ypIAZ9dkgat2+tywUAEe5a5msjZ
 uFcKoiRxZIcIrgt9Lr781NtABi860vb4L/JRDMYzVlezI5rbQDM2pOiAbk2efO3g3Nfh
 WRM1bwts2c4IiPuiX9b5VjZCQN7shck9sEBQ/GPjDRa9kobOmYmmNIwqK393syyclDOM xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33ym34x429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 17:29:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098HPGm7085664;
        Thu, 8 Oct 2020 17:29:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 341xnc0amn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 17:29:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 098HTefU004342;
        Thu, 8 Oct 2020 17:29:41 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 10:29:40 -0700
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
To:     Hugh Dickins <hughd@google.com>
Cc:     Qian Cai <cai@lca.pm>, js1304@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
 <20200708012044.GC992@lca.pw>
 <alpine.LSU.2.11.2010071833100.2214@eggly.anvils>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cf715524-f30d-634f-2a05-e02c4e52e675@oracle.com>
Date:   Thu, 8 Oct 2020 10:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2010071833100.2214@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=27 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=27 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 8:21 PM, Hugh Dickins wrote:
> On Tue, 7 Jul 2020, Qian Cai wrote:
>> On Tue, Jun 23, 2020 at 03:13:47PM +0900, js1304@gmail.com wrote:
>>> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>
>>> There is a well-defined migration target allocation callback.
>>> Use it.
>>>
>>> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>> ---
> ...
>>
>> migrate_pages() starts failing like this apparently using the new
>> callback on NUMA systems,
>>
>> [ 6147.019063][T45242] LTP: starting move_pages12
>> [ 6147.475680][T64921] BUG: unable to handle page fault for address: ffffffffffffffe0
>> [ 6147.483301][T64921] #PF: supervisor read access in kernel mode
>> [ 6147.489170][T64921] #PF: error_code(0x0000) - not-present page
>> [ 6147.495040][T64921] PGD 5df817067 P4D 5df817067 PUD 5df819067 PMD 0 
>> [ 6147.501438][T64921] Oops: 0000 [#1] SMP KASAN NOPTI
>> [ 6147.506348][T64921] CPU: 35 PID: 64921 Comm: move_pages12 Tainted: G           O      5.8.0-rc4-next-20200707 #1
>> [ 6147.516586][T64921] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>> [ 6147.525866][T64921] RIP: 0010:anon_vma_interval_tree_iter_first+0xa2/0x170
>> avc_start_pgoff at mm/interval_tree.c:63
>> (inlined by) __anon_vma_interval_tree_iter_first at mm/interval_tree.c:71
>> (inlined by) anon_vma_interval_tree_iter_first at mm/interval_tree.c:95
>> [ 6147.532787][T64921] Code: 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d e0 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 b3 00 00 00 48 b8 00 00 00 00 00 fc ff df <48> 8b 6d e0 48 8d bd 98 00 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00
>> [ 6147.552370][T64921] RSP: 0018:ffffc9000bfdfa98 EFLAGS: 00010246
>> [ 6147.558327][T64921] RAX: dffffc0000000000 RBX: ffff888524019b28 RCX: 1ffffffffffffffc
>> [ 6147.566205][T64921] RDX: 00000000000003ff RSI: 0000000000000200 RDI: ffffffffffffffe0
>> [ 6147.574084][T64921] RBP: 0000000000000000 R08: fffff94002b1c001 R09: fffff94002b1c001
>> [ 6147.581962][T64921] R10: ffffea00158e0007 R11: fffff94002b1c000 R12: 0000000000000009
>> [ 6147.589839][T64921] R13: ffffea00158e0008 R14: ffffea00158e0000 R15: ffffea00158e0000
>> [ 6147.597717][T64921] FS:  00007f329cf18b80(0000) GS:ffff88881f7c0000(0000) knlGS:0000000000000000
>> [ 6147.606557][T64921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 6147.613037][T64921] CR2: ffffffffffffffe0 CR3: 000000081122a000 CR4: 00000000003506e0
>> [ 6147.620914][T64921] Call Trace:
>> [ 6147.624078][T64921]  rmap_walk_anon+0x141/0xa30
>> rmap_walk_anon at mm/rmap.c:1864
>> [ 6147.628639][T64921]  try_to_unmap+0x209/0x2d0
>> try_to_unmap at mm/rmap.c:1763
>> [ 6147.633026][T64921]  ? rmap_walk_locked+0x140/0x140
>> [ 6147.637936][T64921]  ? page_remove_rmap+0x1190/0x1190
>> [ 6147.643020][T64921]  ? page_not_mapped+0x10/0x10
>> [ 6147.647668][T64921]  ? page_get_anon_vma+0x290/0x290
>> [ 6147.652664][T64921]  ? page_mapcount_is_zero+0x10/0x10
>> [ 6147.657838][T64921]  ? hugetlb_page_mapping_lock_write+0x97/0x180
>> [ 6147.663972][T64921]  migrate_pages+0x1005/0x1fb0
>> unmap_and_move_huge_page at mm/migrate.c:1383
>> (inlined by) migrate_pages at mm/migrate.c:1468
>> [ 6147.668617][T64921]  ? remove_migration_pte+0xac0/0xac0
>> [ 6147.673875][T64921]  move_pages_and_store_status.isra.47+0xd7/0x1a0
>> do_move_pages_to_node at mm/migrate.c:1595
>> (inlined by) move_pages_and_store_status at mm/migrate.c:1683
>> [ 6147.680181][T64921]  ? migrate_pages+0x1fb0/0x1fb0
>> [ 6147.685002][T64921]  __x64_sys_move_pages+0xa5c/0x1100
>> [ 6147.690176][T64921]  ? trace_hardirqs_on+0x20/0x1b5
>> [ 6147.695084][T64921]  ? move_pages_and_store_status.isra.47+0x1a0/0x1a0
>> [ 6147.701653][T64921]  ? rcu_read_lock_sched_held+0xaa/0xd0
>> [ 6147.707088][T64921]  ? switch_fpu_return+0x196/0x400
>> [ 6147.712083][T64921]  ? lockdep_hardirqs_on_prepare+0x38c/0x550
>> [ 6147.717954][T64921]  ? do_syscall_64+0x24/0x310
>> [ 6147.722513][T64921]  do_syscall_64+0x5f/0x310
>> [ 6147.726897][T64921]  ? trace_hardirqs_off+0x12/0x1a0
>> [ 6147.731894][T64921]  ? asm_exc_page_fault+0x8/0x30
>> [ 6147.736714][T64921]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [ 6147.742495][T64921] RIP: 0033:0x7f329c3fe6ed
>> [ 6147.746791][T64921] Code: Bad RIP value.
>> [ 6147.750738][T64921] RSP: 002b:00007fff5b6b5f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000117
>> [ 6147.759055][T64921] RAX: ffffffffffffffda RBX: 00007f329cf18af8 RCX: 00007f329c3fe6ed
>> [ 6147.766933][T64921] RDX: 00000000019b0ee0 RSI: 0000000000000400 RDI: 000000000000fd98
>> [ 6147.774809][T64921] RBP: 0000000000000400 R08: 00000000019b3f00 R09: 0000000000000004
>> [ 6147.782686][T64921] R10: 00000000019b2ef0 R11: 0000000000000246 R12: 0000000000000400
>> [ 6147.790563][T64921] R13: 00000000019b0ee0 R14: 00000000019b2ef0 R15: 00000000019b3f00
>> [ 6147.798440][T64921] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio loop kvm_amd ses enclosure kvm irqbypass efivars acpi_cpufreq nls_ascii nls_cp437 vfat fat efivarfs ip_tables x_tables sd_mod smartpqi scsi_transport_sas tg3 mlx5_core libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
>> [ 6147.828701][T64921] CR2: ffffffffffffffe0
>> [ 6147.832736][T64921] ---[ end trace 40323b256f1c74a8 ]---
>> [ 6147.838083][T64921] RIP: 0010:anon_vma_interval_tree_iter_first+0xa2/0x170
>> [ 6147.845001][T64921] Code: 00 00 00 00 fc ff df 48 8b 6d 08 48 8d 7d e0 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 b3 00 00 00 48 b8 00 00 00 00 00 fc ff df <48> 8b 6d e0 48 8d bd 98 00 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00
>> [ 6147.864583][T64921] RSP: 0018:ffffc9000bfdfa98 EFLAGS: 00010246
>> [ 6147.870539][T64921] RAX: dffffc0000000000 RBX: ffff888524019b28 RCX: 1ffffffffffffffc
>> [ 6147.878417][T64921] RDX: 00000000000003ff RSI: 0000000000000200 RDI: ffffffffffffffe0
>> [ 6147.886294][T64921] RBP: 0000000000000000 R08: fffff94002b1c001 R09: fffff94002b1c001
>> [ 6147.894172][T64921] R10: ffffea00158e0007 R11: fffff94002b1c000 R12: 0000000000000009
>> [ 6147.902049][T64921] R13: ffffea00158e0008 R14: ffffea00158e0000 R15: ffffea00158e0000
>> [ 6147.909932][T64921] FS:  00007f329cf18b80(0000) GS:ffff88881f7c0000(0000) knlGS:0000000000000000
>> [ 6147.918771][T64921] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 6147.925251][T64921] CR2: ffffffffffffffe0 CR3: 000000081122a000 CR4: 00000000003506e0
>> [ 6147.933130][T64921] Kernel panic - not syncing: Fatal exception
>> [ 6147.939493][T64921] Kernel Offset: 0x28c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [ 6147.951090][T64921] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> I hit this too, trying LTP (yes, move_pages12) on 5.9-rc8.  I could not
> then reproduce it, and suppose that Qian Cai was also unable to do so.
> 
> But it's fairly easy to explain, and not at all related to Joonsoo's
> patch or patchset accused in this thread.
> 
> The faulting address ffffffffffffffe0 is not an -ESPIPE here,
> it comes from a mov -0x20(%rcx),%rcx with NULL %rcx in my case: I've
> been too impatient to unravel the interval tree defining to work out
> exactly what that corresponds to, but I assume from an
> anon_vma_interval_tree rb_entry container_of.
> 
> Mike, j'accuse... your 5.7 commit c0d0381ade79 ("hugetlbfs:
> use i_mmap_rwsem for more pmd sharing synchronization"), in which
> unmap_and_move_huge_page() now passes the TTU_RMAP_LOCKED flag to
> try_to_unmap(), because it's already holding mapping->i_mmap_rwsem:
> but that is not the right lock to secure an anon_vma lookup.

Thanks Hugh!  Your analysis is correct and the code in that commit is
not correct.  I was so focused on the file mapping case, I overlooked
(actually introduced) this issue for anon mappings.

Let me verify that this indeed is the root cause.  However, since
move_pages12 migrated anon hugetlb pages it certainly does look to be
the case.

> I intended to send a patch, passing TTU_RMAP_LOCKED only in the
> !PageAnon case (and, see vma_adjust(), anon_vma lock conveniently
> nests inside i_mmap_rwsem); but then wondered if i_mmap_rwsem was
> needed in that case or not, so looked deeper into c0d0381ade79.
> 
> Hmm, not even you liked it!  But the worst of it looks simply
> unnecessary to me, and I hope can be deleted - but better by you
> than by me (in particular, you were trying to kill 1) and 2) birds
> with one stone, and I've always given up on understanding hugetlb's
> reservations: I suspect that side of it is irrelevant here,
> but I wouldn't pretend to be sure).
> 
> How could you ever find a PageAnon page in a vma_shareable() area?
> 
> It is all rather confusing (vma_shareable() depending on VM_MAYSHARE,
> whereas is_cow_mapping() on VM_SHARED and VM_MAYWRITE: they have to
> be studied together with do_mmap()'s 
> 			vm_flags |= VM_SHARED | VM_MAYSHARE;
> 			if (!(file->f_mode & FMODE_WRITE))
> 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
> 
> (And let me add to the confusion by admitting that, prior to 3.15's
> cda540ace6a1 "mm: get_user_pages(write,force) refuse to COW in
> shared areas", maybe it was possible to find a PageAnon there.)
> 
> But my belief (best confirmed by you running your tests with a
> suitably placed BUG_ON or WARN_ON) is that you'll never find a
> PageAnon in a vma_shareable() area, so will never need try_to_unmap()
> to unshare a pagetable in the PageAnon case, so won't need i_mmap_rwsem
> for PageAnon there, and _get_hugetlb_page_mapping() (your function that
> deduces an address_space from an anon_vma) can just be deleted.

Yes, it is confusing.  Let me look into this.  I would be really happy
to delete that ugly function.

> (And in passing, may I ask what hugetlb_page_mapping_lock_write()'s
> hpage->_mapcount inc and dec are for?  You comment it as a hack,
> but don't explain what needs that hack, and I don't see it.)

We are trying to lock the mapping (mapping->i_mmap_rwsem).  We know
mapping is valid, because we obtained it from page_mapping() and it
will remain valid because we have the page locked.  Page needs to be
unlocked to unmap.  However, we have to drop page lock in order to
acquire i_mmap_rwsem.  Once we drop page lock, mapping could become
invalid.  So, the code code artifically incs mapcount so that mapping
will remain valid when upmapping page.

As mentioned above, I hope all this can be removed.
-- 
Mike Kravetz
