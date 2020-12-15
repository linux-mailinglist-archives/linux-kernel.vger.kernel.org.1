Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F602DB5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgLOVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgLOVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:10:50 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29739C06179C;
        Tue, 15 Dec 2020 13:10:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so29684380ejb.12;
        Tue, 15 Dec 2020 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pH0pNV8GuApEAomsf4+0GR1tuhfmS3JbNx8+GNRBn+4=;
        b=ClogU90tZpak3lLuYzPamIpF+50NGe9OhuauW6YZ8MCjq/58QqyDQ0jRZtOHlaMbhS
         mm65ErXJrG1q/qL2JKocQZqrE7jPHDheTFfNYvKgXJa6N2ykZ0YJIy4TWoN/k9DueN6X
         3hxyZFE4yRkF7ceIZd/BwTaOilyqRqU1WIwykoA2Z9U5/aies9HSIUBt4D+v8p5eEVTO
         crxvu7zlA6Ywu5TFioDVQYE5XLpdwS/N/nNaH2CE9L/WMPnW74hAObndmccB6dD63iaQ
         5Etnem9pBGN0sZGoa/mNic7v+w7VOiwk/ZfunKsXYsqPIxoThq8aBCif+12xcIm4bO60
         9+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pH0pNV8GuApEAomsf4+0GR1tuhfmS3JbNx8+GNRBn+4=;
        b=eZG6jDbeOh0QtfwQMfzP0k2iCpOtN4uPidFbD0YeDC0nWLJhlPV6HGjv/C1lt/HwAd
         sFuQUhy4/QXktWjdjDl8I67lFsPPjc4akiVdc+JD0+doP/W6y63EkmvP+g8fIpsoFlIB
         wgFpf+YHPhZf88jAKwfkdW+3vn7kBjaVbcXTWX9inqTzNohEMmfQaiDL/3Y9DaensA4i
         7I8h5dVY0iykAivclTF04xD+2FzWXJ/Pv3jEr9h0OO7TnJ14Sw25BNGzLgG2lqbOSkTd
         pvCkBnCaJvsUpYwl7Zj+qAzRv6SgIVu2Kxt8++TYgpSNTrnBG2sqrpVWNS8qhd6HNji4
         OaEg==
X-Gm-Message-State: AOAM531Rv8iwN+Pra16OwHkstTy1j3IRA8IxzFJtGxj3S7AFnxEG8lMx
        1q7vMjbdWNzFF2wE0jCItkRWQz0wBxrPfXkonhY=
X-Google-Smtp-Source: ABdhPJyVN0bPfFXqXGLxCllZvJFtctFVqi2n6o4bY33Job+8guTHKYOSB77Gt4z/8lAEmQIWB37LLvGyShBgdCCZae4=
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr20303475eju.500.1608066608874;
 Tue, 15 Dec 2020 13:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20201215204858.8186-1-adrien.grassein@gmail.com>
 <20201215204858.8186-4-adrien.grassein@gmail.com> <CAMty3ZD2WsFeuCnt4DEL87Ou-sxHPYiBVu1n-LoK2gEzgO3XwQ@mail.gmail.com>
In-Reply-To: <CAMty3ZD2WsFeuCnt4DEL87Ou-sxHPYiBVu1n-LoK2gEzgO3XwQ@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 15 Dec 2020 22:09:58 +0100
Message-ID: <CABkfQAHBSxUzG6+xMk=k+OR09zVDDex1NgSQK4P-sENv2tbaqw@mail.gmail.com>
Subject: Re: [PATCH 3/6] regulator: dt-bindings: pf8x00: fix nxp,phase-shift doc
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I agree with you, but in the DTS file you put the angle, not the
converted value. So 0 is the minimum, 315 the max even if it's not
reflected in the configuration register.

Thanks,

Le mar. 15 d=C3=A9c. 2020 =C3=A0 22:07, Jagan Teki <jagan@amarulasolutions.=
com> a =C3=A9crit :
>
> On Wed, Dec 16, 2020 at 2:19 AM Adrien Grassein
> <adrien.grassein@gmail.com> wrote:
> >
> > nxp,phase-shift is an enum so use enum format to describe it.
> > Minimum and maximum values are also wrong.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../bindings/regulator/nxp,pf8x00-regulator.yaml | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regula=
tor.yaml
> > index 913532d0532e..1da724c6e2ba 100644
> > --- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.=
yaml
> > +++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.=
yaml
> > @@ -60,21 +60,13 @@ properties:
> >
> >            nxp,phase-shift:
> >              $ref: "/schemas/types.yaml#/definitions/uint32"
> > -            minimum: 45
> > -            maximum: 0
> > +            minimum: 0
> > +            maximum: 315
> > +            default: 0
> > +            enum: [ 0, 45, 90, 135, 180, 225, 270, 315 ]
>
> Do you mean 0 is the minimum or starting value? I can see Table 48.
> SWx phase configuration with minimum and maximum values are starting
> from 45, 90, 135, 180, 225, 270, 315, 0 with phase bits as 0x0 to 0x7
>
> Jagan.
