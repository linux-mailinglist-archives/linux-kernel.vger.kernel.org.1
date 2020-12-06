Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5E2D0739
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgLFVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLFVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:04:09 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57B9C0613D0;
        Sun,  6 Dec 2020 13:03:28 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so11403529ioo.7;
        Sun, 06 Dec 2020 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FTxerJvyox18O/Jq9uhgongY61vUzSSign65wrEgfsY=;
        b=Oimca5xTLVuDfZ05ehZ2r70gMXzxAIsKn2uB2/F14hmhrv+o+CAlgG5s9aAyICLUZU
         52BghTWRY4+5+ZclyJMAsoZzQy2shdpwJNjS6y+9QiCBmAFdJO9nQwXaYAlqoJ3CMavA
         OeYDnjBpZMAnGXUgq311hh0wDAO4i5OjmzmudHuIm0W+AJ9Q0fAdCEZClGGrwSYFkJVP
         Uo+5775KAzX4TuZZv5vpKu+kP7yKKO7pJxUtZmJcIJ4ytNTZ5YpUOh4DtMzvisQjhY4v
         KQJQfnvhUCme3c2IoPNHpMqcsEzV7oR9+u9GMw7rA026kCJqfcNExr3tjdf3xNohMReE
         A0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FTxerJvyox18O/Jq9uhgongY61vUzSSign65wrEgfsY=;
        b=JYiKIGEGtE+I3OxL8qXdjV0LtAQ0V9viEE38zLGdWq+vFueHr9GLPnaT/JfKhcoNaO
         kNWbjt3KpwOAopeKHTpExr27BchBwqBHP7DisCOW79CJ0Vk2s9yOpK2jE9VZYzTqAAMh
         gkqPhuww/jCJoFApaT7l/WnOnF5TRX9pWhi1tcuTBRpvbFw2C7yDgW+/aVWVLITJ5LL5
         bbCFiqTuRDfVXCMpe7MpuFGykjb5e2sw3eof0aoXQR6YXvZZprwg9CK6kmRvUVLMeNzn
         QV9q5OZon2idRjoEBP0GgGTDtiQZSzcSxHS50wq6retZ1AEVjczFh8Hne5cKzn/y7cVe
         T8Xw==
X-Gm-Message-State: AOAM5320jWbaWK8jANb+/E0hOrgELCb5ssy7T+4LOoztwwPhlDk/mE8v
        L8XDRijAKmbZI2hr6G9uGmB55idqtoFsr1hSVbs=
X-Google-Smtp-Source: ABdhPJyrshzZsOF5HvJaY9Phi8uzC+uy5b/cdoLurAV4tRSZ2+UCzDTv6vYKI7UcbqUuyFCgApj0GASA7xQMVgYWen4=
X-Received: by 2002:a5d:9b97:: with SMTP id r23mr14670081iom.123.1607288608109;
 Sun, 06 Dec 2020 13:03:28 -0800 (PST)
MIME-Version: 1.0
References: <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour> <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour> <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
 <20201128103827.d6sfc2eumli2betx@gilmour> <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
 <CAJiuCcfEcM+Dksm4uoRPCiRepDSnEmp7pr8Qk5EsFSH_zEOTYA@mail.gmail.com>
 <C8F86F90-14BF-4857-9DB8-7968A34E4656@aosc.io> <CAJiuCcc=s6xG7Wzfx6PBU0e3BHz+YRpU=t0Ef3EcTp9k11Dkzg@mail.gmail.com>
 <20201201103519.b7rbkmjssmvy6qeo@gilmour>
