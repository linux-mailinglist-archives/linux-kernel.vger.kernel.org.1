Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C32D6B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394220AbgLJWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 17:32:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39110 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405127AbgLJW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:26:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id c7so7271007edv.6;
        Thu, 10 Dec 2020 14:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DgwiQiINReqpRzkxPBOoj0Pj1hdtR6pe6rpIHW4GOsE=;
        b=qOwo7R/dQdVStRi7CFUSia34sWh7p0MWiuMguSYwAhblnhHef7ZgSjUTKtVyKBpB+l
         GljpOmZ6tHJ+D9aRf6Bj27D0ZvQMoGOq9c3Ql6tqKSxTuROrKkSed3VXhK9uPW+Ip1aw
         k5J/KF+M294bLkbF+U5IqI7QzBxEyejLdNgUh/7NZLE2fdVhpZKBohFtOd2NLrEjXI0U
         ByvJVTfr8JePELwrxSTrs6jJLprVhgN965dAkddEyOZqsG6fctN/8WV21KuqFjelEWbi
         qGCnLF4WvHjS+rRllixagOqj7voxenAcGIT68WVbtULZPdCCpqTPWLvlLjaguhmIMCHS
         JWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DgwiQiINReqpRzkxPBOoj0Pj1hdtR6pe6rpIHW4GOsE=;
        b=WI+mMCyCXCm1W1L5n2CYQofkzWwkOEQNUu59skFJy4QmiI7J93U9K7HvtLwHBHxZye
         Bjpi+3LdquksuNQlKJG7BIZ9XqY3AgCQvC8YizxRulyEVxCwmXQISXHtVk2C6VU9qhTH
         d+8YsZetvpRk96rqUUv4KPppRj2mHhYq90nNFTn52pgjG1xxpS7LvB83bb0oM3aFg578
         GRps+eLwDUI4mRqqhwKLmvXGdCDuf86e2bujE6NTPBh78pTx7WuHcFVleOd+TOMADroV
         F9s+yoRIJVYonyRYyEyGm4nzWqqNUTChCtyhPNzKMkupqK0fNaQzuFmtC0fEwllsJ7yJ
         ix0A==
X-Gm-Message-State: AOAM5306Zz7z0govK/WHfmcGjUMLM8Vt0lk3ujlM20AIbLoKbb+yjPqf
        71n3n2d7U1EoiE+TH8yabiepaQ/vXYJn2x5ox6Y=
X-Google-Smtp-Source: ABdhPJx0t8DQWf69ovL+FHwaCkKpf2+w+k1PIInOVaCXFi1pD+jNx4ETD4gVr0kpBfukXXZUNRKO5s09tkEy6V5Fppc=
X-Received: by 2002:a05:6402:1714:: with SMTP id y20mr8783980edu.360.1607639068296;
 Thu, 10 Dec 2020 14:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20201206002629.12872-1-adrien.grassein@gmail.com> <20201207135551.GE5694@sirena.org.uk>
In-Reply-To: <20201207135551.GE5694@sirena.org.uk>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 10 Dec 2020 23:24:17 +0100
Message-ID: <CABkfQAF4AANtxptY+XB2cR6hpz2i2Km+F5U=R67J57zSfnoGMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add pf8x00 regulator
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        troy.kisky@boundarydevices.com,
        Gary Bisson <gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reviewing my patches.

Le lun. 7 d=C3=A9c. 2020 =C3=A0 14:55, Mark Brown <broonie@kernel.org> a =
=C3=A9crit :
>
> On Sun, Dec 06, 2020 at 01:26:28AM +0100, Adrien Grassein wrote:
> > Add dt-bindings for the pf8x00 driver.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
>

For v2 I just copy-paste another commit message to be sure to be conform.

> > +  compatible:
> > +    enum:
> > +      - nxp,pf8x00
>
> Compatible strings should be for specific devices not wildcards.
>
> > +          nxp,hw-en:
> > +            $ref: /schemas/types.yaml#definitions/flag
> > +            description: |
> > +              Only available for ldo2. Used to enable or disable ld02.
>
> I don't understand what this is documenting - what is "hw-en" and how is
> it used to enable or disable LDO2?
I think I read better documentation for this point. Sorry, it was very uncl=
ear.
>
> > +          nxp,vselect-en:
> > +            $ref: /schemas/types.yaml#definitions/flag
> > +            description: |
> > +              Only available for ldo2. When specified, use the VSELECT=
 pin
> > +              of the chip to control the output voltage of the ldo02 r=
egulator.
>
> Shouldn't there be a GPIO specified somewhere or something so that the
> VSELECT pin can be controlled?

I think I read better documentation for this point. Sorry, it was very uncl=
ear.
VSELECT is in fact an input pin of the chip. The configuration just enabled=
 it.
>
> > +          nxp,ilim-ma:
> > +            $ref: /schemas/types.yaml#definitions/uint32
> > +            minimum: 2100
> > +            maximum: 4500
> > +            default: 2100
> > +            enum: [ 2100, 2600, 3000, 4500 ]
> > +            description: |
> > +              Defines the maximum current delivered by the regulator (=
in mA).
>
> Is this not a fixed property of the regulator?
It's not. It's configurable by software.
>
> > +          nxp,quad-phase:
> > +            $ref: /schemas/types.yaml#definitions/flag
> > +            description: |
> > +              This allow regulators  sw1 and sw2, or sw3 and sw4 or sw=
4 and sw5
> > +              to work together to deliver a maximum 10A current.
>
> Presumably this must be set on both the regulators being grouped
> together?
Not. Only the sw1 configuration will be taken in account.

Thanks again,
Adrien
