Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9FC2FB3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbhASICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:02:39 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41861 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbhASH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:59:54 -0500
Received: by mail-ot1-f48.google.com with SMTP id x13so18940658oto.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50LoqJ0vcbBGTat2MdC306m45dAPIXcmM7OGo1AqWqQ=;
        b=CBxShEvf8xEWL/0Dmmhd1kZM2m7iOiV0QnFJanCNMD5SNhRyrlJn/OkGpT8xlDstNY
         tUIKBodpIjCp+s2um8mWAaEcOGLV4eV5HXRDCb/Rub4jNIlZ5+k+u1kB+FF6iL42yu3J
         CvaFANIQNkv86xf9FWtdSuFZn9L41ALyor6RneyvK7l9TA8DQMo+ZC/AxR1aA5GFow3w
         DdPkdC0KLpe+GfKgEO3YaPFGNG1AIwtoocgy/Yo0V7ImYgmTGPHhoaLqbP7VJjEIsTvj
         v/NfVq3FXD8tIlbkkqzq+WcKeIgDAD/6clzEFLAWcIyQKH3i5XFVZnjTIY9NuCJWG4xv
         2Rvg==
X-Gm-Message-State: AOAM5333+E0ZFxU+6Ia3Va5uQDgpjBhyA5sakG8BG9/ptquha8z8sst3
        NFrFnNLUrDSgRMm6VX4SIUmaDcvM9hyd4UBTCZYWvgOO
X-Google-Smtp-Source: ABdhPJz/WliAIvO0lI5a1zlFdgSSgBDzpNZaaOdrNvaOBvgBhtPOxwVGjna9pxcuoaXmPPw3jpupDfNrku6M8CJ0b7Q=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2586166oth.250.1611043153659;
 Mon, 18 Jan 2021 23:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
 <20210114020311.GE2002709@lianli.shorne-pla.net> <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
 <20210118114331.GF2002709@lianli.shorne-pla.net> <CAMuHMdUxAEE2A=dyhdH5Tscin_=m_b61WfRpLvj6pJfdPjd1nA@mail.gmail.com>
 <20210118211554.GH2002709@lianli.shorne-pla.net>
In-Reply-To: <20210118211554.GH2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jan 2021 08:59:02 +0100
Message-ID: <CAMuHMdU4AyL=tWU5p5rZOGBet1BtpG3H2mnwcO0du29-dmK34w@mail.gmail.com>
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

On Mon, Jan 18, 2021 at 10:16 PM Stafford Horne <shorne@gmail.com> wrote:
> On Mon, Jan 18, 2021 at 01:27:32PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Jan 18, 2021 at 12:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Thu, Jan 14, 2021 at 02:48:49PM +0100, Geert Uytterhoeven wrote:
> > > > On Thu, Jan 14, 2021 at 3:03 AM Stafford Horne <shorne@gmail.com> wrote:
> > > > > On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > > > On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > Let the LiteX SoC Controller a register a restart handler, which resets
>
> I think there is a typo here:
>
>   Let the LiteX SoC Controller a register a restart ...
>
> should remove the first 'a' and say
>
>  Let the LiteX SoC Controller register a restart ...
>
> > > > > > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > > > > > >
> > > > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > ---
> > > > > > > Tested with linux-on-litex-vexriscv.
> > > > > > >
> > > > > > > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > > > > > > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > > > > > > CPUs"
> > > > > > > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> > > > > >
> > > > > > Bummer, and that's why the RESET_REG_* definitions are no longer
> > > > > > next to the SCRATCH_REG_* definitions :-(
> > > > >
> > > > > If it helps I have accepted Gabriel's patches and put them onto for-next.
> > > > >
> > > > >   https://github.com/openrisc/linux/commits/for-next
> > > > >
> > > > > I am happy to take and test a patch based on that.  Or I can do the adjustments
> > > > > to base the patch on that myself.  Let me know.
> > > >
> > > > Thanks for letting me know! V3 sent.
> > >
> > > Hi Geert,
> > >
> > > I don't seem to see v3 anywhere.  Where did you send it and what is the subject?
> >
> > https://lore.kernel.org/linux-riscv/20210114134813.2238587-1-geert@linux-m68k.org/
> >
> > So "b4 am 20210114134813.2238587-1-geert@linux-m68k.org" should give you
> > a copy.
>
> Thanks I got it, I am not sure why it does not show up in my inbox anywhere,
> sometimes gmail drops mails.  Hence, I am replying here.

You may want to add a rule to never mark as spam emails with "PATCH"
in the subject.  And check your spam folder regularly, and teach gmail by
marking non-spam as non-spam.

> As per the typo above I can fix during applying or you could send during a v4.
>
> One more small nit is that you move soc_ctrl_dev out to a static instance it
> might help to mention.  But it's easy to see why.

Found a way to get rid of it.  Will send v4 shortly.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
