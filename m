Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69782DF487
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgLTIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgLTIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:55:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B9C0613CF;
        Sun, 20 Dec 2020 00:54:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so16441690lfr.3;
        Sun, 20 Dec 2020 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0/DvVS3xr9IFVHJ6w0VNsbknvI4afWy9yhS+q7bTbbY=;
        b=DqnCBnMOfBR/HYUi5ctKqUhQPyM4dPYenWNznAoFvLpRe22gr6A3/f0QPV+wj3EFiQ
         cW1n6dvSKA+WHYDJSPdr+3lr+8bee6rrq18m4RFAjop0BSzOUrU2aMh7i4rmIfVAQhj+
         iNWBsjLn5QryswFIs+2sKhN9SjQUj47KTtMKeWwWUhu4wLfyLr+5gRnYF2XdHXIv16DM
         eB1u3N9dlCxZn7C7gGwCLbs0LNY+jjf0TM9UdT1JTw/zQdN9k1iCcUdd6CcaW+Mzv6Mv
         CVCTSKzOnKjPja0Vo13i/WJaB1b5dSfPDQIUAZ8EXS92xdy6iG7C7xxfVbaV3b7Z/vJG
         Tojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0/DvVS3xr9IFVHJ6w0VNsbknvI4afWy9yhS+q7bTbbY=;
        b=m0KorTgJmERNqk1uDVEWeSO5UQtl9I430XcIwFX6c2+WrB3xZrG7vW774KPpi0pAtq
         6ffFE4LAEccVQ652nrMiC8umEuEnZ8A6FoRymW2fvyP0xDwQHUTYvOfhK3duD91grNWc
         PXA5hdQZU441O6Ch4ozmtWJsTU5Y/9zeiSv/jBfYvRDIQkK8SZ2rsnOQ6V4toqpNtQAy
         yLuCrtyMYpTt/pQcGfBdwEQuOAVdz5wek5/YM6TkPeWPRSbGcl6sj95OnN/dUlq8P1do
         eMfcAvIrms7gfOK3WXr2nj//tbqHrPj8adcUb7TeOwZ3k7VaYr1RGOUWrsMfGoBza7Jz
         x8tg==
X-Gm-Message-State: AOAM530LO50c3NaLX0c0OlGdfowyfnLPY5mh4nn4XzD+ZGXTNO5NAfer
        hwJ5Uw4WOZMVYyl2DjZFkH7UFcor2Rrz1zdHOYU=
X-Google-Smtp-Source: ABdhPJwQ6WmYhIybkmT3u9SZW56uuc16Crt2W6Rl48VmOjd7uMEHhsQLrmXeY9+j9/ZcP9K9joFIiPVmnSkDwQW18vE=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr4834931lfs.529.1608454482045;
 Sun, 20 Dec 2020 00:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
 <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
In-Reply-To: <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 20 Dec 2020 19:54:30 +1100
Message-ID: <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Romain Dolbeau <romain@dolbeau.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        David S Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>,
        gentoo-sparc@lists.gentoo.org, info@temlib.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain, Sam,

On Sun, Dec 20, 2020 at 6:46 PM Romain Dolbeau <romain@dolbeau.org> wrote:
>
> Le sam. 19 d=C3=A9c. 2020 =C3=A0 22:41, Sam Ravnborg <sam@ravnborg.org> a=
 =C3=A9crit :
> > Another said that it would be a shame to sunset sun4m and sun4d because
> > there are so many machines around, and netbsd is also active on the
> > sparc32 area.
>
> Yes, those were plentiful back in the day and there's still quite a few a=
round.

I have three: two SparcStation 10s and a SparcStation LX.

If I want to run them, assuming the hardware still works, I need to
netboot them as I cannot find working, compatible HDDs for them as
everything has switched to SATA or SAS.

Then there's the issue of finding a monitor as they're not
electrically compatible with VGA and I'm pretty sure none of the VGA
compatible monitors I have or can lay hands on works with their
specific sync frequencies.

Ultimately it's one of those things where there's enough "stuff" in
the way that booting one up for fun is simply impractical and they're
old and slow enough that they're not useful for anything else.

Then we get to the not-so-significant issue of software...

> > The second mail also re-reminded me of an interesting project
> > implementing SPARC V8 and the sun4m platform in VHDL.
>
> There's also new hardware being developed for SBus systems :-)
> <https://github.com/rdolbeau/SBusFPGA>
> (disclaimer: work-in-progress and shameless self-promotion here!).

Interesting project!

Amusingly enough you're not the first to hook an FPGA up to sBus. I
had a card that was some form of high-speed sampling thing which was
effectively some electrically isolated front-end hooked to a Xylinx
FPGA. I ended up trashing it as it had no markings and I couldn't find
out anything about it.

> If there's still a distribution willing to build for Sparc v8, then I
> believe the kernel
> should try to keep support of the relevant machine architectures if at al=
l
> possible...

And here's where the problem lies. The last (official) version of
Debian to support Sparc32 was Etch and I believe it was one of the
last ones to drop support.

I believe that Gentoo is architecture-neutral enough that it'd work,
but I believe that you'll have to compile everything - there'll be no
pre-built anything for sparc32 - and as it's fairly slow hardware by
today's standards, that's going to take a long time, however you could
probably use distcc and cross-compilers to speed it up.

Long painful story short, it's difficult to get the hardware running,
there's practically no Linux distros that support it, and the kernel
code has probably bitrotted due to lack of testing.

As much as it pains me to say this, I think this code's time has come
and it's time to get rid of it.

If there were more people using it or more testing, or more distros
supporting it - not just (theoretically?) working on it - then I'd be
fighting to keep it.

But there isn't.

I think it's time for it to go.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

On Sun, Dec 20, 2020 at 6:46 PM Romain Dolbeau <romain@dolbeau.org> wrote:
>
> Le sam. 19 d=C3=A9c. 2020 =C3=A0 22:41, Sam Ravnborg <sam@ravnborg.org> a=
 =C3=A9crit :
> > Another said that it would be a shame to sunset sun4m and sun4d because
> > there are so many machines around, and netbsd is also active on the
> > sparc32 area.
>
> Yes, those were plentiful back in the day and there's still quite a few a=
round.
>
> > The second mail also re-reminded me of an interesting project
> > implementing SPARC V8 and the sun4m platform in VHDL.
>
> There's also new hardware being developed for SBus systems :-)
> <https://github.com/rdolbeau/SBusFPGA>
> (disclaimer: work-in-progress and shameless self-promotion here!).
>
> If there's still a distribution willing to build for Sparc v8, then I
> believe the kernel
> should try to keep support of the relevant machine architectures if at al=
l
> possible...
>
> Cordially,
>
> --
> Romain Dolbeau



--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
