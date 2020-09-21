Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B722730CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIURWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgIURWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:22:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D11C061755;
        Mon, 21 Sep 2020 10:22:39 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so9519528iom.6;
        Mon, 21 Sep 2020 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eEdVeBjREunXQ/esIC8A/92F1rU6OvwLOe193k+NyY=;
        b=Dez6+QkHxZPpqfsN5aPsPbBdNSLRM/Ok6lm7nbUpv4YEnKEv9fx90K0qvKt1w/fiOz
         agseOobdbg5hYqnDq1dFb9je+XEtyecu8jTUo4zOQKBo7jjy13/BUglJocLEyGp9vHL5
         zZRN+oDAy14TmmzBlIRKeGu12JkIiVyrcK8S8ZdC7hw/IZSFMEY8BZVcSTpTs/Bcb85u
         3TX/DnysCV7hxm3xjoJSxUj6CP9G2QH74Y4xs5KuQE6cMdfK3aX12wX4nPWDt50P7sG2
         FRKgZ1KB5hHFqb0ZNSRTXQ3xnjFiuYKcrPxrMJT30ds1K2B/QscDS7MdOiu/v08FL99A
         Lopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eEdVeBjREunXQ/esIC8A/92F1rU6OvwLOe193k+NyY=;
        b=f6CrImmVehkb3QlAIynJ0cXK1ewJungTDcgmE2B6QDbJ4cXts8kUb6iub/d/uRhQbt
         SQ5nnwDTPHFltyDGm9xic0PDnjnhNLhTcRYBXOspbpbTO+aCu9qWBrxDPw6QjNI3J2ac
         EL7Qye2XYrTjsJghRxjgfTnbgCocdJezysyRDd7JMhWN6o+veoxmG08WgKGk45LAd5kP
         OWCxtkqfQRmFHL2n6ivaNORnjW5wj8WsiFfXL8JW37NK/mF8X+QRdCiLrdQ6XX1qa/Mq
         WyTrQD42UmHSQ2UviBwsY8s4HLRGKcGOihtE8NRJu2Nfgga47pvGcSIiW6GE8+gr6lP0
         m34Q==
X-Gm-Message-State: AOAM5321IUckeeyzse/n8xZLB9WtZ0a7RBZSVRIVYiiBxRwZT1SC26YU
        gPdK/JdFgFtTam8ikhzZArzHChSsXV4jUeLC4Rc=
X-Google-Smtp-Source: ABdhPJyXwpi+qhgzEb2L7INB1xopRJEhE5l25ooD6gDDBzh9eq9jqQIZ31DSqfm4nvdMtzms0O7kB/zg1O4P/MgCG+U=
X-Received: by 2002:a5e:a613:: with SMTP id q19mr392021ioi.36.1600708958749;
 Mon, 21 Sep 2020 10:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921102731.747736-4-peron.clem@gmail.com>
 <20200921135530.q36i4l5m4p7u7zyy@gilmour.lan>
In-Reply-To: <20200921135530.q36i4l5m4p7u7zyy@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 21 Sep 2020 19:22:27 +0200
Message-ID: <CAJiuCcdV7aO79wrcbwjCNJ4uLL0knLFm4kYBvCErxQRnYALByg@mail.gmail.com>
Subject: Re: [PATCH v4 03/22] ASoC: sun4i-i2s: Change get_sr() and get_wss()
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

On Mon, 21 Sep 2020 at 15:55, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 21, 2020 at 12:27:12PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > We are actually using a complex formula to just return a bunch of
> > simple values. Also this formula is wrong for sun4i.
>
> Just like the previous patch, this could use a bit more explanation,
> like why it's a good thing, or how it's wrong on sun4i

Okay I will comment a bit more.

>
> > Replace this with a simpler switch case.
> >
> > Also drop the i2s params not used.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
> >  1 file changed, 44 insertions(+), 25 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 0633b9fba3d7..11bbcbe24d6b 100644
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
>
> Why do we need an hex number here?

This is a register value, so I thought it's usually written using
hexadecimal representation.

>
> Also, why is the return type change needed?

This function returns a ERROR defined in errno.h which actually could
be -133 but S8 only supports -128..127.

There is no real reason to have a S8 here and doesn't give any optimisation=
.

Clement

>
> Maxime
