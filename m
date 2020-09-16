Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4298626C814
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgIPSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:40:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37694 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIPS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:54 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id C939D20C27C2;
        Wed, 16 Sep 2020 11:28:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C939D20C27C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600280926;
        bh=WgSaX7oWmI5euoCqTGJziZ8b5tOWrJ4XQmBMActzLNw=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=boKOId3ClpA3GW7hb01+wYH5B0KutqOD2kTsi8UF5ucx+hskrMN/BT/bqDbcLFNGT
         jx6D+PkaRHpZuTQHzRIwrh1jTO1TL9UqSanxoM1QVjaQKUb0N827PqN5r+Zz6HCSvG
         MLY8qjhLWcDIjKWvNWm8kUYCOmx0vuabvm6DFUI4=
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
Message-ID: <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
Date:   Wed, 16 Sep 2020 11:28:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200916065306.GB18998@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2020 11:53 PM, Michal Hocko wrote:
> On Tue 15-09-20 08:48:08, Vijay Balakrishna wrote:
>>
>>
>> On 9/15/2020 1:18 AM, Michal Hocko wrote:
>>> On Mon 14-09-20 09:57:02, Vijay Balakrishna wrote:
>>>>
>>>>
>>>> On 9/14/2020 7:33 AM, Michal Hocko wrote:
>>>>> On Thu 10-09-20 13:47:39, Vijay Balakrishna wrote:
>>>>>> When memory is hotplug added or removed the min_free_kbytes must be
>>>>>> recalculated based on what is expected by khugepaged.  Currently
>>>>>> after hotplug, min_free_kbytes will be set to a lower default and higher
>>>>>> default set when THP enabled is lost. This leaves the system with small
>>>>>> min_free_kbytes which isn't suitable for systems especially with network
>>>>>> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
>>>>>> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
>>>>>> kills.
>>>>>
>>>>> Care to explain some more please? The whole point of increasing
>>>>> min_free_kbytes for THP is to get a larger free memory with a hope that
>>>>> huge pages will be more likely to appear. While this might help for
>>>>> other users that need a high order pages it is definitely not the
>>>>> primary reason behind it. Could you provide an example with some more
>>>>> data?
>>>>
>>>> Thanks Michal.  I haven't looked into THP as part of my investigation, so I
>>>> cannot comment.
>>>>
>>>> In our use case we are hotplug removing ~2GB of 8GB total (on our SoC)
>>>> during normal reboot/shutdown.  This memory is hotplug hot-added as movable
>>>> type via systemd late service during start-of-day.
>>>>
>>>> In our stress test first we ran into HW WATCHDOG recovery, on enabling
>>>> kernel watchdog we started seeing soft lockup hung task notices, failure
>>>> symptons varied, where stack trace of hung tasks sometimes trying to
>>>> allocate GFP_ATOMIC memory, looping in do_notify_resume, NETDEVICE WATCHDOG
>>>> timeouts, OOM process kills etc.,  During investigation we reran stress test
>>>> without hotplug use case.  Surprisingly this run didn't encounter the said
>>>> problems.  This led to comparing what is different between the two runs,
>>>> while looking at various globals, studying hotplug code I uncovered the
>>>> issue of failing to restore min_free_kbytes.  In particular on our 8GB SoC
>>>> min_free_kbytes went down to 8703 from 22528 after hotplug add.
>>>
>>> Did you try to increase min_free_kbytes manually after hot remove? Btw.
>>
>> No, in our use case memory hot remove done during shutdown.
> 
> I do not follow. If you are hotremoving during shutdown then how come
> the value of min_free_kbytes matter at all?

We are hot adding (which is hot removed memory during shutdown) during 
boot, the removed memory treated as persistent.

