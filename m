Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF03A29CB70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374354AbgJ0Vnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:43:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39590 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374343AbgJ0Vnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:43:37 -0400
Received: by mail-io1-f66.google.com with SMTP id p7so3202693ioo.6;
        Tue, 27 Oct 2020 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4DMtRusIBSeOgDXKaZMtL3aNFUYRHrBj1yi1ElNljs=;
        b=e78D+C4YPOWMj2c9KFCPYCIg3bvAvcyQqVd3q0U9IzxX7aqpzFtPrfQOFokVNN1PNX
         XVrypVrbod4hLwzuZGhyHb/+PDmB3ar1be3vzd1WBJfTgQniWRrX8wn39wKbAhJQpN0A
         oWejHK6i+TG4BlPd+/oJEn1latxU4lUUd8Xv2e2G6Pa7x6z2WF7U8Ot8KajYAwiqxmb5
         42vF/PLb6KUXH7JMRLIW1AeHyRBEqLvvmqbnLwPR3AkCXIvwbCLdl6AHUllzTiBbHgup
         lsgxRaktKlyNrDii/jNalYObBXJQKkUeLo44XP3oS1+49RWV5Hlj51ZCHgtr7+Iz9cNW
         85wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4DMtRusIBSeOgDXKaZMtL3aNFUYRHrBj1yi1ElNljs=;
        b=d6wzK8f/KvuLIuCFNCsY2VyxMtQ6KFHpjI83DbFaQ+lhGRi6F9X1d5Y0EobpMBCg37
         VURxNkB8YsUwxiTQgK171QpDbhJcvgh/8FRx1eKvfR05oYF1eSQ6zEVgNkxJn54Xroli
         9fSRRhYYFvHO438LQTJ3sBUzW8c2rvxXBd78TRXyT9a3CS0tHfA7aqhkY881kLUvOYbV
         eJPYZJEVR+iUrsd15XHGVF7MBXGYuvEF2zHjU37KYfzyNuv9KXo6p/fbaVSdepwX3AZ7
         pfmImKBCYZqlHoMVMeOsw9LOdPfsuB7B3oP+OrGQHgjj+JgHrOZuK27o27q71K723pQj
         kE0Q==
X-Gm-Message-State: AOAM530wOjVlL1t719NYD14kkEJ4ZSoNfJ7omfwqiOBMdIqZ5wjSqfOn
        nA48QcfP2KO0Qmh5rit8WsHY9qY6XJ7EybQz/iE=
X-Google-Smtp-Source: ABdhPJx80PPcZMpfUlBGECvO/rasjkvCl7waBT4W4GSuQJBtLI91Ef08UVD8zq/hY18wjm/GR+zGD6+MmyoxhgDmCBw=
X-Received: by 2002:a6b:8b95:: with SMTP id n143mr3933217iod.36.1603835014568;
 Tue, 27 Oct 2020 14:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201027183149.145165-1-peron.clem@gmail.com> <20201027183149.145165-2-peron.clem@gmail.com>
 <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com>
In-Reply-To: <01e34ad3-c695-c6eb-95dd-76c2cda77c6f@linux.intel.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 27 Oct 2020 22:43:23 +0100
Message-ID: <CAJiuCcdX7jc-VMWYfPPL3qu9RcUU7VMdjshyPH_xLA0yVXftUw@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre-Louis,

On Tue, 27 Oct 2020 at 19:59, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > @@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> >       case SND_SOC_DAIFMT_DSP_B:
> >       case SND_SOC_DAIFMT_LEFT_J:
> >       case SND_SOC_DAIFMT_RIGHT_J:
> > -             lrck_period = params_physical_width(params) * slots;
> > +             lrck_period = slot_width * slots;
> >               break;
> >
> >       case SND_SOC_DAIFMT_I2S:
> > -             lrck_period = params_physical_width(params);
> > +             lrck_period = slot_width;
> >               break;
>
> Aren't I2S, LEFT_J and RIGHT_J pretty much the same in terms of lrclk
> rate/period? the only thing that can change is the polarity, no?
>
> Not sure why it's handled differently here?

I just had a look at the User Manual for H3 and H6 and I didn't find
any reason why LEFT_J and RIGHT_J should be computed in a different
way as I2S.

Also the commit introducing this doesn't mention it.
7ae7834ec446 ("ASoC: sun4i-i2s: Add support for DSP formats")

I can't test it with my board but if nobody complains about it, I will
introduce a fix for this in the next version and change this also for
H6.

Thanks for your review,
Clement
