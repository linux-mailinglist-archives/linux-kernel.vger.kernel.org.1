Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAE2AE521
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgKKAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbgKKAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:48:33 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF5CC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:48:31 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id x13so199860uar.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwI3PFSKWVnaqeshY41Xp/YVBg2cD76OjiJIiFh3rNI=;
        b=QfIsIHzjHTjAr/jTdIRSiD+ZkEfLnev1EHOTrRrDDTB7WurSHmLapfGiBTNJvwGtWM
         n0cecZqV6gOBimx3dJHYoejdFvYV+lM1U9yYeRQ2K3KmHrsUZUWvTeK29NnQ/CF3BEKI
         m3e422SOkDPN1XTyRtLgENxmZHEnNWrVPZYPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwI3PFSKWVnaqeshY41Xp/YVBg2cD76OjiJIiFh3rNI=;
        b=eMMqC+Ah6ACygiJNhJyLIklrcFHlq3A0ZactQ7qKFvk84WMEfuHjxADkVvjNuMGaIQ
         BiP9pZFk6lM6i8Axm/tOKJM2Y/q3lRMB12kfR5m6h2/euOWt+1iCEYYEmlytbupn7iBq
         kVvTT3kiQOveb/Y4NI3qOlNq3UrWDPs2EKfvlkQKIV8JaGjXR4lQHDc8H1pCsOmHSyk8
         8qAHUmDfZT49A7mszxmQXOXfJ3ScZkEbl4i7CXyGJERnPEIMKvMTHjAoSIILXPekeHdq
         FCB3xE6S42jNw7Z9A8qABYp2Ke9iLiEzqRnLWlLKtuFFKuhkdSYl4oKf4cX/0/fhv2Ea
         /P4g==
X-Gm-Message-State: AOAM530VxTk29+NUFqyoGNPatI7GlUexVZBKEh4ziVVZ8TzUgJ+cUk2Z
        4hw0KQiPL/0tjIeW9BItjycZA0PRrNWAqQ==
X-Google-Smtp-Source: ABdhPJxJ4xGiiCrx3DU9ZhN4zV8g+1YT4h4x4B1TmV3k+dQxdXETZrWd7G3en2KM5Rk9TQ2oNsJoHA==
X-Received: by 2002:ab0:330e:: with SMTP id r14mr2183023uao.46.1605055710077;
        Tue, 10 Nov 2020 16:48:30 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id v26sm39295vsq.20.2020.11.10.16.48.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 16:48:29 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id q68so200083uaq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:48:28 -0800 (PST)
X-Received: by 2002:a9f:24eb:: with SMTP id 98mr11624331uar.90.1605055707756;
 Tue, 10 Nov 2020 16:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20200930223532.77755-1-bjorn.andersson@linaro.org>
 <20200930223532.77755-2-bjorn.andersson@linaro.org> <CAD=FV=Unu-PH_RThi3xRF1HUADN2PqcVAOin0O0yo0gcGRWCDQ@mail.gmail.com>
 <20201102170801.GI3151@builder.lan>
In-Reply-To: <20201102170801.GI3151@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Nov 2020 16:48:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XEyn5tLhOFnVTP4W-_qQG_UpZ0npveEo-vE0Y=wKqaBg@mail.gmail.com>
Message-ID: <CAD=FV=XEyn5tLhOFnVTP4W-_qQG_UpZ0npveEo-vE0Y=wKqaBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: ti-sn65dsi86: Replace #pwm-cells
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 2, 2020 at 9:08 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 02 Oct 15:42 CDT 2020, Doug Anderson wrote:
>
> > Hi,
> >
> > On Wed, Sep 30, 2020 at 3:40 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > While the signal on GPIO4 to drive the backlight controller indeed is
> > > pulse width modulated its purpose is specifically to control the
> > > brightness of a backlight.
> >
> > I'm a bit on the fence about this.  I guess you're doing this because
> > it avoids some -EPROBE_DEFER cycles in Linux?  It does seem to have a
> > few downsides, though.
> >
>
> No, the reason for exposing a backlight is that while the thing
> certainly is a PWM signal, the description of it and the registers
> available to control it surely seems "backlight" to me.
>
> In particular No, the reason for exposing a backlight is that while
> while the thing certainly is a PWM signal, the description of it and the
> registers available to control it surely seems "backlight" to me.
>
> > 1. It means a bit of re-inventing the wheel.  It's not a very big
> > wheel, though, I'll give you.  ...but it's still something.
> >
>
> The main problem I saw with exposing this as a PWM was the fact that we
> have both period and frequency to control...
>
> > 2. I'm not sure why you'd want to, but in theory one could use this
> > PWM for some other purposes.  It really is just a generic PWM.  Your
> > change prevents that.
> >
>
> ...and in the even that you use it as a "generic" PWM I'd expect that
> the specified period is related to the frequency of the signal. But the
> period is documented to be related to the number of brightness steps of
> the panel.

