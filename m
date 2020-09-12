Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29F267A15
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgILLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:46:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53676 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgILLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:45:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08CBiqu7007393;
        Sat, 12 Sep 2020 11:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=l4mURHiKjI+SrvaN8x+pKb4j8guE6NrVqWv+0/JSCDg=;
 b=DoU9vVTtM1TaOMJZkxZur7PB/wF9eiE7dKwsMBesDP/n00jboCtkgVIC7LrlgZ9V+0N5
 Mo84dHUZnYTiAABL8T2xbHFs5HKTO5TifA3tpQoVEJgoDlBP4iBco1Q1bbkrQPTtihB6
 T9nCZkll87UwJTjzfSoGdBNhWxEZW0sfkTgAiy5olmNaK9mSXqtUiJ5LG3glbvWNa7/2
 XAg37tQKAV9ylJyAOphXaf/KQOu5FBRKQXO9WoPYSPEbDpS6+1LJJFvrQ+BS06/zZLRX
 8sUrHimbE5Bwp2s3v95gdGPLH8T69a69Nl24yKXEJnVHuUTzusy5zrQkVMZK4BaPvXpd 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9kruqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Sep 2020 11:44:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08CBfEA9171412;
        Sat, 12 Sep 2020 11:44:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33gp50999v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 11:44:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08CBiWSL025714;
        Sat, 12 Sep 2020 11:44:33 GMT
Received: from [192.168.1.126] (/47.220.66.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 12 Sep 2020 04:44:32 -0700
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
To:     Chen Zhou <chenzhou10@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc:     horms@verge.net.au, robh+dt@kernel.org, arnd@arndb.de,
        nsaenzjulienne@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
References: <20200907134745.25732-1-chenzhou10@huawei.com>
From:   John Donnelly <john.p.donnelly@oracle.com>
Message-ID: <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
Date:   Sat, 12 Sep 2020 06:44:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009120115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/20 8:47 AM, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone, and fall back to
> high allocation if it fails.
> If requized size X is too large and leads to very little low memory
> in DMA zone after low allocation, the system may not work normally.
> So add a threshold and go for high allocation directly if the required
> size is too large. The value of threshold is set as the half of
> the low memory.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> This patchset contains the following nine patches:
> 0001-x86-kdump-move-CRASH_ALIGN-to-2M.patch
> 0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
> 0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
> 0004-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
> 0005-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
> 0006-arm64-kdump-reimplement-crashkernel-X.patch
> 0007-kdump-add-threshold-for-the-required-memory.patch
> 0008-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
> 0009-kdump-update-Documentation-about-crashkernel.patch
> 
> 0001-0003 are some x86 cleanups which prepares for making
> functionsreserve_crashkernel[_low]() generic.
> 
> 0004 makes functions reserve_crashkernel[_low]() generic.
> 0005-0006 reimplements crashkernel=X.
> 0007 adds threshold for the required memory.
> 0008 adds memory for devices by DT property linux,usable-memory-range.
> 0009 updates the doc.
> 
> Changes since [v11]
> - Rebased on top of 5.9-rc4.
> - Make the function reserve_crashkernel() of x86 generic.
> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> and arm64 use the generic version to reimplement crashkernel=X.
> 
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> 
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-June/020737.html__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BsfMsIet$
> [2]: https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/19__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6Bv1JxB2D$
> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BgTzrgKq$
> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6Btz3iM8F$
> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BuqcVDab$
> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6Bgdlc1Y7$
> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BsuuZ6C_$
> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6Bo4IxHqi$
> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BjlqN_6I$
> [v8]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BlBSztwY$
> [v9]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/28/73__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BoNFCNt9$
> [v10]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/2/1443__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BvfD2Ihf$
> [v11]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/8/1/150__;!!GqivPVa7Brio!IzjRTihkWj0uY8lqf60OD7rbqIAhyGD20C4EZpBaPsNfWxuPgeU1Av-fzig6BohKxmce$
> 
> Chen Zhou (9):
>    x86: kdump: move CRASH_ALIGN to 2M
>    x86: kdump: make the lower bound of crash kernel reservation
>      consistent
>    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>      reserve_crashkernel[_low]()
>    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>    arm64: kdump: introduce some macroes for crash kernel reservation
>    arm64: kdump: reimplement crashkernel=X
>    kdump: add threshold for the required memory
>    arm64: kdump: add memory for devices by DT property
>      linux,usable-memory-range
>    kdump: update Documentation about crashkernel
> 
>   Documentation/admin-guide/kdump/kdump.rst     |  25 ++-
>   .../admin-guide/kernel-parameters.txt         |  13 +-
>   arch/arm64/include/asm/kexec.h                |  15 ++
>   arch/arm64/include/asm/processor.h            |   1 +
>   arch/arm64/kernel/setup.c                     |  13 +-
>   arch/arm64/mm/init.c                          | 105 ++++------
>   arch/arm64/mm/mmu.c                           |   4 +
>   arch/x86/include/asm/kexec.h                  |  28 +++
>   arch/x86/kernel/setup.c                       | 165 +--------------
>   include/linux/crash_core.h                    |   4 +
>   include/linux/kexec.h                         |   2 -
>   kernel/crash_core.c                           | 192 ++++++++++++++++++
>   kernel/kexec_core.c                           |  17 --
>   13 files changed, 328 insertions(+), 256 deletions(-)
> 


I did a brief unit-test on 5.9-rc4.

Please add:


Tested-by:  John Donnelly <John.p.donnelly@oracle.com>


This activity is over a year old. It needs accepted.





