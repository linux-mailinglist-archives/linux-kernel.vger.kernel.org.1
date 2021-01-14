Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA42F6D29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbhANVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbhANVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:25:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D86C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:24:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h186so4150638pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NUjA2jNSnmu45PtSeP4o+QzyhX9y81W+nYK9XpvLtWM=;
        b=TMWFVNnjCehbf2dXwgupeiZlAZ4966betId5laDETRK4ezJ++qiLBPW1KPMmQwrKC+
         oO/hpMuTUh/aZHY1kmHrVz1ewIBpNw3FJF5uvlB63k1BWwQ+7DcEg2jAkfIBhWZPAu/j
         p2RN+IFCRXg/GoMKyKidFL0/TBYkR0vxOu5Dkjb1ghtfwyTr6JuTlbIhg4nPyTzMyMuu
         P6Xdd228ZQgcTX+5E0nw45xgd8fkpqJJ7p0ia4LPeeODPqyryDdvW2OiV2jEMo87w7R3
         xSFxKwlLAWWx3jUZy8bwFCv5bzhx3WSA33suqZtUokqpNRN3tZ/YoZfR9L0gjItDhJu5
         A8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NUjA2jNSnmu45PtSeP4o+QzyhX9y81W+nYK9XpvLtWM=;
        b=c60muFNPwdbbHbWOkyfvtUHrbshJmQStRYU1q/r7i5tZX70qUleD0kSbiIsAZNejcy
         tr9ooo4gy0FKYjUHUwH8vVbJ3wA+byHGq/VTpATArAh8wNJVGUDBEVwJM3m1AVrTeSVz
         qkV5p+4ejGR9iyhflPI6cBpde2kVM2pCd45BO6lISYw/F1uCJzfoU4KKOQ31Jp/Qzty9
         wJxPSzkCkuOoFbMIN8V6jxqYNKfZvIR8lVwkFMKsr6h6XWgVIPxE+YKEoF33IP80EARu
         rkNCZL8hyWQszINAZFJOr5+IrSSCNplq2MigRwJUDeEQNJcV85YDBXsfTYMDxQU4q9BT
         X5gA==
X-Gm-Message-State: AOAM532JU4U+OcreTcXoEJdmjUM/Qqt64CMYfxBszBIH4wBzqm/Mqu0L
        Ii+NRNwPeRrfUcUBjX1e4BztVA==
X-Google-Smtp-Source: ABdhPJwURX6SX7DoETcJY1cM8nW0POPdmmqVZ6PQJll6UjENI87Kd5yO6X3C/dk1wnyKTepPcjvusQ==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr9441387pgi.74.1610659459310;
        Thu, 14 Jan 2021 13:24:19 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i25sm6012481pfo.137.2021.01.14.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 13:24:18 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:24:18 -0800 (PST)
X-Google-Original-Date: Thu, 14 Jan 2021 13:24:16 PST (-0800)
Subject:     Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
In-Reply-To: <CAOnJCUJON3B6ugWDY1=rcDOMS2+m=SVBsiAEnwV=QDL7omnsfA@mail.gmail.com>
CC:     geert@linux-m68k.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr,
        akpm@linux-foundation.org, ardb@kernel.org, rppt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-74a37cc8-bbda-4471-9510-dab1b35ded2e@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 13:11:14 PST (-0800), atishp@atishpatra.org wrote:
> On Thu, Jan 14, 2021 at 11:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
>> > On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >>
>> >> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
>> >> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
>> >> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
>> >> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>> >> >
>> >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> >> > ---
>> >> >  arch/riscv/include/asm/cache.h | 4 ++++
>> >> >  1 file changed, 4 insertions(+)
>> >> >
>> >> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
>> >> > index 9b58b104559e..c9c669ea2fe6 100644
>> >> > --- a/arch/riscv/include/asm/cache.h
>> >> > +++ b/arch/riscv/include/asm/cache.h
>> >> > @@ -7,7 +7,11 @@
>> >> >  #ifndef _ASM_RISCV_CACHE_H
>> >> >  #define _ASM_RISCV_CACHE_H
>> >> >
>> >> > +#ifdef CONFIG_64BIT
>> >> >  #define L1_CACHE_SHIFT               6
>> >> > +#else
>> >> > +#define L1_CACHE_SHIFT               5
>> >> > +#endif
>> >> >
>> >> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
>> >>
>> >> Should we not instead just
>> >>
>> >> #define SMP_CACHE_BYTES L1_CACHE_BYTES
>> >>
>> >> like a handful of architectures do?
>> >>
>> >
>> > The generic code already defines it that way in include/linux/cache.h
>> >
>> >> The cache size is sort of fake here, as we don't have any non-coherent
>> >> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
>> >> cache lines in RISC-V implementations as software may assume that for
>> >> performance reasons.  Not really a strong reason, but I'd prefer to just make
>> >> these match.
>> >>
>> >
>> > If it is documented somewhere in the kernel, we should update that. I
>> > think SMP_CACHE_BYTES being 64
>> > actually degrades the performance as there will be a fragmented memory
>> > blocks with 32 bit bytes gap wherever
>> > SMP_CACHE_BYTES is used as an alignment requirement.
>>
>> I don't buy that: if you're trying to align to the cache size then the gaps are
>> the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so
>> there's really no reason for these to be different between the base ISAs.
>>
>
> Got your point. I noticed this when fixing the resource tree issue
> where the SMP_CACHE_BYTES
> alignment was not intentional but causing the issue. The real issue
> was solved via another patch in this series though.
>
> Just to clarify, if the allocation function intends to allocate
> consecutive memory, it should use 32 instead of SMP_CACHE_BYTES.
> This will lead to a #ifdef macro in the code.

Well, if you want to be allocating XLEN-byte sized chunks then you should use 
an XLEN-based define and if you want to allocate cache-line-sized chunks then 
you should use some cache-line-based define.  I guess I'd have to see the code 
to know if an ifdef is the right way to go, but the right thing is probably to 
just change over to something that already exists.

>> > In addition to that, Geert Uytterhoeven mentioned some panic on vex32
>> > without this patch.
>> > I didn't see anything in Qemu though.
>>
>> Something like that is probably only going to show up on real hardware, QEMU
>> doesn't really do anything with the cache line size.  That said, as there's
>> nothing in our kernel now related to non-coherent memory there really should
>> only be performance issue (at least until we have non-coherent systems).
>>
>> I'd bet that the change is just masking some other bug, either in the software
>> or the hardware.  I'd prefer to root cause this rather than just working around
>> it, as it'll probably come back later and in a more difficult way to find.
>>
>
> Agreed. @Geert Uytterhoeven Can you do a further analysis of the panic
> you were saying ?
> We may need to change an alignment requirement to 32 for RV32 manually
> at some place in code.
>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
