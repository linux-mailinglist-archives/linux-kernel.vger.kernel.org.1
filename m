Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1B21EEF7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 22:27:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42848 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFEC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:27:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0552N2v9142349;
        Fri, 5 Jun 2020 02:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wdeB5119u9iA1IBe8RssEvLkU/r71Lzx0CyDZ+vyn7M=;
 b=fAsDWM1S6NAXuvfj4b8Iiq+Pel6WhM48a2DcYNSpt3RuioVKKKRR6GaP4DZ0hLStwHg4
 E7pA/XcWegPyuP6tuReap/k/sDGKOfmaGNPISznC0EJGRar579c77lhKFy3PuPUaL67u
 G0zt0V5UyCiu/l07QOTdAKRGm20hmD69cAu0ciWVSxiOqJ6DuOaX1E+rUUj4t2ItJWKh
 VfCWY1cdKl4SZvBCDoDtmOKxJMIFT9RWT2x6MOe9sePyYFVb4mFdP5GAFVj0lMvGNApo
 HAqRq9JikuxYtwdBFscDa9EYEbBzvzQIqH5CfspN3C0dbV2U0oYX1jneEh84Vr7GUhiy +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31f9260m5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 02:26:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0552NbHD045654;
        Fri, 5 Jun 2020 02:26:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31f924rbbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 02:26:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0552QBId002547;
        Fri, 5 Jun 2020 02:26:11 GMT
Received: from [192.168.1.106] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 19:26:10 -0700
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     chenzhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Devicetree List <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        guohanjun@huawei.com,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        James Morse <james.morse@arm.com>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        RuiRui Yang <dyoung@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com>
 <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
 <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com>
 <CAJ2QiJJE-jeRL1HPUZCwi1LtV9CBMmYrsOaS6vX1R1sJ6Z1t8g@mail.gmail.com>
 <6EA47B07-5119-49DF-9980-12A2066F22CA@oracle.com>
 <CAJ2QiJJhUCnobrMHui5=6zLzgy3KsoPxrqiH_oYT8Jhb5MkmbA@mail.gmail.com>
 <8463464e-5461-f328-621c-bacc6a3b88dd@huawei.com>
 <8E0D45DC-12BF-437D-A342-03E974D9C6D4@oracle.com>
 <CACi5LpN-+NRnaDoWWWidbzma8BNzmofA5FQBV=cPF1Mc84FpFg@mail.gmail.com>
 <751bbe2512628ff38002db33ce02af051d080cd2.camel@suse.de>
