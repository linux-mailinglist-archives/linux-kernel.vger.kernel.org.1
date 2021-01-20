Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55BD2FCF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbhATLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:40:33 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41614 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbhATLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:00:15 -0500
Received: by mail-oi1-f172.google.com with SMTP id 15so24575767oix.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DK+FZYOgme3Ym7xK/6JU3jj5omlMd5NXSakDyCnkIA0=;
        b=G4T4aj0/HehZXc8VzLaxdwZ/CJbS1gcmbTJS0Ak5dT6OMAtdWYXMvfmAELf5o9lsLq
         kzPUj3O9wxWvmMtYZ8MA30zQ5SP3OeCP3MOXnjP2EoATUv13hrNUBmnJ4ZXlsIFffLmH
         hiIFQceMc1iTYa6KaorlHEb2Q7FDn/JFX5hXtqL25Nx9ibCMsLlNB5oJdrllZLVbUroQ
         /clIL+D1ZG0LqALlKmCUceUi98QmMzj/IcHLtZQ/+XlvrFbO+8FJDZSyQDMkvkLh6MWF
         HmkYSkeWKPVQBfCy/SsLWXVpJ1rlyo2zZZJ0+mlOm7l/NdnTVCLQnP58oL3iSQ2EIeOS
         i3nQ==
X-Gm-Message-State: AOAM533dTQgD+tI/SuctQx6o+fQvVhOZ6ACqUw2ceJ1HkVUQ41r3qJWs
        KPtgAUACPZQCUUEDxDS2oaz6Wg88cbq1PH7M8GU=
X-Google-Smtp-Source: ABdhPJzNOkj0RJCg5MWPsB2nJeuOLyBgBm/U9bYvMf7/sxQ4TwReP40jMWCWWK5UEYqKMB4u26wZ+I6DChBs1N3JiDs=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr2455753oia.148.1611140371974;
 Wed, 20 Jan 2021 02:59:31 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdXQr-qNQ2aNVmgQFfs_dJ8=A-xzrhxRf9VUmzFXx+2o_w@mail.gmail.com>
 <mhng-c5ceb653-6391-407e-acd9-bd5c43ca434a@penguin> <CAMuHMdXoJ9-jM4sazFbHXEsaDFFMK1ybM53SDqy_2QqPMZEQ=g@mail.gmail.com>
