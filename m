Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136D72F3252
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbhALN43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:56:29 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43644 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbhALN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:56:28 -0500
Received: by mail-ot1-f45.google.com with SMTP id q25so2272635otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bewu31Wz6BYeJ3fs1tGieNc7Cxbmk8ZWGMFgmRHxzYM=;
        b=nf1yUJJo2FWFTlJLV15AKXdbf0tsRhNuLmpX7Ge85ezvd8YGAGS0/iC49KIWTzrShS
         qeDPclHDt+cLrq1S5oCtS30Y3zAWVY8PFpwjet2ckrby8XL29/0Fvwgn8rZkg0CleR3O
         XnwUDtfXtcrDifjY1dAEj0m4rn/Ri1SifvHej0rslzoo9HYOGZrmB+OyQhvfPuh/0KxK
         Rdlhon+8WeoorX3CdtUBY69qCjDxenJ0Z4uL9uAqbwtaKXHstxoj1So4pm1bGlrFGSdI
         mzcm48roDo0i6wuzETinIzhbuNQ6OpDamXXbiOwK889c2CRlzTiaRqxsu75/lTvIPdCg
         +cEA==
X-Gm-Message-State: AOAM530HPEeIw4nL+OGqxm5DJdf4Jn0cjg/h1TIV1S0hdHqgqp9k+nE3
        RFdlfw1vpD0SJS8ih7mLrxxnZwrA6PCyg4NGvVkZBTS7yyg=
X-Google-Smtp-Source: ABdhPJyqsv/zc32Ef1sgaxu3RqyHKnI+wz9AokVKR6Fi6eobl+AJ3SaWHGDvlbGhD47al5nqDyg551JsdyMn1qupqCc=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr2834180otc.145.1610459747107;
 Tue, 12 Jan 2021 05:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20210111130251.361335-1-geert+renesas@glider.be>
 <20210111130251.361335-3-geert+renesas@glider.be> <20210112134259.GA44140@workstation>
In-Reply-To: <20210112134259.GA44140@workstation>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 14:55:35 +0100
Message-ID: <CAMuHMdWo6uSBYr=uBWVPBfELfs6g5ZdnLdADakBj5ze9wkq9BQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/2] ALSA: firewire-tascam: Fix integer overflow in midi_port_work()
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakamoto-san,

On Tue, Jan 12, 2021 at 2:43 PM Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> On Mon, Jan 11, 2021 at 02:02:51PM +0100, Geert Uytterhoeven wrote:
> > As snd_fw_async_midi_port.consume_bytes is unsigned int, and
> > NSEC_PER_SEC is 1000000000L, the second multiplication in
> >
> >     port->consume_bytes * 8 * NSEC_PER_SEC / 31250
> >
> > always overflows on 32-bit platforms, truncating the result.  Fix this
> > by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.
> >
> > Note that this assumes port->consume_bytes <= 16777.
> >
> > Fixes: 531f471834227d03 ("ALSA: firewire-lib/firewire-tascam: localize async midi port")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > I don't know the maximum transfer length of MIDI, but given it's an old
> > standard, I guess it's rather small.  If it is larger than 16777, the
> > constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
> > ---
> >  sound/firewire/tascam/tascam-transaction.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Indeed. The calculation brings integer overflow of 32 bit storage. Thanks
> for your care and proposal of the patch. I agree with the intension of
> patch, however I have a nitpicking that the consume_bytes member is
> defined as 'int', not 'unsigned int' in your commit comment.

Thanks, you're right.
Note that port->consume_bytes being signed halves the limit to
8388 bytes, which is of course still met.

> The member has value returned from the call of 'fill_message()'[1] for the
> length of byte messages in buffer to process, or for error code. The
> error code is checked immediately. The range of value is equal to
> or less than 3 when reaching the calculation, thus it should be less than
> 16777.
>
> Regardless of the type of 'int' or 'unsigned int', this patch can fix
> the issued problem. Feel free to add my tag when you post second version
> with comment fix.
>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
