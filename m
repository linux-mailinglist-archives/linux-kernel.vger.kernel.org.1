Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD32FF0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbhAUQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388045AbhAUQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:45:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9344323A3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611247475;
        bh=cFwM1hMC9s6vW0JOCWTfliy8Sh0HF2SG0JWUyasXm3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YfPYOzSwUl5lcM/zR/Wyh/9vN/DDBBFU4Lf739/RHaSycNziUu6xaTLCBJk5ds6OJ
         7TdbAhVgOftqmlluTsbWNnbFOzRZkd2Xq9nQSJ0FZcnkIICgaYXL1y2eW61rt/EU2r
         pWMZRhH01bI8LXhBG1JetWxrYcBerNFnmICo/Gz+OZVwX8MORkLqHQGuKwzUamyfqb
         kyXbXa0L+fsJw9b3X4Z3tHh8uZuLk9OfZ/vL7Ksu9i8lLFy4HEDeQG40gW+ekdsLF4
         slu4h1KdFbWghCyWYA5NYV697BhwdJ0OALF7xoap8A60xAikvIZwPzx+kkPznWCBv3
         7FnbNI5rlxW+g==
Received: by mail-ed1-f51.google.com with SMTP id c2so3005909edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:44:35 -0800 (PST)
X-Gm-Message-State: AOAM531fi0ZI/3IGo1cmoOhzbAidjqn0yhEx1oB75uIrKalTtJDphuBZ
        i/b25LB5scfGPxwwcA21DpCIZhoelktZeSrZjw==
X-Google-Smtp-Source: ABdhPJwL+0+UT/WOE/L9hf2j8W7FSj5kvlXZasbzYva4ChYrRroJjKbjZhgf60QGhN4Wuss1Reus0UgEas1m/EYMdl4=
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr33028edd.62.1611247474188;
 Thu, 21 Jan 2021 08:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com> <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
In-Reply-To: <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 10:44:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+znLsyQOw59xqYgoYo9eJrn1R1Tj--aRvPHOD_jv0fxA@mail.gmail.com>
Message-ID: <CAL_Jsq+znLsyQOw59xqYgoYo9eJrn1R1Tj--aRvPHOD_jv0fxA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 3:49 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Mohamed,
>
> thanks for your patch!
>
> On Wed, Jan 20, 2021 at 2:31 PM Mohamed Mediouni
> <mohamed.mediouni@caramail.com> wrote:
>
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: apple,aic

As mentioned in patch 7, this needs to be SoC specific.

Also, bindings should be separate patch. checkpatch.pl will tell you this.

> However weird it may seem, Apple is not in the file
> Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> (I think it's weird because I remember clearly that they have been
> using device tree for PPC since ages.)

That's because the vendor prefix is 'AAPL' which is the stock ticker
and it predates documenting anything.

> Could you add this 2-liner to that file and send it directly to
> DT binding maintainers as a single patch as a preparation?

So this is still needed. Happy to take that given already in use.

Rob
