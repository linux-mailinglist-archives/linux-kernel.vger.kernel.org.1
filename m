Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7775228DF81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgJNLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:00:36 -0400
Received: from ozlabs.org ([203.11.71.1]:34065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJNLAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:00:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CB8b356QLz9sVJ;
        Wed, 14 Oct 2020 22:00:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1602673233;
        bh=Vx3JmOYtUix/SdmMkaEvbITbR/qCEr9HRT/SmzH1A8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RL1Y2taWEspng3Tx3sZRtL/q/b+C+B+FGfvU/a3PektPx8qsHLa7cA60mXCEC6yr1
         cX0U7CU2aXuFlsTpaoh+IWKDxbZ8OoJkRF4587p5L02N3RZ3eI9FF4P2tTscEXKYCj
         pRm4tYgRAiqXLvvbT91CdF0bjHwPZsKBJnIe5VA/JcU7YIsNvGQTFoNQtUqvM/L5Y5
         NXg8+4UcMxlG8KlyEVC3OVUJV+7leN12U9ou/iBa/SAusrG35MGe/Vj1F8/VLZJUSV
         vy/0YQz92VFw8scGOcwHIjpB2EnundOHRMfc5aFbak1V0JiiP8jVq4PG+gWxh8uCwj
         g1UPOJlg4DY2Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/features: Remove CPU_FTR_NODSISRALIGN
In-Reply-To: <7b1f7fdd-0256-3370-13ab-d808b9fe9b02@linux.ibm.com>
References: <0346768708b69bdbfec82f6e5b0364962b9b6932.1602489812.git.christophe.leroy@csgroup.eu> <875z7ea8t7.fsf@linux.ibm.com> <cb22e9a8-4a8c-38d9-66f1-24af5ebd7520@csgroup.eu> <87wnzuzb1x.fsf@mpe.ellerman.id.au> <7b1f7fdd-0256-3370-13ab-d808b9fe9b02@linux.ibm.com>
Date:   Wed, 14 Oct 2020 22:00:29 +1100
Message-ID: <87ft6hysvm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 10/13/20 3:45 PM, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 13/10/2020 =C3=A0 09:23, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>>
>>>>> CPU_FTR_NODSISRALIGN has not been used since
>>>>> commit 31bfdb036f12 ("powerpc: Use instruction emulation
>>>>> infrastructure to handle alignment faults")
>>>>>
>>>>> Remove it.
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>> ---
>>>>>    arch/powerpc/include/asm/cputable.h | 22 ++++++++++------------
>>>>>    arch/powerpc/kernel/dt_cpu_ftrs.c   |  8 --------
>>>>>    arch/powerpc/kernel/prom.c          |  2 +-
>>>>>    3 files changed, 11 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/=
dt_cpu_ftrs.c
>>>>> index 1098863e17ee..c598961d9f15 100644
>>>>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>>> @@ -273,13 +273,6 @@ static int __init feat_enable_idle_nap(struct dt=
_cpu_feature *f)
>>>>>    	return 1;
>>>>>    }
>>>>>=20=20=20=20
>>>>> -static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
>>>>> -{
>>>>> -	cur_cpu_spec->cpu_features &=3D ~CPU_FTR_NODSISRALIGN;
>>>>> -
>>>>> -	return 1;
>>>>> -}
>>>>> -
>>>>>    static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
>>>>>    {
>>>>>    	u64 lpcr;
>>>>> @@ -641,7 +634,6 @@ static struct dt_cpu_feature_match __initdata
>>>>>    	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_AS=
SIST},
>>>>>    	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
>>>>>    	{"idle-nap", feat_enable_idle_nap, 0},
>>>>> -	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
>>=20
>> Rather than removing it entirely, I'd rather we left a comment, so that
>> it's obvious that we are ignoring that feature on purpose, not because
>> we forget about it.
>>=20
>> eg:
>>=20
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_=
cpu_ftrs.c
>> index f204ad79b6b5..45cb7e59bd13 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -640,7 +640,7 @@ static struct dt_cpu_feature_match __initdata
>>   	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_ASSIST=
},
>>   	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
>>   	{"idle-nap", feat_enable_idle_nap, 0},
>> -	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
>> +	// "alignment-interrupt-dsisr" ignored
>>   	{"idle-stop", feat_enable_idle_stop, 0},
>>   	{"machine-check-power8", feat_enable_mce_power8, 0},
>>   	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
>>=20
>
>
> why not do it as
> static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
> {
> 	/* This feature should not be enabled */
> #ifdef DEBUG
> 	WARN(1);
> #endif
>
> 	return 1;
> }

No one will ever turn that #define on.
No one will ever turn the feature on either.
Even if they did, it's not a bug because the kernel doesn't use the
DSISR for alignment interrupts any more.

All I want is to be able to compare the list of features defined in
skiboot vs the ones in Linux and see that none are missing in Linux.

cheers
