Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4E2F69A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbhANSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:33:53 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:33:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id o6so13103106iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpxBdx9jZ4gaoHzEH4M+jBIaxXM+BhIPyc9ky3KCS6o=;
        b=V4wj5Oc56UgnE2BbRdn3FvtNA61kZC/Q/b0oIttX6nQPNjZVFPUneu+7au70rNmPRH
         RPlY+uYxJxWrO3hT/w9H6mhLaTdPhmGL9cWT97mV+HVefJpBrGQrAR07Fg5Xd4AjsC5g
         QqIeKdsT5dcYLCehHuvRDPfNV9gRQwtc/fBxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpxBdx9jZ4gaoHzEH4M+jBIaxXM+BhIPyc9ky3KCS6o=;
        b=K7YTCLCxkod+oZEk0KjQ4PnLfRzoYlrrtGMXYV9JvmuZxlQ3aR5CU1LOCIK5+quQmG
         wYcSzBdOgOhIp2qgLTNHG1OvejcnsNM4rhfNnvAk5kryOV2tTRsO6oOn2Y4FHZ5F0n8R
         6iqNqbSpjH1HdnzwoGj4JY2UZwMuq/9sLW7Go91oCMIsZPLWzmWL7WNYCtZc9J2yPAol
         ac+vCXxqOZQ850ek7qZoQkICtEPEKVlPE4NdB9RpIIGxyrXTRmSQFszcE/N8rzD8FjJm
         3+6wUOOg4N3truhl+AwP7j2eIySiXYI97cLggLQcLYPEA6B/gepU7/b+68G0NNfUYvFz
         iwmQ==
X-Gm-Message-State: AOAM532K5CQs3tDQ2U78051la+xV+dDhEjpt4b6xGxSZYdzlfAGL28Jl
        xglXhPeEpRUkyV3/G5LQTqSgPr15kxvI2onwvMID
X-Google-Smtp-Source: ABdhPJzZpwCw+Xdqndp0caPskWocj1SFY7nvD8xb8MXxAlTFcWEDEuswl4lapPjjbYsU4P4plg7idsNMUMY4nFl3wt4=
X-Received: by 2002:a02:b011:: with SMTP id p17mr7502137jah.114.1610649192495;
 Thu, 14 Jan 2021 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-4-atish.patra@wdc.com> <mhng-1400a3dd-651b-4a78-bb2d-1f10580add75@palmerdabbelt-glaptop>
In-Reply-To: <mhng-1400a3dd-651b-4a78-bb2d-1f10580add75@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 14 Jan 2021 10:33:01 -0800
Message-ID: <CAOnJCU+mCPwbeOQpmHmu3ar_17otmgftiKHLL+Z4_nExpj0=cA@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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

On Wed, Jan 13, 2021 at 9:10 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 07 Jan 2021 01:26:51 PST (-0800), Atish Patra wrote:
> > SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> > 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> > allocation if it is requested to be aligned with SMP_CACHE_BYTES.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/cache.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > index 9b58b104559e..c9c669ea2fe6 100644
> > --- a/arch/riscv/include/asm/cache.h
> > +++ b/arch/riscv/include/asm/cache.h
> > @@ -7,7 +7,11 @@
> >  #ifndef _ASM_RISCV_CACHE_H
> >  #define _ASM_RISCV_CACHE_H
> >
> > +#ifdef CONFIG_64BIT
> >  #define L1_CACHE_SHIFT               6
> > +#else
> > +#define L1_CACHE_SHIFT               5
> > +#endif
> >
> >  #define L1_CACHE_BYTES               (1 << L1_CACHE_SHIFT)
>
> Should we not instead just
>
> #define SMP_CACHE_BYTES L1_CACHE_BYTES
>
> like a handful of architectures do?
>

The generic code already defines it that way in include/linux/cache.h

> The cache size is sort of fake here, as we don't have any non-coherent
> mechanisms, but IIRC we wrote somewhere that it's recommended to have 64-byte
> cache lines in RISC-V implementations as software may assume that for
> performance reasons.  Not really a strong reason, but I'd prefer to just make
> these match.
>

If it is documented somewhere in the kernel, we should update that. I
think SMP_CACHE_BYTES being 64
actually degrades the performance as there will be a fragmented memory
blocks with 32 bit bytes gap wherever
SMP_CACHE_BYTES is used as an alignment requirement.

In addition to that, Geert Uytterhoeven mentioned some panic on vex32
without this patch.
I didn't see anything in Qemu though.


> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
