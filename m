Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E402C64D4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgK0MIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgK0MIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:08:50 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06506221F1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606478929;
        bh=9fXLMqgIEFSwvI/jgQLvYaGAn0jqLe3WdPecwXErpQw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Prenpijat5yZJ695ExkyoVG6QFbh9RwEQqYxo8ZuazTY7nit4xrFNWoJi5FKUwV4O
         uGbUVIELTLd2Ex4vzUWwVYmxj9/OLhRcD54o+T+GTFjj+qg3SolS9L8hsqSYgHbnFa
         Snjp2Q9pMjBS1Ej9HYCJcbMxl5wour3x4Ep8u7lc=
Received: by mail-oi1-f178.google.com with SMTP id o25so5640836oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:08:48 -0800 (PST)
X-Gm-Message-State: AOAM53041wnwcx/7It+khNFIv7zua8sd7B8x4spUjPawAaJ0LmTiFdKK
        HNu3lnDW9mPNF/uRiFIRfuk1IdxVx7agVTbmSnc=
X-Google-Smtp-Source: ABdhPJx8yOO8416RWRciBoqI8igktqeeWSk6Dt10xfJA7hUwMQdNnnKNjlIQOYkvWlkbaiRcs/eQTLl0uzIX0/A17kE=
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr4778672oib.33.1606478928265;
 Fri, 27 Nov 2020 04:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <d6cfb1487c1077a7b413276c838dc7aa@kernel.org>
In-Reply-To: <d6cfb1487c1077a7b413276c838dc7aa@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Nov 2020 13:08:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFeYB+UdWkn30dwzb61LUXVztWU4kKG+ncYLy0+S4AEeQ@mail.gmail.com>
Message-ID: <CAMj1kXFeYB+UdWkn30dwzb61LUXVztWU4kKG+ncYLy0+S4AEeQ@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     Marc Zyngier <maz@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 16:27, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-11-05 15:29, Ard Biesheuvel wrote:
> > When reseeding the CRNG periodically, arch_get_random_seed_long() is
> > called to obtain entropy from an architecture specific source if one
> > is implemented. In most cases, these are special instructions, but in
> > some cases, such as on ARM, we may want to back this using firmware
> > calls, which are considerably more expensive.
> >
> > Another call to arch_get_random_seed_long() exists in the CRNG driver,
> > in add_interrupt_randomness(), which collects entropy by capturing
> > inter-interrupt timing and relying on interrupt jitter to provide
> > random bits. This is done by keeping a per-CPU state, and mixing in
> > the IRQ number, the cycle counter and the return address every time an
> > interrupt is taken, and mixing this per-CPU state into the entropy pool
> > every 64 invocations, or at least once per second. The entropy that is
> > gathered this way is credited as 1 bit of entropy. Every time this
> > happens, arch_get_random_seed_long() is invoked, and the result is
> > mixed in as well, and also credited with 1 bit of entropy.
> >
> > This means that arch_get_random_seed_long() is called at least once
> > per second on every CPU, which seems excessive, and doesn't really
> > scale, especially in a virtualization scenario where CPUs may be
> > oversubscribed: in cases where arch_get_random_seed_long() is backed
> > by an instruction that actually goes back to a shared hardware entropy
> > source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> > times per second.
> >
> > So let's drop the call to arch_get_random_seed_long() from
> > add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> > the arch hook to get random seed material from the platform.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Looks sensible. Having this on the interrupt path looks quite
> heavy handed, and my understanding of the above is that it has
> an adverse effect on the entropy pool.
>
> Acked-by: Marc Zyngier <maz@kernel.org>
>

Thanks Marc.

Ted, any thoughts?
