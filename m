Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6682ADA32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgKJPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbgKJPTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:19:48 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F31020797
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605021587;
        bh=8lVT8ZTeoFlItoKh81HPlqRLu1gJHbWcAi9s/4Gzj5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cWZPUcMkGN53XOO0sX/uhI4Z+bD+M9kepq6pEyirF4jKTgg0ab+rb5jSJdWFBBWMu
         2f+Qjmvp1LLqKEErSdAtaS4vHvPAOMkwVLJVUUk8YCEKfVlOI1Elnwyou+SPBpZhWK
         lajAE0l4g5HsJ8RLryW6JEcErM+vTqDKsAL1pP/4=
Received: by mail-oo1-f52.google.com with SMTP id y3so3024313ooq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:19:47 -0800 (PST)
X-Gm-Message-State: AOAM530bdg9w5Ps9LklCbnpD++LW7DJSqz+F0Z0pVQOfUejhZ0LqXzKF
        MthkBUe6EyDiWJzZeqEEPrB6c1limM6n22gDPSs=
X-Google-Smtp-Source: ABdhPJxHJ4rn2y+LU64am7Qu4sz45dFM6TgFIYN58j0maUyG4lRin3+55hak13o49DgoPPw2dXXkWGOow1bf4DbIfM8=
X-Received: by 2002:a4a:e96d:: with SMTP id i13mr13769802ooe.66.1605021586822;
 Tue, 10 Nov 2020 07:19:46 -0800 (PST)
MIME-Version: 1.0
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org> <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org> <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <48fdc3631bc74dd77fea1a30085c8af9@agner.ch>
In-Reply-To: <48fdc3631bc74dd77fea1a30085c8af9@agner.ch>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 16:19:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1JEthD7j0qM05Vm94OpbTFqi_7+pe7LKX7eaANES7i+g@mail.gmail.com>
Message-ID: <CAK8P3a1JEthD7j0qM05Vm94OpbTFqi_7+pe7LKX7eaANES7i+g@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Stefan Agner <stefan@agner.ch>
Cc:     Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 1:24 PM Stefan Agner <stefan@agner.ch> wrote:
> On 2020-11-10 12:21, Arnd Bergmann wrote:
> > Good idea. I wonder what other architectures need the same though.
>
> >> That's what x86 does:
> >>
> >> $ git grep -w MAX_POSSIBLE_PHYSMEM_BITS arch/
> >> arch/x86/include/asm/pgtable-3level_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS   36
> >
> > Doesn't x86 also support a 40-bit addressing mode? I suppose
> > those machines that actually used it are long gone.
> >
> >> arch/x86/include/asm/pgtable_64_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS       52
> >>
> >> It seems that actual numbers would be 36 for !LPAE and 40 for LPAE, but
> >> I'm not sure about that.
> >
> > Close enough, yes.
> >
> > The 36-bit addressing is on !LPAE is only used for early static mappings,
> > so I think we can pretend it's always 32-bit. I checked the ARMv8 reference,
> > and it says that ARMv8-Aarch32 actually supports 40 bit physical addressing
> > both with non-LPAE superpages (short descriptor format) and LPAE (long
> > descriptor format), but Linux only does 36-bit addressing on superpages
> > as specified for ARMv6/ARMv7 short descriptors.
>
> Oh so, more than 4GB of memory can be supported by !LPAE systems via
> superpages? Wasn't aware of that.

Not really, we only really use it for MMIO mappings, and only on the
Xscale3 CPU. Support for this was originally added for IXP23xx,
and the same core is present in IOP13xx and PXA3xx, but only the
last one of these is still supported in mainline, and I don't know if it
actually has anything outside of the 32-bit address space
(arch/arm/mach-pxa/include/mach/addr-map.h suggests it does not)

Russell might remember more details here, and if there is a reason
to keep IO_36 support working after we removed IXP23xx back
in 2012 and never enabled it for ARMv6 or v7. I suppose removing
it would only change a few lines in asm/domain.h, as we'd still
want to keep supersection support regardless.

> Since only ARM_LPAE selects CONFIG_PHYS_ADDR_T_64BIT it really is safe
> to assume 32 bits for non-LPAE systems.
>
> I guess that would mean adding a #define MAX_POSSIBLE_PHYSMEM_BITS 32 to
> arch/arm/include/asm/pgtable-2level.h and a MAX_POSSIBLE_PHYSMEM_BITS 40
> in arch/arm/include/asm/pgtable-3level.h. Seems straight forward and
> would solve the problem I had. I can prepare a patch for ARM, not sure
> about the other architectures...

I think I can help with that once we have agreed on a patch for ARM.

     Arnd
