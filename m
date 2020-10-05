Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC312836A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJENfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJENfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:35:30 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9FC0613CE;
        Mon,  5 Oct 2020 06:35:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id o18so2910615ill.2;
        Mon, 05 Oct 2020 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ScH7spBRgEvoHiLBoomy6Y6xgrMwXDw74+hbCCfUCk=;
        b=DBJ43NN77a5Y46IUwb3kq/Qp3uJWgIzuawxQtEG6nwGa7uq2aIQmR6UpW23L0ekyuY
         doSQHQs6lf/+dHuw6A1tHvwaH1Yu/l+DaeniZwh4whDk2jt0wVcfQv4Quck/AvsT9jU9
         9cJfb9X4vRG9HkoUww8dwwknFdjWFZVXsJvaqoX2htzh/0h1cqgLwk9hgO7ljHdFjJeI
         1tOzJdb9z5oWu0fljA1FGxOpa5+D8VW2wgweIiXnl1RpkaP8IrNu0+WBXX5I8Wd3BTYn
         calvO5Bko05dm4ayeF4UpEj/YODvSw2Qb2ny8X1U3DhMUcRILhMjNKQHNTAIIzW5aE53
         WSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ScH7spBRgEvoHiLBoomy6Y6xgrMwXDw74+hbCCfUCk=;
        b=OvMra0Gh6abzwNSMmi+ppV2qE8W5VDFA6iCvmies6grEtvzidD1m3tTZ+BFaU42jt6
         MbHCNy5LgaeeY+1X869iL6yrSf+9aAJlDyCM/3LxzawfFjI+yrDeZ5n98dFxTNZQWb6O
         Sfj2Pghxph7rw8c7OkgCT9ffccKIQAFC/lKOp+IzuWpdi4SbG5pYQLsOmgB+QYFxOHwf
         TGFSSrEfwT5kZfQAa1yuW1VvM1EokEd59QwAoh9N/Fpox+hZnNYC268eC85+TrTR5fOe
         KquS/lJsDwRV6lscjVenodXmX6GLz8Ve+//9VMePPORLPe4/HVVae8dxOc7LQO22e7zY
         spUQ==
X-Gm-Message-State: AOAM531Z9NJnzC1mgfw2xqPPaX0aOhkMEcYqbLYUhyaQ4wWAExR3A+ck
        gY5gwIanCeuIvkj2sVnfNyXgHGCMQhAv5hpBqhA=
X-Google-Smtp-Source: ABdhPJySP0U5feN77FoosI4tYSbueu7xIwjyAToSotvdCVmiSn/MELKnPNsUll1WeogQTnwwCceaixNNSKw34nbMnDw=
X-Received: by 2002:a92:b30c:: with SMTP id p12mr5278394ilh.35.1601904929683;
 Mon, 05 Oct 2020 06:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201003141950.455829-1-peron.clem@gmail.com> <20201003141950.455829-4-peron.clem@gmail.com>
 <20201005121419.mum4g5utdesvyg7a@gilmour.lan>
In-Reply-To: <20201005121419.mum4g5utdesvyg7a@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Oct 2020 15:35:18 +0200
Message-ID: <CAJiuCcds_H-M6Y9Cb8eMmTgpsaC_ZQee97u260WvDe23yBVc7A@mail.gmail.com>
Subject: Re: [PATCH v6 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss()
 to be more explicit
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, 5 Oct 2020 at 14:14, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Sat, Oct 03, 2020 at 04:19:39PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > We are actually using a complex formula to just return a bunch of
> > simple values. Also this formula is wrong for sun4i when calling
> > get_wss() the function return 4 instead of 3.
> >
> > Replace this with a simpler switch case.
> >
> > Also drop the i2s params which is unused and return a simple int as
> > returning an error code could be out of range for an s8 and there is
> > no optim to return a s8 here.
> >
> > Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
> >  1 file changed, 44 insertions(+), 25 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 1f577dbc20a6..8e497fb3de09 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
> >       unsigned int                    num_mclk_dividers;
> >
> >       unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
> > -     s8      (*get_sr)(const struct sun4i_i2s *, int);
> > -     s8      (*get_wss)(const struct sun4i_i2s *, int);
> > +     int     (*get_sr)(unsigned int width);
> > +     int     (*get_wss)(unsigned int width);
> >       int     (*set_chan_cfg)(const struct sun4i_i2s *i2s,
> >                               unsigned int channels,  unsigned int slot=
s,
> >                               unsigned int slot_width);
> > @@ -381,37 +381,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_=
dai *dai,
> >       return 0;
> >  }
> >
> > -static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
> > +static int sun4i_i2s_get_sr(unsigned int width)
> >  {
> > -     if (width < 16 || width > 24)
> > -             return -EINVAL;
> > -
> > -     if (width % 4)
> > -             return -EINVAL;
> > +     switch (width) {
> > +     case 16:
> > +             return 0x0;
> > +     case 20:
> > +             return 0x1;
> > +     case 24:
> > +             return 0x2;
> > +     }
> >
> > -     return (width - 16) / 4;
> > +     return -EINVAL;
> >  }
> >
> > -static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
> > +static int sun4i_i2s_get_wss(unsigned int width)
> >  {
> > -     if (width < 16 || width > 32)
> > -             return -EINVAL;
> > -
> > -     if (width % 4)
> > -             return -EINVAL;
> > +     switch (width) {
> > +     case 16:
> > +             return 0x0;
> > +     case 20:
> > +             return 0x1;
> > +     case 24:
> > +             return 0x2;
> > +     case 32:
> > +             return 0x3;
> > +     }
>
> Like I said in the previous version, I'm not really sure why we need to
> use the hexadecimal representation here?

I'm not sure if there is a convention when to use hexa or when not to use i=
t.

But these figures are taken from the User Manual where register
descriptions are written in Base 2 and default values are written in
Base 16.

It's easier to read them and check that the code follows the documentation,=
 no ?

Indeed with 2 bits this doesn't change anything.
Do you want me to change them in decimal ?

Clement

>
> Maxime
