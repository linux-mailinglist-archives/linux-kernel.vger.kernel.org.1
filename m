Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B7275F16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgIWRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:48:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIWRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:48:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NHckVq157118;
        Wed, 23 Sep 2020 17:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=VJPsaSlsog7RzRjpSned5XBa998d2a8H4JDAgwG6wc4=;
 b=t8TFoPBB2qdVS6eSe1NWr0RvkNzVY8OetLJoPN7YPwoHq4VtFgKby9TKhEAddZDJMvJN
 s+0Ubu4Gqb7CIikz2BZMo7otMVLQWb+0B/2xxiuCGmOOLhCT42SZFkGHtzN7YanUkTj0
 /195iqhIlCUuCSZXwdwU2LnSC0gUhRP6lJhMrSdKXHRYMnoudvzonLy5FmxMtHK0X+mG
 CPBP7QFtSExg1KuHKst+jTZlgY44sme62SjkENnbawpwyvPAIZOzFeSwj0WlAsMnCwgD
 tj3t7coqEdBPgCI12r95ih6OHdMp+kFZ53Bw9HeEMajOFgOYZ0kkQ5CNusuXnrVZ9e77 yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnukyx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 17:47:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NHeRcf042949;
        Wed, 23 Sep 2020 17:47:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurv0x7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 17:47:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08NHlCNH024133;
        Wed, 23 Sep 2020 17:47:12 GMT
Received: from dhcp-10-154-189-14.vpn.oracle.com (/10.154.189.14)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 10:47:12 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <05b1fdbb-5bb3-1345-14ac-9bf91df16aa4@huawei.com>
Date:   Wed, 23 Sep 2020 12:47:10 -0500
Cc:     catalin.marinas@arm.com, dyoung@redhat.com, will@kernel.org,
        james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bhe@redhat.com, corbet@lwn.net, prabhakar.pkin@gmail.com,
        bhsharma@redhat.com, horms@verge.net.au, robh+dt@kernel.org,
        arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FEE65CB-702C-4C79-947B-21EA8D0DEFFD@oracle.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <05b1fdbb-5bb3-1345-14ac-9bf91df16aa4@huawei.com>
To:     chenzhou <chenzhou10@huawei.com>
X-Mailer: Apple Mail (2.3445.9.5)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230135
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 15, 2020, at 2:16 AM, chenzhou <chenzhou10@huawei.com> wrote:
>=20
>=20
>=20
> On 2020/9/7 21:47, Chen Zhou wrote:
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and =
ZONE_DMA32"),
>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>> fail.
>>=20
>> To solve these issues, change the behavior of crashkernel=3DX.
>> crashkernel=3DX tries low allocation in DMA zone, and fall back to
>> high allocation if it fails.
>> If requized size X is too large and leads to very little low memory
>> in DMA zone after low allocation, the system may not work normally.
>> So add a threshold and go for high allocation directly if the =
required
>> size is too large. The value of threshold is set as the half of
>> the low memory.
>>=20
>> We can also use "crashkernel=3DX,high" to select a high region above
>> DMA zone, which also tries to allocate at least 256M low memory in
>> DMA zone automatically.
>> "crashkernel=3DY,low" can be used to allocate specified size low =
memory.
>> For non-RPi4 platforms, change DMA zone memtioned above to DMA32 =
zone.
>>=20
>> When reserving crashkernel in high memory, some low memory is =
reserved
>> for crash dump kernel devices. So there may be two regions reserved =
for
>> crash dump kernel.
>> In order to distinct from the high region and make no effect to the =
use
>> of existing kexec-tools, rename the low region as "Crash kernel =
(low)",
>> and pass the low region by reusing DT property
>> "linux,usable-memory-range". We made the low memory region as the =
last
>> range of "linux,usable-memory-range" to keep compatibility with =
existing
>> user-space and older kdump kernels.
>>=20
>> Besides, we need to modify kexec-tools:
>> arm64: support more than one crash kernel regions(see [1])
>>=20
>> Another update is document about DT property =
'linux,usable-memory-range':
>> schemas: update 'linux,usable-memory-range' node schema(see [2])
>>=20
>> This patchset contains the following nine patches:
>> 0001-x86-kdump-move-CRASH_ALIGN-to-2M.patch
>> 0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
>> 0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
>> 0004-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
>> 0005-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
>> 0006-arm64-kdump-reimplement-crashkernel-X.patch
>> 0007-kdump-add-threshold-for-the-required-memory.patch
>> 0008-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
>> 0009-kdump-update-Documentation-about-crashkernel.patch
>>=20
>> 0001-0003 are some x86 cleanups which prepares for making
>> functionsreserve_crashkernel[_low]() generic.
>>=20
>> 0004 makes functions reserve_crashkernel[_low]() generic.
>> 0005-0006 reimplements crashkernel=3DX.
>> 0007 adds threshold for the required memory.
>> 0008 adds memory for devices by DT property =
linux,usable-memory-range.
>> 0009 updates the doc.
> Hi Catalin and Dave,

  Hi,

   This patch set  has been going on since May, 2019.  When will this be =
accepted and integrated into a rc build ?

 =20



