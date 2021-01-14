Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19A2F57A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbhANCEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbhANCDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:03:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7BC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:03:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id md11so2252011pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/59kB1O5XIVx4wkhix0uTI9M83ghuwediLtzMt/ydBU=;
        b=hMgyZ0xWZXRDy8tBW0qOIwh+Xe7D8eY37gm1btzh5tZbvbHil34ZvT9v/bxYeUBFQY
         GDmvsv/lcJ98YUN88Plde66JeOnXZyw8/rFSlei6Jdq/k8K2ft40iwR5cVBPn8qIijks
         WcglGx7KYHon9U9Xx1kjTDAaCWaOPYzXbZzn8qAQakbcw3AlmbBBMYhA7nrPpPx1Uq7p
         QF8zG0ZalqAwZ+ksqQM/xkStlgAJ7ZOyFN8/IjTw8wk4vgkmzl3lh35+wyhuoar+Hn9p
         WDnuv4FtVJs7wzXVk1Y+vxAULFRRWZWUat8zc4dLez2OKQKFTLhbgCcTAQoXWc1VlifE
         uR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/59kB1O5XIVx4wkhix0uTI9M83ghuwediLtzMt/ydBU=;
        b=q8juAv8XGM+SESXRIrY9kNTc7yNoTStchpLsC4syu8l/bOWZOWlDOsJEJtvi2lVj8u
         +AUnKcj3ROiK3GjumTZn9NJmElA1bODgpgN87g+HUC55053iJS7COFS4tZIOR4eWjGna
         /EpYjyyqwGdjfuxh86yFnEI4miPK90lAQrb2dS1J6hdS6qOee3OQFz8wdJMLJZ0om9/J
         gkaNrn+0tflh/7RII1gPEnPKRtfF0sAQqRKn2pcwm0M/pfc8UxanCkO+bfr910Shd7Bp
         8uQR+tnp7dp3CTo58wPHgusMZnHBMBCfOy/iUXA0Hd44J6DgSQVuWIAGFfwE9BzcjD/+
         sP3g==
X-Gm-Message-State: AOAM532Fh8ZSeLZ6qNrsW3zaj5LXAijQt5HmB8uVQKJJS2O24mvetCHU
        BGUlGGSBKhdOlT849RktfCI=
X-Google-Smtp-Source: ABdhPJz6RVp8xXM12Kc+tzA7oP/A24jYoxwPWUFPY3GjYTDJEeBLPPNN9KWE/Xvw/6NFqJ0e9TzsFA==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr2403589pjb.199.1610589794397;
        Wed, 13 Jan 2021 18:03:14 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id u1sm3878281pjr.51.2021.01.13.18.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:03:13 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:03:11 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] drivers/soc/litex: Add restart handler
Message-ID: <20210114020311.GE2002709@lianli.shorne-pla.net>
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Let the LiteX SoC Controller a register a restart handler, which resets
> > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Tested with linux-on-litex-vexriscv.
> >
> > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > CPUs"
> > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> 
> Bummer, and that's why the RESET_REG_* definitions are no longer
> next to the SCRATCH_REG_* definitions :-(

If it helps I have accepted Gabriel's patches and put them onto for-next.

  https://github.com/openrisc/linux/commits/for-next

I am happy to take and test a patch based on that.  Or I can do the adjustments
to base the patch on that myself.  Let me know.

-Stafford

> Well, I assume that will be fixed by evolution ;-)
> 
> > v2:
> >   - Rebase on top of v5.11-rc1,
> >   - Change reset handler priority to recommended default value of 128
> >     (was 192).
> >
> > (v1 was not sent to a mailing list)
> > ---
> >  drivers/soc/litex/litex_soc_ctrl.c | 33 +++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > index 1217cafdfd4d1d2b..d729ad50d4ffca5e 100644
> > --- a/drivers/soc/litex/litex_soc_ctrl.c
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -15,6 +15,11 @@
> >  #include <linux/module.h>
> >  #include <linux/errno.h>
> >  #include <linux/io.h>
> > +#include <linux/reboot.h>
> > +
> > +/* reset register located at the base address */
> > +#define RESET_REG_OFF           0x00
> > +#define RESET_REG_VALUE         0x00000001
> >
> >  /*
> >   * LiteX SoC Generator, depending on the configuration, can split a single
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