> 
>>> I would consider oom killer invocation due to min_free_kbytes really
>>> weird behavior. If anything the higher value would cause more memory
>>> reclaim and potentially oom rather than smaller one.
>>
>> Yes, we wondered about it too.  One panic stack trace (after many OOM kills)
>>
>> [330321.174240] Out of memory and no killable processes...
>> [330321.179658] Kernel panic - not syncing: System is deadlocked on memory
>> [330321.186489] CPU: 4 PID: 1 Comm: systemd Kdump: loaded Tainted: G       O
>> 5.4.51-xxx #1
>> [330321.196900] Hardware name: Overlake (DT)
>> [330321.201038] Call trace:
>> [330321.203660]  dump_backtrace+0x0/0x1d0
>> [330321.207533]  show_stack+0x20/0x2c
>> [330321.211048]  dump_stack+0xe8/0x150
>> [330321.214656]  panic+0x18c/0x3b4
>> [330321.217901]  out_of_memory+0x4c0/0x6e4
>> [330321.221863]  __alloc_pages_nodemask+0xbdc/0x1c90
>> [330321.226722]  alloc_pages_current+0x21c/0x2b0
>> [330321.231220]  alloc_slab_page+0x1e0/0x7d8
>> [330321.235361]  new_slab+0x2e8/0x2f8
>> [330321.238874]  ___slab_alloc+0x45c/0x59c
>> [330321.242835]  kmem_cache_alloc+0x2d4/0x360
>> [330321.247065]  getname_flags+0x6c/0x2a8
>> [330321.250938]  user_path_at_empty+0x3c/0x68
>> [330321.255168]  do_readlinkat+0x7c/0x17c
>> [330321.259039]  __arm64_sys_readlinkat+0x5c/0x70
>> [330321.263627]  el0_svc_handler+0x1b8/0x32c
>> [330321.267767]  el0_svc+0x10/0x14
>> [330321.271026] SMP: stopping secondary CPUs
>> [330321.275382] Starting crashdump kernel...
>> [330321.279526] Bye!
> 
> Do you have the full oom splat? The fact that previous oom killer
> invocations haven't helped and all the eligible tasks have been killed
> and you still hit the oom would suggest there is a lot of memory
> allocated without a direct relation to tasks. I fail to see how
> min_free_kbytes would be related.

OOM splat below.  I see we had kmem leak detection turned on here.  We 
haven't run stress with kmem leak detection since uncovereing low 
min_free_kbytes.  During investigation we wanted to make sure there is 
no kmem leaks, we didn't find significant leaks detected.

[330319.234959] 
oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/system.slice/dbus-broker.service,task=dbus-broker,pid=541,uid=999
[330319.251380] Out of memory: Killed process 541 (dbus-broker) 
total-vm:4400kB, anon-rss:892kB, file-rss:380kB, shmem-rss:0kB, UID:999 
pgtables:44kB oom_score_adj:-900
[330319.267587] oom_reaper: reaped process 541 (dbus-broker), now 
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
[330319.766059] systemd invoked oom-killer: 
gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=1, oom_score_adj=0
[330319.776060] CPU: 4 PID: 1 Comm: systemd Kdump: loaded Tainted: G 
        O      5.4.51-xxx #1
[330319.790612] Call trace:
[330319.793240]  dump_backtrace+0x0/0x1d0
[330319.797112]  show_stack+0x20/0x2c
[330319.800628]  dump_stack+0xe8/0x150
[330319.804234]  dump_header+0x80/0x494
[330319.807925]  out_of_memory+0x480/0x6e4
[330319.811887]  __alloc_pages_nodemask+0xbdc/0x1c90
[330319.816745]  alloc_pages_current+0x21c/0x2b0
[330319.821244]  alloc_slab_page+0x1e0/0x7d8
[330319.825383]  new_slab+0x2e8/0x2f8
[330319.828895]  ___slab_alloc+0x45c/0x59c
[330319.832854]  kmem_cache_alloc+0x2d4/0x360
[330319.837086]  getname_flags+0x6c/0x2a8
[330319.840958]  user_path_at_empty+0x3c/0x68
[330319.845188]  do_readlinkat+0x7c/0x17c
[330319.849059]  __arm64_sys_readlinkat+0x5c/0x70
[330319.853648]  el0_svc_handler+0x1b8/0x32c
[330319.857788]  el0_svc+0x10/0x14
[330319.861064] Mem-Info:
[330319.863519] active_anon:60744 inactive_anon:109226 isolated_anon:0
                  active_file:6418 inactive_file:3869 isolated_file:2
                  unevictable:0 dirty:8 writeback:1 unstable:0
                  slab_reclaimable:34660 slab_unreclaimable:795718
                  mapped:1256 shmem:165765 pagetables:689 bounce:0
                  free:340962 free_pcp:4672 free_cma:0
