Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D92F6584
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbhANQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:12:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:11:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id o11so5646790ote.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI7DNB9PJvzlL1ZP9cY7fdOx2/ptLeVjeZhhrDDi7c4=;
        b=Zi8S4ocJOhLeZPI7DA82w2n/RGNymWj4EnipZ421KIVCN3q+pn6FHQlQjVv4fbVCTq
         Arl+l+jzarPBMM/Q4vO6TR9DcPVhQMO9VvuyqHQXyLCv+FfsVMoypWDiVtBzddb+YuxA
         K1x1YV7KyaUREwbkOGl2QJAf+Oot3y9DhjTh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI7DNB9PJvzlL1ZP9cY7fdOx2/ptLeVjeZhhrDDi7c4=;
        b=a+WSZvcXfMAIjyoZOs4t/O1yi8z2mSxIY9bB0kcfSeBwIn+p59zr1ggYR1W6qd2XfN
         xCUhgFywVX4Nktn/VFVosJAnBUf043SApaD9GBwrWFD5PIANE86xLQVPmqIS2QFnb8gy
         3GS/YSJ+jMNn5afvTnQOh4zS/J7yJutoS8pqEeTZLNEeb/8rY29SYOpDNb0yXR6sqt7j
         4mKVhSv0RrtZUZXhxD+qfxnbCahCFwhYuW++bQ9YsNJhIEsXIlHSaXwkoROEzNoiO2Vr
         ljQXOD3Wq+xIb1ktb3ssbIVTgkOlgg7ciPUEEgXPnTYNk3wVSlQF7Q9PtlMNg6MwEmMD
         8k+Q==
X-Gm-Message-State: AOAM531gCS8qaE2AbZolTl64b9obSBdExaSeV6IqMzm2MxmndcjcpyvI
        Vod0muK0crHfBVvfYx/OUNWms2yYObzrCImAV0JW8A==
X-Google-Smtp-Source: ABdhPJzzz22o9OQD7ab1kI0cLaSVhXvWLJ9AS4BVjPKCWnUBdp3at3x0E09pBUvROlXehDbVAiUAp+GHsISnTag0oIg=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr4945559otb.303.1610640679142;
 Thu, 14 Jan 2021 08:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com> <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
In-Reply-To: <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 14 Jan 2021 17:11:07 +0100
Message-ID: <CAKMK7uEwHu5GLF16wn83PLZUjoJWgF0dcLXwsGkt_aBpOgLt+w@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Susi <phill@thesusis.net>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Daniel,
>
> CC linux-fbdev
>
> On Tue, Jan 12, 2021 at 5:00 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Jan 9, 2021 at 12:11 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
> > > > > Could we pause this madness? Scrollback is still useful. I needed it
> > > > > today... it was too small, so command results I was looking for
> > > > > already scrolled away, but... life will be really painful with 0
> > > > > scrollback.
> > > >
> > > > > You'll need it, too... as soon as you get oops and will want to see
> > > > > errors just prior to that oops.
> > > >
> > > > > If it means I get to maintain it... I'm not happy about it but that's
> > > > > better than no scrollback.
> > > >
> > > > Amen!  What self respecting admin installs a gui on servers?  What do we
> > > > have to do to get this back in?  What was so buggy with this code that
> > > > it needed to be removed?  Why was it such a burden to just leave it be?
> > >
> > > It really was buggy, with security implications. And we have no maintainers.
> > >
> > > So the scroll-back code can't come back until we have a maintainer and
> > > a cleaner and simpler implementation.
> > >
> > > And no, maintaining it really doesn't mean "just get it back to the
> > > old broken state".
> > >
> > > So far I haven't actually seen any patches, which means that it's not
> > > coming back.
> > >
> > > The good news? If you have an actual text VGA console, that should
> > > still work just fine.
>
> IIRC, all of this was written for systems lacking VGA text consoles
> in the first place...
>
> > Also on anything that is remotely modern (i.e. runs a drm kernel
> > modesetting driver undearneath the fbdev/fbcon stack) there's a pile
> > more issues on top of just the scrollback/fbcon code being a mess.
>
> Would it help to remove DRM_FBDEV_EMULATION (instead)?

It's a problem with the hardware. "Write some registers and done"
isn't how display blocks work nowadays. So your proposal amounts to
"no fbdev/fbcon for anything modern-ish".

Also I said "a pile more", most of the issues in fbcon/fbdev code
apply for all drivers.

> > Specifically the locking is somewhere between yolo and outright
> > deadlocks. This holds even more so if the use case here is "I want
> > scrollback for an oops". There's rough sketches for how it could be
> > solved, but it's all very tricky work.
>
> When an oops happens, all bets are off.  At that point, all information
> you can extract from the system is valuable, and additional locking
> issues are moot.

Except the first oops then scrolls aways because it's getting buried
under further fail. Your locking needs to be minimally good enough to
not make the situation worse.
-Daniel

> > Also adding dri-devel since defacto that's the only place where
> > display people hang out nowadays.
>
> Please keep on CCing linux-fbdev, especially for patches removing
> fbdev features.
>
> Thanks!
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



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
