Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE5269CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOD61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:58:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p15so1119381qvk.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMJdPDx6ekVB7YXwuHGF9tRuH4E5JE+NQDZ61jgQOAI=;
        b=XsWUXcEgYKKv3P64NV7Q3vzVgQRBa9DgiVHKTpZ0+n70fDfEpFHaX09lAAeS8cJyuo
         qJ6RFZ0fTnH6BODhgwBlyaSbUVDL02our7WLYqeVYwWp9xFvas+p/MZzmZuUh9NMv44S
         6EPLUug67II6U9d7QmLhSmwCQVk+UncJJxDGpNOXjG+3CEaJcEEM2MuiWmvJOUw/ZsQE
         r9oVRAbzFOYVT1Wm8CtyMG2+IlY0w7OLYzrLrBPLz88rfrrWGLwthdQZxSN0i2ZCjUac
         RRWM4PTvxsjDGYU+UfDVM7zJMQA06pr0gdywnyHZdJhrs0/LuAPRNie/VKn8OwDqr/sO
         n8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMJdPDx6ekVB7YXwuHGF9tRuH4E5JE+NQDZ61jgQOAI=;
        b=Z8yVgFUc5cxw4pnaKouB39Y5QZf9dgfd98pQqXEwUKyl8XhHSBECIKx3xtCTHxItXU
         51pIUqL6sQG3Oml4FRiFHLG7vwwHT58eIKOHPvzsWqZ0/ZOzOUQoMhINapVYU3SmjS4N
         dTjxFhXNzth3nZ8LriP+1E0d0bVQ2cyPcMTk7hBHVjfMVnRDn2WPV5vSVCCmQukf23cM
         9Vi3CgiTnqZaIhLdr7unqB3LCKTgfFX//nyAE4oCSqC1bMZ6gzYnYUQ7ADrLJ1G9ajDx
         jJnoO4vysz3Hdzyjtm/9y8RyfghBGRGnhkI6atDaRn+5GMDv3ucie4mbvY76bYsj3N1a
         RFLQ==
X-Gm-Message-State: AOAM532X0x12IX4tsaEK4qvvXv49RZ4JzxhF8hwe20j224AJx5AZ2w+i
        6AqjN4xyX61DNEJ3z1luHpAhIqbXM2hwQvt++bZcgQ==
X-Google-Smtp-Source: ABdhPJyjl4AeOLhR1zK1vHrRbaehEoqpsH6OVLDN65wxiqK03GMCKC93t2OcUrXWkV16aQ9nOiNtsd/WgCet4hoClP0=
X-Received: by 2002:a0c:e649:: with SMTP id c9mr15787689qvn.16.1600142305934;
 Mon, 14 Sep 2020 20:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy1QbMjZxxu+wSBYr3+3oaM2Qg=_Uwj8dfQidi=ck6PV_Q@mail.gmail.com>
 <mhng-1f7adcd7-551c-4b8a-80f5-e1230b335c6a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-1f7adcd7-551c-4b8a-80f5-e1230b335c6a@palmerdabbelt-glaptop1>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 15 Sep 2020 11:58:13 +0800
Message-ID: <CAHCEehKnFpdDamANoOfSJV2pbeMzjhxWja667PL6Sueid9imPw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add sfence.vma after page table changed
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <willdeacon@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Syven Wang <syven.wang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, 03 Aug 2020 20:29:32 PDT (-0700), anup@brainfault.org wrote:
> > On Tue, Aug 4, 2020 at 8:32 AM Greentime Hu <greentime.hu@sifive.com> w=
rote:
> >>
> >> This patch addes local_flush_tlb_page(addr) to use sfence.vma after th=
e
> >
> > s/addes/adds
> >
> >> page table changed. That address will be used immediately in
> >> memset(nextp, 0, PAGE_SIZE) to cause this issue so we should add the
> >> sfence.vma before we use it.
> >
> > Alternate version of this commit description can be:
> >
> > Invalidate local TLB after both set_pet() and clear_pte() because the
> > address can be used immediately after page table change.
> >
> >> Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")
> >>
> >> Reported-by: Syven Wang <syven.wang@sifive.com>
> >> Signed-off-by: Syven Wang <syven.wang@sifive.com>
> >> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> >> ---
> >>  arch/riscv/mm/init.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> index f4adb3684f3d..29b0f7108054 100644
> >> --- a/arch/riscv/mm/init.c
> >> +++ b/arch/riscv/mm/init.c
> >> @@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys=
_addr_t phys, pgprot_t prot)
> >>
> >>         ptep =3D &fixmap_pte[pte_index(addr)];
> >>
> >> -       if (pgprot_val(prot)) {
> >> +       if (pgprot_val(prot))
> >>                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
> >> -       } else {
> >> +       else
> >>                 pte_clear(&init_mm, addr, ptep);
> >> -               local_flush_tlb_page(addr);
> >> -       }
> >> +       local_flush_tlb_page(addr);
> >>  }
>
> arm64 appears to be upgrading all set_pte()s on valid kernel mappings to
> include the fence.  It looks like the message from 7f0b1bf04511 ("arm64: =
Fix
> barriers used for page table modifications") is out of date, as I can't f=
ind
> create_mapping() any more.  If that was some generic kernel thing then we
> should probably upgrade ours as well, but if it was arch/arm64/ code then=
 this
> approach seems fine as __set_fixmap() isn't on the hot path -- I guess th=
is is
> fine either way, but there may be other issues that the arm64 approach fi=
xes.
>
> Do you guys happen to remember what was going on here?

Hi Palmer,

Some architectures add cache writeback in set_pte(), just like nds32, csky.

https://github.com/torvalds/linux/blob/master/arch/nds32/include/asm/pgtabl=
e.h#L213
https://github.com/torvalds/linux/blob/master/arch/csky/include/asm/pgtable=
.h#L104

Would you like to pick this patch or should I send another patch to
implement it in set_pte()?
