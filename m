Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5A528CB72
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgJMKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:15:46 -0400
Received: from ozlabs.org ([203.11.71.1]:39281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJMKPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:15:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C9Wdp0WCgz9sVH;
        Tue, 13 Oct 2020 21:15:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1602584142;
        bh=SQPNY+N9Jz8DH/0ADaruUwdPNuZlX8z+oBbq3gOlFTg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KMycuC8kT6PHLlYV79o7xJsj3BgonMFxzrXRX5HLu1IB6bKup+zZ7BZigT6Vy8pAs
         sJnjApueZWxgymV6aWQW16fzi6xUahpkQBRBukKizq0TtOq0VQFU/+TTMugeOPlD+T
         Y33c2nz2s0jxYhsvVCMlfhvkItZE19O7BS5ZqjO2YrJkwzyBw2yo5cwm9g7jMKz8WA
         9fgFerkIIzcmBQc2jsHW11hilGANJKSiwpOGxdF4uIscWPmERVHHBbnucPZqz/n+3O
         cKpP9rcWnYtOprDjYxqxpT6XCy8bAmlASMd+RuSCfysuHZwg8jseuzvDKpgKRTQs6E
         Ox2tsVl8+z0pQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/features: Remove CPU_FTR_NODSISRALIGN
In-Reply-To: <cb22e9a8-4a8c-38d9-66f1-24af5ebd7520@csgroup.eu>
References: <0346768708b69bdbfec82f6e5b0364962b9b6932.1602489812.git.christophe.leroy@csgroup.eu> <875z7ea8t7.fsf@linux.ibm.com> <cb22e9a8-4a8c-38d9-66f1-24af5ebd7520@csgroup.eu>
Date:   Tue, 13 Oct 2020 21:15:38 +1100
Message-ID: <87wnzuzb1x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 13/10/2020 =C3=A0 09:23, Aneesh Kumar K.V a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>=20
>>> CPU_FTR_NODSISRALIGN has not been used since
>>> commit 31bfdb036f12 ("powerpc: Use instruction emulation
>>> infrastructure to handle alignment faults")
>>>
>>> Remove it.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/include/asm/cputable.h | 22 ++++++++++------------
>>>   arch/powerpc/kernel/dt_cpu_ftrs.c   |  8 --------
>>>   arch/powerpc/kernel/prom.c          |  2 +-
>>>   3 files changed, 11 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt=
_cpu_ftrs.c
>>> index 1098863e17ee..c598961d9f15 100644
>>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>> @@ -273,13 +273,6 @@ static int __init feat_enable_idle_nap(struct dt_c=
pu_feature *f)
>>>   	return 1;
>>>   }
>>>=20=20=20
>>> -static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
>>> -{
>>> -	cur_cpu_spec->cpu_features &=3D ~CPU_FTR_NODSISRALIGN;
>>> -
>>> -	return 1;
>>> -}
>>> -
>>>   static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
>>>   {
>>>   	u64 lpcr;
>>> @@ -641,7 +634,6 @@ static struct dt_cpu_feature_match __initdata
>>>   	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_ASSIS=
T},
>>>   	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
>>>   	{"idle-nap", feat_enable_idle_nap, 0},
>>> -	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},

Rather than removing it entirely, I'd rather we left a comment, so that
it's obvious that we are ignoring that feature on purpose, not because
we forget about it.

eg:

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu=
_ftrs.c
index f204ad79b6b5..45cb7e59bd13 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -640,7 +640,7 @@ static struct dt_cpu_feature_match __initdata
 	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_ASSIST},
 	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
 	{"idle-nap", feat_enable_idle_nap, 0},
-	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
+	// "alignment-interrupt-dsisr" ignored
 	{"idle-stop", feat_enable_idle_stop, 0},
 	{"machine-check-power8", feat_enable_mce_power8, 0},
 	{"performance-monitor-power8", feat_enable_pmu_power8, 0},


>>>   	{"idle-stop", feat_enable_idle_stop, 0},
>>>   	{"machine-check-power8", feat_enable_mce_power8, 0},
>>>   	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>> index c1545f22c077..a5a5acb627fe 100644
>>> --- a/arch/powerpc/kernel/prom.c
>>> +++ b/arch/powerpc/kernel/prom.c
>>> @@ -165,7 +165,7 @@ static struct ibm_pa_feature {
>>>   #ifdef CONFIG_PPC_RADIX_MMU
>>>   	{ .pabyte =3D 40, .pabit =3D 0, .mmu_features  =3D MMU_FTR_TYPE_RADI=
X | MMU_FTR_GTSE },
>>>   #endif
>>> -	{ .pabyte =3D 1,  .pabit =3D 1, .invert =3D 1, .cpu_features =3D CPU_=
FTR_NODSISRALIGN },
>>> +	{ .pabyte =3D 1,  .pabit =3D 1, .invert =3D 1, },
>>>   	{ .pabyte =3D 5,  .pabit =3D 0, .cpu_features  =3D CPU_FTR_REAL_LE,
>>>   				    .cpu_user_ftrs =3D PPC_FEATURE_TRUE_LE },
>>=20
>> I didn't follow this change. Should the line be dropped?
>>=20
>
> Don't know. I have to look closer, I don't know what it is used for.

All it does is clear the CPU feature if firmware tells us to. So if
we're dropping the CPU feature we can drop the whole entry in the
feature array.

cheers
