Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76442A060C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgJ3M6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3M6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:58:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0056C0613CF;
        Fri, 30 Oct 2020 05:58:18 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h21so7370212iob.10;
        Fri, 30 Oct 2020 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DEjwCz6RYcTNQfWnCWPDSlK+EiMHXu1I2qKUPcY2Sh4=;
        b=HBlLv1td8ZGbbQpa0MJPMXQx1wDSoEh19ueH+HpLQn7HCeunMObf8TyVowEs6h3R1m
         iO4vu+D+ag+gypjHMSJ/h5TbRu/++9EMN4/xsfsDdMPaUZtE4oFglwtgR08CcW2G2AdX
         UmlQm9AfRndgv1zsgN3sTlb+QByMJzLQycWwoPdDgQWPlOLC+3cw/yAxHS9xGEcsfk25
         oL5Gr2GsEfDIMPaQ/3v0cjoZYemL+EIxWgI9EmA1QEc1Kc55bB7q7X6z5rvkgrdV8Wln
         YUSHz2U73sjUjSPC7fP0Cum01fYXKZPtnwqJrgS23oaIaaD/6+9OjVGgGaguXxagZ3Lq
         1xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DEjwCz6RYcTNQfWnCWPDSlK+EiMHXu1I2qKUPcY2Sh4=;
        b=EOHe3djSOCTuYt7jKFKoVMSvjUaO7l16O6M0jH9Difv6Wj7i4dqcGRbOWPGFbKMbOY
         GF4s+LdYuMzpyZHagCL/H68jaF7r0LaQCAQEOaenUfbd5BHyxpNxU4D9bOOYP0eEgIWA
         OO0DKzz1o/25/RdgWBjPSGqE/BtnM6X3besT2MOMiweyXwxvcgoQ9FDGX2ycTgae0bgy
         tLDzJE3LMIuyHO4qegzE3VtM+3/FCZf1ofebkxQ0rcTFUHqdEcB3jncNKQbmsSoIrg/X
         HdPf4K8m5oXpHhbSRLcjGBaKodwzKD6zTfWk7aidQv9u6N62wQBu0AB8VyOYIFwdXKUv
         yxxg==
X-Gm-Message-State: AOAM5338qPaJy+A571akTDSoS2cVyE3yUdANhhCEIO1C8n9+q1mEs2BZ
        x1zmXUtB9XZk/8yvcCMvYuvQDtcJXcBFIuigCMg=
X-Google-Smtp-Source: ABdhPJzgAY6KtKOPC6tfzKmvA8QQMoxhHFJsZyDBWBxynYs54LG5exJnFVce2ePcyXh7zbs+RcwK2Q1VsHbq+C9CSvQ=
X-Received: by 2002:a05:6638:1351:: with SMTP id u17mr1911170jad.120.1604062698162;
 Fri, 30 Oct 2020 05:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201027183149.145165-1-peron.clem@gmail.com> <20201027183149.145165-2-peron.clem@gmail.com>
 <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com> <CAJiuCcdX7jc-VMWYfPPL3qu9RcUU7VMdjshyPH_xLA0yVXftUw@mail.gmail.com>
 <3f0c46e2-24a4-b6ee-1ea2-9de5344cfb9d@sholland.org>
In-Reply-To: <3f0c46e2-24a4-b6ee-1ea2-9de5344cfb9d@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 30 Oct 2020 13:58:07 +0100
Message-ID: <CAJiuCceqhGjzJV+=KQkzswpiG2QRb3NhVHqmrXHBi50wNZBFXw@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
To:     Samuel Holland <samuel@sholland.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel

On Fri, 30 Oct 2020 at 02:20, Samuel Holland <samuel@sholland.org> wrote:
>
> On 10/27/20 4:43 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Pierre-Louis,
> >
> > On Tue, 27 Oct 2020 at 19:59, Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>
> >>> @@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct =
sun4i_i2s *i2s,
> >>>       case SND_SOC_DAIFMT_DSP_B:
> >>>       case SND_SOC_DAIFMT_LEFT_J:
> >>>       case SND_SOC_DAIFMT_RIGHT_J:
> >>> -             lrck_period =3D params_physical_width(params) * slots;
> >>> +             lrck_period =3D slot_width * slots;
> >>>               break;
> >>>
> >>>       case SND_SOC_DAIFMT_I2S:
> >>> -             lrck_period =3D params_physical_width(params);
> >>> +             lrck_period =3D slot_width;
> >>>               break;
> >>
> >> Aren't I2S, LEFT_J and RIGHT_J pretty much the same in terms of lrclk
> >> rate/period? the only thing that can change is the polarity, no?
> >>
> >> Not sure why it's handled differently here?
> >
> > I just had a look at the User Manual for H3 and H6 and I didn't find
> > any reason why LEFT_J and RIGHT_J should be computed in a different
> > way as I2S.
>
> Yes, and the manual explicitly groups LEFT_J and RIGHT_J with I2S when
> describing this field:
>
>    PCM Mode: Number of BCLKs within (Left + Right) channel width.
>    I2S/Left-Justified/Right-Justified Mode: Number of BCLKs within each
> individual channel width(Left or Right)
>
> So I agree that the code is wrong here.

Thanks, I will send a fix in the v10.

Regards,
Clement

>
> Regards,
> Samuel
>
> > Also the commit introducing this doesn't mention it.
> > 7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")
> >
> > I can't test it with my board but if nobody complains about it, I will
> > introduce a fix for this in the next version and change this also for
> > H6.
> >
> > Thanks for your review,
> > Clement
> >
>