I think the key here is that the "number of brightness steps of the
panel" isn't really a thing that's worried about.  At least in my
experience, you can pretty much just use as many steps as you can
represent based on your PWM hardware.  If a panel happens to map some
of those steps to the same brightness then it wouldn't be the end of
the world, but in experience it's not really such a digital thing.  If
you choose 4096 steps then you likely get 4096 different brightness
levels.  If you choose 256 steps then you get 256 different brightness
levels.  Once you have "more than enough" steps then everything's
pretty much fine.

Looking at one random panel (just to get an idea of numbers), I see
that it specifies:
* min PWM Freq: 200 Hz
* max PWM Freq: 10,000 Hz.

...and refclk is something between 12 MHz and 38.4 MHz, right?

The bridge chip datasheet says:

PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)

So let's see what we can do.  I'm arguing that we want the client to
be able to specify the PWM frequency and duty cycle and we'll do the
job of picking the number of steps.  We'll try for the most steps we
can get (65535).

I guess we need to solve for PWM_PRE_DIV :

PWM_FREQ * (PWM_PRE_DIV * BACKLIGHT_SCALE + 1) = REFCLK_FREQ
PWM_PRE_DIV * BACKLIGHT_SCALE + 1 = REFCLK_FREQ / PWM_FREQ
PWM_PRE_DIV * BACKLIGHT_SCALE = REFCLK_FREQ / PWM_FREQ - 1
PWM_PRE_DIV = (REFCLK_FREQ / PWM_FREQ - 1) / BACKLIGHT_SCALE

...and solve for BACKLIGHT_SCALE:
BACKLIGHT_SCALE = (REFCLK_FREQ / PWM_FREQ - 1) / PWM_PRE_DIV


With 1000 Hz, 12 MHz refclk:

PWM_PRE_DIV = DIV_ROUND_UP(12000000 / 1000 - 1, 65535)
=> 1
BACKLIGHT_SCALE = (12000000 / 1000 - 1) / 1
=> 11999

With 1000 Hz, 38.4 MHz refclk:
PWM_PRE_DIV = DIV_ROUND_UP(38400000 / 1000 - 1, 65535)
=> 1
BACKLIGHT_SCALE = (38400000 / 1000 - 1) / 1
=> 38399

With 200 Hz, 38.4 MHz refclk:
PWM_PRE_DIV = DIV_ROUND_UP(38400000 / 200 - 1, 65535)
=> 3
BACKLIGHT_SCALE = (38400000 / 200 - 1) / 3
=> 63999

Now that you have BACKLIGHT_SCALE specified, then when someone tries
to give you a duty cycle you just map it to the closest value you can
make.  Obviously you won't be able to perfectly make every exact duty
cycle / period that a client requests, but that's true of all PWMs out
there.

The nice thing here is that (assuming my math is right) we should be
getting nearly exactly the frequency that the client requested and
that (in my mind) is what matters.  You also get as many steps as
possible which means that (with the PWM backlight API) you'll be able
to get as close as possible to whatever a user requests.


> > > Drop the #pwm-cells and instead expose a new property to configure the
> > > granularity of the backlight PWM signal.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > index f8622bd0f61e..e380218b4646 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
> > > @@ -66,9 +66,12 @@ properties:
> > >        1-based to match the datasheet.  See ../../gpio/gpio.txt for more
> > >        information.
> > >
> > > -  '#pwm-cells':
> > > -    const: 1
> > > -    description: See ../../pwm/pwm.yaml for description of the cell formats.
> > > +  ti,backlight-scale:
> > > +    description:
> > > +      The granularity of brightness for the PWM signal provided on GPIO4, if
> > > +      this property is specified.
> > > +    minimum: 0
> > > +    maximum: 65535
> >
> > A few issues here:
> >
> > 1. Maybe call this "num-steps" instead of backlight-scale.  That's
> > essentially what it is, right?  Saying how many discrete steps you're
> > allowing in your backlight?
> >
>
> That would work, I had it as "max-brightness" for a while as well. But I
> reverted to backlight-scale, because that's the name used in the
> datasheet.
>
> I'm fine with whatever color of the shed though :)
>
> > 2. IMO you need the PWM frequency specified, since it can actually
> > matter.  NOTE: once you have the PWM frequency specified, you could
> > imagine automatically figuring out what "num-steps" was.  Really you'd
> > want it to be the largest possible value you could achieve with your
> > hardware at the specified frequency.  There's no advantage (is there?)
> > of providing fewer steps to the backlight client.
> >
>
> I guess there's no problem in having a "num-steps" that is unrelated to
> the number of brightness steps of the panel - but I did distinguish them
> because the datasheet clearly does so.

I think the datasheet talks about the number of steps that you will be
able to make, but that doesn't mean it has to be what's exposed to
clients of this driver, right?


> > 3. Some backlights are specified inverted.  It looks like this maps
> > nicely to the bridge chip, which has a bit for it.  Probably nice to
> > expose this?
> >
>
> Yes, that should be covered.
>
> > Of course, if we were just exposing the PWM directly to Linux we could
> > just use the PWM backlight driver and it'd all magically work.  ;-)
> >
>
> Please help me figure out how to properly expose this in the PWM api and
> I'll be happy to respin it using this - as you say my wheel does look
> pretty similar...

Hopefully the above seems sane to you?

-Doug
