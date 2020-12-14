Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7563D2D9238
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 05:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438547AbgLNEP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 23:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgLNEPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 23:15:55 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F816C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 20:15:15 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n1so8895133pge.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 20:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=IzItAb+/ARuy43MHZHytVoSiTjlxsOWc+L7HYoQ10Rk=;
        b=sKJgfr148BjRYzX/HwC2xkFZ/0a4TrXgBfen9ZN7lMaB7SW+itnsNCLU5d5WxIzZKl
         kwewH+B/EglrOnw8364mXmCmlESywVsBZn47nEoggNeEIwqyeoIQRpvlItqsgt5BDygy
         /dXfwAKnD3GaI+f9n+q+YAwYnJJDiXtatldgOufQJnvB8u1gDNb3Gtnav0ozT96zps19
         Q4mpXyjS94Mkjp7DcfEUhjkvGqmfg5SdCEpblMmXy+XbEYFPUSbJGuYPI5htzzEK3tS5
         1KCdV3Vt7wXNb2B5be0n6lSrozvn+VwrxAqGKSt9wLA+Gfm+fH9Dmb2cDf+Mxzy9CTv4
         vbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=IzItAb+/ARuy43MHZHytVoSiTjlxsOWc+L7HYoQ10Rk=;
        b=hw33JL75l3Y2HN4OZoRcA80yQNKbQsS1KMayiZrjK8+4JQPZXiSnX+67Sy2y+NGzI0
         dtHQndtcj2vTrq8TGk46Tat3RVFkSAb3XtPtWD1n3g1HjIjhxBro6UPB0AJPuJGzPr8+
         YtG2r9cK6Hd+SMqdfW5xQ3iKtn5p5KPaEcwHtHv3/osoReMBjJX+DaOg+/XqTRuP7Zo1
         APBdDTB+4jsJcT2+Ktv5NzveURktiKUUFvfQJSp0CXkC6h2gkufXMsAUEwkUdZD9o06h
         aUcYAdv5L3F2YZkXzhZ0uZk2ppizWTEKseG3l81+b+sOWvgGN/poeXwu8amwv1YBxskO
         fedA==
X-Gm-Message-State: AOAM530JRRlTLQfnVXGeXCvGXTM1E046nGefNfiqxCIBU0Bhydb4IjG1
        aQLA4G9Q7SDdQcTVn25ELDo=
X-Google-Smtp-Source: ABdhPJwLQFbwEuJx28XaT9yTVmY+be361/iJueWiQXXjL88/5Em8DZdjWZlNmRscq1PPBt2c5dGrKg==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr19870693pgm.295.1607919310176;
        Sun, 13 Dec 2020 20:15:10 -0800 (PST)
Received: from localhost ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id ft19sm7668399pjb.44.2020.12.13.20.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 20:15:09 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:15:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: Trim offlined CPUs from mm_cpumasks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201120025757.325930-1-npiggin@gmail.com>
        <20201120025757.325930-3-npiggin@gmail.com>
        <CAMuHMdUdorW03=mipgm92SXNPBZO5owW1Wp6_SacRDZ7fOe9gw@mail.gmail.com>
In-Reply-To: <CAMuHMdUdorW03=mipgm92SXNPBZO5owW1Wp6_SacRDZ7fOe9gw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1607919238.kj439g85v5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Geert Uytterhoeven's message of December 10, 2020 7:06 pm:
> Hi Nicholas,
>=20
> On Fri, Nov 20, 2020 at 4:01 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> When offlining a CPU, powerpc/64s does not flush TLBs, rather it just
>> leaves the CPU set in mm_cpumasks, so it continues to receive TLBIEs
>> to manage its TLBs.
>>
>> However the exit_flush_lazy_tlbs() function expects that after
>> returning, all CPUs (except self) have flushed TLBs for that mm, in
>> which case TLBIEL can be used for this flush. This breaks for offline
>> CPUs because they don't get the IPI to flush their TLB. This can lead
>> to stale translations.
>>
>> Fix this by clearing the CPU from mm_cpumasks, then flushing all TLBs
>> before going offline.
>>
>> These offlined CPU bits stuck in the cpumask also prevents the cpumask
>> from being trimmed back to local mode, which means continual broadcast
>> IPIs or TLBIEs are needed for TLB flushing. This patch prevents that
>> situation too.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Thanks for your patch!
>=20
>> --- a/arch/powerpc/platforms/powermac/smp.c
>> +++ b/arch/powerpc/platforms/powermac/smp.c
>> @@ -911,6 +911,8 @@ static int smp_core99_cpu_disable(void)
>>
>>         mpic_cpu_set_priority(0xf);
>>
>> +       cleanup_cpu_mmu_context();
>> +
>=20
> I guess this change broke pmac32_defconfig+SMP in v5.10-rc7?
>=20
> arch/powerpc/platforms/powermac/smp.c: error: implicit
> declaration of function 'cleanup_cpu_mmu_context'
> [-Werror=3Dimplicit-function-declaration]:  =3D> 914:2
>=20
> http://kisskb.ellerman.id.au/kisskb/buildresult/14423174/

Hey, yeah it does thanks for catching it. This patch fixes it for me

---
From a9b5ec92ffac975e81c6d7db6ff2b1486b2723f7 Mon Sep 17 00:00:00 2001
From: Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 14 Dec 2020 13:52:39 +1000
Subject: [PATCH] powerpc/32s: Fix cleanup_cpu_mmu_context() compile bug

32s has no tlbiel_all() defined, so just disable the cleanup with a
comment.

Fixes: 01b0f0eae081 ("powerpc/64s: Trim offlined CPUs from mm_cpumasks")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powermac/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms=
/powermac/smp.c
index adae2a6712e1..66ef5f8f4445 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -911,7 +911,16 @@ static int smp_core99_cpu_disable(void)
=20
 	mpic_cpu_set_priority(0xf);
=20
+	/*
+	 * Would be nice for consistency if all platforms clear mm_cpumask and
+	 * flush TLBs on unplug, but the TLB invalidation bug described in
+	 * commit 01b0f0eae081 ("powerpc/64s: Trim offlined CPUs from
+	 * mm_cpumasks") only applies to 64s and for now we only have the TLB
+	 * flush code for that platform.
+	 */
+#ifdef CONFIG_PPC64
 	cleanup_cpu_mmu_context();
+#endif
=20
 	return 0;
 }
--=20
2.23.0