>=20
> Any other suggestions about this patchset? Let me know if you have any =
questions.
>=20
> Thanks,
> Chen Zhou
>>=20
>> Changes since [v11]
>> - Rebased on top of 5.9-rc4.
>> - Make the function reserve_crashkernel() of x86 generic.
>> Suggested by Catalin, make the function reserve_crashkernel() of x86 =
generic
>> and arm64 use the generic version to reimplement crashkernel=3DX.
>>=20
>> Changes since [v10]
>> - Reimplement crashkernel=3DX suggested by Catalin, Many thanks to =
Catalin.
>>=20
>> Changes since [v9]
>> - Patch 1 add Acked-by from Dave.
>> - Update patch 5 according to Dave's comments.
>> - Update chosen schema.
>>=20
>> Changes since [v8]
>> - Reuse DT property "linux,usable-memory-range".
>> Suggested by Rob, reuse DT property "linux,usable-memory-range" to =
pass the low
>> memory region.
>> - Fix kdump broken with ZONE_DMA reintroduced.
>> - Update chosen schema.
>>=20
>> Changes since [v7]
>> - Move x86 CRASH_ALIGN to 2M
>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
>> - Update Documentation/devicetree/bindings/chosen.txt.
>> Add corresponding documentation to =
Documentation/devicetree/bindings/chosen.txt
>> suggested by Arnd.
>> - Add Tested-by from Jhon and pk.
>>=20
>> Changes since [v6]
>> - Fix build errors reported by kbuild test robot.
>>=20
>> Changes since [v5]
>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>> - Delete crashkernel=3DX,high.
>> - Modify crashkernel=3DX,low.
>> If crashkernel=3DX,low is specified simultaneously, reserve spcified =
size low
>> memory for crash kdump kernel devices firstly and then reserve memory =
above 4G.
>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, =
and then
>> pass to crash dump kernel by DT property "linux,low-memory-range".
>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>=20
>> Changes since [v4]
>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>=20
>> Changes since [v3]
>> - Add memblock_cap_memory_ranges back for multiple ranges.
>> - Fix some compiling warnings.
>>=20
>> Changes since [v2]
>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" =
as
>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a =
separate
>> patch.
>>=20
>> Changes since [v1]:
>> - Move common reserve_crashkernel_low() code into =
kernel/kexec_core.c.
>> - Remove memblock_cap_memory_ranges() i added in v1 and implement =
that
>> in fdt_enforce_memory_region().
>> There are at most two crash kernel regions, for two crash kernel =
regions
>> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>> and then remove the memory range in the middle.
>>=20
>> [1]: =
https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/202=
0-June/020737.html__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0=
WkR6OxQ0trzzeR2zyIkUM8_zMCI6U-$=20
>> [2]: =
https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/1=
9__;!!GqivPVa7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zy=
IkUM8_5c9NEUf$ =20
>> [v1]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_1bFn-e=
N$=20
>> [v2]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7=
Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_wVqWygD$=
=20
>> [v3]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa=
7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_8fQ7uBl=
$=20
>> [v4]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_ztbOBK=
M$=20
>> [v5]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_9TAk7O=
j$=20
>> [v6]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_9IFx5H=
x$=20
>> [v7]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivP=
Va7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_0x8im=
8q$=20
>> [v8]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_yVVP42=
e$=20
>> [v9]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/28/73__;!!GqivPVa=
7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_y2-BLN1=
$=20
>> [v10]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/2/1443__;!!GqivPV=
a7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_0qJHLG=
R$=20
>> [v11]: =
https://urldefense.com/v3/__https://lkml.org/lkml/2020/8/1/150__;!!GqivPVa=
7Brio!JI57eED82U9Uq1k8V_Kus7azGGPSDqfaSZPHM0WkR6OxQ0trzzeR2zyIkUM8_3QitPUY=
$=20
>>=20
>> Chen Zhou (9):
>>  x86: kdump: move CRASH_ALIGN to 2M
>>  x86: kdump: make the lower bound of crash kernel reservation
>>    consistent
>>  x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>>    reserve_crashkernel[_low]()
>>  x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>>  arm64: kdump: introduce some macroes for crash kernel reservation
>>  arm64: kdump: reimplement crashkernel=3DX
>>  kdump: add threshold for the required memory
>>  arm64: kdump: add memory for devices by DT property
>>    linux,usable-memory-range
>>  kdump: update Documentation about crashkernel
>>=20
>> Documentation/admin-guide/kdump/kdump.rst     |  25 ++-
>> .../admin-guide/kernel-parameters.txt         |  13 +-
>> arch/arm64/include/asm/kexec.h                |  15 ++
>> arch/arm64/include/asm/processor.h            |   1 +
>> arch/arm64/kernel/setup.c                     |  13 +-
>> arch/arm64/mm/init.c                          | 105 ++++------
>> arch/arm64/mm/mmu.c                           |   4 +
>> arch/x86/include/asm/kexec.h                  |  28 +++
>> arch/x86/kernel/setup.c                       | 165 +--------------
>> include/linux/crash_core.h                    |   4 +
>> include/linux/kexec.h                         |   2 -
>> kernel/crash_core.c                           | 192 =
++++++++++++++++++
>> kernel/kexec_core.c                           |  17 --
>> 13 files changed, 328 insertions(+), 256 deletions(-)