[330319.898873] Node 0 active_anon:242976kB inactive_anon:436904kB 
active_file:25672kB inactive_file:15476kB unevictable:0kB 
isolated(anon):0kB isolated(file):8kB mapped:5024kB dirty:32kB 
writeback:4kB shmem:663060kB shmem_thp: 0kB shmem_pmdmapped: 0kB 
anon_thp: 73728kB writeback_tmp:0kB unstable:0kB all_unreclaimable? yes
[330319.928124] Node 0 Normal free:12652kB min:14344kB low:19092kB 
high:23840kB active_anon:55340kB inactive_anon:60276kB active_file:60kB 
inactive_file:128kB unevictable:0kB writepending:4kB present:6220656kB 
managed:4750196kB mlocked:0kB kernel_stack:9568kB pagetables:2756kB 
bounce:0kB free_pcp:10056kB local_pcp:1376kB free_cma:0kB
[330319.958376] lowmem_reserve[]: 0 15360 15360
[330319.962814] Node 0 Movable free:1351196kB min:2544kB low:4508kB 
high:6472kB active_anon:188352kB inactive_anon:376856kB 
active_file:26120kB inactive_file:15308kB unevictable:0kB 
writepending:32kB present:1966080kB managed:1966080kB mlocked:0kB 
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:8632kB 
local_pcp:1336kB free_cma:0kB
[330319.993157] lowmem_reserve[]: 0 0 0
[330319.996879] Node 0 Normal: 3138*4kB (UME) 38*8kB (UM) 0*16kB 0*32kB 
0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12856kB
[330320.009592] Node 0 Movable: 16382*4kB (M) 2980*8kB (M) 311*16kB (M) 
77*32kB (M) 28*64kB (M) 5*128kB (M) 6*256kB (M) 1*512kB (M) 1*1024kB (M) 
120*2048kB (M) 245*4096kB (M) = 1351592kB
[330320.026541] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=1048576kB
[330320.035631] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=32768kB
[330320.044543] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=2048kB
[330320.053363] Node 0 hugepages_total=0 hugepages_free=0 
hugepages_surp=0 hugepages_size=64kB
[330320.062004] 176215 total pagecache pages
[330320.066165] 2046684 pages RAM
[330320.069339] 0 pages HighMem/MovableOnly
[330320.073410] 367615 pages reserved
[330320.076943] 0 pages hwpoisoned
[330320.080190] Unreclaimable slab info:
[330320.083991] Name                      Used          Total
[330320.090244] bio-3                    560KB        672KB
[330320.095747] bio-2                    757KB        832KB
[330320.101254] nf-frags                   7KB         15KB
[330320.106763] fib6_nodes                16KB         16KB
[330320.112270] ip6_dst_cache             70KB         70KB
[330320.117779] RAWv6                    154KB        154KB
[330320.123296] UDPv6                    246KB        246KB
[330320.128806] TCPv6                    146KB        146KB
[330320.134315] nf_conntrack              84KB         94KB
[330320.139823] io                        66KB         80KB
[330320.145332] sd_ext_cdb                 3KB          3KB
[330320.150838] virtio_scsi_cmd           16KB         16KB
[330320.156345] sgpool-128                29KB         29KB
[330320.161852] sgpool-64                 31KB         31KB
[330320.167359] sgpool-32                 31KB         31KB
[330320.172867] sgpool-16                 15KB         15KB
[330320.178374] sgpool-8                   7KB          7KB
[330320.183880] mqueue_inode_cache         31KB         31KB
[330320.189479] jbd2_inode                35KB         43KB
[330320.194989] ext4_system_zone          21KB         55KB
[330320.200497] ext4_bio_post_read_ctx         15KB         15KB
[330320.206453] kioctx                   255KB        255KB
[330320.211960] aio_kiocb                 54KB         77KB
[330320.217477] dio                      196KB        323KB
[330320.222985] bio-1                      7KB          7KB
[330320.228499] UNIX                     308KB        369KB
[330320.234009] tcp_bind_bucket           20KB         20KB
[330320.239518] ip_fib_trie               16KB         16KB
[330320.245024] ip_fib_alias              15KB         15KB
[330320.250537] ip_dst_cache              64KB         64KB
[330320.256047] RAW                      158KB        158KB
[330320.261553] UDP                      247KB        247KB
[330320.267060] tw_sock_TCP               15KB         15KB
[330320.272566] request_sock_TCP          30KB         30KB
[330320.278073] TCP                      278KB        278KB
[330320.283580] hugetlbfs_inode_cache         62KB         62KB
[330320.289446] eventpoll_pwq             31KB         31KB
[330320.294953] eventpoll_epi             31KB         31KB
[330320.300460] inotify_inode_mark         31KB         31KB
[330320.306061] request_queue            467KB        499KB
[330320.311568] blkdev_ioc                61KB         61KB
[330320.317087] bio-0                    259KB        600KB
[330320.322603] biovec-max              3060KB       3718KB
[330320.328112] biovec-64                252KB        315KB
[330320.333619] biovec-16                 62KB         78KB
[330320.339127] khugepaged_mm_slot         31KB         35KB
[330320.344723] user_namespace           122KB        122KB
[330320.350230] uid_cache                 64KB         64KB
[330320.355738] iommu_iova              1076KB       1076KB
[330320.361245] dmaengine-unmap-2          4KB          4KB
[330320.366754] skbuff_fclone_cache        128KB        160KB
[330320.374394] skbuff_head_cache      79402KB     106265KB
[330320.379908] file_lock_cache           62KB         92KB
[330320.385416] file_lock_ctx             42KB         47KB
[330320.390924] fsnotify_mark_connector         46KB         51KB
[330320.396969] net_namespace             64KB         64KB
[330320.402477] task_delay_info           66KB         78KB
[330320.407984] taskstats                 63KB         63KB
[330320.413491] proc_dir_entry           279KB        289KB
[330320.418998] pde_opener                31KB         31KB
[330320.424507] seq_file                  63KB         94KB
[330320.430014] sigqueue                  55KB         55KB
[330320.435525] shmem_inode_cache       1086KB       1221KB
[330320.441036] kernfs_iattrs_cache        782KB        826KB
[330320.446746] kernfs_node_cache       7943KB       8221KB
[330320.452306] mnt_cache               1579KB       2756KB
[330320.457813] filp                     265KB        265KB
[330320.463321] names_cache            21543KB      21543KB
[330320.468833] hashtab_node             115KB        131KB
[330320.474341] ebitmap_node             626KB        641KB
[330320.479849] avtab_node              1047KB       1063KB
[330320.485361] avc_node                 118KB        118KB
[330320.490868] iint_cache                23KB         23KB
[330320.496376] lsm_inode_cache         8578KB       8578KB
[330320.501902] lsm_file_cache           147KB        552KB
[330320.507416] key_jar                  157KB        157KB
[330320.512927] nsproxy                   31KB         31KB
[330320.518436] vm_area_struct            89KB        127KB
[330320.523944] mm_struct                252KB        252KB
[330320.529451] fs_cache                  64KB         64KB
[330320.534959] files_cache              255KB        255KB
[330320.540468] signal_cache             507KB        569KB
[330320.545979] sighand_cache            633KB        841KB
[330320.551488] task_struct             1721KB       1940KB
[330320.556997] cred_jar                 119KB        136KB
[330320.562504] anon_vma_chain            35KB         47KB
[330320.568011] anon_vma                  73KB         95KB
[330320.573520] pid                      101KB        120KB
[330320.579029] numa_policy                3KB          3KB
[330320.584536] trace_event_file         262KB        262KB
[330320.590041] ftrace_event_field        184KB        184KB
[330320.595638] pool_workqueue           128KB        128KB
[330320.601146] task_group                64KB         64KB
[330320.606652] vmap_area                 77KB         78KB
[330320.612159] page->ptl                517KB        517KB
[330320.617665] kmemleak_scan_area         47KB         47KB
[330320.623262] kmemleak_object      2449340KB    2449340KB
[330320.628773] kmalloc-8k              4848KB       4928KB
[330320.634423] kmalloc-4k             48944KB      61856KB
[330320.639946] kmalloc-2k             11768KB      12480KB
[330320.645453] kmalloc-1k             10752KB      10752KB
[330320.651049] kmalloc-512            87024KB      94124KB
[330320.656561] kmalloc-256             2433KB       2528KB
[330320.662359] kmalloc-128            24071KB      29104KB
[330320.667869] kmem_cache_node          867KB        896KB
[330320.673377] kmem_cache              2162KB       2171KB
[330320.678881] Tasks state (memory values in pages):
[330320.683848] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes 
swapents oom_score_adj name
[330320.692867] [    238]     0   238     3446     1394    61440 
0         -1000 systemd-udevd
[330320.702174] [  20024] 62412 20008   313895        0   176128 
0             0 test_ntttcp
[330320.711281] [  20891] 64250 20885    67810        0    49152 
0             0 test_cpuloadgen
[330320.720743] [  20704] 62689 20704   157371       23    90112 
0             0 fio
[330320.729119] [  20708] 62689 20708   157372        5    90112 
0             0 fio
[330320.737496] [  20709] 62689 20709   157373        6    90112 
0             0 fio
[330320.745874] [  20710] 62689 20710   157374        6    90112 
0             0 fio
[330320.754267] [   4698]     0  4698     2231        0    57344 
0             0 umount
[330320.762919] [   4699]     0  4699     2231        0    57344 
0             0 umount
[330320.771565] [   4700]     0  4700     2231        0    53248 
0             0 umount
[330320.780212] [   4701]     0  4701     2231        0    57344 
0             0 umount
[330320.788858] [   4705]     0  4705     2231        0    53248 
0             0 umount
[330320.797505] [   4706]     0  4706     2231        0    57344 
0             0 umount
[330320.806152] [   4707]     0  4707     2231        0    61440 
0             0 umount
[330320.814798] [   4709]     0  4709     2265        0    57344 
0             0 veritysetup
[330320.823891] [   4715]     0  4715     2231        0    61440 
0             0 umount
[330320.832537] [   4716]     0  4716     2231        0    57344 
0             0 umount
[330320.841185] [   4717]     0  4717     2231        0    57344 
0             0 umount
[330320.849832] [   4721]     0  4721     2231        0    57344 
0             0 umount
[330320.858478] [   4722]     0  4722     2231        0    57344 
0             0 umount
[330320.867124] [   4723]     0  4723     2231        0    57344 
0             0 umount
[330320.875770] [   4728]     0  4728     2231        0    61440 
0             0 umount
[330320.884423] [   4729]     0  4729     2231        0    57344 
0             0 umount
[330320.893075] [   4730]     0  4730     2231        0    57344 
0             0 umount
[330320.901722] [   4731]     0  4731     2231        0    57344 
0             0 umount
[330320.910369] [   4732]     0  4732     2231        0    61440 
0             0 umount
[330320.919016] [   4733]     0  4733     2231        0    57344 
0             0 umount
[330320.927662] [   4735]     0  4735     2231        0    61440 
0             0 umount
[330320.936307] [   4736]     0  4736     2231        0    61440 
0             0 umount
[330320.944953] [   4737]     0  4737     2231        0    57344 
0             0 umount
[330320.953599] [   4738]     0  4738     2231        0    61440 
0             0 umount
[330320.962245] [   4739]     0  4739     2231        0    57344 
0             0 umount
[330320.970891] [   4740]     0  4740     2231        0    53248 
0             0 umount
[330320.979536] [   4744]     0  4744     2231        0    61440 
0             0 umount
[330320.988187] [   4746]     0  4746     2231        0    57344 
0             0 umount
[330320.996832] [   4747]     0  4747     2231        0    61440 
0             0 umount
[330321.005479] [   4757]     0  4757     2265        0    53248 
0             0 veritysetup
[330321.014573] [   4758]     0  4758     2231        0    57344 
0             0 umount
[330321.023225] [   4759]     0  4759     2231        0    57344 
0             0 umount
[330321.031872] [   4760]     0  4760     2231        0    61440 
0             0 umount
[330321.040519] [   5922]     0  5922     3012        0    61440 
0             0 systemd-user-ru
[330321.049972] [   6557]     0  6557     2231        0    61440 
0             0 umount
[330321.058618] [   6558]     0  6558     2231        0    61440 
0             0 umount
[330321.067264] [   6563]     0  6563     2231        0    57344 
0             0 umount
[330321.075910] [   6567]     0  6567     2231        0    57344 
0             0 umount
[330321.084556] [   6569]     0  6569     2231        0    53248 
0             0 umount
[330321.093194] [   6570]     0  6570     2231        0    65536 
0             0 umount
[330321.101840] [   6575]     0  6575     2231        0    57344 
0             0 umount
[330321.110485] [   6578]     0  6578     2231        0    61440 
0             0 umount
[330321.119132] [   6579]     0  6579     2231        0    57344 
0             0 umount
[330321.127778] [   6580]     0  6580     2231        0    61440 
0             0 umount
[330321.136425] [   7215]     0  7215     5087        0    69632 
0             0 systemd-journal
[330321.145879] [   8410]     0  8410     5087        0    65536 
0             0 systemd-journal
[330321.155336] [   9603]     0  9603     5087        0    73728 
0             0 systemd-journal
[330321.164790] [  10366]     0 10366     3012        0    61440 
0             0 systemd-user-ru
[330321.174240] Out of memory and no killable processes...
[330321.179658] Kernel panic - not syncing: System is deadlocked on memory
[330321.186489] CPU: 4 PID: 1 Comm: systemd Kdump: loaded Tainted: G 
        O      5.4.51-xxx #1
