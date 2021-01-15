Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6C2F88B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbhAOWot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbhAOWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:44:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF4C061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id md11so5892803pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MSIZ4FzBHVOiuO+ldyqPYGJMXRPb1Z0V0cuiPqnS7aQ=;
        b=xJ84ZosWOiGFWRaL/hsA4Jxeu6oaQ3s1M+yO8sUqabiyHT3UOyWkAQ+0EV5Th1P3T+
         qqNj3gied2l3Hmz3lZcMhr6rTwNh2ZyVcm30BJDj4vv9NJWqR6vbMD7UnrZahcBJXVjj
         ukVopL/3OaFwXGwbasmvAa9Nm6tDAe+uvxZLX+arJ6uXAJ/O4lppYpfMvKhKBnM1idum
         /OMMu3A28+eM0slKK3Wr9bXrUD05SukGbBQy8ZprxrmrsHcjNSzZ6GX1PYe1aJu2Swt6
         fb3H8S0rPOnw7ipX5XEXvxqbAPk5G++RtSkSQq1dia6KXeSBLM4MNNC5aGC88Ktn8Q2h
         mk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MSIZ4FzBHVOiuO+ldyqPYGJMXRPb1Z0V0cuiPqnS7aQ=;
        b=JPm2XUkUHs298P1hICxjgFO0Bi9rO5Q1Sdkc4OToDtA1dzeXOe0Rp/pN5TtZmrbt1C
         OCya1UzFSCO31vlDqQSZyNiMYmrImXNrNFnbP6rIHKN7rH+JHEy2NX9qTpWAJcCgO+s5
         y5DqIV5znxoZQn+IZGPYqmXljeYB8v8IuzsA9XgnnEaDhU6Uyl4C5E3DTF1YKzGFJ3NU
         KS1gf38Pwr45G55sXXJyRNnAIB7LMTLtzHd+Jh8SXS5FM+c84mj91mfjx8eiB/x294yT
         Bi5dwSszY7ONXx/Obq90/kEf40aouh+66QvfBJVX82X2zwk9gCQZMSkkNJKY9h7l5a0o
         VqUg==
X-Gm-Message-State: AOAM5338K/CG0BUBlezwYS85dMNsOcAbSoZ2c4y46mCc6stRJKiICW/I
        e3uJ/OYIwU3eqdLJcrQtLLxc/A==
X-Google-Smtp-Source: ABdhPJxtyr5W8V+mBiNCHHgjIY68knC6OZfI4H8uZLxx+d5//NYQKAYWL80PeI7j5hbA+I6UTKxKuQ==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr13197995pjb.22.1610750647271;
        Fri, 15 Jan 2021 14:44:07 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bk18sm5320450pjb.41.2021.01.15.14.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:06 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:44:06 -0800 (PST)
X-Google-Original-Date: Fri, 15 Jan 2021 14:42:17 PST (-0800)
Subject:     Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
In-Reply-To: <CAMuHMdXQr-qNQ2aNVmgQFfs_dJ8=A-xzrhxRf9VUmzFXx+2o_w@mail.gmail.com>
CC:     atishp@atishpatra.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr,
        akpm@linux-foundation.org, ardb@kernel.org, rppt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-c5ceb653-6391-407e-acd9-bd5c43ca434a@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 23:59:04 PST (-0800), geert@linux-m68k.org wrote:
> Hi Atish,
>
> On Thu, Jan 14, 2021 at 10:11 PM Atish Patra <atishp@atishpatra.org> wrote:
>> On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
>> > > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > >>
>> > >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
>> > >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
>> > >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
>> > >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>> > >> >
>> > >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > >> > ---
>> > >> >  arch/riscv/include/asm/cache.h | 4 ++++
>> > >> >  1 file changed, 4 insertions(+)
>> > >> >
>> > >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
>> > >> > index 9b58b104559e..c9c669ea2fe6 100644
>> > >> > --- a/arch/riscv/include/asm/cache.h
>> > >> > +++ b/arch/riscv/include/asm/cache.h
>> > >> > @@ -7,7 +7,11 @@
>> > >> >  #ifndef _ASM_RISCV_CACHE_H
>> > >> >  #define _ASM_RISCV_CACHE_H
>> > >> >
>> > >> > +#ifdef CONFIG_64BIT
>> > >> >  #define L1_CACHE_SHIFT               6
>> > >> > +#else
>> > >> > +#define L1_CACHE_SHIFT               5
>> > >> > +#endif
>> > >> >
>> > >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
>> > >>
>> > >> Should we not instead just
>> > >>
>> > >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
>> > >>
>> > >> like a handful of architectures do?
>> > >>
>> > >
>> > > The generic code already defines it that way in include/linux/cache.h
>> > >
>> > >> The cache size is sort of fake here, as we don't have any non-coherent
>> > >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
>> > >> cache lines in RISC-V implementations as software may assume that for
>> > >> performance reasons.  Not really a strong reason, but I'd prefer to just make
>> > >> these match.
>> > >>
>> > >
>> > > If it is documented somewhere in the kernel, we should update that. I
>> > > think SMP_CACHE_BYTES being 64
>> > > actually degrades the performance as there will be a fragmented memory
>> > > blocks with 32 bit bytes gap wherever
>> > > SMP_CACHE_BYTES is used as an alignment requirement.
>> >
>> > I don't buy that: if you're trying to align to the cache size then the gaps are
>> > the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
>> > there's really no reason for these to be different between the base ISAs.
>> >
>>
>> Got your point. I noticed this when fixing the resource tree issue
>> where the SMP_CACHE_BYTES
>> alignment was not intentional but causing the issue. The real issue
>> was solved via another patch in this series though.
>>
>> Just to clarify, if the allocation function intends to allocate
>> consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
>> This will lead to a #ifdef macro in the code.
>>
>> > > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
>> > > without this patch.
>> > > I didn't see anything in Qemu though.
>> >
>> > Something like that is probably only going to show up on real hardware, QEMU
>> > doesn't really do anything with the cache line size.  That said, as there's
>> > nothing in our kernel now related to non-coherent memory there really should
>> > only be performance issue (at least until we have non-coherent systems).
>> >
>> > I'd bet that the change is just masking some other bug, either in the software
>> > or the hardware.  I'd prefer to root cause this rather than just working around
>> > it, as it'll probably come back later and in a more difficult way to find.
>> >
>>
>> Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
>> you were saying ?
>> We may need to change an alignment requirement to 32 for RV32 manually
>> at some place in code.
>
> My findings were in
> https://lore.kernel.org/linux-riscv/CAMuHMdWf6K-5y02+WJ6Khu1cD6P0n5x1wYQikrECkuNtAA1pgg@mail.gmail.com/
>
> Note that when the memblock.reserved list kept increasing, it kept on
> adding the same entry to the list.  But that was fixed by "[PATCH 1/4]
> RISC-V: Do not allocate memblock while iterating reserved memblocks".
>
> After that, only the (reproducible) "Unable to handle kernel paging
> request at virtual address 61636473" was left, always at the same place.
> No idea where the actual corruption happened.

Thanks.  Presumably I need an FPGA to run this?  That will make it tricky to 
find anything here on my end.

>
> Gr{oetje,eeting}s,
>
>                         Geert
