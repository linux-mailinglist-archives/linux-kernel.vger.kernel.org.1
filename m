Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097AD2FA276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392595AbhARODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:03:52 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40031 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391219AbhARM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:28:31 -0500
Received: by mail-oi1-f169.google.com with SMTP id p5so17502505oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaIQafbLKqUO8DmT84Dip1Hdgpm2ABLHEOu0dotUJU8=;
        b=AjSr0ycv3JbPljN6WDE/2BrAr7YQw2Kq6K+elgpi4FBdcFCRVxR4egQ80t9JEGJFsi
         xJlY+hEcwfDhScDhou+pe/uu8AyqGxi6laXS3vEQbxjYvR5UXji/UPDtw22XfTVlyEcc
         P44PNguu4UXP2nPDnQyeWr8YY0/vsJwg5R8f9lgJWa/SnAZtizEYLaDZL3I341c97gY1
         3WEdsdBncm1bKHu1HuFE3uugDyGEBcBlqcE6scVavaJl6mJffhwbH7bzNNqbI4bRF1iF
         lcNqI2evmxjjjzStvAimJw1Mi76jRw1M++1S3bQiip2acnMNpzUVyDdMfeku4Q8j0rTb
         ZSdw==
X-Gm-Message-State: AOAM532jchCUm4lD7BZE64tHyzSn0vgwwB+XVkUemAf1erG6Xhu8OPuo
        tG4iw7fO+KWVPLftOB6fLNmX33hYw8cbU57ohOI=
X-Google-Smtp-Source: ABdhPJz1GwiXU+qWm//9EYtjp1S5Xk44DKAOE51qMOGR9tXIV7MeqE7Ob/7JcwZKUurBwZ/zWL7Lg0u4zmzzhoyyCe0=
X-Received: by 2002:aca:31d5:: with SMTP id x204mr5249304oix.153.1610972863647;
 Mon, 18 Jan 2021 04:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
 <20210114020311.GE2002709@lianli.shorne-pla.net> <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
 <20210118114331.GF2002709@lianli.shorne-pla.net>
In-Reply-To: <20210118114331.GF2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jan 2021 13:27:32 +0100
Message-ID: <CAMuHMdUxAEE2A=dyhdH5Tscin_=m_b61WfRpLvj6pJfdPjd1nA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/soc/litex: Add restart handler
To:     Stafford Horne <shorne@gmail.com>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Mon, Jan 18, 2021 at 12:43 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jan 14, 2021 at 02:48:49PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Jan 14, 2021 at 3:03 AM Stafford Horne <shorne@gmail.com> wrote:
> > > On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > Let the LiteX SoC Controller a register a restart handler, which resets
> > > > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > ---
> > > > > Tested with linux-on-litex-vexriscv.
> > > > >
> > > > > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > > > > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > > > > CPUs"
> > > > > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> > > >
> > > > Bummer, and that's why the RESET_REG_* definitions are no longer
> > > > next to the SCRATCH_REG_* definitions :-(
> > >
> > > If it helps I have accepted Gabriel's patches and put them onto for-next.
> > >
> > >   https://github.com/openrisc/linux/commits/for-next
> > >
> > > I am happy to take and test a patch based on that.  Or I can do the adjustments
> > > to base the patch on that myself.  Let me know.
> >
> > Thanks for letting me know! V3 sent.
>
> Hi Geert,
>
> I don't seem to see v3 anywhere.  Where did you send it and what is the subject?

https://lore.kernel.org/linux-riscv/20210114134813.2238587-1-geert@linux-m68k.org/

So "b4 am 20210114134813.2238587-1-geert@linux-m68k.org" should give you
a copy.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