[330321.201038] Call trace:
[330321.203660]  dump_backtrace+0x0/0x1d0
[330321.207533]  show_stack+0x20/0x2c
[330321.211048]  dump_stack+0xe8/0x150
[330321.214656]  panic+0x18c/0x3b4
[330321.217901]  out_of_memory+0x4c0/0x6e4
[330321.221863]  __alloc_pages_nodemask+0xbdc/0x1c90
[330321.226722]  alloc_pages_current+0x21c/0x2b0
[330321.231220]  alloc_slab_page+0x1e0/0x7d8
[330321.235361]  new_slab+0x2e8/0x2f8
[330321.238874]  ___slab_alloc+0x45c/0x59c
[330321.242835]  kmem_cache_alloc+0x2d4/0x360
[330321.247065]  getname_flags+0x6c/0x2a8
[330321.250938]  user_path_at_empty+0x3c/0x68
[330321.255168]  do_readlinkat+0x7c/0x17c
[330321.259039]  __arm64_sys_readlinkat+0x5c/0x70
[330321.263627]  el0_svc_handler+0x1b8/0x32c
[330321.267767]  el0_svc+0x10/0x14
[330321.271026] SMP: stopping secondary CPUs
[330321.275382] Starting crashdump kernel...
[330321.279526] Bye!

> 
>> Then while searching I came across documented warning below.  In above
>> instance panic after OOM kills happened after 3+ days of stress run (a
>> mixure of ttcp, cpuloadgen and fio).
>>
>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/performance_tuning_guide/sect-red_hat_enterprise_linux-performance_tuning_guide-configuration_tools-configuring_system_memory_capacity
>>
>> Warning
>>
>> Extreme values can damage your system. Setting min_free_kbytes to an
>> extremely low value prevents the system from reclaiming memory, which can
>> result in system hangs and OOM-killing processes. However, setting
>> min_free_kbytes too high (for example, to 5–10% of total system memory)
>> causes the system to enter an out-of-memory state immediately, resulting in
>> the system spending too much time reclaiming memory.
> 
> The auto tuned value should never reach such a low value to cause
> problems.

The auto tuned value is incorrect post hotplug memory operation, in our 
use case memoy hot add occurs very early during boot.

Thanks,
Vijay
