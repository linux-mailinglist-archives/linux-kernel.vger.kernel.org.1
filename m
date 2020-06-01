Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA77E1EB16E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgFAV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:59:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgFAV7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:59:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051LvqL6109636;
        Mon, 1 Jun 2020 21:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=h7KFzIKQk9wBseW2QkNgl1tpKnkB5r7VZ+cTH50tGkU=;
 b=BRUlSwmwI4afd6ZLHDR+g9bDk1X1Zlzgc2JS8+cfUaj9d7+FEz9rl1YqQc2H7IV1c99p
 Yr9v2z8SVPT3aDR9bHSSpzyLOuXmxAlY1D1wFEecBPOX+VfkPPIB8DHVSjI3sxpv4tuR
 usvQSlxiuJlMsNIy0suerjjiQPOZxbEMj33gyiAuXgJg7MWlqqh5AirvrjGieq68Todl
 Tcg88Xxs6U4WHgyuX42H/UEIpC+XmcGMMABf983N4GhqYv1Y1L07WjjEzd4XOcPnIhJS
 /VQjyivdUu337DiSHR2JWPHaPzdJh0pEmMsVF9SPIk+obS3TVFp69uoSUaxxctObOimv PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewqs1xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 21:59:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 051LvsLe086842;
        Mon, 1 Jun 2020 21:59:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31c25kve0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 21:59:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 051Lx4Kw026997;
        Mon, 1 Jun 2020 21:59:04 GMT
