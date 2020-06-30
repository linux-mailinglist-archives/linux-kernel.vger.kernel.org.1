Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1049620F992
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389116AbgF3Qfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgF3Qfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:35:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:35:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so20837862wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UY5dDFhwanGzAjA/Hwk2nkrFK53nDw/tdJsDrb47uYk=;
        b=vrFYsy4PUl1thVhIBI/n6B96HCHkilWvostX6tmewC49h0ySiM903UwYD1fxS29iu4
         yOiq4Y1F1VPbwPzqlrm6Y+NfDMSiRbhA4SkEp+BZa0TPe9+QxNfVog0TbB/EPwrtMmqA
         dkdkDd9lcFAdHIGd3N1iZ/r8mVRIbmnEVsXeXR2t5mBHnz0wOPu4Qqq8oiTEzx90ZPbE
         P1euW+KHLG0Ghx2/f6vqQKD826gOZ7tSSs8m43sJHNB/3mVoQolt1i3kdO6KWDPBxpge
         J+AwQRo8tLxwQhDhizaWP0hyxjlZHmfiWkyP7ld2AOQIBdzdJg8M/vkkBZdEQ69MTzwV
         PJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UY5dDFhwanGzAjA/Hwk2nkrFK53nDw/tdJsDrb47uYk=;
        b=GZUdqAP1atPoW4N6RsmHnyDG/KmtLg+OLYf+UyrhGinG6vn1UeRKB9wUNwkDVMBYe1
         HyAvMSuf34mqoqoLXm+LaG9Ml8dck34JZhRpaX6gVzyR2AwRDrFBy3cWgUDDL5+pVqh+
         MBCw3lt4zxp4ps48A/nRA7NQP+b8n/yDqrWIYKbx0qpT6Pm2xjMol20Idc4JmKsOXJ7n
         AuU38vpJdskXU76AoRduur8RAosFrQunt7IUONhOgyueez+bHvDl8vE4kt33cI9q0NXM
         +hwHUi8cYsKwPsQHb7WTbnDa01Sp5WHePqjwJZDHRpWdWvN/lWZJ17Zi0yICvRY646No
         yQ/w==
X-Gm-Message-State: AOAM532y2tjz0naLCT0LK6E0BAPE0wjvSxVmej6WQeuowWSaX7QZ07gR
        Ec0gtNBPjKuwx0YYVFpYDN6pyQ==
X-Google-Smtp-Source: ABdhPJwHpMmHLbOR2PK+c8AILDnO4gKbH2fhAO3npF+VHuPJVOUOu/Moc+PFY2jA82EhThxZdEOdtw==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr22454514wrn.52.1593534943359;
        Tue, 30 Jun 2020 09:35:43 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k126sm4324376wme.17.2020.06.30.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:35:42 -0700 (PDT)
Date:   Tue, 30 Jun 2020 17:35:41 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight
 bindings to DT schema
Message-ID: <20200630163541.cvllavnbmgdlvpfy@holly.lan>
References: <20200618224413.1115849-1-robh@kernel.org>
 <20200619215341.GA6857@ravnborg.org>
 <20200622165730.pnx7fzbq5e6q5h4l@holly.lan>
 <CAL_JsqK1yJ09k6tKak==TjRN17VzueVkcf-WOLw2ETL2ZJv9sg@mail.gmail.com>
 <20200629191847.GA318506@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629191847.GA318506@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:18:47PM +0200, Sam Ravnborg wrote:
> On Mon, Jun 29, 2020 at 11:57:37AM -0600, Rob Herring wrote:
> > On Mon, Jun 22, 2020 at 10:57 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Jun 19, 2020 at 11:53:41PM +0200, Sam Ravnborg wrote:
> > > > > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..7e1f109a38a4
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > > > > @@ -0,0 +1,98 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/leds/backlight/pwm-backlight.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: pwm-backlight bindings
> > > > > +
> > > > > +maintainers:
> > > > > +  - Lee Jones <lee.jones@linaro.org>
> > > > > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > > > > +  - Jingoo Han <jingoohan1@gmail.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: pwm-backlight
> > > > > +
> > > > > +  pwms:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  pwm-names: true
> > > > > +
> > > > > +  power-supply:
> > > > > +    description: regulator for supply voltage
> > > > > +
> > > > > +  enable-gpios:
> > > > > +    description: Contains a single GPIO specifier for the GPIO which enables
> > > > > +      and disables the backlight
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  post-pwm-on-delay-ms:
> > > > > +    description: Delay in ms between setting an initial (non-zero) PWM and
> > > > > +      enabling the backlight using GPIO.
> > > > > +
> > > > > +  pwm-off-delay-ms:
> > > > > +    description: Delay in ms between disabling the backlight using GPIO
> > > > > +      and setting PWM value to 0.
> > > > > +
> > > > > +  brightness-levels:
> > > > > +    description: Array of distinct brightness levels. Typically these are
> > > > > +      in the range from 0 to 255, but any range starting at 0 will do. The
> > > > > +      actual brightness level (PWM duty cycle) will be interpolated from
> > > > > +      these values. 0 means a 0% duty cycle (darkest/off), while the last
> > > > > +      value in the array represents a 100% duty cycle (brightest).
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +
> > > > > +  default-brightness-level:
> > > > > +    description: The default brightness level (index into the array defined
> > > > > +      by the "brightness-levels" property).
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > Same comment as before...
> > >
> > > Sorry the "ditto" meant I didn't thing about PWM as much as I should
> > > have.
> > >
> > > The situation for PWM is a little different to LED. That's mostly
> > > because we decided not to clutter the LED code with
> > > "num-interpolated-steps".
> > >
> > > The PWM code implements the default-brightness-level as an index into
> > > the brightness array *after* it has been expanded using interpolation.
> > > In other words today Linux treats the default-brightness-level more
> > > like[1].
> > >
> > >     description: The default brightness level. When
> > >       num-interpolated-steps is not set this is simply an index into
> > >       the array defined by the "brightness-levels" property. If
> > >       num-interpolated-steps is set the brightness array will be
> > >       expanded by interpolation before we index to get a default
> > >       level.
> > >
> > > This is the best I have come up with so far... but I concede it still
> > > lacks elegance.
> > 
> > Happy to add this or whatever folks want if there's agreement, but I
> > don't want to get bogged down on re-reviewing and re-writing the
> > binding on what is just a conversion. There's a mountain of bindings
> > to convert.
> The original explanation is ok, as pointed out by Daniel.
> So I suggest moving forward with that and then others can improve the
> descriptions later as necessary.

That's fine for me to. It would be clearer in version history (improving
definitions during a conversion hides them when mining the changelog).


Daniel.
