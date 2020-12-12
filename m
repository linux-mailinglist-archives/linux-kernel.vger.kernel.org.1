Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80502D8A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 23:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408114AbgLLWom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 17:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLWom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 17:44:42 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD1C0613CF;
        Sat, 12 Dec 2020 14:44:01 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id c7so13248915edv.6;
        Sat, 12 Dec 2020 14:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yorWS1Y8OcDME3EOhngMSE0EO65pPSVP9MraA5daZhY=;
        b=UHoNBstjp2q+SnfJxTCOzBgNooxiOkGq8uPN6NP2LNhs6sf78dBSdoq4gXKvTDDYBP
         uPAHZrFiRtU0JoEWO99MKnWcV+J990n487iCug4w3ZwRmmLWrIVvBnEm1ZKS8uo5hF54
         z8nSj3YwqHKXTefTIkUs3xYJh+VGm6AfiO5OTxyDLackzxSoltGJrMSh4jzvD77QimCi
         N1DveBwdl5NozwpYigazWCiAYZZiB0d5m2L5FIqqTuZcNzpcfMToVEUmR+o74VgeH39b
         w5OvaUSYsdA2V9F+9PLqI9L0bLG3OhM37U01k1bVnIyVvxd8/G0OH3XXBg6OfGkx8wZ/
         uZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yorWS1Y8OcDME3EOhngMSE0EO65pPSVP9MraA5daZhY=;
        b=Q7fQ3phBkZyL03exTZ47EpkJ04r+ZzUOm6Oesl0rC+1A7COUdgQRodQ0x7rM3U709+
         zmtnEW2Jxm1Syrw23RS6pb/czaY0HwZ2xPwMK96L71rbJjUAdTaBiXav1IXEmAgWS/u5
         YCPtWSe2okb4/Cv/1Bdbi7bUGvKWfeUHoUgLhHNB/bSh8tIqNz5U2lxnxqfm5mORDcuL
         F6wJiuXxx+MpCNK7wYLFwyro9KW7P4JAgCp6+zGsvC2ePi+aims9HrylRPlLpP1jQuFt
         MEa7v2kqOG5LmLTAIE7vW2A190U+1GJynyyLnON5z+eWJjNp2cCui4l+stqgBxXewNrP
         KKEQ==
X-Gm-Message-State: AOAM5337fYL1MZGnDMfssQvYJURIj3mS7URsZxWsL63JM5vFZk0iV1U9
        SPT/dVnm2sOFL8q5MGULf3xRgLuWWOy/5UmYuls=
X-Google-Smtp-Source: ABdhPJxDh8WOfncQIJ3MgT/K9xTvaIDmZdI9csJjQlO/qGNvpOifci9xXtmC9ejMpRzpYlmGAuI9enVhweGOfGUhSnI=
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr17714330edb.107.1607813040330;
 Sat, 12 Dec 2020 14:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
 <20201210221629.17312-1-adrien.grassein@gmail.com> <20201211140412.GD4929@sirena.org.uk>
In-Reply-To: <20201211140412.GD4929@sirena.org.uk>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Sat, 12 Dec 2020 23:43:49 +0100
Message-ID: <CABkfQAGR=sPwhwL0ifqXpqCWKHZ_8pPj6Da_ugOQzFbvYbKdDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add pf8x00 PMIC
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

Hello,

Le ven. 11 d=C3=A9c. 2020 =C3=A0 15:04, Mark Brown <broonie@kernel.org> a =
=C3=A9crit :
>
> On Thu, Dec 10, 2020 at 11:16:28PM +0100, Adrien Grassein wrote:
> > Add a devicetree binding documentation for the pf8x00 regulator driver.
>
> Please don't send new patches in reply to old threads, it makes it hard
> to keep track of what is going on.

Sorry. Should I create a new mail each time I send a new version of the pat=
ch?

>
> > +          regulator-name:
> > +            pattern: "^ldo[1-4]$"
> > +            description:
> > +              should be ldo1", ..., "ldo4"
>
> This is part of the generic regulator binding and since it's for board
> specific usage it should not be constrained by the chip binding.

Ok.
>
> > +          nxp,vselect-en:
> > +            $ref: /schemas/types.yaml#definitions/flag
> > +            description:
> > +              Only available for ldo2. When specified, use the VSELECT
> > +              input pin of the chip to control the output voltage of t=
he
> > +              ldo02 regulator. (3.3V if VSELECT is LOW, 1.8V if HIGH).
>
> How is VSELECT used without a binding specifying some mechanism for
> control?

I think that VSELECT input should be controlled by the sub system that
uses it (via maybe a GPIO).
On my board, it's directly controlled by another chip (so without a GPIO).

>
> > +          nxp,ilim-microamp:
> > +            $ref: /schemas/types.yaml#definitions/uint32
> > +            minimum: 2100
> > +            maximum: 4500
> > +            default: 2100
> > +            enum: [ 2100, 2600, 3000, 4500 ]
> > +            description:
> > +              Defines the maximum current delivered by the regulator i=
n microamp.
>
> Instead of implementing a custom property this should use the already
> existing properties for current limits, this is a common thing for
> hardware to have so we shouldn't have custom bindings.  We'll need to
> relax the check the code currently has for a non-zero minimum limit but
> otherwise everything should already be there.

Ok I now use "regulator-max-microamp" property from the regulator that
acts like my property.
I was wrong with the default value. I re-read the documentation and
the default value is stored in OTP
memory. So if someone skipped this property, it's OK to not send any value.


Thanks again,
Regards,
