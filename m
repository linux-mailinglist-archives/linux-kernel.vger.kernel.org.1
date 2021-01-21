Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3302FE7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbhAUKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbhAUKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A602388E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611225439;
        bh=ci+gBdKi/HOnJaSdn0sRtPgN5znIPCb11FcQpwgiqnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SMFjvTlqUFcxmU+0QM5GuyAcu3EbJltc5C36wOCgFZFcaaUrwF/nZzrlBKwn8OEme
         QhPsilUdLGyb7OP2T/NXiLHETot8cy5zSggrIpEBUUZOgeBYqTMlJ/FoWJLjbfuo5I
         0KBFSbXnI0Z/08yPbsLfCYopp7qLgSeS+OuwRAwXFOgeyjssJz8pdu/fa7zADe5Zhl
         r1xyWVmA+OXo/P+oiEMyLkWBBIiCZ7U918ofnpASa2D1lboougvfUPpzeyZW0Ht2jO
         rUyogcJ4zG+hj52D5zR9cq1kWYkkCrDlzFLO0ZWh2wzrRB1a/7jLkjPFKosfPwUtBe
         H4FMgvPzYNyKw==
Received: by mail-oi1-f175.google.com with SMTP id 9so1653613oiq.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:37:19 -0800 (PST)
X-Gm-Message-State: AOAM530h7eC1jLufwfNmH3DyCxKmzQSXPXnmc9Isxv/JTB4bPuC7DhRO
        yfJmSv5T+hLBfTgVvdT4CQjyaEpnZBwO6WVyHCw=
X-Google-Smtp-Source: ABdhPJxD096f6VWzSCPQn9FQQeK430o3v0vGLayqn9O0A/FSik1QfxdtgTjl0jSUwRw5UKQzloBLAq/ZQAEGhQdtB9Y=
X-Received: by 2002:aca:be54:: with SMTP id o81mr5434123oif.67.1611225438679;
 Thu, 21 Jan 2021 02:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com> <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
In-Reply-To: <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 11:37:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
Message-ID: <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 10:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
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
>
> However weird it may seem, Apple is not in the file
> Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> (I think it's weird because I remember clearly that they have been
> using device tree for PPC since ages.)
>
> Could you add this 2-liner to that file and send it directly to
> DT binding maintainers as a single patch as a preparation?

Choosing the vendor prefix here is going to be a little tricky
and non-obvious.

Background:

Traditionally, it should have been the stock ticker symbol of the
company (clearly only publicly traded companies would be able
to produce a Unix capable computer, right?), but there were
already inconsistent: IBM used "ibm" (in small letters), Sun
used "SUNW" (in capitals) but in 2007 changed the stock ticker
symbol to "JAVA", obviously without changing the firmware bindings.

Apple traditionally used "AAPL" (also in caps) in the device tree,
and there is one remnant of that in the M1 device tree, in the form
of the "AAPL,phandle" property in each node, which corresponds
to our "linux,phandle". (phandles were introduced as properties in
both of the flattened DT formats, .dtb and apple's own format).
There are also "AAPL,unit-string properties and some device_type
strings (AAPL,display-crossbar, AAPL,atc-dpxbar, ...) in the M1 DT,
and the CPU nodes (and only those) use "apple" in small letters
as in "apple,icestorm","ARM,v8". The other nodes tend to not have
a vendor prefix, but a lot use a subsystem name as the prefix, such
as compatible="gpio,t8101" or compatible="tempsensor,t8020".

Since Apple are already using both the "AAPL" and the "apple"
prefix themselves, I have a bad feeling about reusing either of
them for defining the devicetree.org bindings that we add to
linux/Documentation/devicetree/bindings. The question is: if
not "apple", what else should we use here?

      Arnd
