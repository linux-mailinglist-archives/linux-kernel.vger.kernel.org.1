Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869532F6262
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbhANNtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:49:42 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:38538 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbhANNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:49:41 -0500
Received: by mail-qk1-f171.google.com with SMTP id w79so7789215qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgOQR0ROatSAdWiCA9RFh4hh92+P9x5T4fMU/ADXeio=;
        b=fII9md2MyMtc7duFvBgNNYwOY4AUZvlvy2EIItm4cAJQ3OSBo8MqyqdEh6CG1S6wMd
         AuWu7DEZ7ItrXWKZw/6/hlM45L+hFUu7EH7V+1tTmxwSG5pH2ZGVsyy1E9ZAvJtNO8sf
         JcSgbfQeTlqJgqKHlgBStuk/lgakf6fLceup2BP5Hy6nIrHRfE/vxCaHdBY0jDh+tJcv
         GgoraNWzMsb3r7NuGHYs/YKBpzLMj87lbJoPYRI5RaK6mauvH+YbaJDbIXxa/bcSr8CG
         LVEjqEgKpoW+a1/MErUHTW3+KJm3c5UBJLG8jfsSoQD+Nq4zHaouuTHbmaX33Pd/Clvh
         tJEA==
X-Gm-Message-State: AOAM530VYiVltHyRULQiqUFxJYZDfeEglxbsAOqRR4pNZxV0NFLmKoTf
        vqQABD+JHAP/lElvmtCfsF4hNvAxAlibrWbgqhaOAJAW
X-Google-Smtp-Source: ABdhPJzNRR0ADJSP8ugt+v1di48mmLOOlzIZrSX/WuzhPkSewYII3Y6I2ljXxsm6yxEZR14d+rHun6XCbBLF87TnyJ4=
X-Received: by 2002:a37:a950:: with SMTP id s77mr7219663qke.122.1610632140676;
 Thu, 14 Jan 2021 05:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com> <20210114020311.GE2002709@lianli.shorne-pla.net>
In-Reply-To: <20210114020311.GE2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jan 2021 14:48:49 +0100
Message-ID: <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 3:03 AM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Let the LiteX SoC Controller a register a restart handler, which resets
> > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > Tested with linux-on-litex-vexriscv.
> > >
> > > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > > CPUs"
> > > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> >
> > Bummer, and that's why the RESET_REG_* definitions are no longer
> > next to the SCRATCH_REG_* definitions :-(
>
> If it helps I have accepted Gabriel's patches and put them onto for-next.
>
>   https://github.com/openrisc/linux/commits/for-next
>
> I am happy to take and test a patch based on that.  Or I can do the adjustments
> to base the patch on that myself.  Let me know.

Thanks for letting me know! V3 sent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
