Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB727AE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgI1M6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:58:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47081 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1M6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:58:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 95so746118ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3saIS3hHmut30qTXV6lWeJ53gdiOKPXligB+1QcwTJU=;
        b=EDCcQm/a9ej2u+4vBjaaNTK1LWxEQEOCBjEeejGYkwhcWhoJsLp5Ja9ADNBEJbV9cR
         1JjDHdZG8IPYBCQhXT7Oq5EnDBzD2ucqvth0KXswfMunNpUIi5XoH+SF5inz6H6W+ZwW
         WkbWJHSbjLZdjvfSowrDp18HgmhZVgyhrz1jm/1oXoPyXmPfQukdHH/b/Lg87YEb8OoP
         pf8lo6zV5vixlgvwGMdxR9uJYSNX5it1jQoQuudBrqa15lorzHeYJyJD5T4LCGNv4SrL
         PTV9XSZeHRNfd/42+h7MkvwTP7eDnXK1mOLN+q2U3Yyq1CQQ0R66lxib0t/U3A+qX1/v
         X/rg==
X-Gm-Message-State: AOAM530vy1EuKUZe0TFfTffMGbaZqZIQ++/Y2Vq7hzQCg/vvYqqymm+D
        jI3CwlmU+SE7Ivetghy3u/3gW2C18Df2+yaevKg=
X-Google-Smtp-Source: ABdhPJy1GXHmBYkrYjhw8L10FVIRtTxjX47/xIIfxeNFvlfVbbPFpss+xVpzuDTTXDyA5SU9gQc0Ewv27FRCa1/afcA=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr791234otp.107.1601297891277;
 Mon, 28 Sep 2020 05:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
 <20200928092641.2070-3-thunder.leizhen@huawei.com> <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
 <e2d45592-ffc3-395e-0657-dcff0e094c1f@huawei.com> <CAMj1kXEXziNDWxKNmD9nPWCmhpAPO--vWvJvr2nioQL+QJBfBQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEXziNDWxKNmD9nPWCmhpAPO--vWvJvr2nioQL+QJBfBQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Sep 2020 14:57:59 +0200
Message-ID: <CAMuHMdWHa-o=-a8VM+NCpxGoTEeTcm4v1FSrA17xVKzyuZDj9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: decompressor: relax the loading restriction of
 the decompressed kernel
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On Mon, Sep 28, 2020 at 2:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 28 Sep 2020 at 13:57, Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
> > On 2020/9/28 18:14, Ard Biesheuvel wrote:
> > > On Mon, 28 Sep 2020 at 11:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > >>
> > >> mov     r4, pc
> > >> and     r4, r4, #0xf8000000     //truncated to 128MiB boundary
> > >> add     r4, r4, #TEXT_OFFSET    //PA(_start)
> > >>
> > >> Currently, the decompressed kernel must be placed at the position: 128MiB
> > >> boundary + TEXT_OFFSET. This limitation is just because we masked PC with
> > >> 0xf80000000. Actually, we can directly obtain PA(_start) by using formula
> > >> : VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).
> > >>
> > >> So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
> > >> and so on.
> > >>
> > >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > >
> > > No, this won't work.
> >
> > But it works well on my board.
> >
>
> That is because you load zImage at the base of DRAM.
>
> > >
> > > The whole reason for rounding to a multiple of 128 MB is that we
> > > cannot infer the start of DRAM from the placement of the zImage (which
> > > provides _start).
> >
> > Maybe this is further guaranteed by the following code:
> >         /*
> >          * Set up a page table only if it won't overwrite ourself.
> >          * That means r4 < pc || r4 - 16k page directory > &_end.
> >          * Given that r4 > &_end is most unfrequent, we add a rough
> >          * additional 1MB of room for a possible appended DTB.
> >          */
> >
> > In addition, the Image has already been loaded when this position is reached.
> >
> > ----------- <--128MiB boundary
> > |          |
> > ----------- <--TEXT_OFFSET <--
> > | (1)Image |                 |
> > ------------                 |
> > |          |                 |
> > -----------  (2)--copyto-----
> > | (2)Image |
> > -----------
> >
> > I don't think it's the case of (2), but (1). Because no code modification is
> > required for the case (2).
> >
> > By the way, I'm not familiar with the arm32 code, so I'm just speculating.
> >
>
> The zImage code that runs has not received *any* information from the
> platform on where DRAM starts, so the only info it has is the current
> placement of zImage.
>
> So when zImage is loaded at the intended base of DRAM, things work fine.
>
> If the zImage is loaded close to the end of a 128 MB region, the
> rounding would pick the start of that 128 MB region. However, the
> _start symbol you are using will point to an address that is close to
> the end of the 128 MB [given that it is inside zImage] so your logic
> will pick an address that is much higher in memory.

https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses
https://people.kernel.org/linusw/how-the-arm32-kernel-starts
are good reads.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