From:   John Donnelly <John.P.donnelly@oracle.com>
Message-ID: <de6c7c59-89d2-5b2e-d7ba-50403c4bcaf2@oracle.com>
Date:   Thu, 4 Jun 2020 21:26:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <751bbe2512628ff38002db33ce02af051d080cd2.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/4/20 12:01 PM, Nicolas Saenz Julienne wrote:
> On Thu, 2020-06-04 at 01:17 +0530, Bhupesh Sharma wrote:
>> Hi All,
>>
>> On Wed, Jun 3, 2020 at 9:03 PM John Donnelly <john.p.donnelly@oracle.com>
>> wrote:
>>>
>>>> On Jun 3, 2020, at 8:20 AM, chenzhou <chenzhou10@huawei.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>>
>>>> On 2020/6/3 19:47, Prabhakar Kushwaha wrote:
>>>>> Hi Chen,
>>>>>
>>>>> On Tue, Jun 2, 2020 at 8:12 PM John Donnelly <john.p.donnelly@oracle.com
>>>>>> wrote:
>>>>>>
>>>>>>> On Jun 2, 2020, at 12:38 AM, Prabhakar Kushwaha <
>>>>>>> prabhakar.pkin@gmail.com> wrote:
>>>>>>>
>>>>>>> On Tue, Jun 2, 2020 at 3:29 AM John Donnelly <
>>>>>>> john.p.donnelly@oracle.com> wrote:
>>>>>>>> Hi .  See below !
>>>>>>>>
>>>>>>>>> On Jun 1, 2020, at 4:02 PM, Bhupesh Sharma <bhsharma@redhat.com>
>>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Hi John,
>>>>>>>>>
>>>>>>>>> On Tue, Jun 2, 2020 at 1:01 AM John Donnelly <
>>>>>>>>> John.P.donnelly@oracle.com> wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 6/1/20 7:02 AM, Prabhakar Kushwaha wrote:
>>>>>>>>>>> Hi Chen,
>>>>>>>>>>>
>>>>>>>>>>> On Thu, May 21, 2020 at 3:05 PM Chen Zhou <
>>>>>>>>>>> chenzhou10@huawei.com> wrote:
>>>>>>>>>>>> This patch series enable reserving crashkernel above 4G in
>>>>>>>>>>>> arm64.
>>>>>>>>>>>>
>>>>>>>>>>>> There are following issues in arm64 kdump:
>>>>>>>>>>>> 1. We use crashkernel=X to reserve crashkernel below 4G,
>>>>>>>>>>>> which will fail
>>>>>>>>>>>> when there is no enough low memory.
>>>>>>>>>>>> 2. Currently, crashkernel=Y@X can be used to reserve
>>>>>>>>>>>> crashkernel above 4G,
>>>>>>>>>>>> in this case, if swiotlb or DMA buffers are required,
>>>>>>>>>>>> crash dump kernel
>>>>>>>>>>>> will boot failure because there is no low memory available
>>>>>>>>>>>> for allocation.
>>>>>>>>>>>>
>>>>>>>>>>> We are getting "warn_alloc" [1] warning during boot of kdump
>>>>>>>>>>> kernel
>>>>>>>>>>> with bootargs as [2] of primary kernel.
>>>>>>>>>>> This error observed on ThunderX2  ARM64 platform.
>>>>>>>>>>>
>>>>>>>>>>> It is observed with latest upstream tag (v5.7-rc3) with this
>>>>>>>>>>> patch set
>>>>>>>>>>> and
>>>>>>>>>>>
> https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbiIAAlzu$
>>>>>>>>>>> Also **without** this patch-set
>>>>>>>>>>> "
>>>>>>>>>>>
> https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbjC6ujMA$
>>>>>>>>>>> "
>>>>>>>>>>>
>>>>>>>>>>> This issue comes whenever crashkernel memory is reserved
>>>>>>>>>>> after 0xc000_0000.
>>>>>>>>>>> More details discussed earlier in
>>>>>>>>>>>
> https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg806882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbjC6ujMA$
>    without
>>>>>>>>>>> any
>>>>>>>>>>> solution
>>>>>>>>>>>
>>>>>>>>>>> This patch-set is expected to solve similar kind of issue.
>>>>>>>>>>> i.e. low memory is only targeted for DMA, swiotlb; So above
>>>>>>>>>>> mentioned
>>>>>>>>>>> observation should be considered/fixed. .
>>>>>>>>>>>
>>>>>>>>>>> --pk
>>>>>>>>>>>
>>>>>>>>>>> [1]
>>>>>>>>>>> [   30.366695] DMI: Cavium Inc. Saber/Saber, BIOS
>>>>>>>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>>>>>>>>>> [   30.367696] NET: Registered protocol family 16
>>>>>>>>>>> [   30.369973] swapper/0: page allocation failure: order:6,
>>>>>>>>>>> mode:0x1(GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>>>>>>>>>>> [   30.369980] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
>>>>>>>>>>> 5.7.0-rc3+ #121
>>>>>>>>>>> [   30.369981] Hardware name: Cavium Inc. Saber/Saber, BIOS
>>>>>>>>>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>>>>>>>>>> [   30.369984] Call trace:
>>>>>>>>>>> [   30.369989]  dump_backtrace+0x0/0x1f8
>>>>>>>>>>> [   30.369991]  show_stack+0x20/0x30
>>>>>>>>>>> [   30.369997]  dump_stack+0xc0/0x10c
>>>>>>>>>>> [   30.370001]  warn_alloc+0x10c/0x178
>>>>>>>>>>> [   30.370004]  __alloc_pages_slowpath.constprop.111+0xb10/0
>>>>>>>>>>> xb50
>>>>>>>>>>> [   30.370006]  __alloc_pages_nodemask+0x2b4/0x300
>>>>>>>>>>> [   30.370008]  alloc_page_interleave+0x24/0x98
>>>>>>>>>>> [   30.370011]  alloc_pages_current+0xe4/0x108
>>>>>>>>>>> [   30.370017]  dma_atomic_pool_init+0x44/0x1a4
>>>>>>>>>>> [   30.370020]  do_one_initcall+0x54/0x228
>>>>>>>>>>> [   30.370027]  kernel_init_freeable+0x228/0x2cc
>>>>>>>>>>> [   30.370031]  kernel_init+0x1c/0x110
>>>>>>>>>>> [   30.370034]  ret_from_fork+0x10/0x18
>>>>>>>>>>> [   30.370036] Mem-Info:
>>>>>>>>>>> [   30.370064] active_anon:0 inactive_anon:0 isolated_anon:0
>>>>>>>>>>> [   30.370064]  active_file:0 inactive_file:0
>>>>>>>>>>> isolated_file:0
>>>>>>>>>>> [   30.370064]  unevictable:0 dirty:0 writeback:0 unstable:0
>>>>>>>>>>> [   30.370064]  slab_reclaimable:34 slab_unreclaimable:4438
>>>>>>>>>>> [   30.370064]  mapped:0 shmem:0 pagetables:14 bounce:0
>>>>>>>>>>> [   30.370064]  free:1537719 free_pcp:219 free_cma:0
>>>>>>>>>>> [   30.370070] Node 0 active_anon:0kB inactive_anon:0kB
>>>>>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB
>>>>>>>>>>> isolated(anon):0kB
>>>>>>>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB
>>>>>>>>>>> shmem:0kB
>>>>>>>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
>>>>>>>>>>> writeback_tmp:0kB
>>>>>>>>>>> unstable:0kB all_unreclaimable? no
>>>>>>>>>>> [   30.370073] Node 1 active_anon:0kB inactive_anon:0kB
>>>>>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB
>>>>>>>>>>> isolated(anon):0kB
>>>>>>>>>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB
>>>>>>>>>>> shmem:0kB
>>>>>>>>>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
>>>>>>>>>>> writeback_tmp:0kB
>>>>>>>>>>> unstable:0kB all_unreclaimable? no
>>>>>>>>>>> [   30.370079] Node 0 DMA free:0kB min:0kB low:0kB high:0kB
>>>>>>>>>>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>>>>>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB
>>>>>>>>>>> writepending:0kB
>>>>>>>>>>> present:128kB managed:0kB mlocked:0kB kernel_stack:0kB
>>>>>>>>>>> pagetables:0kB
>>>>>>>>>>> bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>>>>>>>>>>> [   30.370084] lowmem_reserve[]: 0 250 6063 6063
>>>>>>>>>>> [   30.370090] Node 0 DMA32 free:256000kB min:408kB
>>>>>>>>>>> low:664kB
>>>>>>>>>>> high:920kB reserved_highatomic:0KB active_anon:0kB
>>>>>>>>>>> inactive_anon:0kB
>>>>>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB
>>>>>>>>>>> writepending:0kB
>>>>>>>>>>> present:269700kB managed:256000kB mlocked:0kB
>>>>>>>>>>> kernel_stack:0kB
>>>>>>>>>>> pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
>>>>>>>>>>> free_cma:0kB
>>>>>>>>>>> [   30.370094] lowmem_reserve[]: 0 0 5813 5813
>>>>>>>>>>> [   30.370100] Node 0 Normal free:5894876kB min:9552kB
>>>>>>>>>>> low:15504kB
>>>>>>>>>>> high:21456kB reserved_highatomic:0KB active_anon:0kB
>>>>>>>>>>> inactive_anon:0kB
>>>>>>>>>>> active_file:0kB inactive_file:0kB unevictable:0kB
>>>>>>>>>>> writepending:0kB
>>>>>>>>>>> present:8388608kB managed:5953112kB mlocked:0kB
>>>>>>>>>>> kernel_stack:21672kB
>>>>>>>>>>> pagetables:56kB bounce:0kB free_pcp:876kB local_pcp:176kB
>>>>>>>>>>> free_cma:0kB
>>>>>>>>>>> [   30.370104] lowmem_reserve[]: 0 0 0 0
>>>>>>>>>>> [   30.370107] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB
>>>>>>>>>>> 0*128kB
>>>>>>>>>>> 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
>>>>>>>>>>> [   30.370113] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB
>>>>>>>>>>> 0*64kB 0*128kB
>>>>>>>>>>> 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 62*4096kB (M) =
>>>>>>>>>>> 256000kB
>>>>>>>>>>> [   30.370119] Node 0 Normal: 2*4kB (M) 3*8kB (ME) 2*16kB
>>>>>>>>>>> (UE) 3*32kB
>>>>>>>>>>> (UM) 1*64kB (U) 2*128kB (M) 2*256kB (ME) 3*512kB (ME)
>>>>>>>>>>> 3*1024kB (ME)
>>>>>>>>>>> 3*2048kB (UME) 1436*4096kB (M) = 5893600kB
>>>>>>>>>>> [   30.370129] Node 0 hugepages_total=0 hugepages_free=0
>>>>>>>>>>> hugepages_surp=0 hugepages_size=1048576kB
>>>>>>>>>>> [   30.370130] 0 total pagecache pages
>>>>>>>>>>> [   30.370132] 0 pages in swap cache
>>>>>>>>>>> [   30.370134] Swap cache stats: add 0, delete 0, find 0/0
>>>>>>>>>>> [   30.370135] Free swap  = 0kB
>>>>>>>>>>> [   30.370136] Total swap = 0kB
>>>>>>>>>>> [   30.370137] 2164609 pages RAM
>>>>>>>>>>> [   30.370139] 0 pages HighMem/MovableOnly
>>>>>>>>>>> [   30.370140] 612331 pages reserved
>>>>>>>>>>> [   30.370141] 0 pages hwpoisoned
>>>>>>>>>>> [   30.370143] DMA: failed to allocate 256 KiB pool for
>>>>>>>>>>> atomic
>>>>>>>>>>> coherent allocation
>>>>>>>>>> During my testing I saw the same error and Chen's  solution
>>>>>>>>>> corrected it .
>>>>>>>>> Which combination you are using on your side? I am using
>>>>>>>>> Prabhakar's
>>>>>>>>> suggested environment and can reproduce the issue
>>>>>>>>> with or without Chen's crashkernel support above 4G patchset.
>>>>>>>>>
>>>>>>>>> I am also using a ThunderX2 platform with latest makedumpfile
>>>>>>>>> code and
>>>>>>>>> kexec-tools (with the suggested patch
>>>>>>>>> <
>>>>>>>>>
> https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!J6lUig58-Gw6TKZnEEYzEeSU36T-1SqlB1kImU00xtX_lss5Tx-JbUmLE9TJC3foXBLg$
>>>>>>>>>> ).
>>>>>>>>> Thanks,
>>>>>>>>> Bhupesh
>>>>>>>> I did this activity 5 months ago and I have moved on to other
>>>>>>>> activities. My DMA failures were related to PCI devices that could
>>>>>>>> not be enumerated because  low-DMA space was not  available when
>>>>>>>> crashkernel was moved above 4G; I don’t recall the exact platform.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> For this failure ,
>>>>>>>>
>>>>>>>>>>> DMA: failed to allocate 256 KiB pool for atomic
>>>>>>>>>>> coherent allocation
>>>>>>>> Is due to :
>>>>>>>>
>>>>>>>>
>>>>>>>> 3618082c
>>>>>>>> ("arm64 use both ZONE_DMA and ZONE_DMA32")
>>>>>>>>
>>>>>>>> With the introduction of ZONE_DMA to support the Raspberry DMA
>>>>>>>> region below 1G, the crashkernel is placed in the upper 4G
>>>>>>>> ZONE_DMA_32 region. Since the crashkernel does not have access
>>>>>>>> to the ZONE_DMA region, it prints out call trace during bootup.
>>>>>>>>
>>>>>>>> It is due to having this CONFIG item  ON  :
>>>>>>>>
>>>>>>>>
>>>>>>>> CONFIG_ZONE_DMA=y
>>>>>>>>
>>>>>>>> Turning off ZONE_DMA fixes a issue and Raspberry PI 4 will
>>>>>>>> use the device tree to specify memory below 1G.
>>>>>>>>
>>>>>>>>
>>>>>>> Disabling ZONE_DMA is temporary solution.  We may need proper
>>>>>>> solution
>>>>>> Perhaps the Raspberry platform configuration dependencies need
>>>>>> separated  from “server class” Arm  equipment ?  Or auto-configured on
>>>>>> boot ?  Consult an expert ;-)
>>>>>>
>>>>>>
>>>>>>
>>>>>>>> I would like to see Chen’s feature added , perhaps as
>>>>>>>> EXPERIMENTAL,  so we can get some configuration testing done on
>>>>>>>> it.   It corrects having a DMA zone in low memory while crash-
>>>>>>>> kernel is above 4GB.  This has been going on for a year now.
>>>>>>> I will also like this patch to be added in Linux as early as
>>>>>>> possible.
>>>>>>>
>>>>>>> Issue mentioned by me happens with or without this patch.
>>>>>>>
>>>>>>> This patch-set can consider fixing because it uses low memory for
>>>>>>> DMA
>>>>>>> & swiotlb only.
>>>>>>> We can consider restricting crashkernel within the required range
>>>>>>> like below
>>>>>>>
>>>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>>>> index 7f9e5a6dc48c..bd67b90d35bd 100644
>>>>>>> --- a/kernel/crash_core.c
>>>>>>> +++ b/kernel/crash_core.c
>>>>>>> @@ -354,7 +354,7 @@ int __init reserve_crashkernel_low(void)
>>>>>>>                        return 0;
>>>>>>>        }
>>>>>>>
>>>>>>> -       low_base = memblock_find_in_range(0, 1ULL << 32, low_size,
>>>>>>> CRASH_ALIGN);
>>>>>>> +       low_base = memblock_find_in_range(0,0xc0000000, low_size,
>>>>>>> CRASH_ALIGN);
>>>>>>>        if (!low_base) {
>>>>>>>                pr_err("Cannot reserve %ldMB crashkernel low memory,
>>>>>>> please try smaller size.\n",
>>>>>>>                       (unsigned long)(low_size >> 20));
>>>>>>>
>>>>>>>
>>>>>>     I suspect  0xc0000000  would need to be a CONFIG item  and not
>>>>>> hard-coded.
>>>>>>
>>>>> if you consider this as valid change,  can you please incorporate as
>>>>> part of your patch-set.
>>>> After commit 1a8e1cef7 ("arm64: use both ZONE_DMA and ZONE_DMA32")，the 0-
>>>> 4G memory is splited
>>>> to DMA [mem 0x0000000000000000-0x000000003fffffff] and DMA32 [mem
>>>> 0x0000000040000000-0x00000000ffffffff] on arm64.
>>>>
>>>>  From the above discussion, on your platform, the low crashkernel fall in
>>>> DMA32 region, but your environment needs to access DMA
>>>> region, so there is the call trace.
>>>>
>>>> I have a question, why do you choose 0xc0000000 here?
>>>>
>>>> Besides, this is common code, we also need to consider about x86.
>>>>
>>>   + nsaenzjulienne@suse.de
> Thanks for adding me to the conversation, and sorry for the headaches.
>
>>>    Exactly .  This is why it needs to be a CONFIG option for  Raspberry
>>> ..,  or device tree option.
>>>
>>>
>>>    We could revert 1a8e1cef7 since it broke  Arm kdump too.
>> Well, unfortunately the patch for commit 1a8e1cef7603 ("arm64: use
>> both ZONE_DMA and ZONE_DMA32") was not Cc'ed to the kexec mailing
>> list, thus we couldn't get many eyes on it for a thorough review from
>> kexec/kdump p-o-v.
>>
>> Also we historically never had distinction in common arch code on the
>> basis of the intended end use-case: embedded, server or automotive, so
>> I am not sure introducing a Raspberry specific CONFIG option would be
>> a good idea.
> +1
>
>  From the distros perspective it's very important to keep a single kernel image.
>
>> So, rather than reverting the patch, we can look at addressing the
>> same properly this time - especially from a kdump p-o-v.
>> This issue has been reported by some Red Hat arm64 partners with
>> upstream kernel also and as we have noticed in the past as well,
>> hardcoding the placement of the crashkernel base address (unless the
>> base address is specified by a crashkernel=X@Y like bootargs) is also
>> not a portable suggestion.
>>
>> I am working on a possible fix and will have more updates on the same
>> in a day-or-two.
> Please keep me in the loop, we've also had issues pointing to this reported by
> SUSE partners. I can do some testing both on the RPi4 and on big servers that
> need huge crashkernel sizes.
>
> Regards,
> Nicolas
>
Hi Nicolas,


You want want to review this topic with the various email threads . It 
has been a long journey.



[1]:https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-May/025128.html__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJwQs3C4x$  
[v1]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ6e-mIEp$  
[v2]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJyUVjUta$  
[v3]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ3CXBRdT$  
[v4]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ7SxW1Vj$  
[v5]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ2wyJ9tj$  
[v6]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJzvGhWBh$  
[v7]:https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!NHQIQVbVz5bR1SSP7U7SwT3uHb6OnycPGa6nM0oLTaQdZT4pjRsjrMjn5GqOJ6pAg6tX$  

Chen Zhou (5):
   x86: kdump: move reserve_crashkernel_low() into crash_core.c
   arm64: kdump: reserve crashkenel above 4G for crash dump kernel
   arm64: kdump: add memory for devices by DT property, low-memory-range
   kdump: update Documentation about crashkernel on arm64
   dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump

  Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
  .../admin-guide/kernel-parameters.txt         | 12 ++-
  Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
  arch/arm64/kernel/setup.c                     |  8 +-
  arch/arm64/mm/init.c                          | 61 ++++++++++++-
  arch/x86/kernel/setup.c                       | 66 ++------------
  include/linux/crash_core.h                    |  3 +
  include/linux/kexec.h                         |  2 -
  kernel/crash_core.c                           | 85 +++++++++++++++++++
  kernel/kexec_core.c                           | 17 ----
  10 files changed, 208 insertions(+), 84 deletions(-)

-- 
2.20.1