Received: from dhcp-10-154-163-168.vpn.oracle.com (/10.154.163.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 14:59:04 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
Date:   Mon, 1 Jun 2020 16:59:01 -0500
Cc:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Devicetree List <devicetree@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        guohanjun@huawei.com, James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        RuiRui Yang <dyoung@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F64A309C-B9C0-45F2-A50D-D677005C33A6@oracle.com>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <CAJ2QiJ+1Hj2OQzpR5CfvLGMfTTbXAST94hsbfm0VcDmJKV3WTw@mail.gmail.com>
 <303695cc-d3ea-9f51-1489-07d27d4253d4@oracle.com>
 <CACi5LpOZzdfEKUYAfYxtgeUbk9K6YFVUKLaGS8XoS0kForjH9A@mail.gmail.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=1 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9639 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=1 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi .  See below !=20

> On Jun 1, 2020, at 4:02 PM, Bhupesh Sharma <bhsharma@redhat.com> =
wrote:
>=20
> Hi John,
>=20
> On Tue, Jun 2, 2020 at 1:01 AM John Donnelly =
<John.P.donnelly@oracle.com> wrote:
>>=20
>> Hi,
>>=20
>>=20
>> On 6/1/20 7:02 AM, Prabhakar Kushwaha wrote:
>>> Hi Chen,
>>>=20
>>> On Thu, May 21, 2020 at 3:05 PM Chen Zhou <chenzhou10@huawei.com> =
wrote:
>>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>>=20
>>>> There are following issues in arm64 kdump:
>>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which =
will fail
>>>> when there is no enough low memory.
>>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel =
above 4G,
>>>> in this case, if swiotlb or DMA buffers are required, crash dump =
kernel
>>>> will boot failure because there is no low memory available for =
allocation.
>>>>=20
>>>> To solve these issues, introduce crashkernel=3DX,low to reserve =
specified
>>>> size low memory.
>>>> Crashkernel=3DX tries to reserve memory for the crash dump kernel =
under
>>>> 4G. If crashkernel=3DY,low is specified simultaneously, reserve =
spcified
>>>> size low memory for crash kdump kernel devices firstly and then =
reserve
>>>> memory above 4G.
>>>>=20
>>>> When crashkernel is reserved above 4G in memory, that is, =
crashkernel=3DX,low
>>>> is specified simultaneously, kernel should reserve specified size =
low memory
>>>> for crash dump kernel devices. So there may be two crash kernel =
regions, one
>>>> is below 4G, the other is above 4G.
>>>> In order to distinct from the high region and make no effect to the =
use of
>>>> kexec-tools, rename the low region as "Crash kernel (low)", and add =
DT property
>>>> "linux,low-memory-range" to crash dump kernel's dtb to pass the low =
region.
>>>>=20
>>>> Besides, we need to modify kexec-tools:
>>>> arm64: kdump: add another DT property to crash dump kernel's =
dtb(see [1])
>>>>=20
>>>> The previous changes and discussions can be retrieved from:
>>>>=20
>>>> Changes since [v7]
>>>> - Move x86 CRASH_ALIGN to 2M
>>>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
>>>> - Update Documentation/devicetree/bindings/chosen.txt
>>>> Add corresponding documentation to =
Documentation/devicetree/bindings/chosen.txt suggested by Arnd.
>>>> - Add Tested-by from Jhon and pk
>>>>=20
>>>> Changes since [v6]
>>>> - Fix build errors reported by kbuild test robot.
>>>>=20
>>>> Changes since [v5]
>>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>>>> - Delete crashkernel=3DX,high.
>>>> - Modify crashkernel=3DX,low.
>>>> If crashkernel=3DX,low is specified simultaneously, reserve =
spcified size low
>>>> memory for crash kdump kernel devices firstly and then reserve =
memory above 4G.
>>>> In addition, rename crashk_low_res as "Crash kernel (low)" for =
arm64, and then
>>>> pass to crash dump kernel by DT property "linux,low-memory-range".
>>>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>>>=20
>>>> Changes since [v4]
>>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by =
Mike.
>>>>=20
>>>> Changes since [v3]
>>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>>> - Fix some compiling warnings.
>>>>=20
>>>> Changes since [v2]
>>>> - Split patch "arm64: kdump: support reserving crashkernel above =
4G" as
>>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a =
separate
>>>> patch.
>>>>=20
>>>> Changes since [v1]:
>>>> - Move common reserve_crashkernel_low() code into =
kernel/kexec_core.c.
>>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement =
that
>>>> in fdt_enforce_memory_region().
>>>> There are at most two crash kernel regions, for two crash kernel =
regions
>>>> case, we cap the memory range [min(regs[*].start), =
max(regs[*].end)]
>>>> and then remove the memory range in the middle.
>>>>=20
>>>> [1]: =
https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/202=
0-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3K=
RVqALmvSK2VmCkIPIhsaxbvpn1uM1$
>>>> [v1]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbt0xN9P=
E$
>>>> [v2]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7=
Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbub7yUQH$=

>>>> [v3]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa=
7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbnc4zPPV=
$
>>>> [v4]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbvsAsZL=
u$
>>>> [v5]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbl24n-7=
9$
>>>> [v6]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPV=
a7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbs7r8G2=
a$
>>>> [v7]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivP=
Va7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvSK2VmCkIPIhsaxbiFUH9=
0G$
>>>>=20
>>>> Chen Zhou (5):
>>>>   x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>>>   arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>>>   arm64: kdump: add memory for devices by DT property, =
low-memory-range
>>>>   kdump: update Documentation about crashkernel on arm64
>>>>   dt-bindings: chosen: Document linux,low-memory-range for arm64 =
kdump
>>>>=20
>>> We are getting "warn_alloc" [1] warning during boot of kdump kernel
>>> with bootargs as [2] of primary kernel.
>>> This error observed on ThunderX2  ARM64 platform.
>>>=20
>>> It is observed with latest upstream tag (v5.7-rc3) with this patch =
set
>>>  and =
https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/20=
20-May/025128.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3=
KRVqALmvSK2VmCkIPIhsaxbiIAAlzu$
>>> Also **without** this patch-set
>>> =
"https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg8=
06882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmv=
SK2VmCkIPIhsaxbjC6ujMA$"
>>>=20
>>> This issue comes whenever crashkernel memory is reserved after =
0xc000_0000.
>>> More details discussed earlier in
>>> =
https://urldefense.com/v3/__https://www.spinics.net/lists/arm-kernel/msg80=
6882.html__;!!GqivPVa7Brio!LnTSARkCt0V0FozR0KmqooaH5ADtdXvs3mPdP3KRVqALmvS=
K2VmCkIPIhsaxbjC6ujMA$  without any
>>> solution
>>>=20
>>> This patch-set is expected to solve similar kind of issue.
>>> i.e. low memory is only targeted for DMA, swiotlb; So above =
mentioned
>>> observation should be considered/fixed. .
>>>=20
>>> --pk
>>>=20
>>> [1]
>>> [   30.366695] DMI: Cavium Inc. Saber/Saber, BIOS
>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>> [   30.367696] NET: Registered protocol family 16
>>> [   30.369973] swapper/0: page allocation failure: order:6,
>>> mode:0x1(GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>>> [   30.369980] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc3+ =
#121
>>> [   30.369981] Hardware name: Cavium Inc. Saber/Saber, BIOS
>>> TX2-FW-Release-3.1-build_01-2803-g74253a541a mm/dd/yyyy
>>> [   30.369984] Call trace:
>>> [   30.369989]  dump_backtrace+0x0/0x1f8
>>> [   30.369991]  show_stack+0x20/0x30
>>> [   30.369997]  dump_stack+0xc0/0x10c
>>> [   30.370001]  warn_alloc+0x10c/0x178
>>> [   30.370004]  __alloc_pages_slowpath.constprop.111+0xb10/0xb50
>>> [   30.370006]  __alloc_pages_nodemask+0x2b4/0x300
>>> [   30.370008]  alloc_page_interleave+0x24/0x98
>>> [   30.370011]  alloc_pages_current+0xe4/0x108
>>> [   30.370017]  dma_atomic_pool_init+0x44/0x1a4
>>> [   30.370020]  do_one_initcall+0x54/0x228
>>> [   30.370027]  kernel_init_freeable+0x228/0x2cc
>>> [   30.370031]  kernel_init+0x1c/0x110
>>> [   30.370034]  ret_from_fork+0x10/0x18
>>> [   30.370036] Mem-Info:
>>> [   30.370064] active_anon:0 inactive_anon:0 isolated_anon:0
>>> [   30.370064]  active_file:0 inactive_file:0 isolated_file:0
>>> [   30.370064]  unevictable:0 dirty:0 writeback:0 unstable:0
>>> [   30.370064]  slab_reclaimable:34 slab_unreclaimable:4438
>>> [   30.370064]  mapped:0 shmem:0 pagetables:14 bounce:0
>>> [   30.370064]  free:1537719 free_pcp:219 free_cma:0
>>> [   30.370070] Node 0 active_anon:0kB inactive_anon:0kB
>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
>>> unstable:0kB all_unreclaimable? no
>>> [   30.370073] Node 1 active_anon:0kB inactive_anon:0kB
>>> active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB
>>> isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB
>>> shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
>>> unstable:0kB all_unreclaimable? no
>>> [   30.370079] Node 0 DMA free:0kB min:0kB low:0kB high:0kB
>>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>> present:128kB managed:0kB mlocked:0kB kernel_stack:0kB =
pagetables:0kB
>>> bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>>> [   30.370084] lowmem_reserve[]: 0 250 6063 6063
>>> [   30.370090] Node 0 DMA32 free:256000kB min:408kB low:664kB
>>> high:920kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>> present:269700kB managed:256000kB mlocked:0kB kernel_stack:0kB
>>> pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>>> [   30.370094] lowmem_reserve[]: 0 0 5813 5813
>>> [   30.370100] Node 0 Normal free:5894876kB min:9552kB low:15504kB
>>> high:21456kB reserved_highatomic:0KB active_anon:0kB =
inactive_anon:0kB
>>> active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>>> present:8388608kB managed:5953112kB mlocked:0kB kernel_stack:21672kB
>>> pagetables:56kB bounce:0kB free_pcp:876kB local_pcp:176kB =
free_cma:0kB
>>> [   30.370104] lowmem_reserve[]: 0 0 0 0
>>> [   30.370107] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
>>> 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 0kB
>>> [   30.370113] Node 0 DMA32: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB =
0*128kB
>>> 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 62*4096kB (M) =3D 256000kB
>>> [   30.370119] Node 0 Normal: 2*4kB (M) 3*8kB (ME) 2*16kB (UE) =
3*32kB
>>> (UM) 1*64kB (U) 2*128kB (M) 2*256kB (ME) 3*512kB (ME) 3*1024kB (ME)
>>> 3*2048kB (UME) 1436*4096kB (M) =3D 5893600kB
>>> [   30.370129] Node 0 hugepages_total=3D0 hugepages_free=3D0
>>> hugepages_surp=3D0 hugepages_size=3D1048576kB
>>> [   30.370130] 0 total pagecache pages
>>> [   30.370132] 0 pages in swap cache
>>> [   30.370134] Swap cache stats: add 0, delete 0, find 0/0
>>> [   30.370135] Free swap  =3D 0kB
>>> [   30.370136] Total swap =3D 0kB
>>> [   30.370137] 2164609 pages RAM
>>> [   30.370139] 0 pages HighMem/MovableOnly
>>> [   30.370140] 612331 pages reserved
>>> [   30.370141] 0 pages hwpoisoned
>>> [   30.370143] DMA: failed to allocate 256 KiB pool for atomic
>>> coherent allocation
>>=20
>>=20
>> During my testing I saw the same error and Chen's  solution corrected =
it .
>=20
> Which combination you are using on your side? I am using Prabhakar's
> suggested environment and can reproduce the issue
> with or without Chen's crashkernel support above 4G patchset.
>=20
> I am also using a ThunderX2 platform with latest makedumpfile code and
> kexec-tools (with the suggested patch
> =
<https://urldefense.com/v3/__https://lists.infradead.org/pipermail/kexec/2=
020-May/025128.html__;!!GqivPVa7Brio!J6lUig58-Gw6TKZnEEYzEeSU36T-1SqlB1kIm=
U00xtX_lss5Tx-JbUmLE9TJC3foXBLg$ >).
>=20
> Thanks,
> Bhupesh


I did this activity 5 months ago and I have moved on to other =
activities. My DMA failures were related to PCI devices that could not =
be enumerated because  low-DMA space was not  available  when =
crashkernel was moved above 4G; I don=E2=80=99t recall the exact =
platform.=20



For this failure ,=20

>>>  DMA: failed to allocate 256 KiB pool for atomic
>>> coherent allocation


Is due to :


 3618082c
 ("arm64 use both ZONE_DMA and ZONE_DMA32")

With the introduction of ZONE_DMA to support the Raspberry DMA
region below 1G, the crashkernel is placed in the upper 4G
ZONE_DMA_32 region. Since the crashkernel does not have access
to the ZONE_DMA region, it prints out call trace during bootup.

It is due to having this CONFIG item  ON  :


CONFIG_ZONE_DMA=3Dy

Turning off ZONE_DMA fixes a issue and Raspberry PI 4 will
use the device tree to specify memory below 1G.


I would like to see Chen=E2=80=99s feature added , perhaps as =
EXPERIMENTAL,  so we can get some configuration testing done on it.   It =
corrects having a DMA zone in low memory while crash-kernel is above =
4GB.  This has been going on for a year now.=20


Thank you,

John.


( Note  .. I am not on the all the kernel-dlist emails  so this won=E2=80=99=
t be seen by everyone , -  someone may have to bounce it )







