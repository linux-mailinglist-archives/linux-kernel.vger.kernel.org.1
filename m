Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2AE2A805A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgKEOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbgKEOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:05:11 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A5362151B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604585110;
        bh=esBcP/AJui6XiODiwrRpOoJCZgU1uTPnZxKtrRhiwcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p0Avospvm9Lp2t90GSwX+PDScEW9y9WjpQyOZ/4BKa83ieD2OGsfWV5jRNyiM/aDm
         9nk0uok6m3Xa66LyTG14bQXYC2S0pWeB6ElqYQiozYM7JWBGNa75/RFcx7pq3GF23w
         AL7Xu7QQPpAL/z9XBzQePs8klKyRBXZtzWv5J0Kk=
Received: by mail-oi1-f178.google.com with SMTP id d9so1776191oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:05:10 -0800 (PST)
X-Gm-Message-State: AOAM530qj0oqhTAXvqXJiHil6/X490MvNUUKtXksJqmIdFRTE+RDqHse
        QmS0Xdb5/JEQV3H94LpqZjgsn8ySs4z9sV2LQgw=
X-Google-Smtp-Source: ABdhPJzvhwiuKTQ1g53DmeNxesk2+lZ+jwmMOBSwIT6oWGiGdQqKP2WkQiSoendqj34YoBYf+kut4OMFtsrmDTp2C7Q=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1519564oie.47.1604585109752;
 Thu, 05 Nov 2020 06:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com> <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
In-Reply-To: <20201105140322.GH82102@C02TD0UTHF1T.local>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Nov 2020 15:04:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
Message-ID: <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Nov 2020 at 15:03, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:
> > On Thu, Nov 05, 2020 at 12:56:55PM +0000, Andre Przywara wrote:
> >
> > >  static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> > >  {
> > > +   struct arm_smccc_res res;
> > >     unsigned long val;
> > > -   bool ok = arch_get_random_seed_long(&val);
> > >
> > > -   *v = val;
> > > -   return ok;
> > > +   if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> > > +           if (arch_get_random_seed_long(&val)) {
> > > +                   *v = val;
> > > +                   return true;
> > > +           }
> > > +           return false;
> > > +   }
> >
> > It isn't obvious to me why we don't fall through to trying the SMCCC
> > TRNG here if for some reason the v8.5-RNG didn't give us something.
> > Definitely an obscure possibility but still...
>
> I think it's better to assume that if we have a HW RNG and it's not
> giving us entropy, it's not worthwhile trapping to the host, which might
> encounter the exact same issue.
>
> I'd rather we have one RNG source that we trust works, and use that
> exclusively.
>
> That said, I'm not sure it's great to plumb this under the
> arch_get_random*() interfaces, e.g. given this measn that
> add_interrupt_randomness() will end up trapping to the host all the time
> when it calls arch_get_random_seed_long().
>

As it turns out, add_interrupt_randomness() isn't actually used on ARM.

> Is there an existing interface for "slow" runtime entropy that we can
> plumb this into instead?
>
> Thanks,
> Mark.
