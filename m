Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BB2717C6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgITUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 16:06:00 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A057C061755;
        Sun, 20 Sep 2020 13:06:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h2so11704437ilo.12;
        Sun, 20 Sep 2020 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wP4gZRkOAWgiW0xnyA5/8lMVxtrC05P+MT5wMJXn4Ks=;
        b=Bd8j3+i27Pi1JS6swpqa39XxIyg0FnZZehxsQB73iY8qx/SIdpXwyAUGFpNpx96Gso
         dd9ZVKY8Nme0wkY9hzNyw5MO8P5F6knorU7JkKKpSE/Vx8N/CRiRqsO0YRP535/8UJet
         SFJfTzgprcgbI/OODHFMJYR7yJ5gx04jPohWq9haKdZA6VrpVQz6z4/N4RSVroJoYv0X
         z+HkA+WgVdpDWBusI2arko6gwI9AVmhiuRToSvB8KMCWFxpHXbcbpzvWJI0YYCJuX9bJ
         4MkTJZJdirUOJbP71WkN0dIY0xNzvXwdDmXtw7l4ssBeVBNFy9VRD2vioJj25AFeT6Oh
         P9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wP4gZRkOAWgiW0xnyA5/8lMVxtrC05P+MT5wMJXn4Ks=;
        b=uk4t+nOtB6tK0vcwdgcy9FITOm0LMnok47OOCmVnlrHK8hvfVNuQT1nk2FPiRQX2G+
         jzq10mvvKSv0QwtSrSZzLqaCf+X63jxsMFSYWopTE5SauJu3FdEZLmLDzElyo/T1u/5b
         +Z28VPjy/q8SP/nw/m9Qm8ESYTDsBjHzAoST+8AHuLqtSLfVxuExjjgoyUfVHh5RDcm6
         3Fl8jK09AB3s3frdF7OScBdQIXbD1e6NL7vBffoFAG55tDKyWSZMDlEwaYTEHy1/1p4q
         Y+E4VShAs+rxQnG1ei4uXmtxWBqIfs2W0XQONMcssaF64BvfT1D6w/8lOVHofGydkvEn
         RsRg==
X-Gm-Message-State: AOAM530/hEmqUWt8fRk8sCRBB+wbU5klzZDwO3LK7L+LetG0c82koUtA
        cuUTRyOiyBh6eA5TCeVYv/LKouznYl4EKVLiZg4=
X-Google-Smtp-Source: ABdhPJxuV8GsyADygtnzpUmWSuBmmFfyYdRFN3/asdGXDpCMeaS/zYguGIj04QJ5JTCpS6h53VBfbQWyhYeFuOPh728=
X-Received: by 2002:a92:217:: with SMTP id 23mr38815570ilc.118.1600632359330;
 Sun, 20 Sep 2020 13:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200920180758.592217-1-peron.clem@gmail.com> <20200920180758.592217-7-peron.clem@gmail.com>
 <497a7062-4acf-d928-c2ee-ec595ed6799b@sholland.org>
In-Reply-To: <497a7062-4acf-d928-c2ee-ec595ed6799b@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 20 Sep 2020 22:05:48 +0200
Message-ID: <CAJiuCccEVOcD38DZLru2PirGhRBaeJqFAug_aZjW+QY0xHTb1g@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] ASoC: sun4i-i2s: Fix sun8i volatile regs
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Samuel,

On Sun, 20 Sep 2020 at 20:52, Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/20/20 1:07 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > The FIFO TX reg is volatile and sun8i i2s register
> > mapping is different from sun4i.
> >
> > Even if in this case it's doesn't create an issue,
> > Avoid setting some regs that are undefined in sun8i.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index ce4913f0ffe4..a35be0e2baf5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -1126,12 +1126,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev=
, unsigned int reg)
> >
> >  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int re=
g)
> >  {
> > -     if (reg =3D=3D SUN8I_I2S_INT_STA_REG)
> > +     switch (reg) {
> > +     case SUN4I_I2S_FIFO_CTRL_REG:
>
> Please check if this breaks audio recording with runtime PM enabled. I no=
ticed
> this with an older revision of the series that also changed
> sun4i_i2s_volatile_reg. Marking SUN4I_I2S_FIFO_CTRL_REG as volatile broke
> setting of SUN4I_I2S_FIFO_CTRL_TX_MODE/RX_MODE, because the set_fmt() cal=
lback
> is not run with a runtime PM reference held, and volatile registers are n=
ot
> written by regcache_sync() during sun4i_i2s_runtime_resume().
>
> As a workaround, I moved the TX_MODE/RX_MODE initialization to hw_params(=
), but
> I am not sure it is the right thing to do:

Thanks for the catch,
I never tried to suspend/resume my board actually.
But your explanation and the fix seems legit to me.

I don't think it's a workaround as settings the fifo size is not
related to set_fmt and could also be set in hw_params.

I will add your fix in the next version.

Regards,
Clement

>
> https://github.com/smaeul/linux/commit/5e40ac610986.patch
>
> Cheers,
> Samuel
>
> > +     case SUN4I_I2S_FIFO_RX_REG:
> > +     case SUN4I_I2S_FIFO_STA_REG:
> > +     case SUN4I_I2S_RX_CNT_REG:
> > +     case SUN4I_I2S_TX_CNT_REG:
> > +     case SUN8I_I2S_FIFO_TX_REG:
> > +     case SUN8I_I2S_INT_STA_REG:
> >               return true;
> > -     if (reg =3D=3D SUN8I_I2S_FIFO_TX_REG)
> > -             return false;
> >
> > -     return sun4i_i2s_volatile_reg(dev, reg);
> > +     default:
> > +             return false;
> > +     }
> >  }
> >
> >  static const struct reg_default sun4i_i2s_reg_defaults[] =3D {
> >
>
