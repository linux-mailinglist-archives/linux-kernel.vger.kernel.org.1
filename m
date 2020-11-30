Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F02C88E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgK3QE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgK3QE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:04:56 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDD3206D5;
        Mon, 30 Nov 2020 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606752255;
        bh=OKizQehPufOsCKn6ePfX0wM4iNsQxAsdx3z7gn7uXNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n5o/7PaW8e+MJFjLTX9a7bF2vZhcE/MvcqwbHV8en45mide+dXXTEeqAA+aEY1pjl
         JGGLNfEaN4paNFN1xhlksWVBotGarDJtFUbfRU436dxAL92yG6BQF8q8bnOfR4Ya3A
         yuHEP5DsFFTXsLwL7iRZOI1XUEkL2IW/HoDOus0U=
Received: by mail-oo1-f53.google.com with SMTP id z13so2787930ooa.5;
        Mon, 30 Nov 2020 08:04:15 -0800 (PST)
X-Gm-Message-State: AOAM533FxTuR1JSxWQ/i7CmCqCmMKqu9AAOAOQs0Z/+R21ylIfR4OEUe
        uKP0lnoQGylZhrTUKLLUJ6hM3oSX2ZzCQKa15IQ=
X-Google-Smtp-Source: ABdhPJwO0OcyppzAFxXiC9ksMmD7xi6slop9CL8rc7rks9bONP+F1VWCvg0c5OxAIGzkt5dp0AYxBKkOECM50AUbaN0=
X-Received: by 2002:a4a:d8d0:: with SMTP id c16mr5118495oov.26.1606752254399;
 Mon, 30 Nov 2020 08:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-10-daniel@0x0f.com>
 <CAK8P3a15Q=97iWyGu6=2aKfVtrYNL2BgmszHqoqYxFT_uHoP4A@mail.gmail.com> <CAFr9PXksWa_u9TSz6FpTvB0fFMQvpTua7EVKKnfUutmZVtWq6A@mail.gmail.com>
In-Reply-To: <CAFr9PXksWa_u9TSz6FpTvB0fFMQvpTua7EVKKnfUutmZVtWq6A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 Nov 2020 17:03:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GpMb5uQnrorvd360MNKhQCjR0zO4vfYTzqBN8P8qpuA@mail.gmail.com>
Message-ID: <CAK8P3a1GpMb5uQnrorvd360MNKhQCjR0zO4vfYTzqBN8P8qpuA@mail.gmail.com>
Subject: Re: [PATCH 9/9] ARM: mstar: SMP support
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:25 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Arnd,
>
> On Mon, 30 Nov 2020 at 22:42, Arnd Bergmann <arnd@kernel.org> wrote:
> > > +struct smp_operations __initdata mstarv7_smp_ops  = {
> > > +       .smp_boot_secondary = mstarv7_boot_secondary,
> > > +};
> > > +#endif
> >
> > So no hotplug operations?
>
> Not yet. There are controls to power down different bits of the chip,
> assert internal resets and so on so it might be possible to add that
> later but I haven't worked out where those bits are yet for the second
> cpu.
>
> > Or better, use CPU_METHOD_OF_DECLARE() instead of smp_ops.
>
> I'll do that for the v2.

Ok.

> Was there anything else that looked fishy? Every other platform seems
> to have a lot of code for moving secondary CPUs from the boot ROM into
> somewhere the kernel can control the order in which they come online
> (vendor code has a copy/paste of the vexpress code) so I was worried I
> missed something.

No, it looks fine to me, but I'm not an expert in this area.

As far as I can tell, platforms will either execute from bootrom with
the secondary_startup function in a register like you have, or
they start from SRAM, with that function somewhere else, but
you wouldn't need both.

           Arnd
