Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1582F6B74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbhANTrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbhANTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:47:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE17C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:46:50 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m6so3982022pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zhioZvV+r4fFwCqQkXpsP5zDQ159hRRkEm/rP3sSAhw=;
        b=jLpR+y7JcSVCEWiVGH0PQhcticHXkso7HHKSFRnbUplsQy9azcPgakQrOVqfX2lGG0
         TxXTfaafryZFSDC0kYOSZYSEHYvql2xtRAw4ZqMK9oiHkp1lhKixpCE2bO3/4iGyVcO1
         RudVAMy4VCGx51m2JXaMMUU9HSSMPfenZzF/qfsksrcIUE1FgZazDHp0LWdk6iPHB4aw
         vRERbCX0dc8rhaZn/dig7YipISfCEsMEy/nQf1ycsDtuHiExFlMz2AdtwNUT+nJfWZzQ
         yKUT4jjwxL7YlKh7GlwEJg79UmCatv9Ng8VBrFKANozUNoGRHug0EqzAAj2q3aFLEz0Y
         Fq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zhioZvV+r4fFwCqQkXpsP5zDQ159hRRkEm/rP3sSAhw=;
        b=fjWgdR1IqSpWvMmfwPW1UuSgYCg4u8X9TXJ6ba8L8m8RxbBwcxkhtC8EfjD4AXWADw
         FNRi+CW0JMhBnkqFuI8chqIiRZP7atQKydzsFgcxv20jeUz74zCyJbTJE8+CJl4xkAZC
         x2XkbqfeRndjUN656bE0GdNTacbuUf0Pc6SBW5LT0qgOPMufBjDXLN3brA8clnM/uwtx
         PAX0RNUg3s7hjf8wdT+IHhyr+9j4MH7SK9dy1zg8Nkr1PSolZZbOUhnwaKy6dCnImMsR
         fgXp6WopSnF5uEn8gkOdT5W6eEvh6Exm8dvggVAp21mbHDJSS8q4zSJDc2tJilqNTOfi
         q6Uw==
X-Gm-Message-State: AOAM530UNuN4p8LwxfE1UpB5QU9FKbFL+hWwvPCquUBgQnGNfvsBX7o7
        AkMiVYxI8A8u/W8CT2T5U5ReGQ==
X-Google-Smtp-Source: ABdhPJwChzvje/sEu0mKBw3x+Gljo8EFgwO/vrqp2ASGrMbMqmQO59kB4L64YDyDW9yC6MKJy06h0Q==
X-Received: by 2002:a65:4347:: with SMTP id k7mr9036167pgq.186.1610653609881;
        Thu, 14 Jan 2021 11:46:49 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i7sm5957229pfc.50.2021.01.14.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:46:49 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:46:49 -0800 (PST)
X-Google-Original-Date: Thu, 14 Jan 2021 11:46:47 PST (-0800)
Subject:     Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
In-Reply-To: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, mick@ics.forth.gr,
        akpm@linux-foundation.org, ardb@kernel.org, rppt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-4458ef4d-9443-491e-9118-aec3596058ed@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 10:33:01 PST (-0800), atishp@atishpatra.org wrote:
> On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
>> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
>> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
>> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>> >
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > ---
>> >  arch/riscv/include/asm/cache.h | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
>> > index 9b58b104559e..c9c669ea2fe6 100644
>> > --- a/arch/riscv/include/asm/cache.h
>> > +++ b/arch/riscv/include/asm/cache.h
>> > @@ -7,7 +7,11 @@
>> >  #ifndef _ASM_RISCV_CACHE_H
>> >  #define _ASM_RISCV_CACHE_H
>> >
>> > +#ifdef CONFIG_64BIT
>> >  #define L1_CACHE_SHIFT               6
>> > +#else
>> > +#define L1_CACHE_SHIFT               5
>> > +#endif
>> >
>> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
>>
>> Should we not instead just
>>
>> #define SMP_CACHE_BYTES L1_CACHE_BYTES
>>
>> like a handful of architectures do?
>>
>
> The generic code already defines it that way in include/linux/cache.h
>
>> The cache size is sort of fake here, as we don't have any non-coherent
>> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
>> cache lines in RISC-V implementations as software may assume that for
>> performance reasons.  Not really a strong reason, but I'd prefer to just make
>> these match.
>>
>
> If it is documented somewhere in the kernel, we should update that. I
> think SMP_CACHE_BYTES being 64
> actually degrades the performance as there will be a fragmented memory
> blocks with 32 bit bytes gap wherever
> SMP_CACHE_BYTES is used as an alignment requirement.

I don't buy that: if you're trying to align to the cache size then the gaps are 
the whole point.  IIUC the 64-byte cache lines come from DDR, not XLEN, so 
there's really no reason for these to be different between the base ISAs.

> In addition to that, Geert Uytterhoeven mentioned some panic on vex32
> without this patch.
> I didn't see anything in Qemu though.

Something like that is probably only going to show up on real hardware, QEMU 
doesn't really do anything with the cache line size.  That said, as there's 
nothing in our kernel now related to non-coherent memory there really should 
only be performance issue (at least until we have non-coherent systems).

I'd bet that the change is just masking some other bug, either in the software 
or the hardware.  I'd prefer to root cause this rather than just working around 
it, as it'll probably come back later and in a more difficult way to find.

>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