In-Reply-To: <CAMuHMdXoJ9-jM4sazFbHXEsaDFFMK1ybM53SDqy_2QqPMZEQ=g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jan 2021 11:59:20 +0100
Message-ID: <CAMuHMdU9JTYKGxLpmDaYGMGOeaeDb_mCWbCNP2VM7LKwSE+YAg@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 8:03 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 15, 2021 at 11:44 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > On Thu, 14 Jan 2021 23:59:04 PST (-0800), geert@linux-m68k.org wrote:
> > > On Thu, Jan 14, 2021 at 10:11 PM Atish Patra <atishp@atishpatra.org> wrote:
> > >> On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >> > On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
> > >> > > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >> > >>
> > >> > >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> > >> > >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> > >> > >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> > >> > >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> > >> > >> >
> > >> > >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > >> > >> > ---
> > >> > >> >  arch/riscv/include/asm/cache.h | 4 ++++
> > >> > >> >  1 file changed, 4 insertions(+)
> > >> > >> >
> > >> > >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > >> > >> > index 9b58b104559e..c9c669ea2fe6 100644
> > >> > >> > --- a/arch/riscv/include/asm/cache.h
> > >> > >> > +++ b/arch/riscv/include/asm/cache.h
> > >> > >> > @@ -7,7 +7,11 @@
> > >> > >> >  #ifndef _ASM_RISCV_CACHE_H
> > >> > >> >  #define _ASM_RISCV_CACHE_H
> > >> > >> >
> > >> > >> > +#ifdef CONFIG_64BIT
> > >> > >> >  #define L1_CACHE_SHIFT               6
> > >> > >> > +#else
> > >> > >> > +#define L1_CACHE_SHIFT               5
> > >> > >> > +#endif
> > >> > >> >
> > >> > >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
> > >> > >>
> > >> > >> Should we not instead just
> > >> > >>
> > >> > >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
> > >> > >>
> > >> > >> like a handful of architectures do?
> > >> > >>
> > >> > >
> > >> > > The generic code already defines it that way in include/linux/cache.h
> > >> > >
> > >> > >> The cache size is sort of fake here, as we don't have any non-coherent
> > >> > >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> > >> > >> cache lines in RISC-V implementations as software may assume that for
> > >> > >> performance reasons.  Not really a strong reason, but I'd prefer to just make
> > >> > >> these match.
> > >> > >>
> > >> > >
> > >> > > If it is documented somewhere in the kernel, we should update that. I
> > >> > > think SMP_CACHE_BYTES being 64
> > >> > > actually degrades the performance as there will be a fragmented memory
> > >> > > blocks with 32 bit bytes gap wherever
> > >> > > SMP_CACHE_BYTES is used as an alignment requirement.
> > >> >
> > >> > I don't buy that: if you're trying to align to the cache size then the gaps are
> > >> > the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
> > >> > there's really no reason for these to be different between the base ISAs.
> > >> >
> > >>
> > >> Got your point. I noticed this when fixing the resource tree issue
> > >> where the SMP_CACHE_BYTES
> > >> alignment was not intentional but causing the issue. The real issue
> > >> was solved via another patch in this series though.
> > >>
> > >> Just to clarify, if the allocation function intends to allocate
> > >> consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
> > >> This will lead to a #ifdef macro in the code.
> > >>
> > >> > > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> > >> > > without this patch.
> > >> > > I didn't see anything in Qemu though.
> > >> >
> > >> > Something like that is probably only going to show up on real hardware, QEMU
> > >> > doesn't really do anything with the cache line size.  That said, as there's
> > >> > nothing in our kernel now related to non-coherent memory there really should
> > >> > only be performance issue (at least until we have non-coherent systems).
> > >> >
> > >> > I'd bet that the change is just masking some other bug, either in the software
> > >> > or the hardware.  I'd prefer to root cause this rather than just working around
> > >> > it, as it'll probably come back later and in a more difficult way to find.
> > >> >
> > >>
> > >> Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
> > >> you were saying ?
> > >> We may need to change an alignment requirement to 32 for RV32 manually
> > >> at some place in code.
> > >
> > > My findings were in
> > > https://lore.kernel.org/linux-riscv/CAMuHMdWf6K-5y02+WJ6Khu1cD6P0n5x1wYQikrECkuNtAA1pgg@mail.gmail.com/
> > >
> > > Note that when the memblock.reserved list kept increasing, it kept on
> > > adding the same entry to the list.  But that was fixed by "[PATCH 1/4]
> > > RISC-V: Do not allocate memblock while iterating reserved memblocks".
> > >
> > > After that, only the (reproducible) "Unable to handle kernel paging
> > > request at virtual address 61636473" was left, always at the same place.
> > > No idea where the actual corruption happened.
> >
> > Thanks.  Presumably I need an FPGA to run this?  That will make it tricky to
> > find anything here on my end.
>
> In theory, it should work with the LiteX simulation, too.
> I.e. follow the instructions at
> https://github.com/litex-hub/linux-on-litex-vexriscv
> You can find prebuilt binaries at
> https://github.com/litex-hub/linux-on-litex-vexriscv/issues/164
> Take images/opensbi.bin from opensbi_2020_12_15.zip, and
> images/rootfs.cpio from linux_2021_01_11.zip.
> Take images/Image from your own kernel build.
>
> Unfortunately it seems the simulator is currently broken, and kernels
> (both prebuilt and my own config) hang after
> "sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every
> 2199023255500ns"

In the mean time, the simulator got fixed.
Unfortunately the crash does not happen on the simulator.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
