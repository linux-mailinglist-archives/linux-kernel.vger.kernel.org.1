Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8252D9715
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436612AbgLNLFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407349AbgLNLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:04:55 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD8C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:04:14 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t22so2466838pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=giOKidC9koKbUCA23vFcqUz66kzKhj7G43+rbP55W1Q=;
        b=Lq669SqvkvMuTktRXXiRsU5TldllIx3Uqe67TuFsslWmurjDTftGmgIFTCv3LM+ytt
         Oun1j+y3J28/kG6u0nO80ix5eqMOB0CFE9d0I6RTnQSaxaQAtGwYOUtnaT4Hn0sBaElp
         8c/lJFLeHxsEfkoI3cAUuCqpcIvnOK+wkxodEOJOsyWSis4S/8C/IHIwrkXX+UXnPioW
         4ROutlW/IaLa4jkMEC7+dxgomMqA8mZEc4Ws/MVupQBrKyJ8eZxPwO+Y8L9Ljo3dtxmI
         FkwreZImnjfRhzJUxonQCgqq5rsyfE2k6gT71v2/JZwuAf2alfqOiS+JHpKQ/Blhq3ch
         jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=giOKidC9koKbUCA23vFcqUz66kzKhj7G43+rbP55W1Q=;
        b=HQSP6EInJrFzbUOuXRXDZOwX3C/WJmFe2j9m5kZT0r8lRJR/ZTuZlLgN4gfcq03CaI
         VXDmTQhm1+KtGVYoIppc45XJwC/8+InTfRIlou7oeJ9w0d7oVd01t6YD4YrsC5dWUiqW
         BIRLhRYWc2JxWSkfTMXRkCRzvKhHMEHIP3aP+ki5BijNCcTNY/hd/48+MbjpZ0MBw0uS
         7yOjy46xCwuI84rKOZZVUeaq/KpwjYfRhH3jolYIBvMYfdd41ivANquXNmlnh+ehm16e
         +oeguZL5KVvcfj198PVZLsNwz4+FIXE/ov47+HM2c+xH4GgvylloJSniO2XaEb3HKh4X
         8aUg==
X-Gm-Message-State: AOAM531U7B8t01EsgAJBDT4W69cxnwRZNFghBv4WYDzqdQpe0769/K2H
        Thp1CNLwXROryL6r1RrKCDjTiWf4KZ8=
X-Google-Smtp-Source: ABdhPJwumjWaIWUY8c2o3q91Ja5o96+pEAQQlVCvtSje50/bfmNrhO7ELnmk5cBKo4zsRbRfgCmGKg==
X-Received: by 2002:aa7:959a:0:b029:1a1:ffc5:531d with SMTP id z26-20020aa7959a0000b02901a1ffc5531dmr13277998pfj.27.1607943854398;
        Mon, 14 Dec 2020 03:04:14 -0800 (PST)
Received: from localhost ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id k21sm18458132pfu.7.2020.12.14.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 03:04:13 -0800 (PST)
Date:   Mon, 14 Dec 2020 21:04:08 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: Trim offlined CPUs from mm_cpumasks
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201120025757.325930-1-npiggin@gmail.com>
        <20201120025757.325930-3-npiggin@gmail.com>
        <CAMuHMdUdorW03=mipgm92SXNPBZO5owW1Wp6_SacRDZ7fOe9gw@mail.gmail.com>
        <1607919238.kj439g85v5.astroid@bobo.none>
        <87h7oozn06.fsf@mpe.ellerman.id.au>
In-Reply-To: <87h7oozn06.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1607943765.29hccd2b8p.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Michael Ellerman's message of December 14, 2020 8:43 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Excerpts from Geert Uytterhoeven's message of December 10, 2020 7:06 pm:
>>> Hi Nicholas,
>>>=20
>>> On Fri, Nov 20, 2020 at 4:01 AM Nicholas Piggin <npiggin@gmail.com> wro=
te:
>>>>
>>>> When offlining a CPU, powerpc/64s does not flush TLBs, rather it just
>>>> leaves the CPU set in mm_cpumasks, so it continues to receive TLBIEs
>>>> to manage its TLBs.
>>>>
>>>> However the exit_flush_lazy_tlbs() function expects that after
>>>> returning, all CPUs (except self) have flushed TLBs for that mm, in
>>>> which case TLBIEL can be used for this flush. This breaks for offline
>>>> CPUs because they don't get the IPI to flush their TLB. This can lead
>>>> to stale translations.
>>>>
>>>> Fix this by clearing the CPU from mm_cpumasks, then flushing all TLBs
>>>> before going offline.
>>>>
>>>> These offlined CPU bits stuck in the cpumask also prevents the cpumask
>>>> from being trimmed back to local mode, which means continual broadcast
>>>> IPIs or TLBIEs are needed for TLB flushing. This patch prevents that
>>>> situation too.
>>>>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>=20
>>> Thanks for your patch!
>>>=20
>>>> --- a/arch/powerpc/platforms/powermac/smp.c
>>>> +++ b/arch/powerpc/platforms/powermac/smp.c
>>>> @@ -911,6 +911,8 @@ static int smp_core99_cpu_disable(void)
>>>>
>>>>         mpic_cpu_set_priority(0xf);
>>>>
>>>> +       cleanup_cpu_mmu_context();
>>>> +
>>>=20
>>> I guess this change broke pmac32_defconfig+SMP in v5.10-rc7?
>>>=20
>>> arch/powerpc/platforms/powermac/smp.c: error: implicit
>>> declaration of function 'cleanup_cpu_mmu_context'
>>> [-Werror=3Dimplicit-function-declaration]:  =3D> 914:2
>>>=20
>>> http://kisskb.ellerman.id.au/kisskb/buildresult/14423174/
>>
>> Hey, yeah it does thanks for catching it. This patch fixes it for me
>>
>> ---
>> From a9b5ec92ffac975e81c6d7db6ff2b1486b2723f7 Mon Sep 17 00:00:00 2001
>> From: Nicholas Piggin <npiggin@gmail.com>
>> Date: Mon, 14 Dec 2020 13:52:39 +1000
>> Subject: [PATCH] powerpc/32s: Fix cleanup_cpu_mmu_context() compile bug
>>
>> 32s has no tlbiel_all() defined, so just disable the cleanup with a
>> comment.
>=20
> Or what about just:

That works, I kind of wanted it in there explicit that we don't
clean up on 32s. I don't mind if you prefer this though.

Thanks,
Nick

>=20
> diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc=
/include/asm/book3s/32/mmu-hash.h
> index 331187661236..685c589e723f 100644
> --- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
> @@ -94,6 +94,7 @@ typedef struct {
>  } mm_context_t;
>=20
>  void update_bats(void);
> +static inline void cleanup_cpu_mmu_context(void) { };
>=20
>  /* patch sites */
>  extern s32 patch__hash_page_A0, patch__hash_page_A1, patch__hash_page_A2=
;
>=20
>=20
> cheers
>=20
>=20