In-Reply-To: <20201201103519.b7rbkmjssmvy6qeo@gilmour>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 6 Dec 2020 22:03:16 +0100
Message-ID: <CAJiuCceq4J=9obLTJ9TL=ci55bupc552ymGOH9z-feNTbq0hSQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Tue, 1 Dec 2020 at 11:35, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sat, Nov 28, 2020 at 10:07:27PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime, Icenowy,
> >
> > On Sat, 28 Nov 2020 at 12:59, Icenowy Zheng <icenowy@aosc.io> wrote:
> > >
> > >
> > >
> > > =E4=BA=8E 2020=E5=B9=B411=E6=9C=8828=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=887:54:04, "Cl=C3=A9ment P=C3=A9ron" <peron.clem@gmail.com> =E5=86=99=
=E5=88=B0:
> > > >Hi Icenowy,
> > > >
> > > >On Sat, 28 Nov 2020 at 12:28, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > >>
> > > >> =E5=9C=A8 2020-11-28=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:38 +01=
00=EF=BC=8CMaxime Ripard=E5=86=99=E9=81=93=EF=BC=9A
> > > >> > On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> > > >> > > > > > > > Okay. But I'm not satisfied with a non-public sample
> > > >> > > > > > > > occupies
> > > >> > > > > > > > the pinetab name. Is rename it to pinetab-dev and ad=
d a
> > > >> > > > > > > > pinetab-retail okay?
> > > >> > > > > > >
> > > >> > > > > > > To me, naming the production version anything but
> > > >"pinetab"
> > > >> > > > > > > isn't
> > > >> > > > > > > satisfying either.
> > > >> > > > > >
> > > >> > > > > > I understand where you're coming from, but the point I w=
as
> > > >> > > > > > making my
> > > >> > > > > > previous mail is precisely that it's not really possible=
.
> > > >> > > > > >
> > > >> > > > > > You want to name the early adopter version _the_ product=
ion
> > > >> > > > > > version. Let's assume the hardware changes again between
> > > >the
> > > >> > > > > > early
> > > >> > > > > > adopter and mass-production version. Which one will be
> > > >_the_
> > > >> > > > > > production version? The early-adopter or the mass-produc=
ed
> > > >> > > > > > one?
> > > >> > > > > >
> > > >> > > > > > There's really no good answer here, and both would suck =
in
> > > >> > > > > > their
> > > >> > > > > > own way. The only way to deal with this is to simply avo=
id
> > > >> > > > > > defining one version as the one true board, and just
> > > >loading
> > > >> > > > > > the
> > > >> > > > > > proper DT in u-boot based on whatever clue we have of th=
e
> > > >> > > > > > hardware
> > > >> > > > > > revision.
> > > >> > > > > Then will it be okay to rename current pinetab DT to
> > > >> > > > > pinetab-sample and then introduce new DTs all with suffixe=
s?
> > > >> > > >
> > > >> > > > No. From my previous mail:
> > > >> > >
> > > >> > > It can be seen as dropping the PineTab DT and introduce new DT=
s
> > > >> > > with
> > > >> > > suffix.
> > > >> > >
> > > >> > > Do we have rule that we cannot drop boards?
> > > >> >
> > > >> > Are you really arguing that removing a DT and then adding an
> > > >> > identical
> > > >> > one under a different name is not renaming it?
> > > >>
> > > >> Then we can just keep confusing name?
> > > >
> > > >Sorry maybe I missed some information
> > > >But why don't you do like pinephone?
> > >
> > > They're the same board revision with different LCD panels.
> >
> > I just ask Pine64 about this and here is the reply :
> > "The PineTab LCD panel change was a last minutes before production
> > starts that vendor advise us switch over to new LCD controller due to
> > EoL concern".
> >
> > "Pine64 communication" is not so bad we just need to ask and they reply=
 :)
> >
> > So the issue is not that the Product was not finalized but that one
> > component arrives in EoL.
> > This could also happens during a running production.
>
> Like you said, it can happen pretty much any time, for any reason, so
> the intent doesn't really matter here.

Agree, that was more to support Pin64 guys here.

As pinetab compatible can't be reused maybe somethings like this :
sun50i-a64-pinetab.dtsi
sun50i-a64-pinetab-1.0-early-adopter.dtb
sun50i-a64-pinetab-1.0.dtb or sun50i-a64-pinetab-retail.dtb. But
retail is like prod it's not explicit.

What do you think ?

Clement

>
> Maxime
