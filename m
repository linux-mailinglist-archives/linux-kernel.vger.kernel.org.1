Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF42FF25C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389246AbhAURsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389053AbhAURqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:46:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D3CB22A85
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611251166;
        bh=8Vgfa2YyRq9M4HMsdg2N5RVEwQqUfKMIoedhRicA3i8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkWwKqyDQSQzUF6c3Ef+beGqDZgdJ+B0m3wmkPCJ4O3ZYxcMtFZj3Iag4w3ZAH+48
         +ROPQCn1WTVgOXiIxKphyFKnFnQnFLr0GakCHkSxPb7WtdA9laaYWfnB0v+huoVDLe
         H94YYxtTu5voA/u+stvcD0aeJoKeEuEMycFpPhUr4I32wg1G6NXW9F28Kpk3QQP9I7
         CmXDVQ8BF3BpZKg6G3YynU5QNWyRKDdNAyq0N98XKUVi0I9oFnMBWPdHQrwibqOcrO
         XwUbGTWE13Mh3SbVYfjdSFnSVS3vX4j6EWl4SjkibF9Wy58a4F953+ucZRDEer6AAY
         MkcZEPrL9zUzg==
Received: by mail-ej1-f44.google.com with SMTP id r12so3815544ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:46:06 -0800 (PST)
X-Gm-Message-State: AOAM533acx3+C62aj4Icqo3EYVnpL4BI1XLo+hq/qs70o1lDlOU2Ts8h
        yxCG6gyzm4G7p9Erk0zBjEfnHyhNA4wI2YMMJw==
X-Google-Smtp-Source: ABdhPJxZ6w3DGy8e6iuFR3womYGkTwr2xd6oYATYjCw5hfVyz7Ge7r8p5AKFVrANgIpFc03gZIpusPNihpwj6i4MQOY=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr395803ejb.359.1611251164737;
 Thu, 21 Jan 2021 09:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com> <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
 <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
In-Reply-To: <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 11:45:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJL8kgUwP0SA5TZDoBqqTh=eYRgG1=bymS9t=rEHr-HWw@mail.gmail.com>
Message-ID: <CAL_JsqJL8kgUwP0SA5TZDoBqqTh=eYRgG1=bymS9t=rEHr-HWw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 4:38 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 10:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Hi Mohamed,
> >
> > thanks for your patch!
> >
> > On Wed, Jan 20, 2021 at 2:31 PM Mohamed Mediouni
> > <mohamed.mediouni@caramail.com> wrote:
> >
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: apple,aic
> >
> > However weird it may seem, Apple is not in the file
> > Documentation/devicetree/bindings/vendor-prefixes.yaml
> >
> > (I think it's weird because I remember clearly that they have been
> > using device tree for PPC since ages.)
> >
> > Could you add this 2-liner to that file and send it directly to
> > DT binding maintainers as a single patch as a preparation?
>
> Choosing the vendor prefix here is going to be a little tricky
> and non-obvious.
>
> Background:
>
> Traditionally, it should have been the stock ticker symbol of the
> company (clearly only publicly traded companies would be able
> to produce a Unix capable computer, right?), but there were
> already inconsistent: IBM used "ibm" (in small letters), Sun
> used "SUNW" (in capitals) but in 2007 changed the stock ticker
> symbol to "JAVA", obviously without changing the firmware bindings.
>
> Apple traditionally used "AAPL" (also in caps) in the device tree,
> and there is one remnant of that in the M1 device tree, in the form
> of the "AAPL,phandle" property in each node, which corresponds
> to our "linux,phandle". (phandles were introduced as properties in
> both of the flattened DT formats, .dtb and apple's own format).
> There are also "AAPL,unit-string properties and some device_type
> strings (AAPL,display-crossbar, AAPL,atc-dpxbar, ...) in the M1 DT,
> and the CPU nodes (and only those) use "apple" in small letters
> as in "apple,icestorm","ARM,v8". The other nodes tend to not have
> a vendor prefix, but a lot use a subsystem name as the prefix, such
> as compatible="gpio,t8101" or compatible="tempsensor,t8020".
>
> Since Apple are already using both the "AAPL" and the "apple"
> prefix themselves, I have a bad feeling about reusing either of
> them for defining the devicetree.org bindings that we add to
> linux/Documentation/devicetree/bindings. The question is: if
> not "apple", what else should we use here?

IMO, 'AAPL' as that is what is already in use in the kernel. I don't
see why it matters at all what Apple is using. It might if we used any
of the ADT as-is, but I don't see that happening from what I've seen.

Rob
